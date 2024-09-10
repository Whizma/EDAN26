## Questions

1.  **Controller and Node Agreement:** 
    * If you use a controller, how can it know that no node is active? 
        The nodes can message the controller if they are active or not. 

    *   If you don't use a controller for that, how do the actors agree on terminating the algorithm?
    
      The Ceberg termination criterion only needs to look at the sink and source, and if the excess flow of the source matches that of the sink, we are finished. 

2.  **Concurrent Push Messages:** 
    *   How many push messages can a node have in progress concurrently in your solution? (One is OK)
        
        Only one.

3.  **Non-Negative Excess Preflow:** 
    *   How do you ensure that a node never gets a negative excess preflow? (Except possibly for the source depending on how you implement it)
        
        We do it programmaticaly, checked with assert.

4.  **Scalability with Millions of Nodes:** 
    *   With millions of nodes in a graph, it would be bad to have one JVM thread per actor, so how is it done?

        Actor thread not tied to a JVM thread, work for any actor can be done by any JVM thread. Threadpool

5.  **Source Code Explanation:** 
    *   Explain your source code.

        In Node, we added a method for discharge, which relabels if it cant push to any neighbor, or pushes if it can. We added three cases, Start, PushRequest and PushResponse. Start initializes the source node by pushing flow out on its edges. One node sends a PushRequest to another node when trying to push, and PushRequest changes corresponding excess flow and edge flow. PushResponse changes the senders excess flow, and discharges. 

        In the controller, we added cases for Initialize and ShouldTerminate. We start the algorithm in the Maxflow case.



6.  **Performance Improvements:** 
    *   Did you find a way to improve the performance of your program over the first correct version?

        First: 3.53 real         3.24 user          0.08 sys
        
        Our:   31.38 real        97.79 user         8.29 sys

7.  **Akka Use Cases:** 
    *   For which types of applications would you consider using Akka and why?

        Distributed applications, chat applications