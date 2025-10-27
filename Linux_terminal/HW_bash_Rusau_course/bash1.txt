1. touch bash1.txt
2. cd ~
3. pwd
4. mkdir test1
5. cd test1/
6. touch 1 2 3
7. ls
8. cd ~
9. mkdir test2
10. rmdir test2/
11. rm test1/2
12. mkdir test3/
    touch test3/one test3/two
13. rm -r test3/
14. mkdir test4
15. mv test1/1 test4/
    mv test1/3 test4/
16. echo line1 > test4/1
    echo line2 > test4/1
    echo line3 > test4/1
17. cat test4/1
18. echo line1 > test4/3
    echo line2 > test4/3
    echo line3 > test4/3
19. cat test4/1 test4/3
20. vim test4/1
    i
    <Изменены строки>
    Esc
    wq