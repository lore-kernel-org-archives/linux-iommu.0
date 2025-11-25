Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C323EA87
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055039; cv=fail; b=hQDWgLqUk7yqw6kggpA3I+Hf4eYovs8bkBkKCzyrHgHM/G+AI5lfU3lmN4pDiWGo0dfJF50FoC6u6c5JP7PLB60Dp1mYIN06l8p6d8MvwG9IyPKyCULr3CnB8tGc3iifN04VnbwnTa7m2Uh3x2Iygb+KkrZrIFnCkm528aAR/PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055039; c=relaxed/simple;
	bh=zHJSekCzkw+VGQwRxmBejqiT/60fUUeVQoBoWaL17Zc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUJPDp3tUKtEOiY9G+iKw7rlP2Ky7u5pC0FYHDTjYy86FzjWEOfkQSZXgJMVYROMyFBenl2y3ZidJ2SlLBcN+a2Oy08sKbpICqxo5h+ZvkjyGYZb/9e//U1bjXtowhze4DveDFNWKVNlnf6rrpIW4Km+zBxW6oXy67ZWxMULoVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YAjbmb3W; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YAjbmb3W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPZbxIciTrFnHVUZpdJWhVx9zvoXUe4SF+/jEyvmm2JMsLRLm5eVYlipewt+HbmblSRcKhes57g00JqRfwYoNAhMw4T5oAV8BIHFhMvH5oOxvR0oJSA2cuUOzMSvS6lb6dZHZUBrHH5iLAmhSDayDdLIPYc7203aXN3j66tLGi5ybfJiz76NHuWYshcoAFSXR66rVlDDdCutIH+itzzhae5RyuqwG33ArqvPyxKzw7P3mx4bFc9+JnfWpLRRJ6mYDsMMW2hU5+XvUZcSnp9kMbAfN/UAM83GxNjDGOJNrxI8iie1bh7uduth1qrQvqaopmkcKrHY8p2KhW9yRtNRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2d6eRCM0RhsKUOaUc8U8fCsE7Urog8sRe1Ijhsw7oM=;
 b=ZMetdp3dQddhdDwrHO/2MNri8N/dTbELzcjpk8AviBEg4goLxegSxSpryesijwyhf6JkdLDuOWvIO/1EseVTgzlPbaEYE/dZ7vaedgWNSVoGPv8GDB6kLqpyyFmXtU1/5IWnvLdNOW61SRHPiudHQuL0s4Qh6GBktLpOzsuu1DA44w+AOBPJgfkYmNSRqw2+dlQSoEab/Y/3X4WvMmnkBtvuGHT1JqnKBSZ1/EZYSQlcey7iYUDooD3QsJmIx1+904oMDf8zATfBpt6MYQtqu8ZzEzD/YauwDAwXVpVz9T1OilJPgYccg4jffKv+9EFfrBGYEkAUhq4qglKzA+9+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2d6eRCM0RhsKUOaUc8U8fCsE7Urog8sRe1Ijhsw7oM=;
 b=YAjbmb3WkyXjbZrhj7elpNDQ3GRWfAXILiK3fv5feVXD94rzR8tDc6tHJGoJNm4GeREPEIxnG/gzVv7LWM+DIW7cJt0ewEaui2+Gn1TWlq7vmmq6FDWlR2D+iA+qklg0Cvg4yk2+SHTzp7G4aq9+YhNNz+prCWmd3e9yBgk5V6sv+J2yQnKOo34z8+3o1otu/wzVmGiJHUkC6qQ1VNTC8YbIR9Eg8T/n7FWOHm98T4s49y6oXepqyWy30iqetkZhfJGVDCtBGvTues7aLLxpruGAX99y/LEYSyKE1PVHZ+o+HXyGFxJ9eQIFo5CGx18xwQy+zCVCjmQtv6hTN/KitA==
Received: from BN9PR03CA0596.namprd03.prod.outlook.com (2603:10b6:408:10d::31)
 by SA1PR12MB999085.namprd12.prod.outlook.com (2603:10b6:806:4a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:17:14 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::63) by BN9PR03CA0596.outlook.office365.com
 (2603:10b6:408:10d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 07:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Tue, 25 Nov 2025 07:17:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:17:08 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 23:17:07 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 24 Nov 2025 23:17:07 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V2 1/3] iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
