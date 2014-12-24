sudo nano /etc/hosts
Add www.todos.com here

sudo docker build -no-cache -t joostlaan/todos .

sudo docker run -i -p 80:80 -t joostlaan/todos /sbin/my_init /bin/bash

sudo docker build -no-cache -t joostlaan/todos . && sudo docker run -i -p 80:80 -t joostlaan/todos /sbin/my_init /bin/bash