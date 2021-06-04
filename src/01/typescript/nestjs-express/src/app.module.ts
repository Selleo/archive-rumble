import { LoggingInterceptor } from '@algoan/nestjs-logging-interceptor';
import { Module } from '@nestjs/common';
import { APP_INTERCEPTOR } from '@nestjs/core';
import { HelloModule } from './hello/hello.module';

@Module({
  imports: [HelloModule],
  controllers: [],
  providers: [
    {
      provide: APP_INTERCEPTOR,
      useClass: LoggingInterceptor,
    },
  ],
})
export class AppModule {}
