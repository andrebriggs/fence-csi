import json
import os.path
from os import path

if path.exists('/var/www/fence/creds.json'):
    print ("File exist")
    creds = json.load(open('/var/www/fence/creds.json', 'r'))
    print('declare -A db_creds')
    for key in ['db_host', 'db_username', 'db_password', 'db_database']:
      print("db_creds['%s']='%s'" % (key, creds[key]))
    EOM
else:
    print("File not exist")
    exit(1)