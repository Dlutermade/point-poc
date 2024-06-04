import { createMockLocation } from "./location/createMockLocation";
import { createMockLocationMemberGroups } from "./location/createMockLocationMemberGroups";
import { createMockLocationMembers } from "./location/createMockLocationMembers";
import { manualAddPointToMembers } from "./point/manualAddPointToMembers";
import {
  needCreateMockLocation,
  needCreateMockLocationMembers,
  needCreateMockLocationMemberGroups,
  needManualAddPointToMembers,
} from "./testVal";

if (needCreateMockLocation) {
  const { location, campaign } = await createMockLocation();
  console.log(location, campaign);
}

if (needCreateMockLocationMembers) {
  const data = await createMockLocationMembers();
  console.log(data);
}

if (needCreateMockLocationMemberGroups) {
  const data = await createMockLocationMemberGroups();
  console.log(data);
}

//

if (needManualAddPointToMembers) {
  const data = await manualAddPointToMembers({
    amount: 100,
    name: "Manual Add Point One",
  });
  console.log(JSON.stringify(data, null, 2));
}
