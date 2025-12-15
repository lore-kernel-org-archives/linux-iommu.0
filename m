Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28594279DC2
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765781326; cv=fail; b=Seh3Vq85F0ZLEmepKnpEjFM4rUPywckVtRStf2oW0JKP2HAB/ARqEJ1tMhHV24EPnaFeIz7xP0fwY8l1X58CkWosRTG99GiGKg2x6XY9yDTtUQbGxvcRm4R2pi0UuBr0FCnI78Fd3cLXno/fj5qQsh4rLY/RWCPJQp2n2i66zfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765781326; c=relaxed/simple;
	bh=KBBx6NrJJTDAR8d8mDr78ZMCvONT4K2zuXzKFlb+0RE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfIF/T0r76SthsaErUk98/bT/jXeH6lIX27tJtAcyoenVvsw5rON8D2KkbtDssLoXJw7bAasrN42YUcWeA33/yBfDo9XNDaZP1Tey3o+YSlzZ7UcYGWkRdi2WJBveFJaBv/KadlgkciT8bo181QIkT6bqUsieUeOaJvi6ZYR7Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hmfHBqXq; arc=fail smtp.client-ip=52.101.62.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hmfHBqXq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVfdP1eYkPowUAXlec5rV9Rh1l9R5gXToqdwbM7dWrnCEdsvTmZYXod5ShQvovxotLs3WiuvuxbBRvIZFqKxF43oomLDvpUH4hqYEtw/jOKe/VTqla0MiuQ/3MF6IGyN6SMPWXoG1CO2QdLecuQahVXBSokMAp01Wr2b+AFZS0715dOAxceITRpK0Qx4aeyycVFXarVQvWSj+V+Vnr6wzjLyFFniADPXhoPJYwsCH7VrYTiPMtNieLahYc3vjjsr8K7/rW6cuCSd/armnwqalZVVY4HPAuMY+n+8uYM9HdjROdYyxRl+1R8qZnLgZZ3PaUKUUjLHzzjlBpcAXEkitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywOt0d7YpGetiDH4CuJANyaIqsqbOy+k3tNRHggLIYQ=;
 b=Rjn2qEUx3NMHb4X8Pz3z2fio33Cldkz4XUhxIp9rfNHNi2/QtW86h/CLwMsrJfan0qlcm1aaZ1awWg/87M+dSh2c11RGPNQHuPhA3AHTWi1Pq9UYksa7K0tBK/a4OujxZcLPqZB16sHTwJp1Xg3Bd2hZZO7et55ZHdADoTo5wkv9MZwIhIutt6FnXRD1azp7I7J5kcIjHBPB20ugpg+dNeklK2pKrgR7F5WR3+6I7gXqY4G0hpngfVZkUcHeRv+PD9mDxo+lBrtwrKGM6cnz/RZeRNLupFsJgR9y5xKE5h32xvOeWCV7PJRF1ZjK7hKulq/jZTQRt1x2V86VxBri2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywOt0d7YpGetiDH4CuJANyaIqsqbOy+k3tNRHggLIYQ=;
 b=hmfHBqXqQwu32Ma1Rm2eK9S3p40AJNR9D+WjD4Tr0vnuslaR2QAhitvRoMCjWGe8Nc3KeRtWfGraffMDKm3qgbsaauwXBsO/Ii3W9rPFGATZ7M6/onAJmAqJrNYQpHBBUB9/62LXNHUV+bFowTcmSWI8qCjJNXgkD9tWIv+VqCSqT80zfxkUxf8H3XERNHq0n3SyGLr7Lb3Gtip3ctG2EZxIi9o5F5mZt9hWVL1HgcgAOk7wZ3cyhAAqohmQyjRGqwTkL8wuFYsSKQJzbOCORvOpnMl7tHKp081OurWcRhWGfANn3acf1ul+uaP3TTd9CcAhWaacp9oF+dhBV/q1sg==
Received: from CH0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:610:74::30)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 06:48:41 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:74:cafe::31) by CH0PR04CA0085.outlook.office365.com
 (2603:10b6:610:74::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 06:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Mon, 15 Dec 2025 06:48:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Dec
 2025 22:48:24 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Dec
 2025 22:48:23 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Sun, 14 Dec 2025 22:48:22 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH V7 1/4] iommu/tegra241-cmdqv: Decouple driver from ACPI
