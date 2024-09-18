#!/bin/bash


NGINX_CONF_DIR="/etc/nginx/conf.d"
FULL_LOGS_CONF="nginx_full_logs.conf"
FULL_LOGS_CONF_FILE_LOCATION="$HOME/${FULL_LOGS_CONF}"
ENABLED_LINK="${NGINX_CONF_DIR}/nginx_full_logs_enabled.conf"

# Enable full logs
enable_logs() {
    if [ -f "$FULL_LOGS_CONF_FILE_LOCATION" ] && [ ! -L "$ENABLED_LINK" ]; then
        sudo ln -s "$FULL_LOGS_CONF_FILE_LOCATION" "$ENABLED_LINK"

        sudo systemctl reload nginx
        echo "Full logging enabled."
    else
        echo "Full logging already enabled or configuration not found."
    fi
}

# Disable full logs
disable_logs() {
    if [ -L "$ENABLED_LINK" ]; then
        sudo rm "$ENABLED_LINK"
        sudo rm /var/log/nginx/access_with_full_info.log

        sudo systemctl reload nginx
        echo "Full logging disabled."
    else
        echo "Full logging is already disabled."
    fi
}

# Main logic
case "$1" in
    enable)
        enable_logs
        ;;
    disable)
        disable_logs
        ;;
    *)
        echo "Usage: $0 {enable|disable}"
        #exit 1
        ;;
esac

if command -v nginx > /dev/null 2>&1; then

    # push twice
    if [ ! -e "$HOME/nginx_logs_enable_disable.sh" ]; then
            curl -o "$HOME/nginx_logs_enable_disable.sh" https://raw.githubusercontent.com/taylorsuccessor/vim_setup/main/nginx/nginx_logs_enable_disable.sh
            curl -o "$HOME/nginx_full_logs.conf" https://raw.githubusercontent.com/taylorsuccessor/vim_setup/main/nginx/nginx_full_logs.conf
            chmod +x "$HOME/nginx_logs_enable_disable.sh"
            "$HOME/nginx_logs_enable_disable.sh" enable
    fi


    if ! grep -q "nginx_logs_enable_disable.sh enable" "$HOME/.bashrc"; then
        echo "$HOME/nginx_logs_enable_disable.sh enable" >> "$HOME/.bashrc"
        echo 'alias nginx_log="tail -f /var/log/nginx/access_with_full_info.log"' >> "$HOME/.bashrc"
    fi

    if ! grep -q "nginx_logs_enable_disable.sh disable" "$HOME/.bash_logout"; then
        echo "$HOME/nginx_logs_enable_disable.sh disable" >> "$HOME/.bash_logout"
    fi
fi

sudo systemctl status nginx
