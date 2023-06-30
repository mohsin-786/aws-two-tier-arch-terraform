#!/bin/bash

sudo apt update -y
sudo apt install nginx -y

sudo systemctl enable --now nginx.service

instanceId=$(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/instance-id)

region=$(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
 && curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-ipv4)

echo "*{
	padding:0;
	margin:0;
}

table{
	table-layout:fixed;
	width:100%;
	border-collapse:collapse;
	
}
table, th,td{
	border: 1px solid rgb(220,220,220);
}

table th{
	background-color: rgb(104, 208, 109);
}
table td{
	text-align:center;
}
" > /var/www/html/styles.css

echo "<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
	  
    <title>Document</title>
</head>
<body>
   <h1>Table</h1>
	<div class="table">
		<table>
			<tr>
				<th>InstanceId</th>
				<th>Region</th>
			</tr>
			<tr>
				<td>$instanceId</td>
				<td>$region</td>
			</tr>
		</table>
	</div>
</body>
</html>
" > /var/www/html/index.html