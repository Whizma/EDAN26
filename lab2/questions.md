8.27 sek för c - 16 threads
4.70 sek för java - 8 threads 


railway huge input 16 threads
CPU: ppc64 POWER8, speed 3491 MHz (estimated)
Counted CYCLES events (Cycles) with a unit mask of 0x00 (No unit mask) count 100000
samples  %        image name               symbol name
2107     41.1282  libpthread-2.31.so       pthread_mutex_unlock
1434     27.9914  libpthread-2.31.so       pthread_mutex_lock
377       7.3590  kallsyms                 rfi_flush_fallback
237       4.6262  a.out                    task
95        1.8544  libc-2.31.so             _int_free
66        1.2883  kallsyms                 futex_wait_setup
66        1.2883  kallsyms                 system_call_exit
66        1.2883  libpthread-2.31.so       __lll_lock_wait
is3006ma-s@power8:~/lab2/c$

samma input i c
thread is donezo: 542 
thread is donezo: 686 
thread is donezo: 733 
thread is donezo: 790 
thread is donezo: 769 
thread is donezo: 734 
thread is donezo: 929 
thread is donezo: 988 

java:
Thread is done: 632
Thread is done: 698
Thread is done: 701
Thread is done: 719
Thread is done: 679
Thread is done: 663
Thread is done: 602
Thread is done: 664
t = 0.219 s
f = 9924


1. How do you avoid data-races and deadlocks?
mutex locks


2. What is your approach to load-balancing and how does it succeed?
Threads pull nodes from the same queue, working until the queue is emptied. 


3. Is your parallel program faster than the sequential from Lab 0, and what
do you think is the reason for this?

Not faster. We spend alot of time locking and unlocking. 


4. Did you notice any big performance difference between Java and C? (in
principle, either can be fastest and the JVM and the optimizing compiler
are important factors, and how you use the languages).

Java faster and nodes more evenly distributed between threads. Queue implementation could be the main difference

5. Explain your source codes.
6. Did you find a way to improve the performance of your programs over the
first correct version?

Nope
