Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E32F7ADE
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917950; cv=fail; b=m7dGcCQIpjvGGwiotqdOiJscGx835IT0PTQXdsraNoyNd82ZJz2P3Ushk33JCbN12WbXMRCU3YtQVIuheR2iQhP/WGV8xpE6jObOHh0JoLY3K9Dg0OP3mUaBQmAzeE/N4IwCseC3vXLTiz/6Wfrt2uPOiW+FOWCLTgUGFHP5F1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917950; c=relaxed/simple;
	bh=jk/sO2crgs6DHwQZcwac2gdYcxARmmwgQ7I0bmBnPkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lo/4iqEmUTxOw6WSkoTE4iIfr63anK2bciCNbv59aJvJdnRzW3q8fCo/6819+j4b144gsmAYAWEmap+xK0w87hxZGNVLJQlfIx07rfGnEfGV4Qn2Jsde+vHgHYqbr1eBY23sqnz8ckTDTD/tmFaYnBsu5VrvtDW0sIOjBH9qQ2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TmpM1Bno reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TmpM1Bno"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naeQWIg92QLy1HwPzlck9PgZxlMBSGWyRXdYGahiqHU4+lZ5XY+hz3XXx2Na6VMmEEo278enAZ+4km9UfAGkrzU6eA37REtwy+dzrjWqg2YRPkbc0BcLkVZz7FVBvKAJl7vdWq0epa0M5EPi4OLj3NsWe8hIQ8YRLPvHIUZ2AavofN9tX8Sfk3/hJ7E7zs8jZ8TSmcOLN8A4L/kT3h0HUDJeSoSYKdhWkf2XCZGHF8zxbUzZtvGa3yoVLBtzmjMxVD8r2yXfg8QysvIHf+n4ibMZZtbEYF5e4H3HpvN4fNwCnhWmK9ZscVTadpTYrZFEurpvoyyxf2YejW8t5ecVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f5qrg5xQ2Dg1lL6/iHiC1nrYftRzYMA0obosXtp3hs=;
 b=RsyAelPOp9i4f0Ws8iHV18ykEYd4VAkUx6yjwl4RXQNwQqJ4y3AtcpDUjZeDMC7/SiGiXNfmJuvKS+SodtpA6ajrQct/jmNOHqUXoL64hFXtEeBf2B0dT+wI4rOp3D0/JmNpibnQ/5Kh/ZMqBkmFIKIy2auB2GyMhv42b+AE3M29/VNP5fIp4Hx1Wjw1/Akag2MpBPqSbBIm36QQ4POPTYmgVT1Ko5Ka4Ug4vcHBCZyK8rCJQ4P0+uttwfY1MrVfPTgJ4DE7f/8csgZghLyswKS3055oZ6xTiCc9x68dFWnu/kbiUygseZfqovnJbI1klFPj1IFT7d9AdZH1fJK1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f5qrg5xQ2Dg1lL6/iHiC1nrYftRzYMA0obosXtp3hs=;
 b=TmpM1Bno5qfulRGlzfGiwLezumjJss1RPOzREwTQ5EkjnwyR8r7bQVoKZvZBweDo4XvoFDIzCFi0Z58n4FkpM68Tr2czDT9eGEvzSEQlvkV4JtWLj7Fps/kMa5NPnKHmxLFxrIQpYJ03Ms5aUgupKt97Zz2JalbKHw3Iz9MDQg5qKdZucJGtnTCsHgSPky0AangzhA/Ag5R4hH85IlTfqfDawYZuh7AtKa9FkKiXZj9RX2TvFVKV0N/25dEBMe4fOQt75kjK6S/KqeS/9cRD9/plQzfLvYQ33262lBHUI0GQdeS7RtmyVzEzv9nSlUv13KkJ02ah8LYeVMY5ZPhIPA==
Received: from DS7PR03CA0178.namprd03.prod.outlook.com (2603:10b6:5:3b2::33)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 06:59:02 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::99) by DS7PR03CA0178.outlook.office365.com
 (2603:10b6:5:3b2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 06:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 06:59:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 22:58:56 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 22:58:55 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 4 Dec 2025 22:58:55 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V4 1/3] iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
