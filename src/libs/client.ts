import { PrismaClient } from "@prisma/client";

const client = new PrismaClient();

await client.$connect();

export default client;
