Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE147796
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769768; cv=fail; b=UfchAbhAKQEEOA6Pml6A4WyDwzyIk2LuthgL2cyA1jYwAr+MYRTkezic8qmTnz+55DIpvixSLCFWtt7iAITs0GMOaIBNzx3LjKTlW7Zrhrg/Rk+p4IhF5bPSM/GLGTbKGaXwVP/vrXOuQVEXo19L+6L7tMHQDcLNrwCgL1dAaYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769768; c=relaxed/simple;
	bh=gFJ/ivERZRyZqSkp/zq5rfwVqWbE9sPwgBotUKEyuE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkQnv5rdCF1aeWO35j+RaidOU47/i7yJPlJFr4GYOjFipszpTIZH7FZJuT/god+dE+qc+ecy2jhCECBo0TygvmCNLwnRMSe5O+UdUTb1aDSPyns6IBDAb/0yPHuwP2cRAzL1OE6teKo3hyLuryj+IyXMa+tddwNiDlq8HI9f5Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cpmzFeNN; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cpmzFeNN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eanIzUqRXKQTrp3LbGslnIh9CUC0vvbcNhDQeGSHRVARlviIfMkJbbGpBxn01hkKzjs/bvrPkL1OzaPgllK8fKv1a8WduLA+Ldp50KsKDHL7G5dhc2GvKACw+BE56vNxOYHYLv5U6c9arG6Kb/WQAOuwO5WGitbYI8KWGUFCztqWNPJWELVHA8LiXWixytOTX5Gjn5EfpbWVmU/wfL7JrPFmnqwwVaaujtCv+f9SdXqGJ3pvhreWYJyNXdxjouS2ewTQagTzsUfjTRlrkdXzzEpqSG6hkYNVop6ayz1m4eH7PuOO94IK40jVeEOH4QKqzZsCmPeZZAccjNB3flwTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuUCRx1T7PyNtbyKchCLoBMd4PQxD+UIgtcgquyKorU=;
 b=bvzm8mJDjMnDS52C+Z07ox7ifCw+KZiM0ayF709YMEZ0kG2JM2oSQFi8q6GUm6iEofFkvJFV+8e3Yo8oNypDC3frP4ofNl9RkdetLGw3hMGT4L2pjwnU50RD+nnuZygSjwstLznUDE/7Z0oR0MKZzVwxc1FESSoVSbSzsWFCWTRdVyY18h50+5ae+gFAJQWttg1GRH8bJiNmxmszGamdWPi7gQVpWXDyEsTGUVxU0tPQJw6vWbrnF+dC/AgKzDUwTNrebZMb8NPrKXUnZfGUFaZdvWDoRsVLZnu2RrrJyThTZ7/BShOhQCfo5+yp+jPVhrYYOsE7k3sHDJkOVVN5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuUCRx1T7PyNtbyKchCLoBMd4PQxD+UIgtcgquyKorU=;
 b=cpmzFeNNZAJK4j33fWxjXqUhFNw7BO/X+V87Bkdrim1uWltZnjPs8YqTJFCswezH5JMg773EduPhm/Z08OLadiz2vB1vosh91n0CGvLgGKwzEDN9KTyeB7MeAc7A0wmSc2l1jjLjMjX7Jiom3cV9ydgzInOpvrTKIxfeu4dsXdSr7bexvV35ESqxsXg4UOUZGLZbOf+Pt3iqI3exT+SInLvN57OsvqHATTj1do5rwdbclKnPAKiFbuaC71y/15+/fYd80IdvzcMJhnstgpo4eTh8O+yjsi1NAuhjENFYjceEZMyhmsfk3jzhyJF+y8hQ2boo+sjhu+shJbCCa/Qiug==
Received: from SJ0PR05CA0200.namprd05.prod.outlook.com (2603:10b6:a03:330::25)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 00:56:02 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::19) by SJ0PR05CA0200.outlook.office365.com
 (2603:10b6:a03:330::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9 via Frontend
 Transport; Fri, 16 Aug 2024 00:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 00:56:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:46 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:55:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v12 08/10] iommu/arm-smmu-v3: Add struct arm_smmu_impl_ops
