Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43232ED47
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766014802; cv=fail; b=u1cQYlEtsOtb6bYme+djaGnH9o2qvHXqcGUqAtSvhjHg/06gNMCWtCKI1JXNHZX1gdq2lxYyjO1cb9rEv4fOwFyWgfWKFq96niP7uYkOjIF6rhuQao2P2cApEd7pDSLLFltaBrSB11+Km/I5PS9JrhYA8gfasRhmoFJ+NsjPk4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766014802; c=relaxed/simple;
	bh=vxQgN4bWx5Ln2CH6nPgbSKLgvQ8108MzQzEQ1IBnCZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERTgiIbxZAv1CSUh0KZVwbpMynUX2fOlmRrOp7d/ASmx9GWUnUKCzdQGRA8SuHAevRRk8MHXQKK7K1n/6etoSplH7MNzqhkEEeYXmp5cX8mrkrjNG2JEaX8e0hHjRviPAC6YZSeQU/1SXFfdCtbveWBWGjtonBRSe1w6C4/tnDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SmJ0P7lM; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SmJ0P7lM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hioNKmnhlP6mt5ubOtDWIS4eivQ8clTkEHyl2mdgU3kYnONJtrcQDu9MgXncQVJyQ/cSBEw5R7Y7DsJPhMjYQVpEAVRlOFS8Ww82sJLabOozncYSgViFHfaMf3pfqV0STmt+esMfDX6Jj9lhnUfJVEjzDCT86dBeYZt9tUDya3MS7mCy9NC45FQJT3DgTtrVRXZ2J3bGN+Aspz4ggbq3mlFEA+o3HHg52JdyTdGRq7rZm+cDEKfvN2N0HKkU64ybOfDUGsOyIp6GIq0SnIGuWDOdEOJZDKW/IeM+c44rgiru9NcmzFOlrY6FOXNonqcIbxRI3Ljp6vCVHxb4tVBMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O32R0HOJF3+FQ8WavtJ35swA9YmN6PmkmG4kvKQY/AE=;
 b=GUsU9U7IQT0G1xaOZ+LjpMbHx61N5uSSh71cWwh5pAJm2tIy9PEmw/I/s1Gw2OkWnlLjvqD8P9VsWDTEnmxGHxXErvnwA+qUIqN3UuRHT0Z1UxsC+bW7codSLc0muu/49nriUUWpaREuH3YJ7cexh4KkVkPAFzcLDPITLuCmexEbVQj6RV5emMNlbuM+bapRva2itafNva255Z9ToZzgirKL8hgf7pYNIs1zX3vi+JzOTYuv2tOaFhtBNBXeSyAgBLHBzRJnrYugRB/hEdqysS0Xo+D8PG7hed6P0xW1SuuFywPbMpO7VIWdqnBCO8fB7TtMwHBDtb0A/IfxfhmcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O32R0HOJF3+FQ8WavtJ35swA9YmN6PmkmG4kvKQY/AE=;
 b=SmJ0P7lMvLsJJDzjzRKRdAOP2S4QZnLvWWS552GUtGgKMp6fj0Agz9HDFfNtvDiEofI61DZhN0rHKXh1zL8jjeWlMsbS0Ip8eQPyKu0kNqCvSkVaZY7FBJBg2u4AG+dESAlNO8knum6EiqNwYF29xZxS4sjfW3suirTdoh0JkGiPaLeOKi4XiyTuXVuHDSkigYqw1cZ9TSn/5L5CsWy2dybV6FBaoXj5OdWWU31SP3eh1VmhFwh57ezT7rHvUPLJy27nYlboJ+UNUW/CUhBg5LoJRbOkdErKHxE+WjHcG6jpWiVd6BUDqQzPteVQVRXe71FIDMdl82QbxrhXqQWVUg==
