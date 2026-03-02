This is `licensor`, the license server for the Rails Performance Workshop.

## Running tests with Docker Compose

```bash
docker compose -f docker-compose.test.yml run --rm --build test
```

This starts:
- Postgres for the test database
- `stripe-mock` for Stripe API calls used by tests
- the Rails test runner container
