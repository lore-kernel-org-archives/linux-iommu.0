Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479198F6C
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458276; cv=fail; b=lf+XSavNSOaSRzqLXnog8oL/IZlCdQs++ADL1pPqGW8C6ccWzOexgHk0xTVJ7XkXLDabc7DccdnqRpnHY5kIT77FcEeezzV8aEfEfjPcmoZAThiDNhF1E4WRz1aOWsd9lVS6SYJquwjk4V6VtpHXh25Wu7+O/Z4dYZLhw6HqJZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458276; c=relaxed/simple;
	bh=6FrBCiPhYGm+xfDn4C2EsSjwxh75MY+JAt3WqTkhnLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ta1//Ck5UB6Gjc6eyRnLzZ9AFIniAJa45NnLidSiw2QXysy6/O999HutNgAk+86S5WwTskhldgcoUEVgMdv2K6ROuYGlVsKBSGO0PqhCBe+WyFKmTEvw4hSCioLkf347ZGbkWfdMZTb9DXXHa2jAKCHEHKBgHS1OAc10R0CY5Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JQB1LvAQ; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JQB1LvAQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kuzz2tRjVHB5vkik/xxzw+1HDUnLpOfeq5RsV9z00naTXbor55N7qoB+1VM+DOaKwoy0coGUWB85Wxnfu97RGfUCm18a3r1e/7ZRpR2q7XeeEomhlgLu3LQi86Vj1BpqCDZUe0yyeUCLN4TBsL+eFcGi29eigF+NkCOPMriBSCjjB1wGJEiJqzJtZV5PN8KVj/oawTyajHtXwI9TKQJocrt1qaTHSfYFNcRyzWDm9qL9IT0MrOln1FWx6sd0Dx1Ny4Cx7LYzOySLazUt8tgBAikHhaXlOV8Zer3V+MmaUPLdABieuUN8Iuld3Wc0YPEIpDjkIyNW3R24f/ice24nOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkKRpziQG8+7oEEa/wpm6Pr7g2iIVLGZrt/AD1Pz5BE=;
 b=RCdYWJGR6RuuDwwgLVG0X53xIXEe9Ue7toqByvVIIBWTo6t0+qczyCyaf0V7H/i0wB/1RJEhCNkrPnfr3FSGfmi/dc4GJebBauQzIzHUMVaQZ7JLvcG2zugODrDbPWsHMAuyx9q109YUvkQDM9J4KLvd+KsHjhiEHyEoD/LJNGA67+g+pKLJBN79c1OmL/oQAi+Mde5CWO3Hz6X11ao8UjcQDRYPboZyeKYMZxKYwzbKYpEkpPQqiP/K8WLn+FJqfzhpUDG9W4/3GKM8oMtm+x4yGtPsX8BY2YmAZ2Y8U/tnZe7I7nqMjMGYel9KZasI7mx4o5gRTdcxjMpeD6xJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkKRpziQG8+7oEEa/wpm6Pr7g2iIVLGZrt/AD1Pz5BE=;
 b=JQB1LvAQLlIXUvvzRbIzmpV2P0qkX5dku9FVwOis3cww4teat+MgRBurDyFbPGVVf+O/3pBlvt9lrjJYLVEwvHng9vfkGCmuz3T7OWssAY36a52cre5mSS8Fv7PHIZ75OHTdEadOouGe9jRxaHplRhwUELotrXb/uHLOQEDioJTb83ePNx2b2CrvIH4LoMHkUNcBlDtzNk4GhkyWXMn/Ch5RsnxNAnwd7BgIl03DbvEyh3EYYCCVdEft5mFlaLJ6+ckLInu4S9VP3IJUhnQC1Pc+cFNOGbFErAr1D5zKK9FVKYg0vsAevDuN6WbIl6+N5z58vWX4rlk6YupluIVSLg==
Received: from BYAPR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:74::43)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sat, 24 Aug
 2024 00:11:11 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::85) by BYAPR05CA0066.outlook.office365.com
 (2603:10b6:a03:74::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.12 via Frontend
 Transport; Sat, 24 Aug 2024 00:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 24 Aug 2024 00:11:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 17:10:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v13 07/10] iommu/arm-smmu-v3: Add struct arm_smmu_impl_ops
