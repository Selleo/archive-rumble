import { WinstonModule } from 'nest-winston';
import { transports, format } from 'winston';

export function createLogger() {
  return WinstonModule.createLogger({
    level: 'info',
    format: format.json(),
    transports: [new transports.Console()],
  });
}
