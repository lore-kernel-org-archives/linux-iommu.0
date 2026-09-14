Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141773911AA
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411745; cv=fail; b=PWICbt10fVFXjcBBUS/XLuU3c2fPvtfaq98ZuS5RKvD2AcHkSuKiLo7InhcoW0ECblwcsi7qfEYPEtu6k/NYP56Uu1Jo6CFb/IZQjqteQGOMz5ftQjqeeKcPzL7YiI4XUkS/xNMunWxIULQj96kUPWavlU2rzQwLTVsdZ89G+aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411745; c=relaxed/simple;
	bh=buxR8Sh/dfom31lAgiKQMSyY6K8ANoBr5LA1MvF+a8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=een+af5SdlYR1HZXikg6icf193q28ojs2iwvq035Xk0g4PVs+EP6gHJyS6XGmtIm1LkI4rjUUlxm7kF9kL6MaQYR05O1yZkcWP9RspRuIrQzqBDlyauw3VlqXo8j9cFbRMHcvTSyezpVGVvwyyrFZ617svZ7H7etAz+j9SsdiN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ea1o5tGJ; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ea1o5tGJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtjCfAiW3ObllYzeaaTUA2c3X/lJIm3S4vfkwsG78/H8x1N6zMcCnqhZBYNPkfSsSXpbQ2rKRP92qSCwDvk3cHa3nG9wm4/laPxuK4WnYMttcs2hmGx+FDcPhlvzKOnQPUamk9ZmU/QJ4pahoiCfEzJQRJo9ulECcrSL7VRsQHus+geiTNSZPy/UWRwFQPfiCtKNJDuPvVAl8V6bwxK0DExsmZWS4mfTmF6BD143t4aEYKvtUSzQfqX88XkanyShVQmFEDuxeH2JVY77k5aGWHFgsG7WyicEYN3P6Xi60gB25Z179wYjjx0mdOL2bjEJoMC0cl2nSrJwvj2EXVYrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2/dnfXQ3sPpwBTlBzVy80W9kyioQB+J6+/fxQ44f70=;
 b=yS11r2iisVLr5q+rDCipt9wdIqisSaSki+JfuQtxwup5IWU8qptBaQ8woGng3kqvSJW8KQ1cajmH1K37qK0vZ6hUz3I1lwKkgbRTEK7ocJEZrqrsli+JdJ7jjt4dYPzqQaDLp8KAzx0c2cOGPV9pKn6ZBbuazlU+KI4pJfs8lEtyFEFB22qkN35gZY7TLOlHGea9GT958RoyxX2vJE5vkmYn7/pPKZA/k2rZBPDA/E2WB3LMaRqFT1UCwhIusFvU/HuXAH2QmGSdaC03jAR9GM0FmfgU1lJaKunjx2/dczTvn4nxeO7qCvZft9cQfWGAuDPFHIZnakUI/GFpPQhZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2/dnfXQ3sPpwBTlBzVy80W9kyioQB+J6+/fxQ44f70=;
 b=Ea1o5tGJ8CUFmnIKaJMgW+x4u2TWygmFvtUE4AtvoKqdgSSSQn4InU+9QaY3Ml7fmo6CXQg2A1THNe6aZLrd1zgaSIUvST6nqSawE9I/hpBz6Mw+l6xvDFyQha+v5X/D4+DWvjSUsUVQKWdR+ZZlSrW7vrFNHi1D0x8BuYrtPX8=
