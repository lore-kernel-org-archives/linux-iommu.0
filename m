Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2733344A
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606776; cv=fail; b=Ew7QA6tfGQ/zQpEVY8lYwG3ib3OKp7RRNYK6N/BFsYmBQyTL+5ZfVQlglzNFjufj/yL94ydbkdQJrICzxYUBer4qbwwMQAWHPme1/98Fxti2B69V6jFzbo2aVUwb4ceMbTl+Ax2q/Q93MqWA6OAFXDUlAKJ+WNuk7HdTjmRbRII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606776; c=relaxed/simple;
	bh=gBOB/Q6wj1j3VFLEYffxuu4JsPwg6VQQMVxtVaXcL+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptTKtcgnsj9T1amvZLPSNo0iVij0YZYUfbqv9+Z5fkGSOF12PH1Jw0vjc5ARkspDUSbLXD9StO4TZXKLQlceK+DFaebJ7voL8v5Jhoo8namKLrOk+OUsY71aJzdvflWm2cVO72s0p5x8jAwaQZSoNOpSnUNAYcdKdg0NpwiRSQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WLBBp7IO; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WLBBp7IO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFE/GSPIYOYjK2moGQUwHyG9fxp+xc3/xwomC2iwDz82PMUdB+ZEy/TYRKkCOLfDo/DoAe5O3YUJ2gKnIYyJCnGPtVsyetpVFXlTFfuqHCtqGEBuEEofqseam50Ee9TOQ5G1qkdR9TfHMVCTSTDulbbezfkOrC7hyDWOSf5nFs6l1gRmjF/Stl/aJr0VJARkRKOjxi+QSKYdUHZ8QvlM6BnvNDbxEo3rYy5WnxVhRs6fqw/KmHggrqo+4YgFxGE9PnaexCygLaY7YE/VU1uqzS6LT8g6TDBC92ml4zAVOhcHutecZoJkYELBT2rOvB337GNAHVkyyU3loz/dWKWiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kvc9tANq2dMgMuIvGxW+qbtjsaKtDQkFP6v/Lt6enFo=;
 b=jl+jSpawWnB4LKGyEkHnOujq54g7xKbuFOixi/KrRG8iyEZ8xJJ5/tdnSt6kEDOxbnKQw4W4ppCmuuFLLfKyKATeV1BoZ56ANAuDTln/VibFCqProM6CCzI1DoWqqpC7gw942C2gl8UJipqrt1MkebI77PKs1eCMnswHPFOaSlHqcj0YGSyHVKQIsD17vTJLv7pAu08wuoefzbjFSfFrCsY45JGMKkNycEU5KyZI8tw+6HTir4UCwhaK0zMxFQzel9GQnGk0NjvJ4+8HocLbihn4cWdI99+Z1LZIh2xmZMjq54J8QrLvkbqvShnRrHGd8150QPv3HNI69vY7PSi7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kvc9tANq2dMgMuIvGxW+qbtjsaKtDQkFP6v/Lt6enFo=;
 b=WLBBp7IOIjZBwxgyK6oStYUQNmNTGWWDczWcGzyaJTY+k+7AloN10zSE9/+iVt92677pf3YEbV3NGM0KuS3QIJa92v/GtOUtbevoF8yHibdglk6A+eWoZGiDpeOSwgb4imV4FIRknk7Kq6mQx73YbwWG4mp1leL9gsoX5Q0GBIrMlZMO6PPWTaEgMkSPqDBq6cE+m3c1pDQa2f8SyAKZBmBX8QXuI33OKct3GDY6hiSaD1IPGKUWNrZ0+F9njyCVp1cVmVruQrTAWjLduX395v/Vdzr3Qd/eUHyGPCl39UgNn3QQQ8sxDMI4DpXdBSj1C02DSn+XIydf8RNfX+/GQA==
Received: from BL1P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::10)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:32:47 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::c5) by BL1P221CA0023.outlook.office365.com
 (2603:10b6:208:2c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 16:32:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 08:32:24 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Dec 2025 08:32:23 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 1 Dec 2025 08:32:23 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V3 1/3] iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
