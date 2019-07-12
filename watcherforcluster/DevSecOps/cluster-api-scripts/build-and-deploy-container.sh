#!/bin/bash
docker build -t gcr.io/blackjack-209019/blackjack/devsecops/cluster-scripts:latest . \
&& gcloud docker -- push gcr.io/blackjack-209019/blackjack/devsecops/cluster-scripts:latest
