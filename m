Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627D2E0B5D
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851036; cv=fail; b=MEGc6KmZG5DXxUUSYAGiY9TNBImbydigpatmz//QlGcgdw3+LN3vmshjzVy3Xsg92gRMRBvHRRssKI/uYKd686rzFKYXbb7PPnhS0loOnewFZJT4LyoVYSneW8h/ZSUKYZcLKMU4R4lsx0FFwTLPGinDq8+476Cgm2TLuUqR0ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851036; c=relaxed/simple;
	bh=F5jsSEY7LnQWoiil1dRfnA847Be//B6yD6WFWEiu5Gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfxODvq5cyZ3Ye46+do09iuHUH41lDURl41IilTEHZ0lFKxbbL21GFL5F3dWrt9bNQ9D2nxU7CusnvOpp4N3hnWMuxXN8lFGb6qoSOJGxDDIzM5j8zOpV987lfRIAeAvxMU/JdmU5DKnYoAIEi4iwnyWWQiY4d+oYTDeZeUlAWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hI/5weyh; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hI/5weyh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Spn00oa3gZSknq8CnkpcP9TuvrF91dy7Dgdlyjn0b8vZBh+iz23kMObnoEBx8KI0kueOJc9V/KGGa6kFhMAzO+wlRD45kQWl7Hkfvu9O5WFDXYOrGDm71lXLM6+9PKFRXOuQHfUgMSGn5MCSucNuB20onxiVjLLpUQ26/GMk6zi8YMHLmv6xey/8bDlwA0CyAQkFCPiiiTWv87d4KjebKTpdrA8sOmXKiisH1hvOTVhM6XZI6pqYtv2U5Bt8YMg05HxvzA/RO6QpSgHKPqpo97t886Ckvl1UKWvuAR38bsTW9FNJizKkQLMooQp9t1G9dvex9hlL5KjjFbV+/8Mx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaHg3032du0y6lTEzCapP5RxUEv1RS9JNaeHEBtmNGg=;
 b=RRHPcyF1PLqHYRzNSirbPXo31UIELmPZlKzPhAxCn4rtkpInBmkpotSlU+XqsEZmRL9xu0nXJGkHraw1t9jevHgYlgf3i6RIzJKonAZkuv4I5yVaX1K10zlVav8OlDNmdTUA4+7VbkNVNnlR/qEnDXyUlFdUwBZ6RaGVZR5x9v2gnMEzXyClLZ+igxIlfirro3OGCEmnOATGDMmSGpKXXaHtvPT6FxLO9vn7bqFAoXtg7CSDEuNLFKPXXT+LvXVCjZU0tNEMHzJkCAuoBxmup81URWFTNMygh/5M2L2c3R5K/BbzF6YRH/DFmbAmeq2s3mWa+BsdEnCymOH3OZLztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaHg3032du0y6lTEzCapP5RxUEv1RS9JNaeHEBtmNGg=;
 b=hI/5weyhkSCSbjq7jA56JlS9E1cgf9fOT795PRs5Ox6jBgpxLPCivgaATPYLeOXOfztvvj1FcbdU+fJg3tujwZ+DodZkvICMyz7ex534uWCm6D3OQXCaUDE+/t/8fckU0d5X/8lH6YHraFxU9c7uvDL4Fz0OSRWPh37LkoDdI3L4hYSLyFYLGOJ0rpwpcNaoP6xuLemdCstXaYB8K/yMTWOfTzFcClbUWTXiZIxOhuvE3edAC3uXHyyOD3atW8PlHjx94HFPo7pjMAwE9h2BqWs8aDn+Lc4FL8sGh7LGWCO2MCiN9XB3W+ILV2wh0QbMlGYkM+b0+DI2prbfACJrjw==
