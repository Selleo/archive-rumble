---
weight: 1
title: "01 - Say hello"
---

# Say hello

Goal of this Rumble is to create a simple HTTP server that returns text response: `"Hello"`.

At the end of the Rumble all solutions will be measured in a benchmark in a cloud.

## Rules

1. Create simple endpoint returning `200` status with `Hello` text as a `text/plain` mime type.
2. Application must listen at `3000` port.
3. Timeouts must be set to `30s`.
4. Application must be dockerized and created image pushed to a GitHub docker repository.
5. Dockerized application should run out of the box, any environment variables (if needed) should be hardcoded for simplicity.
6. Logging should be enabled to `STDOUT` and every request should be logged.

{{< hint info >}}
**Docker-based solution**

Make sure to read source distribution guideline and corresponding docker section.
{{< /hint >}}

## Verification

Run docker image with port exposed to `3000` and try `curl` command:

```
curl http://localhost:3000/hello
```

You should see the `Hello` output.
To verify response headers use:

```
curl -I http://localhost:3000/hello
```

## Results (wip)

### Information


|                 | go/gorilla        | js/express   | ts/deno           | ts/nest-express |
|-----------------|-------------------|--------------|-------------------|-----------------|
| <b>docker</b>   |                   |              |                   |                 |
| image size      | 13MB              | 167MB        | 103MB             | 410MB           |
| runtime         | 1.16.5-alpine3.13 | 14.15.4-slim | alpine-deno:1.9.2 | 16-alpine       |
| <b>logger</b>   |                   |              |                   |                 |
| type            | json              | plain        | plain             | json            |
| avg. entry size | 106 bytes         | 35 bytes     | 46 bytes          | 134 bytes       |


https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html
running tasks = 3 (reservation 512)
CPU available = 512
MEM available = 2348

2vCPU 4GB (2048, 4096)

### Benchmark 


