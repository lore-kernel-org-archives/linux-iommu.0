Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436B4FDA67
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858752; cv=fail; b=qZ0tEQaTYFhmQ94hzzsKRota9wiNx8ejVMo7nSrSX/XZkW+4oAG2rXeLIzv6N5A19+T2oeqBFDpJrk6RaTJcBgHxmEjr7DImLltiZ3OFAqBMtCo1zW+qF8wJNYzZALjjdiros1pAUAjiDlCIYN1OZUr06zLAhivf8nZ/OB9dwVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858752; c=relaxed/simple;
	bh=Vj4czVnJH2Baaf2xBsqzfH2CZaeAuoz3yzEY6YZFWO0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KXkdaq2OUvh7o71n8RYQXnfCIWGYSbXS19WRikyBlnjErj6VsDvWRe3W2QnYju/tW5ud0vmWEbl9G1rZDsGRm6WUGXG3EpnvTsCKItletBQ9BReBmtEtJ/UhlASu43f2C/dJ6a/71ukFOaBNp/w29QQ+dCmtkzeH+RSYL6avtNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WCgOd1fi; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WCgOd1fi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIRcp7mE0Qbc1dFD/TY6JqRr8SqOXdw5wrRY5do2reT7WY2fNE24EPEC2zlbKl74n5b/vEIDwoOINxofa0LylpJIxofubEFVfwEbMc+fsrcC5ydNGd7yjf/pp1YC5B+EareF8HQjYIvWuyeMZ6Zy3ckcwHIyQXKAg9dhJkk4GI2lM1LVeZD6bwjNgn36asLjJmiPil5cXNVSWSM8XllU/Xi4n0t9srR314UrX/CIZnu+9fN2G+54KCD4TGq08nzvWEgeB2vk5jmxnPzMN5lsta8Pw6j9oESUUiSNdWmc75iZbXLj0yLV41dFN5hBstw0XloeP4bdo8LD1IsQvjiJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yig8D+xvn6ohIUi/2rcFR0s8Evpw28KrohOG4qkC4nU=;
 b=iTZYmGDGYXAkeyK9u/WHe3d2MlgXDrL1mgKalt21TXDkJ9XqPVrQ7PT2j09dnEDSTZvQYyNfWY+LviuVGd89XAMQCe2OW0r2ObWd2mt66jBXaMmAL2CvFYs2+O306Hc60G5GtWwwygorCBnEgf6u1Lj5NEq8ugM1ymE+zgeyzQfyGE01Cz3Xgnm7+UqjaP7wpAJmSAMcKzOhKhCkpF4ODAMJtAYCAufySs3e5iy6DmdIU0e/xITgEjzVlSMdK6eX7bF4WuRD6iF+1K5i0zXma4UqMU815gD8+KOjr+mwdYtJh9fzN5XwF/ZhjmvdSp8/6YvyfHjifnw/ZZCxQjRxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yig8D+xvn6ohIUi/2rcFR0s8Evpw28KrohOG4qkC4nU=;
 b=WCgOd1fiFn9KJ0mhNggpbvu5mvfhdG+ZTw75XKgLOlgfPrpguQFLRySlydxEfNpmy2FJdRkrzK3tHHDvK0GqrbbfNIwPxOlOAVXOMxkgFhTbrnSE/Gvx7k5S97XMNLlgshd0h94NaZmNJKxTnQHS9DS6lMLRJcAsKK5T92oh5Qw3ATbnuSLVwj5c7SseXSPxaStL47ZQHIp9OnA8FVzg03Xj8LQg2Xq+7xADhKBUpg0DYtG81/GExf+swUE/ShOKhaX4HxTefP+h1k9OcfmkjbkiEhBP5VzT6AphMst5iv6ZxCStSiUJp5OU1ABMZzjuOGSQ7NX7Xxba7caKs0EfHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AMBPR04MB11839.eurprd04.prod.outlook.com (2603:10a6:20b:6ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 12:45:47 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 12:45:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 01 Oct 2026 20:49:59 +0800
Subject: [PATCH RFC v4 2/4] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-smmu-shared-sid-ver3-v4-2-06b34fb2e691@nxp.com>
References: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
In-Reply-To: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jean-Philippe Brucker <jpb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AMBPR04MB11839:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b57691e-1c10-4b18-394c-08df1fb9ea39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yHVlaR4hYowkfz+Dtzos7gs2umTGwuahnW5uvn9tdnLeXxjmbBa7gjWEl9O750aYvNL3teHq1weP8P6i9T1GAKuawvvjVW81sq3xeWVxmICzWq0cvF0BZ1g4dNHfP9tOdfgvS/lp3fzf5LN7/uQ+JtRuzeWh/iDotXKCF7YQBfWyc/IHHS7u4Wjsm9uOcMJlHuJ1Qsx3T7PQK7K/yw19H4lfxEZr5rhzJMReR80ZzAODPkWzCGWtsTl8wkF6cLdu7WibViuV1Hi88nx4G9emSVJ5j6cvMaizl58p3cRFvipOUlsO5VaWlnom8qeWeDPuoFKSsT5bIMBK1nGSbh3iXu0/cx7Z3TyJ4WBxwme/yb6m/HpKkPhaNqESy0IDw9PRuDt8IEO2JkmNZ3UHfwEEf9mtWvjPIuA//SN4y/TefcBdDVcBlawTsJwunYrCx6dpLyMjpyivJchTOJLwS0v77Jq1mAqzFKXA3hfpO/kfY/WqYelVjPaFhi3aJh7GBpMIilIRDIj2IgtvMIx6UosQMc5ici6TtVtFYbfbWvmG2f/MczJcXvGjBoB7dSrIqg862tCaAH5l45VLUfsGr8o8ziivMj87ohAR5f8SLzfzVH8pdayh3Z0knsv7FpwKmp52uJ9D0L8i+cASPGafyT0SrEFl8bCBa60c599doZHshCU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGVKMUFRM2lBUjloUllqLzVsMkxPVnRDNkI5SDBoU1gzbmp0UkErY3BiU1R2?=
 =?utf-8?B?QWNGMjVXQTEwVjl6ZTlXeDJqeGNjWWJKbzBTaW5LSTk0WElsSTZoY3Y0TlpG?=
 =?utf-8?B?ZjR3eXpPRjlYVXJUcitNYk41TXZuNktjWWxHSHZxcHY5U2p5VE5PbHF5UThu?=
 =?utf-8?B?Rnc5OThXMFNQWTlJS2EvNUJUcllFd0N0R1VsMjJFaSswL3lLQUxENjJoZjZZ?=
 =?utf-8?B?R3h2cENReElpVDVQTEhuM3ZFbGlQcjJkYmE4bmUxY29CMGNyTW1TYXJCYzQr?=
 =?utf-8?B?aHBhTnhTRVduQzl0NGdOYlVjVzg4elRyU2w0azM0bUpJUStqQllKaGRldDlj?=
 =?utf-8?B?MEI0QTJWYWl5NEl1Mmx2NllzUmhkdzl6aERsakpVQXhoMnNKRFdnaHZ0UGZs?=
 =?utf-8?B?U2ZHNDhrMFkxMEFzRHVkWVhyQm94RlFmTWduVmUvMFFaanF3Um5XQ3Vpb0FP?=
 =?utf-8?B?aHVGZHpXdGhmWmVrSG9Cc1VpOTZobVhMc2lWVDJSZGxpcThFbjBCMytQTmFw?=
 =?utf-8?B?MUJTOEY2OVRZOVpqc1lZNjA3Z1U3RCsyT2hDZ0J3bkpjRlluZGpFVmlkbWRy?=
 =?utf-8?B?MnBPdDVSNTR2RythNWJuaEtlamo1Mk5pZklMZVJZM2NEMU1lMHhYUXhRSGhW?=
 =?utf-8?B?ci9LcnpCNUV6RUZTcm9vTk90K1A2UEh2ZkluSHNkU0tGai84VDh2SzNpOFpS?=
 =?utf-8?B?Y2VhOE5KQlRnUFB4aFJKUXRxbVk2b0JaNVJtQk9ueTkrVHR2VTdORERMaXpp?=
 =?utf-8?B?MmFzY2UwNU9ocml1RjE2SkVtTmlaekZYVUtkS2JacGhUa0RFemhKaGovQW9P?=
 =?utf-8?B?ckZTMUpoS2FFY2dwc1pqc1NLd1EyRUFLSDc5VWViWS9GbmpGdnZUcjV4YURl?=
 =?utf-8?B?R1ArYXhHVE91VTZIVGdWT3FwMTM1NW5QNC82MjBNQ1JVU0l5VllFVmlCSzdE?=
 =?utf-8?B?YjJUVlE2WUFQRk14MFlmYXVsYll3SUhyVHJtalJSQk1rcTF2NmdvOGk4a2FK?=
 =?utf-8?B?MVZnRlVmcDU5L2o2a2RZN0loUSthZ3hranQwWm9nTk5OTUxZN1MxV1JHV2Zt?=
 =?utf-8?B?TWR2cW9mTFp1VDJVcU5WNko2cnpJNE1XVTAxY0gzZEFzRkpvSmVIRnZzRFdX?=
 =?utf-8?B?ei8xVU1vcEFwaWZOeE5rUzBWeVprcUprclhUS0I2QzVUdXRBVXBiWGJ4WFlZ?=
 =?utf-8?B?WDgzY1hrNXhpWTB1MmJKOStTdkxqQVJzYnlYY0dTZXJwMVl4cXZQa3J0Q2o5?=
 =?utf-8?B?b0NxYWdGMkxLS0ZPMS9ob1BvV1cwNGVYSFFNVTRHT2lrVEVsbWZKTnZrRUdr?=
 =?utf-8?B?L2NNczc0a0FHeW1VUVZDVUVhY0RkbkNSOGZDbm83dnRmcUhJTDJ3RjBrUTVC?=
 =?utf-8?B?a2MzQ2ZZSnBhZkpWUW9VdVlyOVA0Sm9tVDdGR2tEckpJcUU4dnR3VThIZDJJ?=
 =?utf-8?B?UnVtOHc0dHdOVXRlMnkyK3lwK2xDbXVPQVZXQjl4RHg4SVhWYWNza3Q2MWQ1?=
 =?utf-8?B?UjJ0eEVpWUVZR2N5UnhORnN6cVNlalBIUFNsWHVrd1FHMDZkbHJUVVUvY3Rp?=
 =?utf-8?B?QzRqZmhWb3RqcW1yNk4zUjVwTExKbWNPbExuN3lwREJQREV6OHcvcExRdzIv?=
 =?utf-8?B?ZmVweHRUS1JEV2wrMlFvb2x1V1gxalZ0RkpNTC9laGRiWkFhT1hvbDk4NGR4?=
 =?utf-8?B?ZC9rZWFQSjd2VXZzZSt2WkRPZVNXY0VFWDRTRWh0czNJVHZqVm43MXd6bURn?=
 =?utf-8?B?N3J2SzFRQStsdHZtTFVROTBMWnBZM3pqWVRuTDNlZnpXamZNWnpWS2FubnZs?=
 =?utf-8?B?VTZMRjJQMU9PMHIzZ1VsVllxU0NYeGV6V3VHUUFFZ2VZYW9FRStwY2hGZjBZ?=
 =?utf-8?B?N0x6S0FlTDFPVHZaV2FMT0RIZXBkcmRidmlWUnU3alFFOEdtSWhhdzlwMlJy?=
 =?utf-8?B?S2x6dHdlQ3lEUFdBWGtEUmRvSW55WkpMM21KK3k4bHI0cCs4ZlJmb3NaMU9X?=
 =?utf-8?B?ZVdiT0FtK0U4Q0JmN29hbFloaFRQSnpxU1VGai9XbTk3SUhMMmdQWGtwbTJB?=
 =?utf-8?B?dUpOeFJrQTQzVlJwdnVvR2RYNWN5cVBRMUl6LzRlQTdZZVZERGE0UTBBRDdi?=
 =?utf-8?B?WEcrR3hnN2IzNlY3MjRuZkhIcWxHdVNiSGY0T2FvMXZlY09id0trVFBncE9Q?=
 =?utf-8?B?TnhOa0pic3BQbXNaa1pkc3dFaGRvNlRvRzhvTnM0VmpRd29tZ2ZYYTlUQVlY?=
 =?utf-8?B?eGJPRWZMeTJ2dGhsdDQ0b2UrNFlZRkQyWDcrYUJsRE5zMURaazVrb0hIeGVr?=
 =?utf-8?B?R0ZrRHBtMHVabVE5aWNiR2ljOFc3M1JVbThuazdkWTg0N2lJMEkwUnBTN3NF?=
 =?utf-8?Q?lZT+wkiXarzEJNTVN7F4M/BIdOfRIV/0anHHB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b57691e-1c10-4b18-394c-08df1fb9ea39
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:45:47.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueFa78i354Z9GWVY23hmGgE+JPCy+8VqhQmAVuKo1w/y7b6eOBlcr9f5BF8aY9die9U2KueoldFLPqOomMGuN1RGTG+cNwlRMLwbBlaw9P1NZEIEtfGNQkyr2VuucFlK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11839

From: Peng Fan <peng.fan@nxp.com>

Some SoCs have a limited number of IOMMU Stream IDs and hardware
that inherently shares them.  For example, the NXP i.MX95 has only
64 SIDs (6-bit internal bus) serving 64+ DMA initiators across
separate IP blocks - MMC, SD, NET, PCI, DMA, NPU, DSP, DISPLAY
and more.  Genuinely distinct platform devices share a SID by
hardware design because the SID space is exhausted.

When arm_smmu_insert_master() encounters a SID already owned by a
different single-SID master, instead of failing with -ENODEV, link
the new master into the existing stream's shared_masters list.
The stream structure is shared directly: the RB tree entry remains
the same, and all sharing masters are tracked via list_head.

On removal, if the departing master owns the canonical stream,
transfer ownership to the next sharer.

Sharing is restricted to single-SID masters (num_streams == 1)
since multi-SID sharing would require more complex tracking.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 94 +++++++++++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +
 2 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a79f2250a4886..9d98d1b2758f7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2037,15 +2037,14 @@ static int arm_smmu_streams_cmp_key(const void *lhs, const struct rb_node *rhs)
 	return 0;
 }
 
