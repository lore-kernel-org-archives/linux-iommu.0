Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69A38A71F
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571322; cv=fail; b=ZxvpXzD2L03L+6hW0LGgbuPfVB7uiAw2kxJlJqDLBocMaZhisgtruGW9hGSdKKttK4LT3Yg+P6kpZHMWncNJw5lQJAjivUFu9amWXNflMXcfRUWVHgppVDJgPAGBykDWWE3CdE/2p6X+alM99sjv+eKCuVhXErR4zRtxwYPBpfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571322; c=relaxed/simple;
	bh=lJgOgLaQcFaMeQVYh2u7JrpQmWuzBsb53hYFMtpP4Kg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MvCMUe6JZuqcsoGuXmwhVFiuG5stfci/VKHrURn5NQEHNl0fNExymEaD/2CygSBQ2nKRUQmRuSNV6xNrQ0yAAXbAOASDgjD8NnkWqx8gnyFBhxyWp0/jvYOFpzINjVqrktuX2ggR0SDKhfQ0mL1VrxxqhqN9UDxhYtfqw+tLWkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OaRXyapB; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OaRXyapB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRDf6Coj2l9crrMj/Z+I5fe9siRurgC30P5bupv2f4aU+Xdxe3hum+oNMeVpRA+oIG10fkOpVRgwKOY1X62KHCQWfMxX9au/s8Kna4ojUEim2xziorfdnFvy+u0lAtDqRnOXQxs/0WnVI4XZsof4ATlSHgwz4+e7QVNJ1/NaFWkHtFggmZ7fGevzwkiwUCMSTd4yd532Lgh2A3joSsO9nFAAKaoja9W4Z9aRGGv+uAQ+wObeVWuEtAEVQaYfbfbA5V7OUni2LA1fd82uQNNf2OPjhU8LOH0lnMsyqatLKn2O8NxgC2CRFgP1oGOtuG9fh5F8bcDv1u0KPiBqHrUqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uILlEev8D+jIjtkU26s/iWWXomCsEPxNyIbnLZCB5Z4=;
 b=htHaAVcrQM00LyxvfX7GG4dDy7nsOBJYpbnwBWbBfCZJspL1wewSToHrmKZGrdPhk5YQVW3jkssKAMEv8QreFWCN1LlJ7k4Rz+LdZFkS1iinxNbJTOMA9stfZaHX0vpw0TBrAz1qzz+UjJ0O64hLqdq9pSZH7D3XMfxWQrz/iVeRySDRsraZeRM5HID3ZXd+4FSKpV8hZs0lYzNTlXUoMpUoPzQHCqldDp1BAsdL0JuXBqENEVI6xPv1OqKI833g3cBmbgvUguvZF0+391sPNVd1TXzu7rMF3fBbf0ikvR+uTVyQkbnEiRIWHkvZ7h0bcSusb7D0xCxpTXe8i+fq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uILlEev8D+jIjtkU26s/iWWXomCsEPxNyIbnLZCB5Z4=;
 b=OaRXyapBq7RjUhSlr5Gez/fwnldljFY/OVTe6py2W8JB42X2F9A8E9+SC9Fm6U9392WDi9CT9yLs3c8DB9IZlJqEmlwy8MqCbP+hzybR/wEHOFarXXOKTIQJG36WngO0HeVucfVvWisnygjylmN/22E0cXbIG71VSJcPBgJ72BgF4MmAhM4hcOOTTHW3KdtNjdiZ/7izxhg2s2zsa+NX+pcUtF3j1X1dJ23Hc7DZM3WVsIiXPA+/mWrvsAvjFiKiZp7jGZ5ZlEL8Gt9iEzW36qFCV6XoOIw0DIHdKWllCOzv1JsPgpavzYuPiPmEv7UimXlBAbHWXvuRzUiGYE1Hxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB921731.eurprd04.prod.outlook.com (2603:10a6:2c8:2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:08:36 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:08:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 16 Sep 2026 23:12:36 +0800
Subject: [PATCH RFC 3/4] iommu/arm-smmu-v3: Group aliasing devices into the
 same IOMMU group
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260916-smmu-shared-sid-v1-3-517384504aee@nxp.com>
References: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
In-Reply-To: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR2PR04MB921731:EE_
X-MS-Office365-Filtering-Correlation-Id: d7759a28-8bb9-417e-3984-08df140461ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|1800799024|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mixkf8AllLD7ZSyhKbE5th/IgRlCmw+Pg7ZxVHZ5jQ76xXGG1VlYn2nvQMGmp6Uv1EqeCzGR13BW6KPUjWsKs3I9qwO4TTZcqhUhGNoD5eOPXYMgH9ZjoO/M30QhXPs/IiFYuFEfGEJSpCp54QPF0XstmYw+J4W6schYMxveirGIDy6nB5IEO9Guw1YwuemSsQucfnwGxGNZqokvEcCjcnaeN8OX2HAiGxarciE2H01XV4rPtF6WCCui5962YaVYZ2Y/7WzeZusOC4OotsYt+tBaV8w9vAQe/2q9FLwV65JoWhO8V/AJRQB6NeMmbjnktrDtM2AAAkMA0W2srG2ZdMaKYDC1M4afzwdNxadMGjcSdwtbX8VkYjaYQW3K0ZDias9G4emUW4pSNILAosfMe1LMrsGBuizyKIL1yq14SPwUTz6xnBgUz1EHFbyXLNPYJKErf0rvA9nmtYEqUzr7qQmUbZy/t7yplf1+lOoq5Hr0Ap9th3z7FHOlD7Gi6Vmq6WlUkKlBcUJGMpER0czQ1cpKdFarTVHK01soqP8M+vbw6uTN2gJizcadpYkMI4oah/2Z+UKUwO1CllYDpCkCsOSYwz8dLUyWzeOEsTAc8E8iqFCkiaYoiX+SYW/LBbatx9SIfJMX3a/DZSMnWQ5JJQwbImfvycBKW3YBIud8JpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2xyQUpjUnF6R2g0Nm4wb0kzMzlIWmVhcmZqdUlEZStVRnA5N2E4QlhkTEFP?=
 =?utf-8?B?VDdMSi8rcUt1V001dUUvL3ZOaUNRMVlDYTViRTJwZWJJaWk0OEFRcEdoVlVF?=
 =?utf-8?B?Y3h0U3JDU1kzYVo2NFdsQlhSK0xILy9SYVVLY09zZWNYd0xxblkwQ0dPQU50?=
 =?utf-8?B?amx2QitqMmV1dTg3YTBuL2J2ZW1BUU1mRTRsdWVPUUVBVDNRdGt5UHZJMFpT?=
 =?utf-8?B?UFZiSVNSYloyaU9vcUc4dlo1VFIwSlU4aWRtUCtJTFNDRm1Ga3BIalBKRFpF?=
 =?utf-8?B?MExNNnNOY1hYYU0xSEJLZWVZck1jM3NSNGxVclNFTXVOOGRuUFF4bEhTZ0FH?=
 =?utf-8?B?SWJoaEllNHUxb2RUV0pJTGhNNWM3aktvTkpueml1enM4S0xWVUF3OWdJOFEx?=
 =?utf-8?B?cTdxeHN3UTlKTXZkQjZzaTF3V2hWbHJqd21RMEdPVU0yeDR0bXJmQUc3Ukcr?=
 =?utf-8?B?TFlpZGo2VHluK244SThyYXArS1FEcjNFK0R5ZzRBbWYzNlhjUU5DQlY4WEI3?=
 =?utf-8?B?NVpxUFlyVDhQUmFMWDkzREZvMzlHRjVCRWE0MTBSQVJHQ21HVmQ3VFBnMXNC?=
 =?utf-8?B?NXo1Nm5FeW1QMnJQT2pDZlVYMDlibzNTL2M2UDExMFFUdTRPUFhMRlRhYlo5?=
 =?utf-8?B?OHdDdlViTXFqYUowNCt1Q00wYUlBOFhlWXpnTEd3TU5Scm1uTWkvUWxPVWY2?=
 =?utf-8?B?dnZZWXNBdzJ0a3Bab1pRd0tQTWtDeGRIVVB2NGozZi9QN2pCa2RTdFVYbWxR?=
 =?utf-8?B?MWJucUxVbzQ1Y3pmc2pqandSTzlCNmFHR3RwSlVnMEpJK0RXQXNXTVg0dS82?=
 =?utf-8?B?TDNqTjB4OE9SSkZBRGUyc1daU0tDZFcxQWxxbTlQZ2hudzVEaFplTFFqSlAw?=
 =?utf-8?B?OUtjc1hxN1crbUpNK05oY1ZibFBFNmN4NjROaTM1OFVsOUhJNHVSUWpTRFE4?=
 =?utf-8?B?NldYSFhaYkM0WFJEZW94T0NJSWlBNWVoN21CYWFzWlQvSXhlQUJoQUlVODAr?=
 =?utf-8?B?Vk9sdXg2QjEzL0UzT2pNN3dzenpUMGtncWVIYUxHdkZWd3ZIOE9WTWYvZXBK?=
 =?utf-8?B?TDlEZHhDOEVmS3RCT3poLzV6WnZZY2ZSL1hDd0JLVzhvT1F0Lzc2N0VzYVc2?=
 =?utf-8?B?Tk5mS3R4ZTZYYjMvL3EvR2VqenpKdzRxR0EwaEk0aWU2TW5jalhMc2xsMUVM?=
 =?utf-8?B?d1hoSUt6UHE4MHJ4S0FEQVY2K3V0VnovZGFwSEpzLytNd2xFTWFqTkx0Mk9F?=
 =?utf-8?B?MTQyVVRYVm9OWDF4azVLcXBnL2YxSHFBMk9HZGZWZkVWVWhiRlJXZlNSWHZY?=
 =?utf-8?B?RDZab0VkdENaQUxicW56WG51WVl2UTNZSmxncFl3NUtPODE4OElBM29hQnF6?=
 =?utf-8?B?ZXFzSEt3MVlGTWpmUFcxenpmWFJOcHREc3ZLb2Q4N3U0eDk2dTNneWVleHNz?=
 =?utf-8?B?Lzkxdmw2S0xISFhNYVlkZTZYUzcvQU9Hd2wxUWdGOGNmYVVaK3liL1Q1VjhT?=
 =?utf-8?B?WkRJQ1cwTHJkRVFoUDlhMUJ5SkVPTld1N2RCcWZsNURrK3Z0ZmtQOTFZbkhu?=
 =?utf-8?B?NlYwNFJpYVlmZExIaTF2RjBNSE96M3g5bVVoVlh2aHErQkpSN2w1ZUI1bDVW?=
 =?utf-8?B?aGZ6dVZHU3pQZ2t4eXhXYW1qYUxhaVBJR3JQL0gxYUVmdjdKS3VNcWx4TG5x?=
 =?utf-8?B?R0hVclBYY1IxaVRLWUVveloyNmVZd2E0ZnJpd0ZwSDloWTVPYWJ4dGlHdFlJ?=
 =?utf-8?B?SFlxakY1bnZvZmo1WnpPZmxsUHVzRGEzdEllRXpvQngraHhHcCs4SDE2ZTJD?=
 =?utf-8?B?RXJTbUlKbEZVNU1mQXgxTjRwY1pHMUhjYlRhUlFoeTMxaUwvMVd3ajdPUzBj?=
 =?utf-8?B?Y1hpK0doZmdLSzN5R0pIZDQ3cEc2aGlqZ1RQbDNMUkpUa2xwMEdENEt3OU1k?=
 =?utf-8?B?TkxoUk5Xc1RkUWdqdy9qQTV5Rm1LcWkzbWs5ZnFMRWZzY201UXNlNVFvZmVi?=
 =?utf-8?B?cW9GUDR1MytGNEtXQlNGMlNTc2dBNE9SdlhZdDYwWGJvb3FzckFjdTVCQkZF?=
 =?utf-8?B?eTZ5RGJWV2k5TEJ2bkx1RmhQQ2UzeFk0NDJVbHFKVk5EQThoaUZvUkZtbnhi?=
 =?utf-8?B?RCszeWQySjF0elhTeEdxcnptNytjS3lTVUoyV2hiRlE1MnRMbVJJNWg4YzFq?=
 =?utf-8?B?OUtoUGY1K3IwcmZNOGZHcG5TUWhVSmU1VUlKcmtXK0ZsbTd4c2hzRWpBVGNL?=
 =?utf-8?B?ek1wOG43a0czb0xBYmN6NElBMVlBVHBZTWhkK0lYc1g3RXNQZ1Zqa2M0Sity?=
 =?utf-8?B?MGdQTjdEWkp4MDVqaGduRHBtZnREZ2Y3RW1JL1RIQk1wRGxOUmdzNk1kaEp6?=
 =?utf-8?Q?Ioy19S16yLGo4OqyDVpCt3gDe3SBgeGDVnpH8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7759a28-8bb9-417e-3984-08df140461ae
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:08:36.2112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +x9byedzSFx7LyQnYGK1MzICZMgisoGltBdRrtp3MaZGNjGCSpphTQSsY2tvTRseXvu5nQyKBsYdBE/L7ywWwIVCybOcYN4ByVi77/u3UxoOUm9Ytz3/03AdfE8UTtsw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB921731

From: Peng Fan <peng.fan@nxp.com>

arm_smmu_device_group() previously rejected SID aliasing with a comment
saying it was impractical.  Now that the XArray makes SID lookup O(1),
detect aliasing at group-assignment time and place the new device into
the same IOMMU group as the master that already owns the SID.

This is a prerequisite for shared-SID support: devices sharing a SID
must share a single IOMMU domain and therefore a single cd_table,
because the STE can only point to one cd_table at a time.

arm_smmu_device_group() is called before arm_smmu_insert_master() adds
the current master's streams to the xarray, so any xarray hit here
belongs to a different, already-probed master.  streams_mutex is held
to ensure the xarray is stable and the returned stream object is not
freed concurrently.

If a device has multiple SIDs that land in different existing groups, a
warning is emitted. The IOMMU core has no group-merge API, so this
cannot be fixed up and DMA isolation may be compromised.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 61 +++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f53e1871426a5..bb3ee25d10d6e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4365,19 +4365,64 @@ static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
 
 static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
-	struct iommu_group *group;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_group *group = NULL;
+	int i;
 
 	/*
-	 * We don't support devices sharing stream IDs other than PCI RID
-	 * aliases, since the necessary ID-to-device lookup becomes rather
-	 * impractical given a potential sparse 32-bit stream ID space.
+	 * If any of this device's SIDs are already owned by another master,
+	 * place this device in the same IOMMU group as that master.  This
+	 * ensures that aliasing devices share a single domain and therefore
+	 * a single cd_table, which is required because the STE can only
+	 * point to one cd_table at a time.
+	 *
+	 * arm_smmu_device_group() is called before arm_smmu_insert_master()
+	 * adds the current master's streams to the xarray, so any hit here
+	 * belongs to a different, already-probed master.
+	 *
+	 * streams_mutex is held to ensure the xarray is stable and the
+	 * returned stream object is not freed concurrently.
 	 */
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *stream =
+			xa_load(&smmu->streams, fwspec->ids[i]);
+		struct iommu_group *existing;
+
+		if (!stream)
+			continue;
+
+		existing = iommu_group_get(stream->master->dev);
+		if (!group) {
+			group = existing;
+		} else if (group != existing) {
+			/*
+			 * This device has SIDs in two different groups.
+			 * The IOMMU core has no group-merge API, so we
+			 * cannot fix this up.  Warn and keep the first
+			 * group — the mismatched SID will still be
+			 * inserted into the XArray and shared, but DMA
+			 * isolation is compromised.
+			 */
+			dev_warn(dev,
+				 "SID 0x%x already in a different IOMMU group than SID 0x%x, expect broken isolation\n",
+				 fwspec->ids[i], fwspec->ids[0]);
+			iommu_group_put(existing);
+		} else {
+			iommu_group_put(existing);
+		}
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	if (group)
+		return group;
+
 	if (dev_is_pci(dev))
-		group = pci_device_group(dev);
-	else
-		group = generic_device_group(dev);
+		return pci_device_group(dev);
 
-	return group;
+	return generic_device_group(dev);
 }
 
 static int arm_smmu_of_xlate(struct device *dev,

-- 
2.34.1

