import type { Server } from 'http';
import { NestFactory } from '@nestjs/core';
import { createLogger } from './utils/createLogger';
import { AppModule } from './app.module';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';

async function bootstrap() {
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter(),
    { logger: createLogger() },
  );

  const server: Server = await app.listen(3000);
  server.setTimeout(30_000);
}
bootstrap();
