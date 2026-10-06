Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63163ECBCD
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288922; cv=fail; b=AVf4rv5okkTCmYD3/GdXbd+zSgdR6gXVW17b6Ixy08RoivbYMhQpZaJ9cpboQGMd3zUVUGMlIX2+MRh5rs439XoaGMZJr01ufx0MjXZcVlZ0BmLlyDI2VdjWe+P0hbVYWKhHNWgLym0v77P+fgMG7NXvdTiLvrwavilhVy3pzX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288922; c=relaxed/simple;
	bh=JDgeZUHEdhHgK+Bb7aAtR8v3gOb1OD6quhgaVufpZ2k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=f6j5oNYE9D4wD9F0MCr3HO58qTK94M5fyYW5khquOFS/gmRGtse0nBH9BUrjvcUS4jXaUmycgF7Ccn6oxqd92ktad4GxyBiXPSRaOw91rUWkwmTBPu6Z6V7335rW7q/btgJVVHXhOkgE4FIsVbqevYvXvlW/THDrSOA31qg5pos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RXjJyBoX; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RXjJyBoX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZ9Wwy3jiUhO4PSnq2hIZJZUHf2QS5V+zX4u1fIXy2mPaIYEur+XjubjFKiTklUi5xgiRZUieUGLiOHT5/iMfjsoXVC04M4O8c2dCVQGbkciT36yjLCTfLZYnHbUsF1llmDq81oszzym0OeOsVVV43kQPuPmGlKy7ErEnQ6VS7X0wMMQbh7BzF+BTXzRhQ3HhoFmA2OrhGVaK3J7JgtZLFYQLsCFsLlyDi70SdJXzmaI3V5ZPz58fW9/bfZQsHGKFcwwq37/HBBTNtEMSi20PJI34UX5JkVmkYwzoowBxVg4SPBVb9Nk5F2l7wJehScf1UCrrwkthfkOBdIvEqFeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQxI5zDKRbRryOEXAIFB6riA6NcV6EUY3C6bqtf5eLQ=;
 b=eZynpfpQZqUNsh57U31Un1OI4n4SrToE90Iduu9kGD81UbWN5Md53JttDpGGCMA97LtSbitOveongTLmd7siUlFpFqynUXv3yvsW1cNyN30hl0GB2rleoELGziE3QZWxGwJHTDIC3XCy/2+cOn25MYaX/T03ViCDpmcXMBRLjGxSo/pICAjn6tUwNJMSGnp82+0xRpta59akOLwuowRFkvDo9tXdXx1wDA3Q0MF7RqX78/1G2hXe6TpdHbeDvyKNe4hThLKjMZWznY0WyMi3Nk7xmnQjS6hSEs/T4WYXsU70btdty0a9NuqR/9ChQqegSXt33/vrQxp784Kt/rolrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQxI5zDKRbRryOEXAIFB6riA6NcV6EUY3C6bqtf5eLQ=;
 b=RXjJyBoXjDrQejFo5e3uXk2BkUzzYRB1HEvr+btzfNbWmts3SnGtA8zut/pFxTvrfebBfYZBblcCrF3p4sw9wdCkIG+7I2tmP0l5VZo19GWeFk5zD0qnGlUG4zPNl17LL7tWd+fyW1mPPsUPzk9fw2lN5tJGVVWJ0WTIfmebMzgO6Dizq+J3TDQAVa6t6srWMyyPobHJh95/8oDYe/TA6K/4sH4ajkz0CJiLiRqgkd4LQMB8F/0+qHggdzArH/IBUk/RLI7MV8t7R9EAlEpbqGKNy4Ad4g7/ZUm6Vr+5lsE8hYHA4VKkQfzvMCgeaYw86m3TBlGdyDSueB8goJ1/BA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by FRZPR04MB12432.eurprd04.prod.outlook.com (2603:10a6:d10:1ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:15:16 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 12:15:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 06 Oct 2026 20:19:10 +0800
Subject: [PATCH RFC v5 4/6] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-smmu-shared-sid-v5-4-169a59c671d3@nxp.com>
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
X-ClientProxiedBy: MA5P287CA0144.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|FRZPR04MB12432:EE_
X-MS-Office365-Filtering-Correlation-Id: 7147c363-1753-4f99-3569-08df23a37ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	ri2r587BPQuy84J+yv4753e2ZbmLuuYWiRdDFQN/wFUSq952IjmphhcWs4yQ/d+Z4hMvBzFnObj1F8Sgsr9WpWLO8yZGBESxzvyt4TYJ3TzDWNS1UogqhcdFLymKbzCMPheGsWpN3o0r0AkbBLZmbn4eiQ4Zp1vy8/t4TW+PuEr8SA4v9vn4YP73oFstXwbrWDib511FFl4l7wl133jyvJrkxGaoGMyzZqxBFuEhxWr228wMaJPOsQfa00G2/2jxVvHa5baAL6fdoHu5oJEWvwvl3IHpECr2nJiRDSQN5h6/QVJj7yVP55L7KvfRNRSRCdPHWDULPeGbxTN1E4DubC8WyqE5O08GaDN+B/jl3H3Obf4mdKBtD5nRCxsHDUdZaiN6KSrtHrkshnfRdfNY0C1Zu7E2ZCvbGGt7EDSZ4xvICOdQjzihY8KVBMgQtrZi50ELhRBkoYNSybpbz2sTczQh/UIS4J5a+0kNWTFkkGjCqYRYlI9BefO/6Y5iaFsA6dr9C7DGu5avZAKR88ldNpB6KTmd05VunX2ujZiw/eMJ+nReHOV0vOxdHvozSfqEkhQwKutNP1OUZYAkGOHfLKGCEunVb99lv7iP/OXx+CBCjKQTFVUnuk3RtJTuskd5K8khDJUrLsASbL+dIKjKYvXcYfW6luEt+KL9L+SGf5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzlwT2VEUWp6RDdUVEtiK1pUL3VkcTVZQk15NEY0amhUTDd1eE9qOHVSbnRM?=
 =?utf-8?B?WW9tcUd2K0JVTmVNTVZpY2duY2lGcjlQcXl6NzlsMHlpc2Y4MUdLeHVVaHZF?=
 =?utf-8?B?WXZKLy9QNDRDelUrd3dLQ3ozL3lSZGdNdXN3ZmFkalFkZ2dCV3VyTkxWaWpC?=
 =?utf-8?B?NW5nMFVHb1dkNE85Qm9HU1UyWnU3L0FoWCtZMThzV2N4L08zdDFTcGo0UHp0?=
 =?utf-8?B?cFdkVlhCWWJrVDQxWDQrdTFOQUp5TnFaU2JEYUZqYk1sMnVMMTNnSjlXMS9x?=
 =?utf-8?B?cStNNkNVQkNJUmdXTzNCQ3VZSGpuamJkek5nV1dtSldqNVluaEJFdmhwN1Nm?=
 =?utf-8?B?ak5wbEVuSzNHdlhIMDJlbXNoQXNyM015eXc3YWluVDBlRDFqMHkzcVJsWVpO?=
 =?utf-8?B?ckFheEZmN2tBcmFnM2RUdXk2YkduUDMrZ251eEVSa05KK1BaU1YzNEFHcWd6?=
 =?utf-8?B?U1BNNEpzMGlqaUpnMVArSE5SRUhCSElNRlVSNFoxVmExOVV6bUd4Q0lxMkdw?=
 =?utf-8?B?c0M4ZGZpNWJwVmIzMTJXdDE1NVJFanJkdVBpSXgvT05jaWhQL2JCMlk0dEk3?=
 =?utf-8?B?V3BSWUNNbGluYjFMR21GRWFscFk5WXdrTVNsczk2dHFUYU80QnpvUm9obTRp?=
 =?utf-8?B?SGQ4NVlyNEtqSldRWlZpZWVWekx3em5XWW1vcGxhTitPdDBFcmRXdHhFQUg2?=
 =?utf-8?B?czl2N2E4R0dVajV2dmxRWFpRd0NLM3RMRFYzWkpNS2NFSFo1YVdGSHJVRk5v?=
 =?utf-8?B?UWpPeTFJTS9pSUx5R3NXeWl5OHROMGZpMTVDaVoyTnVWeHE2LzVNUnJtckhU?=
 =?utf-8?B?QXJmcmFWdmdnWUtiMk5vQVUzaUFOVVE0aVBuVjZJRXV5QWVvRFFUeVEyYnB5?=
 =?utf-8?B?K3laWTdKQTIzOVNJUEF3Wis0Smd5alMrbzcwR2gvK0hmMXBZdG9KS3pMa2N4?=
 =?utf-8?B?SnBISHJ2RFM4dWlyc2JjYUdkOU9aMlpzY3ZEL01OWnZIakdZOFd6dzJmaUV0?=
 =?utf-8?B?S3J0bDhFdXZucmtOWXl6MGV5Um5waVZkUEFMb0xmSVlCQWVFek1aRDRmd2FH?=
 =?utf-8?B?MTJGL1pkWjRQbzJIaEtBUnIyQzZ6QzBOS20zazdBeXRZcWpOMUNma0F3RmIx?=
 =?utf-8?B?dUlvRTNMR25CNDhDajdoWWRKcW52VjNEK1lRSXdFSVdnRnFIa0JWZmFUT2cw?=
 =?utf-8?B?MlpJNnA3T28zSi9LTi9aWjBST3R6bzlUZnBYZzU3QVNJdWpXUlU4VmVscWxH?=
 =?utf-8?B?NGRuZ0ZiYU1kRWlydHdvcGI3ZmdEUVVFZGFKekdCdDg0UkFWMWtQNFk5cWJG?=
 =?utf-8?B?eHJIaUtlcWR4YUhLSktteStwTlhJajFYaGg0dGRNQXVYWEx0TWtwZXJqY0N5?=
 =?utf-8?B?T09TY0FMUHVZRUpEakt2bVNCZEZHVTNQejRHSkVOK3FSNjFNdnp5ZTljMXNp?=
 =?utf-8?B?RmNNcDRQT2tuLzVpTE84OFYyZzBwUnVLU1FJeU5lbWdzdE8vOEpSQWwxQnd1?=
 =?utf-8?B?cVJlcU4ySXZyREwyUnJLTmdITGRrUDFPUXRGekhiOGM3aUMxeE1iYlV3bDVh?=
 =?utf-8?B?VXNVN3VOS3NqVEdoaHNZNE9jVytQNkd2cG9VaTNuTElJcG1mZ00ya2IzcVZx?=
 =?utf-8?B?SE8rRk9kWDdMZU4wZzZ6YThxWkg0WExlOU5pVkRXMFRYNkdjWXhDMFlYTXdu?=
 =?utf-8?B?RHdmcGJlZEdudHNNaFFNUit0SmU0YkRHMDF5K01qckt2Y3pVQTg1eEl1NkQw?=
 =?utf-8?B?cWxYdkVzRkFDT3loK1BDd1VGSEJVMTZENm51NEhyK3creDlHTEhHb1Fwcjhh?=
 =?utf-8?B?U1Jtc21FenF3R3R1M0JxakdBU1hYWDM4ZlRMaVhOcTluM2U0d1Z4ZXVpcW1T?=
 =?utf-8?B?MkNJN1h0Z29pOGdmWGtNcC8vMmVUUzlMZDAzV3ppRGFjaU9lc09HODN5dnNW?=
 =?utf-8?B?dmw3K25ZZEZ3RUlsTllaYTBNeWp3YjRKVjVzbUJnZXNSa2tKY29TbXpCdHkw?=
 =?utf-8?B?bjlpYWlNaW1RUXVwZHpmVDJKdDVKQ1NGQnorQ2I4Yk42UmVVeDZqOTlldGNt?=
 =?utf-8?B?RGdKenhHbFZsWmgrYVpBUzZTMVBlZGtDYTdhK3h4WTVoYUg5aFRaTDZFTEUr?=
 =?utf-8?B?a2MrRm5VOE1WSVFKb2tDVTVhc2QydkJXeUVZSzAralVrOGVCc1RpVk5GMmVj?=
 =?utf-8?B?YlNJRE5wUFdMcStnNTMySjl5V2w5ekxuaTNSLzRydHowN2dISkN0UHdjM0pk?=
 =?utf-8?B?eDRYSFQ4ak85eG5RWWVxc2p2M0hTUE02QUQ2SG5hQy9ZMXlXdFZNUDNLSTIx?=
 =?utf-8?B?ZWNhRnFJSlJHaE04dGZhaENhR1VSbUIzVmZ3QUJhVkxOSTJqS0FoYUQ4Vnh0?=
 =?utf-8?Q?HZLEN9Dj2rwWy0tL6Uc7ypQV1B/4K3ky4IUfX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7147c363-1753-4f99-3569-08df23a37ac2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:15:15.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2nP/QJZxxjZxunmm4tXGEXnSxgMvmuF9tVNMBff45hbFQbaTEFESEEuqeaTf/rywAKvifvCa0XScBJ3J0u+tAdBsSJVT7HahtLhLGzsnzVuia7JLvWAw40w/mqyKBQp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR04MB12432

From: Peng Fan <peng.fan@nxp.com>

On SoCs like NXP i.MX95 where the SMMU has a limited number of Stream
IDs (e.g. 6-bit bus = 64 SIDs), multiple DMA-capable devices are
assigned the same Stream ID by hardware design.

Refactor arm_smmu_find_master() into arm_smmu_find_stream() to look up
streams by SID inside the lock. When a second master attempts to use a
SID that is already claimed, link the masters together via the stream's
shared_masters list instead of rejecting the probe.

Sharing is restricted to single-SID masters (num_streams == 1) to keep
the STE lifecycle simple. Multi-SID sharing is explicitly rejected.

On removal, a shared master detaches from the shared_masters list. The
stream and its RB tree entry are kept alive until the last master using
that SID is removed.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 92 ++++++++++++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +
 2 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 69c2c3596b06a..d306e4af90ef0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2044,8 +2044,8 @@ static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
 		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
 }
 
