# Start:

```
docker build -t app . && docker run -it --init -p 3000:3000 app
```

# Gothas 
- default timeout is set to 30 secs [at the moment deno does not support configuration of this]
- tested on MBP 13" 2021 with M1 Silicon (arm)