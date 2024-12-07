#!/bin/bash

# Step 1: Detect PHP version installed on the system
echo "Detecting PHP version..."
PHP_VERSION=$(php -v | head -n 1 | awk '{print $2}')
echo "Detected PHP version: $PHP_VERSION"

# Step 2: Download the PHP Project
echo "Downloading project files..."
PROJECT_DIR="/var/www/sharing"
if [ ! -d "$PROJECT_DIR" ]; then
    sudo mkdir -p $PROJECT_DIR
fi

sudo chown -R $USER:$USER $PROJECT_DIR
sudo chmod -R 755 $PROJECT_DIR

cd $PROJECT_DIR

# Download the project files from GitHub or other sources
# For example, if using raw GitHub URL for `index.php`:
wget https://raw.githubusercontent.com/taylorsuccessor/vim_setup/main/sharing/index.php

# Step 4: Create Required Directories for Sessions and Uploads
echo "Creating directories for sessions and uploads..."
SESSIONS_DIR="$PROJECT_DIR/sessions"

sudo mkdir -p $SESSIONS_DIR


# Step 5: Set up systemd service for PHP server to auto-restart if it fails
echo "Creating systemd service to keep PHP server running..."

SERVICE_FILE="/etc/systemd/system/php-server.service"

# Create the systemd service file to run PHP built-in server
sudo bash -c "cat > $SERVICE_FILE" <<EOL
[Unit]
Description=PHP built-in server for files sharing
After=network.target

[Service]
#ExecStart=/usr/bin/php -S 0.0.0.0:9999 -t $PROJECT_DIR
ExecStart=/usr/bin/php -S 0.0.0.0:9999  $PROJECT_DIR/index.php
WorkingDirectory=$PROJECT_DIR
Restart=always
User=www-data
Group=www-data
Environment=PATH=/usr/bin:/usr/local/bin

[Install]
WantedBy=multi-user.target
EOL

# Step 6: Enable and Start the PHP server service
echo "Enabling and starting the PHP server service..."
sudo systemctl enable php-server.service
sudo systemctl start php-server.service

# Step 7: Verify if PHP server service is running
echo "Verifying PHP server..."
sudo systemctl status php-server.service

echo "Setup complete! Your PHP server is now running on port 9999."
echo "You can access the project at http://your_server_ip:9999/"