Received: from BN9PR03CA0288.namprd03.prod.outlook.com (2603:10b6:408:f5::23)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:48:53 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::a5) by BN9PR03CA0288.outlook.office365.com
 (2603:10b6:408:f5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:48:52 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:48:46 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
Date: Mon, 14 Sep 2026 18:47:32 +0000
Message-ID: <20260914184750.222939-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fc9b19-e09a-4740-da8a-08df1290d2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|23010399003|6133799003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	r8H74SQrKN90LZA2sQAnIWTGVHS25il5YJhA4M+iqYDZHcY9ncLK3giPXbWPWRUg3x5buoQrv7oBhbKBq6vzjMlpa+kVe0Fb6ax0KfV61MWls25eNnM0ELeix68Pmw7eMdNJJ1JN6EL5mIF3XT09hssIwqQwMxQsnqMiBUaBAjfddIG0GTIGBlzt8wXwD72L31mVdNdUHqBPT3PnjTD3Il2brwG4tohUwr/T3W9Bjwm11MnbB9w3ktxfpFTI+xvdxSmGDrDOdrGy/hvROXz+6/wp5nch9OotMkojamoIu1r+FWRP6rzNAAIKhV91QDroBOhG1j5S7CZ9YelrvFNPiMg18gcTtugyqCJS4aXcfKkwpPyQG5fGuueEuPTPzmlsy+dh0SfAyUd9ShS1fm5Sofs4lM4g+b066UUPRNNky03L3QhfQJ4qWjSEnm29/47WP+2cDHSxgi/sEhYjCwx07z9WH6vVkNxl9xKeXJOyV84zUQiN4RK28A60X+68Bcqf+PhSGqA+pGbxTpKpRoX82JMDrclyTTikC7RoX+2PS1iA+/Da9oIJOsV2N03rYSVD1xR4An2YzkkFmGP5FwMIuHQ0SDZMXaVJIgUhsOhEyWmWytgI/eOS1kLlYSSKO45MrMIZdGPzHSFBIqz6n5lOIqWE9mDD8t+ygCiRX7jNexKfZRXxXKyaan5T/4SPTefYOUCrAE3evFXDVzFpsGGRBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ODmGxdFn+4E5cqdSllYZxbupoowuAJXwyuqfTb0OvT+EYHDmiVh4QGK/xCbSltwuM10K+FaiQvjkrzVQoy7kCA0djXK1cOMoQNX1HKJp4hLh/cJk6ayla8I2GaI5wcn9uORw785LgZfuPt6mgFugwlgltq7XbzybfIaWIPejKPYfZpOT4pH8Ia7eH6yPMpwUjiYtDJKSu108V5TgvDcaoFs39NKnH/t/D3fkH/2R110F+X4s63BT2UAKwQicasuR98gtsq8TMPx6UQIHAYyo70I561F0M1tBjCwIE177JiMxOBqutRU+wBBcaUSFDEEpUZ2JV9ZY24GgpveTWCfvnutoOdRVNaFYXcdXliACepyyeAaOnEc2I/ON7+oxo8M+iQHYfV+2KtlTZMic2U+S2ZrLZdtnZv/66FYI5sP7qPi4LBRDUL3TxYAJsGpx2fuF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:48:52.8314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fc9b19-e09a-4740-da8a-08df1290d2a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

Enable hardware vIOMMU on an IOMMU by locating its PCI vendor-specific
capability (VSC), reading the VF and VF Control BAR addresses, and
mapping them for host access (256MB VF, 4MB VF Control).

VF Control covers the first 4K of guest IOMMU MMIO (control registers,
trapped by QEMU). VF MMIO covers the third 4K (virtualized by the
IOMMU). Per-guest bases use the Guest ID from the previous patch.

Reject a VSC VF or VF Control BAR that is disabled or decodes to
physical address zero before mapping MMIO.

Set AMD_IOMMU_FLAG_VIOMMU_EN after the VF BARs are mapped. Export
MMIO map helpers. Call amd_viommu_uninit() from IOMMU teardown
before free_iommu_buffers() so MMIO and the command buffer remain.

Release the reserved MMIO region if ioremap() fails so VF/VFCTRL map
errors do not leak request_mem_region() for the life of the machine.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +
 drivers/iommu/amd/amd_iommu_types.h | 31 +++++++++
 drivers/iommu/amd/amd_viommu.h      |  6 ++
 drivers/iommu/amd/init.c            | 14 ++++-
 drivers/iommu/amd/viommu.c          | 98 +++++++++++++++++++++++++++++
 5 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f6cf412a9820..51e4364e8564 100644
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
index 8c38775ff5c1..c2257d48e222 100644
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
 /* Used offsets into the MMIO space */
 #define MMIO_DEV_TABLE_OFFSET   0x0000
 #define MMIO_CMD_BUF_OFFSET     0x0008
@@ -464,6 +470,20 @@ extern bool amdr_ivrs_remap_support;
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
@@ -678,6 +698,17 @@ struct amd_iommu {
 	 */
 	u16 cap_ptr;
 
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
index 864e7b283cff..e5fbea666e01 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -12,6 +12,8 @@ struct amd_iommu;
 
 int amd_viommu_init(struct amd_iommu *iommu);
 
+void __init amd_viommu_uninit(struct amd_iommu *iommu);
+
 #else
 
 /*
@@ -24,6 +26,10 @@ static inline int amd_viommu_init(struct amd_iommu *iommu)
 	return 0;
 }
 
+static inline void amd_viommu_uninit(struct amd_iommu *iommu)
+{
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7b4cb473019d..79386816807a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -459,8 +459,10 @@ static void iommu_disable(struct amd_iommu *iommu)
  * mapping and unmapping functions for the IOMMU MMIO space. Each AMD IOMMU in
  * the system has one.
  */
-static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
+u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
 {
+	u8 __iomem *base;
+
 	if (!request_mem_region(address, end, "amd_iommu")) {
 		pr_err("Can not reserve memory region %llx-%llx for mmio\n",
 			address, end);
@@ -468,10 +470,14 @@ static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
 		return NULL;
 	}
 
-	return (u8 __iomem *)ioremap(address, end);
+	base = ioremap(address, end);
+	if (!base)
+		release_mem_region(address, end);
+
+	return base;
 }
 
-static void __init iommu_unmap_mmio_space(struct amd_iommu *iommu)
+void __init iommu_unmap_mmio_space(struct amd_iommu *iommu)
 {
 	if (iommu->mmio_base)
 		iounmap(iommu->mmio_base);
@@ -1792,6 +1798,8 @@ static void __init free_sysfs(struct amd_iommu *iommu)
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
 	free_sysfs(iommu);
+	/* Tear down vIOMMU before IOMMU buffers and MMIO are released. */
+	amd_viommu_uninit(iommu);
 	free_iommu_buffers(iommu);
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 53f3302f7cc6..7e6c4412ff20 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -18,8 +18,106 @@
 #include "amd_iommu_types.h"
 #include "amd_viommu.h"
 
+static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
+{
+	if (iommu->vfctrl_base) {
+		iounmap(iommu->vfctrl_base);
+		iommu->vfctrl_base = NULL;
+	}
+	if (iommu->vf_cntl_phys) {
+		release_mem_region(iommu->vf_cntl_phys, VIOMMU_VF_CNTL_MMIO_MAP_SIZE);
+		iommu->vf_cntl_phys = 0;
+	}
+
+	if (iommu->vf_base) {
+		iounmap(iommu->vf_base);
+		iommu->vf_base = NULL;
+	}
+	if (iommu->vf_base_phys) {
+		release_mem_region(iommu->vf_base_phys, VIOMMU_VF_MMIO_MAP_SIZE);
+		iommu->vf_base_phys = 0;
+	}
+}
+
+void __init amd_viommu_uninit(struct amd_iommu *iommu)
+{
+	iommu->flags &= ~AMD_IOMMU_FLAG_VIOMMU_EN;
+	amd_viommu_vf_vfcntl_unmap(iommu);
+}
+
+static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
+{
+	u32 lo, hi;
+	u16 vsc;
+	u64 vf_phys, vf_cntl_phys;
+
+	vsc = pci_find_capability(iommu->dev, PCI_CAP_ID_VNDR);
+	if (!vsc)
+		return -ENODEV;
+
+	pr_debug("device:%s, vsc offset:%04x\n",
+		 pci_name(iommu->dev), vsc);
+
+	/* Setting up VF and VF_CNTL MMIOs */
+	pci_read_config_dword(iommu->dev, vsc + MMIO_VSC_VF_BAR_LO_OFFSET, &lo);
+	pci_read_config_dword(iommu->dev, vsc + MMIO_VSC_VF_BAR_HI_OFFSET, &hi);
+	vf_phys = hi;
+	vf_phys = (vf_phys << 32) | lo;
+	if (!(vf_phys & 1)) {
+		pr_err(FW_BUG "vf_phys disabled\n");
+		return -EINVAL;
+	}
+	vf_phys &= ~1ULL;
+	if (!vf_phys) {
+		pr_err(FW_BUG "vf_phys address is zero\n");
+		return -EINVAL;
+	}
+
+	pci_read_config_dword(iommu->dev, vsc + MMIO_VSC_VF_CNTL_BAR_LO_OFFSET, &lo);
+	pci_read_config_dword(iommu->dev, vsc + MMIO_VSC_VF_CNTL_BAR_HI_OFFSET, &hi);
+	vf_cntl_phys = hi;
+	vf_cntl_phys = (vf_cntl_phys << 32) | lo;
+	if (!(vf_cntl_phys & 1)) {
+		pr_err(FW_BUG "vf_cntl_phys disabled\n");
+		return -EINVAL;
+	}
+	vf_cntl_phys &= ~1ULL;
+	if (!vf_cntl_phys) {
+		pr_err(FW_BUG "vf_cntl_phys address is zero\n");
+		return -EINVAL;
+	}
+
+	/* Mapping 256MB of VF and 4MB of VF_CNTL BARs */
+	iommu->vf_base = iommu_map_mmio_space(vf_phys, VIOMMU_VF_MMIO_MAP_SIZE);
+	if (!iommu->vf_base) {
+		pr_err("Can't reserve vf_base\n");
+		goto err_out;
+	}
+	iommu->vf_base_phys = vf_phys;
+
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
+	amd_viommu_vf_vfcntl_unmap(iommu);
+	return -ENOMEM;
+}
+
 int __init amd_viommu_init(struct amd_iommu *iommu)
 {
+	int ret;
+
+	ret = viommu_vf_vfcntl_init(iommu);
+	if (ret)
+		return ret;
+
 	iommu->flags |= AMD_IOMMU_FLAG_VIOMMU_EN;
 	return 0;
 }
-- 
2.34.1