Date: Thu, 15 Aug 2024 17:55:29 -0700
Message-ID: <2f9f677df068557e8cc399406eeed2d1926e41d6.1723754745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723754745.git.nicolinc@nvidia.com>
References: <cover.1723754745.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: a66e9156-77ba-40e8-fe62-08dcbd8e3358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OSCmAp4E5ujGFZug/HR5mb8CGhR7XQe5iDAZcHVjWKvjJn1B0v7vg1k7emd7?=
 =?us-ascii?Q?vkMhlvEt+UIDRV5TABT+c718on24o8G8hUE6vFUJulJocSu01L33cnIJJEeN?=
 =?us-ascii?Q?fsPal/R1rz0OBY/kmitRzb8LJClRqhdXmSBUR7lvzBT3DsSkGHjH8Aizw4TV?=
 =?us-ascii?Q?8rJErp6QOvTYeZWoolRto39tpm/wO4RGwTkJDkfmkgbMXXIlpnBgHiUKeOm+?=
 =?us-ascii?Q?3NATLC4sWNJN/qWyU8kDVz77e8UoT7AwAHkpXB5qwNPjDQkhazShkG1SbR54?=
 =?us-ascii?Q?gwjqoeZMuEkVzTi4z8JXrvH5LYGmdatmSRYQhby++YwLl6Og8D+/AgDGeFis?=
 =?us-ascii?Q?vK+h3nhMd3XkjJUe2Qj4hj/gJ0hNCcVe6a8IpIS3KFIJVB+FlkrTCpGZs/mf?=
 =?us-ascii?Q?avAcFTIrjepJPq4I4gQu2DSSz9n2dvLz2p9flbYY8IQxjCGIsGQopN+ss2iQ?=
 =?us-ascii?Q?+bXMJyS8EMbE5NBXdt668iAy2alnvPsthDoyd00OEVrxu2Z3AZY10rTOP0RL?=
 =?us-ascii?Q?j8t1nMTwYY78a314ZTP99GUU1ugs08cwvsFWqjWrTLomXzpTMbL7W6rLtcKk?=
 =?us-ascii?Q?C57uGsIwZfJmtw6jIu5DR0ck3+5xXILwPGEEI1pLJFwcm7MgaQ/TZx1BSozX?=
 =?us-ascii?Q?6LSFBPL/Cm81M/Y/Xmj79EmrJI2ERRnyod1GySWSs8RiwSm5mYvpGQL9zUx3?=
 =?us-ascii?Q?hyud7NQ4M4RSd2FO7ThQu9XwwqDWHE8zYapdnbKypcaX6KwtPefsyC/zYUHk?=
 =?us-ascii?Q?V6YVDyXZaZWfL5FXKrpQZYVk6uc9dSVTIHwncjbZk1g1d0P6MaccAGmWZuYn?=
 =?us-ascii?Q?zi2wlLH5qfeHACQJdb1aD/It/r0CjubIZP+KqIrMKS2i0o9hncZJ/+nFvSn2?=
 =?us-ascii?Q?ObJ/tHOfuCNvsZh5sg/VvwMM750UWX2dcg6J4QJ6f1yexQE67LwjpwmcUKYf?=
 =?us-ascii?Q?/P5VF3YtFaAG5WEe8iUuQkzVBzHBm1qqFgwqFdJ3gMQ5wogtGc+p3IqxQqyO?=
 =?us-ascii?Q?VZNaSESaoSt6WyFyn/+CAdOXwI8uupFsKMaJQQh8qaD4dOvmy32Xmu8GEAB6?=
 =?us-ascii?Q?/ABOst/w8LYYOeo6gG3A22V+K4udM58HHsFLlNP4ilnAsjXurkyGlneItdnt?=
 =?us-ascii?Q?2M6ZBMUXF7/f/npd2DVvMq9mvQoCUQkvcGSCbM1z1SzRKIHErdALmWlk23Mq?=
 =?us-ascii?Q?SE/YLhtoxxZUlaivE/BXtOajQhzvPTPfiWB4BUXfB6kzFNcPxG/j5Zy/+t6t?=
 =?us-ascii?Q?3qzFxe4YF70BHJ4yO1cSDqg+UBlg+Vg3gnAk4FU6I2w2VaqEH24U5PJh2erX?=
 =?us-ascii?Q?OGAhV3CpOjiJIBF7Q4EkHpjMWimHgqny/OBnktssRyEPP1axl7r95jH5rG3e?=
 =?us-ascii?Q?G3ekCpmchXAiSjuIxKUyZKrz61BVn4l2NLao/yGYMePnYBtrmtLR7QdYtMTB?=
 =?us-ascii?Q?OO6SBdW19VIOfQdmPeK4YE9WnGpi8GGs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:56:02.3306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a66e9156-77ba-40e8-fe62-08dcbd8e3358
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065

