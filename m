Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0FB195B37
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 02:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996750; cv=fail; b=KFs5bxPQeH0ruuNh3RsTPI3sM2FjGd10wjhCfRHH3M5/EF8DWPhyXkhCeTN/hVOq8kRvgrcyGwYtD/ftzLJVj4FOtu9+Z1S35+mL2Hm+dGt4XA+jS4m5YYFX7D9mrTMDjtIYCKoaFOadciCDR/kSk266GzA1wX89H4LSjnStoig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996750; c=relaxed/simple;
	bh=Ak1RQZ3NCchBLSzeVr1nTkZsjb+7NyPvHd4OnlWvgKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQmvij+C1U1sAbH27r7BasTNWnzNGpytZe8w8/l8O9OYH/P5rXxY4Apa90ckalbZ3rZIJ05THXuxi00DJ0sjSIatsDYfG3ksrntVqW9OyaIks6sfqIBHGb6pPIkpRzYwL//ZhtkEpHL3HKrbKC9GmjGdk8waGS1WC08h+Ek6Y/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WyMajqkU; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WyMajqkU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EALP/PC047J/rIyn+1999fgpe24fmLCcrtIf2APSHucA6YluvLGWZh8+1ph041/X2dEsjmV6hsTtXmdjkHvMkW5MnNl1VDRMKEqUp5IsVLU6emU1B6/mxPegAZYmbxdIox9lLyeWK3psh4cQKsOiVPzsjgLW5eILEFIYd+JzsktdoqStMExrLuq+X/LTA4zHDliWlwEebMwl4ElPTqb3eF9KbikkCSv8FX+QAWZfyQkoqzTTQZQVuk6ESSnBXt/scFwOiZWZ5hTYNUHD2vaUzAmrsrI63JLhnLLewHwnVdwJxESY3GCQ1v2Au3dGwuF8bR76ZqDd3Tk2MV4Yg1A3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaTqD6GVnBngTTPeqFmyn3fgvm6Z8fAbprgFssFM/WQ=;
 b=HVF6nPlK3mS+vH2wnCyha8QAJNjMxRMeOxds95VVD92z7xGMyyt3dRHEOuvOKJJYRU6qzz9077pkbDGheSeaW490G3UcYEC283XM68gMJKB8flfQYkPL5JXSjuLNQCn/HA+7yZQac5V4Li4dp2CPBq9wE1V9qV6PXZRFXmsErzkS8cEaQqP03+jTNt96gMX6WQALEteBBd3MOtYffPN2JSr4fFv8Fweoo8+On6W+0WWTzCfbF9hGeGj2xuI9jjLofMNYWl3dlTfjDKeYfzWMkROAvjqJGi/U3L+fiGT2hkvjI0shg6ePrhLWrqbUlzecCdNdTSesR5I1yMeE69BFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaTqD6GVnBngTTPeqFmyn3fgvm6Z8fAbprgFssFM/WQ=;
 b=WyMajqkUzGg6/47z/r72BBATb7rYKBNLPfKayZ+8axb2h0PG/v+gde3+8/RwnX0jognPzF84qQ9v7RO3yJq9iAoWYwEn6VoLg5qhuEtMjdYN2EGy3Rz+A46VEljq4lNs4P04t4bqgi11PFJ6LfusQVMQ9eVozyc07fKkLXAHdZdjhMbJzBD7dr8FOhwcyCiQffCL5YL6VQbA4R8p90ycJxAh/X8I13nJo1QDZoVP39xbrTVDWIYhkv5GfIz2Q5f92IQg9xIPVkqQxL0OEgyk4/avWQt/DXgQUgZivuhkpNJna4/bwn0CIscUSWDN9+5+xkf7MP2ZAZUUzE9gY7NSZg==
Received: from SA1P222CA0172.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::28)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 02:12:24 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::92) by SA1P222CA0172.outlook.office365.com
 (2603:10b6:806:3c3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Wed, 7 Aug 2024 02:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 02:12:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 19:12:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v11 7/9] iommu/arm-smmu-v3: Add struct arm_smmu_impl
