Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEAE331A4D
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591305; cv=fail; b=uk9uFYzPaOpKcD1cnFgNSoxHzAihaBAh0SfOIsznktI+LdxSXshyyO/WTFURQXhZPM7Zg1aD7mdUT2c6nk5y3Y1tfx/BBDFxeVrIi8QtliKSTGbvH4ZBk/b7HU/0fjMN6AeHcDMzuLJn7IGdvUJ/fDYEZ0KXedUwgEbOI+ckbao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591305; c=relaxed/simple;
	bh=hftfjCQuHb6EV8MW4W0x15ubVgX9W2LMOVGuTpBhXII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZ9xGdXLn0PNtffJQJPkiSDnWNqzgSf0gN/XY7h7lVt72WMUuqTUpb1L7B/rCzR4uNj/f9g2yi3QVch8Z619bfWjhHCCWm3GyY01vFItMLPqTkq1Mwde0mv6hCGQJDZO0JA9W/XuyTzkBXAcSLrnx4X4EZMswb75ZcXYJQMtj38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gknIJLun; arc=fail smtp.client-ip=52.101.85.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gknIJLun"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfAfURqZ6+l4sRlCP+iU4fM2LoEQRXJJtWOQQMCj5BWQWzehHPZhFfg414pNjtiqQZyW0Q7FYYQL9OZzudu2x47vtBMEzI/Og9emsBGfKH5g4xl+Ua8LJduNeEZ9a0lZ7gn6mszMHMhdy0EAHPLreuYsrAMlhpo2qWTpuYHe8Pyb9HugY28XVWPrk6lyU64iaAtkYta61pB8hK1Dj7AzPHzn6MEw6FDRLOsj/W+yUCh1nE3FA9ww623w5Btc/Z33jJNE4e+i39YpcJOnSGDJED2zhenKN/HA+DUvjzneRTLPS3V+3S0YEjXLMYl+qXPEVMwKGUd8jCXFQhtMeHx4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AkT6Zx5LeMr+yLW0ebHI6rgvVC2i82dUyh6VNx/zC0=;
 b=PVqkzBk1hltCUXya3x0Mqm2xhFzyy6QoLbTC/t7uthoY62FOP0TvyWDD56+gsdNa73aKnwmEENM7K+Pr1g9aEzxne19FsCpIqkDuFT4PalyGOAIv7vf5ZJJLJh9RjNHNzzfwQt6gWuqJ9hRD8jlFJCiKdNt4eEfEvkXM720jQDma4Wcqb6vNoIgZVNr/YIIuByIrdGL50KlcFQqcq7JQ/ZvzUIlfwhfxW/tzdl1mAQ3hGyb9Le9b1xatYb2EWqeIRKnpPqvWCplAlVk+VKl9sJVQUGH7wRr4f88Tkz3tp3b2tH7EuH4rhk9EEDb4n9Ohlh4GhnUtJ4n/61ZzHRJy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AkT6Zx5LeMr+yLW0ebHI6rgvVC2i82dUyh6VNx/zC0=;
 b=gknIJLunQejBJBvVHeVb3gTnux3/mgefKFhH2xudhfCP5NFjVBRk0g8Mtz/e3Y+RvOKpmtiBpn+dz7/KZ7Zt6PfP2NrZ+3V3vhp3kAzl5nLzsbCG/4QJrr+E1rWfolkJAv/fbZ3gNzqYHj/XRC+nniAGALQznGhzsrj+OTgID8sCgFzhIBQyDHEdd056UYr5UBxjZks/vww+Bu2fRRLag02EOd+nsM2juUU4e6UpcBVkikO/Dnzuw4pPVMuM0vhkuv7oWf5EI6Xfx9vMPa9+0bwZtvmtC67IxUrgO5+1WLKdFPOZnuRSj89lBHE8vwCR2QJlz2jrd9JybGX8QLjssg==
