file://<WORKSPACE>/lab1/preflow.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

presentation compiler configuration:
Scala version: 3.3.3
Classpath:
<HOME>/Library/Caches/Coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.3/scala3-library_3-3.3.3.jar [exists ], <HOME>/Library/Caches/Coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.12/scala-library-2.13.12.jar [exists ]
Options:



action parameters:
offset: 2255
uri: file://<WORKSPACE>/lab1/preflow.scala
text:
```scala
import scala.util._
import java.util.Scanner
import java.io._
import akka.actor._
import akka.pattern.ask
import akka.util.Timeout
import scala.concurrent.{Await, ExecutionContext, Future, Promise}
import scala.concurrent.duration._
import scala.language.postfixOps
import scala.io._

case class Flow(f: Int)
case class Debug(debug: Boolean)
case class Control(control: ActorRef)
case class Source(n: Int)
case class PushRequest(senderHeight: Int, flow: Int, edge: Edge)
case class PushResponse(accept: Boolean, edge: Edge) 

case object Print
case object Start
case object Excess
case object Maxflow
case object Sink
case object Hello

class Edge(var u: ActorRef, var v: ActorRef, var c: Int) {
  var f = 0
}

class Node(val index: Int) extends Actor {
  var e = 0; /* excess preflow. 						*/
  var h = 0; /* height. 							*/
  var control: ActorRef = null /* controller to report to when e is zero. 			*/
  var source: Boolean = false /* true if we are the source.					*/
  var sink: Boolean = false /* true if we are the sink.					*/
  var edge: List[Edge] =
    Nil /* adjacency list with edge objects shared with other nodes.	*/
  var debug = true /* to enable printing.						*/
  var isPushing = false
  var currentEdges:List[Edge] = Nil

  def min(a: Int, b: Int): Int = { if (a < b) a else b }

  def id: String = "@" + index;

  def other(a: Edge, u: ActorRef): ActorRef = { if (u == a.u) a.v else a.u }

  def status: Unit = { if (debug) println(id + " e = " + e + ", h = " + h) }

  def enter(func: String): Unit = {
    if (debug) { println(id + " enters " + func); status }
  }
  def exit(func: String): Unit = {
    if (debug) { println(id + " exits " + func); status }
  }

  def tryPush(currentEdge: Edge): Unit = {
    enter("trypush")

    val delta = min(e, currentEdge.c - currentEdge.f)
    other(currentEdge, self) ! PushRequest(h, delta, currentEdge)

    exit("trypush")
  }

  def relabel: Unit = {

    enter("relabel")

    h += 1

    exit("relabel")
  }

  def discharge: Unit = {
    enter("discharge")
    if (e > 0 && !sink && !source && !isPushing) {
      if (currentEdges.isEmpty) {
        relabel
        currentEdges = edge
      }
      var n = currentEdges.head
      currentEdges = currentEdges.tail
      other(@@)
    }
    
    exit("discharge") 
  }

  def receive = {

    case Debug(debug: Boolean) => this.debug = debug

    case Print => status

    case Excess => {
      sender ! Flow(
        e
      ) /* send our current excess preflow to actor that asked for it. */
    }

    case edge: Edge => {
      this.edge =
        edge :: this.edge /* put this edge first in the adjacency-list. */
    }

    case Control(control: ActorRef) => this.control = control

    case Sink => { sink = true }

    case Source(n: Int) => { h = n; source = true }

    case Start => {
      enter("start")

      for (currentEdge <- edge) {

        if (currentEdge.u == self && e > 0) {
          push(currentEdge, height)
        }
        if (e > 0) {
          relabel
        } else {
          control ! Flow(0)
        }
      }

      exit("start")
    }

    case PushRequest(senderHeight, flow, edge) => {
      enter("PushRequest")
      if (h < senderHeight) {
        sender ! PushResponse(true, edge)
        e += flow
      } else {
        sender ! PushResponse(false, edge)
      }
      exit("PushRequest")
    }

    case PushResponse(accept, edge) => {
      isPushing = false
      if(accept) {
        e -= edge.f
        discharge
      } else {
        discharge
      }
    }

    case _ =>
      {
        println("" + index + " received an unknown message" + _)
      }

      assert(false)
  }

}

class Preflow extends Actor {
  var s = 0; /* index of source node.					*/
  var t = 0; /* index of sink node.					*/
  var n = 0; /* number of vertices in the graph.				*/
  var edge: Array[Edge] = null /* edges in the graph.						*/
  var node: Array[ActorRef] = null /* vertices in the graph.					*/
  var ret: ActorRef = null /* Actor to send result to.					*/

  def receive = {

    case node: Array[ActorRef] => {
      this.node = node
      n = node.size
      s = 0
      t = n - 1
      for (u <- node)
        u ! Control(self)
    }

    case edge: Array[Edge] => this.edge = edge

    case Flow(f: Int) => {
      ret ! f /* somebody (hopefully the sink) told us its current excess preflow. */
    }

    case Maxflow => {
      ret = sender
      node(s) ! Source(n)


      

      for(currentEdge <- node(s).edge) { // Preflow från sourcen
        currentEdge.f = currentEdge.c
        
        node(s).e -= currentEdge.f
      }

      for (u <- node) {
        u ! Start
      }

      node(t) ! Excess /* ask sink for its excess preflow (which certainly still is zero). */
    }
  }
}

object main extends App {
	println("main")
  implicit val t = Timeout(4 seconds);

  val begin = System.currentTimeMillis()
  val system = ActorSystem("Main")
  val control = system.actorOf(Props[Preflow], name = "control")

  var n = 0;
  var m = 0;
  var edge: Array[Edge] = null
  var node: Array[ActorRef] = null

  val s = new Scanner(System.in);

  n = s.nextInt
  m = s.nextInt

  /* next ignore c and p from 6railwayplanning */
  s.nextInt
  s.nextInt

  node = new Array[ActorRef](n)

  for (i <- 0 to n - 1)
    node(i) = system.actorOf(Props(new Node(i)), name = "v" + i)

  edge = new Array[Edge](m)

  for (i <- 0 to m - 1) {

    val u = s.nextInt
    val v = s.nextInt
    val c = s.nextInt

    edge(i) = new Edge(node(u), node(v), c)

    node(u) ! edge(i)
    node(v) ! edge(i)
  }

  control ! node
  control ! edge
  println("Hej")
  val flow = control ? Maxflow
  val f = Await.result(flow, t.duration)

  println("f = " + f)

  system.stop(control);
  system.terminate()

  val end = System.currentTimeMillis()

  println("t = " + (end - begin) / 1000.0 + " s")
}

```



#### Error stacktrace:

```
scala.collection.LinearSeqOps.apply(LinearSeq.scala:131)
	scala.collection.LinearSeqOps.apply$(LinearSeq.scala:128)
	scala.collection.immutable.List.apply(List.scala:79)
	dotty.tools.dotc.util.Signatures$.countParams(Signatures.scala:501)
	dotty.tools.dotc.util.Signatures$.applyCallInfo(Signatures.scala:186)
	dotty.tools.dotc.util.Signatures$.computeSignatureHelp(Signatures.scala:94)
	dotty.tools.dotc.util.Signatures$.signatureHelp(Signatures.scala:63)
	scala.meta.internal.pc.MetalsSignatures$.signatures(MetalsSignatures.scala:17)
	scala.meta.internal.pc.SignatureHelpProvider$.signatureHelp(SignatureHelpProvider.scala:51)
	scala.meta.internal.pc.ScalaPresentationCompiler.signatureHelp$$anonfun$1(ScalaPresentationCompiler.scala:435)
```
#### Short summary: 

java.lang.IndexOutOfBoundsException: 0