Date: Mon, 15 Dec 2025 06:48:16 +0000
Message-ID: <20251215064819.3345361-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251215064819.3345361-1-amhetre@nvidia.com>
References: <20251215064819.3345361-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: d9651405-2593-47de-a7a6-08de3ba5fadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LYzYlZ3oJH6ggzyuQyBgL5laQmkxHVcStD6ciLf88gMn0TOJI5TLB0P47D0j?=
 =?us-ascii?Q?FCphtoQic8dOLlT2a/FiXgFUdJFlZznG61V6JTWElB5OALKJSegre5Fml092?=
 =?us-ascii?Q?47pp/W/n5sU2gQoqjWXXPvDSGH4t3fxD9JCVrWEGoDzkZOstohero/QCSayH?=
 =?us-ascii?Q?eiQ2n7muXrGIyY8K2ALcm9UdflbTN5w4hmY9X0KhhRVPkBmJW6gF6SYNFXNs?=
 =?us-ascii?Q?9yKx+C1xQwWIRgzc+wGM2Rb+CthOXV8bwoJOlaKCX+yIWjWKeVjsM0/Z4qxV?=
 =?us-ascii?Q?O19zygwGpMtnxhfnDveVMhur3K0TTp1SzDcakkIG7bxIpVjrQk4cDkYaWNL/?=
 =?us-ascii?Q?9fMVoMgH88433I5vxISbXa1Tm7LA05ytWavIx0b2W3FCdgsRI3nDNWO16YVM?=
 =?us-ascii?Q?AYxCJeMbX7ubbJlMQGurrEa+P3+ywnmwRTaDwcS/roSEtgAcUGo4T56RgLIu?=
 =?us-ascii?Q?S5+LpxmNErCQ3sDqPjj67cG/RUraw3l+0Uc6iq/8T87kN+af0Fhmh0zEsDE0?=
 =?us-ascii?Q?c7at1K/FakhctH4ShKG9XzSU0t1SxwlxJlkGYer0B+B9C7+nVWEZUKSQJP2r?=
 =?us-ascii?Q?+8hy884gP4wUdfGhfTm37QAQTg2dI8c9XbHMI3BuNa4hroro9V+PR6Gw3DQ4?=
 =?us-ascii?Q?A2AzUq1DZJWV72/oc5JpLonavGujbSNzCa+EePEGAj5D2xzgGST3OmMqvaca?=
 =?us-ascii?Q?Z+jdPuZ+YkH4jM5FTtXpNBX/du28iiXSQMhjcaZhP4jFGGiYkKUj52mF8TRf?=
 =?us-ascii?Q?tKDNeJejx+PlgmrWjXrcaTR5/LKuyZUyYssJwGHVGMz8Te+KGLyB+CWQPNaF?=
 =?us-ascii?Q?bUFhTxDfTJkod7nedvjNhj1qpL9DajPqJQZRAZfv5eTD9spk9JQmpCW22oOT?=
 =?us-ascii?Q?f6Wq1pUVbngX7hn42onI6TlqTzvSr7flIZ9HaQS2YH5nrZPIdDVlxsRzMf5u?=
 =?us-ascii?Q?wTvjTIKlQ9af+Z9/ne23KiQmLfc3MrEDwxsz3K9BIwMGdVT3UHuMKxjGY4th?=
 =?us-ascii?Q?D28qfx8n7haarw/AEWs2hD+bpfPB5v7HEIvaaUJjroXeXcf2BQBi45azT1O+?=
 =?us-ascii?Q?SyVeco8mQSh1z405rfeaDa45zLcIh2WcGMmLLbvtXsgoI/uNHJgqguBntclX?=
 =?us-ascii?Q?grt/gszdBWP767+hHf+DGeS6wFkv0DyWQwnlqXXza2ggaX8IX04Fw2LuB+yg?=
 =?us-ascii?Q?KN0rTcY12XRPNPJpU2Xdx9U9Xdkk0Djp1PTZ72+I+dY3Wxvi6TMhAJ+6jJTP?=
 =?us-ascii?Q?30KetrDaJcH7FdAN1aDEg4tefxYFiM8wQlBfYrkVPXsIQ81QbEPzGs33ngfA?=
 =?us-ascii?Q?AgfCZv775TgrZgs+wGDVbu9+XPXiwUrpO8n0aM/QQtYJ+udLKU3u2AYu2jWE?=
 =?us-ascii?Q?89rKYDEoNRhF7Tq9HO7WBJ77vKAdg9vRAZAJovBL4qQfb+VCSAp+E6X572TB?=
 =?us-ascii?Q?xsy2rqv+bxvfQB1gAos83xFn18zmXWbAi9xLrg8N+nJXFcUdk+q5M0tgtrSv?=
 =?us-ascii?Q?6O5fSwupCtQlwQixL1043Xtc3IPENDK2T5hQBRrjoAdqi4kS2x9S8p7ITbos?=
 =?us-ascii?Q?dCOrdd1Uu97volg7tkk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 06:48:39.6509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9651405-2593-47de-a7a6-08de3ba5fadf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014

From: Nicolin Chen <nicolinc@nvidia.com>

A platform device is created by acpi_create_platform_device() per CMDQV's
adev. That means there is no point in going through _CRS of ACPI.

Replace all the ACPI functions with standard platform functions. And drop
all ACPI dependencies. This will make the driver compatible with DT also.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/Kconfig                     |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 84 +++----------------
 3 files changed, 14 insertions(+), 74 deletions(-)

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
index d16d35c78c06..dad3c0cb800b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4542,10 +4542,11 @@ static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
 	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
 	if (adev) {
 		/* Tegra241 CMDQV driver is responsible for put_device() */
-		smmu->impl_dev = &adev->dev;
+		smmu->impl_dev = get_device(acpi_get_first_physical_node(adev));
 		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
 		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
 			 dev_name(smmu->impl_dev));
+		acpi_dev_put(adev);
 	}
 	kfree(uid);
 }
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