From: Jason Gunthorpe <jgg@nvidia.com>

NVIDIA Tegra241 implemented SMMU in a slightly different way that supports
a CMDQV extension feature as a secondary CMDQ for virtualization cases.

Mimicing the arm-smmu (v2) driver, introduce a struct arm_smmu_impl_ops to
accommodate impl routines.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 51 ++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 ++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6df3cb0bc406..2159455cd781 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -338,7 +338,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 
 static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 {
-	return &smmu->cmdq;
+	struct arm_smmu_cmdq *cmdq = NULL;
+
+	if (smmu->impl_ops && smmu->impl_ops->get_secondary_cmdq)
+		cmdq = smmu->impl_ops->get_secondary_cmdq(smmu);
+
+	return cmdq ?: &smmu->cmdq;
 }
 
 static bool arm_smmu_cmdq_needs_busy_polling(struct arm_smmu_device *smmu,
@@ -4044,6 +4049,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	if (smmu->impl_ops && smmu->impl_ops->device_reset) {
+		ret = smmu->impl_ops->device_reset(smmu);
+		if (ret) {
+			dev_err(smmu->dev, "failed to reset impl\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -4450,6 +4463,38 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	iort_put_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 }
 
+static void arm_smmu_impl_remove(void *data)
+{
+	struct arm_smmu_device *smmu = data;
+
+	if (smmu->impl_ops && smmu->impl_ops->device_remove)
+		smmu->impl_ops->device_remove(smmu);
+}
+
+/*
+ * Probe all the compiled in implementations. Each one checks to see if it
+ * matches this HW and if so returns a devm_krealloc'd arm_smmu_device which
+ * replaces the callers. Otherwise the original is returned or ERR_PTR.
+ */
+static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_device *new_smmu = ERR_PTR(-ENODEV);
+	int ret;
+
+	/* Add impl probe */
+
+	if (new_smmu == ERR_PTR(-ENODEV))
+		return smmu;
+	if (IS_ERR(new_smmu))
+		return new_smmu;
+
+	ret = devm_add_action_or_reset(new_smmu->dev, arm_smmu_impl_remove,
+				       new_smmu);
+	if (ret)
+		return ERR_PTR(ret);
+	return new_smmu;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -4471,6 +4516,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	smmu = arm_smmu_impl_probe(smmu);
+	if (IS_ERR(smmu))
+		return PTR_ERR(smmu);
+
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 9f5d156b73af..475517729307 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -15,6 +15,7 @@
 #include <linux/sizes.h>
 
 struct acpi_iort_node;
+struct arm_smmu_device;
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -629,9 +630,17 @@ struct arm_smmu_strtab_cfg {
 	u32				strtab_base_cfg;
 };
 
+struct arm_smmu_impl_ops {
+	int (*device_reset)(struct arm_smmu_device *smmu);
+	void (*device_remove)(struct arm_smmu_device *smmu);
+	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu);
+};
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
 	struct device			*dev;
+	const struct arm_smmu_impl_ops	*impl_ops;
+
 	void __iomem			*base;
 	void __iomem			*page1;
 
-- 
2.43.0

