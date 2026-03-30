Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80123AEF57
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860196; cv=fail; b=Vb8Ir6RKcRt1Zl8hhUd+b9Durf83keN532vYmuiVBKZEFyYMdkmxIRzIe7CGRU9Fswllo8bMQf+3illzxMjXe/QJSYgJVwev2WZKFmrwlmyAPENtYUGynywrgnGkIXy2zTWfUNrN8m1Zb/6T4Ma9tCb9QLbgQPKo46q0w3oWnBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860196; c=relaxed/simple;
	bh=qxK1+mwTYnYy4FsHu5Nag3wSw+AHzIRhpRAw/sBtuRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a53RVXiqsKeCKC0/KQqRYzrx4Hcm8ftOIq5lPUHAHiDzFtpih3L2TrspT3GTdCQMcz5ktgiL1ChDJxyo0sWJJTEH09fVnpWkNRJCO5WxrY6Ic8q2O68s7YUZf7JnfvzbFcIIo6Xu436qD3tYqrnPBSWu94dHok+gl8aayv6o9Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zBDESK/A; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zBDESK/A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZ4l0Cr7fayz38LxrFnVNkdTSGkCYl21pVzYSnENFP9zW19oeP5LFj+zeOJsm525mVGTU3TlQJ9jsqosnbQQg3icoZkLk9opASU9GW87C2b9exFYgxo3In7Qt0aLJEbRrl532NwPSUn6UJEFeKv0fsnpzeFUcb4UZRdYkaJF7ollfg3hUAKdDFZaVcADgQkGDqxPSy9Vsn+KScqFaTDC0uMaR0pIM1crzU+ZL7bpiZKQmdfahtQdm5N21h53AUs+SRZ04nQTRjqGjUgsTWpJ+A2chFlWvshtFDvx+cxlRtpsfPAWgBlYu7MWf6uSHzTppYXV26REoL9ttwOkiE2eUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NS+EgrDdWvIs9s5AeuQ3xkiTzAfiyx7U86IPwk8r/8=;
 b=FhDNrDCa/f9usmd71zQ9AA0TF07AHSJHgLWq+Bdy48/gc3epo1CsbgVRAqg60JSfXEJE4EkBHdQ0FqqlK4B4sfPiIYbjCFhVnS5laAaPRmkWfEbRlCHQYIkWh4B2KivvI7zNDHn436G5C91uMeIwDeT7jQ0W46jr6O7fBMu5EaLRw3Lmyn4S/ixDe3VkFRtCoU+vHKSnAC6/32E9hEltX63/yMng1DN5NGBWc7lagQSNiRAe24dFEWiQleZSYINXHi8oQtn9v+OmGtNezXLF/2YRu/iBpKuFHJ8uRgbz8hyMI7M0AQnSvQqpbiu2DgRfhDcaJ3KhOCa6+IW9LmZEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NS+EgrDdWvIs9s5AeuQ3xkiTzAfiyx7U86IPwk8r/8=;
 b=zBDESK/AAAabmxtqiel/s7YPuLe4lhUULSVZoKiQjO9ychhd+DFyYuCNwkoWh91y4JnNkaPfgDTsYiZNsThYlT2+9PXV4QPoB0351FspD+j4xa0AtY+3drv83M/vxR0PtOARHlhu5k1FaU6hMqxsETMcaQxCCb0SjsueSQIHnXE=
Received: from DM6PR04CA0020.namprd04.prod.outlook.com (2603:10b6:5:334::25)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:43:09 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::24) by DM6PR04CA0020.outlook.office365.com
 (2603:10b6:5:334::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:09 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:04 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 06/22] iommu/amd: Map vIOMMU VF MMIO and VF Control MMIO regions
