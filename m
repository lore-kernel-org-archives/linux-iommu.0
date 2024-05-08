Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B217C79
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 05:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147835; cv=fail; b=Vk4WSsWYsIrdQvgIWzEZqBoFb9PnLOqoM23rXwbb0kazyndmIOQlNP2aohzSeamEQd0LrGYw04EknFgQXOGY8v5Gn7Pjn2VSBOgdpB9rLLQCMlzzGp9rC9DP4eSW8A7MK9pwKllxTbgB4P0ezqSJUQDZTUvgMls3GWslZH2LU5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147835; c=relaxed/simple;
	bh=ziCXq7CU3opQdwX6vkppf5fS5Sz4eqAu61osYV+M7Eg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuHqSc45exBVYWqxGb6T6BAQduBmTPULfSSaelB+LmEHXIbeaEmS7cjBOPVGurmitU5ncmzHXau2VNn272jLBr3f+s3yx+AVDoogkJQbRHHb4B3MNgj9jWfLOknY0DPZPnaVfAsFCmaNAjm3A5aqij0EqX+wj+ksmAmE17ekY0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ljyPSlOt; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ljyPSlOt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPgAIwv7z7ENyxZS4aKZ+5ZKCMfJjD/ZsAPw3CIc2wxxiKUky0pjpp7ViuhPFAeHCohkrKStJcI3ojtYfl9Gs4lGcUXn1TYct3vXUMPmJaoHTVqVnMnkWUuitsZjZUueRbxZj1AIQBvlPqFwf5e76lDiOJ3Lo7XZ3uj01e4aB/DOZvlcRW8GDdySoigfuSflolSCiW2ZEuQoleoVrm1keSSvFao3ftM3wEw9dT0F0MAeDNvkSmXkBmBNQe9TKaEz+AtiuKXgBbIVuHdMfiDStONd/iXE2Tv5a3A+vfG5oTjO+UtJ65ilhnWH6RrL+SRN7BbsrvL77WpEfJfCVwmUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PxSlnQtktBnue3hbfE+wSjtV932LD0f12fXmCQnt5k=;
 b=PuSF4xqXWRSHjeo4MoJcwTOsv41djXR4KU/e+vSD9YAmd/JSYNPCXE3dAWbIRUY7gnUF5zfXKqczBI9RN5hs0kRjdgjkTQkB7aEdt0fkWlwxekRT/hyqcbkV9AxVxpKR227BnHZYx2DBlXqmf8CPVqGwIqn3fgxA9Beaf9TtkJTHa93S8VQri1VDxpzm2XGtiG+WGmIlOk/dYUHHJjUmUBBNYZfjxEAF4uPUBhY5ec31wgDYPCyEA16IeFljkWSAFlq/PCTcTSNuRxL8S/a+c99GU33zTw/9OndfQamGsR5HuZAfYxjgZx/Mg/lwm7s8CYzTuCgT76u+5rXRWlLHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PxSlnQtktBnue3hbfE+wSjtV932LD0f12fXmCQnt5k=;
 b=ljyPSlOtku+7QbKcxzHM0mpRP0m63AAjA/gfGHzrITFSW/sxNdZzIPEIFpt/r8xs545qLty6Gik4arJZh9dLDwnUrWWs3zSDZlYFcuCus+iIUPPQug+Adhbf/Jq/jufyRTuvP1XPRSdw5u5uoMJWDVkbdLbx9MDv42MEywOHpDWV2O2Ytx6rShVaqJ4iDxJEo+KXWL6DaBVZAA0RsIL1viPqMt51CzKGwBU4awTou2+CYIZHwF6XEWfMbV5gFQ6a9mQl0z6KdSjnj4t3iGOOnObFIBYBzlaVcaZo1Es1/peGai3zir0ZobnZAdRHnC1nmSDc3UDgnW/DHG+xkyvFNw==
Received: from BY5PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:180::40)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 05:57:08 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::dd) by BY5PR13CA0027.outlook.office365.com
 (2603:10b6:a03:180::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 05:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 05:57:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 22:57:01 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 22:57:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 May 2024 22:57:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v7 1/6] iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
