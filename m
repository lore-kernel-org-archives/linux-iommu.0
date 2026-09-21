Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769548EC6E
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990281; cv=fail; b=Hf3svLC7vBN9CsrYL3vWsRgsM9i8eEI3GAPcTctMpdJwAIYyo3un5hI1uvVxPogx4mmJ/E4LPtz/GrLufRJ22G/5LiiayQverr2OeUe6xgXIJYK3x++al+rfhxQKDnzA7MlZRGEdL6JL+1U3EiZTFZ5NXNmTCFuPRsbJIezuYig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990281; c=relaxed/simple;
	bh=w76LrviwoRXi1DOlKR7MnWMDfpZ4qGj3rLacMTnd53g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jNYaFSn46PqX+77Rg7OV13RZge8AmPpksMH71SS9JV2sN5LhzEad9eA7rmu1fcufYge+jNrD5OiROgdCp1wHWFSXhIrABwWvmXIvD+b5PrjUFZiH5vUPSwpIhGCli9cIBXBqI2vv7/j0R6UwDZikW+TfTshfHbzPvreLsa6nw/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JtzhnJ5Y; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JtzhnJ5Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgfGuraVCqFpUHUTAuekBbZqGkIctaBANUgLNI0U4ZdkgS/ghUIIYWOZyzji44w+tzl40W3Vba8S4LUVAB2kM3BOCYwevqjrZlp9YVWj+excIr4bBaMTt+1dOphUhVz6H429I5ygtDCpksPwQCZj/rJA8lPl6LftUJ9hTxIUzIwIMkYvmitvbPyHHeVlJpFGdYtBEYc7cx2qL3/Fw/yCanza/UHzYN3LnvaOPaq5C0gJbhCWLuystMLqInMSDHUzhdGhuhK47ytNArm7Y6NJe2gtBzRMtS4fQGaZJhqj+aOuLgNWfP5aZZ2/9O3MI0y/B8px270RSSvApE7NEGySHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYR+CCfe7Nse5TyLdV8R6PaT5x5yrAjUFlHn+dCy7yU=;
 b=K1B8VFTMvu/8c80vmRnV8mnXyf8fB5YjSNMEh5uUWEirudhMH7S/GMhWM0hlgmGVzE9mDoBGXa2rZkCTKI63fP8v1dMlhV0VmrLfEB/4yUnIM/ODCU5lHr34HzHbew8tlsFGGc9J4BC5pd4vTwG2xGDk/xNVxlwcDhpKCXSGFfGCwj+4E+m50rS8hvRX70SNUC5HkvBWxXuxDaw/cjFrV6pbT7rPpK8XVC8GkR0w+fEV74wDlRoQ4tgEn+hVhPqVXUy3wn7ge2R/TdEilhXsGXV/nky9t0dN1n6+9pAp6KDXI5NT5fu9kTH7+GIMKHcQ08QO98TxbwXTrMmLmY6uaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYR+CCfe7Nse5TyLdV8R6PaT5x5yrAjUFlHn+dCy7yU=;
 b=JtzhnJ5YpT41EUSmZoTz1P+MMuczpvwWT15MtwUzgi3dme2MXKguSJ+rFvkto8kSU0ij1+tTJVjerin95+zDju22PPnDc/xDxAWD7xpGjkcIj0N3B1VvOF8YeF65xVtkKgxxreSnNMRdih5wQbCgJJPjbDe7pq5DLZJEgxe28CJ1HA0zfjouyBwo8gC/v091HrSAkE9lzQ725IGpVhYI6NLwvoStb/OQLqEtojTwkipPVND0OaEveqPIh3js8Do1ekTroHz23Zwwv6NcSUPFDX8ToAWEK/hiWxTjCKxiYv+tSnvLlyRwzfDHR36N0jlSFUgoRFKVl/1jW9hwkEC6Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB10637.eurprd04.prod.outlook.com (2603:10a6:800:25f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:31:16 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:31:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 21 Sep 2026 19:35:00 +0800
Subject: [PATCH RFC v2 1/4] iommu/arm-smmu-v3: Convert streams from RB tree
 to XArray
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-smmu-shared-sid-v2-1-4b656ce68178@nxp.com>
References: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
In-Reply-To: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5P287CA0043.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB10637:EE_
X-MS-Office365-Filtering-Correlation-Id: 67741980-5d52-4398-8060-08df17d3d955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|19092799006|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ijmPW31CZQO5l0bGL3MFCbE/hDecU3ictjC7ThYh96n23AUGJyOGd54L3dqeok4CxSA3u9iHB3gD484RIlL1lhNuDXdVLeIcWGKSB1rXlpa5RsWJmsHWB2prvBLcBf1FhK7DyY9c+WkjSMxHG+haW+QEfKo+gAaKtbvemQ++hrC6XzL6C1rvKZ6E1zfR2R+7pEGjHPFm4udjZgTTywHw/SRbmKSIdunsS+vtYXKVnFfAepRYj7r3DHU7OWm8SoOj2w7JoL8S4X2m7En9udOvW3xV+muA6amHKum0b6bSt5/PYrpudd9P9MUhcEM/wFwNPdAG6lALisgmz4n94lRy0653PDII9RJ9aH6CQTnO7F4I2p3UZy8tawLQ2BEOfvQ2M7uuQpvSuBTqYY8YSs8njPpocCdQKh9gP6rEVZWIUOtF/BnI6xzw3p7SpU6WuTZcTitAtrIRl9MpFaVxPZQpOZtUb6ypJax2y7obNqP28EkaMbsg+hlGahKygouD92s9HjuIJM34KM7XewR0llzauIvGGUozsVlsYPxejYdTc99cwujHtFjooaFoRvgssG6WO2xeuvTk2x85kVpCSUD6p7ZfdI3+1vwbVOMZ3lk2G8GDrmOZRZZ02qJozsggQsIWtxOna0izZknHYNtWii4kr+Ed2iOD5W7a1jv+GQgBmAo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THRtMndJZm9Yc2FqaWxQamVhNkdqT2lidFJ6dThZNHg1YVpzdUwyQ013VkZ6?=
 =?utf-8?B?cm1mUHVpVnh0cEJaYjEvN3hEczR1M05nRk94TkRpMGx2aDNFWEhUN3dvUEtk?=
 =?utf-8?B?NzJvT256SFZFcStDWU5vaVhlY1c5a2tLVGpxV202bW9sTVFvN0oxV2M4b3NT?=
 =?utf-8?B?QThXU1p2V2hIc0Q2WHVmbm40eHNOb2NZMEFpUHVQY0ZvQ2lkU0dTV0NITDJU?=
 =?utf-8?B?SlhyMkZDU3VGaW9tRXhlcWJ4VkcxdEt0cUVva0pmTnBydFo0K3ZxNGl5ek9D?=
 =?utf-8?B?S1dZekIxdzlOUzVEaThJSzRrR1JkTTJ0R1llUFFrWkNhdEt5WjJwVUdqQXBR?=
 =?utf-8?B?b2JZWEY1bzFSaFU1eHFKRE0xdFZIODYxVlhCbUJqSXhkZzJtUXpoOUlxcTFn?=
 =?utf-8?B?TXRlS3lndW44dGJWck1maDY3YnlRZWZqZnNTL2M2bkgyRzNZaHJFTS8yT0dR?=
 =?utf-8?B?d2N3N2g3UXEraE5ERTg1U2V2TzZjS0dsWmlyZzVYbHpNUUpjRHBMTyt4S1Ez?=
 =?utf-8?B?NEVWZEpkOW1nVGg5T1FNOHl6L0NKa253bTY0eWF4RUcxK1RrQlBJRko2cSsw?=
 =?utf-8?B?S1JDQ2d3dWd2STEvbXlyUnZCWkd5U2NoK1lVQ2M5VVhCVWVWWVdhTi9tKzRL?=
 =?utf-8?B?U1JoTWF0RWk5bEQrTWNyekpzOG1ObElTc28xb2JwRlJudytHV3dGTEtOTFlD?=
 =?utf-8?B?MDhmMGJZR2cxRUlXNUw2VGwveVkxVktnNkgxQWdxUkNNRlpMdTZVR2RWS3A0?=
 =?utf-8?B?OVNZZXc0U2s3RlhUZkpsVzBmeGxFWjRLRmNHM1VyclNvK1lYWE1OYlIwZDRZ?=
 =?utf-8?B?aXBacFVjNUQxRllCOUdrWW9GQ0JScms3RTgwajJQQlpLRjMyRVU5bDE2eENx?=
 =?utf-8?B?VDRSTzNjV3Q1bXR4cWZURld4enAzOHp4U204L1lpcnZFTUJ4aTB3ZHNPejR6?=
 =?utf-8?B?eEt4NzdpWU5MNlBIVDBRMUdWd0ZaQlQ1UThNaEJOdHVSbk9wUE1ZUG05OUNh?=
 =?utf-8?B?c1Qva3hxbFlTczlZM2pEN1JZVUhnNThVaXMwQTMxVmFLWTZJbXIzdXN4Yy80?=
 =?utf-8?B?RjFyNXBuSEpBVS9OUzd5aVpwUWFRUldlVy9jNUZPR2xTak9ERnVmWW9rTDVB?=
 =?utf-8?B?bElIY1E4TVlQd0h3cERObnhuTjBEUFI4TmFEV21PeG8xU2pXejZtSVVGZlZu?=
 =?utf-8?B?aE05UGQwajVwOHV1WFFsQXRDNmJzTllxSkNyVGFEU2NqWGJMYXJGY0g0bDdn?=
 =?utf-8?B?bVFLd3hHc0JCbXRTQ1hWelBrTlQ5cDR3Q0NQVG1SQU5ocUhQVUdSTGJvRG4w?=
 =?utf-8?B?Nzhrbm1PbTVITGw1UHVwV2RjQWd4Rm5SU1pYd0l0aklwNXRpSHBNajhJalIy?=
 =?utf-8?B?bG1kQmxtUkxZNU8yd1ZjdVVFcWNiUGQ1OWR0a1E3Ri9DNjhOM3BnaDhCOVhP?=
 =?utf-8?B?Z2w5akVtMkNlYlQrb0lwRTVid1F5RUxGanNsNmY5M2c4VTlWbUp4elk4OVMv?=
 =?utf-8?B?OUVPWDMyOXBFc1QvOEJpK1Y5NEw0NlYxMkxSR0tPQWtlck11YmsrMTdoS0dv?=
 =?utf-8?B?WnVjMHg2Szh4V0s5RUYxM1duU2lhREs3aTB6KzBXTjRZOWszVkNhZERJUGZo?=
 =?utf-8?B?UkNNZUsyNDFDWGc4ZWJKSmVXSlFrUDNCc2NiUkZ3Y3FjQ092V2pwSzdIOThl?=
 =?utf-8?B?WVY1dDB2bVY5d2dYeFZjYkhWK3hIYlYxZDhZWmZvNnJ1czcwcW55V3crdWtK?=
 =?utf-8?B?U0krZ3NFYmFRRkhCV2tTTC9zV1VWYkZ0djBEbFFzbTlCbG5FUmh0bDhoamhL?=
 =?utf-8?B?TnhsTHpnZFlWcGlSL2N5TFJTa25ua2hQVUZJc3Z1WnlFRFVjeEpxZ1Brck1l?=
 =?utf-8?B?MmJEeEtZeStOMGw0VUMrYVVWTy80bTljN3AwZEVpamZWMEx4R1p1MFhRWHlZ?=
 =?utf-8?B?Tk1ZMnZSOUd3dkhobVUvU2h3cm0rNEsxVmU5NSt3Q0lyaGN2c3dwNU5lN2JN?=
 =?utf-8?B?TmxZV2hRTVNFWW11bm9lWENpYzZIWUxYZ1h5dnN5NFJQYS9iNEQ5NGlzOHlh?=
 =?utf-8?B?T3U2a0NEMHlDTENuSXNmYTJVY3RxUGNZZUhTa3NHTmw2Y0hqYURGL1dJQnow?=
 =?utf-8?B?cXFmR2JyNXdOTFh6QW1aSjVWbllybytCZHB5dVFNUlUwMGtjdVZYdjJkUmdK?=
 =?utf-8?B?OFhTdjVKMmRZK0RhSmdDeVI1dmt3RFljay9sNkVXaDViT3NrREJwQ2cwTzR0?=
 =?utf-8?B?ekpPQ09pU2NDd3YxK3EzNkpkcGdHZzZlZXZrUGRFUDY3MXNJV3lJUTlDckNO?=
 =?utf-8?B?djZ4eU83N2JVRHJRSUpTVWpMeGhtM1JvbmJadmsvN2s3WmkzbDJUa0p5V3h3?=
 =?utf-8?Q?hf8DVKARn4wPkYtIX4Akksx0rsRsY3cnjfJU6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67741980-5d52-4398-8060-08df17d3d955
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:31:16.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9f6ugbOgxlJTMoZoeYAVzvh9GlbVFleUk3mLed8gyzeMHrcc23pQ2DrOL8ONHQUCZREA87h4Z0WE8E6TY1+tyCGoKRj9BJ0WOd3ZgMnlf9G4jL3n42DLBOcn1n5/lGA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10637

From: Peng Fan <peng.fan@nxp.com>

Replace the smmu->streams RB tree with an XArray for SID ->
arm_smmu_stream lookups. The existing streams_mutex serialises all
accesses (both xa_store/xa_erase and xa_load), protecting the lifetime
of returned pointers against concurrent arm_smmu_remove_master()
without requiring RCU grace periods. A mutex (rather than xa_lock) is
needed because several paths sleep while the lock is held:
dmam_alloc_coherent(GFP_KERNEL) in arm_smmu_init_sid_strtab(), and
down_read() inside iommu_report_device_fault().

This removes the RB tree comparators, the rb_node from
arm_smmu_stream, and simplifies duplicate-SID handling for bridged PCI
devices.

No behavioural change intended; preparation for shared-SID support.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 83 ++++++++++++++---------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 11 +++-
 2 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..65e448a69a019 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2024,37 +2024,17 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
-static int arm_smmu_streams_cmp_key(const void *lhs, const struct rb_node *rhs)
-{
-	struct arm_smmu_stream *stream_rhs =
-		rb_entry(rhs, struct arm_smmu_stream, node);
-	const u32 *sid_lhs = lhs;
-
-	if (*sid_lhs < stream_rhs->id)
-		return -1;
-	if (*sid_lhs > stream_rhs->id)
-		return 1;
-	return 0;
-}
-
-static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
-				     const struct rb_node *rhs)
-{
-	return arm_smmu_streams_cmp_key(
-		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
-}
-
 static struct arm_smmu_master *
 arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
-	struct rb_node *node;
+	struct arm_smmu_stream *stream;
 
 	lockdep_assert_held(&smmu->streams_mutex);
 
-	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
-	if (!node)
+	stream = xa_load(&smmu->streams, sid);
+	if (!stream)
 		return NULL;
-	return rb_entry(node, struct arm_smmu_stream, node)->master;
+	return stream->master;
 }
 
 /* IRQ and event handlers */
