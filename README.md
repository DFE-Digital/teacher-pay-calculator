# Calculate teacher pay

> School teachers and leaders in England can use this service to see how their
  salary could change following the 2023 pay award.

This repository contains the source code and infrastructure definitions for the
'Calculate teacher pay' service, a minimalistic Ruby on Rails application.

## Local development setup

After cloning the repository, `cd` into the folder and install the dependencies with:

```
$ yarn install
$ bundle install
$ bundle exec foreman start
```

Finally, visit: http://127.0.0.1:3000/

## Testing

To run the unit test suite locally:

```
$ bundle exec rspec
```

To perform manual testing against the hosted `development` enviornment, e.g.
when testing a dependency update, follow the instructions below (see [Deployment](#deployment)).

Please note: the hosted `development` environment is deployed with
`RAILS_ENV=production`.

## Deployment

There currently are two hosted environments in AKS, `development` and
`production`, and the respective urls are:

- https://development.calculate-teacher-pay.education.gov.uk/
- https://calculate-teacher-pay.education.gov.uk/

Every merge to `main` will trigger a deployment to `development` and
`production` via a Github Actions workflow.

In some circumstances, you may need to trigger a manual deployment to
`development` first, e.g. to test a new feature before it's ready for release.

To trigger a manual deployment, you can use the Github Actions workflow
"Deploy to AKS (Manual)", specifying:

- a target docker image tag (`main` by default)
- the target environment (`development` or `production`)

For `development`, you'd normally need to build the docker image locally and
push it to the repo's docker registry. Example steps:

```
$ export LATEST_COMMIT_SHA=git rev-parse --verify HEAD
$ docker buildx build --platform linux/amd64 --output type=docker . \
  -t ghcr.io/dfe-digital/teacher-pay-calculator:$LATEST_COMMIT_SHA
$ docker push ghcr.io/dfe-digital/teacher-pay-calculator:$LATEST_COMMIT_SHA
```

To authenticate with the registry, make sure you are added to it and
follow the instructions at https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-with-a-personal-access-token-classic

** **CAVEATS** **

* You can use the same workflow to deploy to `production`, although you should
  use the deployment via pipeline approach; in other words, simply merge to
  `main` when a branch/PR is ready to go to `production`
* The current setup relies on a Personal Github Token created by one of the
  current maintainers of the project and added to the `s189t01-ctp-dv-inf-kv`
  and `s189t01-ctp-pd-inf-kv` keyvaults; this is not ideal, but it was necessary
  to keep the repository public while we were doing the first and initial
  testing of new salary figures that couldn't be disclosed to the public until
  an official government announcement
* The Personal Github Token should have an expiration date and refreshed before
  completely expiring, otherwise the currently deployed pods won't be able to
  restart and fetch the docker image, potentially leading to unplanned downtime
* The `development` environment is protected with Basic auth; the credentials
  can be found in the `s189t01-ctp-dv-inf-kv` keyvault.

## Monitoring

Sentry is configured for both hosted environments.

StatusCake is also configured to check against the `/healthcheck` endpoint.

Alerts will be sent to the #claim_tech Slack channel.
