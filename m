Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3D13BC2B
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883814; cv=fail; b=M8r/es6lH6IA3Y8yudmelPtAM4vHK5l3aGdcj1m0sYB89byHLDOdug+mcY0ZVW+JuQlz6brjtdquGeu58EyHNGzu7W5tUV7GmvMvIJwTSupXkwnmL74pYs3uEYRnhEY7IVf42LQ/z+xpemMJck8jvuSr04Dk5U37UjL8mFyXnQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883814; c=relaxed/simple;
	bh=f1IKnNzS5HrHXMD9tg13OY9R1jr02X9kq81S3Fc8aOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nt+kMbN4gMKnifqR6vH7+o20b5Ia1shN0ab8TnloMcbkE5tGAZRMHoaD3j7bi+SaKBBriQ2P1CYLl171jxhJgn5qY8O+7AT8V3CRdlSExkrLPVBF3sPR4s0UTQxE3l81DqQlPQXUzKRtPxq1LPzoB8+M20oYNyhOWv4MbMWDNMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GYEMyqHl; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GYEMyqHl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPB0Xk9I3rtkDlGCP9M3L7mUOWR3TguubcdpzZ/lhEfHjuIOVq07BadEkpQ0c/+0b2nZC8XRrnkeYinimXydg+axTUwHfXnARC2Vfn+/2hrT+Y3kur2PjfVu24+Om+RtYjTtxbGlqxfw8GEX3Ql01adrTT4aDiGYVfWmsVT9F7/3/t/R1LqCPi54Fgj4MLuRiOLc7v6fHg17x2s7pFityxpoj2BOYkgOUwn1a5WT0i6hFZwoms1f96S8GMbS8i8eK4jYu48HODUM52io6aWYffd2jcyeWKf7aHrrHodCgfYWQtn899awGq2GmQngc3buhlu+Ym14y6XAWbbiIny0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb/F+ahqKgDMpW3pDAhczGGfSMxz2Z17FQ99tHnkfk4=;
 b=UHozrHI6B7QwhZB/LGL4ZxE7KCStUgTqpliJLBlmzdEwyZ0dG0vNwcdQ4kMudrp+3/IDtOOvfJpg8lngc6RUA7IGp71z5R/qhqPjAqmmVSyu8oAits2ZlQYlR9bHj5AJ++rBf3XsOpUgtOY8Oc3It+nce5wgPfn/Jm6NgNc38dBdCzLexTiO1/rDAb6+fetyasR9C3mhA1nHtsYDMjOnrwNYWDvIwHwjc13abTbxIUxBGd7aZC4/Z9HJla4BS8jFGiJVhdgnOK0RPKM8Lk+dfUNsXloZ7Tmhu1PCC68qcOA4jNLQQwiROaokJt+Une0W4tzmRi3+SlslfB6nNP9bUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb/F+ahqKgDMpW3pDAhczGGfSMxz2Z17FQ99tHnkfk4=;
 b=GYEMyqHljJE5+l5wEc++bmIN9McGWn0TBeQ0tj8rxshoV83iEIDr5msqCOURgbAMRJEZ/bpIVghv2AIMy5P4E/nf9+3aw0T73ezc1HJBvCVpifxlgdu8OJq5DGiZEE+Wb5dj+N6icZ3A/E9wkFD5afh5uRYgp3pmz0Lf4RidjFaSHZccMUrpmwP7sX6nVMEqQmKfdXYO0Is6EGpsyql9Uihg1GjXJ5ZyHrP3Ek1k4FKXGycouTdtM+WmO+InF0r6M5K5MdiR8kAkLCqTb4dCEdTUXjfaWiVFnBIUSaiumFWu9gJb91B8djiPqdiwtx2eCk2d4qc4ntBMZ5PSbstqyw==
Received: from CH2PR04CA0025.namprd04.prod.outlook.com (2603:10b6:610:52::35)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 28 May
 2024 08:10:09 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::d8) by CH2PR04CA0025.outlook.office365.com
 (2603:10b6:610:52::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 08:10:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7656.0 via Frontend Transport; Tue, 28 May 2024 08:10:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 01:09:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 01:09:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 01:09:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v8 1/6] iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
