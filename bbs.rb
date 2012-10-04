#!/usr/local/bin/ruby
# encoding: utf-8

require "cgi"

filename = "bbs.rb"
num_list = [10, 20, 50, 100]

f = open("bbs.dat", "r:UTF-8")
datnum = []
l = f.gets

while l
  datnum << CGI.escapeHTML(l)
  l = f.gets
end

f.close

cgi = CGI.new
en = cgi["en"] 

# num:一度に表示する掲示板データの件数
num = cgi["num"].to_i
if num <= 0 or num > 100
  num = 20
end

# en:表示するdatnumの最終番号
en = cgi["en"] 
if en == ""
  en = datnum.length - 1
else
  en = en.to_i
  if en < 0 or en > datnum.length - 1
    en = datnum.length - 1
  end
end

# st:一度に表示されるdatnumの一番古いデータの番号
st = en - num + 1
if st < 0
  st = 0
end

link = "<div class=\"navi\">"
if st > 0
  link = link + " <a href=\"#{filename}?num=#{num}&en=#{st-1}\">次のページ</a>"
else
  link = link + " 次のページ"
end

if en < datnum.length - 1
  link = link + " <a href=\"#{filename}?num=#{num}&en=#{en+num}\">前のページ</a>"
else
  link = link + " 前のページ"
end

num_list.each do |i|
  link = link + " <a href=\"#{filename}?num=#{i}&en=#{en}\">#{i}件ごと</a>"
end
link = link + "</div>"

print "Content-type: text/html\n\n"

print <<EOF
<!DOCTYPE html>
<html lang="ja">
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 <title>simple BBS</title>
</head>
<body>

<h1>簡易掲示板</h1>

<form action="./update.rb" method="post">
<div>
一行掲示板です。書き込みをどうぞ。<br>
<input name="t" value="">
<input type="submit" name="s" value="書き込み">
</div>
</form>
<br>

#{link}

<hr class="sep">

EOF

i = en
while i >= st
print <<EOF
<div class="day">
 <div class="body">
  <div class="section">
  #{puts i + 1, ":", datnum[i]}
  </div>
 </div>
</div>
EOF
  i = i - 1
end

print <<EOF

<hr class="sep">
#{link}
<div class="footer">
</div>

</body>
</html>
EOF
