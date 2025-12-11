Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A924B173;
	Thu, 11 Dec 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765433377; cv=fail; b=t2tk475EH/o5auPpT1ZTPU5FstbohaXW+zCxsDegGSMA1BKWbdoWCWg/e90q5nnEoq3vYUpJ3j30I1gMW9TgTzt0E6jN2DVUMjEX9VEscofhw6woFUMxCjcA5HoBDvNW1HIofde9fzH+uWBkP3J5HbnDD2yf3Ce0Kwl5BqNFPHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765433377; c=relaxed/simple;
	bh=5EVFUUS0qb9wgei8Ng6AAtzfzq/g3vIB3kvRWgPWEvw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRXKHj05ZQ7FtK19b5eIwc0cQcm8Dd6m2bDv+eMyJz4xy/Ixk1LlBzrRkzgGLwXOeYZ/d5CTHFDqwWDb+upcgmywVybGATdXDcfZFDPCox+MDJ/btv8TjidSNfup3Ts9Uy26U69X7dBy1W4BSaLobfdRYNYk0Qm473CVcEIfyzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fyTHI1V3; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fyTHI1V3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqcsSAzfgPve6CetbKpVxg1+gQioUJLOj6T6qgrOb2fn43UfnT6G4R6gH4jgVDe1HIXdgitNIMvnOQKhw8xltPiCycWqw22yJpdBLWdy5OAHuGDgrTFPXS6XIub3AxULD5obtb6ow2kRK1VBko2XjPRPMpFZMOPqUw7N/aEs90L2p12ZWv5tW3dFI5cUSKx9yy+/eDW31TDvu77dk9bahfjPW1yjQ2VuozpXORy6gFb3hCvrzoN6HFmyrgtEL/YUKALfOaRIQQScvQkHs9T0/LacvwM6pvTWclwaitfh4TsfenMzAyhXZ+Dtt6MuEIevAOEBBQhxaX8kuLRjIriGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZuV8+EjHAsb9UfjPhO1rkXiZbx2xlxeI8ewygNbw7o=;
 b=MUD/XEolpbPuFEKDQAQia1A9DEsJdu5OvwIGYbLMLFK+cPNwCsGFBCgShZPXPVE1Sz+Uy960d9d6u6JNjPkqtF1rvN4D21K+fFIm+KW4bOySo3u1Zcm4jBz0cnpbE1NFzUreV01YgrZ+2TJgJdbXskagV63RwgOc819alYLN/3nR3w4+amnSyaPCibb/ZgVYkGFnSPHZWQ8WCoEpR9xfMa0av0RWWB1/qePLe/Z/Zn7VxAMgB/XDCJZOzkGXbEcV0wMiQm64q5nItV8O19KRBLYUb6Wjdyfqk1jauTWuuEDepVAlWos6nkuGahNyr3RokJAe0ovcp8hvXHCkGaudkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZuV8+EjHAsb9UfjPhO1rkXiZbx2xlxeI8ewygNbw7o=;
 b=fyTHI1V3aqa3shi9EeqP2jC1Q2PYsM6F3ndYXsou24mBaCx8wp66tv+xoerC0BlTrHvP6q6hlmIePK/62IBu4cn8O2UPy86k9U/Z9t2qSUeFklo8UEtvmx7lpClPx24/c/eQPP+s7o1flCxUIGlMvTo3TvkVsvshYGcWx8iycEn2cXrcjpco28trKS69g44o7dW1KrH7cIYOUOBeLxL8zEDhxv0cltxjpN4PuoHuZV6Q6jrxER6KFXrIIn/ChWsCk5gbmtj59O1DQnWVZ4rH+S8mw7c53vAR1rxEH89ZQkGrzsKe21lZ8WrJ+MI+sWYzK5ILg3cdtcwjUYp2lhBA8g==
