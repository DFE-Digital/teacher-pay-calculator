# Load testing

## Scenario
Amend the scenario in `loadtest.js` if necessary.

## Build the k6 image
```
docker build . -t ghcr.io/dfe-digital/k6-client:1234
```

Replace 1234 with any other tag to force a new deployment to Kubernetes.

## Push to Github container registry
First [login to GHCR](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-with-a-personal-access-token-classic) if necessary.

Then:

```
docker push ghcr.io/dfe-digital/k6-client:1234
```

## Deploy to Kubernetes
Use PIM to elevate access to the `s189-teacher-services-cloud-test` subscription.

Configure the variables BASE_URL, HTTP_USERNAME, HTTP_PASSWORD, RAMP_UP_TIME, VUSERS in `app.yml`.

Then:

```
kubectl -n srtl-development apply -f 'manifests/*.yml'
```

The test will start immediately.

## Dashboard
The k6 dashboard is available at: https://k6-client.test.teacherservices.cloud/

It can be used to monitor the test then generate a pdf report.

## Cleanup
Make sure to run:

```
kubectl -n srtl-development delete -f 'manifests/*.yml'
```
