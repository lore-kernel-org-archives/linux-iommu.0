Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348E13635C
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334760; cv=fail; b=SjYB5ScvyZbynGNrTUbJcvnMg+IDEoJMhx8FEsevRRAVTK+5uO1s8m6Vzl/xSL2WaqHge7ntGequ0O55PbEk+aNXhcfSCjxtb2PU8kkdNUoZSklulsSKmXWqBrqPPxHRttHuYihJ4Wy8aufDwLTYBZEvyKnBN50bnrH4O18/n4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334760; c=relaxed/simple;
	bh=EAcEFEGgT29YG3bdrr8uoTYBMi0b+xkqzhNfwlBq/A8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfiAgyRHMnLfJ+xBBsz1VHXqv0I3t8vj8AEQNN0KU4ejCC4Ec6UxBsVZNDh6HlcW6sDZ82Sp2TRLtt0lx6eBzUmhCo8m+ck2gixUHtLB8xQc/5EeDKQcYbPrlipYpY9IFVcLaQ6JCUGLIHw1nib1OnUdgMtYN1RW/XA0P2pcw6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k/6OA99N; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k/6OA99N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Om1nNAsVKlP2yBYyvcfQczBDxr9W0S32Fxi7A8Oj8e4I5K5/swOg3A4mpxj0qHXsUmgw0fZDI6CtXoIxBPZcH+oxcUVxZnh8b7LgeYMLhJ+FID/jBKEjHeH4yrWw2Dx4qt3wc58F1NM73vvENUp95+uGehrlhvK+lXSKKxvS3tKznD3QPpP3GuREMPdtoiBpZr/hmjy3q5QLBm3nOP92iyh2PA2NMy8PEOv4uayAg1jXqW0PD0ZrrMkZwGvm69wVL2lB11Ll861xOb+FqHQphQL0e8qKaQaEzQHkr2efbGv2vN0yXJgsruGJjKgG84tpP28sMhAgFVAgrIPnPNIqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC7Fctfw5taEfdIqlbmsIqct56bgsOJjsYZEIV09zS0=;
 b=XN++RjHFfS93eEQoBUble9+BYeqQXfYt07mDWB1gXW6Hks/zhtqg92wGByvkmcR2PF5FeafCYnIXm/Nkk2D3qV6yIrgxvBvFrECbaGbkEK2t4yjbau/BEgTc6/aGBzo0sNE0wK2hs/vPyhpiUpsElKtCJsAb8rInU75yppwI1WfGLB5Bkwdn16/UB33VJ7Tq70B4dw1cr1UQHSc6OveiI6NPCQAVxC1+H1SI7Scx8roQDGqsX+TERFEfYuf3PWQZMid1LuDcsF6X6WoW4aXUu80Z5oOed35uOA0Z0UFRyTudjELmzqncX9dvGktaLbUgEbhsXn4cIOBv/JXugyahSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC7Fctfw5taEfdIqlbmsIqct56bgsOJjsYZEIV09zS0=;
 b=k/6OA99N5WDHuVdp06WUXrkE5Od535I96K23eAkN/261o4xub4Y443y6OeJe7Xw7dVobyb3FLi7ACYr5eKukWgRlxKwliRAxNKtjyXdvdAqHNmW0ti1ktSrKllrtX+7q8Pfpc2va1n7UtdnjK4LA3D0grRcAz7/JsLXgvk3jibxTHKw8xxkHIHAcI79+KDFsQHTz2yP4bMaJRREbUnAgap3uyaS7ExNYpjWKwPAWq3v0o/ZnZNAL7LSJR39eSafvordJsm4usFoxudZ3i7g17/xMeoMNHT4cmtE1m2cmJ1wl4AcvcckfJPQu11V0F2+lexTw8CpGfrPIpchAH4tKFw==
