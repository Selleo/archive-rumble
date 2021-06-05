import { WinstonModule } from 'nest-winston';
import winston from 'winston';

export function createLogger() {
  return WinstonModule.createLogger({
    level: 'info',
    format: winston.format.json(),
    transports: [new winston.transports.Console()],
  });
}
