Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5D47208B
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760290; cv=fail; b=ku2gZyNQcjuNNG8O47IqGzpShy/X0oJm9VazA9SRZLLXqwV4PV827beiE5Arvy8WzUzCMN4kB+1DeMYnG//jQMewLz7pjhvAGbEwUwxJMstkszIUOQbniSLDVqYuKUp6psQO3SF3QuT1VA/U7SjFCXd9LllVv0a+FsU2IlklTgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760290; c=relaxed/simple;
	bh=nXNJPiTCZ8pYri+km6lDRZ5u+50Yr60ZjmHtxCNwPI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbn4SAd7ySPPqBGGTrQJ45Qx8uE0JDt+nA/u9fbwbzui5iIEIpttaKLEAvglLpx6bklwwRwR+eNo7A529QnPlIMSO4BHDcvklJSV4K1nyhLdYdH9aB1y/7KVvn7Lfd8Uv+sztw09BV87Bk+RUw516/Dv21aVCl8Z6O77gAjXNg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ycPXws40; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ycPXws40"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlGZ0rEdLAZJ2VMN8iPFL8/ePsDhaG84l8y+nIlWFjX0lKxGZM1EC97lzB015GuRvS/IAS+0fH8FSqyZJqYzpwGhs+mEGtuDDrKrIoTkHAtZzT5OKMGosG2qA7qeuOcWx4Hxjzwj+wCK0ko+nNJPVzi7gL3sdtqrUJf7eRVbEG1qVFiKMgaj7Kkp0t7hL4wNWUKSqDMKJOtkUCN3tXVPKzJXQuuN/77MjRq6yz0vOaqiFxDz1bSrF7uwcREtPNimwHM+/QpB2USLmkZuLM4CNjzwwdqvWf+ilN4PEhZz+5sL4YDLHRMHWfvSQxfKY9YQIfOsu8CPCaLncnXncHdt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmsK2UilLYKZ4CyLf61gHFlqZjLwIK8lSHGKP0/0k0c=;
 b=C+PT33WopZl7Gib54XoYzDttS4EAGMQYwomMMaqBlpiDWrsGK1XfpJwLBZMvFDHMNkoPrNcu0QDI7xvcOyr1bWiitNOf5kUGDVo1wgLK5FOkgTs+Udi+19TNK/aNhH++FARSGobt1VAMDnRi7d5sR3Cd5+kUi7Keq6kT9FXQp70FoL6f/NBENQNvHhb/IoVOnfROZDO9nlQHnEGrrZ/0Ent1tKvX/VO6CGDPOgt0DdIQhiL0RNmIgIexj0rmAj5q3nsUNDgk5pNSUuT/DjtUlBcdF/t49WX/dyrInKnkuI/XlVR18WY+Gr8XyKrCbYBmYL3qiUsVsjH77LuSZP08hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmsK2UilLYKZ4CyLf61gHFlqZjLwIK8lSHGKP0/0k0c=;
 b=ycPXws40BSlugyzBWkk6BNTOUrwTDhKnZxMJgsDaGzAr7aVUISA8LmI34lwp/zb9IEYMHTl4e5sw7umKcc/8OvRbSmtsdSHf4K20AWx5Bkel5thXIlkuCmeS4NVVd150iFBiPcXQQ3wJpSIf9Gv9bgOYXDzjZSpr/AEAVPxYS54=
