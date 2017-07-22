# Lightning Network Daemon API Documentation Site
API Documentation for the Lightning Network Daemon

## Running the site locally

### Prerequisites

You're going to need:

 - **Linux or OS X** — Windows may work, but is unsupported.
 - **Ruby, version 2.2.5 or newer**
 - **Bundler** — If Ruby is already installed, but the `bundle` command doesn't work, just run `gem install bundler` in a terminal.

### Running locally

```shell
git clone https://github.com/MaxFangX/lightning-api

# Start a local server for testing purposes
bundle install
bundle exec middleman server
```

You can now see the docs at `http://localhost:4567`.

### Regenerating documentation

```shell
# Install Jinja for python templating
pip install Jinja2

# Set your $GOPATH to the current directory
export GOPATH=`pwd`
export PATH=$PATH:$GOPATH/bin

# Install annotations
go get -u github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis

# Get the latest rpc.proto
curl -o rpc.proto -s https://raw.githubusercontent.com/lightningnetwork/lnd/master/lnrpc/rpc.proto
```

At this point, you will need to
[install protoc-gen-doc](https://github.com/pseudomuto/protoc-gen-doc) and place the
binary in `$GOPATH/bin`, named exactly `protoc-gen-doc`. The binary committed to
this repo is the Mac OS X version. If running the `protoc -I. ...` command below
correctly outputs a new `rpc.json` file for you, you may skip this step.

```shell
# Generate the rpc.json file from rpc.proto, so that generate_slate_docs.py can
# parse it
protoc -I. -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --doc_out=json,rpc.json:. rpc.proto
```

## Deployment

The Lightning API is deployed with `s3_website`. Visit their [github
repo](https://github.com/laurilehmijoki/s3_website) for more information.

### Steps

1. Install `s3_website`
```bash
gem install s3_website
```

2. Add the deployment credentials for `s3_config.yml`
```
export LN_S3_ID="YOUR_S3_ID"
export LN_S3_SECRET="YOUR_S3_SECRET"
export LN_CLOUDFRONT_DISTRIBUTION_ID="YOUR_CLOUDFRONT_DISTRIBUTION_ID"
```

3. Build the website:
```
bundle exec middleman build --clean
```

4. Deploy the site from local changes:

```
s3_website push
```
