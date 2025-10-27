1. touch bash2.txt
2. cd ~
3. mkdir  test3
4. cd test3/
   cat > 4
   row1
   row2
   row3
   row4
   cp 4 5
   cp 4 6
5. grep row2 5
6. grep -r row test3/
7. grep -c row test3/6
8. find test3/ -name 5
9. find test3/ -type f -name 5 -delete
10. echo test >> 4
11. sed -i 's/test/fail/g' 4
12. echo test >> 4
13. ps aux
14. kill 1819
15. ping rusau.net
16. ping -c 5 rusau.net
17. curl -X 'GET'   'https://petstore.swagger.io/v2/pet/findByStatus?status=sold'   -H 'accept: application/json'
18. curl -X 'POST' \
  'https://petstore.swagger.io/v2/user' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "id": 0,
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "password": "string",
  "phone": "string",
  "userStatus": 0
}'