Date: Tue, 6 Aug 2024 19:11:52 -0700
Message-ID: <8f6fd78b4c4358e65e9d171d90aa4a3dac392f09.1722993435.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722993435.git.nicolinc@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: d637e5a5-5df8-40ab-9db9-08dcb686605b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kMb/ryLbNYxpT0ivf8XkwyGlWUWo1PaUNThxqutSV8Dtk+aRpYVV+x2LR0Zt?=
 =?us-ascii?Q?2i09YCF4reKfp6eINecXVxnfyMg4Wz42hijjDqAWZjon1wVeQTs049ZykwWg?=
 =?us-ascii?Q?OQXeyvlDgjLepn/YQNgifXBwQFj0h2AKQZPg0OLU47l8h1DB5nuAv1YXb9ee?=
 =?us-ascii?Q?hJFpgVHUN11EbzBfokSisPqMdRjQg4yGi6SGbFkxnWuGK9NwYNM3rjn4JFYi?=
 =?us-ascii?Q?0AfMRZ08lKSLGGYcsaiaTFkVpawiFcy6JgMCEpNJ0E0S3k12VU1ttkWDdLZs?=
 =?us-ascii?Q?J3gVUXAFvqP5q3ydir24G12tO5BQTHCoQq9/0d+xlIfu4IwbgqG6tmEwlm3x?=
 =?us-ascii?Q?5wnRyNd0HXwGjRbGHWafK1veqj2G6U16T7JGMkjIeoEGyTKf/IFzLSgU12rh?=
 =?us-ascii?Q?BkUiZNfp3nOEfCcZ3BAkY60LaYyHKRuxT+poeceAm9wOI4UL+l4KwiNk7iB5?=
 =?us-ascii?Q?2kpJkZHeKmdUsXNMqCJ0VAoFQA2/RMQZiwGc4SwKRWgE98Q8pwrVfoHQxp0w?=
 =?us-ascii?Q?zxOm6IgPg/FQ56UU0Jk/ai0BJPi7CynRlGFGl7K7czhjmvIyLSObZN71ykj+?=
 =?us-ascii?Q?mf0owEb6qVZss19L/fR7AiY+PRQaYtBKSvfWUKYXCbc0TUYdACm16xnchJWa?=
 =?us-ascii?Q?h0edO5GAoWo5ZTMd19zDd4+FGYSx6g61+9RTXIzqzizG+rBTDAn1t6LuzkGU?=
 =?us-ascii?Q?j4+adYbK8JPLYmxyH9af3QFAThR1xKBR1SWRDr6flXaZxDTtS44+kLxjsWp/?=
 =?us-ascii?Q?10nj9wmKAstQbB23wp9udrROVNPdyKVZ1leDGTxuwsYtqD/r4kpZKjSSmg0l?=
 =?us-ascii?Q?6eCbTqGH1dFiXTqpzz4BaHRQe2SF/m2rzuU6vjFQKJmFqn6UPnQy/IV+XaTQ?=
 =?us-ascii?Q?Qr86o7cMhfoSksnfLQMHXOBU/iUqdNL5tFSyXko1jCR3DKsOl0ktbrFSzYco?=
 =?us-ascii?Q?uisRzbTVIHT3pG4zjIWfDQ8Mx6PrNsIGOLvSdzY56ohHBqBqvLQYItbT1mlj?=
 =?us-ascii?Q?RnmbsHhKV4MWMPTWFzY0F20VW/cIu+G9yCsgMzwiTqGhyPRdOlxw4Z/R7SDA?=
 =?us-ascii?Q?jShXJ3ERV0zPKFL+r2zue/qYayWNHJ53td2u3uNPYwMJ5NIpqDxpaZ8VGqqC?=
 =?us-ascii?Q?Po/RJcjTa9tM4y3fcdgcWSKeHxQNDhPK5B4yyLJ8veQKaJtIjjUjc5WU77C2?=
 =?us-ascii?Q?Y5q35ZsB/aHOFKF+k2omv5e/O3AMUhU/ZuyuWvf5CIdZRdVldEiE1yeHgGSJ?=
 =?us-ascii?Q?tKmaHP2rxOzFCd8VZj94Iq6jUcOhhVoB6FLp+LjFnOK/SsNMPEhA+G5RI6ai?=
 =?us-ascii?Q?sV2nuZ2877FTr8MkN6jtB7wEWBv8A4bxiGolFDqvZ/TeFkqV4srAClbEAKbl?=
 =?us-ascii?Q?PZVixinCN9e6pzxdwLTyzPhW0G15bCm5a0qUEy1RkXa2bPCg3vxjJNdr//jO?=
 =?us-ascii?Q?g4cUB0uCgi0NE3bBvoFPhVKEruKGZh6H?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:12:23.6695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d637e5a5-5df8-40ab-9db9-08dcb686605b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407

NVIDIA Tegra241 implemented SMMU in a slightly different way that supports
a CMDQV extension feature as a secondary CMDQ for virtualization cases.

