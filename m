Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE92F5A08
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 01:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119470; cv=fail; b=sL4xMmYWfveZ50tw8KHO7aCmrE9MDnW3LiAH+KMGmpZ20CjMTs92uZ3sJFi3UEHeKRnaY+xN6IFIB4wo+5wD1TdirI1HScdala39/kehgJjthTxtgFBCoCxGf5kAzbIncs8h2ztCSjAI08/xdeERvg5EHPI7X40eaGm7kELwUng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119470; c=relaxed/simple;
	bh=pDfiN5o4VMyWDIuYQ77tDqLMwZAFud0k/okgvmyCO/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdnoinEm1et073MITj+IVM1+4Gn/BdF+0gyw2AsA9KMWtPdtzXsV96el8tNbgOEYE4Z4dQkcOqQuTcZi6FhyCcZR8H2unc15KBsRbjvg3HRnlEJLyieddirqXzXVGm/tn0nmcwbGTQn5QzfGQcqN65CoogsD6XdxotMq+a2EVPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EbsaPJIk; arc=fail smtp.client-ip=52.101.48.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EbsaPJIk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZhmof4Z50ORhDta++UU6akTx8/UFk0VtFDPPe2I6udZwo5cpi+j8afzbibdeLPFrGezAvLCUezZZnBBkDFRe2CcSDwQ4XE1O2bhNKQDNCPX8/f4rNM7FoIuIi/jPi4VHicItW3cHb+lw+/FR9DfG+YLlwXHkZaIGeXajKL8j7Ly6NvzzWBoPlqOlaFxWjdDxeei0cWAKqk+Uxlqi2/PJqrUDsKMFix6xqryhEPEEknbVAect3c+AIKeWJ7lOQ2KNb35kDOogUR6t6imhDPiz1YApFnYTa1uuCbNjKybMUIlHKh/7AW6B5vgqSb6/u3N1E9eaNtoGBnDTO3Ipxw3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRvb0O132BqC/sFtcLzqAA9sF0DXX065fhE+8OVxcP0=;
 b=bvrurxh+bndI9E5scOGk2E2SyyPmZiEzxksmpT/JV2GUaFRVO2SzwG+6AW8n4wRd42kkQRQKhU9i0yhlDcEDfLteXyGI7YjMrIgBKhiy8vhnJNRgLDKsgiLa5PfUYkFlZgMVvbWHdqV11kXZk/AGckl5zl4/nBiwN0yoXCKUC55Anwyl+ptXwLFrxoU0qKliHEJPGTA4orq+5R/OeBAcnl0NNsj03wsFVU1yEuKdpo1T6208voNfs7wb4qW7oOkKyHobbmS+/GcWwhuvTVB5eEQBaXlnQSgUgcNOF6rhak4vxOVz7XkM9Pxw5ec0znJbFK6VdtFiO5dEe4tkt2Moug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRvb0O132BqC/sFtcLzqAA9sF0DXX065fhE+8OVxcP0=;
 b=EbsaPJIk30ULT3lzuYlYL+p0oVFhYiGbHl9kEd/tVOyuZ5wa/e2iM7jB5cl38HZA80+/a0ZV86Fs9lyOrkM/ocfBHX5A6qS0OXAGGprPAUDF1Vm5LbAPmAnP418+uDVm+RoMJBU2iVmi5jWr7AbS+m8uOAlVM9T7nONvktQi9mQHgRWAy2Jo1Q0EGGO3hgsEY1YRoWHpfBxat0NtXlzNq5GqRT5tr8flVxSQbQCfacva0LsHYStASOGoDptsuN/ievmIIvOU2eVqVuGUTtRBIvDDx8E7bmafNlEQH9JmbKcJ/4MafBy5Po6YLg256KRB2eNmewkixAdbqW5qtCiSyw==
