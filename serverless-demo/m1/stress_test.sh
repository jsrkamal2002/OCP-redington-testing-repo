#!/bin/bash

# Define the number of concurrent requests and sleep interval
CONCURRENT_REQUESTS=5
SLEEP_INTERVAL=0.5  # Adjust sleep interval in seconds as needed

# Function to perform the stress testing
perform_stress_test() {
  seq 1 500000 | xargs -P${CONCURRENT_REQUESTS} -I{} bash -c 'curl -k hello-serverless-default.apps.r630.example.com; sleep '${SLEEP_INTERVAL}
}

# Run the stress test
perform_stress_test