Received: from SN7PR04CA0109.namprd04.prod.outlook.com (2603:10b6:806:122::24)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:54:57 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::92) by SN7PR04CA0109.outlook.office365.com
 (2603:10b6:806:122::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.17 via Frontend Transport; Mon,
 27 Oct 2025 18:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 18:54:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 11:54:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 11:54:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 11:54:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
Date: Mon, 27 Oct 2025 11:54:20 -0700
Message-ID: <5f229859b5d252b703be8f1229d73903a566e8d8.1761590851.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761590851.git.nicolinc@nvidia.com>
References: <cover.1761590851.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c975e6-491e-44f7-243f-08de158a52b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ibAB+0m754twCQKkd7tdI7/ipG923pbNlU+yztblQxua4g8P60YTJhOw7GFr?=
 =?us-ascii?Q?basrvsOJn4uKuOWYPLWztrISo478kF2USnTHH/3k3kIr9bY6IVl9OAX5rDIL?=
 =?us-ascii?Q?+kupP2WaeVkivt/AbqmJm0vPn935km2Z+52qCJFFMXjXpmjbiCfTrUeLSmKg?=
 =?us-ascii?Q?IqJzceSGBk63Ovijrks+/SFAc0ZYbk9pwt485NIsY52yijpS3BiDYI2+T6VU?=
 =?us-ascii?Q?aLylpnauvJUJUE60mYSJItMDx5txopjb0kWMYTlUIUO3xtCsw0wfSspqSyDY?=
 =?us-ascii?Q?LrTVc6fJXaZ0LOkUg4QStgZ9Un/vockSwCuwvq4nnqUxAj12ICHSBEarE0BW?=
 =?us-ascii?Q?gVjZAA1TIvGYgcLxD1gxw1Nb1/i7MrenXOY/z2HvsBVodeFNIz5IPEPeDwJY?=
 =?us-ascii?Q?0GuJKD8dO86PjthEXIFj8nBJI3Sc15T5QyI/ijZAfh/gXsMuobV0UdG21jiA?=
 =?us-ascii?Q?ze2n1PVU0cBNxrixZ2XNBeH3q3ER9WNA3kSWQefZkSk+0x0jai7fwawQPBBL?=
 =?us-ascii?Q?uxVw/KaXN6zcz5SOGa4EfOyvcypu4wTWnJTYvfXlUECRT4oQCyY2Gp7Q9iLZ?=
 =?us-ascii?Q?GhNyfzWdleQid0T8lOtWK9f2q2T4p5yaMWUhMCIB5JMdIcohy5NDjPGeJSz8?=
 =?us-ascii?Q?ZZJCz8pLa6Gju+r4ATsEcrjTXRdD8qO0Qen44OaMsyExw0zfpZiIV1GXEAVB?=
 =?us-ascii?Q?71sJWLuFIFi8nGq/3A3dv99cwAaAVbhAg5rajgL/7aHd8QlZ2jRf+/28HBO5?=
 =?us-ascii?Q?MTq5f4p2kjbkVjVc8kyl8UFOzgCq5U1fobGE4GJ7AM3XGomqiGD0Kc78aZGw?=
 =?us-ascii?Q?BvfHq+NSlVYG2QTUJW4CTcGSrbd9L9SCoGS/F+Tjc4IG0Fp56oS1U0MhXmNe?=
 =?us-ascii?Q?lqpObgkUzsrXc/ksSjihjBsSGUSnXLhGSPWhsVsFbwf+LXg6nfq5SxBCaF9t?=
 =?us-ascii?Q?WaHaeJmsg7eEQgeYlKfFD6OfK1m8hSvVQpPZsme8WMIgGFPPlOfrOqvuD6IC?=
 =?us-ascii?Q?dKX0n/kazg6QWNuJst/0k3GyV/rcocIRybaKPUEO184Ztqu867C5drulRG+h?=
 =?us-ascii?Q?6yqN9mhLHoq3yVJQcP6GeSKgefsfKBhE05nCWKOay6hGwDzfoD/V+eCNcRwF?=
 =?us-ascii?Q?n9iWiXo1IQuWtxTzHQ+sv80WhgOJxL0cXAqYffIFsybxBmtD0miQM9zg7Hq6?=
 =?us-ascii?Q?106QgNenjWl4xWHJYnn+lH4B8OUmZGURnIMIPPBW14XYZoQ28l4sYRhlg2Az?=
 =?us-ascii?Q?oL41V62I2dsRb3lMKIBP31U1jwWtck7qPdVcy/SEyEl1ehoPpuCgN1uj0iS/?=
 =?us-ascii?Q?JVHS0FeetxQh9RGmLSg3lXQoJa1RHzcgUYCuA4peAw1V2ScoM3aV6MpuZxer?=
 =?us-ascii?Q?2e5B4pM6BnaPWC0M+hwHJPVnyUzy38aSD3zlTdozBW6orEhwWbxwUVwkzZuo?=
 =?us-ascii?Q?KTweX86RFZLZt07M4nOqM1H6HnA+mfa/F8Ko5XJ4eD93fyneDESScdtKiZLz?=
 =?us-ascii?Q?CnwnIr7Clf956S7Gl6A6iejiS4xrSliyzaMOzwRLQDq46xZOuCQGQka32z6Q?=
 =?us-ascii?Q?+swxBabe/6c/CumL1vxDq7DQiXqrlP3g4sez97f0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:54:56.8778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c975e6-491e-44f7-243f-08de158a52b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662

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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   9 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 225 ++++++++++++++++++--
 2 files changed, 221 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b0dd9ff846f75..b85ab564943cf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1078,6 +1078,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
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
index f638c344b754e..435dbc8d2fdbc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2499,23 +2499,19 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
@@ -2535,8 +2531,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
-
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -2564,9 +2558,26 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
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
 
@@ -2622,6 +2633,194 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
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
+		/* nsize_opcode always needs a sync, no batching */
+		arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, cmd);
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
-- 
2.43.0

