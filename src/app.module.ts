import { Module } from '@nestjs/common';
import { PrismaModule } from 'prisma/prisma.module';
import { StudentModule } from './student/student.module';
import { BullModule } from '@nestjs/bull';
import { STUDENT_QUEUE } from './queues/constants';

@Module({
  imports: [
    PrismaModule, 
    StudentModule,
    BullModule.forRoot({
      redis:{
        host:process.env.REDIS_HOST,
        port:Number(process.env.REDIS_PORT),
      }
    }),
    BullModule.registerQueue({
      name:STUDENT_QUEUE
    }),
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
