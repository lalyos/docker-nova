#!/bin/bash




list=$(PGPASSWORD=s3cr3t \
psql -h 172.17.0.2 \
  -U postgres  \
  postgres \
  -c 'select * from vip;'
)

cat > /var/www/html/index.html <<EOF
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


nginx -g 'daemon off;'