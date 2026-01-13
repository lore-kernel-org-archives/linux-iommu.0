Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68D3644CC
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768283403; cv=fail; b=K3UWMTvK07CkzEvNYpE426P2rUqOwiQoyTxG1cm3x5Op9gYQMnhU3xYHUd53PiRea+6rkN1iscXoodoNpOikImZx+Q4SOlyfQRcXFwmh+BLTbapqy339e3CJlkf4DrL/evG2SfqDNtcYFdbFGU65hN78AT1BhaDI5X1XNhSimRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768283403; c=relaxed/simple;
	bh=KBBx6NrJJTDAR8d8mDr78ZMCvONT4K2zuXzKFlb+0RE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmNFiDW09sSWRBrnukdAPBzchiCjC1jEZBnVqZ8k1cRXTRESn+X3Fe8Re3LciEna8bF1DLGQOA7XBAhk3rXCf3qft0fFK2RHE7HhoYUuWY6SiZsZYOU2s8VNhfrbCMU2vLmsHn4vIWiIehSB6XyFYeJ0p8Z0erO/HMr8K10Unos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ha11SIMW; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ha11SIMW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGW9woOiRiNG2dxWhVqQPfQku3eKB78xtP5argZSe8USsD9w1A5HA+fyq14JurwtNfu+dIz0+3t3ev5ga50VlCcHa5Xd952sr3HgYJzhAuUyqp4X6LjdGq1IZ7v/wqZ1DlbGa3l9kKNrpFZpOExXDQLI9BopYWC455hKYJ+A4DY9WFsrKiDQbO2YINTioEKuomEe8uUuQBkTnNnTwqVJO1eMw1FMzRk97sTAsdebUuVhGWwonD4lo+IfZkyaEDUcmtDhz+RcERkLsZHMYgeFl2CGN3aPRFdNkR1KH/OuVqfzbBwldX+/YOK4bpIe6CBvOelbYqloGgWiFev2RHipUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywOt0d7YpGetiDH4CuJANyaIqsqbOy+k3tNRHggLIYQ=;
 b=ZgiR1pMVJHy+ll9aMG4WMi6L0R7lfpBZTAkdpjXjjkgCKbzMDxnHz/vrv8VET3mZrfL3aIbukYolyMrM5f7Zn1uhu/ptVOHTK1R3Pp41BjKEr+GLVqxATJPnCr45Vyv2/pO2RgjeCT7jML8R5BdjvOBSmn7zBpk3p+A3TMaLYIN6scmGYC5KY/R4+tGhvwXhr3RrJ+ayfwjl6CnccZq5De0NwoA4cWZmyH+pk3SdD24HOJ5/YuVYdaP4TfMmUsu2MSIVylKrQNep0BEPlmPgKNj8nS7XH3QMREqprEvpRnztFN+MxOs+XvepQNTQzcYPme8ZN0AgAaOhYrYcUzFr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywOt0d7YpGetiDH4CuJANyaIqsqbOy+k3tNRHggLIYQ=;
 b=Ha11SIMWkUCmeox8q10AlVJzGZYLtYilJZfb9ACxWnD8Z+dVa7TanL5+Y4ltO88Tz2M2ur+Snp13Hnbxd+TNEQzT6S71WVf7MidzUP6oNbM5FZuPU+fXH/dyJN2JEAESOdqX4jWx72kDViaZr/8UZaVus+e3FaZsuelNtGDzNhEyheJ8LMfAKxqwyiRgNfIztKpomgI2t8Ofgqc/Oeex5J60e3sCBKESLE87G0qtH7StvWBV3/2Z+MuVAuqhQMuEPVeJzGBgavejYNr+wH5emOoDBU83TCI5IMqycQVv5mnnw7uunUrCX/LTBt4+L7LPqJ9GRr8C7YqbOA6ngdBKxA==
Received: from BL1PR13CA0004.namprd13.prod.outlook.com (2603:10b6:208:256::9)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 05:49:56 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::c4) by BL1PR13CA0004.outlook.office365.com
 (2603:10b6:208:256::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 05:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 13 Jan 2026 05:49:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 21:49:39 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 12 Jan 2026 21:49:38 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 12 Jan 2026 21:49:38 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH V8 1/4] iommu/tegra241-cmdqv: Decouple driver from ACPI