Received: from SA1PR04CA0022.namprd04.prod.outlook.com (2603:10b6:806:2ce::17)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 01:11:00 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::ed) by SA1PR04CA0022.outlook.office365.com
 (2603:10b6:806:2ce::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Wed,
 26 Nov 2025 01:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 01:11:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 17:10:43 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 17:10:43 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 25 Nov 2025 17:10:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
Date: Tue, 25 Nov 2025 17:10:11 -0800
Message-ID: <3bfd8f82d199aff80c5dac79ebf1ec574d0a44ed.1764119291.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1764119291.git.nicolinc@nvidia.com>
References: <cover.1764119291.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: d9810ca2-07bc-4ebf-8eb4-08de2c88a9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mr8zD7WD3XntwejPS7BatfZbjD39VuDnkAHwKU3kE+RJv11UAPLacrcKGYo/?=
 =?us-ascii?Q?yVa2XPf6dT/UsyBHKEHhO4KUu6tbZni/+/OvsnxjI6zegLtnrihM+7n8sg3K?=
 =?us-ascii?Q?xC3IwPeC5JXCM5GEChHt3Sbtdd+5a52QAryYMww7QrS+EAz34y08t1A/k6Lh?=
 =?us-ascii?Q?9E7BYM4ZddKbhSLrG6fpAkdCVghnKHPUJd5sv3OI7y8FRgtKcs9Nh5uU9mQF?=
 =?us-ascii?Q?d0lT+PUz8R9y0LYSZo3y/WlVK+QZcz7mB0yL9Q/f0STa9MUodfTaExsgWxqq?=
 =?us-ascii?Q?sPD0e4u0iRH5BVYcA8RPNA7IIU6h9ktAgxgy7QqFSthh9VVsT1KfQMhOHNcY?=
 =?us-ascii?Q?zmuoyFhaj3KXRF3n/elipmn2epPcllX+V7KC6P8M3fXZnZfvsWatQpCnXHP2?=
 =?us-ascii?Q?/DTUTFxa5pLK1mn/Mwatjvo6zPzaEq9+9faNdAkMZoionjUCguMQlBH0kr1c?=
 =?us-ascii?Q?xZk2UKkhJKSWwURCoI2JmL6gJ2a/A/en5xJTbvuZkRhdrcGvB1IBjzy5/ceh?=
 =?us-ascii?Q?MXR8Rs5cZuSop5vlYFVUjCIcDFy8ITRTeM8UL/y17E0uguUKD6mctUJQYIHy?=
 =?us-ascii?Q?wzXhnDPI7B+AP3lWR3h1xwAABA6h3Qo3VjUw71OoTxfYPXIVOQ8jidDT7Y/i?=
 =?us-ascii?Q?MEVESJh5o62jIUf6LuBSuhhTN7Jw8g1xAtYD5HkgCvgbEm0rZMBcudwdfG3k?=
 =?us-ascii?Q?tB53LyQaoLwDGCbVEu6lcYBWvbxH3360+/r67RSZ/QhGX56IH3ozBm7PtNVm?=
 =?us-ascii?Q?jZAZbX7nhvKWLkgtrUwZ6InUMPeIh4aGpFeNwiA/KBwfph5ZIkRRJHEuHmja?=
 =?us-ascii?Q?RKOh7TWkBZVQwjhowZC4A//2kubJqzqZU4DbGPTgnudCwFE8+/wBZL7QHhSM?=
 =?us-ascii?Q?m72s/0rnnIPJwtZ6LkCFHiUMs83mtjXxSlnaX8WEE65thWoe7bgPt70BbWx4?=
 =?us-ascii?Q?6lWRgDxRpbCN+p9UNGkCs97vOlpvobiiuxXBng090PtU7LQcE55CsCFwweF0?=
 =?us-ascii?Q?NxBKGdi9CK30IMcjGW36ImAlkQ1C1YjUv1UAQSrqCWC4UXn44gSdYj9RCQBb?=
 =?us-ascii?Q?8MLljo+P9r8GPPlYkJsQEHv4dbfLkNY8uLD/ssZ18lF3GJiqn0xjjNJHsk5e?=
 =?us-ascii?Q?jvNlMoQ8L8B0hfx5L/yfWwe7Ewo6Z3Z08W4HlBtmG6FifZJArLbUWp5YRVEg?=
 =?us-ascii?Q?v0q6NQ9H5fAABICDNisUKEAcHaHFc78/TMtCDlXVv5x3FRh+Ic7jzqkjf90+?=
 =?us-ascii?Q?hKyiUULnRRySht4M9PTqpqLH1YbnHRgUAh+eA0uuwDOLMEdGv9ZtmHIqHoiQ?=
 =?us-ascii?Q?euJILk6FUpNkTTBZimI/gntzDe/uS2LGylDOQ4jQxyHF5FkZ2bis76DSRlqZ?=
 =?us-ascii?Q?pJkXpvNlm2ZKFkOKSoBKVZHmpB7nLKfYu6mI5S513HD9DwY6lHZtlft+Xahh?=
 =?us-ascii?Q?WDWN447c6kwMxZRNedlO/9jySFpLLs2JfLeJMfG//QATBiZQ22txnH/ehj4F?=
 =?us-ascii?Q?Q+EgZq396kxcO56cAWVRSbBzAfz4haeNI6PPzoNF8EkYFjC+Sr5+uO+n60GJ?=
 =?us-ascii?Q?UzNwnP4EHFWnfYizV1BcE5aST5DT1MZuZuPMRDh8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 01:11:00.4859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9810ca2-07bc-4ebf-8eb4-08de2c88a9a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714

Each smmu_domain now has an arm_smmu_invs that specifies the invalidation
steps to perform after any change the IOPTEs. This includes supports for
basic ASID/VMID, the special case for nesting, and ATC invalidations.

Introduce a new arm_smmu_domain_inv helper iterating smmu_domain->invs to
convert the invalidation array to commands. Any invalidation request with
no size specified means an entire flush over a range based one.

Take advantage of the sorted array to compatible batch operations together
to the same SMMU. For instance, ATC invaliations for multiple SIDs can be
pushed as a batch.

ATC invalidations must be completed before the driver disables ATS. Or the
device is permitted to ignore any racing invalidation that would cause an
SMMU timeout. The sequencing is done with a rwlock where holding the write
side of the rwlock means that there are no outstanding ATC invalidations.
If ATS is not used the rwlock is ignored, similar to the existing code.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   9 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 236 ++++++++++++++++++--
 2 files changed, 232 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cfd5036e3da6..ecc49ec99df6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1085,6 +1085,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			    unsigned long iova, size_t size);
 