-static struct arm_smmu_master *
-arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+static struct arm_smmu_stream *
+arm_smmu_find_stream(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
 
@@ -2054,7 +2054,20 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
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
@@ -4109,36 +4122,41 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		kfree(master->streams);
 		return -ENOMEM;
 	}
+	INIT_LIST_HEAD(&master->shared_masters_elm);
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *stream;
-		struct rb_node *existing;
 		u32 sid = fwspec->ids[i];
 
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
 			break;
 
-		existing = rb_find(&sid, &smmu->streams,
-				   arm_smmu_streams_cmp_key);
-		if (existing) {
-			struct arm_smmu_master *existing_master =
-				rb_entry(existing, struct arm_smmu_stream, node)
-					->master;
-
+		stream = arm_smmu_find_stream(smmu, sid);
+		if (stream) {
 			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master) {
-				master->streams[i] = rb_entry(existing,
-					struct arm_smmu_stream, node);
+			if (stream->master == master) {
+				master->streams[i] = stream;
 				continue;
 			}
 
-			dev_warn(master->dev,
-				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing_master->dev));
-			ret = -ENODEV;
-			break;
+			if (master->num_streams != 1 ||
+			    stream->master->num_streams != 1) {
+				dev_warn(master->dev,
+					 "Shared StreamID 0x%x not supported for multi-SID masters\n",
+					 sid);
+				ret = -ENODEV;
+				break;
+			}
+
+			if (list_empty(&stream->shared_masters))
+				list_add_tail(&stream->master->shared_masters_elm,
+					      &stream->shared_masters);
+			list_add_tail(&master->shared_masters_elm,
+				      &stream->shared_masters);
+			master->streams[i] = stream;
+			continue;
 		}
 
 		stream = kzalloc_obj(*stream, GFP_KERNEL);
