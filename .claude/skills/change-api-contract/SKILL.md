---
name: change-api-contract
description: Change the orders API contract and carry the change through orders-api and orders-web. Use when a field or endpoint must change in both repos.
---
# Change the API contract
1. In `repos/orders-api`, follow its `add-endpoint` skill: contract, regenerate, handler, tests.
2. Write down the contract change: fields, and whether it's breaking.
3. In `repos/orders-web`, follow its `add-api-call` skill for each changed endpoint.
4. Run both repos' tests.
5. Make a branch and commit in each repo. Write each PR description with the `pr-description` skill, naming the other PR. Merge orders-api first.
