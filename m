Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4CB3EC822
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288914; cv=fail; b=sK07iPSovLl7JyALK0SWRIaoFQBZcRh3kSBXwKLRu9A0WwBLo1r2et7PICT2u7Eh0MvIHlq/UqFw4IUPZwgWvqfbhVV99H3a6hVj/MjnbC8ENx9cUkp5Ka41Dzn3fsIyikQWPWsKLtvJIPmlQLtzgSv+1x/NdnxV6HNkVv/UC/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288914; c=relaxed/simple;
	bh=wCliVYBWdQGiIiiNBpzJ8pw7NTp1MwG8bbccDUkXVwc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mLGHLgLsU0xFK6e8M8SfpmOPQwK/SFzu6VHoH5AA6HXxlDivYLY7OgfodHDXP49zw8UUqqQTrbEL4zGFb+vlbLE6kKwmrvqVJncH62fw69VXd28TLWw1UTHRCoQzQIWgNitKz4DSpC88HyJQ1/2BDrYWekHu6+hetI9JGvrlm34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qA7YGyx8; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qA7YGyx8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q06Vp1nGgYhkm3N8UXS/ONGeJms4V5U5GBz2GPG8h1TeufZXo/hD75oGRo7ygwopo8tKKWjrtfedGqDk+O4iOTEUo9+ekotjmNnJjXR7UlU9PkvnrFzrvAO1Cbg5xdaJU9KqIx0GzFdiz6EsYNXwjD2edfrk6/N9a7h/yeoi9ATfndBflDGTehYCUxOWDe2oQh+3m5lZnQMir+Y2+pzRehar7FnL6rcytNLmXkNKOzshDtEd5SKy3hsTXBlT5gtfhOzGPDJfxmzfNzb6GAOF0wCS6hvR7oQWPlVShadjlTn4BUaBXePmo99pdNWxxRxUZcPKhDatJwuQavhw7EfLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvZbc4/TlXjmGWDlSla0zeOSZpNlpV1NuIZjS2q9lyc=;
 b=l7zx2JIXtKRCg9c/LAxyIC1INTdeH7LOY0epBRLS383Z+fcU3cRfNOcq7KHDg0zM+WzjtVAaFX0P0hduTuw8dTfid2PCk8vg6KybXeBig8I3WmneBiBxyzkRuU//3qaXKbdps+XL8nMqOS1fkFrJP8xghr0AlLGXbAax44hF9kZsYDG61Imqu5kPzDugJHJuvBC7CGVku+PzXyrdqdEW1Fay7Ee4fWLqoGJnw3N56KYDguhe8R1P4FO2wFi9WtCXc9Xut+xnIFvV0J25P5rrSEERPWogwx11jfqErp/Wax0sHcg9AhlzBn6oW/4dDIQMtMlec/f3Aqd1BFJEZKaqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvZbc4/TlXjmGWDlSla0zeOSZpNlpV1NuIZjS2q9lyc=;
 b=qA7YGyx8+4ieQ7nBqLknsEGAeoEjo0Wmf8TkN2dIoO2kgpvCc5utWOeHYw4dJ8xltBIilMoMejWh0jzZX8geBkSmpCD68+7GtyPL8o+wC3rb8TqPaCN7njCvPC5JxvDoKO4GmzcqSTwoGk2L88bsPioGdhgBGzlnQeJkSqE2+COWpolf8fjiK/kIHubXKg2Hr7/jBEyxhrw7qdnpGRolIohP/XyD1KHjoi5vofrH2eVHpVYu0MOt8gNS9jgCQNVSxxzP53GmgPAbv0Ce/g0Ps7U41n9GYwrthNqOI/7xvKoLp2c2K3kojBD/b4Ga92WJP+o5lyVBc2Co6C35MDVZRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by FRZPR04MB12432.eurprd04.prod.outlook.com (2603:10a6:d10:1ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:15:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 12:15:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 06 Oct 2026 20:19:09 +0800
Subject: [PATCH RFC v5 3/6] iommu/arm-smmu-v3: Delay stream allocation to
 inside the mutex
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-smmu-shared-sid-v5-3-169a59c671d3@nxp.com>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
In-Reply-To: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|FRZPR04MB12432:EE_
X-MS-Office365-Filtering-Correlation-Id: 5014daa5-0d2d-4544-0203-08df23a376e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZlGGuXOaoL5RgjQTqL5dZYxefGmfoMnaNAsQxIy0qd+h/HCjsnZfPbZUziYr/M6lfrcTCNpvbKqgQvCk8bvtlkuO6RVLu9uXueEtiU2SjSxmrjAF+5+ROrV4sCzkNjYeD91Qvhj+DfpMznJZgHrfuVbxUm6vDMTS6YBN81CvIQ2ezmtI8Qr634j5fZ7EgJqyXnz7moLeMQi1BDYPbMjitqWd+VI/v9oz5nzAJXsfUJDzerDle/45bHtfBp5xA714s61lPdGiKEOM3TDbjuQP8nwcJAKqkzBjnEE1zw1xBJZhca5W/hsADhX3Y2ndCfhdEkpeED0GBBnAgE0yb0g6plKZuMfDiQ3UUcp3ZwEtPc7492nSpNzF+QeLDJRK2NfocYmOfirHaFggPR4vOM5oxzhmY9+vxFqJJkCdiLX8eXSR0SqH07aupx/asiPBcxW7NJUL8PE3dOD7D3LD3DM+UYj9afiyZWBgyeV40/X4r7tb/EAA3Pk3ZgQVsAN2mfVpJWcYQGJDzJqaGULvXak+Y5oAFbOc4SZOYtkmU026Yeq2rfsV59+jDGOT+tAZ0lf6KgGxpTS9xWQlx3LHx1AfJNhEmTHtKZM2DdgQDGNROdEVnpRzHDJS6n1nQBRohp+NOq17xUyNicHjuin7SwC4DgVBQJbva4sGuSthm8+ya99IxB/msR+OsYlk2T9skF2dp8U8x7CnglX1u8V2/TK+yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTg3Y1VTbGlGVkRicGVsMXBPUis2S1AvcGdkWTBpL3Z2YlZKVkxGeW5YQkc4?=
 =?utf-8?B?eFFsK29YNGV6YzFtMEx2Z015OHpoYkJHQVYwaFZZTlAxL0dYUjR4NmMzR0hv?=
 =?utf-8?B?UDZZTk1WVjJ6dlcxTkxXSWwyZWJHQnMvazk0bE5KUW1WT1krUkdBR3J4azU0?=
 =?utf-8?B?YmxlbVZ4ampUeGpUajd5RmNYZ2lzNzIvc3huanVFK092QUJGaS8xZnA1ZDk5?=
 =?utf-8?B?Q2NhcS9Rdi9hVmc5enFGaFpCZWR0eTRXSEc3cnhORWIvWXBUa3VXSFF4em1U?=
 =?utf-8?B?c1VpU2xYSWxyWHZlc0EzOXN0VFJwOERyTjZ6OTROenpmcDN0V0ZIb1VXTUNZ?=
 =?utf-8?B?dE10VC9DTTI0dktZVnYyRmp4MkhvTDdwRlFZUmJMWXFTeGVZUExXR1FvV2tz?=
 =?utf-8?B?V1RvM3NvK1lTaXl3NStHeE8xNkhGaUZCdnN3VmQ3Y2s4N2dkT3RhaDhIOGF3?=
 =?utf-8?B?V0FNRzNvYUpkTm92UUJJSGlzSlJ1ZWprOFRhOW54UlhsRExsUytvRGluZG5i?=
 =?utf-8?B?Tm5WOTJWVDdCRlExYzhsaENrS1pQSzc4UForQlFWbUs3a0RUZ3AyVHJvRzRF?=
 =?utf-8?B?cEk2WElGOURyZGxIQ09pSGIySGZYR0FWMnFhRnJhOE1jRVNkbDdlSmxMNzdL?=
 =?utf-8?B?dFR3cFhndEp1ZHhiNjBKSXlxK3h4U2ZYRXdrVzE0d0lUTG14eEdjNE9GQ0w3?=
 =?utf-8?B?cVJ6MHlNSHRBRjh3WFlSRVJidDl0bGdHQlA0ZVFpbHJhWmc5dTY5U1E1UFgz?=
 =?utf-8?B?d1VCdXgyeS9aWCszZFJUTW5Ed0FkMFU0akl1YWJGb21KVmNDbjdOYXFJdW56?=
 =?utf-8?B?U3M1R3hmM1UyS0NKMk1leGJ0WHZzSzg3eFV1WUhwN0NHZ244aGtkeEt3Ukly?=
 =?utf-8?B?MlA5QW14NUZHRzkrdmR1UzgydVRIVGFjeFVudmZrcDRQRXRxd2Mydlh3aDNM?=
 =?utf-8?B?VHRvL3dGVGlhMzVidllVaE1qTS83dGl0bVFtUmpKbE5OMy94QzQ0Vkg0Y2FV?=
 =?utf-8?B?MlBYY2lrZ3RFdkhKT214bExjUnhWcEd3b3p4QVdnKzZ0MDBGUlozNHd2UmI1?=
 =?utf-8?B?WVZrSE5GRjVSdEhFck1MK0FvT0FIZUZ5MGdEaGlncjNvSUhXdmZPYXpNT1NR?=
 =?utf-8?B?MGRRWnp4cnlKWVdaZStxZDVQakxxRjdDdVJ3TEdITzB3cTVOeGYvUTZQOTNR?=
 =?utf-8?B?eG93b3dieWp3aGxZdHMvZDRkREticmJBb1JxWGtHd0RSSEZDZytkdCtnMEht?=
 =?utf-8?B?UHE2U25BUTNDK2tUQThoQkpFNjBqWVN6U2lMRU5oU1VUdVVTZ3FWaWJwZWJy?=
 =?utf-8?B?a0IraTBxc0ZQSXFMNkpJOUc0OEZoQ2dXRlZFYWp2bG9GZHFwa09PM3BRdG13?=
 =?utf-8?B?RGUva0ZpU05vbENIeW9ySkVMaE1yeUNCRnhES1djcjlpTi9ScjVwTjdBMEZq?=
 =?utf-8?B?UEowTFlLWEV3MWdrQjFVWkNmME1SVlFZeXJNMG83eU1IdU8xV2JYVm9YbU5a?=
 =?utf-8?B?UXhZSUxPMHV4U1drczdjTEZzV25qRXdZL1MxdzNWRno5NUJXNElGTXk2VEpU?=
 =?utf-8?B?Mk02MUpuME9NOTU0R0NQRGlPM21lYzRJUjcrd3F2aENLTDlmOVRBKzVsSjB6?=
 =?utf-8?B?eUx3RmxHYUk1Zmc3UWQvemZDQWpiYm1BNnovUTJXd2h6blNNc0ExblFNeG8v?=
 =?utf-8?B?dHAwcnQ3eGhGUkZxdmVKNTZWaDNBdWdvVC92UjJ2RDFlRVpYY0hCeEhmdlpF?=
 =?utf-8?B?c1YyL01DdERNemNrMExGMUhic0ZFMVpXc2ovMncrUkxWS2RVYlBabHgzUVo3?=
 =?utf-8?B?K2ZhVXBlRUp0OTlDaTFMZmhZTUpqNVpvNEdtYnhEUnAySFZPejhCYzZSdEcz?=
 =?utf-8?B?YVBueUZKSE9pdFVZSnV1TktZVXdHUkpDcmplUW1CSjhGUkZyb3VQbFFTVzFm?=
 =?utf-8?B?QURGQUpFdXFmeUpDNHFGdC8xL0Ria3R3Q1c1RzNCanB5NHVzYjlSelJmN1Bu?=
 =?utf-8?B?Y3dzbE14VUNVTmNvWWRBSE9ONG9jK1lnZ3Y0dWUxMFlVQVc1SEtHQ2MySVRZ?=
 =?utf-8?B?WFVVM0dvSldUMXJXYTJpNzgxU0FZWm5nR2RCbDBCc2lsbGtZQ2U0Tm9uWFlJ?=
 =?utf-8?B?N2lSNGhpcGpmb3lDZnVhUkc5NjVid3hiM1l1ellUVWt5QVlkWGF6M3diVStR?=
 =?utf-8?B?YXdJZGtZNW5PVHVnQVcyL3NLbnVENHlDSThCYnBiZVdYRm4rRHhPUk9Mc1d3?=
 =?utf-8?B?WlV2OFBnTXFFRFNzZ0NpcU8vWGhRWUNmQWJwcnROQ2U5SUgwR0RCcjRZcW1T?=
 =?utf-8?B?U1JPcDk0NDRWMkhaNGxhanhkOXlqZm9yRFlaNEg0Wkt5SHB1Mk16ak5KZGVp?=
 =?utf-8?Q?1ildFUgioXno4y1FGmM6eLCtyFsIr3vDPCE7E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5014daa5-0d2d-4544-0203-08df23a376e5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:15:09.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0QqaboRpu7IgUp0q6cSZ9SpzuyCBPETtnEDr7+UnC/DMTl3eMO/rA0gSXpKs8WBUcy5F4ALl+tDF7CD2zX3VhRqJToh7eWRhVGqZHSyzpTD6HZHcV6GFlbxXXAYAj2E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR04MB12432

From: Peng Fan <peng.fan@nxp.com>

Move arm_smmu_stream allocation from upfront (before the mutex) into
the mutex-protected loop in arm_smmu_insert_master(). Instead of
pre-allocating all stream objects and then inserting them into the RB
tree, first look up whether the SID already exists in the tree. Only
allocate and insert a new stream when no existing entry is found, then
avoid unnecessary allocations when bridged PCI devices produce duplicated
IDs. Prepare the code for a subsequent patch that will reuse existing
streams when stream IDs are shared across masters.

The sort is also moved after the mutex section, since streams are now
populated inside the loop rather than beforehand.

Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 102 +++++++++++++++-------------
 1 file changed, 53 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9d34eac196a65..69c2c3596b06a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4110,52 +4110,29 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream;
-
-		new_stream = kzalloc_obj(*new_stream, GFP_KERNEL);
-		if (!new_stream) {
-			ret = -ENOMEM;
-			goto out_free_streams;
-		}
-		new_stream->id = fwspec->ids[i];
-		new_stream->master = master;
-		master->streams[i] = new_stream;
-	}
-
-	/* Put the ids into order for sorted to_merge/to_unref arrays */
-	sort(master->streams, master->num_streams,
-	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
-	     NULL);
-
-	/*
-	 * Clear after sorting: RB_CLEAR_NODE() records the node's own address,
-	 * which sort_nonatomic() invalidates by relocating the entries.
-	 */
-	for (i = 0; i < fwspec->num_ids; i++)
-		RB_CLEAR_NODE(&master->streams[i]->node);
-
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = master->streams[i];
+		struct arm_smmu_stream *stream;
 		struct rb_node *existing;
