Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77632C11F9
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945520; cv=fail; b=HrZg8iKWZTtoa2HopjY/3p+GVpT8Ev6bNKZx5zUgCZu+Yq0ng1cSCT3Qa0AD4HUumCFDii6H/sr2FNnQtA/bkcgHGXbPD9pvQ+rn+DvQUF+xK6M0T9f9Lf3j8v/KoFiF3HMUwTeb4fFbIAdHBKC1htvYLryVAEb3pfjxiICxls4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945520; c=relaxed/simple;
	bh=h+yD2HJSNmiI6mDK9rxsq05TCBqbgAWQVKFWMkKweP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYlpWud1ab1yjjPN5PPmUUT+N1Un/3MHtC4ei+oOsi36nyIvJM8mnRNLh0QlfAydQRo7HKLBFRq+nFska7BK+ip7QBjulW4pOk7CBuGP07uEtbJhbyjCStJmdiETwpIgOk/tKye4oIspNTMiXtd9ps5gVjoEFYV0LEC3bthHI2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Av94WdXA; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Av94WdXA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhjnjx93Ty+yjuRN9+Vz2ukOdH/pEo/ffwxQlp3RwDgRxI2bLljjwyI7skcjmzfvtc5hB7G1m9IyY71UajpVYE596LX/EP4yoeJgj8Nxwk8fNcR8eQxY5P/TAYTDP/uaHKPV/aig2ZAt/NSbJRNCL9DInFg0jzy93JFh01GkAyLMB4AhAhfK339ljTy/VjjgXNAPH4x8q1oRJ6PM2KjGz/Dn/fEalhmiMkSs2z+d2ZZZmiJZmwhCs4bgpCaypaGLG0Nb+iWa1vnh3zd6vRZpTk3yB1FOcT18oi6yMfz7hwxtkeLRp1SY3Hvn2MOlI0pYlv3gozkDpaYj/XxN2KKrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiQEnwP2Wydt1FXeRAxCxKqmiqbXQRcCXk9UlzIt++A=;
 b=DOnxGci1w+5178XY3YuQfoy4MN9RJJcJ206Fwl4XyAdRcqKhLJwUL4zvfcAByoXNaLxqT6tFnTPX/3Z/VSf9jOwcn7CesP+QDKeWvjOGImYt/IlpBgSPybu5w7NJXu/yLkywkWd2ewBT2ZdwFTBAtbKJuhcrLUFZzgZ/+xzFBwF2xs8oDtWlAbyt/RdTDwk4sG45o1z5e0f71ljQCkjBfxviKKCVnAlOyd1M1O1Rz9XRhLldabYDjSb5pUO00aAlv0Otf0E+fD7biLeqBarAmO5P+rbfzuM/fTMi5j4REnqooSJaTc8mYMWrKdkuhsMMMlrLExvG++DcFFEPu98xBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiQEnwP2Wydt1FXeRAxCxKqmiqbXQRcCXk9UlzIt++A=;
 b=Av94WdXA63hAex7678q06pDyOYlh0DLuDQKipSpKvwSLH20RYJf28QZlnRIbSP2WSsy7oZrdM2wj/M9sGtvteE30O6yp02tMHuQSsLmWuDy00u20MxCdDjeClDK47vk65r12u/+HMnzZSJs3xzfeBZRcodgJw4XVEz6e5sAuDrU=
Received: from SA1PR03CA0019.namprd03.prod.outlook.com (2603:10b6:806:2d3::21)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 05:18:32 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::12) by SA1PR03CA0019.outlook.office365.com
 (2603:10b6:806:2d3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:31 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:26 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 06/26] iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