Date: Fri, 5 Dec 2025 06:58:48 +0000
Message-ID: <20251205065850.3841834-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251205065850.3841834-1-amhetre@nvidia.com>
References: <20251205065850.3841834-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: c68969c2-1e99-41cf-2e83-08de33cbc601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZdXyxupdHKZ7UUc4uDxcN3KdqI0QRE/KrXM5MsMZoPSihACWDgqrdPVmhjs2?=
 =?us-ascii?Q?vBCTJ66IprhCujr27WslwzHf7EI4C4aFjBmxsxtwszks/VwZH9Fh5H1lXxXi?=
 =?us-ascii?Q?4O/5EhEupVs23DBYeVovhbwtgWltw7qe/iv0MRQ0fUwU0irY0qGRRdzVrOD9?=
 =?us-ascii?Q?1W1WaPWUek1/UnpNkcq795/Ii9vCjtHklgKwH94bxlxyqvpNyRtPCWmOMBTA?=
 =?us-ascii?Q?inoArQGh/l81kL5JV7kDgdCmwC8KALIoodDHwNXmoLhgTomk1ZblvCjAQ6j9?=
 =?us-ascii?Q?/oJVJXxq4b/YuCO5NFlBc5E6JOsPcEYiZ5icPL+uBqsdBpAPvEmZbpSvPOww?=
 =?us-ascii?Q?KrOkfEwLNSBZFu6QmWHDD0k7S8vgBhZ0PCORo5e3IcHHJNCahwkeWkqOLeUT?=
 =?us-ascii?Q?68uyCAdYifAwXThZrWYO41SwGCmOgADgXDu+fk8yumlxUapODttBQ9k1kjN6?=
 =?us-ascii?Q?gw2j5MjSgBMSB1twpXAtxRjUuzSW3hc0Jc8u7reb6L8VjlzxjbaJjY4PyPbK?=
 =?us-ascii?Q?ebfJm+gn3ZSGDx0I5XBP06ILMph/EmCjAVIOWL7CIUUOHQxaugApZHGdWlgA?=
 =?us-ascii?Q?h0q36NYWjwOrnGd61/m3dXTm/RkYTbTs/O+tx0pnnia4ZnBHPmidh3PCk30q?=
 =?us-ascii?Q?29PXiO5zDP5psK/b0iNn830+F8b8TLCjaRvs5fRaYthzGNfrRWaCkDl8Th6x?=
 =?us-ascii?Q?hXxnOeGRoB8joE7r1GW6A/d2zkZ4Nxem9LJR5tUF3rjs/COAihDpfYBtadrE?=
 =?us-ascii?Q?Hzq3JOabN+MxanBhjNDMQUEpLRUP4350tlgZaeWEQrqUqMvPKSnwLrmfICbC?=
 =?us-ascii?Q?FU8HpEc27k4MYppG6n7iANGlw3lbk3QGeEcwOAIFgsLMMILxLKimu79nMtoS?=
 =?us-ascii?Q?SJIyjTQLDM2upc1BDWOAaF5qSbCEqwfMsGYJ0DCbgvXD69noyvKRNd9XHWql?=
 =?us-ascii?Q?b8XMVOVlby8uVvE39o9hCV1WVnuF//WFVZZO1eAMha2cU0761Idk32eFgyWi?=
 =?us-ascii?Q?5xL1FWMBd3cAgEI3GEQptXGbT4ms3oHsBZ1BJtwxX52DtN3deS7qXcEMSLmF?=
 =?us-ascii?Q?7KCFZFsOC5hFAXHheqHBUQSPKPWL3SZht2HITKUrw9awrdhp4lzlfcfHOoZX?=
 =?us-ascii?Q?ZFVMCC5O7THhFvI9ku6bRBtzqSJ/0yjkQSG14n+yH3tfZtRiVshhqVW5F82J?=
 =?us-ascii?Q?OT1ter13R4vNNITNxiWiF9yCtrOiMZShYLkLejKyHq8a67lC8NKDukcnyaVH?=
 =?us-ascii?Q?hnyNw+Z3HtDczPnUsnRgiQmfWVuawF2hUtY9dhKhQAYgyhxzvvgwXdUIXitv?=
 =?us-ascii?Q?09tpeZ7ao2IMZwzcpSPVsPY9IxVQ4yDMg3Z3HDAGdnagIKP/zo3Wh7SzVmWc?=
 =?us-ascii?Q?cBUcelNVNeYNjgtUzJT7LAKKux1LMDc/KQVmVKlF0MBYLgGH5r2+KT88LMpN?=
 =?us-ascii?Q?fQ1uTay74Nsoeewg3EAc8HsD+opcE2k2T+4ulMLAM1yIm9GStm7IOrgYMESg?=
 =?us-ascii?Q?aznTfrC9kC/hCgKmxqrAFbAglT9hPATyFo20NqiSBpbycA+prfzdZ/1XMjt0?=
 =?us-ascii?Q?cgq2COx5Ji9Lo2Pjy94=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:59:02.5046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68969c2-1e99-41cf-2e83-08de33cbc601
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 32 +++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 27 +++++++++++++++-
 3 files changed, 58 insertions(+), 2 deletions(-)

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
index d16d35c78c06..9433cd91c68f 100644
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
index 378104cd395e..c096c8229c5d 100644
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
-- 
2.25.1