Received: from CY8PR12CA0014.namprd12.prod.outlook.com (2603:10b6:930:4e::16)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 09:24:42 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::5a) by CY8PR12CA0014.outlook.office365.com
 (2603:10b6:930:4e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:24:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:24:41 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:24:35 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
Date: Wed, 30 Sep 2026 09:23:26 +0000
Message-ID: <20260930092344.5616-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fea2f2-7c9c-465c-633e-08df1ed4a888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B1SOGUGu4GR/D34iOhvfmOJvopclz944qp0uSvt3O9YTLW5ZAf2v482cVs3hps3OQxhqDcvnoQpBeGny5eqU+RwynnTdxf3053PYt8SiV0H9HYuP10tLtRGNe7vUS56dbp+FCL6CA0K+HAT5/Wo+10Ide0IGhjl/qg4pZ+Ya+QEA5Tsl4uncS3zn0ZY3j6dinhfWZwaoqCzsz6l5vAcWLBsJlnEUiUZ7E+gWhGB9vYAg6cxunPkl+vuzi26K9kSPUCP35ACgPy5zClH98MpSb1WGCHou1150zPeravODmNURbBVyak8DfDg26calcMNwT+LB7YwLSpDlfq+S8sPQpvuWwR7AgEnET3ccstbZMLnAkc+lDer0jJbdr19KjLGKRE2LilNnMFs03SJRvZjKVj9O2RRACd8hf5l4Id4h2XOl8EgRhF0dd4bhtdsYKlw7O//bT0Mv2+lu8BLKhw+1BHdocGPN7X4J7WiSN5gEcqUI4Go0u7yBa/snQj4lBmQQoxB3YM0HmBBBKjwA7Fq7GeDPpqB5LBYov3Ppl9cxVcyCxRyVThxMi0nNBHPQGokAJ34Z1ev6R/MhuEualKnIeIDzNKEgfBUd+jqXc+6p2Ux9TTVAeJgPIPn3qg4FUEQns0mTaE4ICFW55M1y52RI//ZarkrPXeJMdgFg33PPRXrBFsd8MZAsJZk9WXRARoB7dg7ZAL1gzNIqVS19PXJ7jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yhgLUpa8l4Jx0sVTdPt3ZSRwheeJmOGBH/FumPZMvgSF04wPzsdFDLzqgkVs9HxsjiLmSQBi5ufJ2IGJaiaGXQ6oFlOTiYay1XF35hWpjb/dfEEJBMhD2W0JVITDhinvc5PaOu3tmv91u873ZlHG0EzUcxWZ3uZCA0MSAQtLq1IxtJWqDVNwwvOP1vJ+v1AMd0W6qo713MlDcpuq06AWqxmj9FH8ClsdhclJkG6IMo7lFno1uAJbFSzmG+zgNompjo9jukNLVqko9FtpDfC3hMqPa1IqJszh/V1IVZEdELO6gNYllnL8tluqPyqb7M0SXSzWdk0xkassMAjp2K85yWqwVcXu4LjYaEP/n7F8cHHd4juM2tBWlwjK+lHkAqGLnpM9Aj5F3UgoY7JRV4cxQigP6gJom47QBlnzkgedQmaHTrNjbzrrxh725JF8D4Uu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:24:41.8700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fea2f2-7c9c-465c-633e-08df1ed4a888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789

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

Skip the host release in iommu_unmap_mmio_space() when mmio_base is
NULL, so a failed ioremap() is not released twice.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +
 drivers/iommu/amd/amd_iommu_types.h | 31 +++++++++
 drivers/iommu/amd/amd_viommu.h      |  6 ++
 drivers/iommu/amd/init.c            | 25 ++++++--
 drivers/iommu/amd/viommu.c          | 98 +++++++++++++++++++++++++++++
 5 files changed, 157 insertions(+), 5 deletions(-)

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
index 7b4cb473019d..5be422591bac 100644
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
@@ -468,13 +470,24 @@ static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
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
-	if (iommu->mmio_base)
-		iounmap(iommu->mmio_base);
+	/*
+	 * iommu_map_mmio_space() drops the reservation when ioremap()
+	 * fails, so release only a mapping that was installed.
+	 */
+	if (!iommu->mmio_base)
+		return;
+
+	iounmap(iommu->mmio_base);
+	iommu->mmio_base = NULL;
 	release_mem_region(iommu->mmio_phys, iommu->mmio_phys_end);
 }
 
@@ -1792,6 +1805,8 @@ static void __init free_sysfs(struct amd_iommu *iommu)
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

