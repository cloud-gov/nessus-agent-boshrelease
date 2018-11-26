#!/bin/bash

# "Grep `nessuscli agent status` for "\[error\]" to prevent relinking all the time
if /opt/nessus_agent/sbin/nessuscli agent status | grep '\[error\]' || ! /opt/nessus_agent/sbin/nessuscli agent status; then
    /opt/nessus_agent/sbin/nessuscli agent link \
    --host=<%= p("nessus-agent.server") %> \
    --port=<%= p("nessus-agent.port") %> \
    --key=<%= p("nessus-agent.key") %> \
    --name=<%= spec.deployment %>-<%= name %>-<%= spec.index %>-<%= p("nessus-agent.group") %> \
    --groups=<%= p("nessus-agent.group") %> || true
fi
