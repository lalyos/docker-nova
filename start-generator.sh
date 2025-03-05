#!/bin/bash


while true; do
sleep ${SLEEP:-5}

list=$(PGPASSWORD=s3cr3t \
psql -h ${DB_HOST:-db} \
  -U postgres  \
  postgres \
  -c 'select * from vip;'
)

cat > ${WWW_DIR:-/www}/index.html <<EOF
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<h1>VIP db</h1>
<body bgcolor="yellow">
<pre>
${list}
</pre>
</body>
</html>
EOF
done