import { Controller, Get, Header } from '@nestjs/common';

@Controller()
export class HelloController {
  @Get('hello')
  @Header('Content-Type', 'text/plain')
  async hello() {
    return 'Hello';
  }
}