-static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
-				     const struct rb_node *rhs)
+static int arm_smmu_streams_cmp_node(struct rb_node *lhs, const struct rb_node *rhs)
 {
 	return arm_smmu_streams_cmp_key(
 		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
 }
 
-static struct arm_smmu_master *
-arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+static struct arm_smmu_stream *
+arm_smmu_find_stream(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
 
@@ -2054,7 +2053,20 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
 	if (!node)
 		return NULL;
-	return rb_entry(node, struct arm_smmu_stream, node)->master;
+	return rb_entry(node, struct arm_smmu_stream, node);
+}
+
+static struct arm_smmu_master *
+arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_stream *stream;
+
+	stream = arm_smmu_find_stream(smmu, sid);
+	if (!stream)
+		return NULL;
+	if (!list_empty(&stream->shared_masters))
+		return NULL;
+	return stream->master;
 }
 
 /* IRQ and event handlers */
@@ -4116,6 +4128,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
 	}
+	INIT_LIST_HEAD(&master->shared_masters_elm);
 
 	/* Put the ids into order for sorted to_merge/to_unref arrays */
 	sort(master->streams, master->num_streams,
@@ -4128,6 +4141,8 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		struct rb_node *existing;
 		u32 sid = new_stream->id;
 
+		INIT_LIST_HEAD(&new_stream->shared_masters);
+
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
 			break;
@@ -4136,23 +4151,33 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		existing = rb_find_add(&new_stream->node, &smmu->streams,
 				       arm_smmu_streams_cmp_node);
 		if (existing) {
-			struct arm_smmu_master *existing_master =
-				rb_entry(existing, struct arm_smmu_stream, node)
-					->master;
+			struct arm_smmu_stream *existing_stream =
+				rb_entry(existing, struct arm_smmu_stream, node);
 
 			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
+			if (existing_stream->master == master)
 				continue;
 
-			dev_warn(master->dev,
-				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing_master->dev));
-			ret = -ENODEV;
-			break;
+			if (master->num_streams != 1 ||
+			    existing_stream->master->num_streams != 1) {
+				dev_warn(master->dev,
+					 "Shared StreamID 0x%x not supported for multi-SID masters\n",
+					 sid);
+				ret = -ENODEV;
+				break;
+			}
+
+			if (list_empty(&existing_stream->shared_masters))
+				list_add_tail(&existing_stream->master->shared_masters_elm,
+					      &existing_stream->shared_masters);
+			list_add_tail(&master->shared_masters_elm,
+				      &existing_stream->shared_masters);
+			continue;
 		}
 	}
 
 	if (ret) {
+		list_del_init(&master->shared_masters_elm);
 		for (i--; i >= 0; i--) {
 			if (i > 0 && master->streams[i - 1].id == master->streams[i].id)
 				continue;
@@ -4170,16 +4195,47 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
 	int i;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		if (i > 0 && master->streams[i - 1].id == master->streams[i].id)
-			continue;
-		rb_erase(&master->streams[i].node, &smmu->streams);
+	if (!list_empty(&master->shared_masters_elm)) {
+		struct arm_smmu_stream *stream;
+
+		list_del_init(&master->shared_masters_elm);
+		stream = arm_smmu_find_stream(smmu, master->streams[0].id);
+		if (stream && stream->master == master) {
+			struct arm_smmu_master *next;
+			struct arm_smmu_stream *next_stream;
+
+			next = list_first_entry(&stream->shared_masters,
+					struct arm_smmu_master,
+					shared_masters_elm);
+			next_stream = &next->streams[0];
+			next_stream->ste_installed = stream->ste_installed;
+			INIT_LIST_HEAD(&next_stream->shared_masters);
+			list_splice_init(&stream->shared_masters,
+					 &next_stream->shared_masters);
+			rb_replace_node(&stream->node, &next_stream->node,
+					&smmu->streams);
+			stream = next_stream;
+		}
+
+		if (stream && list_is_singular(&stream->shared_masters)) {
+			struct arm_smmu_master *last;
+
+			last = list_first_entry(&stream->shared_masters,
+						struct arm_smmu_master,
+						shared_masters_elm);
+			list_del_init(&last->shared_masters_elm);
+		}
+	} else {
+		for (i = 0; i < master->num_streams; i++) {
+			if (i > 0 && master->streams[i - 1].id == master->streams[i].id)
+				continue;
+			rb_erase(&master->streams[i].node, &smmu->streams);
+		}
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd2fee2f560e6..89177f3e7dabe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -969,6 +969,8 @@ struct arm_smmu_stream {
 	u32				id;
 	struct arm_smmu_master		*master;
 	struct rb_node			node;
+	bool				ste_installed;
+	struct list_head		shared_masters;
 };
 
 struct arm_smmu_vmaster {
@@ -1017,6 +1019,7 @@ struct arm_smmu_master {
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
 	bool				ats_always_on;
+	struct list_head		shared_masters_elm;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };

-- 
2.34.1

