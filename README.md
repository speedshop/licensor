This is `licensor`, the license server for the Rails Performance Workshop.

Testing requires `stripe-mock` to be running on port 12111:

```
docker run --rm -it -p 12111-12112:12111-12112 stripemock/stripe-mock:test
```