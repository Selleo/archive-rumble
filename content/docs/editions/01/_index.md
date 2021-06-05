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
