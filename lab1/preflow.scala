import scala.util._
import java.util.Scanner
import java.io._
import java.math
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
case class PushResponse(accept: Boolean, edge: Edge, flow: Int)

case object Print
case object Start
case object Excess
case object Maxflow
case object Sink
case object Hello
case object ShouldTerminate

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
  var currentEdges: List[Edge] = Nil

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
      var pf = if (n.u == self) e else -e
      other(n, self) ! PushRequest(h, pf, n)
      isPushing = true
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
        var pf = if (currentEdge.c == self) currentEdge.c else -currentEdge.c
        other(currentEdge, self) ! PushRequest(h, pf, currentEdge)
        control ! ShouldTerminate
      }

      exit("start")
    }

    case PushRequest(senderHeight, flow, currentEdge) => {
      enter("PushRequest")
      var delta = 0
      if (senderHeight > h) {
        if (flow > 0) {
          delta = min(flow, currentEdge.c - currentEdge.f)
          currentEdge.f += delta
          e += delta
        } else {
          delta = min(-flow, currentEdge.c + currentEdge.f)
          currentEdge.f -= delta
          e += delta
        }
        sender ! PushResponse(true, currentEdge, delta)
        if ((sink || source)) {
          control ! ShouldTerminate
        }
      } else {
        sender ! PushResponse(false, currentEdge, 0)
      }
      exit("PushRequest")
    }

    case PushResponse(accept, edge, flow) => {
      isPushing = false
      if (accept) {
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
      node(t) ! Sink
      node(s) ! Start
    }

    case ShouldTerminate => {
      implicit val time = Timeout(4 seconds);

      val excessSourceFuture = node(s) ? Excess
      val excessSinkFuture = node(t) ? Excess
      
      val excessSource = Await.result(excessSourceFuture, time.duration).asInstanceOf[Flow].f
      val excessSink = Await.result(excessSinkFuture, time.duration).asInstanceOf[Flow].f

      // Now you have the actual flow values as integers
      if (Math.abs(excessSource) == excessSink) {
        node(t) ! Excess // (Purpose of this still needs clarification)
      }
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
