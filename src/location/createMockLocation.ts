import { createId } from "@paralleldrive/cuid2";
import client from "../libs/client";
/*
  {
    id: "pelsbhn8uywddm208hzcryq5",
    name: "Mock Location One",
    createdAt: 2024-05-30T06:39:14.779Z,
    updatedAt: 2024-05-30T06:39:14.779Z,
  }

  {
    id: "clwsvxaax0000dfc97nyqz6jc",
    locationId: "pelsbhn8uywddm208hzcryq5",
    createdAt: 2024-05-30T06:39:14.793Z,
    updatedAt: 2024-05-30T06:39:14.793Z,
    campaign: {
      id: "clwsvxaax0000dfc97nyqz6jc",
    },
  }
*/
export async function createMockLocation() {
  const location = await client.location.create({
    data: {
      id: "pelsbhn8uywddm208hzcryq5",
      name: "Mock Location One",
    },
  });

  const campaign = await client.locationPointCampaign.create({
    data: {
      location: {
        connect: {
          id: location.id,
        },
      },
      campaign: {
        create: {
          id: "clwsvxaax0000dfc97nyqz6jc",
        },
      },
    },
    include: {
      campaign: true,
    },
  });

  return {
    location,
    campaign,
  };
}
