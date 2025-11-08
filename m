Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB6F2E5B2A
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589328; cv=fail; b=fD2uU2ak5vpZD3Mh+02ecCuemCi6V5arnSJVaEjVqyAxBd31Gqh1iY6Uf+ILwIbmflwBhKtrHjRxNUAHeDmVh7oj7PTQ2JighebyKE6dn+XM9B50qMXjEYZpBqfJnJu8erL+6j9pR/AQ9Onk2xqov21WD9EjrAGbDUYuKJpy4K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589328; c=relaxed/simple;
	bh=K9mxEV/R02TT/W8b4vKH8AbtpY1o0jb1Fsb8R/YhIJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWjuj3N4UItydK7pybJOn4VUlTOYHDi3Pygyzt+7T/Mlgq3bDkxfW13vSrm9C9zBZm4hsUwug8TwGIL7uu8oaYrLKYWPcCki2I7f7LvzVyUFoNRQTbqTD2P6L9aZOFLzFycyMR3z57qMQofRMJqVzwlhPbWNmlAaMdc9pxPK3Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NM6WmNKV; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NM6WmNKV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH1+6HVUcVh0ZeI9G148tqLrlEzEvRZVl+OHKkvVw6d6QyaP0eoMDPJi72uWNagoKiCMzYfdaIdMTZcYjlWeT+hOzr8Yi7bK49hIn/QOzvksh9pfd4dRIpzXX1wD4Vh0UoTMXL7n1ReELuRphThFbJTbahaI667TVENQ76xTFAIrMHz0wesVPOFThuLonc2DBGVOH8B4skA6qeIo76WyXawOIUxTZwT45WgfYJccI/KjO/+u7jqivm0urtuuRjjRVbOkTgvuwOmbLvA8yg9JuiGB+kkIjdUATNDxX24NMDP450OvQJ9g8hdAcBy8ww0NXhbyE9LfYekNehtWYs79RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJpIC3tTG1L7fuNcEi9MLjosQFDoXonN1TFmD3+HiIM=;
 b=eG+/wTZ2aE090gBADwBHuZUOzdWnJVoMX8W/7BmoEORmLgNV4FVIAX+xP0ktkaBxFzF7K9YQKqwTk9MOmLXPAsg9C4pM0rrKcIue62LgaaQ6SC/Zf994gazgkl2s0UPBewPY3uwk/KzmAEJWyxeatXWT8ZY+jwHSSkZTRil/ms6Vpfe/3ISfq7IYBoMrSo5BLkJ5VKqhMnc6ceXH7cfRkaxMzezLMJYo9rwkTb+uwdCgJqZsiieL3P/3TEQuJ5kFwFX6q0l/PqgOyws0iku5wjNrDD76pQjoXt6XRNQm8ywIMqfm4cythoWCud70bXy4z3xKvvYuir1FxfL8eUloXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJpIC3tTG1L7fuNcEi9MLjosQFDoXonN1TFmD3+HiIM=;
 b=NM6WmNKV4xS06FLmZno61fsvDccC6gKo7ybDcDUnkb82BWD1xPawOKFQa++P1QTU6VpE8i7ZZcN0fgFxlKOTxhdCnz38lG9CsScebEk+jRLjxgKWU4+gSkf5XdyZbJDg6/Ee7khnppds2YjYrycvVLx4eIazsupdGujtEbMPf0yfK90AEt0aj97rQYYd+qvRSkcu6mnenMkrM9l1uU5Ee1H1iUM5ifyYPsK/+tHk3Jj6bf2dHIi1DtcoLg6FEio1Wcr3m7JcQHKD4q1RCguhEYXwc0OihDy+KThv36hcRzp5+VQNHOpvp7ZLBDFgu59gMCsbVGbi7HUYYhdyepGb0A==
