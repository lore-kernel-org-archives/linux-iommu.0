Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651881AC1
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206726; cv=fail; b=uyJRB3LS4ZlNFoIVtdsRWDvLlKCWSH0a4glSmHq+aPFxCrbDMzwOQ/bBJOteYSrV3NlEY1MB53+oTQs64ccAzneM90HQy1Pg3vKuQXE8nug++IKetUI6774NkXJt7oTDiH4zWsgJ9SfCw0xGq0yNRic1fO8nKI8pHG2Y7jRf99I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206726; c=relaxed/simple;
	bh=En3a8Osk8GgAJ3Mr6l/DVLt4N7ToChSxlINtSb4iqpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WY2r/XI/m2a+tgfAmePt9svSUo4X6ftT5ue9tlbMc6b1RfKL+DOdYzD101h6q6GZk59xPwjbJi5yq0DCaMgvXBjLIG7EX/HejLpc5rdrxGifL7VnfIrmdMGsHr6aMBNhbao84U4mHlYEzb/iNpPNhJc76GlvK6S2r0qzU5Vs1M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KhcRnIe/; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KhcRnIe/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=el9M2s1qPS2MJJqX0ceKCRLji0UIM9d5flCIq+8005pMFKIGXCUOmY5Misek/UDxEbFReSsFkV9/uI0wmpNqKIqcckGaPdSJPR/JgSQ4e7Oo9QkUWx0DS6LhzBuO++KPjsM9OrsXnXSsd8E8yvbYRXQZ76x43N9ogAD2PRSmz8RQ90oB5TxbyjTgJl+ox3RUdKF74t6ug1aYCJ+ux7yzFdItRetS77jKEKvCU3fNSAemEO1QftUS0s5JL964yoq18GBvZH/3FTbdVhKxt2AFlesVtcOVAj8jiUh2BzSBVYrZS7caS94/DC+UklmWagl2FhnXKNCl6jfUhi7Hhi24+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1DysAuwBylhHD4G5WD3grReAAbyn9//uozGOk5p3sA=;
 b=oVJNvyUhx4BMdYMB1AxQq0gPGVXTYHzn5lFF3BtP1Q07wMdMv8qkJsym0DQQT1FhZzsQ/0P/477X+RoaSLcqb+79uAD9+k/NgFF8x0jRou3Vrqqqh6DMJ294AHW7Dk9syA9UGHnYOF2B5m9HbBq3HW3JMVo1RqOXw9lptkqqKI3Qa0NC2v5RkqKrE25RJzqKpvrt7zXMBrasmQOgdBGsD0piwHkedRqdyJIdRO+vEzx2Vci61ErNhxF8bS1YVaECb+TPD9f5yaN0KhtJVwfsKYaDtuqtnzT6gTU228uR4pDFwu8EVBkL2PKXEB5gKC4kj57XXx88GTjPhjFi1YrqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1DysAuwBylhHD4G5WD3grReAAbyn9//uozGOk5p3sA=;
 b=KhcRnIe/vV/rmlX6KsZpvmNulipqornQHLhNVjrwQlcZk2d0GpJ6ELzfAvfrtKa9Ucre5b/lB5khqBL4FQAxS7PA3+Ew6UMPqMMTyiPN0Mrfpbr6PYzoyf/uyp52BF43QezJadlsxlT5gkQdWv/Kds+KZ/tmD5gmQ4EZYr0+V6bRWhWdugR5I3tVJNf6qbnpoQN3WhsUexUptYxbsQl/QAtT/txG93fvHADVn7rVesM3l3vu2euXwd+bgwkDSlvicpAIvAOutXKCD66ULY1Rz0t80gkJEXbwivrB8la1msWahL9l3EhlBB/sI78WtWc4SSgpkC0UvOQv2D99+OzCRg==
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Sun, 28 Jul
 2024 22:45:20 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::62) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Sun, 28 Jul 2024 22:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Sun, 28 Jul 2024 22:45:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 15:45:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v10 7/9] iommu/arm-smmu-v3: Add struct arm_smmu_impl
