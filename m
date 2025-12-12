Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA627C84E
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519708; cv=fail; b=sxRsMSByxckFwWX7CDpbkcmg45x2TrBe2R96ojyVjmKKDMPjYDa9mbeKPcwOfx186iInDtyD6z9Te54lgjrDrY9Yq4SlSAD6bJnz30MZOnkPboTN0TqPQQvGRc/e0YFvmQyoQ50CoZwrNCa4rj6ptm5+erhNg18XxvRd7zX7H9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519708; c=relaxed/simple;
	bh=vNub+cLQgszPXBpBvwUniL+1eOqFe1O1U+jJOBd/f0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WA0jOCOF7sxU5+8t5I1Cknixv3SOU9j0jIeKLCSjD79VGcNvsmVc2BRfJPYLt676hcmxeKfDK/Ue2cN8MXLkxRib+b19NV0rPuVWRmO1n3CHGTexMcEv5gsYDk5U79j0LWLbt1Xg6b3GjazVEonu9DUt23jVEiYS+LfGKijWIWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oa4D3nEn; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oa4D3nEn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4cbk3BaC0x31lIDQmSYav4+ZD8nMdvHqJRegoO5GnxMIQz5hDldgJqaQMy/DiL51b2/2gjlpobzMWRTksttq91XPONluI7en4wLm2zSieSLkqJbt6yQq44MwIqvaktRBh5hZ1XuAFDkOnAWfgBpjbJfMLcguoczJsWbrM+UB0XeTYkSQz4LHUyKNGfL//ezL3G/FUwqgjjDOEvr840F8jzVXV6rsF+ARY0hHqWn4hh9rXKBSe3MApdUM4UVwK28Zcx/AzcRDwBk+y7/vt8GrgTXLNz2Tw3IlZUwXkSJ7VabJM/9Db+9WtioS+DzlYFp68nrYqYcoFKQN+YOkWsZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChIp35UI6PLWm4JmoIAQlms9MMPRL54P6yVQ8j//RE0=;
 b=v/Yt+WZgtb9MuuDIelsKJlTbGCE+TO/sZI8Qi+7B4OI6LLaCueMkJohCqX74ODVgHdJ5wlaS5Z5QtAf/Hf5dhCpSmY8+7wSvyQQCS5E1NWvf4AIacqRmiQBeogPr4NYusBy7oG/aeIZP9Pq4L686Pnd5QLBK8sSOxIBJdmlmBL6QoqzIwqfAScWe/3CVeXyzdH+W8wd+qQEHTFz7g70/RrJ5yZ2MoGef82tpsOqZJ1bMnoNKBPMCh4X26pJmVjwsAmiqU49ej7yXx3rtX62Nmz3RXIN0j8WUHTNyzkGyGzksvuVMFePpiu9t/ENGoVPSlM/kVK3C+HsawBbKW9ypNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChIp35UI6PLWm4JmoIAQlms9MMPRL54P6yVQ8j//RE0=;
 b=Oa4D3nEnOQbpkiOXZqKhRskVur+Q/3aEHNfev4+t3/GdrxJW0Df3Q2Wo4v+sOsNCAmr0qNaEuTr48qDAWOVsHVTFr+kxi/y5UI3IX+ctwfcLp9cMPjn2U4CBI45owmQkK47LG1VC92Eaz6fkNnH/5gfojXjHqnQ3LHPEJIlk0GCsHt7jUeSQM0FXi9Y3IrMQBSgtEdsA7Ky8WQeX3/fVOy9jzr6+wZzHaZXw/QlsCCBGWr1DBapDNOGqMI1z+6VNaJsz8zgKLd7HJfFCA/tR2lEwvUmxido5LqM1+GshaX90Pe18fczg9KdReW4ep2g6AtJh0RubLdaee/sEz5l8vQ==
Received: from BYAPR02CA0002.namprd02.prod.outlook.com (2603:10b6:a02:ee::15)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Fri, 12 Dec
 2025 06:08:18 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::95) by BYAPR02CA0002.outlook.office365.com
 (2603:10b6:a02:ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Fri,
 12 Dec 2025 06:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 06:08:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:08:06 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:08:06 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 11 Dec 2025 22:08:06 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH V6 1/4] iommu/tegra241-cmdqv: Decouple driver from ACPI