-		u32 sid = new_stream->id;
+		u32 sid = fwspec->ids[i];
 
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
 			break;
 
-		/* Insert into SID tree */
-		existing = rb_find_add(&new_stream->node, &smmu->streams,
-				       arm_smmu_streams_cmp_node);
+		existing = rb_find(&sid, &smmu->streams,
+				   arm_smmu_streams_cmp_key);
 		if (existing) {
 			struct arm_smmu_master *existing_master =
 				rb_entry(existing, struct arm_smmu_stream, node)
 					->master;
 
 			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
+			if (existing_master == master) {
+				master->streams[i] = rb_entry(existing,
+					struct arm_smmu_stream, node);
 				continue;
+			}
 
 			dev_warn(master->dev,
 				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
@@ -4163,45 +4140,72 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 			ret = -ENODEV;
 			break;
 		}
+
+		stream = kzalloc_obj(*stream, GFP_KERNEL);
+		if (!stream) {
+			ret = -ENOMEM;
+			break;
+		}
+		stream->id = sid;
+		stream->master = master;
+
+		rb_find_add(&stream->node, &smmu->streams,
+			    arm_smmu_streams_cmp_node);
+		master->streams[i] = stream;
 	}
 
 	if (ret) {
-		for (i--; i >= 0; i--)
-			if (!RB_EMPTY_NODE(&master->streams[i]->node))
-				rb_erase(&master->streams[i]->node,
-					 &smmu->streams);
+		for (i--; i >= 0; i--) {
+			int j;
+
+			if (!master->streams[i])
+				continue;
+			/* Skip duplicated SID pointers already freed */
+			for (j = 0; j < i; j++)
+				if (master->streams[j] == master->streams[i])
+					break;
+			if (j < i)
+				continue;
+			rb_erase(&master->streams[i]->node, &smmu->streams);
+			kfree(master->streams[i]);
+		}
 		mutex_unlock(&smmu->streams_mutex);
-		goto out_free_streams;
+		kfree(master->streams);
+		kfree(master->build_invs);
+		return ret;
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
-	return 0;
+	/* Put the ids into order for sorted to_merge/to_unref arrays */
+	sort(master->streams, master->num_streams,
+	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
+	     NULL);
 
-out_free_streams:
-	for (i = 0; i < master->num_streams; i++)
-		kfree(master->streams[i]);
-	kfree(master->streams);
-	kfree(master->build_invs);
-	return ret;
+	return 0;
 }
 
 static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
 	int i;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
-		if (!RB_EMPTY_NODE(&master->streams[i]->node))
-			rb_erase(&master->streams[i]->node, &smmu->streams);
-	mutex_unlock(&smmu->streams_mutex);
+	for (i = 0; i < master->num_streams; i++) {
+		int j;
 
-	for (i = 0; i < master->num_streams; i++)
+		/* Skip duplicated SID pointers already freed */
+		for (j = 0; j < i; j++)
+			if (master->streams[j] == master->streams[i])
+				break;
+		if (j < i)
+			continue;
+		rb_erase(&master->streams[i]->node, &smmu->streams);
 		kfree(master->streams[i]);
+	}
+	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
 	kfree(master->build_invs);

-- 
2.34.1