Date: Sun, 28 Jul 2024 15:44:52 -0700
Message-ID: <173976eb174eef0a36d5280abe175f6ca0cdcc90.1722206275.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722206275.git.nicolinc@nvidia.com>
References: <cover.1722206275.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eed9f48-d428-4f94-87a3-08dcaf56f5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T/mZJ4o6vi3SZqsEaLrZhXCZkCdAscAFv3DPxagrwIAN//DaD8TV9ipdn5xb?=
 =?us-ascii?Q?zcmpolZ19Z1/Ncf2RZDpVKLWf0uxe2i98zcEsubDaL4TNW/DpUqXJl9nxtAF?=
 =?us-ascii?Q?zlWW1oG7SpI+9owYuxwYdsS/KJLnWcaAGm4IVhaD14s55dP6G7iqvLwkLhTY?=
 =?us-ascii?Q?AX023800lna4yd+0KoFg+vp/QTs5AYwm+RIVztwOfjmq1YenSD1cX7Klfued?=
 =?us-ascii?Q?S2yNIkrk5UWLQ5uSJSlNk6q3/rluxrxO4TQ8Xvn/YmFbwrvfXpS+5iT6X0SE?=
 =?us-ascii?Q?Y3A+eN+5MNj+91Dlrvg/n6jeS5cPGFNIbfAI8aCLFLC/tlHk49URoJpI3nBw?=
 =?us-ascii?Q?UE/QzmkJv659eYP6pMqDZgX8tUzZPDD2xsJydCfRVq7oO1wKqSun6l8Xukdz?=
 =?us-ascii?Q?GBsgMv6E8bKeeQR5jrnVNK2NY5impUkQd1b/0bx7OFTg2/aafXhAh7JRpiaR?=
 =?us-ascii?Q?ba1hOVYkXhqhtKep7cijA1UZwgejgR8967dJXF14aLTHEObKf4weyUbqFz0U?=
 =?us-ascii?Q?WIBViY7CxFLgm7XJcqzKHcpnCUDAd6uVVbRej1YY3KJZoJ0qDPcdhlVypr/x?=
 =?us-ascii?Q?8777I/lgiLW681qx7bWafmGUBpJBJKqsiJSem8eOP/Vo0cXR/Vz0CU8QVmH1?=
 =?us-ascii?Q?EonMLgRk7VGgILrH73QrQDKA08/U7Eyh0Snx3hOGb1GYx4N6C77SJoMoZTOh?=
 =?us-ascii?Q?rTGPD5FE4pMtQPaaZc4aQIkynxyDmZ4YAfy1sdSM/Jk8esnynnCPlmA/+RMx?=
 =?us-ascii?Q?zcY5lstJCkFLoIcd8riyebqZ5oNuUxakPHG5AFWCC9InphZ7bTswybZurP8N?=
 =?us-ascii?Q?cBOGsJJw22uQbbqh/RndmKy5pG0ruWTBUDgSELwNtM9I4WNUrKSGCCUAskKI?=
 =?us-ascii?Q?thum2GqH+/Xrr8WFdxY0BHeHD4v95WDY1UB4pi5MGgKEniescx3u394Roghh?=
 =?us-ascii?Q?CartwfVv+YKqsjC/21CgHjm9U99u/h40cFenwu92K7mAYXxRoBM/BlkTwt/v?=
 =?us-ascii?Q?9x5nV48/dOV4g2NSvVBuyIDI6eoNKNaQseK6gVsqL+qeJdTseu8MC5AzWxpc?=
 =?us-ascii?Q?1DwQcxAsnfGmsZtnrjRFiMC6pqM4v9G4fuKLWoHhQWZppxljnoVeY0ZyqqCA?=
 =?us-ascii?Q?n8yWRpiyETXJGtiRaGIaLNp9GBdVHfKZZfyM5RVUWJfySeZwz9SO6931a0Tx?=
 =?us-ascii?Q?AMIlqtkastnHPTE74UkrcjQdTnR1tgIxObFY06er+8rnJv/sA3pQ6y+kQ+dH?=
 =?us-ascii?Q?nCwp+3URmJAre83k9g4fuWwDzhtY1wfaZCUL0WnEFKAmmKze4z5s5QnGUw3p?=
 =?us-ascii?Q?h+/C4r1j3nOpV4aJmQGpoyWrpsIaiDMW5uEgmFHaii9rfpBvb4ZOlM2k2Zn4?=
 =?us-ascii?Q?ErPThVTO+o1WfB3ArNHwL4C7DvoljoLY54fn3P+op1x0RhGMxu2WJoHUSpIM?=
 =?us-ascii?Q?2M5S4lbnB7T/G9reHspBhNm8lsHd7o1x?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 22:45:20.3021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eed9f48-d428-4f94-87a3-08dcaf56f5b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357

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
index e764236a92166..18d940c65e2ca 100644
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
index 71818f5860364..38d4a84e2c821 100644
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

