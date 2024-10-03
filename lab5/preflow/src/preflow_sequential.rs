#[macro_use]
extern crate text_io;

// use std::i32::MIN;
use std::cmp;
use std::collections::LinkedList;
use std::sync::{Arc, Mutex};
// use std::thread;
use std::collections::VecDeque;

struct Node {
    i: usize, /* index of itself for debugging.	*/
    e: i32,   /* excess preflow.			*/
    h: i32,   /* height.				*/
}

struct Edge {
    u: usize,
    v: usize,
    f: i32,
    c: i32,
}

impl Node {
    fn new(ii: usize) -> Node {
        Node { i: ii, e: 0, h: 0 }
    }
}

impl Edge {
    fn new(uu: usize, vv: usize, cc: i32) -> Edge {
        Edge {
            u: uu,
            v: vv,
            f: 0,
            c: cc,
        }
    }
}

fn other(u: &Node, e: &Edge) -> usize {
    if u.i == e.u {
        e.v
    } else {
        e.u
    }
}

fn enter_excess(excess: &mut VecDeque<usize>, node: &usize, t: &usize) {
    if *node != 0 && *node != *t {
        excess.push_back(*node);
    }
}

fn relabel(excess: &mut VecDeque<usize>, u: &mut Node, t: &usize) -> () {
    u.h += 1;
    enter_excess(excess, &u.i, &t);
}

fn push(u: &mut Node, v: &mut Node, e: &mut Edge, excess: &mut VecDeque<usize>, t: &usize) -> () {
    let d: i32;

    if u.i == e.u {
        d = cmp::min(u.e, e.c - e.f);
        e.f += d;
    } else {
        d = cmp::min(u.e, e.c + e.f);
        e.f -= d;
    }

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
    let n: usize = read!(); /* n nodes.						*/
    let m: usize = read!(); /* m edges.						*/
    let _c: usize = read!(); /* underscore avoids warning about an unused variable.	*/
    let _p: usize = read!(); /* c and p are in the input from 6railwayplanning.	*/
    let mut node = vec![];
    let mut edge = vec![];
    let mut adj: Vec<LinkedList<usize>> = Vec::with_capacity(n);
    let mut excess: VecDeque<usize> = VecDeque::new();
    let debug = false;

    let s = 0;
    let t = n - 1;

    println!("n = {}", n);
    println!("m = {}", m);

    for i in 0..n {
        let u: Node = Node::new(i);
        node.push(Arc::new(Mutex::new(u)));
        adj.push(LinkedList::new());
    }

    for i in 0..m {
        let u: usize = read!();
        let v: usize = read!();
        let c: i32 = read!();
        let e: Edge = Edge::new(u, v, c);
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

    let iter = adj[s].iter();

    for e in iter {
        let mut sink = node[s].lock().unwrap();
        sink.h = n as i32;
        let mut current_edge = edge[*e].lock().unwrap();
        let mut neighbor = node[other(&*sink, &*current_edge)].lock().unwrap();

        sink.e += current_edge.c;
        push(&mut *sink,&mut *neighbor,&mut *current_edge, &mut excess, &t);
    }

    while !excess.is_empty() {
        let u = excess.pop_front().unwrap();
        let mut u_node_guard = node[u].lock().unwrap(); // Acquire lock on node[u] ONCE
        let u_node = &*u_node_guard; // Dereference to get the Node

        let mut should_push = false;
        for e in adj[u].iter() {
            let mut edge_guard = edge[*e].lock().unwrap();
            let (v, b) = if u == edge_guard.u {
                (edge_guard.v, 1)
            } else {
                (edge_guard.u, -1)
            };

            let mut v_node_guard = node[v].lock().unwrap();
            if u_node.h > v_node_guard.h && b * edge_guard.f < edge_guard.c {
                should_push = true;
                push(&mut *u_node_guard, &mut *v_node_guard, &mut *edge_guard, &mut excess, &t);
                break;
            }
        }

        if !should_push {
            relabel(&mut excess, &mut *u_node_guard, &t);
        }
    }

    println!("f = {}", node[t].lock().unwrap().e);
}