Date: Fri, 12 Dec 2025 06:08:00 +0000
Message-ID: <20251212060803.1712637-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212060803.1712637-1-amhetre@nvidia.com>
References: <20251212060803.1712637-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 332df756-89fd-4a29-8566-08de3944d869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WNo0pNHPE3JAKVdNQ3dcTe94ELGuRJ4kQg/8df5KIoQd6a45Far+wmbxEkOZ?=
 =?us-ascii?Q?WipZJZ//+hl51PcvXfDOqFp1QX1xrUCMd+GOR8IbAJgvYpMQD/9XDWxRS/hz?=
 =?us-ascii?Q?KOOqIYYwmJCoDfUxI2mTEdxALT3CA+Kb3NafTC4SR2iNqZYycNSjl+u5HVPQ?=
 =?us-ascii?Q?F58JT1Z40SRdcqqWP5bltQVoHiNlBJ1Wiv9TvCT6BcF5av4cibV3I5Dm6aR/?=
 =?us-ascii?Q?aOFmttfq7y0j0h+8UZs5aeJLpIppGo8ETuGkXD6USQVgJG9TpRFUTHBmyV0v?=
 =?us-ascii?Q?DiFxwL4EMgPMA2Jwh0DszG8xME1OkwyhChxgquRO3zMWSkRSIew/1LbgEs1a?=
 =?us-ascii?Q?SHK1So1ICAs8+OZClfjzgoXig9RVAQODvbbOuKet7xz54vImy/WbHKwBm+hM?=
 =?us-ascii?Q?059J5/jTAjQxBUWn28b6ce8vBPU2matbRyhrtqeFk7s8/cRGRktBtoiXt5he?=
 =?us-ascii?Q?Y/IwybtV4kGbcX2kyUf4JJD1Fhoi4hrOiFme4957+jpL8P3o34tBt33Mx4p6?=
 =?us-ascii?Q?zistaaN2mG0SxzzhuOMzZ4GBoVTi9t1XX6Loq2arQbbzPFBUnT7pIliSK2n2?=
 =?us-ascii?Q?vp+7u7n0QpzsBSv1VE9eRdbrGUxzU9vqTvn76slKNe4PNa2DukHSNXKNWUUb?=
 =?us-ascii?Q?ZU1NqGXDn6jKyJS0fL9grkQ5uRJJ8whdcLWbWQaUCiyRkBJKaDfawmvERlrY?=
 =?us-ascii?Q?XShUv4p2Vcmcz9xEhmrUNtx9QcgZFelSCBXA38rlwcAiKIk+XxJPdyhXr+pZ?=
 =?us-ascii?Q?VJi6uMfiHDkwRB9FwYmGPH0CfYsg1iVQORRVdxIxSACc0GQ2KNAPkw2IbC3Y?=
 =?us-ascii?Q?j3RK3+TAMhsp9ZO/8OMrtEUvqvBSK7vNaFPRqJO4yH9JQYczL+3LQ+IN6iug?=
 =?us-ascii?Q?GhAKrhg0NhGCbnAu+hdHiPw4ufNeq+kT84gNKsX3Z7WY4qkjbLnAQOoedW53?=
 =?us-ascii?Q?HF21XeGdZv+yFLPoucYt9TDY2AvkFlUJDzgCYRGqZVinSNqIMun5l37ngdLQ?=
 =?us-ascii?Q?36bj6PLu+BgCmSBvAIFxEQ8h+3qZz2adOqwdD9uKFiILEh8iqAYbdyJo5Y7b?=
 =?us-ascii?Q?W2HUWjJYOtNbqCtnpdJSaTC4gmamCYejTRSBBNE3MY0kPLUWSektUluUVGao?=
 =?us-ascii?Q?ou/Bq8YIbItdrM11ep3yPhm/+nHorOwiT1hz/E+p1HBqtRfxg/ZYmwPGHiKG?=
 =?us-ascii?Q?vYzxtQuQBM7SvykrZVu0s9VRMoerg/gdpPg2ilQY5+T+qPQPSg2lmxuKV3gk?=
 =?us-ascii?Q?ivHB9F+ZRW4F7ZvikqfQ/6U38kx5gowVeYFCsbZrNGkvrWitB3B3X4muT+9k?=
 =?us-ascii?Q?iHYI/Y8Js0+hhXQz7yvD4H7z876M3rZaZebN0lxL/XXrJpRc8JEwQ8XaM3pD?=
 =?us-ascii?Q?H0Z++kZ9M1req3+XPg42W/7yXyju6nfvIxjYmrMWh/6miIghLQyaG7iCns2W?=
 =?us-ascii?Q?L1ERTd4X2kfOBMPY+ERFQNsTGtr9gUbkLr17Kod0DaEsIqih9g4d0Ls1m1H0?=
 =?us-ascii?Q?xVHoWiEjFe4yXfm64IMG1SMSaxCIbsdh0zT4jYHzJ3ZQ8eHdUBOayimwQ0N5?=
 =?us-ascii?Q?Nuk8xr5ibDiGhkQqlk0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 06:08:18.4162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 332df756-89fd-4a29-8566-08de3944d869
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825

