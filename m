Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430DF41D113
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159127; cv=fail; b=g5WJ2iEULNUfsUFcCQFvJQApnPBTv2ZL74kHDjSMVvzu7GRGbYcb+Iz3+Dqkfmg5IIPT6oVGeUud4Vv++XpzR8/qQYgsoCvprmZUoMw59vT6pQUkvRvCa2TtrXnkpo9Ie8cZDCp2sfD9f/L0l5XqrgtFPrxdSWgC0dwkgv/bjX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159127; c=relaxed/simple;
	bh=ljZsqjiCzjONd66uzjO8mOb1LDC5pyqWGa/hk+uKc5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC7ytVG45xmF/ySnMfO1Au2YmmWpxt3PvcV2UcFQqG5EBQFwsDNA42OEyaDcbwnlTGd7lGBorpAcPOqc13nzp/x2geEZv9EVZ/T63G84igxFnsGzQ0fOW/b6pXYZ4Op2tInSjGJiwqkk4G5bnx//7Ellvay6RnZiC3vloX/QKXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=amyQut6Q; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="amyQut6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHeX6POSLcax7qstdDOQ73QVLvd0C0Xmha5BugWqmGv6eaVBJF3wEMzEEBlgv09kidHajUuTK1C89Cb9B0qXvnjTeGP183zW4JOxOZ+/D5gALkMmPj3nqcV1XQZrYaspCRrReO+BJb7XdAiXbQJdplyqqdj+0GrP739VONlYxQTdrogZLPFm7AGjN5lVN1y/kpmMK6BG/hk/eiqOLTYaPzNwQ81R5HN6sXj8p4ZJEUDy1Nq/D8vFyPMULxKK5iR2jaHcZj6L3kQQjEbFCzmZqOHX7TQevh3lLM1R+lV+Hnbj1M5L4VFDq1SO1Hxo4j20trpSBhFdSJ+TG28YyKRcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBO4M5chcKNNY+p3eFudhxxgXU2jrD1IQz73TnSdx3c=;
 b=TpWo9D3wU5Ro+8NO9f1c+x5W1RrzjHseKJuskG1xzo6vvc/93xjmibf+BYN7XbyZIvfm8jrkqrVZAr5qb22LbmMCkUnBpopLEF1X8G9jFqmo8UesentsDAlGAB2Cvo2bRso2VkkRP6tGJs9mqoBYFxX1rMWZYObh+ECgI2fCwzMJ00I7qeQ9/e5nS2Hp+8b0p1A83Lw9zijDLhu+jpixfsSaSS2id59K6BSxr8uS8mO1EOAZedqGWXkFXyrbEMmT/72xukDaMMwJAJohpd38LtMZHaSHQYED0vyu+5QLNXlmaPWlKuiu5Su5Wb3YRV3tVG9Q4DlzDS1N1DbAAb+TFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBO4M5chcKNNY+p3eFudhxxgXU2jrD1IQz73TnSdx3c=;
 b=amyQut6QUpxHSlcXnnv0NlgBlNP2exSPBEoYaOJc+HIXcIvtz1j/0kqiVdK0SzRU8d9ZmIPQgACRG6v6JG3CNrrATpUNd3qDbuoTRR1V8wJWLqw/M0lkYZmYitqHD7Ez5z+swTWnwDmWPgI902euX0FIdvxNm9Z3VEYmz4lWtes=
Received: from SA1P222CA0185.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::11)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:59 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::9d) by SA1P222CA0185.outlook.office365.com
 (2603:10b6:806:3c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:59 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:54 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 21/24] iommu/amd: Add translation DTE and VFctrl TransDevID helpers
