#!/bin/bash

# "nessuscli agent status" will exit code 2 if the agent is not linked
if ! /opt/nessus_agent/sbin/nessuscli agent status; then
    /opt/nessus_agent/sbin/nessuscli agent link \
    --host=<%= p("nessus-agent.server") %> \
    --port=<%= p("nessus-agent.port") %> \
    --key=<%= p("nessus-agent.key") %> \
    --name=<%= spec.deployment %>-<%= name %>-<%= spec.index %> \
    --groups=<%= p("nessus-agent.group") %> || true
fi
