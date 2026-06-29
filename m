Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7343D6CD4
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747707; cv=fail; b=n6o2BhMwojBqFz/xa69K2kSCEe97cIICUNblFQsgiX5cGePtc7uo7zO+YK0TSNu0ijNK3SYhT+bgUmwwQsXxgU5AcoJswvk18Hv0Ttisqvw1SIWv7aXYllCltCsAgzCmExg9pQ9c6C1rDgIl8bt4MvVuOUyVrmozIT0ZDP6gF4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747707; c=relaxed/simple;
	bh=h+yD2HJSNmiI6mDK9rxsq05TCBqbgAWQVKFWMkKweP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lN7Nd9A7KuTfVZpT+1x9ISz+g6dgr1EWYUSLAAkqcI8Mev7fLknVGGCeCEJc4eoQQ9AxFI/y+YZ2/k1SQ3H6BDNGnh63lHRRju/DShusFvK/YxJkfRXtaZVyzmUg6gTfA5J/1x/Gz5OCJDbikp1t3MgZ8sV4Dt+rpOQJqD1iq08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XVQSXloG; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XVQSXloG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjqCScgHzQgm87mzO29AhILbDs4KXNS55ToTtkELuhetOEx4ghDXoodKM7meqRNWMpVs8Li5tBluRCFHliW4SooSKubJHAOIF3cCFg0Ev6apP5Gz6HDHM6T4D/hh4NE6dyiqtoycdvbq0kc/sdr4hK9f9MvbYacLqcf34sUhJpESGXE7uKa77blR86QTnhRFzXvCZpcQeSo4BbhemarY9UFneSJyUiJdLf2KaGq259n57Qctm0wPaIyk/1K0OIKpacCi2Am5EAr7jbuHJl5kErMA5wlPi0JXu6IfWi0d2PABGjMjxbq1y9pjHWkzEYtHYWsc6SQg1jCBkj+7NR4wFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiQEnwP2Wydt1FXeRAxCxKqmiqbXQRcCXk9UlzIt++A=;
 b=tqOzadKKI6fhVtITguTBnX747Hrc633MSfSwDl8sZ0CxINXe33mC12e0TRscobpin+71guVM3u6I1wsGTrLjWFUpkf2a2GIk3wIH+CVs8/Y4ivvcYth+0Idh9kEnuXik42kXBwjj+gJEmw+f/HpH0ia1cd07QpTDmrObmYUA+/mZRsgXoUkfJkE6zD+gCuEAk8gqy6pDgpaDIt7EUxEIZYyWqeBkIuczENUw/CL53e/pzGoTwqI+q/oZOtKpWAIJ2Km7HPaaBgHn4WnQTGY5ljlhbkrO2JSC6G0h6JvjS1Lyd9+7PBM2xr6U1V/aTArgmtzAJJeqhwMi32Ov+G6KiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiQEnwP2Wydt1FXeRAxCxKqmiqbXQRcCXk9UlzIt++A=;
 b=XVQSXloGt0YnCmf+vdmhVO3m64pzoObF7pHisw0iXCZFSVpRQf5v7zjKEwS83p+VmrOgTeV1PZjhQ/H1lTgmK+qMFBBzh2btyRG/EAWb+Jv3rfANN2/G0sop7s0iaP2uMeuAviuaaqruXtzfE2J+HGSrHZy92AgLN+HdbDwkyLQ=
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:41:38 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::31) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:41:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:33 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:20 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 06/22] iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
Date: Mon, 29 Jun 2026 15:35:19 +0000
Message-ID: <20260629153535.15775-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5697c6-c6f9-4448-cc5c-08ded5f4e88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|7416014|1800799024|22082099003|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZJkGaYXkoGDWqF+M//45evC4+/1wdH9QTqMTRpI6ykUfipjYT/hdkQVz5H9j8fHhefbtX8gLvwwljOd9QF+re0xNYLFGdebPTv0h0quSwt/7XvWLatVfEqEtaJVug6RbFDljM9H8TkMaHT6O1cRqY3Ao2+9qZkO3u7EnoMMAXL5oZJK3EbH/pav26UM0F5YQ88K0AI6Zva1DVvpjeDe+TBRRQRBfuSkJIjFCHr/bosd9DK66ZAYaaQLdzs7gthol5wpwF7qE7U5aGFRaL3Xd0A4ci8OUmbqMSvwfGEq1n4TqBzTirSQSeRCpyIM0AcSFRUOXkAxjMlZWxcdLORdLXWz2KO8iFDLcHVW5XV/MEEtDYmDKWdNlpDWTU/SyyJgdIvFzcfBR3BGDezFoVJ86IYnMVUKYcz+ENi/nNoPZZCO0qKHA6GHr+69HhS1qugm6jvue/GwYWbFT18/bDSnBTQt3+xeCP8X41efwOlpPCqNpK79Wb8z3jr+8SEcGvZX6eBrUIe1fgfv5FO6A5mA2Cor+EQLBFCoglPXb4uW7aip/iogPrTi1Bx1L77qIEiqmncXsv8DVP+RbJlAcV3gDYHHFlIIfXiBZxk25GbfowKTIlAGwfW0b5CgstRCJiVXASsXbyZkszyOdZ1WN+n9Iv6ASLWOn16nvTiuicCDtjH0igwQccxy3GTSXCnuJWbmbQzDyql9PoPKXbacPYrxJFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(7416014)(1800799024)(22082099003)(56012099006)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FYFEd4ITf4Rv/3iV+izk/fWQbETDrImoTKVFn1Bn2Uws91Vc/pR7srzZ/l4zLVYgMTtdpyFwHbD/GYZm5tHNMy9RWngeAWD2zZCBU/TyMRSqdaM/obzFyc7U6Dco8DxTNe7osp+xJN2VejK2lrL5Y8CVxhfjtcGr43XDDBd968B2elt7AAlMtX2LAVWW0itfChzm4hLYMGSAvlKEnD6xL4l45x9PJB/zwVHHPEjQvx4m2WDvnBaRlhRles6Gcz86DljGa683apRlP3j714c7KJjmCF3NKavRafLhCZ1P6tw4+1/ItoTBCqReXBPGDM50JXY9M22jmlH4D7VSe5tQpECz0jL0cAs56x0/hjfrZxlPr/FjuoOjsv9mJzO6B2YY1SA5qm99GwneA80g16gCraBDPn1a0eaPdTEWF10QS69r1L06kAxVri0W5XI6VIHR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:38.3044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5697c6-c6f9-4448-cc5c-08ded5f4e88c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426

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

