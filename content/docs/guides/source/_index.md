---
weight: 2
title: "Source code distribution"
---

# Source code distribution guideline

GitHub repository contains `src/xx` folder where `xx` is a Rumble number.

Each solution should have its own directory and be grouped by technology.

## Recommended folder structure

Following format is preferred:

```
src/01/LANGUAGE/FRAMEWORK[-SERVER]
```

Examples:

```
src/
  01/
    ruby/
      sinatra-thin/
      rails-puma/
    crystal/
      stdlib/
      kemal/
    go/
      gin/
      gorilla/
    elixir/
      phoenix-cowboy/
    javascript/
      ...

```

It's possible that duplicates might appear when few people choose the same technology stack but on different team.
That's acceptable - all of you will need to assign suffix to your folders i.e. `-a`, `-b`.

Solution folder should contain a **tiny** README how to run a project (docker based solutions can only provide docker image tag to run).

## Docker based solutions

If a Rumble requires to create a docker image make sure to use proper format and tagging.
Read more at [Using docker]({{< relref "/docs/guides/docker" >}}).

## Incremental work from Rumble to Rumble

If a current Rumble can be built upon previous Rumble just copy the whole solution to the new folder.
**Do not modify** the old one.
