#!/bin/bash

# "Grep `nessuscli agent status` for "\[error\]" to prevent relinking all the time
if /opt/nessus_agent/sbin/nessuscli agent status | grep '\[error\]' || \
   /opt/nessus_agent/sbin/nessuscli agent status | grep "Not linked to a manager" || \
   ! /opt/nessus_agent/sbin/nessuscli agent status; then
    /opt/nessus_agent/sbin/nessuscli agent link \
    --host=<%= p("nessus-agent.server") %> \
    --port=<%= p("nessus-agent.port") %> \
    --key=<%= p("nessus-agent.key") %> \
    --name=<%= spec.deployment %>-<%= name %>-<%= spec.index %> \
    --groups=<%= p("nessus-agent.group") %> || true
fi
