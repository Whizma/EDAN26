#[macro_use] extern crate text_io;

use std::i32::MIN;
use std::sync::{Mutex,Arc};
use std::collections::LinkedList;
use std::cmp;
use std::thread;
use std::collections::VecDeque;

struct Node {
	i:	usize,			/* index of itself for debugging.	*/
	e:	i32,			/* excess preflow.			*/
	h:	i32,			/* height.				*/
}

struct Edge {
        u:      usize,  
        v:      usize,
        f:      i32,
        c:      i32,
}

struct Graph {
	n: i32, // number of nodes
	m: i32, 
	v: Vec<Arc<Mutex<Node>>>,
	e: Vec<Arc<Mutex<Edge>>>,
	s: usize,
	t: usize,
	excess: VecDeque<usize>
}

impl Node {
	fn new(ii:usize) -> Node {
		Node { i: ii, e: 0, h: 0 }
	}

}

impl Edge {
        fn new(uu:usize, vv:usize,cc:i32) -> Edge {
                Edge { u: uu, v: vv, f: 0, c: cc }      
        }
}

fn other(u: &Node, e: &Edge) -> usize {
	if u.i == e.u {
		e.v
	}
	else {
		e.u
	}
}

fn enter_excess(excess: &mut VecDeque<usize>, node: &usize, t: &usize) {
	if *node != 0 && *node != *t {
		excess.push_back((*node));
	}
}

fn relabel(excess: &mut VecDeque<usize>, u: &mut Node, t: &usize) -> () {
	u.h += 1;
	enter_excess(excess, &u.i, &t);
}

fn push(u: &mut Node, v: &mut Node, e: &mut Edge, excess: &mut VecDeque<usize>, t: &usize) -> () {
	let d: i32;

	if u.i == e.u {
		println!("u.e = {}", u.e);
		println!("e.c - e.f = {}", e.c - e.f);
		d = cmp::min(u.e, e.c - e.f);
		e.f += d;
		println!("e.f = {}", e.f);
	}
	else {
		println!("u.e = {}", u.e);
		println!("e.c + e.f = {}", e.c + e.f);
		d = cmp::min(u.e, e.c + e.f);
		e.f -= d;
		println!("e.f = {}", e.f);
	}
	println!("d = {}", d);

	u.e -= d;
	v.e += d;

	if u.e > 0 {
		enter_excess(excess, &u.i, &t);
	}
	if v.e == d {
		enter_excess(excess, &v.i, &t);
	}

} 

fn main() {

	let n: usize = read!();		/* n nodes.						*/
	let m: usize = read!();		/* m edges.						*/
	let _c: usize = read!();	/* underscore avoids warning about an unused variable.	*/
	let _p: usize = read!();	/* c and p are in the input from 6railwayplanning.	*/
	let mut node = vec![];
	let mut edge = vec![];
	let mut adj: Vec<LinkedList<usize>> =Vec::with_capacity(n);
	let mut excess: VecDeque<usize> = VecDeque::new();
	let debug = true;

	let s = 0;
	let t = n-1;

	println!("n = {}", n);
	println!("m = {}", m);

	for i in 0..n {
		let u:Node = Node::new(i);
		node.push(Arc::new(Mutex::new(u))); 
		adj.push(LinkedList::new());
	}

	for i in 0..m {
		let u: usize = read!();
		let v: usize = read!();
		let c: i32 = read!();
		let e:Edge = Edge::new(u,v,c);
		adj[u].push_back(i);
		adj[v].push_back(i);
		edge.push(Arc::new(Mutex::new(e))); 
	}

	if debug {
		for i in 0..n {
			print!("adj[{}] = ", i);
			let iter = adj[i].iter();

			for e in iter {
				print!("e = {}, ", e);
			}
			println!("");
		}
	}

	println!("initial pushes");
	let iter = adj[s].iter();

	
	for e in iter {
		let mut sink = node[s].lock().unwrap();
		sink.h = n as i32;
		let mut current_edge = edge[*e].lock().unwrap();
		let mut neighbor = node[other(&*sink, &*current_edge)].lock().unwrap(); 

		sink.e += current_edge.c;
		push(&mut *sink, &mut *neighbor, &mut *current_edge, &mut excess, &t);
	}
	println!("sink flow = {}", node[s].lock().unwrap().e);
	

	while !excess.is_empty() {
		let mut c = 0;
		let u = excess.pop_front().unwrap();
		let u2 = node[u].lock().unwrap();
		let iter = adj[u].iter();
		let mut v: usize;
		let mut b: i32;
		let mut shouldPush = false;

		for e in iter {
			let mut a = edge[*e].lock().unwrap();
			if u == a.u {
				v = a.v;
				b = 1;
			}
			else {
				v = a.u;
				b = -1;
			}
			let v2 = node[v].lock().unwrap();
			if u2.h > v2.h && b * a.f < a.c {
				shouldPush = true;
				let mut u3 = node[u].lock().unwrap();
				let mut v1 = node[v].lock().unwrap();
				push(&mut *u3, &mut  *v1, &mut *a, &mut excess, &t);
				break;
			}
		}

		if !shouldPush {
			relabel(&mut excess, &mut node[u].lock().unwrap(), &t);
		}

	}

	println!("f = {}", node[t].lock().unwrap().e);

}
