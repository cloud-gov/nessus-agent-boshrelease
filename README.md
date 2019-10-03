# BOSH Release for the nessus agent

## Usage

To use this bosh release, first upload it to your bosh:

```sh
bosh target BOSH_HOST
git clone https://github.com/18F/cg-nessus-agent-boshrelease.git
cd cg-nessus-agent-boshrelease
bosh upload-release releases/nessus-agent/nessus-agent-1.yml
```

Then add the nessus agent key to the properties section of your manifest file and the nessus-agent release to the releases section:

```yml
properties:
  ...
  nessus-agent:
    key: foobar
    server: cloud.nessus.com
    port: 443
releases:
- ...
- name: nessus-agent
  version: latest
```

Finally add the `nessus-agent` template to your job:

```yml
- instances: 1
  name: runner_z1
  ...
  templates:
  - ...
  - name: nessus-agent
    release: nessus-agent
```