@@ -4148,6 +4166,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		}
 		stream->id = sid;
 		stream->master = master;
+		INIT_LIST_HEAD(&stream->shared_masters);
 
 		rb_find_add(&stream->node, &smmu->streams,
 			    arm_smmu_streams_cmp_node);
@@ -4155,6 +4174,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	}
 
 	if (ret) {
+		list_del_init(&master->shared_masters_elm);
 		for (i--; i >= 0; i--) {
 			int j;
 
@@ -4193,17 +4213,31 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < master->num_streams; i++) {
-		int j;
+	if (!list_empty(&master->shared_masters_elm)) {
+		struct arm_smmu_stream *stream = master->streams[0];
 
-		/* Skip duplicated SID pointers already freed */
-		for (j = 0; j < i; j++)
-			if (master->streams[j] == master->streams[i])
-				break;
-		if (j < i)
-			continue;
-		rb_erase(&master->streams[i]->node, &smmu->streams);
-		kfree(master->streams[i]);
+		list_del_init(&master->shared_masters_elm);
+		if (list_is_singular(&stream->shared_masters)) {
+			struct arm_smmu_master *last;
+
+			last = list_first_entry(&stream->shared_masters,
+					struct arm_smmu_master,
+					shared_masters_elm);
+			list_del_init(&last->shared_masters_elm);
+		}
+	} else {
+		for (i = 0; i < master->num_streams; i++) {
+			int j;
+
+			/* Skip duplicated SID pointers already freed */
+			for (j = 0; j < i; j++)
+				if (master->streams[j] == master->streams[i])
+					break;
+			if (j < i)
+				continue;
+			rb_erase(&master->streams[i]->node, &smmu->streams);
+			kfree(master->streams[i]);
+		}
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ba430078cbce9..2ed7a66c8b0b8 100644
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