Date: Tue, 7 May 2024 22:56:49 -0700
Message-ID: <eef21813345f9f752f21162d857cf211be71b827.1715147377.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715147377.git.nicolinc@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7002d28b-03dd-4feb-fab6-08dc6f23b249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NZOussHJeH0Cv7XDgdPFiFw7yO8K+JfjEbI/KBKI6BVuqnyArHDipWzaJdBh?=
 =?us-ascii?Q?tPv+ITMiQwaOFycqmG2jVUy/lyt2eU0HZGqMvgUoWFytnw6ki95uuxKz+1l8?=
 =?us-ascii?Q?vv5gStwSn4ZIqL3GovW1m5D38h393XWqw23YcG5BEvS8sJtFOUzD5Ku6i0pK?=
 =?us-ascii?Q?moX+FcKyPJmMR/kxVoTN3tVtLDCnodVKQIHbJ9tV7zfPrI7Jx/Gk3CofmCv1?=
 =?us-ascii?Q?mzfJYr4dSIU2KOtrT+kFWFhti1m5Ww8o071jNY7CiMhOhCGZHjYhoQVT4v3/?=
 =?us-ascii?Q?ICiZKkAFacGYeP7lEkQVDymkxZjzSG/0iEP95Wjc9aQt7bBrbxAbsdz3wek4?=
 =?us-ascii?Q?16/NwTHwwqx9VLYZug8mGyz1PvzpRH67sHgqxFHKlRD+fDt8Foa/0SU1USLC?=
 =?us-ascii?Q?YmQ7kGFsNQBaroks9erGu3YTzUeCtAG5RefFPgA0lgGVXWbPv6OORg7aKBrt?=
 =?us-ascii?Q?u2aL9QG/kdALWrtHTo9Sy7+2k97H9eaHXGU4y3xulTBZFjfFpY3HMMe/2jpa?=
 =?us-ascii?Q?xma2SLzS+U1cJIqFfcOH8nAZ/b1qXrI0wU0Yg5d0OY8Rht1qdw31AtEFN5H3?=
 =?us-ascii?Q?wSn7bfexEj4Y5sIFZc6EYn2WHoxL7HwD6BwSHdIkJW+wrIWoP/9arOr7IXHE?=
 =?us-ascii?Q?Bcfj1MnkTqrmoAs2QdAUJkbHDPMz166Qbp/OVfAzQm/lS+narfRgIl/3UBDP?=
 =?us-ascii?Q?IuH31Jc/k/4i8+73H74c5cCAVtY76KlXgMUHVjtqjToX8u/tTAMe44IzhQQI?=
 =?us-ascii?Q?82gPY7KLJkz+QuMaXb4Rm6WyImGA5yztJMfyOJ+sw69GfEFljAb+gvX6LIVk?=
 =?us-ascii?Q?ZWWWsHTz2/lz9/OHSi9H2Cd/ZM+sGvUFDNFGuTYjtxuXcO+8tpZBxHEX/StX?=
 =?us-ascii?Q?y7W7GU5i0k1R5TI3KCvyLrVuEVWbSqvjJXNweK5Gx4JzgrEn+4XpdVgubRQL?=
 =?us-ascii?Q?mpuHduJzKamlnNMQDtzJT68UeNTA4XgPuJzBB55l+G3sM5+A5zhj5bYaFj01?=
 =?us-ascii?Q?Ci/QjSjtaoAzHL1jPfHIlRE4s/ImphqdT/Gyg66jPAl1bCsgJTjP/NF2vFyP?=
 =?us-ascii?Q?m616NgPNwSrbHJtFpte5/fdfsgz1DlrgJ4ZcolWrkhfrul9nxV3QRipgwDOy?=
 =?us-ascii?Q?8hBnoAyssapIuUXuugvPQS0qNuj2kIw1vgWVd1oI+9Ww0++Mh5rfnCermYcr?=
 =?us-ascii?Q?mzzHD5zzOeme53ZSstDvWoJ73LaF/NLcFUXWbOHnd1gBzdWTeHW6eKFgQxWV?=
 =?us-ascii?Q?KKMX9hNxZEWvTuwacrdmDWEQQFDEudh2xdMWT10a2bKlutZmSDZR6FewfaGQ?=
 =?us-ascii?Q?2o+WScGWUggl3lquPpBJhr70uol8WbX3pZp0Pg6Ma9KOWoKDIwXTxAczeAWy?=
 =?us-ascii?Q?Kk467M2Av/W5Lm9JANe6wcta22ml?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:57:08.5342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7002d28b-03dd-4feb-fab6-08dc6f23b249
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

The symbols __arm_smmu_cmdq_skip_err(), arm_smmu_init_one_queue(), and
arm_smmu_cmdq_init() need to be used by the tegra241-cmdqv compilation
unit in a following patch. Remove the static and put prototypes in the
header.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 +++++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1ad0937760c6..31ada4c7b87d 100644
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
@@ -3121,12 +3121,10 @@ static struct iommu_ops arm_smmu_ops = {
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
 
@@ -3164,9 +3162,9 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
 	atomic_set(&cmdq->owner_prod, 0);
@@ -3191,7 +3189,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
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

