1. Does the use of phases affect the possibility to do good load-balancing, and why, and if it does, to what extent is it significant?

After phase2, we are able to evenly distribute nodes that the the threads are able to work on after each phase run. This increases parallel execution compared to the second lab, where a thread stops if the main excess list ever is empty. 

Con: work is done by the main thread

2. Explain your source code.

Phases:

phase1 threads set command instructions for each node without locking

phase2 single thread executes commands

run it back turbo


3. Can you distribute the nodes in a fair way for load-balance?

Yep, but only for one phase


4. Did you find a way to improve the performance of your program over the first correct version?

Yep but not alot