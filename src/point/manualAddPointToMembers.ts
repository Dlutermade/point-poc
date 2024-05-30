import client from "../libs/client";
import { formatISO } from "date-fns";

export async function manualAddPointToMembers(point: {
  amount: number;
  name: string;
}) {
  const expiredAt = formatISO(new Date(2024, 5, 30, 23, 59, 59));

  const data = await client.locationPointIncomeRecord.create({
    data: {
      eachAmount: point.amount,
      name: point.name,
      campaignId: "clwsvxaax0000dfc97nyqz6jc",
      type: "MANUAL",

      issuedPoints: {
        create: [
          {
            ownerId: "xllvl9am7vp4p3xk5qy0vg89",
            expiredAt,
          },
          {
            ownerId: "q98233jsdvmwgyf4ri2c0nrb",
            expiredAt,
          },
          {
            ownerId: "i2ez5tq2rryiyela0kkdajkl",
            expiredAt,
          },
        ],
      },
    },
    include: {
      issuedPoints: true,
    },
  });

  return data;
}

// ------
/*
{
  "id": "clwsy0fb70001krj8bncdo3bx",
  "eachAmount": 100,
  "name": "Manual Add Point One",
  "campaignId": "clwsvxaax0000dfc97nyqz6jc",
  "fromScheduleId": null,
  "fromExpenditureRecordId": null,
  "type": "MANUAL",
  "createdAt": "2024-05-30T07:37:40.484Z",
  "updatedAt": "2024-05-30T07:37:40.484Z",
  "issuedPoints": [
    {
      "id": "clwsy0fb80003krj8vqsp3szd",
      "expiredAt": null,
      "ownerId": "xllvl9am7vp4p3xk5qy0vg89",
      "fromRecordId": "clwsy0fb70001krj8bncdo3bx",
      "createdAt": "2024-05-30T07:37:40.484Z",
      "updatedAt": "2024-05-30T07:37:40.484Z"
    },
    {
      "id": "clwsy0fb80004krj8pfonby5f",
      "expiredAt": null,
      "ownerId": "q98233jsdvmwgyf4ri2c0nrb",
      "fromRecordId": "clwsy0fb70001krj8bncdo3bx",
      "createdAt": "2024-05-30T07:37:40.484Z",
      "updatedAt": "2024-05-30T07:37:40.484Z"
    },
    {
      "id": "clwsy0fb80005krj8ny0sjdmc",
      "expiredAt": null,
      "ownerId": "i2ez5tq2rryiyela0kkdajkl",
      "fromRecordId": "clwsy0fb70001krj8bncdo3bx",
      "createdAt": "2024-05-30T07:37:40.484Z",
      "updatedAt": "2024-05-30T07:37:40.484Z"
    }
  ]
}
*/

// ------
/*
{
  "id": "clwsygopq0001qzukce4r7god",
  "eachAmount": 100,
  "name": "Manual Add Point One",
  "campaignId": "clwsvxaax0000dfc97nyqz6jc",
  "fromScheduleId": null,
  "fromExpenditureRecordId": null,
  "type": "MANUAL",
  "createdAt": "2024-05-30T07:50:19.167Z",
  "updatedAt": "2024-05-30T07:50:19.167Z",
  "issuedPoints": [
    {
      "id": "clwsygopq0003qzukcgyn1oec",
      "expiredAt": "2024-06-30T15:59:59.000Z",
      "ownerId": "xllvl9am7vp4p3xk5qy0vg89",
      "fromRecordId": "clwsygopq0001qzukce4r7god",
      "createdAt": "2024-05-30T07:50:19.167Z",
      "updatedAt": "2024-05-30T07:50:19.167Z"
    },
    {
      "id": "clwsygopq0004qzukl00k4ig8",
      "expiredAt": "2024-06-30T15:59:59.000Z",
      "ownerId": "q98233jsdvmwgyf4ri2c0nrb",
      "fromRecordId": "clwsygopq0001qzukce4r7god",
      "createdAt": "2024-05-30T07:50:19.167Z",
      "updatedAt": "2024-05-30T07:50:19.167Z"
    },
    {
      "id": "clwsygopq0005qzuk8wnubora",
      "expiredAt": "2024-06-30T15:59:59.000Z",
      "ownerId": "i2ez5tq2rryiyela0kkdajkl",
      "fromRecordId": "clwsygopq0001qzukce4r7god",
      "createdAt": "2024-05-30T07:50:19.167Z",
      "updatedAt": "2024-05-30T07:50:19.167Z"
    }
  ]
}
*/