From: Nicolin Chen <nicolinc@nvidia.com>

A platform device is created by acpi_create_platform_device() per CMDQV's
adev. That means there is no point in going through _CRS of ACPI.

Replace all the ACPI functions with standard platform functions. And drop
all ACPI dependencies. This will make the driver compatible with DT also.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/Kconfig                     |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  2 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 84 +++----------------
 3 files changed, 13 insertions(+), 74 deletions(-)

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
index d16d35c78c06..42de3da54858 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4542,7 +4542,7 @@ static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
 	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
 	if (adev) {
 		/* Tegra241 CMDQV driver is responsible for put_device() */
-		smmu->impl_dev = &adev->dev;
+		smmu->impl_dev = acpi_get_first_physical_node(adev);
 		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
 		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
 			 dev_name(smmu->impl_dev));
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 378104cd395e..1fc03b72beb8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -3,17 +3,15 @@
 
 #define dev_fmt(fmt) "tegra241_cmdqv: " fmt
 
-#include <linux/acpi.h>
 #include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/iopoll.h>
+#include <linux/platform_device.h>
 #include <uapi/linux/iommufd.h>
 
-#include <acpi/acpixf.h>
-
 #include "arm-smmu-v3.h"
 
 /* CMDQV register page base and size defines */
@@ -854,69 +852,6 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 
 /* Probe Functions */
 
-static int tegra241_cmdqv_acpi_is_memory(struct acpi_resource *res, void *data)
-{
-	struct resource_win win;
-
-	return !acpi_dev_resource_address_space(res, &win);
-}
-
-static int tegra241_cmdqv_acpi_get_irqs(struct acpi_resource *ares, void *data)
-{
-	struct resource r;
-	int *irq = data;
-
-	if (*irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r))
-		*irq = r.start;
-	return 1; /* No need to add resource to the list */
-}
-
-static struct resource *
-tegra241_cmdqv_find_acpi_resource(struct device *dev, int *irq)
-{
-	struct acpi_device *adev = to_acpi_device(dev);
-	struct list_head resource_list;
-	struct resource_entry *rentry;
-	struct resource *res = NULL;
-	int ret;
-
-	INIT_LIST_HEAD(&resource_list);
-	ret = acpi_dev_get_resources(adev, &resource_list,
-				     tegra241_cmdqv_acpi_is_memory, NULL);
-	if (ret < 0) {
-		dev_err(dev, "failed to get memory resource: %d\n", ret);
-		return NULL;
-	}
-
-	rentry = list_first_entry_or_null(&resource_list,
-					  struct resource_entry, node);
-	if (!rentry) {
-		dev_err(dev, "failed to get memory resource entry\n");
-		goto free_list;
-	}
-
-	/* Caller must free the res */
-	res = kzalloc(sizeof(*res), GFP_KERNEL);
-	if (!res)
-		goto free_list;
-
-	*res = *rentry->res;
-
-	acpi_dev_free_resource_list(&resource_list);
-
-	INIT_LIST_HEAD(&resource_list);
-
-	if (irq)
-		ret = acpi_dev_get_resources(adev, &resource_list,
-					     tegra241_cmdqv_acpi_get_irqs, irq);
-	if (ret < 0 || !irq || *irq <= 0)
-		dev_warn(dev, "no interrupt. errors will not be reported\n");
-
-free_list:
-	acpi_dev_free_resource_list(&resource_list);
-	return res;
-}
-
 static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 {
 	struct tegra241_cmdqv *cmdqv =
@@ -1042,18 +977,23 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 
 struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 {
+	struct platform_device *pdev = to_platform_device(smmu->impl_dev);
 	struct arm_smmu_device *new_smmu;
-	struct resource *res = NULL;
+	struct resource *res;
 	int irq;
 
-	if (!smmu->dev->of_node)
-		res = tegra241_cmdqv_find_acpi_resource(smmu->impl_dev, &irq);
-	if (!res)
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no memory resource found for CMDQV\n");
 		goto out_fallback;
+	}
 
-	new_smmu = __tegra241_cmdqv_probe(smmu, res, irq);
-	kfree(res);
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq <= 0)
+		dev_warn(&pdev->dev,
+			 "no interrupt. errors will not be reported\n");
 
+	new_smmu = __tegra241_cmdqv_probe(smmu, res, irq);
 	if (new_smmu)
 		return new_smmu;
 
-- 
2.25.1