@@ -4123,38 +4103,47 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	     NULL);
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++) {
+	for (i = 0; i < master->num_streams; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
-		struct rb_node *existing;
+		struct arm_smmu_stream *existing;
 		u32 sid = new_stream->id;
 
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
 			break;
 
-		/* Insert into SID tree */
-		existing = rb_find_add(&new_stream->node, &smmu->streams,
-				       arm_smmu_streams_cmp_node);
-		if (existing) {
-			struct arm_smmu_master *existing_master =
-				rb_entry(existing, struct arm_smmu_stream, node)
-					->master;
-
-			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
-				continue;
+		/* Bridged PCI devices may end up with duplicated IDs */
+		if (i > 0 && master->streams[i - 1].id == sid)
+			continue;
 
+		existing = xa_load(&smmu->streams, sid);
+		if (existing) {
 			dev_warn(master->dev,
 				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing_master->dev));
+				 sid, dev_name(existing->master->dev));
 			ret = -ENODEV;
 			break;
 		}
+
+		/*
+		 * xa_store() returns the old entry (void *) on success
+		 * or an ERR_PTR on allocation failure.  Use xa_err() to
+		 * convert to a standard errno.
+		 */
+		ret = xa_err(xa_store(&smmu->streams, sid, new_stream,
+				      GFP_KERNEL));
+		if (ret)
+			break;
 	}
 
 	if (ret) {
-		for (i--; i >= 0; i--)
-			rb_erase(&master->streams[i].node, &smmu->streams);
+		for (i--; i >= 0; i--) {
+			u32 sid = master->streams[i].id;
+
+			if (i > 0 && master->streams[i - 1].id == sid)
+				continue;
+			xa_erase(&smmu->streams, sid);
+		}
 		kfree(master->streams);
 		kfree(master->build_invs);
 	}
