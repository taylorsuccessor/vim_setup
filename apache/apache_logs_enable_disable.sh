1-
sudo vim /etc/apache2/apache2.conf
# add this line after last LogFormat 

LogFormat "%h\n%l\n%u\n%t\n\"%r\"\n%>s\n%b\n\"%{User-Agent}i\"\n\"%{Referer}i\"\n\"%{Accept}i\"\n\"%{Host}i\"\n\"%{Authorization}i\"\n\"%{X-Request-ID}i\"\n%{request_body}e\n\"%{Cookie}i\"" fullinfo


2-
sudo vim /etc/apache2/sites-available/xxxxxxx-le-ssl.conf

# replace CustomLog
CustomLog /var/log/apache2/access_with_full_info.log fullinfo


3-
sudo systemctl restart apache2


4-
 tail -f /var/log/apache2/access_with_full_info.log