Mimicing the arm-smmu (v2) driver, introduce a new struct arm_smmu_impl to
accommodate impl routines.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 67 +++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 19 ++++++
 2 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e764236a9216..18d940c65e2c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -338,7 +338,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 
 static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 {
-	return &smmu->cmdq;
+	struct arm_smmu_cmdq *cmdq = NULL;
+
+	if (smmu->impl && smmu->impl->get_secondary_cmdq)
+		cmdq = smmu->impl->get_secondary_cmdq(smmu);
+
+	return cmdq ?: &smmu->cmdq;
 }
 
 static bool arm_smmu_cmdq_needs_busy_polling(struct arm_smmu_device *smmu,
@@ -4044,6 +4049,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	if (smmu->impl && smmu->impl->device_reset) {
+		ret = smmu->impl->device_reset(smmu);
+		if (ret) {
+			dev_err(smmu->dev, "failed to reset impl\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -4347,8 +4360,23 @@ static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
 	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
 }
 
-static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
-				      struct arm_smmu_device *smmu)
+static struct arm_smmu_device *
+arm_smmu_impl_acpi_probe(struct arm_smmu_device *smmu,
+			 struct acpi_iort_node *node)
+{
+	/*
+	 * DSDT might hold some SMMU extension, so we have no option but to go
+	 * through the ACPI tables unconditionally. On success, this returns a
+	 * copy of smmu struct holding an impl pointer. Otherwise, an impl may
+	 * choose to return an ERR_PTR as an error out, or to return the pass-
+	 * in smmu pointer as a fallback to the standard SMMU.
+	 */
+	return arm_smmu_impl_acpi_dsdt_probe(smmu, node);
+}
+
+static struct arm_smmu_device *
+arm_smmu_device_acpi_probe(struct platform_device *pdev,
+			   struct arm_smmu_device *smmu)
 {
 	struct acpi_iort_smmu_v3 *iort_smmu;
 	struct device *dev = smmu->dev;
@@ -4372,18 +4400,20 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 		smmu->features |= ARM_SMMU_FEAT_HA;
 	}
 
-	return 0;
+	return arm_smmu_impl_acpi_probe(smmu, node);
 }
 #else
-static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
-					     struct arm_smmu_device *smmu)
+static struct arm_smmu_device *
+arm_smmu_device_acpi_probe(struct platform_device *pdev,
+			   struct arm_smmu_device *smmu)
 {
-	return -ENODEV;
+	return ERR_PTR(-ENODEV);
 }
 #endif
 
-static int arm_smmu_device_dt_probe(struct platform_device *pdev,
-				    struct arm_smmu_device *smmu)
+static struct arm_smmu_device *
+arm_smmu_device_dt_probe(struct platform_device *pdev,
+			 struct arm_smmu_device *smmu)
 {
 	struct device *dev = &pdev->dev;
 	u32 cells;
@@ -4401,7 +4431,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-	return ret;
+	return ret ? ERR_PTR(ret) : smmu;
 }
 
 static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
@@ -4453,6 +4483,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	iort_put_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 }
 
+static void arm_smmu_impl_remove(void *data)
+{
+	struct arm_smmu_device *smmu = data;
+
+	if (smmu->impl && smmu->impl->device_remove)
+		smmu->impl->device_remove(smmu);
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -4467,10 +4505,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	smmu->dev = dev;
 
 	if (dev->of_node) {
-		ret = arm_smmu_device_dt_probe(pdev, smmu);
+		smmu = arm_smmu_device_dt_probe(pdev, smmu);
 	} else {
-		ret = arm_smmu_device_acpi_probe(pdev, smmu);
+		smmu = arm_smmu_device_acpi_probe(pdev, smmu);
 	}
+	if (IS_ERR(smmu))
+		return PTR_ERR(smmu);
+
+	ret = devm_add_action_or_reset(dev, arm_smmu_impl_remove, smmu);
 	if (ret)
 		return ret;
 
@@ -4560,6 +4602,7 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
+	arm_smmu_impl_remove(smmu);
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 71818f586036..38d4a84e2c82 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -14,6 +14,9 @@
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
 
+struct arm_smmu_device;
+struct acpi_iort_node;
+
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
 #define IDR0_ST_LVL			GENMASK(28, 27)
@@ -627,9 +630,25 @@ struct arm_smmu_strtab_cfg {
 	u32				strtab_base_cfg;
 };
 
+struct arm_smmu_impl {
+	int (*device_reset)(struct arm_smmu_device *smmu);
+	void (*device_remove)(struct arm_smmu_device *smmu);
+	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu);
+};
+
+static inline struct arm_smmu_device *
+arm_smmu_impl_acpi_dsdt_probe(struct arm_smmu_device *smmu,
+			      struct acpi_iort_node *node)
+{
+	return smmu;
+}
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
 	struct device			*dev;
+	/* An SMMUv3 implementation */
+	const struct arm_smmu_impl	*impl;
+
 	void __iomem			*base;
 	void __iomem			*page1;
 
-- 
2.43.0

