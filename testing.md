# Voting

First time voting
  Voting for yourself
    - increment your votes and set voted_for to yourself
  Voting for someone else
    - increment new candidate votes
    - set voted_for to new candidate

Previously voted
  Voting for yourself
    - decrement old candidates votes
    - increment your votes and set voted_for to yourself
  Voting for someone else
    Old candidate is yourself
      - decrement your votes and set voted_for to the new candidate
      - increment new candidates votes
    Old candidate is someone else
      - decrement old candidates votes
      - increment new candidates votes
      - set voted_for to the new candidate

# Auth

**First Time Sign in**
- delete access_token from database
- revoke access to app
- sign in
- verify that GitHub authorization must be granted
- verify access_token stored in contributor record and browser local storage

**Second Time Sign in**
- reload page
- verify that GitHub authorization is skipped
- verify username displayed in browser

**First time sign in when not a contributor**
- delete contributor from database
- delete access_token from local storage
- revoke access to app
- sign in
- verify alert

**Second time sign in when not a contributor**
- sign in
- verify alert

**Revoked access**
- sign in
- revoke access
- reload page
- verify that you must sign in again