Date: Mon, 27 Jul 2026 13:29:10 +0000
Message-ID: <20260727132913.22475-22-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ea1333-8a05-48a4-dfde-08deebe36fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|7416014|36860700016|56012099006|10067099003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IrUQGKslJgk1QKEkhQ98B1q2j39E6WOyQ2SvZQzXBYCdemiZQw/afTxRqTCB/ipZL1pOs2mD8o+6e7R4XsL9YjEL5W25m4SOoh1iIOY/xETgvFNJIUKuafcC/7+FHhrbcQsjCzCOaIAg15dQM4H1ISCNAOtlTuLazYSpf5yK7USyZ6H/3O1mZL2W9sqaQPYK5P/ISo/f9xgxULQIinhVrR6+Dz+reAHIqD3fa5qbm2ti6oz6QEy54b8yTuYfGRDXyHORY8lCirf6uaeyufPZh9TZ9g6Ha9OiFpxQZ7LSDxmCZnh17CuKoWaXq9+xYLO0DIjSl4KRtcFwABfPJVt5kw5c1o7m5ftsldSD+xbn1S0gOOTyoa9o0PCf38dNAmfXAgmfYDHp3TGwf93LCdqtaDaNmYx/5HcImd/JVkcN9/iCE5pCL2ZT4AOSGrGbBcScCVOnrwbV72L9hVe3l/Voai9sgMjYXjwMJmdohE+P27A/xRIhpaVMhfvFZbwJF0iv547TVKNMJPRgBVEi1O4bvjNb7vsTTOZQsVykvWIE3sp82hly/m44aSJtENXDchYS2uNtaMT4nq8Ise1ycRwUcBbNLYzK6QCaKEb/shFIh532l9KvaSGmBAAokmT/MOsAk0VhdsNRp4aDP3vK6LuoaOl2sLYiAyphdrN/wOYXjimjlQ4Jggd0viU+dijTIQm1VzyY8UbhAeBw4FiJy4cm5A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(7416014)(36860700016)(56012099006)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6hNv1bRQnMguvhz5VbR0ZBjIjkTUprjD5KCqDEqJmn2JqgVZb7DV5OvoYcIpwQKYDCTcw+AFJa7HXCN6lFVjNS9gJMQUhIix08ZssGuJY4NPHF0/Ers46s7ts7E86rne8QESMiBov2TwhODQg80s+lFWwETLAls+ZdNaCrQJfs0H72p7oiGWJ+GG6w5Aiv9BMtnfUixVFgMUGhbWA8b8QSBp+7ZFWiLKhFdcWtMHL5Lj0r4fj7Ez/SnD+B0S+6bHmHieDZlxhh7FFn2ZzjwQFYKHBkCn1CQF9fIvTvdu4uRpI072B3Kv+3ybsdGoB/yWoeTm4UNlFbZC6UynDvoNIBy6NhvVhrQ4COxbLLYUm3K0nu+g5OMirobv5w86WtkocqKSjIgbnW1MOM3dio7fW6l9VMfdQjJj8RZhzr5xpAkF+YnqUdXEhGlJ47Jsr040
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:59.6334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ea1333-8a05-48a4-dfde-08deebe36fad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481

The hardware vIOMMU uses a per-vIOMMU translate device ID (TransDevID)
to index the host device table when guest IOMMU traffic needs GPA->SPA
translation.  The VF Control guest miscellaneous register tells the
IOMMU which TransDevID to use; the corresponding device table entry
(DTE) points at the nest parent v1 page table that performs the walk
from guest physical to system physical addresses.

Add amd_iommu_set_translate_dte() and amd_iommu_clear_translate_dte()
to install or clear that DTE for a given TransDevID slot through
iommu_dev_data and the existing DTE update path, restoring IVRS
persistent bits via amd_iommu_make_clear_dte() on teardown.  Add
amd_iommu_update_vfctrl_mmio_translate_devid() to publish the
TransDevID in VFctrl guest-misc MMIO, and
VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET for the register offset.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 ++
 drivers/iommu/amd/amd_iommu_types.h |  2 +
 drivers/iommu/amd/iommu.c           | 82 ++++++++++++++++++++++++++++-
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f61cc51ef9a2..200640ed0ef6 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -232,6 +232,11 @@ static inline void
 amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg) { }
 #endif
 
+int amd_iommu_set_translate_dte(struct iommufd_viommu *viommu);
+void amd_iommu_clear_translate_dte(struct amd_iommu *iommu, u32 trans_devid);
+void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
+						  u16 gid, u32 trans_devid);
+
 static inline void
 amd_iommu_make_clear_dte(struct amd_iommu *iommu, u16 devid,
 			 struct dev_table_entry *new)
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c102d059964a..f288a7b384d0 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -495,6 +495,7 @@ extern bool amdr_ivrs_remap_support;
 /* VIOMMU stuff */
 #define VIOMMU_VF_MMIO_ENTRY_SIZE		4096
 #define VIOMMU_VFCTRL_MMIO_ENTRY_SIZE		64