Date: Tue, 25 Nov 2025 07:16:57 +0000
Message-ID: <20251125071659.3048659-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251125071659.3048659-1-amhetre@nvidia.com>
References: <20251125071659.3048659-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SA1PR12MB999085:EE_
X-MS-Office365-Filtering-Correlation-Id: a48a4353-cf7a-4708-8a2f-08de2bf2a878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DbyKbnNTWEak2lkXK9Ng+feD3lYPzLbxF/7rE7tDcdwIHFFYTHWBlLgDFv/T?=
 =?us-ascii?Q?SZWC3UfkJSptUxt2d0/ZvgBRACzh/pTbaoUAlxfUZ+znprdzOAZMkW64vc1u?=
 =?us-ascii?Q?boof0fnL7VBLbTWtFBIH+UKwKH8kZi6mY8SqK4yia0b1JT+NzuOpCdEk5G6M?=
 =?us-ascii?Q?sw2q5RnZ/9ouE5Mu2fLNnQrn3ShIHkeUYVjfqz7mkEP5woPeHS3Gr7ubFl4c?=
 =?us-ascii?Q?yJUCn6z6esg0W/oFBu+0Kk2+XKnES93pAATfhib/zH0vYwRMPuNiUacZIR+A?=
 =?us-ascii?Q?ZUNkWaniarS8XTh5bK+Z8+VjPduwwiPnpyvRh6tZR56SmZooNaDtj3BYNu2X?=
 =?us-ascii?Q?9X5ZvJoTcdlwwIDQbrMqighajQ1QFxenmRluH48y/vONHoa6D8zTvbRAqF/1?=
 =?us-ascii?Q?7tBoA9rDrw38OPrOQjJgYCExkuF5z0SsFbUJv/jFPzfdBJCEPp8OkdMuwvCw?=
 =?us-ascii?Q?XdXHV5kRd5fD5UDIKEFJVjSU80BL02Nerg/nhX+tkdvHIWVgHWClhH9ql44k?=
 =?us-ascii?Q?oi0ySstP5vTNHFh+8dgEOAEV1RlbkCCpOWDZSOSt4IR9QkPj1lrQvVJvYK29?=
 =?us-ascii?Q?aLAroKsUX0rbV8otibwc+UPq0U1XINdrO+eXgx6Eb4iT1xInCJ8dCOXIoZx4?=
 =?us-ascii?Q?gV4lXEeCsc5LW8bqWiS2/kLF46/qcUSwVghzWOE00TAYRDqljgCnhDMZ2/EY?=
 =?us-ascii?Q?evXyvMwtLwTCS9wRqc/YxRmuBGUCPYLIcST742Zz5R5CwCNsvT+rNq/6is4I?=
 =?us-ascii?Q?p3HtgLwyXYe7DSy/P4meO6KsMsaf3JG0b0zyLLZETtKFJuEPGt8nLZhub/u1?=
 =?us-ascii?Q?1qrUK+6Z8i+ZBZ5cMhzo28MbU6+5Nen3MBKQZEE4FHz5UV7plU9QlMoejAKz?=
 =?us-ascii?Q?4jnE1oXBIKLWcAd8908ihcCgeqWNMPlrHeSZUJK61ldqvzhymF+ONqTwSDmf?=
 =?us-ascii?Q?JnSjrx4dBEYWa6Q8lGpDtpjkH3OnU+fsNyRMKFoUj6r7AfJbHN4egIGLieNs?=
 =?us-ascii?Q?c1oRd4OtUlFASNVr7aZqBHNN7+CjkCHpueeja48l8CGqVHErS0TPX94+oF5l?=
 =?us-ascii?Q?7J1Z+o3qubzOhY3jM1IiGEokrwF7bUvT7kIu2wS+VgRu1mjGFl8enwAEFKPt?=
 =?us-ascii?Q?NsnbJpP4U6BjBQcUoSQ6KDZDDWHPJMYjcO2PuSh+vL21OWXo64SXUYLLOYZ/?=
 =?us-ascii?Q?CK6cGD7J0WBSqPtMLPiPc9XDGh5DXrpVqNl85rdBj2I78qSPPd7K+3PeblEi?=
 =?us-ascii?Q?g2IxFCjp6u3PwSiiAkTgn+yEfDpzrzsnuy0QqcTbhFBJhzt0vZak4y6jTeKM?=
 =?us-ascii?Q?ZORmxjArqO5SHbG7z70KvwJhal7NB7+tBcV/VUMcWZK5WFyP8TvQE7Yq4DGb?=
 =?us-ascii?Q?A882BFzoqX8pGifIMgYkZ9r4xzh+GMmGC2QgD+3+0BKLPxCZFxttiSLMcqYY?=
 =?us-ascii?Q?CyeJrCWp/CKbupaR0SGHstAZh2XgEZyNRDQMtgB3o0lf5XkgpqoQFZMU8BNL?=
 =?us-ascii?Q?53BMWLNWOEZQHc2K8bAc1fHaR6EI6QrW/jWHvZ8h/vcWxioKCSi4SFJ8xqXI?=
 =?us-ascii?Q?Qo005IvcyeuOIAl5npI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:17:14.0080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48a4353-cf7a-4708-8a2f-08de2bf2a878
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999085

Add device tree support to the CMDQV driver to enable usage on Tegra264
SoCs. The implementation parses the nvidia,cmdqv phandle from the SMMU
device tree node to associate each SMMU with its corresponding CMDQV
instance.

Update the dependency from Kconfig as the driver now supports both
ACPI and device tree initialization through conditional compilation.

Add nvidia,tegra264-smmu to the arm-smmu-v3 device tree match table to
enable device tree based probing on Nvidia Tegra264 platforms and
restrict CMDQV usage to other vendors.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/Kconfig                     |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 32 ++++++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 43 ++++++++++++++++++-
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index ef42bbe07dbe..168ada9c3d68 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -121,7 +121,7 @@ config ARM_SMMU_V3_KUNIT_TEST
 
 config TEGRA241_CMDQV
 	bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
-	depends on ACPI
+	depends on OF || ACPI
 	help
 	  Support for NVIDIA CMDQ-Virtualization extension for ARM SMMUv3. The
 	  CMDQ-V extension is similar to v3.3 ECMDQ for multi command queues
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a33fbd12a0dd..2eec7cd4f3de 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4530,6 +4530,34 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
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
@@ -4634,6 +4662,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
+	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
+		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+
 	return ret;
 }
 
@@ -4867,6 +4898,7 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
+	{ .compatible = "nvidia,tegra264-smmu", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
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

