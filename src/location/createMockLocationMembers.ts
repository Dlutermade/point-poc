import { createId } from "@paralleldrive/cuid2";
import client from "../libs/client";

/*
  [
    {
      id: "xllvl9am7vp4p3xk5qy0vg89",
      name: "Mock Location Member One",
      locationId: "pelsbhn8uywddm208hzcryq5",
      createdAt: 2024-05-30T06:52:38.045Z,
      updatedAt: 2024-05-30T06:52:38.045Z,
    }, {
      id: "q98233jsdvmwgyf4ri2c0nrb",
      name: "Mock Location Member Two",
      locationId: "pelsbhn8uywddm208hzcryq5",
      createdAt: 2024-05-30T06:52:38.045Z,
      updatedAt: 2024-05-30T06:52:38.045Z,
    }, {
      id: "i2ez5tq2rryiyela0kkdajkl",
      name: "Mock Location Member Three",
      locationId: "pelsbhn8uywddm208hzcryq5",
      createdAt: 2024-05-30T06:52:38.045Z,
      updatedAt: 2024-05-30T06:52:38.045Z,
    }
  ]
 */
export async function createMockLocationMembers() {
  const data = await client.locationMember.createMany({
    data: [
      {
        id: createId(),
        locationId: "pelsbhn8uywddm208hzcryq5",
        name: "Mock Location Member One",
      },
      {
        id: createId(),
        locationId: "pelsbhn8uywddm208hzcryq5",
        name: "Mock Location Member Two",
      },
      {
        id: createId(),
        locationId: "pelsbhn8uywddm208hzcryq5",
        name: "Mock Location Member Three",
      },
    ],
  });

  return data;
}