+#define VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET	0x10
 
 /* Host ioremap/request_mem_region sizes for VF / VF_CNTL BARs */
 #define VIOMMU_VF_MMIO_MAP_SIZE		0x10000000UL
@@ -556,6 +557,7 @@ struct amd_iommu_viommu {
 
 	u64 *devid_table;
 	u64 *domid_table;
+	u16 trans_devid;
 
 	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
 	unsigned long vfmmio_mmap_offset;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6207879528bf..ad592c8aa455 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -213,7 +213,12 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 			     struct dev_table_entry *new)
 {
 	update_dte256(iommu, dev_data, new);
-	clone_aliases(iommu, dev_data->dev);
+	/*
+	 * The dev_data for trans_devid does not have struct dev.
+	 * So clone_aliases is not supported for translate-device-id.
+	 */
+	if (dev_data->dev)
+		clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(iommu, dev_data);
 	amd_iommu_completion_wait(iommu);
 }
@@ -1747,7 +1752,11 @@ static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_
 	u16 alias;
 	int ret;
 
-	if (dev_is_pci(dev_data->dev))
+	/*
+	 * The dev_data for trans_devid does not have struct dev.
+	 * So, it is not considered as a PCI device.
+	 */
+	if (dev_data->dev && dev_is_pci(dev_data->dev))
 		pdev = to_pci_dev(dev_data->dev);
 
 	if (pdev)
@@ -3275,6 +3284,75 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+
+void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
+						  u16 gid, u32 devid)
+{
+	writeq((devid & 0xFFFFULL) << 16,
+	       VIOMMU_VFCTRL_MMIO_BASE(iommu, gid) +
+	       VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET);
+}
+
+int amd_iommu_set_translate_dte(struct iommufd_viommu *viommu)
+{
+	struct amd_iommu_viommu *aviommu =
+		container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu =
+		container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	struct protection_domain *pdom = aviommu->parent;
+	u16 gid = aviommu->gid;
+	u32 trans_devid = aviommu->trans_devid;
+	struct dev_table_entry new = {};
+	struct iommu_dev_data *trans_dev_data;
+	struct pt_iommu_amdv1_hw_info pt_info;
+
+	trans_dev_data = search_dev_data(iommu, trans_devid);
+	if (!trans_dev_data) {
+		trans_dev_data = amd_iommu_alloc_dev_data(iommu, trans_devid);
+		if (!trans_dev_data) {
+			pr_err("%s: Failed to allocate dev_data for translate-device-id %#x\n",
+			       __func__, trans_devid);
+			return -ENOMEM;
+		}
+	}
+
+	trans_dev_data->dev = NULL;
+	trans_dev_data->devid = trans_devid;
+	trans_dev_data->domain = pdom;
+
+	amd_iommu_make_clear_dte(iommu, trans_devid, &new);
+	/* Setup DTE for v1 page table at the offset specified by trans_devid */
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+
+	pr_debug("%s: gid=%#x, iommu_devid=%#x, devid=%#x, host_pt_root=%#llx, mode=%#x\n",
+		 __func__, gid, iommu->devid, trans_devid, pt_info.host_pt_root, pt_info.mode);
+
+	amd_iommu_set_dte_v1(trans_dev_data, pdom, pdom->id, &pt_info, &new);
+	amd_iommu_update_dte(iommu, trans_dev_data, &new);
+	return 0;
+}
+
+void amd_iommu_clear_translate_dte(struct amd_iommu *iommu, u32 trans_devid)
+{
+	struct dev_table_entry new = {};
+	struct iommu_dev_data *trans_dev_data;
+
+	pr_debug("%s: iommu_devid=%#x, trans_devid=%#x\n",
+		 __func__, iommu->devid, trans_devid);
+
+	trans_dev_data = search_dev_data(iommu, trans_devid);
+	if (!trans_dev_data) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	amd_iommu_make_clear_dte(iommu, trans_devid, &new);
+	amd_iommu_update_dte(iommu, trans_dev_data, &new);
+	amd_iommu_free_dev_data(iommu, trans_dev_data);
+}
+#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.hw_info = amd_iommufd_hw_info,
-- 
2.34.1