Received: from DM6PR10CA0007.namprd10.prod.outlook.com (2603:10b6:5:60::20) by
 CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 02:10:25 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::cb) by DM6PR10CA0007.outlook.office365.com
 (2603:10b6:5:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 02:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 02:10:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:08 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:08 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 18:10:07 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
Date: Mon, 15 Dec 2025 18:09:35 -0800
Message-ID: <f4261c5b30ce3c6942470433033d4933ec5eef3e.1765850465.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765850465.git.nicolinc@nvidia.com>
References: <cover.1765850465.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 458f7d5d-3896-4b35-7a62-08de3c4846a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k+gzzqit9ZWJHwY4U42YNGN6Z8aRMyfVoz1cnRCFhiKzRpja0FFcdIukk4IH?=
 =?us-ascii?Q?hHFUL6Ro1iXdV1OZTUEv8oTEcXdvhQBSt+5BE5zWgamvRr7QNCDtfzcxb/x9?=
 =?us-ascii?Q?ySwME/o4LE4FYLccWSLjn0F+ogq3UGI2hV3GZ4H7Oam9bXshxgoTfY+Hvq5V?=
 =?us-ascii?Q?s8/KP+7Ag2+Yq3C97OO6yoSvkIKSRCozef31XBo6lrBHRj/3ODvO7XCVjPem?=
 =?us-ascii?Q?O2n8A1cthZMcCzdxI6gugrZqVOuflZAJNAH9gg3/TNdHObXqhOJfAQ2jwtTv?=
 =?us-ascii?Q?kdRWea3UykZ25VFq5wW8zk1ExkneFhYSB8T+Qbmqmn0BrzMgEmeS4P19eWUk?=
 =?us-ascii?Q?jyC8OCLEQ5AtyvXCQp5cBZ/J3ZnVelyFv6g/Ds/6uDqzW1YdN2WBZeTCK23S?=
 =?us-ascii?Q?XZl7tmOClGxmuEiojqvApkDEU3Le8diW+vc4ZgIp+v+8ntZPxoQUzOFsL9uJ?=
 =?us-ascii?Q?VGBcclWR8ZbP3VRVHk1NQg5NoIPN4BTnFfUb+6pyWpnA9vJjUbowoSukIt5x?=
 =?us-ascii?Q?YMvmvf8sPB3CByy+K1YQfJvd8rTTfP4Xj6KbaGu5KIn96XYS52+2GJ1aYLJu?=
 =?us-ascii?Q?QwDdj4NOOjEXbsHerfqwps7BOE+ZB3dxvnu+2wVJr5vNgmAPdJBQ3RZ4HioO?=
 =?us-ascii?Q?b2daQlJ9Ep7H5Tlo0tkThVcZtPbMnnx9uz8lOuVkkyloT9nrqtSCJdt2k5h2?=
 =?us-ascii?Q?3w/ViDjbL2CSDhUrtLQFZVBAoKzyWrQqXxyHci870TJmr1hl0nz4G7hQ1fYs?=
 =?us-ascii?Q?ODpsTc5Q70LR/LY779Wm8Jt7plfIEHdg393h4S/atyddUsHyPDcpVO8YVpy2?=
 =?us-ascii?Q?gLw2UcLehFle2i9YO5l10nRjpbJ9llLDUJjVe7/DBkYej9kJv+4QWPOMW4pw?=
 =?us-ascii?Q?+BPfXWPTg4A6brzeoADbAKWwwpYfRoSq853pWTKjJdh1K3TQdJPoBTytlXtV?=
 =?us-ascii?Q?RYwSu003iNDcw8mnTqnS1InzBD0N9tOYTWgWYpTgFuBSOZ4GVXcJae5OCAqP?=
 =?us-ascii?Q?gb5jVaee6PaNbi9H8P+99ujEI3HJ2QNB62C7bkGHw/e1TXPEx3zDDqUB9Cd4?=
 =?us-ascii?Q?tz8G9aE6y4lhPBIJNpJA/tWO7VYaOYL2dnxdr8ahNqKnJMJqgG5MGMcXJH0l?=
 =?us-ascii?Q?4rp/DLDdmMZZRfC2RbJbyr6uo/voNHMgLHTXdQroiQM5lTZF4KmiD4x8XRR6?=
 =?us-ascii?Q?SitjNnWhb6g1IRBbxauPtGPzLV6/kOBVET7huPBpVE6yXCPSz0ld6Hdom3Zl?=
 =?us-ascii?Q?MSMM+Aoy8SB7gcUNCI4Zxc59/3z1UH7XQqRmiaV8TOsvNmEimtaPMNbAQFi2?=
 =?us-ascii?Q?HR9tLxACcSgcj5AcY6hJdU2EYbP7CR3IYSEzU1+r9zsEJQag0bFW4HiUCX2D?=
 =?us-ascii?Q?gJz/PGcXiJvoHrb76YPy9lfZsEIli6ffdotFxlq6zyPdJBkbwHLgJ1G3gRQ0?=
 =?us-ascii?Q?I72vUwdswHezxAaPN6UX/TYx1CIm2MgbUGQB3NBUgqbzF9ZxWRGZj6gUxlBd?=
 =?us-ascii?Q?nINV3s38gn91naCF/wcwruTGtM/T8fkGmQ0R89YMvwG86v5t4Zz2LJQ2JMp3?=
 =?us-ascii?Q?V2NY8qXjLxNFuSLvYP3tuZzH+R69EMHi+WWtXauo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 02:10:25.2161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458f7d5d-3896-4b35-7a62-08de3c4846a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755

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
index f8dc96476c43..c3fee7f14480 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1086,6 +1086,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
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
index 9a2281b5d9da..497dce3c1812 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2516,23 +2516,19 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
@@ -2552,8 +2548,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
-
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -2581,9 +2575,26 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
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
 
@@ -2639,6 +2650,193 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
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
@@ -3280,6 +3478,12 @@ arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
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
 
@@ -3329,6 +3533,12 @@ arm_smmu_install_old_domain_invs(struct arm_smmu_attach_state *state)
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

