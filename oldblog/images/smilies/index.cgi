#!/usr/bin/python

import cgi, os

path = 'http://scottj.info/images/smilies/'

print 'Content-type: text/html'
print '''
<html>
<head>
<title>Smilies</title>
<style type="text/css">
img {
  border: 0;
}
</style>
</head>
<body>
'''

form = cgi.FieldStorage()
file = form.getfirst('f', '')

if file:
  imgpath = path + file
  print '<img src="%s"><br><br>' % imgpath
  print '<input size=80 value="[img]%s[/img]" readonly onclick="this.select();">' % imgpath
else:
  files = os.listdir('.')
  files.sort()
  for name in files:
    if (name == '.htaccess' or name == 'index.cgi'):
      continue
    imgpath = path + name
    print '<a href="?f=%s"><img src="%s" /></a>' % (name, imgpath)

print '''
</body>
</html>
'''