Received: from MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20) by
 PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.8; Wed, 10 Dec 2025 02:45:54 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::9c) by MN2PR01CA0051.outlook.office365.com
 (2603:10b6:208:23f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 02:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 02:45:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 18:45:52 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 18:45:51 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 18:45:51 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: [PATCH rc v3 3/4] iommu/arm-smmu-v3: Ignore STE EATS when computing the update sequence
Date: Tue, 9 Dec 2025 18:45:18 -0800
Message-ID: <7c0b9c00d50ca22b078117f7f1b9a49cc41eec2e.1765334527.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765334526.git.nicolinc@nvidia.com>
References: <cover.1765334526.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: e6cf97fe-1154-459b-51b7-08de37963cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e6WXNJRS8aKg6j65f8lPv5ZUX0o0CgeQGNZJphU5NvXH1rkHs4Nvlth1wywp?=
 =?us-ascii?Q?hdU4mXpT3OuQZAZWEkjHpaH1diwyCaj1rH2IzuV0hPTxzmp4QC3OoPkhKvc6?=
 =?us-ascii?Q?UPATNHeYhiO1ViNrPOSSu8IIpRKVAmlDW8BXf6C9X9LJevX8lkUc8gvyiszg?=
 =?us-ascii?Q?nwbyhNj6WAfbdZGcS6hLl+VEz6gxr3pMjEcRGloFO73JninAZNeUTFukzRRd?=
 =?us-ascii?Q?OdavNbACNcYm5+11GfbhQLjCw/dA4j4Hs2EIENlWEHJidbL4YZNSlZLXVbxH?=
 =?us-ascii?Q?NKBztTNqbO3fWnlVibfzpxaOu4AQVSAB5Fr/JU1T1M+W9uBT4rgoukQdcrSI?=
 =?us-ascii?Q?dOOD9jrtI9i/icFcikg8cOCBmwdqjZF2dPgWgOrSnRoUqZeZeAThhcgoHQuc?=
 =?us-ascii?Q?5X7lK8BzwDN60f9/jdM30Gni133mLyABRA5w/a8omnX7UWOmBes6EabBRcNl?=
 =?us-ascii?Q?nmub/i/mcLrc/eJvm1qAbIL2d9VZLW67OXhig65F8MUhpIQ7F2SUDIlQILP0?=
 =?us-ascii?Q?L7KEY4l3fq9F6FBOlt58ePB6fTm4k/yzbjkIigbAMJuP7OFrH/oX1VHoRZJB?=
 =?us-ascii?Q?6TNHnhmr9Va3zVflqO89qp5ka5zf4+nOQOvIjDsYXGlA1+93tmY44/8JcW/P?=
 =?us-ascii?Q?VtPn99eU1SLv5dw6vpwxBL7kh9tgPZRMHXhQ+5d159Xtk2a2En700nILFCYs?=
 =?us-ascii?Q?Oa6yLbiWPzcHjrrEibsiNBueyxPcqiKx/ZakHEoOGulsd7jCkmvxDIHq11fT?=
 =?us-ascii?Q?DgJOFAJyDESN80dfCbYQZnCrHihXrp3Z/x6MOfUjTkQXyYnXrK0nEywNXgfZ?=
 =?us-ascii?Q?Asz91XtnJFk07Dve5C43gLIvMhaLaXq0JuvSMrV7rPYxNR0+9Aw/UpegkPbV?=
 =?us-ascii?Q?CJrOHi02/mOtZF25UUaiVHSgF27h32PxAF+tdqDIm2nfeV9TV9VYljQOSTd5?=
 =?us-ascii?Q?SY0snDlbpwbqMXaXCihdeQvFOd1WEKCq47ROWzwHibpUK6ACC7jTj7NuxSV7?=
 =?us-ascii?Q?v/HfCKNo4N9xh7nLMQKHPO/urZsqp2GWvG6dou37eTa+wwvlrcwa2zN2gbL4?=
 =?us-ascii?Q?fYmmaUPZiG6zfWzFRxI2K+ulUOVMWYrarWe/etqRQCnETL1TjPhapFUf7hYJ?=
 =?us-ascii?Q?nFVxOf/5b3/kwSUSb7j5Pxu/f41jZ4lXmB4FMBtXc961GOQFio6tJmPZ7EDB?=
 =?us-ascii?Q?MycQV7/w09Gr+P7wZWY0JOnzmjIoZmZgpOjhuXTR3b76k4Ka0UvRB7mk9O8Y?=
 =?us-ascii?Q?h2naxcN65Y8PCzAN/Gom8CcrTP4p3yuCb5xcnhWwyOtagMCBw7vKbxtL8+LZ?=
 =?us-ascii?Q?cCWJBsv6cG68XD2I3Oo36sJAmk14GdUdSCRM1PD5E79+AjCNPJG87dKIiQa3?=
 =?us-ascii?Q?1pbWZtjqmcocnwoFFn61fsX/vXtQBr9StmHTS6N1QhhrvYkoQx97snTgSr0v?=
 =?us-ascii?Q?hV78V8Zo51ScfuuuyoZXdCAonknP2BxgmRTBOBy8YP+6QxEcK4JtL6jvfO2g?=
 =?us-ascii?Q?Ji1TOc1j0Qme9PwzkPNTXsLZR7gX7AXbvaObHAnL4nVkr3IF3wutmX8zTyop?=
 =?us-ascii?Q?E2PuC9OCswfrLc6Dr3A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 02:45:53.4909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cf97fe-1154-459b-51b7-08de37963cb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282

From: Jason Gunthorpe <jgg@nvidia.com>

If a VM wants to toggle EATS off at the same time as changing the CFG, the
hypervisor will see EATS change to 0 and insert a V=0 breaking update into
the STE even though the VM did not ask for that.

In bare metal, EATS is ignored by CFG=ABORT/BYPASS, which is why this does
not cause a problem until we have nested where CFG is always a variation of
S2 trans that does use EATS.

Relax the rules for EATS sequencing, we don't need it to be exact because
the enclosing code will always disable ATS at the PCI device if we are
changing EATS. This ensures there are no ATS transactions that can race
with an EATS change so we don't need to carefully sequence these bits.

Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3e161d8298d9..72ba41591fdb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1095,6 +1095,15 @@ void arm_smmu_get_ste_ignored(__le64 *ignored_bits)
 	 *  fault records even when MEV == 0.
 	 */
 	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
+
+	/*
+	 * EATS is used to reject and control the ATS behavior of the device. If
+	 * we are changing it away from 0 then we already trust the device to
+	 * use ATS properly and we have sequenced the device's ATS enable in PCI
+	 * config space to prevent it from issuing ATS while we are changing
+	 * EATS.
+	 */
+	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_ignored);
 
-- 
2.43.0