@@ -4167,14 +4156,19 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
 	int i;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
-		rb_erase(&master->streams[i].node, &smmu->streams);
+	for (i = 0; i < master->num_streams; i++) {
+		u32 sid = master->streams[i].id;
+
+		/* Skip intra-master duplicate SIDs */
+		if (i > 0 && master->streams[i - 1].id == sid)
+			continue;
+		xa_erase(&smmu->streams, sid);
+	}
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
@@ -4602,7 +4596,7 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	int ret;
 
 	mutex_init(&smmu->streams_mutex);
-	smmu->streams = RB_ROOT;
+	xa_init(&smmu->streams);
 
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
@@ -5627,6 +5621,7 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
+	xa_destroy(&smmu->streams);
 }
 
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd2fee2f560e6..97dc97ac704d9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
+#include <linux/xarray.h>
 
 struct arm_smmu_device;
 struct arm_vsmmu;
@@ -961,14 +962,20 @@ struct arm_smmu_device {
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
 
-	struct rb_root			streams;
+	/*
+	 * XArray of arm_smmu_stream, indexed by SID.
+	 * All accesses (reads and writes) are serialised by streams_mutex.
+	 * The mutex is held across xa_load() and all subsequent uses of the
+	 * returned pointer to prevent use-after-free from concurrent
+	 * arm_smmu_remove_master().
+	 */
+	struct xarray			streams;
 	struct mutex			streams_mutex;
 };
 
 struct arm_smmu_stream {
 	u32				id;
 	struct arm_smmu_master		*master;
-	struct rb_node			node;
 };
 
 struct arm_smmu_vmaster {

-- 
2.34.1