Date: Mon, 30 Mar 2026 08:41:50 +0000
Message-ID: <20260330084206.9251-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acd3738-c35f-48e3-cb01-08de8e385ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FmF6QSwwexbcC95qPfIOpadfihJso5I9AsIykhyAirL+qKjCErLvz6wVIZcochrlBEos1PnLvP2AGPE+Dz1zQ4ikrSqsIgnHMPyoowOB/TYat3die4IzzwyoKHogPNR3zOd1EM5W8JzkA8Hvol0W518Ek75P3U3L5qEwSlnAZhvsU1d37Tn4URvCcSzoDw+kSYUp/zUwzlId0I7n5320IHM0w2lq5Ia0fLMMwwrJRvqaIZ5NVQzqY/reXTpXE9wua9fEDGLt4DWH/4zZZzsfjIMZbPVzRXmtpbcjQq5/7yohbyI5JToFmcyKPc6iyg9XzikNIUX/6CIMGOefznFm7OqTGrTdzuZlJ+0m4MhOx0jo08KTHpzpe0UC85YBCPbwSJQF8wNlu7K91mRkPM37U8249h4sx/H368fC70L8d28i7/JJdxV3K+yS20InaBFZ4cBD40tdHg5GYD4WiZXZpDQhVD64ZSyRpP3De8LH3dWmBA+upDfiyoXAjK5oMUm0/jEQG/pYtMrvM5bBKLq0IMmaXFIttdDJk3KRfC/ccfzkfb3Dafjrg/905ZXbbp6OCZz/W9mY7bC8rb2B/Ap4aGeo0WbPTx45G3CmTxPHSUighf1VbIREvUjUemi7TqoXabR9L7nu1YrD6gz7iRCgV1qjSmnYhBsCaKYJ61drML7fVoglaf671hWIck2Y2t8Rxm6U6q670HcqDen1koBLSGDMUx0YrLRes+19aa3wDltaruQXVhwYM1kfGa6MZIZOu5hNySYibVECzhCDO4bIhw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+9UNzxdJKnTfT+IAGJ414Tiq2Ug3EWtqnXhZNbIIdByAcwbdODX7b5plQkTJOWgvTpXgQ66QOIti+k050cdycKnaKrbYTo+sLeQTbvhMNGxDnvegaYlsPXYujytvPsU6p9stEZ6Ks0hCv8OQ3SPZDANl9ND/8Vw0J4/+WAqyojoyWc4Z8lAWfg//70o2HQocz/AIeytn33uJITTlxyGkcwj+aaVFcMFC0Czl75MC+uugSoccQitlnErkIEzoxU5EUi6hGK0gnr8+mk/by8l0eqL/P38ySUkZAh0VPT4R3tFYl9hfg1hShTZF0w0keVtZ4F75HAldzfe3L+4jneECCRmfYcY8ItRh8OsKqMggUcxs3Lk4KY84SUwL/A1NdAXHbZf8ct41anRQu906aXnwyTCO8L2qsm9aGF1opInzr7uGLLINCnUhIz/hGhRqHDCo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:09.3681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acd3738-c35f-48e3-cb01-08de8e385ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134

To enable the vIOMMU feature, the AMD IOMMU driver needs to map
vIOMMU VF MMIO and VF Control MMIO regions using information in
the PCI vendor-specific capability (VSC).

The VF Control MMIO region represents the 1st 4K of guest IOMMU mmio
region, which contains IOMMU control registers, and will be trapped
and handled by QEMU.

The VF MMIO region represents the 3rd 4K of guest IOMMU mmio region,
which will be virtualized by the IOMMU hardware.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h | 29 ++++++++++
 drivers/iommu/amd/init.c            |  2 +-
 drivers/iommu/amd/viommu.c          | 83 +++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 51a7c3b3329f..470e5d98c52b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -26,6 +26,7 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
+u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0b4d713d3337..f0e18a7dd7f2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -38,6 +38,12 @@
 #define MMIO_RANGE_OFFSET	0x0c
 #define MMIO_MISC_OFFSET	0x10
 
+/* vIOMMU Capability offsets (from IOMMU Capability Header) */
+#define MMIO_VSC_VF_BAR_LO_OFFSET	0x08
+#define MMIO_VSC_VF_BAR_HI_OFFSET	0x0c
+#define MMIO_VSC_VF_CNTL_BAR_LO_OFFSET	0x10
+#define MMIO_VSC_VF_CNTL_BAR_HI_OFFSET	0x14
+
 /* Masks, shifts and macros to parse the device range capability */
 #define MMIO_RANGE_LD_MASK	0xff000000
 #define MMIO_RANGE_FD_MASK	0x00ff0000
@@ -472,6 +478,16 @@ extern bool amdr_ivrs_remap_support;
 #define for_each_ivhd_dte_flags(entry) \
 	list_for_each_entry((entry), &amd_ivhd_dev_flags_list, list)
 
+/* VIOMMU stuff */
+#define VIOMMU_VF_MMIO_ENTRY_SIZE		4096
+#define VIOMMU_VFCTRL_MMIO_ENTRY_SIZE		64
+
+#define VIOMMU_VF_MMIO_BASE(iommu, guestId) \
+	(iommu->vf_base + (guestId * VIOMMU_VF_MMIO_ENTRY_SIZE))
+
+#define VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId) \
+	(iommu->vfctrl_base + (guestId * VIOMMU_VFCTRL_MMIO_ENTRY_SIZE))
+
 struct amd_iommu;
 struct iommu_domain;
 struct irq_domain;
