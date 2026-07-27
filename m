Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17B2D0C84
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159050; cv=fail; b=P8qrXJj2OOcSrfuoLsLQw4IeL9hlQsCCp0yj6y8u8W8dLh99ip8uzq8+DsMRVwspXJ7RFuOowSIacaZW+j70XhwTTJ2vpdWImlo9xdNST29wFnyQ645EtMAvzJUBWh7/Gxf/Nr/JaspUdptFqaLY0Wp6d/njURyW+QvrdGtxpM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159050; c=relaxed/simple;
	bh=h+yD2HJSNmiI6mDK9rxsq05TCBqbgAWQVKFWMkKweP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rpq4nNxHsRr3xjGZHCOgdErctFoQZ8kBWlB8fA/Yr/L0BBiHpPmkYUFTTA/TaO9RQPF1IbcoG57CLkMtBuVi41lWl+yxHKcdkMp7pkGZFXdDB0JSQO7G/EmOUuetHecOcNfYnKM/WOJb99FxZN+jZkATY3P2szB3sGpJ9yFdui8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=31PpWgxw; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="31PpWgxw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLCLRZlPYImW2u8MVDBoQu26ANemvGeyhYTMiiKjkUD2jh2gfvwtkmdBRnz4JSHkc/+OLiTMtu0YpQuf9LRAcnWNPfg3F3ADAfZKgjJUrSOEaGxtd1BAcXwg2thLsrkmMM8RLsKbopkacwjq7An1+Bq1OaKOhPugAkVtPF+9AMKbggRMDaIqAonKT4WE91UdPqM7xSrLtmX7WJzUQrp4dRIKoEd2q/ZionnxEoM2py+DC3efbkL8/lGOzPfX0+49Br4AoOsZ3mtZdZjQre0i7N89XWaId65aELWEpiutw25dhs7aOUYk+LbSFxIcWvhA4j0waRrEoBnwomtQPihVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiQEnwP2Wydt1FXeRAxCxKqmiqbXQRcCXk9UlzIt++A=;
 b=Dt8DorDn9VamMWbJSz32tRoL2Ixd8cYyElV+WP4My5nw2ySfEA7EhmSp9Ywwu2yhvMcOuiy0UzllvbZVoMeFg7ERfioulJxZiY6LqfNZwJ9/eg3pmrfprfKPa9+Yi+t+fN7TdPbbqisd6GW4HY67nrPib51NIUiraWOYUCq9rSzDZW3A+B2oKDs1UVaHfCU4I+Dk624ZHK6aTkTg6wmIIXOildEr6itKVRhKPDeIIvef/VF22h8Ts8tmD1QfgnR2JbYxx9/n6TEdDSOphPg7nxbr0osCgb05mgLVQXydmiNTWkQKqZpU1y2sJLHxKoMYkb37nfyGP7FUoaeBbNr4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiQEnwP2Wydt1FXeRAxCxKqmiqbXQRcCXk9UlzIt++A=;
 b=31PpWgxwEJqG+SWaAO0eMeWBsrbSHkp0D8Tf0cQx2shCIVoTWawt191Htx9DmAydwKrsKOYmKm7Ee+uKxKpwP/XQ9rsOGOfw4qP+edE4Eos0zAc1j/s67HJXAVKNWnDJpv/bgqVOIeKVbufjburXLVsB0DjIh/f5PU6rWNJIPwI=
Received: from PH8PR02CA0037.namprd02.prod.outlook.com (2603:10b6:510:2da::35)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Mon, 27 Jul 2026 13:30:38 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::f) by PH8PR02CA0037.outlook.office365.com
 (2603:10b6:510:2da::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:30:37 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:30:32 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
Date: Mon, 27 Jul 2026 13:28:55 +0000
Message-ID: <20260727132913.22475-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 44fc046f-1ba0-4333-ad42-08deebe33ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|18002099003|22082099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	c9DFC39568vEHfqLWe9+W/H/3FvAhy1umLWQN0irVa6va9px6hRw45JZMagTnLUapuF5RdJuMwXz9//Y+RxT2s60ko1aA1Sy7LAO7Pq/ahxwdeOIYx6sx5FA594PHcr+tx0KfrM8Ez/YOVsTs+YoSnTsF9/Q0BIdwuBiCa5Zij6FL33K0cuwA9eUk4IM/+1C0WqvE/U6gaEC76P+i6v+XXMzemULFSgfAj8wMRUTWzaGt8YY9Vo0BPJVgGF9O427O0KzHfzVNVMDxSyhZ1BjJixUA2hbNcjy0wEdnzzPfRi+13TPgMKRQLzzfk/Rx2+JBYd84xitsv/Q8U6VmuorjnPa8jeauPQV5hpdrKHQ/P/VFb531ZLeqydilcrxykxpJBNtVB2qUZ4cJFdABP+xhsSIOkSi4wht74aVxtCizvKX4S2UJu22dExl1kaqz/1USAblmgjFNoOp8GQOUSHMPbph4J3gta6g9PawvtN/MuxG9Rvdz9P78sE32LKYtAu7QD6tvwBO4R8xldrXkKy1bSPR97O0k03CbSgvShrl21pM73mLdLhUY8I9Bl2FuNm4uJTpiio7F6sxTnLotYFz70wxmzVZsK9sIHQ0o1Jm56LrLRvRk/MZU1LoQbqU0uGQujx0LAZr6kz6QomAKuyoDQvuYPoYmK195/ScwA0LFiU9xJ832Mc6DhdEvJbJXT1zDnERJTDXOh01hucUb9zkmg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HBSLCRGBONuPOnnUx75o3gMVUTpcIkYOjxItmv4YGEoDSYkzAKGvESmg48A5fiJOY4z/x2cRJs1jTp/DD8bbgCznpTnYYyBSE5q1E72cxNjWsUZ2mJdw2QVUMJ1bcJRqnswaGKAAik6mfn/NdOxg1GBldNnQdXDo1JiaUko+5qFFiGxpb+d0X27aUV1aCLxMRmd2k1YLbfIZARSJAbLOa6z8WzKvqpcryTyle+JwDTldOMiA2JAMpMUpfKfYLgAO4PdJM1nbqV52RxwQ0hLe00c+0kUn5keV5w/lTzPQe/kFp8V6bWXqbhmbIb7yUgg2MrVonFN/Uw7YYoEkmwdl4kLvvXMGT2Dpr3M0Y/g7DApIa5DgNeR3xDI9J4CuDl0QejBUCCTkI87rfnxVQny1G4OdkJZe1EkegkUalX6NzvCU6cBAOhkxEkZoaOK2iQgy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:30:37.7937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fc046f-1ba0-4333-ad42-08deebe33ee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543

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