Received: from CH5PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:1ed::24)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 23:25:07 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::41) by CH5PR02CA0023.outlook.office365.com
 (2603:10b6:610:1ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 23:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 23:25:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:51 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:51 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Dec 2025 15:24:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
Date: Wed, 17 Dec 2025 15:24:31 -0800
Message-ID: <d96b106c424b82e1bb4d5d67a47596997dafd78a.1766013662.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766013662.git.nicolinc@nvidia.com>
References: <cover.1766013662.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d2584d-e365-4734-a0ed-08de3dc383c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|3613699012;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?E0XclbhkizRwCFYLqZAymZfXxOAmpVPDOalria/a2fg7WljnZAgue9qbaWtd?=
 =?us-ascii?Q?XbwyiIlpP1pwin8onhO+XgM9QJKehvh48y+9Dh4C2dpQ7WU7DhYMmf1tCSo0?=
 =?us-ascii?Q?YDR1ZtVhuSkWUMVkBKZGYW0VhAI49My/bhOgqTshaI3Zy7J3nmLZHuNyX0jv?=
 =?us-ascii?Q?MEW2YbZBBcIz2gSqTfHtburRHE+5z2l44j/dQeXYR6vbiV611d5airytgWmJ?=
 =?us-ascii?Q?1+ijSeEt1pp4yy2jbymam4p6FMKS0MIW6tTsBYM0pEztOWslH01Ozw+YqOE2?=
 =?us-ascii?Q?A2AbyurfZ69iYJLmshzWW8e0CgTlXlN13Bl8I+OM3TK86krPxrd+X2ZImqq2?=
 =?us-ascii?Q?FrIOR8tiJB7jh/5kCzFyrmkgJgVAWtfgPLwwciY/SvpozjEdeGxn0+HzyrcZ?=
 =?us-ascii?Q?ex4pHzMkwP62W7N/ymTfj+cO625yJgi/7ed+g5vS0AY1cJu8gsB2VPKI480R?=
 =?us-ascii?Q?pG7iAWZP8QsF9EMGLZdxz6dwl4jMkm70D76pamg7ahNfNNBjWEPfnNTRiJpu?=
 =?us-ascii?Q?UMEdv8Kj3EJudJDQxZ1sK17l0l+y5yYL4rXAdC1Fx/SpH9/n5lWrIaNRVLRz?=
 =?us-ascii?Q?+1OlqdWWyOz0ssxkCI/+eeEl+YYTkPCIZxdbCa3pRSTim/QCIV4TMim3p6dR?=
 =?us-ascii?Q?wBcm6GGnhntbK49WAec4FujVm2BaXGYbKaS8PwEV2E484J3y0ne6fG5voXaz?=
 =?us-ascii?Q?PJXiG+kj0Jy44f8pgIhcefEdYSxax5AR/XF9OlNrvO1NLqMOBi9fJEcbt8j4?=
 =?us-ascii?Q?BnG8uSh31AC7qkhosDR/bUlYw7S9yD9UeAP1nNWltdggv8gKQB6g+rERDmCP?=
 =?us-ascii?Q?3X9oYXOHaPh7TzhutM6xO1Qam5iv4cgio0AvS4kaKI7dUrffNpN1GCG8Oh/j?=
 =?us-ascii?Q?GxYwmALoOrvK10FFK2clATNQdUIzmAibkFBejhjexGmgZ4bpoFRg1nFe0pwZ?=
 =?us-ascii?Q?uc22emExJS/eEq7vVZBdsvQvVo/yXtFKE++xjlrCV9NHw9jzf8nX5vTbhuZJ?=
 =?us-ascii?Q?rFznDN8J7uuSv7X5ySHSKWq9NB65dy6EDe2ej3aaxdlkx53z6+cQAgfO1/N+?=
 =?us-ascii?Q?tHyLfxocT0r+pPP72exNfvYpwkNfLaJ5u5YdHQBOwRM9ecmPL07HNV1fbDMC?=
 =?us-ascii?Q?DBAgYoaLdeycwXStxtIIrz0f9yigNADJwVbjDWT5G6AbM2v8/ekBRS8CPIPL?=
 =?us-ascii?Q?F+7FR1Un3AvbjZmL8DJeuzCdNJFstcFg6zpr9jJEzKa3H/xCDGkG6ZvCdwFe?=
 =?us-ascii?Q?gBgGfCUwOUbzDwsbdaU83eK8zIYqqgngUaos+8BG9KiPf9dtPuxV9uqn+Ey/?=
 =?us-ascii?Q?W2Yopm2d94GRfyiJcLcZfHXpgcsoQ3lpwhn3CWP7uzDCiCyrTm5cQ4L+gqqg?=
 =?us-ascii?Q?GYWvrucTpaVWIgGJTULCEz3xEmfZc+yQ5P7ydHqFJS4KM5+IhSIdslnhYBqW?=
 =?us-ascii?Q?4p+IXRuCsRLOJAmZ7t2OH79VSVhzURs4gx8hUXzrRebfx45KSSr0nHVVvE94?=
 =?us-ascii?Q?YXTGOlxOIp+1eiNs7dYJf4W15ykcmw+J40SHMhRmEDWHlEt6obZ8JBcGGJ9x?=
 =?us-ascii?Q?gCHcgnXUm30NB92h/+HLZywpymOscuMPQj8B7FWW?=
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 23:25:07.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d2584d-e365-4734-a0ed-08de3dc383c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
 CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 258 +++++++++++++++++++-
 2 files changed, 254 insertions(+), 13 deletions(-)

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
index 9a2281b5d9da..788c20a9aa76 100644
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
@@ -3280,6 +3478,23 @@ arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
 		return;
 
 	rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
+	/*
+	 * We are committed to updating the STE. Ensure the invalidation array
+	 * is visible to concurrent map/unmap threads, and acquire any racing
+	 * IOPTE updates.
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
 	kfree_rcu(invst->old_invs, rcu);
 }
 
@@ -3329,6 +3544,23 @@ arm_smmu_install_old_domain_invs(struct arm_smmu_attach_state *state)
 		return;
 
 	rcu_assign_pointer(*invst->invs_ptr, new_invs);
+	/*
+	 * We are committed to updating the STE. Ensure the invalidation array
+	 * is visible to concurrent map/unmap threads, and acquire any racing
+	 * IOPTE updates.
+	 *
+	 *  [CPU0]                        | [CPU1]
+	 *                                |
+	 *  change IOPTEs and TLB flush:  |
+	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_old_domain_invs {
+	 *    ...                         |   rcu_assign_pointer(new_invs);
+	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
+	 *    ...                         |   kfree_rcu(old_invs, rcu);
+	 *    // load invalidation array  | }
+	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
+	 *                                |   STE = TTB0 // read new IOPTEs
+	 */
+	smp_mb();
 	kfree_rcu(old_invs, rcu);
 }
 
-- 
2.43.0

