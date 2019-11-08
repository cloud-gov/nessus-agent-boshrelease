# BOSH Release for the nessus agent

## Usage

To use this bosh release, first upload it to your bosh:

```sh
bosh env
git clone https://github.com/18F/cg-nessus-agent-boshrelease.git
cd cg-nessus-agent-boshrelease
bosh upload-release
```

If co-locating the `nessus-agent` as a job on a specific BOSH deployment manifest, you could include the `nessus-agent` similar to this:

```yml
# some-deployment-manifest.yml

releases:
- ...
- name: nessus-agent
  version: latest

instance_groups:
- name: some-deployment
  instances: ...
  azs: ...
  jobs:
    - name: some-job
      release: ...
    # here's where you could add the nessus-agent directly:
    - name: nessus-agent
      release: nessus-agent
      properties:
        nessus-agent:
          key: aaaabbbbbccccddddeeee11112222333
          server: cloud.tenable.com
          port: 443
```

Alternatively, you could leverage this in your `runtime-config` as a [`BOSH add-on`](https://bosh.io/docs/runtime-config/#addons):

```yml
# bosh update-runtime-config --name=nessus-agent nessus-agent.yml --vars-file=/tmp/nessus-agent-vars.yml
releases:
  - name: nessus-agent
    version: 2
addons:
  - name: nessus-agent
    jobs:
      - name: nessus-agent
        release: nessus-agent
        properties:
          nessus-agent:
            key: ((nessus_agent_key))
            server: ((nessus_agent_server))
            port: ((nessus_agent_port))
            group: ((nessus_agent_group))
    include:
      deployments:
        - prometheus
        - my-other-deployment

# bosh -d my-other-deployment deploy ...
```
