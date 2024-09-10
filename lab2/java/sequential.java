import java.util.Scanner;
import java.util.Iterator;
import java.util.ListIterator;
import java.util.LinkedList;

import java.io.*;

class Graph {

	int	s;
	int	t;
	int	n;
	int	m;
	Node	excess;		// list of nodes with excess preflow
	Node	node[];
	Edge	edge[];

	Graph(Node node[], Edge edge[])
	{
		this.node	= node;
		this.n		= node.length;
		this.edge	= edge;
		this.m		= edge.length;
	}

	void enter_excess(Node u)
	{
		if (u != node[s] && u != node[t]) {
			u.next = excess;
			excess = u;
		}
	}

	Node other(Edge a, Node u)
	{
		if (a.u == u)	
			return a.v;
		else
			return a.u;
	}

	void relabel(Node u)
	{
		u.h++;
		enter_excess(u);
	}

	void push(Node u, Node v, Edge a){
		System.out.println("push");
		int delta;
		if (u == a.u) {
			delta = Math.min(u.e, a.c - a.f);
			a.f += delta;
		}
		else {
			delta = Math.min(u.e, a.c + a.f);
			a.f -= delta;
		}

		u.e -= delta;
		v.e += delta;

		assert(delta >= 0);
		assert(u.e >= 0);
		assert(Math.abs(a.f) <= a.c);

		if (u.e > 0) {
			enter_excess(u);
		}

		if (v.e == delta) {
			enter_excess(v);
		}

	}

	int preflow(int s, int t)
	{
		ListIterator<Edge>	iter;
		int			  b;
		Edge			a;
		Node			u;
		Node			v;
		
		this.s = s;
		this.t = t;
		node[s].h = n;

		iter = node[s].adj.listIterator();
		while (iter.hasNext()) {
			a = iter.next();

			node[s].e += a.c;

			push(node[s], other(a, node[s]), a);
		}

		while (excess != null) {
			
			u = excess;
			v = null;
			a = null;
			excess = u.next;

			iter = u.adj.listIterator();
			while (iter.hasNext()) {
				// System.out.println("Fast i  while");
				a = iter.next();
				
				if (u == a.u) {
					v = a.v;
					b = 1;
				} else {
					v = a.u;
					b = -1;
				}
				System.out.println(u.toString() + " " + v.toString());

				if(u.h > v.h && b * a.f < a.c) {
					break;
				} else {
					v = null;
				}
			}

			if (v != null)
				push(u, v, a);
			else
				relabel(u);
		}

		return node[t].e;
	}
}

class Node {
	int	h;
	int	e;
	int	i;
	Node	next;
	LinkedList<Edge>	adj;

	Node(int i)
	{
		this.i = i;
		adj = new LinkedList<Edge>();
	}
}

class Edge {
	Node	u;
	Node	v;
	int	f;
	int	c;

	Edge(Node u, Node v, int c)
	{
		this.u = u;
		this.v = v;
		this.c = c;

	}
}

class Preflow {
	public static void main(String args[]){	
		double	begin = System.currentTimeMillis();
		Scanner s = new Scanner(System.in);
		int	n;
		int	m;
		int	i;
		int	u;
		int	v;
		int	c;
		int	f;
		Graph	g;

		n = s.nextInt();
		m = s.nextInt();
		s.nextInt();
		s.nextInt();
		Node[] node = new Node[n];
		Edge[] edge = new Edge[m];

		for (i = 0; i < n; i += 1)
			node[i] = new Node(i);

		for (i = 0; i < m; i += 1) {
			u = s.nextInt();
			v = s.nextInt();
			c = s.nextInt(); 
			edge[i] = new Edge(node[u], node[v], c);
			node[u].adj.addLast(edge[i]);
			node[v].adj.addLast(edge[i]);
		}

		g = new Graph(node, edge);
		f = g.preflow(0, n-1);
		double	end = System.currentTimeMillis();
		System.out.println("t = " + (end - begin) / 1000.0 + " s");
		System.out.println("f = " + f);
	}
}
