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
          group: mygroup
```
