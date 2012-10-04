#!/usr/local/bin/ruby
# encoding: utf-8

require "cgi"

c = CGI.new
message = c["t"]

f = open("./bbs.dat", "a:UTF-8")
f.write(message + "\n")
f.close

print "Content-type: text/html\n\n"

print <<EOF
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf8">
 <title>form</title>
</head>
<body>

書き込みありがとうございました。
<a href="./bbs.rb">掲示板へ戻る</a>

</body>
</html>
EOF
