#[macro_use]
extern crate text_io;

// use std::i32::MIN;
use std::cmp;
use std::collections::LinkedList;
use std::collections::VecDeque;
use std::sync::{Arc, Mutex, RwLock};
use std::thread;
use std::thread::JoinHandle;

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
        let mut source = node[s].lock().unwrap();
        source.h = n as i32;
        let mut current_edge = edge[*e].lock().unwrap();
        let mut neighbor = node[other(&*source, &*current_edge)].lock().unwrap();

        source.e += current_edge.c;
        push(
            &mut *source,
            &mut *neighbor,
            &mut *current_edge,
            &mut excess,
            &t,
        );
    }

    let excess_arc = Arc::new(Mutex::new(excess));
    let adj_arc = Arc::new(RwLock::new(adj));
    let node_arc = Arc::new(RwLock::new(node));
    let edge_arc = Arc::new(RwLock::new(edge));

    let mut handles: Vec<JoinHandle<()>> = vec![];

    let n_threads = 8;


    for _ in 0..n_threads {
        let excess_main = excess_arc.clone();
        let node_main = Arc::clone(&node_arc);
        let edge_main = Arc::clone(&edge_arc);
        let adj_main = Arc::clone(&adj_arc);

        let t = thread::spawn(move || {
            let mut u: usize;
            let node_thread = node_main.read().unwrap();
            let edge_thread = edge_main.read().unwrap();
            let adj_thread = adj_main.read().unwrap();



            loop {
                // let mut excess = excess_main.lock().unwrap();
                u = {
                    let mut excess = excess_main.lock().unwrap();

                    if excess.is_empty() {
                        break;
                    }
                    excess.pop_front().unwrap()
                };


                let iter = adj_thread[u].iter();
                let total_elements = iter.len();

                for (i, e) in iter.enumerate() {
                    let mut u_node_guard;
                    let mut v_node_guard;
    
                    let mut edge_guard = edge_thread[*e].lock().unwrap();
                    let (v, b) = if u == edge_guard.u {
                        (edge_guard.v, 1)
                    } else {
                        (edge_guard.u, -1)
                    };

                    // println!("Innan uv");
                    if u < v {
                        u_node_guard = node_thread[u].lock().unwrap();
                        v_node_guard = node_thread[v].lock().unwrap();
                    } else {
                        v_node_guard = node_thread[v].lock().unwrap();
                        u_node_guard = node_thread[u].lock().unwrap();
                    }
                    // println!("efter uv");

                    if u_node_guard.h > v_node_guard.h && b * edge_guard.f < edge_guard.c {
                        push(
                            &mut u_node_guard,
                            &mut *v_node_guard,
                            &mut *edge_guard,
                            &mut excess_main.lock().unwrap(),
                            &t,
                        );
                        break;
                    }

                    // println!("total elements: {}", total_elements);
                    // println!("i: {}", i);
                    if total_elements == i + 1{
                        relabel(&mut excess_main.lock().unwrap(), &mut u_node_guard, &t);
                        // println!("Efter relabel");
                    }
                }

            }
        });
        handles.push(t);
    }

    for t in handles {
        t.join().unwrap();
    }

    // while !excess.is_empty() {
    //     let u = excess.pop_front().unwrap();
    //     let mut u_node_guard = node[u].lock().unwrap(); // Acquire lock on node[u] ONCE
    //     let u_node = &*u_node_guard; // Dereference to get the Node

    //     let mut should_push = false;
    //     for e in adj[u].iter() {
    //         let mut edge_guard = edge[*e].lock().unwrap();
    //         let (v, b) = if u == edge_guard.u {
    //             (edge_guard.v, 1)
    //         } else {
    //             (edge_guard.u, -1)
    //         };

    //         let mut v_node_guard = node[v].lock().unwrap();
    //         if u_node.h > v_node_guard.h && b * edge_guard.f < edge_guard.c {
    //             should_push = true;
    //             push(&mut *u_node_guard, &mut *v_node_guard, &mut *edge_guard, &mut excess, &t);
    //             break;
    //         }
    //     }

    //     if !should_push {
    //         relabel(&mut excess, &mut *u_node_guard, &t);
    //     }
    // }

    println!("f = {}", node_arc.read().unwrap()[t].lock().unwrap().e);
}