+void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
+			       unsigned long iova, size_t size,
+			       unsigned int granule, bool leaf);
+
+static inline void arm_smmu_domain_inv(struct arm_smmu_domain *smmu_domain)
+{
+	arm_smmu_domain_inv_range(smmu_domain, 0, 0, 0, false);
+}
+
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 			      struct arm_smmu_cmdq *cmdq);
 int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d14894b99028..af3d067d7028 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2514,23 +2514,19 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
-static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
-				     unsigned long iova, size_t size,
-				     size_t granule,
-				     struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
+					  struct arm_smmu_cmdq_batch *cmds,
+					  struct arm_smmu_cmdq_ent *cmd,
+					  unsigned long iova, size_t size,
+					  size_t granule, size_t pgsize)
 {
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	unsigned long end = iova + size, num_pages = 0, tg = 0;
+	unsigned long end = iova + size, num_pages = 0, tg = pgsize;
 	size_t inv_range = granule;
-	struct arm_smmu_cmdq_batch cmds;
 
 	if (!size)
 		return;
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
-		/* Get the leaf page size */
-		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
-
 		num_pages = size >> tg;
 
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
@@ -2550,8 +2546,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
-
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -2579,9 +2573,26 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		}
 
 		cmd->tlbi.addr = iova;
-		arm_smmu_cmdq_batch_add(smmu, &cmds, cmd);
+		arm_smmu_cmdq_batch_add(smmu, cmds, cmd);
 		iova += inv_range;
 	}
