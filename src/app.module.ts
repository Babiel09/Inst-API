import { Module } from '@nestjs/common';
import { PrismaModule } from 'prisma/prisma.module';
import { StudentModule } from './student/student.module';

@Module({
  imports: [PrismaModule, StudentModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