Date: Tue, 28 May 2024 01:09:49 -0700
Message-ID: <87a75a3603a4335d3f2dd16e6417d0779296680b.1716883239.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716883239.git.nicolinc@nvidia.com>
References: <cover.1716883239.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f5a0cf-fb57-4fa3-3fcc-08dc7eed9763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DOPcQWGvKLgwX7wyf2uXzL8GWL/mahTTZU94W4uz21oU39IEXcG2CRazGDZm?=
 =?us-ascii?Q?FOLP9ge3+2ug7tYIpUVNb+H9NqQLfBYsPccZjPjjltz160WR05PTf5zOu8ZG?=
 =?us-ascii?Q?YA6g4VtSw+pAqPdJAbTQilxGl4C8MxffdD5kYjIkpC8vIys+KMIM3CRzWwg/?=
 =?us-ascii?Q?3qUqmBFTQY2n8PqDHInew5tknAPFZ/fqPo8LYyS/TRLX7+5iHj5N8Rk+IVG/?=
 =?us-ascii?Q?afAFp6FJ0kzjHJUDDzoq/7HLNPItDshO5YpAainyKa3pbSNolPz4YKXiUEEg?=
 =?us-ascii?Q?iIu2UPJBiIjYpXiNVQcanuT6ElT8jeBWnPsHheQtw+4RQCV6wybi8pnGqu8f?=
 =?us-ascii?Q?JRXwN4hYjZzJSDUkA29BPCXhl/dxnw+yrlR8La8JE28MzfNh+TziNEB7CbeY?=
 =?us-ascii?Q?Wv52oP91u3xtA9eiqnTm8w7MclxoWgyrIA561s9AcecuIi9OqlocvXC//yfw?=
 =?us-ascii?Q?Wecb6GSx/oZTiZ8QbJSB0ZN8OShOi6X/O9uyitXqNRWuquXY5U0XHpOwstqd?=
 =?us-ascii?Q?cwn3KSz6vLGyVTVF/be79uVGk/4SY77zq1O0IrSZwv/yIpD+qsYw6ZWpEe19?=
 =?us-ascii?Q?tFWZhCND1hRwiRaf8KX8FbXfNTUAGrkay53LSAs4Ao3w0e4hrpR/MtAkh4B9?=
 =?us-ascii?Q?9hgPR058fgTanefZ2fy6cuzjfHEVSDi1x9YTKn912yciOE1B2OosI4KZfc/9?=
 =?us-ascii?Q?8JjgKVSKCURo6851ctLxW31NLl6TwLzlx9f0T9TSMVq0IgTsuox4n0UTayLj?=
 =?us-ascii?Q?hUx54E8FSdJuHO18ofACbE80hGDASPRq4SMLoXk6w5zir67AQTTlwatWl4QL?=
 =?us-ascii?Q?OF1kWA6vDky3eJEaZd2dcHBJYiFyKyJiT9mKJou0TIzyD/aHsfi/82m+o5ra?=
 =?us-ascii?Q?HV/XYA5MWXvlMU9Wort7D0TryaMUpjI3fSSy0DnZA9/0NeLobvtyEZxQZAPx?=
 =?us-ascii?Q?jhiBFxxQaQ5g9F3+BuW/PQsWmzA2n7MsD7O/Wb+grCVb/EcbZWXCe1JLe73T?=
 =?us-ascii?Q?+8P2VKtbwFUBP0/9tuD/WmM+jWJ8i2Ciot5lS1vfESNb/PvFiW70xdd/eU+q?=
 =?us-ascii?Q?PQpHOVjhABJ5N1fEUeqzu8O7EmhzXcE9gjo9RLc66L3ssMhW7U/P8W8wCGDy?=
 =?us-ascii?Q?Hjlc0xyY0qX0W8Vi3T/tfAGyOzWUoe7EMw/eYQRHB/hRg5uOu9LH2T0NeAdM?=
 =?us-ascii?Q?y3L5rpLzeil4B4dKvUtKiSpGl3YzhwRSRZZW/AJXud/vHNLi0lvY8a6x0bQU?=
 =?us-ascii?Q?qoRDHNrHaVzfqmUn6gJ9/1P2vmnw7+rznWCcFIPO1xBoYQcUz9FKpFCfB/WG?=
 =?us-ascii?Q?4thVt+9uuAHHoWPHwgOKo/unh9+rSGds6Z4lQcQsnwmbY2gGB47DY5BNi78p?=
 =?us-ascii?Q?4aNuGig=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 08:10:09.0574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f5a0cf-fb57-4fa3-3fcc-08dc7eed9763
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

The symbols __arm_smmu_cmdq_skip_err(), arm_smmu_init_one_queue(), and
arm_smmu_cmdq_init() need to be used by the tegra241-cmdqv compilation
unit in a following patch.

Remove the static and put prototypes in the header. Also allow to pass
in a different cmdq pointer to arm_smmu_cmdq_init.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 +++++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab415e107054..21878d4467da 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -366,8 +366,8 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 }
 
-static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
-				     struct arm_smmu_queue *q)
+void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
+			      struct arm_smmu_queue *q)
 {
 	static const char * const cerror_str[] = {
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
@@ -3124,12 +3124,10 @@ static struct iommu_ops arm_smmu_ops = {
 };
 
 /* Probing and initialisation functions */
-static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
-				   struct arm_smmu_queue *q,
-				   void __iomem *page,
-				   unsigned long prod_off,
-				   unsigned long cons_off,
-				   size_t dwords, const char *name)
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name)
 {
 	size_t qsz;
 
@@ -3167,9 +3165,9 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
 	atomic_set(&cmdq->owner_prod, 0);
@@ -3194,7 +3192,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1242a086c9f9..67b0ca0b1b79 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -794,6 +794,15 @@ bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size);
 
+void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
+			      struct arm_smmu_queue *q);
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name);
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
-- 
2.43.0

