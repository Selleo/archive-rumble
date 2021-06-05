---
weight: 3
title: "Docker"
---

# Publishing a docker image to GitHub registry

In order to access [GitHub docker registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-docker-registry) you need to create a personal access token with appropriate permissions.
For more information about working with Docker refer to its documentation.

## Create personal access token

Use the following permissions to access GitHub docker registry:

![permissions](/guides/generate-token.png "Permissions")

## Login to registry

Copy your token and login to docker registry:

```bash
docker login https://docker.pkg.github.com -u YOUR_GITHUB_USERNAME
```

alternatively if you have your token stored in ENV variable you can use:

```bash
echo $GITHUB_TOKEN | docker login https://docker.pkg.github.com -u YOUR_GITHUB_USERNAME --password-stdin
```

Your token will be stored in a file (`~/.docker/config.json`) so you don't have to do it again unless you regenarate the token.

## Build, tag and publish

Preferred naming convention for docker image tags is as follows:

```
docker.pkg.github.com/selleo/rumble/XX-LANGUAGE-FRAMEWORK[-SERVER]:latest
```

For the project located in `src/01/go/gorilla` directory, you can build an image like this:

```bash
docker build . -t docker.pkg.github.com/selleo/rumble/01-go-gorilla:latest
```

Before pushing the image make sure your project works locally:

```bash
docker run --rm -p 3000:3000 docker.pkg.github.com/selleo/rumble/01-go-gorilla:latest
```

Once you are sure you can publish your image:

```bash
docker push docker.pkg.github.com/selleo/rumble/01-go-gorilla:latest
```

Built image should be accessible at: [https://github.com/Selleo/rumble/packages](https://github.com/Selleo/rumble/packages)

