#!/bin/bash

sudo apt-get update; 
sudo apt-get install -yq build-essential python-pip rsync 
pip install flask


cat > app.py << EOF
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_cloud():
	return 'Hello Cloud!'
app.run(host='0.0.0.0')
EOF

cat > s.sh << EOF
nohup python -u ~/app.py > output.log &
EOF

chmod +x s.sh

sleep 3
./s.sh
sleep 3
