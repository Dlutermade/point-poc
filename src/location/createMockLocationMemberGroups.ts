import client from "../libs/client";
import { mockMemberIds } from "../testVal";
import _ from "lodash";
/**
[
  {
    "id": "clwsx9ij00000ptfbzbyd07nf",
    "name": "Mock Location Member Group One",
    "ownerId": "pelsbhn8uywddm208hzcryq5",
    "createdAt": "2024-05-30T07:16:44.940Z",
    "updatedAt": "2024-05-30T07:16:44.940Z",
    "members": [
      {
        "id": "q98233jsdvmwgyf4ri2c0nrb",
        "name": "Mock Location Member Two",
        "locationId": "pelsbhn8uywddm208hzcryq5",
        "createdAt": "2024-05-30T06:52:38.045Z",
        "updatedAt": "2024-05-30T06:52:38.045Z"
      },
      {
        "id": "i2ez5tq2rryiyela0kkdajkl",
        "name": "Mock Location Member Three",
        "locationId": "pelsbhn8uywddm208hzcryq5",
        "createdAt": "2024-05-30T06:52:38.045Z",
        "updatedAt": "2024-05-30T06:52:38.045Z"
      }
    ]
  },
  {
    "id": "clwsx9ijc0001ptfb3urev676",
    "name": "Mock Location Member Group Two",
    "ownerId": "pelsbhn8uywddm208hzcryq5",
    "createdAt": "2024-05-30T07:16:44.940Z",
    "updatedAt": "2024-05-30T07:16:44.940Z",
    "members": [
      {
        "id": "q98233jsdvmwgyf4ri2c0nrb",
        "name": "Mock Location Member Two",
        "locationId": "pelsbhn8uywddm208hzcryq5",
        "createdAt": "2024-05-30T06:52:38.045Z",
        "updatedAt": "2024-05-30T06:52:38.045Z"
      }
    ]
  }
]
 */
export async function createMockLocationMemberGroups() {
  const randomLocationMemberIdGroups = [
    _.sampleSize(mockMemberIds, 2),
    _.sampleSize(mockMemberIds, 1),
  ];

  if (
    _.isEqual(randomLocationMemberIdGroups[0], randomLocationMemberIdGroups[1])
  ) {
    randomLocationMemberIdGroups[1] = _.sampleSize(mockMemberIds, 1);
  }

  await Promise.all(
    randomLocationMemberIdGroups.map(async (memberIds, idx) => {
      await client.locationMemberGroup.create({
        data: {
          name: `Mock Location Member Group ${idx === 0 ? "One" : "Two"}`,
          owner: {
            connect: {
              id: "pelsbhn8uywddm208hzcryq5",
            },
          },
          members: {
            connect: memberIds.map((id) => ({ id })),
          },
        },
      });
    })
  );
}
