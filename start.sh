#!/bin/bash

cat > /var/www/html/index.html <<EOF
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<h1>${TITLE:-RTFM}</h1>
<body bgcolor="${COLOR:-red}">
    ${BODY:-Please use the BODY/COLOR/TITLE environment variables.}
</body>
</html>
EOF

nginx -g 'daemon off;'