Date: Thu, 28 May 2026 05:17:18 +0000
Message-ID: <20260528051738.596013-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ba93e9-4419-44ff-7cb9-08debc788f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	m6CuAwQMjrx2BHzlBAcLJ3wJRvQa9CetrxlAkYh79hRbVI5ECE/X7/Mz9eU9FXqF6PmHXtywZ/WlWAmzOuREYnFGC9nTqdmyI3lUd5CO3pfYU0XOqSbAnVrUq1L/0+/6rDd+oqB9oEfebF1c/gfGEGGuUnK8Hbj6zvlQBAlFCaZVo0TXTapT34rtUkEsb4TpvY26iRGctfPA7+xvDp5aR2610patQd8ugIqwZgzDnF2Bm3uv48PONou4eSjvdjDMAem5Ug2ZTBirCA7cd/ntisOsoXVyeqFlmym5+c8UNantnnojLi+fGt7nQ2YcO4+lE+VpaGZC93RC9NZBGsZBlS3rvfN3GLWs9UX/25FnKNHT97wX0TArmOraK8UnSW4pOqhf5LuOGLdvkvymczhItY0UqwSO+Cru0EMYgx9LI1Qo1H2VMnEzjx6eVieOMZRRidt3FZF0hpvwtjEDdTnfA0ArnA48/jZrn7Perb+Q9UPPXl/OniPRujNYL4A0DL57kDkxjpO4k4Fnw/ApTRhT6QUnHIEOJYnaIFP6m4y/vHVcO5rzUXcxo2z1OU3ypyXVGr0cXd9AEuFmSNVVXDdPPfLaVwc6HdmOPjw0ezI4wYiZcMWoAp5otJwiKgNXJC6DGcVdhYrkaHQkm2BPfEJK4vRqkl04PdvwmdUXlke2vf7PS6KEnJcCwnqD0XzozsQGc1VGexP88mJLfk2HpWwL52dgPIHc3UjgG6ugkGxq52E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NK7BMOdux5D8SPhNO08+nnGoeq2YF+YMpKFAIcooyUUk2w9v1Mfhke+aHOV3638TxY3oIk47mTNA8X21rpa/XZ0Zd0W/5sf2XSUY/ilom/MZFuRSoWC8n7Z2p8+4+lTG7fprRPMbXp46Dn5onruV2cxhE6o5AjM5Hb20T/SpXJkl7Zmes8imA/VHWJC1E/2BbQvK0VnJ7NDaCCPpj39fpwFA6pBCvKmiEgMBFZ3TK+JQZX1IzNzM8rr/bkNCGOWVtW855zfEfKPwPWmztdmIEzEouRb80Mez/QoLuHRNiP9ZM8pPcz5BVIO0M8+GBpLLSJC1NEQ9FSTwe9kMEIJouHi4Vsd2VtBMjlAMkrAvHGoSi7c/zcxc1+Tg+xkFY9BCxmZ1AQTdfcXq/wO/T8+EV6GJbIWGUw7OmLHV+ZTIp22oV9zDTYPF9D52LTqLd5wW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:31.9649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ba93e9-4419-44ff-7cb9-08debc788f59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714

Enable hardware vIOMMU on an IOMMU by locating its PCI vendor-specific
capability (VSC), reading the VF and VF Control BAR addresses, and
mapping them for host access (256MB VF, 4MB VF Control).

VF Control covers the first 4K of guest IOMMU MMIO (control registers,
trapped by QEMU). VF MMIO covers the third 4K (virtualized by the
IOMMU). Per-guest bases use the Guest ID from the previous patch.

Initialize the per-amd_iommu gid_ida here so amd_iommu_gid_alloc() can
run when IOMMUFD creates a vIOMMU instance. Export MMIO map helpers and
call amd_viommu_uninit() from IOMMU teardown.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |  34 ++++++++
 drivers/iommu/amd/amd_viommu.h      |   6 ++
 drivers/iommu/amd/init.c            |   5 +-
 drivers/iommu/amd/viommu.c          | 124 ++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 9f2a1a8a6d3c..044bc9a634a1 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -28,6 +28,8 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
+u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end);
+void __init iommu_unmap_mmio_space(struct amd_iommu *iommu);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 00f964d5b149..e88e0bacd1a9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -40,6 +40,12 @@
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
@@ -473,6 +479,20 @@ extern bool amdr_ivrs_remap_support;
 #define for_each_ivhd_dte_flags(entry) \
 	list_for_each_entry((entry), &amd_ivhd_dev_flags_list, list)
 
+/* VIOMMU stuff */
+#define VIOMMU_VF_MMIO_ENTRY_SIZE		4096
+#define VIOMMU_VFCTRL_MMIO_ENTRY_SIZE		64
+
+/* Host ioremap/request_mem_region sizes for VF / VF_CNTL BARs */
+#define VIOMMU_VF_MMIO_MAP_SIZE		0x10000000UL
+#define VIOMMU_VF_CNTL_MMIO_MAP_SIZE	0x400000UL
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
@@ -686,6 +706,20 @@ struct amd_iommu {
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
+	u64 vf_cntl_phys;
+
+	/* virtual addresses of vIOMMU VF/VF_CNTL BAR */
+	u8 __iomem *vf_base;
+	u8 __iomem *vfctrl_base;
+
 	/* pci domain of this IOMMU */
 	struct amd_iommu_pci_seg *pci_seg;
 
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index f08ab9ef23a9..d0c4fdd00809 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -10,6 +10,8 @@
 
 int amd_viommu_init(struct amd_iommu *iommu);
 
+void __init amd_viommu_uninit(struct amd_iommu *iommu);
+
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
@@ -17,6 +19,10 @@ static inline int amd_viommu_init(struct amd_iommu *iommu)
 	return -EOPNOTSUPP;
 }
 