Received: from DM6PR17CA0023.namprd17.prod.outlook.com (2603:10b6:5:1b3::36)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 06:09:28 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::76) by DM6PR17CA0023.outlook.office365.com
 (2603:10b6:5:1b3::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Thu,
 11 Dec 2025 06:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 06:09:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 22:09:12 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 22:09:11 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 22:09:08 -0800
Date: Wed, 10 Dec 2025 22:09:05 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, Ashish Mhetre <amhetre@nvidia.com>
CC: <oe-kbuild-all@lists.linux.dev>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <vdumpa@nvidia.com>, <jgg@ziepe.ca>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <joro@8bytes.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, kernel test robot
	<lkp@intel.com>, <will@kernel.org>
Subject: Re: [PATCH V4 1/3] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
Message-ID: <aTpgAU6FjinhclQH@nvidia.com>
References: <20251205065850.3841834-2-amhetre@nvidia.com>
 <202512090331.QAFgb6vQ-lkp@intel.com>
 <2bf7bb25-9a6b-42d5-b095-978f7bb81f35@nvidia.com>
 <e7c69e9c-6af4-468a-88ed-fb8829afb92e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e7c69e9c-6af4-468a-88ed-fb8829afb92e@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fcf275-8698-4646-ec6e-08de387bd785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xyNu8To4a3Ytma2S2DQIDJtKp2TQrzydPsMjPt6ZhUbVDhN0i3dFzlqHYiIs?=
 =?us-ascii?Q?wUIUVzA/2V+ztB/483RMMflqdpYWI7RJsJkSGP00nGGgV3qxFerViqfb/og3?=
 =?us-ascii?Q?ODdMjxlADUGwYiWGJj+Fx+KrvhePMXqEIQsZC1PCK2UszrNIas1s1VBi4eMz?=
 =?us-ascii?Q?KvaZV6CyjEYpxu/jA/0GjVmDU4wF9sbzTayfnBjvJ/xyk7iCNQ3F9Wwd8jpT?=
 =?us-ascii?Q?5Na30+MfdtjjsbDx91TfI1mHF3zBMoveBuilTJe/SL8dNueIeSxMo8c4Ojdr?=
 =?us-ascii?Q?I4wXBr+05tzSVD5pbyk57iZK3/fNG5OxMApDiBhPwKu2fJBjHqHW5C76SqBa?=
 =?us-ascii?Q?ZiyRRaKLvoQmUY/iXVZeL0bogMB4wkG4tApIUwLlCLNi+FavKawWKLn/pAyd?=
 =?us-ascii?Q?TFK9uYCphGhi0XMpVS+74FSNyCV+yFT2AIuEBow+JcxIb4B8mWaDFzHKhdJg?=
 =?us-ascii?Q?jkSnSc3ZBGJeWJEfwJlV80FA5x1GPPBSvZ6xeJFhoSX6JBNjAyK+nkDdBx26?=
 =?us-ascii?Q?2ZS5ne8OK7d8Thij0KeUDGoj4IeuzSqvH6UB3TeWPFGk9p0QFMYzbpQQ23fq?=
 =?us-ascii?Q?MgnEyQcAXsi6ipAbiPqW8x+7lqhGwncdGUAuOKmnHbc04q2ldQpF0j8kFmQP?=
 =?us-ascii?Q?3BUlNuUH7/DcnG80YmJ9ervNi6eqQ3mp11r0R1MsFXIlghOF5AmMYRlHfCcY?=
 =?us-ascii?Q?gCz/IwuAXm6KnVnNK/OtM4EGmxWwxHMr/ifpa1Ztywnu3onjG0WuzQCS2B/8?=
 =?us-ascii?Q?wB6eXCYr46oa47PiSjUwtbT+1dCMfFK0VHAH2lY9cYA7I0FGAmOjeRBca3/w?=
 =?us-ascii?Q?DJ1flJAxiD8AV+/4EQ9ZjZRtpmSQnNnciAWzBvgRyUQIZgBFVTPsBHoA/p2X?=
 =?us-ascii?Q?KiUejN2hHExqqaZ7+LrB2lzRfio6TBuRIivvdhqcB1WsgUv74RzJayTpJD87?=
 =?us-ascii?Q?cQo8oaf9yiaHPe0HB1rVQJa+Rwf0coVxA2NiXeZfwsi4M73gkjzjbvC1DpoX?=
 =?us-ascii?Q?8SYE5APMpYp0FvhrybSH3W9zxejqfovhR1pe5yZvjwExx7U6AnscU32nWO8H?=
 =?us-ascii?Q?zDi+O0gNW6uv1xaEOsnTrPYpFENRwTuyuyR/2O6SUedzUC6I9DoqaiRiF63t?=
 =?us-ascii?Q?VD/LQZDFox6qJlJGC9Tzp8XH3VImFvbOdwfk3HG8w29CuDOCGv5Xmb0ajUcs?=
 =?us-ascii?Q?KSO9HybCLs/h4tSMVPxmqrMYQALLvW7PNK5J1m/DpRIVMCBn3z4Jf9i175SV?=
 =?us-ascii?Q?/nuFtHwI+0Ke8i2dD9jFTWPWB2prWw6iR5AATt3AbcDu/uOQBytEnSpTtj0y?=
 =?us-ascii?Q?N3hzVbT3KC7QhDXXI6vK1YqFT0IRZ0tCysGIeYtT1J3pkYGzpdC55nl1D+JA?=
 =?us-ascii?Q?s0uhICnlEXwauyKGUVnYzGroBqBOC3YVAi5uY1dDcUXUbl7PmPwYhBYgTcah?=
 =?us-ascii?Q?myRSuq3cmHkfyfMkLk1D+lbAc49DpbwESxlCvDPV93VIQ9XJAuwJaV0FN4Uk?=
 =?us-ascii?Q?cJrk+GE+rzAlsKIADj0fNSMD7o+mlGvk7HazJuGVx/sDie7K9B3E4yXNjhjZ?=
 =?us-ascii?Q?gNeD9EPNHtZdPj8VGgE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:09:27.9764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fcf275-8698-4646-ec6e-08de387bd785
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194

On Wed, Dec 10, 2025 at 12:39:49PM +0000, Robin Murphy wrote:
> On 2025-12-10 5:19 am, Ashish Mhetre wrote:
> [...]
> > Hi Robin, Nic,
> > We removed ACPI dependency in Kconfig but driver still depends
> > on ACPI for these functions. I will be protecting ACPIspecific
> > tegra241-cmdqv code under CONFIG_ACPI similar to what is done
> > in arm-smmu-v3 driver. Is this the correct thing to do or do you
> > have any other suggestions?
> 
> Yes, when I commented that "depends on ACPI || OF" was functionally the same
> as just removing "depends on ACPI", I didn't mean to suggest that wasn't
> necessarily a genuine dependency still.
> 
> I guess if you can wrap the ACPI-specific functions in a single #ifdef block
> that's reasonable, however I do now wonder whether things couldn't be
> factored out a bit more - if it's a standard DSDT/SSDT namespace device,
> shouldn't there also be a corresponding platform device created for it,
> which we could look up instead of delving directly into the _CRS of the ACPI
> node itself? (not sure off-hand if there's a straightforward inverse of
> ACPI_COMPANION()...)

Ah, I did a quick tracer at acpi_create_platform_device(). And I
do see platform devices being created. So, we could have made it
ACPI-independent from the beginning, as you expected :)

Ashish, let's attach the following patch in your series:

From 7b69a638276e66b16b923b0ce1743d3efc85a04c Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Thu, 11 Dec 2025 05:47:05 +0000
Subject: [PATCH] iommu/tegra241-cmdqv: Decouple driver from ACPI

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
index ef42bbe07dbef..5fac08b89deea 100644
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
index 38028e4a52f7f..0c98be3135c63 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5280,7 +5280,7 @@ static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
 	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
 	if (adev) {
 		/* Tegra241 CMDQV driver is responsible for put_device() */
-		smmu->impl_dev = &adev->dev;
+		smmu->impl_dev = acpi_get_first_physical_node(adev);
 		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
 		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
 			 dev_name(smmu->impl_dev));
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 378104cd395e5..1fc03b72beb88 100644
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
2.43.0