Received: from MN2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:208:23e::7)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.13; Sat, 8 Nov 2025 08:08:38 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::51) by MN2PR14CA0002.outlook.office365.com
 (2603:10b6:208:23e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 08:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 08:08:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 8 Nov 2025 00:08:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
Date: Sat, 8 Nov 2025 00:08:07 -0800
Message-ID: <ba48efdacdf1f4fec38cf0025ded20486f4c942a.1762588839.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588839.git.nicolinc@nvidia.com>
References: <cover.1762588839.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c809d9-0c85-4e5e-9107-08de1e9e0590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JsofqGou97eN9qWMnTfeL8vXplseEdoY6BKSjAgGew2HxBroaF9eeCDpbH9I?=
 =?us-ascii?Q?c3L2DyvPuuTdBUe3qSVqpaTE9gUp7nMFD1M7FAMPEq1ymm1HUem+hM8FW4NF?=
 =?us-ascii?Q?Hv1zUsO/YC+yl3jusAoDI2CLKGFoW2fW8Pylm4tA0c04ael2Sf8DJuXTd0mw?=
 =?us-ascii?Q?+lTXuXfynpG6q4RQofrRWFDsxx7zId5nGU9qBni9GadO5XI5uf8+vOMrMSpz?=
 =?us-ascii?Q?O7nf7X/yFhOilQscPpc1th587aa9B2+rqy8xbkl3hvxRHVoFeRMxQxgzt3J1?=
 =?us-ascii?Q?DsRAEm1rIRn4RRutkQDb/JzYfuqBp9s+dNVE1TVv7+yLvNZFXadYc65934Zd?=
 =?us-ascii?Q?Ovko+AT9UazQbOLVSI3NE6ffAXh2O3NfdTWjne1R50p+iJ5mflkA5SWiF5JD?=
 =?us-ascii?Q?YdYDuzuvan/Dt9zKy1Znia0tvm92w0BeRqpbT9MJWOzV2zR4SGvuDxTkoWoY?=
 =?us-ascii?Q?aifI969Okwi0bJQxcfhjnCkOyiBZCNlAkY/om3Y7xLA9R5OT8UC3SzoNeBIh?=
 =?us-ascii?Q?Ljn/Yo+wMjQm8M8H41o0tnJSbjjcg+5pmKaPcwaHYELtPp6bxlcHzakjNxM7?=
 =?us-ascii?Q?THoAPGfecO5debFxOPFZ/JBAL6rA2GV2Ki9AVF/8R/cmXShDPQM2tSEIH1Mh?=
 =?us-ascii?Q?RSUrDaw6NwlWgMb1vKGN8KoMdtTKuhc3p145He4bSoAd+8IlZh9M/bej/jEP?=
 =?us-ascii?Q?X1RyAK3Ic/vhofLRwZ7M/ymMZko09/4YlgxTqVI85tRwMpKKqBZRoUAK7JI4?=
 =?us-ascii?Q?/rT8T9Qukh44Mb2fArXr+/JpD8mEdQf9l9iudr2Wifg3UjjfD5vqeNbK97Im?=
 =?us-ascii?Q?VjjV9+XJ263QFulPWyCQl48s5dTRi43YShMSJ6shVdUTLj4/ebuMx1O5c+CU?=
 =?us-ascii?Q?5JxCKfRyi384eX8hePGvzFJ5GdGtDwaxeW9j9WNK2VFl+ir/sJVosSF8iDya?=
 =?us-ascii?Q?9zIgpsZhiEQhF+VRMUMV0JJqivjczctz8fjwo1tNnEQP9l4MuKSzPEiPgwfr?=
 =?us-ascii?Q?7r3ExL7+bg0N9qJpsiNIcJmabfFHBtbCMGSl3TAFxzYY0erwuRx3596jXhjw?=
 =?us-ascii?Q?uNnJnc8d9CxS4i6CBcbyYMjJ27Ubv1q9qcQHeXiSh/GLRzdHGuclkCj+S71P?=
 =?us-ascii?Q?HZJBucteXqXoTFGAYRy/+VF6Hpu59s39vuv0q0qZRc3rigQrSb8BKCjAsEzY?=
 =?us-ascii?Q?2GLlzTzitRv1ntTJY4zhiiotSta/2FAvVrBWcWlV4Itubi90l1F3bUttvdyG?=
 =?us-ascii?Q?Ju4XcpPgam5vud5A+NGQPPGrzkepOZd8/8I5+volhmGBYsN4hV1ShRyhZCM+?=
 =?us-ascii?Q?SnTdevvwl9RyX6L/8bUbozZQGgByBLHuT1wS8UHdriNj0wCQMlP3TKX3FFuI?=
 =?us-ascii?Q?fBob7LARovDdvds/eEBpdCqlx/A/SiZv/Jy2UCC0CSZGasaHMygDAOSQspHy?=
 =?us-ascii?Q?jSk2Tc89bv3nNRrTrbCoNu0V9i2o4miUviuWNcrAKPZChpxOszKjlpxlqvkn?=
 =?us-ascii?Q?SZ0SEhgrp4V5QlUvI5wtnUTy1cs2EAAC7xrKznw90ztUhuavIBQGjHw7CId/?=
 =?us-ascii?Q?uApE88ei/6uz9PBFOKTrkszcCU3slmUJYFeHxEyE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 08:08:37.8364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c809d9-0c85-4e5e-9107-08de1e9e0590
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 224 ++++++++++++++++++--
 2 files changed, 220 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5899429a514ab..593f94a699863 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1079,6 +1079,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
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
index 22875a951488d..9f4f4e95a3603 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2506,23 +2506,19 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
@@ -2542,8 +2538,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
-
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -2571,9 +2565,26 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
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
 
@@ -2629,6 +2640,193 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
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
-- 
2.43.0