+static inline void amd_viommu_uninit(struct amd_iommu *iommu)
+{
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5ac883429ced..6e69b3dd8b1e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -459,7 +459,7 @@ static void iommu_disable(struct amd_iommu *iommu)
  * mapping and unmapping functions for the IOMMU MMIO space. Each AMD IOMMU in
  * the system has one.
  */
-static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
+u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
 {
 	if (!request_mem_region(address, end, "amd_iommu")) {
 		pr_err("Can not reserve memory region %llx-%llx for mmio\n",
@@ -471,7 +471,7 @@ static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
 	return (u8 __iomem *)ioremap(address, end);
 }
 
-static void __init iommu_unmap_mmio_space(struct amd_iommu *iommu)
+void __init iommu_unmap_mmio_space(struct amd_iommu *iommu)
 {
 	if (iommu->mmio_base)
 		iounmap(iommu->mmio_base);
@@ -1790,6 +1790,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	free_iommu_buffers(iommu);
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
+	amd_viommu_uninit(iommu);
 	iommu_unmap_mmio_space(iommu);
 	amd_iommu_iopf_uninit(iommu);
 }
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index f4b5f96d4785..014ae16bf58b 100644
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
@@ -18,12 +24,130 @@
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
+static void amd_viommu_gid_ida_init(struct amd_iommu *iommu)
+{
+	ida_init(&iommu->gid_ida);
+	iommu->gid_ida_inited = true;
+}
+
+static void amd_viommu_gid_ida_fini(struct amd_iommu *iommu)
+{
+	if (!iommu->gid_ida_inited)
+		return;
+
+	ida_destroy(&iommu->gid_ida);
+	iommu->gid_ida_inited = false;
+}
+
+static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
+{
+	if (iommu->vfctrl_base) {
+		iounmap(iommu->vfctrl_base);
+		iommu->vfctrl_base = NULL;
+	}
+	if (iommu->vf_cntl_phys)
+		release_mem_region(iommu->vf_cntl_phys, VIOMMU_VF_CNTL_MMIO_MAP_SIZE);
+
+	if (iommu->vf_base) {
+		iounmap(iommu->vf_base);
+		iommu->vf_base = NULL;
+	}
+	if (iommu->vf_base_phys)
+		release_mem_region(iommu->vf_base_phys, VIOMMU_VF_MMIO_MAP_SIZE);
+}
+
+void __init amd_viommu_uninit(struct amd_iommu *iommu)
+{
+	amd_viommu_gid_ida_fini(iommu);
+	amd_viommu_vf_vfcntl_unmap(iommu);
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
+	iommu->vf_base = iommu_map_mmio_space(vf_phys, VIOMMU_VF_MMIO_MAP_SIZE);
+	if (!iommu->vf_base) {
+		pr_err("Can't reserve vf_base\n");
+		return -ENOMEM;
+	}
+	iommu->vf_base_phys = vf_phys;
+
+	vf_cntl_phys &= ~1ULL;
+	iommu->vfctrl_base = iommu_map_mmio_space(vf_cntl_phys, VIOMMU_VF_CNTL_MMIO_MAP_SIZE);
+	if (!iommu->vfctrl_base) {
+		pr_err("Can't reserve vfctrl_base\n");
+		goto err_out;
+	}
+	iommu->vf_cntl_phys = vf_cntl_phys;
+
+	pr_debug("%s: IOMMU device:%s, vf_base:%#llx, vfctrl_base:%#llx\n",
+		 __func__, pci_name(iommu->dev), vf_phys, vf_cntl_phys);
+	return 0;
+err_out:
+	amd_viommu_uninit(iommu);
+	return -ENOMEM;
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
+	amd_viommu_gid_ida_init(iommu);
+
 	return 0;
 }
-- 
2.34.1

