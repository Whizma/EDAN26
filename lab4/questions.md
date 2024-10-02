1. What is your explanation to requirement 3?

There is a lock instruction.

2. With only one thread doing work in phase 2 in Lab 3, can you move some of that work to phase 1 instead?

Yes, most of the push logic. 

3. Which memory order is used by default for compound assignment operators (such as +=) ? (in case you don’t use C/C++, your answer may differ from these languages)

Sequntial consistency. 

4. Will you get a data-race if you switch to memory_order_relaxed in C/C++? Why or why not?

We use an accumulating atomic int to calculate sum of flow to push. Using relaxed order, visibilty could impact.


5. Can you notice any performance difference when using (1) sequential consistency memory order and (2) relaxed memory order? Why or why not do you think?

About the same. 

Sequential consistency memory order can be slower due to the strict odering, and cache coherence traffic. Relaxed memory order can be faster thanks tto increased optimization oppurtinites and less cache coherence trafic.

Barriers and a small number of atomic operations could overshadow the performance gains from using a relaxed memory order. 


6. Explain your source code.

Like lab 3 but most of the push logic moved to phase1

7. Did you find a way to improve the performance of your program over the
first correct version?

Slightly

8. What is the purpose of each of memory order release and memory order
acquire?

Release: The processor must wait for all reads to have been performed and all writes made by itself must be acknowledged before the release can complete

Acquire: No read or write is allowed to execute before the acquire. 