@@ -685,6 +701,19 @@ struct amd_iommu {
 	 */
 	u16 cap_ptr;
 
+	/* Vendor-Specific Capability (VSC) pointer. */
+	u16 vsc_offset;
+
+	/*
+	 * VF MMIO base physical address. This is needed to calculate/pass
+	 * per guest VF MMIO address (3rd 4K of IOMMU MMIO space)
+	 */
+	u64 vf_base_phys;
+
+	/* virtual addresses of vIOMMU VF/VF_CNTL BAR */
+	u8 __iomem *vf_base;
+	u8 __iomem *vfctrl_base;
+
 	/* pci domain of this IOMMU */
 	struct amd_iommu_pci_seg *pci_seg;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index a1cc6aa6f7dc..0018ae804ab4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -478,7 +478,7 @@ static void iommu_disable(struct amd_iommu *iommu)
  * mapping and unmapping functions for the IOMMU MMIO space. Each AMD IOMMU in
  * the system has one.
  */
-static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
+u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
 {
 	if (!request_mem_region(address, end, "amd_iommu")) {
 		pr_err("Can not reserve memory region %llx-%llx for mmio\n",
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index f4b5f96d4785..887a9eb8122d 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -7,9 +7,15 @@
 #define dev_fmt(fmt)    pr_fmt(fmt)
 
 #include <linux/iommu.h>
+#include <linux/amd-iommu.h>
+
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/ioctl.h>
 #include <linux/iommufd.h>
 #include <linux/amd-iommu.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/mem_encrypt.h>
 
 #include <asm/iommu.h>
 #include <asm/set_memory.h>
@@ -18,12 +24,89 @@
 #include "amd_iommu.h"
 #include "amd_iommu_types.h"
 #include "amd_viommu.h"
+#include "../iommu-pages.h"
+
+LIST_HEAD(viommu_devid_map);
+
+static int viommu_init_pci_vsc(struct amd_iommu *iommu)
+{
+	iommu->vsc_offset = pci_find_capability(iommu->dev, PCI_CAP_ID_VNDR);
+	if (!iommu->vsc_offset)
+		return -ENODEV;
+
+	DUMP_printk("device:%s, vsc offset:%04x\n",
+		    pci_name(iommu->dev), iommu->vsc_offset);
+	return 0;
+}
+
+static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
+{
+	u32 lo, hi;
+	u64 vf_phys, vf_cntl_phys;
+
+	/* Setting up VF and VF_CNTL MMIOs */
+	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_BAR_LO_OFFSET, &lo);
+	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_BAR_HI_OFFSET, &hi);
+	vf_phys = hi;
+	vf_phys = (vf_phys << 32) | lo;
+	if (!(vf_phys & 1)) {
+		pr_err(FW_BUG "vf_phys disabled\n");
+		return -EINVAL;
+	}
+
+	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_CNTL_BAR_LO_OFFSET, &lo);
+	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_CNTL_BAR_HI_OFFSET, &hi);
+	vf_cntl_phys = hi;
+	vf_cntl_phys = (vf_cntl_phys << 32) | lo;
+	if (!(vf_cntl_phys & 1)) {
+		pr_err(FW_BUG "vf_cntl_phys disabled\n");
+		return -EINVAL;
+	}
+
+	if (!vf_phys || !vf_cntl_phys) {
+		pr_err(FW_BUG "AMD-Vi: Unassigned VF resources.\n");
+		return -ENOMEM;
+	}
+
+	/* Mapping 256MB of VF and 4MB of VF_CNTL BARs */
+	vf_phys &= ~1ULL;
+	iommu->vf_base = iommu_map_mmio_space(vf_phys, 0x10000000);
+	if (!iommu->vf_base) {
+		pr_err("Can't reserve vf_base\n");
+		return -ENOMEM;
+	}
+
+	vf_cntl_phys &= ~1ULL;
+	iommu->vfctrl_base = iommu_map_mmio_space(vf_cntl_phys, 0x400000);
+
+	if (!iommu->vfctrl_base) {
+		pr_err("Can't reserve vfctrl_base\n");
+		return -ENOMEM;
+	}
+
+	/* Track VF MMIO base addess */
+	iommu->vf_base_phys = vf_phys;
+
+	pr_debug("%s: IOMMU device:%s, vf_base:%#llx, vfctrl_base:%#llx\n",
+		 __func__, pci_name(iommu->dev), vf_phys, vf_cntl_phys);
+	return 0;
+}
 
 int __init amd_viommu_init(struct amd_iommu *iommu)
 {
+	int ret;
+
 	if (!amd_iommu_viommu ||
 	    !check_feature(FEATURE_VIOMMU))
 		return 0;
 
+	ret = viommu_init_pci_vsc(iommu);
+	if (ret)
+		return ret;
+
+	ret = viommu_vf_vfcntl_init(iommu);
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.34.1