Date: Mon, 1 Dec 2025 16:32:17 +0000
Message-ID: <20251201163219.3237266-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251201163219.3237266-1-amhetre@nvidia.com>
References: <20251201163219.3237266-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfdee40-09bc-430e-e8a0-08de30f742a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLQD97FBgQyKmOdhrc3haA2jxyuQ574BeVqUqMqCjHIyFdQMy4Z2tcSywCDm?=
 =?us-ascii?Q?l8fBW7DxDJGlH8xinO8EM1NZ5CdxB4wD8zfe+EZL87PEnyc1MhV7JYaVCHH/?=
 =?us-ascii?Q?I/RYtWKAG7xfCWrYWFKvV7W87GKtyw+qaXvu/okIvg9Pm/sLzsQLiXD5Stht?=
 =?us-ascii?Q?6BrwdnKQ7N44J7/3fL/Tem45w+/zABd7pPW//O/viq7C1SnwoIWCckjgaUA7?=
 =?us-ascii?Q?zJ5xKDq9MI9mG3GMACuaeeiHszHuVYqxw6tW/mwPTJZJBTQBPmZc5JZOpyhE?=
 =?us-ascii?Q?gDe8VP510tSPth0SAQknv18NRAYgVBuph4Lo3xTX1ARgdQCQwyUlT7FeR6mo?=
 =?us-ascii?Q?T4FRiLocwfN57yKBknNhVBt4i6UtLB7CPVU+yW86h2HD8vd3lGykLruJKFn0?=
 =?us-ascii?Q?VECfLXb7ZT++KLXMhwLlqnjUrLCPTkknVUNx8JfGO5IPdxv88FYXbhP5Vu8n?=
 =?us-ascii?Q?Uch0NR0W7cC+9NJ5FMqMuJV8audzPbEiQ9VoqDnu2xlBCPAzX4XbNe1YE4HE?=
 =?us-ascii?Q?EDFwJN+vDREUYMRklfmMdFZLblSBXhpDOU0YVVxnINKLj8U0RNac1tJjLu75?=
 =?us-ascii?Q?3fuwLmErIRKCEPWpOBaBwwijJg0oQ/2e1iJG0TL+ODBHHaW3qzQiGp0KXAQb?=
 =?us-ascii?Q?aCRj90/Pkg7/HHMaI5JGVY8jA9RjnkNdk0x8yZR1ouKUhpGTp7JbcOf3FNUR?=
 =?us-ascii?Q?ZcetR1pZ65b0vdP8135PJvIsw0dBbhxScd9iJWB3uGa0Sh6uXtnglHlXfVny?=
 =?us-ascii?Q?KF42pZWxpdNAkTxURdF2KXIBgCR33HTQBsT8+2CawZUM2InVQQhZgVm22xzi?=
 =?us-ascii?Q?WOqkUEuUpBVSZ9rCaET4vqqADRb7MTr2i+9anvQmcclIbPBA4dU6HcSvBfv8?=
 =?us-ascii?Q?qG+38gXrkkB3KKe6Y4U2dIkQBm7rjU7LLbeuJToPuWdRUjMcjUAIKZ+7g8a/?=
 =?us-ascii?Q?Z/GUvhSW/eLz7wk2R725KqK/blcwdCt7s3+Tugoacc8PSlIQr+DwQkTOc/Zq?=
 =?us-ascii?Q?Ubwu9KgKJ6NWwk0Sn67QivsfLKa0B+xwIQakLANeSMZm6WEPU14cT6VzP7X0?=
 =?us-ascii?Q?DagcXpdlUZ4/tg0z5EX0muGYRSoF/VtV/mWS5cGcjj/ymgXZqZrKSjN/nYC/?=
 =?us-ascii?Q?BC7LBwkcWCVodHDTKzv1gcTKoB1CZeR28KSzVHxHDBwU8AKGcdlaVRK08Fol?=
 =?us-ascii?Q?rRxUVgWWxD0hzqqMbESdm7e8G73ncoqYH1INoCS37Kk3TJPMdokBXQDL8yRP?=
 =?us-ascii?Q?ZHG5tN5yc0UipShpHHdxkSQdaMcT/jT9Oo+jG5fSAzFfu1nP5Vmz5MLGj6lY?=
 =?us-ascii?Q?s8SHB8xT87Ik4LxlGiswLz9nC822tjno0baJT+bOo/h0+ijTe6HShnEbxvg1?=
 =?us-ascii?Q?HdVvxorBwqI0E/Vd6FbYU7iOLoWLKb0dQyt3AaeZMQus7eXKQYSEs99bSBWZ?=
 =?us-ascii?Q?Am0WEGX+9n0Fa+NHTHgs1aJ3irK7RF/k0f+zw+wUm69isuRMXvmcKIuoRL7U?=
 =?us-ascii?Q?fd3/VOGGFCVkXlJC8BC/A9/f7eBeBigsT9oHRVMLgqmieYO9ECet5s1qv1WO?=
 =?us-ascii?Q?nhJbcVWHNfCMnBHuUwY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:32:46.4718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfdee40-09bc-430e-e8a0-08de30f742a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793