+}
+
+static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
+				     unsigned long iova, size_t size,
+				     size_t granule,
+				     struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_batch cmds;
+	size_t pgsize;
+
+	/* Get the leaf page size */
+	pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
+
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
+	arm_smmu_cmdq_batch_add_range(smmu, &cmds, cmd, iova, size, granule,
+				      pgsize);
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
@@ -2637,6 +2648,193 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 }
 
+static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu, size_t size,
+				      size_t granule)
+{
+	size_t max_tlbi_ops;
+
+	/* 0 size means invalidate all */
+	if (!size || size == SIZE_MAX)
+		return true;
+
+	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV)
+		return false;
+
+	/*
+	 * Borrowed from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h,
+	 * this is used as a threshold to replace "size_opcode" commands with a
+	 * single "nsize_opcode" command, when SMMU doesn't implement the range
+	 * invalidation feature, where there can be too many per-granule TLBIs,
+	 * resulting in a soft lockup.
+	 */
+	max_tlbi_ops = 1 << (ilog2(granule) - 3);
+	return size >= max_tlbi_ops * granule;
+}
+
+/* Used by non INV_TYPE_ATS* invalidations */
+static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
+				       struct arm_smmu_cmdq_batch *cmds,
+				       struct arm_smmu_cmdq_ent *cmd,
+				       unsigned long iova, size_t size,
+				       unsigned int granule)
+{
+	if (arm_smmu_inv_size_too_big(inv->smmu, size, granule)) {
+		cmd->opcode = inv->nsize_opcode;
+		arm_smmu_cmdq_batch_add(inv->smmu, cmds, cmd);
+		return;
+	}
+
+	cmd->opcode = inv->size_opcode;
+	arm_smmu_cmdq_batch_add_range(inv->smmu, cmds, cmd, iova, size, granule,
+				      inv->pgsize);
+}
+
+static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
+					   struct arm_smmu_inv *next)
+{
+	/* Changing smmu means changing command queue */
+	if (cur->smmu != next->smmu)
+		return true;
+	/* The batch for S2 TLBI must be done before nested S1 ASIDs */
+	if (cur->type != INV_TYPE_S2_VMID_S1_CLEAR &&
+	    next->type == INV_TYPE_S2_VMID_S1_CLEAR)
+		return true;
+	/* ATS must be after a sync of the S1/S2 invalidations */
+	if (!arm_smmu_inv_is_ats(cur) && arm_smmu_inv_is_ats(next))
+		return true;
+	return false;
+}
+
+static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
+					unsigned long iova, size_t size,
+					unsigned int granule, bool leaf)
+{
+	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_inv *cur;
+	struct arm_smmu_inv *end;
+
+	cur = invs->inv;
+	end = cur + READ_ONCE(invs->num_invs);
+	/* Skip any leading entry marked as a trash */
+	for (; cur != end; cur++)
+		if (refcount_read(&cur->users))
+			break;
+	while (cur != end) {
+		struct arm_smmu_device *smmu = cur->smmu;
+		struct arm_smmu_cmdq_ent cmd = {
+			/*
+			 * Pick size_opcode to run arm_smmu_get_cmdq(). This can
+			 * be changed to nsize_opcode, which would result in the
+			 * same CMDQ pointer.
+			 */
+			.opcode = cur->size_opcode,
+		};
+		struct arm_smmu_inv *next;
+
+		if (!cmds.num)
+			arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
+
+		switch (cur->type) {
+		case INV_TYPE_S1_ASID:
+			cmd.tlbi.asid = cur->id;
+			cmd.tlbi.leaf = leaf;
+			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
+						   granule);
+			break;
+		case INV_TYPE_S2_VMID:
+			cmd.tlbi.vmid = cur->id;
+			cmd.tlbi.leaf = leaf;
+			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
+						   granule);
+			break;
+		case INV_TYPE_S2_VMID_S1_CLEAR:
+			/* CMDQ_OP_TLBI_S12_VMALL already flushed S1 entries */
+			if (arm_smmu_inv_size_too_big(cur->smmu, size, granule))
+				continue;
+			cmd.tlbi.vmid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		case INV_TYPE_ATS:
+			arm_smmu_atc_inv_to_cmd(cur->ssid, iova, size, &cmd);
+			cmd.atc.sid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		case INV_TYPE_ATS_FULL:
+			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
+			cmd.atc.sid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		/* Skip any trash entry in-between */
+		for (next = cur + 1; next != end; next++)
+			if (refcount_read(&next->users))
+				break;
+
+		if (cmds.num &&
+		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
+			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+			cmds.num = 0;
+		}
+		cur = next;
+	}
+}
+
+void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
+			       unsigned long iova, size_t size,
+			       unsigned int granule, bool leaf)
+{
+	struct arm_smmu_invs *invs;
+
+	/*
+	 * An invalidation request must follow some IOPTE change and then load
+	 * an invalidation array. In the meantime, a domain attachment mutates
+	 * the array and then stores an STE/CD asking SMMU HW to acquire those
+	 * changed IOPTEs. In other word, these two are interdependent and can
+	 * race.
+	 *
+	 * In a race, the RCU design (with its underlying memory barriers) can
+	 * ensure the invalidation array to always get updated before loaded.
+	 *
+	 * smp_mb() is used here, paired with the smp_mb() following the array
+	 * update in a concurrent attach, to ensure:
+	 *  - HW sees the new IOPTEs if it walks after STE installation
+	 *  - Invalidation thread sees the updated array with the new ASID.
+	 *
+	 *  [CPU0]                        | [CPU1]
+	 *                                |
+	 *  change IOPTEs and TLB flush:  |
+	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_new_domain_invs {
+	 *    ...                         |   rcu_assign_pointer(new_invs);
+	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
+	 *    ...                         |   kfree_rcu(old_invs, rcu);
+	 *    // load invalidation array  | }
+	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
+	 *                                |   STE = TTB0 // read new IOPTEs
+	 */
+	smp_mb();
+
+	rcu_read_lock();
+	invs = rcu_dereference(smmu_domain->invs);
+
+	/*
+	 * Avoid locking unless ATS is being used. No ATC invalidation can be
+	 * going on after a domain is detached.
+	 */
+	if (invs->has_ats) {
+		read_lock(&invs->rwlock);
+		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
+		read_unlock(&invs->rwlock);
+	} else {
+		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
+	}
+
+	rcu_read_unlock();
+}
+
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 					 unsigned long iova, size_t granule,
 					 void *cookie)
@@ -3278,6 +3476,12 @@ arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
 		return;
 
 	rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
+	/*
+	 * We are committed to updating the STE. Ensure the invalidation array
+	 * is visable to concurrent map/unmap threads, and acquire any racying
+	 * IOPTE updates.
+	 */
+	smp_mb();
 	kfree_rcu(invst->old_invs, rcu);
 }
 
@@ -3327,6 +3531,12 @@ arm_smmu_install_old_domain_invs(struct arm_smmu_attach_state *state)
 		return;
 
 	rcu_assign_pointer(*invst->invs_ptr, new_invs);
+	/*
+	 * We are committed to updating the STE. Ensure the invalidation array
+	 * is visable to concurrent map/unmap threads, and acquire any racying
+	 * IOPTE updates.
+	 */
+	smp_mb();
 	kfree_rcu(old_invs, rcu);
 }
 
-- 
2.43.0

