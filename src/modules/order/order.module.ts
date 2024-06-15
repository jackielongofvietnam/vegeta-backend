import { Module } from '@nestjs/common';
import { OrderController } from './controllers/order.controller';
import { OrderService } from './services/order.service';
import { OrderRepository } from './repositories/order.repository';

@Module({
  controllers: [OrderController],
  providers: [OrderService, OrderRepository]
})
export class OrderModule {}
