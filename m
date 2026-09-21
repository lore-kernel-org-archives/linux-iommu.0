Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A748595F
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994206; cv=fail; b=HM5OivnCevoc//8GAWcjb7rHFvLvKxhAZAd6OHK4d6arCzNGNkLThQaMABU4uHTVbDgBok5W4CbQe80JCgB1uWfLY9xRZUOhMMDJ5RiCtAWjpHoD33KyTrKmwIQtg4DWRHfWYckrtvE7UF5/o8S6750yc0Jz9b4+dfQI8M+8DJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994206; c=relaxed/simple;
	bh=kPCHrfRWRxCV+0yr3XkTzgqUZgeLwbjN3rJORcVZi+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O8q4R9dUaXNZ1EV6frh80ATpERqc4/Y5yyRe5byrvatQ9O4RYAH1cHIxY51h0cz+ArkVfprExf3DFP1qWrYn9a1Uz/3ijV3sMrFrm37xcTma6bVj10CvbL32u8GivMZ0/teNC0n4wRWFbaEg8qktyD/Z4rLkY15qAgsCYtNwapI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NLrL0oR7; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NLrL0oR7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Khw0bfy65b1Yu2bGH50/kMh13rhg+6SOppXuv2Zh1FQQvSgyaTpveQRaTglVl+awddwZ1aImQ3QdRKl6BC7hdfZGeiPI6T5OisdE2aC7v3p280NzO8E+CROH55EonwnFCYPJH3L2W46oNNqHwGOoAmMVs9lKFUeLfVRiYD5WF3qcglrgvkI2fwQY0cc3DA3emIyCMjN1j5575MfaCuqnIjxDRHUkFazj2RRJXEbm3tuQDSEsMO5OaMDVuTxAelKQyfmjNztIughsK8LsQS8My5E33Vk6+kYmCEiu5LoMhYujnLmg5D2NfqNt89jQndGgS6S2KrxEuBs0TrPbI7gpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crMJ5fwvhDLCfNoZh5OsD4lev7sJytrb8LKXxd6zrgQ=;
 b=mQNGfH3IPRPs3Fk5KJ7ADxLOtBQb6QuK6sSulKEPKrcjelLe+ehTN6U60xMEhxEet2KVfogDW6EwRorZca6YggBCJnn9x7elNGo8droPd2D4b7OpE/IpiwB4KKUlJPVX1sbm9ScnBwKg/O5BwbNq/rXf8zm3UrDsnFU2NvvJHRpHJCBMJuD+x1rXRTwlEYF9LlBs8fWn5ki5iUZDyDAbspLJf0bUM/wXW/w+vUGZDnLcKj+dhgLk6A9j31LAV+I873EcSN18dWkGSMROXJVDsEXQ49jnqcKQXnp8LmkiQkigBrvqSEu2N8A2h3B7RE3pukJ3SZiONsbgS93YBxt9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crMJ5fwvhDLCfNoZh5OsD4lev7sJytrb8LKXxd6zrgQ=;
 b=NLrL0oR7XXJM6Yt3cX4vKDm2xlsw7RD2/Hu0eNaeqOQ6pziNN6cx2boGp4ymJ13mliAJr+Nfze7r5u4q6gyY+I5Hs/pVxzKslRzLIqiYGXCZLBSYDS5/pP7k4s+4xmLdXsBuPyMzblqJzq3XZVvTMS9lnya19NPu5QePuWxCOWqpHgzaat1w79Nogq/r1tsbYi7wifjU5eJssQKrJUgjvaOda5JRfuWnZsU+GvjYYe3GdgWmGm0KibSsXGuzcKIp0FHgIb+srVI6GO1+W6dMrhQkpQFZmUcsHWKTjBGuKBUuETFWSYm+a4BNGtmz+wHdgVKWSFcWMAyeV24Oru8r8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM8PR04MB7907.eurprd04.prod.outlook.com (2603:10a6:20b:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 12:36:37 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:36:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	jpb@kernel.org,
	jgg@ziepe.ca
Cc: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com
Subject: [PATCH RFC v2 3/4] iommu/arm-smmu-v3: Group aliasing devices into the same IOMMU group
Date: Mon, 21 Sep 2026 20:40:57 +0800
Message-Id: <20260921124057.1664114-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
References: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM8PR04MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc8eade-4760-42ab-7325-08df17dcfa1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|19092799006|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dW41/0f0/i2LIZ7EKawaW/5kNT1CvZVLFi4HlDbRplZ7HqBB88IKdxzaBnm39z9VSXpzcDnZ8yTR54k7V+WWu5+cu/8AY/D5tnJ5DyGOx1HXABajgjLPCNG8dxINxaK+d3goTRdGObB/vcUk9CVTQLo4cILRFBy+ygswDS2NfThqPZ1UUHa7DG2jYazvZxWOCk1yKZumnMIgJIgvz2lh4MMkHtrcHsaHw0qtXJPd7wQlNc4hZ8BcY62fX3hwS4FuO293UIBh7m6WFYY3Jbj6qfXHDM+sL19YfdaO2SYWMV1ZVBYrDN8+YMLVNDOuvR0BJpUxic7OuKxeOtWxm9J6Yc7IxFI47Wx+o8dB2CmbGKLexIDWCPa1N2bSh0qvT3chvl+U2LVIEKGAQDfOyD99xutfEQrxwGXFy7ZfDZJxzV6SZuYFV6wEnrcCmTbDYuuqmoztbV6+mNbHAtoyaqq1boAnFaLEIPfMkTikfhQ5Oxw+B5FhFTJixW9VNE2L+LTTt4IqK5CCRLEMSif+DsM5O8PekOX/8dGsHiYmYExqJ6r7Nm3HrKi8FmSlUdU4PKEWFf/H1iNG0cT09F3wHCz3k7d7XYt50WeBqFOJBscECxobby8Kl0S2yG7PSr5W8JWqIuBCchCzI/vP71GsTLhB8UJAcIOOOoa9bmn1Ud9EoZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K05xWDlBU0p4YXFwcVRPM3BhaGxMRCtNeCt1c1l0SlR2Z0hhMVNRNC9jTk5W?=
 =?utf-8?B?SU01ajh5WHVjd1JqZDRoYXJHdTNQaWFLZ3BtSUpqN09UU2tzbkJwU3Y1eXI1?=
 =?utf-8?B?dFRkRDgwd211dkxVUDNXS1NaN1A2eGxmay9OR0IzMTlXTEZtRjVZWnYrNUZl?=
 =?utf-8?B?c21PSER5NzU0eDFQRC9uZVlLVzZnZWNUK2JJNm5DQ2g5N3FGV0F0UDB1WjhO?=
 =?utf-8?B?blRYdXRqRFl6eXhWSWJGU24vWGNSS1ZwR3RKc2FEd2swREVwaEprRld4RUs4?=
 =?utf-8?B?eExjeEkzcTJaUEdlWkYwSUxlWCtGVE42aUlmZGFiOEFSdzJCQy85UE5IOUZN?=
 =?utf-8?B?VTA2ZVVuNUt5OG9ycEJ2eVBtL283T2twUjJHNkNTcUhFTjlJL21CTWJNb1FJ?=
 =?utf-8?B?bHhMbS9Ea2dNbkFqWlNaZlhNRU9lOTBhTjNjWGFFUllwY0VyNUFpYmVOWWVD?=
 =?utf-8?B?Tk1LKzNPRm5hZkRHb1VJUTViL0VKczNvanc2Z0M2ZGpqNnJNM3ZBalgxUXI0?=
 =?utf-8?B?bWxHRzltUUNzcEZhSFVZcGwyQmdnTUtDa1c4dDBOUVJ6ZnpzZWlyQUlrR21a?=
 =?utf-8?B?MThuTHhLL2VWaCtmNi8rR2tkYXhTblpUWEdNd2YvM2ZaazltVFlXSkJ0TC9Z?=
 =?utf-8?B?L3dsbnUxODdSWnhmM3FVSlphNi9TeXBqbXloS3ByeDdmRG9sdWNJeG5SQTdy?=
 =?utf-8?B?R2NLbG9YUWFJci80aDBkSXBQV1U1bUQxbEwrUnhkaWtVdHJNU292ZlpnbExm?=
 =?utf-8?B?VDJWbzRFOXFGSnJ6TGdDZW0ybjY5WndXVksxYks3T1NnclljdFhNM0M2YjQw?=
 =?utf-8?B?MmtyVXNJeHAzd0syakV6N2Z6c0UvT0YwZHZIUGN5RThxV1B2NU02bHZuNzhh?=
 =?utf-8?B?eDdVSkl1VFNCZHJZMUJEdmt1WS80dnZZSXI1dSszK3duN0hxQm15RmFDdmVu?=
 =?utf-8?B?TzQzbWNJSkRUdUdUM2pQa3dydk1ncklZNEtpL01RbitTQ0MrMlZwUldRRnJr?=
 =?utf-8?B?b0tVRlNMRzlJa3RQOVNRMm0vNGQxK3hxa0krZWx2NGVRUjJubzJSMDBNUnds?=
 =?utf-8?B?M1dleXgxU1EzeDFGVkNxNXI2OEdLemdNVlM2RWtFQTFuZ045YXZTZUhxdzVB?=
 =?utf-8?B?bC9jODZjS1dGSEMwWUZWWEFZVkcxOVN3anQ1REd0bDMrT0FmV2dZRUNJUlJY?=
 =?utf-8?B?VGNETWQ2Z2R0bUlZdHppTGdnT1RWSXNNNlRFMlo4M0ttbnU3UnZhWXBSYkZX?=
 =?utf-8?B?bHlLZmJaeGJmdlo0alQrYy9aQnRSZ0FDYW1rK25xL0c1UlBpcWNDR3hFbUo3?=
 =?utf-8?B?TWt1STNIbWtMU3FsUTQ4RVlLNHlXVm1qY1lQV1RuRUE2Q0pVYzdWTGs0eDBm?=
 =?utf-8?B?YXAyU3czaW1WZFZaNEV2OHR2NTBrM2txTzc2ZS96TUZ5UW1IUXJpRXJXWFR2?=
 =?utf-8?B?VnhmUGtMV0VNVzZUa3hhYnE1cDhjaFRyMng0RzFxbGlIOGpuMG5iVEFUV0w4?=
 =?utf-8?B?djgrVkxCRW9oaW8xVU5RbmkxcTlUeEVUYTZQL3MwKzNOSUxlL3ZobkdKcHRE?=
 =?utf-8?B?YnJtblZBSEpONDB3WUJ4RHkwMFVWTm1zMnp3bWVNRGhkMzZ6WVNSb09VVmJF?=
 =?utf-8?B?bHRkcDhOTXhOMTRxcTZ0WjBITndxckJMTVBMYjFnN1lRMHp4N0RxeTBCcE84?=
 =?utf-8?B?dUJJanBpWHQvNnVyN09tOVNxMVRaZnZ1SEMzV0NOdzdUKzBUVzNGZUtvMDRk?=
 =?utf-8?B?cVAzYk9uNElEUmFRM0RjamtGNFJpUXdQeDUvMThZY1NCYmlJNy93NXlOZ096?=
 =?utf-8?B?UEx0cU9vYTZJNDd0SU1oU01iaUptLy9HRUk2d0kwVTY5NHZ6SnJoZllNb3lj?=
 =?utf-8?B?c05YWWtBSkl6ZUExaVVDeG9HVGdNS1ZDNGxDb2N5QjI2c3ZYc1I5cHlyQjMv?=
 =?utf-8?B?d3ZmNUl5OEUzanNFT3JwczNsQlVBK051VHpNVW5CNFJxc2hhU1lWSERaNlRy?=
 =?utf-8?B?bU16aVB1OU1Rd3hRSDVCZUNBWi9ZcGp5L1hqNWh1L1FPaG43Snh1RWF2RzBa?=
 =?utf-8?B?TWxCakpjVjN5dzdvc0V3eEVFTXR6b0hydlpvRms2cEtVK3lNUkhMODR6SnYy?=
 =?utf-8?B?V0RKOWNIdUs0Q2RkN3JVTnIrUGVwKzVYL2RkQlJzSkE1cEhWZ1YvSFBkR0xS?=
 =?utf-8?B?ZFZPbUhSRDVHVWhrVWppc2R5ME5XUjRiY3NaUjBEV284WFh6K2UvY043Mk5k?=
 =?utf-8?B?RDNTKzZwbWlWSVhyenhNMmJvdE9SQ1pCSzdLMEJTUVlsVlA4ZURPN2k5ZkxC?=
 =?utf-8?B?dG5WYkN0REFPNVY4dlZqakFaRThqNmlxV2FuMHllNVk2aXFiRjRkSnkyamhM?=
 =?utf-8?Q?SLOV+jZKjzwFOTKe1dXevskApngNmnYZiENe3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc8eade-4760-42ab-7325-08df17dcfa1e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:36:36.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx0R0OZ/IlUK62fntwiNxaoUpLoLS0xDaS4t7frU2EKMEJ89jKvf5qTfx5nxnOk6GvbL2izZHkZyyhEN1gEMDjd9gGpA4qyAyRltCpdtTeqUHm3Uda0iolhb2EiD7dka
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7907

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 61 ++++++++++++++++++---
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