Date: Tue, 13 Jan 2026 05:49:32 +0000
Message-ID: <20260113054935.1945785-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260113054935.1945785-1-amhetre@nvidia.com>
References: <20260113054935.1945785-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: a4399d49-06ea-4224-7c5a-08de526794b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9vxKx5yW2EY9oaTeOAGwDSZQcLM5draXF64V1MSS8PyulheNN9S/z54TdhEE?=
 =?us-ascii?Q?iVYqRWyDMe963rZC1a1TMSIB0BkagwUqrMGflHuElr2xd/cH+T9guEkcJ7Fd?=
 =?us-ascii?Q?NXtd0JnVDfURjzF/8bLgobxJgznO5jHIcDCMdreMOK2wMquaNSzTtYyipt5R?=
 =?us-ascii?Q?tHUa4uZLZVSAUtgagm/6MP0DX1svQSRgxsoKQBXejo0CIxDJEZV+kRjGuoBL?=
 =?us-ascii?Q?mks8cyL8NBqZqkC0SIFmg9dssidROli0uGT+Mq9Egwg5zyEiOYRS3MhzL+Tz?=
 =?us-ascii?Q?+6csjzueTnTCXeuXruPuj0KhTrdIcRDQJX6E7eGKKV4vZjPZngZS4dR2eMeP?=
 =?us-ascii?Q?iy7DuzISm6H3FUnWKwgsfpn959x1ZEpn1A+GkwGWpk768FhjJmmMz1JI9Cyu?=
 =?us-ascii?Q?WDL+qAGt0x7rbO/C5SMk7/NfNmAdXIFzvfCPJ49U54Cf0yk3wHK9KTp5lCER?=
 =?us-ascii?Q?k/ww0dUQ+Ioe53Z6mcGuWqWtwAP6/x9Kp+SfmQnRyhUYcEhKzY5DffoSOXez?=
 =?us-ascii?Q?pKk8iTklxZ/Ja7YPg3jPFk0XYzZVbKe7Yk89hbPYn1JJ47pfS83IjCdY3LDe?=
 =?us-ascii?Q?s/MiqNc+GK7YXU7s0RZreY3YPdYobqu+Frc7yndENaUNbNwKsEEc41EBpanG?=
 =?us-ascii?Q?wggNd8NW49HPRr1UL2zrxA+8n6r5rUwUYVse5T1hs24ZmXdwA8rVY9R8usbg?=
 =?us-ascii?Q?/pZUpHBrvlW58ctIA+/3ew80AsgM1Dut3C5Ilbw6d4Hgos1yqML5ynWHvkvW?=
 =?us-ascii?Q?fF5Tig4Wrhf7LAvEl7Zav3qA8m1LG8lT0AsHVwDOnU07kpU8N0XGj3uqclVN?=
 =?us-ascii?Q?/4wpnuVUqgDncGX37gz0n/ulZFhYFONXuEgkAUeK7UDd8j79OLwbcajEajHb?=
 =?us-ascii?Q?Y5olF2GVu/1uiurhyGe9No6T/k3Kp9rxrGX3ebaTBuebxcDtvEz3z6Ht1Vgw?=
 =?us-ascii?Q?kD3jMxH/Oz/SfBshi+WLWoHjFjFH5Y1KmJIsFgOM3P4SCiQuZHAYA7HoXycy?=
 =?us-ascii?Q?i2i8ZHJVrt3a0Qnia9N1UhKTt/Q0ibWw7G1Iki6llAuISlKkH8QtODSQOxCd?=
 =?us-ascii?Q?SWMg8w9TNOYEIVd/FIMfYabYsQon2HJGFJTW30eTvt+Jo7eu+koK/bvgCB6N?=
 =?us-ascii?Q?ZETPeZVCHMJSiYzgW7w7zAIUyWVktGN65QkNr7QWu2zKLX4kdimnaAoTpDGc?=
 =?us-ascii?Q?XlHlX4IasDEY/BivP8Pd6Og9X2l7fNRkUngsxNtx5digUZyNB+9IoefP49ji?=
 =?us-ascii?Q?WuO+QO6sqngouYRpJB9tYUfPN4a/EFIyiQooJ726AtXKJm+cdorFWpp57DPG?=
 =?us-ascii?Q?QaMhL18Su7SSe/b05EtS8S8SiACbfkL1bmEfSQ/vy9vNi8dXEIjVWy9fWdDI?=
 =?us-ascii?Q?6GKxJbgWdWjKTi/o7VwITcck6Oe0880otvElhrQoDGRGgPNSgAz7w+w5raEF?=
 =?us-ascii?Q?Ei9JE1m3CX4fvvSGNiC3rzkvQBt72onD6Ji9maiVgsqvuwDj5QA/DTnh/aro?=
 =?us-ascii?Q?+KbtR0Y/t5pGCQcGdmrufssJlm+htLjDhCbssH/PgoaeFSQzwFYjLvaVlFXB?=
 =?us-ascii?Q?ootJd91mWJ7JLd5J0ss=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:49:56.1445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4399d49-06ea-4224-7c5a-08de526794b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568

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

