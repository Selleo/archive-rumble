# Rumble

https://rumble.selleo.app

## Development

Use asdf version manager and install hugo.

```
asdf plugin-add gohugo https://bitbucket.org/mgladdish/asdf-gohugo
asdf install  # you must be in root repo folder
asdf reshim gohugo
```

Start server:

```
hugo serve -D
```

## Deployment

```
AWS_PROFILE=... AWS_BUCKET=... ID=... make deploy
```

