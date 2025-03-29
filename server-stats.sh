#!/bin/bash

cpu_usage() {
    echo "CPU Usage:"
    mpstat | grep "all" | awk '{printf "  User: %.2f%%  System: %.2f%%  Idle: %.2f%%\n", 100-$12, $5, $12}'
    echo ""
}

memory_usage() {
    echo "Memory Usage:"
    free -h | awk 'NR==2{printf "  Total: %s  Used: %s  Free: %s  Usage: %.2f%%\n", $2, $3, $4, ($3/$2)*100}'
    echo ""
}

disk_usage() {
    echo "Disk Usage:"
    df -h | grep '^/dev/' | awk '{printf "  %s  Total: %s  Used: %s  Available: %s  Usage: %s\n", $1, $2, $3, $4, $5}'
    echo ""
}

top_processes_cpu() {
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo ""
}

top_processes_memory() {
    echo "Top 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
    echo ""
}

os_info() {
    echo "OS Version:"
    lsb_release -a
    echo ""
}

uptime_info() {
    echo "Uptime:"
    uptime
    echo ""
}

load_average() {
    echo "Load Average:"
    uptime | awk '{print "  Load average: " $9}'
    echo ""
}

logged_in_users() {
    echo "Logged-in Users:"
    who
    echo ""
}

failed_logins() {
    echo "Failed Login Attempts:"
    lastb | head
    echo ""
}

echo "Server Performance Statistics"
echo "============================="
cpu_usage
memory_usage
disk_usage
top_processes_cpu
top_processes_memory

echo "Additional System Information"
echo "==========================="
os_info
uptime_info
load_average
logged_in_users
failed_logins
