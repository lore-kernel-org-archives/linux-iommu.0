Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2084FDC
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228759; cv=fail; b=GxY5Q4uP+dBn6PR9qXUsFEmrNVHwc4UkVXky4vH/gTaAhHOY618JFnoB1dNKIo0SPkHs3l2jLfQlcCHsi9GvxwfPXarY7lBEDLLO0Cy3veKfZt+MHqrBawe8o2NAebKSjmcl4XemHaYuS4Df+0UC2JCkEOJbH/VPnQ4MgYU4Eqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228759; c=relaxed/simple;
	bh=f1IKnNzS5HrHXMD9tg13OY9R1jr02X9kq81S3Fc8aOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnnaxaFvEGTJqgDD2McnbejCNQkWx53P9+1wKIreoxS+Qm8jeP0mY62rhevSkSbXiT2cZx5cyuOjMoXXtuvWaTQJksVkNDKcTusrSX/Kx9zOa717QT1b39ZB6yzRR1yiJ2b3Ecd9gWmlTyrlekwgJObONpZawA4GLdftTl1r7Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eKJM2YSW; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eKJM2YSW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2atQkmtn53fGhBUkFH6sminP7mEuDkfbPER6o0jzbxq5dtMSrQmaDqepMqXmCdSS7IEN6SLOr1XfCoerq8kWijTIAeoBCUkQxpy8zWwKvFhy9mHACcPdY0LbQA65Lt+bLFULN7TAgvXcz9x6tPE2aVRU9CB5lzENji9XLrTMWOAu+QDRFMMrEhVJZQRI8wfg6O15tttfb5Rh2SvcuvC/T/N0ACS+wC4x7/L1q9A4CDJB0NQGDLkFtpLS/s/FP+F4awh19wE2ZbJAV2OAUw4fFejjv913HJK6v42Nk4DjzKHk5UikCdzKhQskdq+YtjN7JcptYyskN79t4QWAy4SAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb/F+ahqKgDMpW3pDAhczGGfSMxz2Z17FQ99tHnkfk4=;
 b=GBhK9paD5wy1XfmBw96aWdGNN1iS83Qk0jBHFK4JQPFDSI4mnpOSoITUbl2BFTMtK888MJca22J10FNiocQoK9SUuiZr2UJRiiL5rllNIZqPWqcOzJYtJ8+pCchzDZI+rjlxZdmHalLVXmtxP/px4YFSmW49d7l+JFcT9loWKlXaUE3ngJgi7X/7X3CTYihFN+/i42u6+zarf9HWh/3+z/HJ7eHDObh64t6C2Dk68det6zNpyYAHtx3iR9fHWHXMbkMTkC8IwBw2DM7wdVejMUrC5/bmTSDmMkkitxBOtCXUNPHbOUqCaHhCXuPfx/NqLV5I7sLRWnRQDt1BqiYOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb/F+ahqKgDMpW3pDAhczGGfSMxz2Z17FQ99tHnkfk4=;
 b=eKJM2YSWvaxlghrTQB+Casc4edmAsf04E2tQvPxBP+c4wbTpNkDmq/dtCEqoT3nGPDaBNJkTgMJvH6jLd++2tTckXeMpSAiPgDEHz/KDusQhT8BAQzHE7orZZqZ9qiBh2fWn2qTjfji+/VhH/pqu1khKrIAM2PKb+atkh2K2rnFP5HsxmNycUyQ76tL/Maw+snjqXGb5A0BZDEcsE15leFYPcv/07tyeJguxsgAmnU8MF9Me406srAKYmndoWr7QC/x/B2q7OXDlA/7eTprQOHmPi+/O+8kFeYtV771+0bij1WMnR+tuz0YF7Ew74CKwLVZA/vk2HKk2nJVqufPDoQ==
Received: from SA1P222CA0101.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::9)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 21:45:52 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::15) by SA1P222CA0101.outlook.office365.com
 (2603:10b6:806:35e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 21:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:45:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 14:45:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 14:45:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 14:45:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v9 1/6] iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
