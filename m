Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466593BC4FE
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501443; cv=fail; b=CrZRiQwzLW8IDLjRhHCjmB/kiThI1zf/eyjaVCkdyFY1XudX3gCTBgj8LujAIlo6bR4qzposgtqdEd9ofMW+8NPDqYVDH7Wcz+fRYmO2bLlt3+I7C6IWi0dIUlmyLkGhXQ1g5PDqMg1NASRYKRe6Tl+MksXeDMKI2Eaey5f/zpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501443; c=relaxed/simple;
	bh=KG7WvgpRkXiflCrRf5I100Oo4LrmEhLiuCFobIy+MhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5Muo9ygk6laAZprryC02maOCTfUEWFuVH62H75xFCSMa0dSugsd3IlyurfL6rdYvbSwlWyWkVL8f971xs3vnHtNg7eJzJdPfYk/IxzJTMadEFz88EJbok7X9Zdf3ABhatPW/ft7Pc7dkh752yERW6301t1IZyMY69YTJ1G/RIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZNJB4QDx; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZNJB4QDx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTRuL40n+Jp8dvW8Iiva9iHXP5UgLBFticQ3jEGgP2NgarFKTLZrDq1FK6m+CYIeaGVAxNBLD0Z91jrYAqCbuqIGyHnXHpnu6O8oyK/qSRClZHLJpM2khGiZVWM+Ewyh9Qopr8ERX9FOvmIlbC/OkzL3g4F4qlP0Z2HlLb1HLvHQPvhM8iMaQ2dCE2WKcsRM7wW/qYGam+jZMaZVcN1bpAu7GVppkMWyiRmTbDUjfBoJdgn9yC1LFExTCQArcjHvzhatVt1xr2pHzqAy7ysPjREFxz7WVh+zj/Hruq0XpYOiG/gb5tHtP8oMtk/8ze/mAPxagmsDfbwWdG0ET8e9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyzUJ7xvmP+Rkm2sqUPv0jYU7l6h0pxJk2/1lJeadgM=;
 b=kUOd6doTWOR2pc+ydrofZ+VWyEvuLfc0lY+uAdmOYT80dLQ28JfYwD1FRfox70F6pAHNyeeLt7D6gvqPPH1vmw7oJa5Ncb8QjG8YXZK2fiCZYenF9GI9mJIev3jgXw5YZKOR1vhy9h1xNLQkWPXDYGqziYfqJavUciWh5HUwe1I/WROvvt2xf3AbB+5JTDSsPFyJj5fZYTR2bbghoP0+2c8++JYaQbrdMQ2TjwlNCsAx83lYsm8KKbVZmlc2P4UcGqAz4kNa8lCGmieL/1VZtTAtxto1fhenbFAZgoXhHbAlSRZiBQg9PXCQs8RuqLnC+T5g0+uGCYZlrTmdhek52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyzUJ7xvmP+Rkm2sqUPv0jYU7l6h0pxJk2/1lJeadgM=;
 b=ZNJB4QDxOE9f3TgjwXAlYV877xVZMxGYFN5PbMm4AJxGi2SIhkd5PVAlFQkiW45AFYEK2L39/bpp/4yOsssj+9doZmz6QtY73w8JnWQdQM5Ba4ZBj72ccX6NmD+73tQ9F1xERtP4ewP4eM+QC8SyaywpI0IacCpdXBBbHYPw2dgFeFt2dJnS/U5TSTMWbDgD2my+Mbsh5jRjzAWwEC+nEugGPQ6tpBuFo3gvrzOzCilvsYYpr4eiaRtJ0s1Nb6fNCXaJrVbIic630vTAi4kvbhA3xL+m31/3UmhSKzxnq+Q59kmNv5/9M7FBp2mhBsgCv9VEuahgr3DtlHXFhPAvqg==
Received: from SJ0PR13CA0102.namprd13.prod.outlook.com (2603:10b6:a03:2c5::17)
 by IA0PPF95ABFC125.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 18:23:55 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::56) by SJ0PR13CA0102.outlook.office365.com
 (2603:10b6:a03:2c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 18:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 18:23:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 10:23:37 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 15 Jan 2026 10:23:37 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 10:23:36 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jgg@nvidia.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v7 2/4] iommu/arm-smmu-v3: Mark STE MEV safe when computing the update sequence
