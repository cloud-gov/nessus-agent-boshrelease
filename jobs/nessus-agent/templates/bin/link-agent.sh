#!/bin/bash

# "Grep `nessuscli agent status` for "\[error\]" to prevent relinking all the time
if /opt/nessus_agent/sbin/nessuscli agent status | grep '\[error\]' || \
   /opt/nessus_agent/sbin/nessuscli agent status | grep "Not linked to a manager" || \
   ! /opt/nessus_agent/sbin/nessuscli agent status; then
    /opt/nessus_agent/sbin/nessuscli agent link \
    --host=<%= p("nessus-agent.server") %> \
    --port=<%= p("nessus-agent.port") %> \
    --key=<%= p("nessus-agent.key") %> \
    <% if_p('nessus-agent.proxy-host') do |proxy_host| %> \
    --proxy-host="<%= proxy_host %>" \
    <% end %> \
    <% if_p('nessus-agent.proxy-port') do |proxy_port| %> \
    --proxy-port="<%= proxy_port %>" \
    <% end %> \
    <% if_p('nessus-agent.proxy-username') do |proxy_username| %> \
    --proxy-username="<%= proxy_username %>" \
    <% end %> \
    <% if_p('nessus-agent.proxy-password') do |proxy_password| %> \
    --proxy-password="<%= proxy_password %>" \
    <% end %> \
    --name=<%= spec.deployment %>-<%= name %>-<%= spec.index %>-<%= p("nessus-agent.group") %> \
    --groups=<%= p("nessus-agent.group") %> || true
fi