Date: Fri, 23 Aug 2024 17:10:41 -0700
Message-ID: <681b1c65e4ab113a9725554e428b9f46abf6bf69.1724453781.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724453781.git.nicolinc@nvidia.com>
References: <cover.1724453781.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cd0a71-f0a9-4e88-976a-08dcc3d142de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZForYFZDm0ncegOyzl9FnlcG3iZUR0KKMqcWMMyFEstv315Ub0FhVjsE8OXH?=
 =?us-ascii?Q?RIeu3glbz7/JojuTLagU1GYuNFYXYyGmG9NnKkROk8d3fvMgKvbEDdA2/4SR?=
 =?us-ascii?Q?TVepKXJcWkNfB895rJsjjrSLq0/9m8SQoWu4t7GG+qQxLrhC8gK79JiGEXWV?=
 =?us-ascii?Q?TkrvUqxiSXQSNdQXK32XQVHCv3u8wvUOq9ruotf8So8CnMTi4t6+c+ol1C34?=
 =?us-ascii?Q?4JOMOCCAnX/u7fQWx+X2CPGZKob73bv7wyoxFgQ6ojPAHZwSTwGva6mHLVXc?=
 =?us-ascii?Q?Y8eDH+8RoTNqHzF80R308b/wmdwszfP679IOb003reSmPCyZ7Hr2Bb4NIJfm?=
 =?us-ascii?Q?CVhNunfybNwE8bdrq+WIYQ+VApUrTndIgGz8aq/UU5+bAOp9TDwHo/ysJe1i?=
 =?us-ascii?Q?jkj0XPORQwcQx1foUFmNnLXLO9zLgfokhoSwZLEh12ycG3dOkV6VrAlRAb0B?=
 =?us-ascii?Q?1T/xMOr5eDix3wI543dFTFhGY8V+Cp5Nzgh+y5wJGsNS1SeqQr3dwlH8P/uT?=
 =?us-ascii?Q?ytDMXp0GrCoaHP2if/Qm9k3nhWyKbjjIXf/M+o0L5QrqoRQhViaWWDrcp4r9?=
 =?us-ascii?Q?Zh0bVHFfnYfxtDPEUHl/m/6hsx/16qFixoEENLPfcDRFaMwzSYK5WtJ3vZP+?=
 =?us-ascii?Q?eeNjAGVmdvuvrTE+oRdSDDZ4gbRMUE020g+TlZeQbYWM25WUumIKj9nTvOYs?=
 =?us-ascii?Q?4mTU8FMUWUv8bdv3Wrl8HQZkcyr/HIm8lv8Ymg/9r/lfTUhMTNGRtyGU9Ws/?=
 =?us-ascii?Q?ZRbHImygCGV9Cq9fcwkoTCLQalxABfCD/IiiXDh8djxSBtcTAz6nrKXcfMhn?=
 =?us-ascii?Q?G0QQAlkwsNPpfXgUsj8brqAV3PyDxlt/Ynv/fbhFYWXwhS3F6toHyx4m1U/F?=
 =?us-ascii?Q?p4X0uhXVltWvFY3wGJyTYL8TzSYySXdsVySNbLJxNp5WQmtURVkwwT5GudnM?=
 =?us-ascii?Q?qVImDVt1EvD3cbXvmX89fN3tnNl3CzsMuwZagtAi6lghW9ftLlkYtS8g84zs?=
 =?us-ascii?Q?m0Ljsw3ZDNoetthQXGtGAcj9vBHpC+dXGBi8MhzjqHGNR50E/qhEJpf6/oD/?=
 =?us-ascii?Q?UFa0cmA8cgvQH+OGu6wS8DQ43ij6zKnHbnd+wMhkJiN44oxUcMNKnidhufn4?=
 =?us-ascii?Q?kB3qPj5sihrnwEu5zmhquhsjrj5nZtF20xHkGlIFELpOtsodf6VB2Tmkqt4X?=
 =?us-ascii?Q?SnEWRxFgEnjHIOzS7r0/fx63/0yqw/dX2SXcCfhmRsrYTt3EhFqAUyMwmW63?=
 =?us-ascii?Q?F43o4zZbeWH/CxIsDmmbUF3jopAepB6nfAQJ+R3XboKubgy84BouEuQOY6NC?=
 =?us-ascii?Q?sxGjySMaabCbwkcV+nAOKPIx55j44WvygyDqzX4a+ngVtBFl/QIxQTC4tPk1?=
 =?us-ascii?Q?iklzptEX2b4oYMQCb5AIyT3lQyiA8Xi8v9n9VGe0zPZeoQCv+LTWDhqEX9eL?=
 =?us-ascii?Q?gjhBAk/HWKrm4qS8voI95MXtZZ4eNY/S?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 00:11:11.5670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cd0a71-f0a9-4e88-976a-08dcc3d142de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

From: Jason Gunthorpe <jgg@nvidia.com>

Mimicing the arm-smmu (v2) driver, introduce a struct arm_smmu_impl_ops to
accommodate impl routines.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 51 ++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 10 ++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ceb31d63f79b..0c2b5ec02c9b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -348,7 +348,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 
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
@@ -4052,6 +4057,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
 
@@ -4469,6 +4482,38 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
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
@@ -4490,6 +4535,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
index ebd9db4789ff..c2d864992280 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -14,6 +14,8 @@
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
 
+struct arm_smmu_device;
+
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
 #define IDR0_ST_LVL			GENMASK(28, 27)
@@ -630,9 +632,17 @@ struct arm_smmu_strtab_cfg {
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

