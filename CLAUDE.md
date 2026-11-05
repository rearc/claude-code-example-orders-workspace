# Orders workspace

For changes that span orders-api and orders-web. Each repo has its own CLAUDE.md, rules, skills
and plugins; follow them inside that repo. This file covers only how the repos fit together.

## The repos
- `repos/orders-api`: the API. Its `openapi.json` is the contract.
- `repos/orders-web`: the browser client. `src/api/ordersClient.js` follows the contract.

## Order of work
1. Change the contract and the API first (orders-api), with its tests passing.
2. Then the client (orders-web), with its tests passing.
3. One branch and one PR per repo, each naming the other PR. Merge orders-api first.

## In this workspace
- These settings govern the session; the repos' own settings don't. The repos' deny rules are restated here.
- Run each repo's commands from inside that repo (`cd repos/<repo>`).
