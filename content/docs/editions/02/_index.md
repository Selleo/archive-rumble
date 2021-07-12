---
weight: 2
title: "02 - Simple JSON"
---

# Simple JSON

Goal of this Rumble is to create a simple HTTP server that accepts JSON payload, deserializes it and serialzes it back again as a response.

## Rules

1. Create a simple `/v1/json` endpoint that accepts JSON payload via `POST` method.
2. Parse the JSON into object/struct that is easy to use within the application.
- provide the code that is typical to use in those scenarios for your technology - do not try to optimize it, be productive
3. Serialize the same object back into response.
4. Create a simple `/v2/json` endpoint that accepts the same payload.
5. Parse the JSON into object/struct but this time you can optimize the whole process.
6. Serialize the same object back into response.

{{< hint info >}}
**Requirements**

- application must listen at `3000` port
- provide a Dockerfile for your app (do not push to the registry, just make sure your `docker build ...` works)
- enable logging
{{< /hint >}}

Benchmark will measure:
- CPU usage
- Memory usage
- Performance gain between standard solution and optimized one

## JSON file

[Download JSON file](https://raw.githubusercontent.com/Selleo/rumble/main/src/02/example.min.json) used for payload. Example comes from the [json.org](https://www.json.org/example.html).

## Verification

Run docker image with port exposed to `3000` and try `curl` command:

```
curl -X POST -H "Content-Type: application/json" -d @example.min.json http://localhost:3000/v1/json
```