|                        | go/gorilla | js/express | ts/deno | ts/nest-express |
|------------------------|------------|------------|---------|-----------------|
| <b>idle before</b>     |            |            |         |                 |
| cpu utilization        | 0.01%      | 0.02%      | 0.02%   | 0.04%           |
| memory utilization     | 0.23%      | 0.87%      | 0.77%   | 4.02%           |
| <b>rate 100</b>        |            |            |         |                 |
| max cpu utilization    | 1.30%      | 5.08%      | 3.25%   | 6.40%           |
| max memory utilization | 0.46%      | 3.50%      | 1.44%   | 4.84%           |
| <b>rate 500</b>        |            |            |         |                 |
| max cpu utilization    | 4.21%      | 13.83%     | 11.19%  | 18.37%          |
| max memory utilization | 0.46%      | 3.75%      | 2.90%   | 6.02%           |
| <b>rate 750</b>        |            |            |         |                 |
| max cpu utilization    | 5.93%      | 16.66%     | 15.75%  | 21.91%          |
| max memory utilization | 0.46%      | 3.71%      | 4.40%   | 6.29%           |
| <b>rate 1000</b>       |            |            |         |                 |
| max cpu utilization    | 7.54%      | 21.15%     | 19.81%  | 28.91%          |
| max memory utilization | 0.46%      | 3.83%      | 4.58%   | 6.34%           |
| <b>rate 1250</b>       |            |            |         |                 |
| max cpu utilization    | 9.27%      | 26.24%     | 24.93%  | 36.84%          |
| max memory utilization | 0.46%      | 3.86%      | 4.50%   | 6.35%           |
| <b>rate 1500</b>       |            |            |         |                 |
| max cpu utilization    | 10.92%     | 31.47%     | 30.11%  | 42.79%          |
| max memory utilization | 0.47%      | 3.89%      | 5.20%   | 6.53%           |
| <b>rate 1750</b>       |            |            |         |                 |
| max cpu utilization    | 12.36%     | 37.30%     | 34.96%  | 49.73%          |
| max memory utilization | 0.46%      | 4.11%      | 5.27%   | 6.59%           |
| <b>rate 2000</b>       |            |            |         |                 |
| max cpu utilization    | 13.95%     | 42.59%     | 41.22%  | 57.20%          |
| max memory utilization | 0.48%      | 4.23%      | 5.30%   | 7.17%           |
| <b>rate 2250</b>       |            |            |         |                 |
| max cpu utilization    | 15.54%     | 50.62%     | 46.21%  | 73.64%          |
| max memory utilization | 0.51%      | 4.37%      | 5.43%   | 7.77%           |
| <b>rate 2500</b>       |            |            |         |                 |
| max cpu utilization    | 17.65%     | 55.61%     | 52.04%  | 73.85%          |
| max memory utilization | 0.48%      | 4.46%      | 5.56%   | 8.17%           |
| <b>rate 2750</b>       |            |            |         |                 |
| max cpu utilization    | 18.83%     | 59.86%     | 59.09%  | 72.16%          |
| max memory utilization | 0.99%      | 4.57%      | 5.69%   | 8.23%           |
| <b>rate 3000</b>       |            |            |         |                 |
| max cpu utilization    | 21.68%     | 71.83%     | 63.62%  | 74.46%          |
| max memory utilization | 0.54%      | 4.58%      | 5.79%   | 8.22%           |
| <b>rate 3250</b>       |            |            |         |                 |
| max cpu utilization    | 22.81%     | 78.69%     | 69.57%  | 71.89%          |
| max memory utilization | 0.54%      | 4.82%      | 5.87%   | 8.10%           |
| <b>rate 3500</b>       |            |            |         |                 |
| max cpu utilization    | 24.53%     | 79.79%     | 73.05%  | 72.50%          |
| max memory utilization | 0.54%      | 5.14%      | 6.00%   | 8.33%           |
| <b>rate 3750</b>       |            |            |         |                 |
| max cpu utilization    | 26.12%     | 80.47%     | 77.58%  | 73.87%          |
| max memory utilization | 0.55%      | 5.12%      | 6.66%   | 8.30%           |
| <b>rate 4000</b>       |            |            |         |                 |
| max cpu utilization    | 28.86%     | 80.47%     | 78.98%  | 73.06%          |
| max memory utilization | 0.54%      | 5.12%      | 7.13%   | 8.31%           |
| <b>rate 4250</b>       |            |            |         |                 |
| max cpu utilization    | 30.97%     | 79.33%     | 78.35%  | 72.04%          |
| max memory utilization | 0.54%      | 5.13%      | 7.36%   | 8.25%           |
| <b>rate 4500</b>       |            |            |         |                 |
| max cpu utilization    | 30.52%     | 79.46%     | 80.28%  | 72.31%          |
| max memory utilization | 0.54%      | 5.14%      | 7.49%   | 8.25%           |
| <b>rate 4750</b>       |            |            |         |                 |
| max cpu utilization    | 33.10%     | 79.24%     | 79.68%  | 71.98%          |
| max memory utilization | 0.55%      | 5.15%      | 8.38%   | 8.29%           |
| <b>rate 5000</b>       |            |            |         |                 |
| max cpu utilization    | 38.28%     | 80.00%     | 79.19%  | 71.75%          |
| max memory utilization | 0.55%      | 5.22%      | 8.44%   | 8.33%           |
| <b>rate 5250</b>       |            |            |         |                 |
| max cpu utilization    | 37.95%     | 79.60%     | 79.14%  | 71.99%          |
| max memory utilization | 0.54%      | 5.25%      | 8.36%   | 8.20%           |
| <b>rate 5500</b>       |            |            |         |                 |
| max cpu utilization    | 39.31%     | 79.35%     | 79.17%  | 71.99%          |
| max memory utilization | 0.54%      | 5.25%      | 8.38%   | 8.20%           |
| <b>rate 5750</b>       |            |            |         |                 |
| max cpu utilization    | 40.66%     | 79.79%     | 78.61%  | 71.66%          |
| max memory utilization | 0.54%      | 5.22%      | 8.41%   | 8.34%           |
| <b>rate 6000</b>       |            |            |         |                 |
| max cpu utilization    | 40.82%     | 79.07%     | 79.33%  | 71.61%          |
| max memory utilization | 0.54%      | 5.22%      | 8.42%   | 8.28%           |
| <b>idle after</b>      |            |            |         |                 |
| cpu utilization        | 0.01%      | 0.03%      | 0.01%   | 0.04%           |
| memory utilization     | 0.32%      | 1.69%      | 8.42%   | 6.49%           |