Date: Thu, 15 Jan 2026 10:23:29 -0800
Message-ID: <5279777e3fb9b8ae703e72c53d8a6a52f466001d.1768501336.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768501336.git.nicolinc@nvidia.com>
References: <cover.1768501336.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|IA0PPF95ABFC125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9591316f-fbc3-42e3-99df-08de54633dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0K/FWyytt7mH7tpqyR0XrDcKJ0CFLF0BuumfpFouEbOaF6IEuyMeVrfeiH6i?=
 =?us-ascii?Q?GNPMcFrrU/VCaIBJo7FhktDKLucQMFKp6ZluM+vVprUU+jYSxyYA+Gbu6W04?=
 =?us-ascii?Q?y6iBHTrTaZD3ETW4sBRlknhe7lBAzsM5N2WDFrlQg1AWZTAqWaxLcwAQMow2?=
 =?us-ascii?Q?P7xCkngpGm3BbD9NiZtmrHWCb5bn24AyGCAbiWb59zZYueJ6bBEceB3PAD0R?=
 =?us-ascii?Q?vofjSqOrwaVXoIL2SuFcwe+qLhf9HP5WX8lwKFvyRfQC1GCCJva+ZCE/JtR/?=
 =?us-ascii?Q?4nUhsMtqDJBbpIfkgulntWm1YCYL/gQrTFNDbvFElcz2/rNJkThj03Ij1eT7?=
 =?us-ascii?Q?lhTc+VGPKhyJREh0isdbjfa85nKpP3EpRFBnAJpg/bWVKOy0YhrlmRr/gnpj?=
 =?us-ascii?Q?cTRjQ4GlRkXnRlKPHAj55mul4CjiAhGD/7f16pzHrlDIv2cK7Uu60/90WswI?=
 =?us-ascii?Q?9bP0929u8fzugsV0LKgUN2YdQpIiSc55f10nRLsmEVzxHzEyqJZh+kmBCV9u?=
 =?us-ascii?Q?WrsaTpqXDX90B2uLYxw+77zTENs+rHjiK4XfYf5FXHjF2jpfgvNhylcM3mHm?=
 =?us-ascii?Q?MQd6yMFAJDO65jPAMNjN1gawG8xEiUTVLBODQk9Iv5HUGjGzhkBxjvBcechH?=
 =?us-ascii?Q?/wtcW7E0z/9SkrA9pkNAOgG6gEAjIXIIYSqtkXaCxi/8AXM0nVMNuyzcKMfC?=
 =?us-ascii?Q?Zl4v5uz9sJW0ZnLO6PgFTiQic4Ab7ZG40ZPvnGJtOSSyWhlCnY0z5BJHgLkc?=
 =?us-ascii?Q?Th0nxWiHVSeXiQ5tjSDdLbQQw7+47SCCjb/TUveorQGKCHh9qJxgHlDDOS1J?=
 =?us-ascii?Q?t16CpTKkgx2wrUhNzPYjenXcr0BvdYNaNlrExwTQduFlDHyT++z9wAIkLyBC?=
 =?us-ascii?Q?m5gnLyEIpQiAeEuDYbhqyyoDJ57Eye5I3Mq1rtYbhbkbG0Fd4gEfV+keRHIL?=
 =?us-ascii?Q?d+8miovxW6NEC1kzBwieptZMoR7IOt4QLluvfb+Ifol54HYw2o30Y6kFGXis?=
 =?us-ascii?Q?msJYRNxag6dnxW18aeIEaL6ikOyHgZ3JcG3UDRXoYUpBQoI8TyuZM+wa2zaN?=
 =?us-ascii?Q?WlA97PTs1sFntXB0VRh0RRWur0rQG3d1UTYmU1WxZhHHJW/w67kxrBO421WO?=
 =?us-ascii?Q?3haNC0s/rWph4GCD66COxRRWpwhHRVHXimtOePAuA8asbB9hEYW1cluDFQ0N?=
 =?us-ascii?Q?JSDQPhsksfxuwQeZJ6IcfvKGznZ5BpC9c/V9zKBqhHK2yp2fGheLjxF7EJKy?=
 =?us-ascii?Q?lsL6EYI5BK6OpBmxOZB21jUyDx2F1COtp0ssj7MQ2IEaM6o08aG/4VgpNrSa?=
 =?us-ascii?Q?kfuTbZnsBZwbCgPsw+hWiuEfWXtpiQWFnQy+jdS7r+LjWDnkk4VjvJNRlBa5?=
 =?us-ascii?Q?vpzGHiN3rrHbQ7NjYPdFknCbZ/k+q3e3j0NHfhnBdxquOSSdrcW+6wKQIMIW?=
 =?us-ascii?Q?+SdCUU+0ss4j252+OmVwWuCH6zqlEykp7yd+2FnTOlWkmlV0EwFjAYPgzp+T?=
 =?us-ascii?Q?sC0fP+Ua92WVKvlHALyuXwRWcuCfzb6vmKRBI4z2e845MeIJcwl5uwvNFwju?=
 =?us-ascii?Q?CrjVe9TT9C+XZ5fsxcUH3dcV6UNs9GHNWROyZA9+sTlWJeKzIijIqb1f64An?=
 =?us-ascii?Q?pmERYU3U6tfU6Pf8+kMKJ/CrzRos+9pPunyykqtyqPalmHctMoEy81QH9wqC?=
 =?us-ascii?Q?DhwuyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 18:23:54.7737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9591316f-fbc3-42e3-99df-08de54633dc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF95ABFC125

From: Jason Gunthorpe <jgg@nvidia.com>

Nested CD tables set the MEV bit to try to reduce multi-fault spamming on
the hypervisor. Since MEV is in STE word 1 this causes a breaking update
sequence that is not required and impacts real workloads.

For the purposes of STE updates the value of MEV doesn't matter, if it is
set/cleared early or late it just results in a change to the fault reports
that must be supported by the kernel anyhow. The spec says:

 Note: Software must expect, and be able to deal with, coalesced fault
 records even when MEV == 0.

So mark STE MEV safe when computing the update sequence, to avoid creating
a breaking update.

Fixes: da0c56520e88 ("iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 390446d259ab..ccd6357fa5a8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1086,6 +1086,16 @@ VISIBLE_IF_KUNIT
 void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
 				  __le64 *safe_bits)
 {
+	/*
+	 * MEV does not meaningfully impact the operation of the HW, it only
+	 * changes how many fault events are generated, thus we can relax it
+	 * when computing the ordering. The spec notes the device can act like
+	 * MEV=1 anyhow:
+	 *
+	 *  Note: Software must expect, and be able to deal with, coalesced
+	 *  fault records even when MEV == 0.
+	 */
+	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
 
-- 
2.43.0

