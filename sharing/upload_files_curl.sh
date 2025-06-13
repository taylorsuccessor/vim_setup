#!/bin/bash

set -e

echo "🔧 Installing dependencies..."
sudo apt update
sudo apt install -y python3 python3-pip python3-venv

echo "🚀 Creating virtual environment..."
python3 -m venv ~/upload_env
source ~/upload_env/bin/activate

echo "📦 Installing Python packages..."
pip install flask gunicorn

echo "📁 Creating server directory..."
mkdir -p ~/upload_server/uploads
cd ~/upload_server

echo "📜 Writing server.py..."
cat <<EOF > server.py
from flask import Flask, request, send_from_directory, jsonify, abort
import os, hashlib, tempfile, shutil

UPLOAD_FOLDER = 'uploads'
CHUNK_SIZE = 4096
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 15 * 1024 * 1024 * 1024

@app.route('/', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400
    file = request.files['file']
    file.stream.seek(0)

    tmp_file = tempfile.NamedTemporaryFile(delete=False)
    hash_obj = hashlib.sha256()

    with open(tmp_file.name, 'wb') as f:
        while True:
            chunk = file.stream.read(CHUNK_SIZE)
            if not chunk: break
            hash_obj.update(chunk)
            f.write(chunk)

    file_hash = hash_obj.hexdigest()[:16]
    final_path = os.path.join(UPLOAD_FOLDER, file_hash)
    shutil.move(tmp_file.name, final_path)
    return jsonify({'url': f"{request.url_root}{file_hash}"})

@app.route('/<file_hash>', methods=['GET'])
def download_file(file_hash):
    path = os.path.join(UPLOAD_FOLDER, file_hash)
    if not os.path.exists(path): abort(404)
    return send_from_directory(UPLOAD_FOLDER, file_hash, as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8000)
EOF

echo "🛠️ Creating systemd service..."
SERVICE_FILE="/etc/systemd/system/upload-server.service"
sudo bash -c "cat > $SERVICE_FILE" <<EOF
[Unit]
Description=Gunicorn Upload Server
After=network.target

[Service]
User=$USER
Group=$USER
WorkingDirectory=/home/$USER/upload_server
ExecStart=/home/$USER/upload_env/bin/gunicorn -w 4 -b 0.0.0.0:8000 server:app --timeout 3600
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

echo "🔄 Reloading systemd and enabling the service..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable upload-server
sudo systemctl start upload-server

echo "✅ Upload server is running at http://$(hostname -I | awk '{print $1}'):8000"
