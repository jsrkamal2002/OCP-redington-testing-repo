#!/bin/bash

# Get the route URL
ROUTE_URL=$(oc get route nginx-route -o jsonpath='{.spec.host}')

if [ -z "$ROUTE_URL" ]; then
    echo "Error: Could not get the route URL. Make sure the route 'nginx-route' exists."
    exit 1
fi

echo "Starting load test on $ROUTE_URL"

# Function to run ab with increasing concurrency
run_ab() {
    concurrency=$1
    requests=$((concurrency * 100))  # 100 requests per concurrent connection
    
    echo "Running test with concurrency: $concurrency, requests: $requests"
    ab -n $requests -c $concurrency http://$ROUTE_URL/
    sleep 5  # Wait a bit between tests
}

# Start with low concurrency and gradually increase
for concurrency in 1 5 10 20 50 100
do
    run_ab $concurrency
done

echo "Load test completed."