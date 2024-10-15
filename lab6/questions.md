clang: 53s
gcc1: 14.8s
gcc2: 2.15s
pgcc: 0.71s
xlc: 0.25s


Qs:

1.Why is it more reasonable to use software transactional memory with Clojure than with C, C++ or Java?

    Ref typen säkerställer att data modifieras av en transaktion i C och Java behöver programmeraren själv berätta för kompilatorn att det är ett transaktionsblock. Saknar inbyggd support

2. How does Power detect conflicts between hardware transactions?

    read and write bits?

3. Why can you not use I/O in a transaction, and which instructions can be used on Power if you need to print something?

    Printa är en "non reversible action" svårt att ta tillbaka en I/O. TSUSPEND

4. Explain your source codes.

    Det är preflow push i clojure...

    