Add device tree support to the CMDQV driver to enable usage on Tegra264
SoCs. The implementation parses the nvidia,cmdqv phandle from the SMMU
device tree node to associate each SMMU with its corresponding CMDQV
instance based on compatible string.

Remove the dependency from Kconfig as the driver now supports both ACPI
and device tree initialization through conditional compilation and
ARM_SMMU_V3 depends on ARM64 which implies at least OF.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/Kconfig                     |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 32 ++++++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 43 ++++++++++++++++++-
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index ef42bbe07dbe..5fac08b89dee 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -121,7 +121,6 @@ config ARM_SMMU_V3_KUNIT_TEST
 
 config TEGRA241_CMDQV
 	bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
-	depends on ACPI
 	help
 	  Support for NVIDIA CMDQ-Virtualization extension for ARM SMMUv3. The
 	  CMDQ-V extension is similar to v3.3 ECMDQ for multi command queues
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a33fbd12a0dd..206dffabc9c0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4530,6 +4530,35 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+#ifdef CONFIG_TEGRA241_CMDQV
+static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
+				 struct arm_smmu_device *smmu)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
+	if (!np)
+		return;
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return;
+
+	smmu->impl_dev = &pdev->dev;
+	smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
+	dev_info(smmu->dev, "found companion CMDQV device: %s\n",
+		 dev_name(smmu->impl_dev));
+	put_device(&pdev->dev);
+}
+#else
+static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
+				 struct arm_smmu_device *smmu)
+{
+}
+#endif
+
 #ifdef CONFIG_ACPI
 #ifdef CONFIG_TEGRA241_CMDQV
 static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
@@ -4634,6 +4663,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
+	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
+		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+
 	return ret;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 378104cd395e..2608bf6518b4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -11,6 +11,8 @@
 #include <linux/iommufd.h>
 #include <linux/iopoll.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <acpi/acpixf.h>
 
@@ -917,6 +919,26 @@ tegra241_cmdqv_find_acpi_resource(struct device *dev, int *irq)
 	return res;
 }
 
+static struct resource *
+tegra241_cmdqv_find_dt_resource(struct device *dev, int *irq)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "no memory resource found for CMDQV\n");
+		return NULL;
+	}
+
+	if (irq)
+		*irq = platform_get_irq_optional(pdev, 0);
+	if (!irq || *irq <= 0)
+		dev_warn(dev, "no interrupt. errors will not be reported\n");
+
+	return res;
+}
+
 static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 {
 	struct tegra241_cmdqv *cmdqv =
@@ -1048,11 +1070,14 @@ struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 
 	if (!smmu->dev->of_node)
 		res = tegra241_cmdqv_find_acpi_resource(smmu->impl_dev, &irq);
+	else
+		res = tegra241_cmdqv_find_dt_resource(smmu->impl_dev, &irq);
 	if (!res)
 		goto out_fallback;
 
 	new_smmu = __tegra241_cmdqv_probe(smmu, res, irq);
-	kfree(res);
+	if (!smmu->dev->of_node)
+		kfree(res);
 
 	if (new_smmu)
 		return new_smmu;
@@ -1346,4 +1371,20 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
 	return ret;
 }
 
+static const struct of_device_id tegra241_cmdqv_of_match[] = {
+	{ .compatible = "nvidia,tegra264-cmdqv" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tegra241_cmdqv_of_match);
+
+static struct platform_driver tegra241_cmdqv_driver = {
+	.driver = {
+		.name = "tegra241-cmdqv",
+		.of_match_table = tegra241_cmdqv_of_match,
+	},
+};
+module_platform_driver(tegra241_cmdqv_driver);
+
+MODULE_DESCRIPTION("NVIDIA Tegra241 Command Queue Virtualization Driver");
+MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IOMMUFD");
-- 
2.25.1