Date: Wed, 12 Jun 2024 14:45:28 -0700
Message-ID: <36a536d53451d0a2f78e696d344c32e217db9a73.1718228494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718228494.git.nicolinc@nvidia.com>
References: <cover.1718228494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5da93f-9a78-4dd5-00aa-08dc8b29078a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|36860700007|376008|1800799018|82310400020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JTS73iAxsTR8TLJU3VUr6w3NilOnUAMkMfbtk+AW9B4Q+ODSr8D6sROjutui?=
 =?us-ascii?Q?ATBGgHjxQ7cFc+hrOrzDgcUrU1Mg1P0MeQ4KrfpRusaEBLHdxm3ez4ABV5lt?=
 =?us-ascii?Q?LqhGgpRlzM0Zb2lUBJ33uQR7QOzWMxI8cJevZ1XgWuDn9EMIIK0mFSULnslb?=
 =?us-ascii?Q?PbPy8njNU2fjGQ1X7P/F0jQzdcjuX7l6sPBcT55im2Q5Qr2TCh7+rr01VVE2?=
 =?us-ascii?Q?6/kOY2RVnv9RHI1XHD6oW54DJ8Em7o23gyg2LqJgbE3p0jAN+VwFE74O1EIs?=
 =?us-ascii?Q?InwVYyYcpxCHL70D5nlXChif+GDdGXk2jzQPVny3BwnVsnqS+DLM9R2zdDGb?=
 =?us-ascii?Q?raXlCKEoABabWcGUU4CuK0PkuiQ61LtYq9p8jBRTOwSs1ZTwjVcfOf3WigAM?=
 =?us-ascii?Q?5MkuGGOnEX9riw7LRghzoSAdgW2N2h4XuFC360awzD8aX456rV32AWrvXZBb?=
 =?us-ascii?Q?Et+frA5wNXPnd2Ny9p3+Y7C9qXO1hfG+yGsT7GZJrsgbGWoZ7G5kaNAcDYni?=
 =?us-ascii?Q?/GoCgEoE7l+AOsLj38WkydhhB3X3nJ+3C0n73GWNPiCMZJ5E0EsYKN2QhwJc?=
 =?us-ascii?Q?uaPl3Fdb0k4UYeoVhaemKqd4UXJOaK/Y5XbElpD6lA2x/E3lOO1eKcVsYzeQ?=
 =?us-ascii?Q?STEFP2VWVeAAT5Ve6lDVEbA5dcZT540EmD8O5T2OJVsHTYIQ2AOhLzYbT05D?=
 =?us-ascii?Q?QzeHfuxL/jUQG7mlAQeBD7QEzlnyTPEo2UgAPemXlX0/RLmLLciCrEa8gXy7?=
 =?us-ascii?Q?185SxrFU4UTi7NDJ7bOXKcJXQUF9LfWCnok2fImGQFtne/jTznF+jb29JfL8?=
 =?us-ascii?Q?kzTVPdPCeBsL6A42A/jcbnlR24CFq22MhQT4z7R8E+8Yf9f7t9zDAsrNQpEZ?=
 =?us-ascii?Q?yxg6tUpmRrEEHWWVf3/mAPMU1TeRMyVB4VJPfAsfEbFAtBSioiLvRzuNXWIN?=
 =?us-ascii?Q?O6MQkI3c55jpApYH+SbXMRVTm3oqSPmppv6yS00zf4lfXX1VMTmRODGmS6i+?=
 =?us-ascii?Q?G1E8GQzY3nRH77jsxgMYrtq6g4AkTovfRDyPd19X/gHVzAeRsGs7N39ykquD?=
 =?us-ascii?Q?D5xbgtnpaEi4iuwPUluZs/Rnh0h68N7pUbZs9UjdGkW/ZSTES4N2EDmBA9OW?=
 =?us-ascii?Q?B2TXKRDpnHjupTuQXulJ3jHqJrv38SzBreK5p0oBTKeIucUh1/z7MBPNzR9u?=
 =?us-ascii?Q?PovL0Yn3s4+k4CZSiZNXO4BNNOiyVTAQE6oomtsWUPHYjY97NYWLMJKcMqp3?=
 =?us-ascii?Q?F7klP1I24uOuH91iG89A0CQ8hGfxHm0l7IaOQFrfGDjfsypyUsHw2l/oo3TJ?=
 =?us-ascii?Q?yIkHDYHJaj+algH/3D4fPJYTaXzOife4THb1xotmR3ZBPfNwBcgZygsSypCC?=
 =?us-ascii?Q?mklXZozp5oIrLSfk+zzraOHNAu7UmTN5ckxHNc418gMt/1o7eA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:45:51.4766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5da93f-9a78-4dd5-00aa-08dc8b29078a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664

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

