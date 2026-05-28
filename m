Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199C83164B4
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945590; cv=fail; b=qarNh0yiByzaFo4CegPJp2AD2RNmK5mAdzIUPz9NHiXuN+EI+JbusCQj8mAsglvnzZ5gRQGB5whNhcfDE5i/X5k/YmOcP3FnZvxYGa11pq2iH5hljxiSQ9OgLQzqJl6obCIu6EhoEgm3eYvSuxCcVOjCM56EvLdRFjoOld0X5Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945590; c=relaxed/simple;
	bh=T5D+PGUFCjkqxYA5LWS60+0BfFwu87uSSaTjBQxDz4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTCQmyNgd/JtMVidTYUVg4dEY9IJE7Ptz1V/kjMQuYejvKqgF3z69baN0QofXtwZ2tWtEGYNLN7E3naphMjDXVdoUpIXwm2HT6ahORuDiKorhZhlFR7ves6CkYKb5w75xH6snOWUENvnG7fS7E1JzDTpBKGHxm57EBcFlO0vUgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rfXDFQ1I; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rfXDFQ1I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQvOBnt6aQzocPyhzApFjXS1UX2gwXKRPkrIm2mVDFwSbu0wpnEFcgeFQr8bTuM/+FWt3CxhSH/BM6Rk9re4HhqGl3oATNlHAHyoUAEq+tWYqZ1j9nUY/GX4iwkLrmLlgP0HMlQB5DuW/KY1DZCJMxkT6rUZHiTvK+vo52/zvybj8wjYADBIwft08KZbtilzEc8rZzBW4JxxJqu4ce2hirY3Znt3trqc3V19+INaqeSdqdSBMsR3dh4u/3JhZU5IrXFG04zV/FqsR9mptl0MWQxGhIgUZ062EQVMqc7Pih2HlemHNYT8QJ0x5EBzoQeomPsYdFlF3t3IiN9eW3+YwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyjVNi6k0FptJT2iprliP4IZu+50ZQRUBnjY7J2ouO4=;
 b=O49q8THfO1Q9Jme7zNtBZqn5EYK0PcGPpUXHo/xBaD+YT0U1AMAzCizw67CyVTafLOgg5J8xBB+IaFwIL8IEaMZ+LCGZQw0quvx6+YYJnFbMjPFVsfsyWfTqXd7BfE4SRUt+NRPvmikyCPF2fA63XNGyZhBVWglcHk90urqRWqWEzonlpAj1pZxGhOxlHg74ys6Z0ffsHDEWjObsxxTUSYFqSqLao7fi8iGLAL09krPPe5xehyZf4vcPKB8LGqTnL+VKTKfvFk/2niQSXufO9eCVmAcm9W8OMSam68k3ND42u4XqoC0pTNh+szr9j9yCCrv20Uh5CefyhrnsZ8I30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyjVNi6k0FptJT2iprliP4IZu+50ZQRUBnjY7J2ouO4=;
 b=rfXDFQ1Is0nNAzRNJ95tGG+hqXSO6lB+6WwtslG0B8TJteB7Qy+LgSZIuRQL6PkNZjykG0fNTdGgyQ6ZoVYtp/NQ2qTyLDsYzYe4uY2k/vuO4p/ryT5WNWyuquayKzws6ajRSA4HUedrFp7uiTrrmA5Rbc6QC2Y0KWxB8KNXTvQ=
Received: from CH0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:76::22)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 05:19:44 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::2c) by CH0PR04CA0017.outlook.office365.com
 (2603:10b6:610:76::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:43 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:38 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 21/26] iommu/amd: Map kvmfd to shared translate device ID for vIOMMU
Date: Thu, 28 May 2026 05:17:33 +0000
Message-ID: <20260528051738.596013-22-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad5af7a-6c8b-4a7c-06a1-08debc78ba39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7416014|56012099006|3023799007|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KAP1Ik0witLLXnD3JlNj9SxW26YrGBF34kCwQqMuBTBUcHN8qPC2z9kJG+b3dx9usuLiiRSy58EAJt2+eR8mAgQjXRNApWkfvJnFj0TfCNhAV+AlkqPrXfu6w8bmMV89pEV95zZAigyNtCAH7WEKMICv4UlP5CLCOyxTCvfKAVCjBCP0VN+4N+fnvxQeD7nVgxZIrF/G2am1w5LCTZHiNHeE7+KybzzKxFqnhgliXibWopRAw0sHVETm+Ja3hI2V+nVosivvaMArVzx3kz+iyTZ6mCDiTIYLfIinUyXu9VvcfWUW0A8OiiztSofyCbJcawGCSEgIsxK5OUorNR4FRhcfxlqqmOiKmRnpQ7uGNoKg8TG9SUoS9ZUlcHebe14v2YmQ3aqPgfbpOmwLQ/wiK5N8B2dB1RaJuDHqe5pEq5r9xIOLY2xsVE55jUQBkRmzWTwu4ve6PdkP+PcH/o26FCeT1dDQTENJl/QYq1OlM5kzjGV8kM9By6R4nMZncGswpelNOGMaxQBqLSyE2th5cIhbihFwQss1Ks59rNYDCsvvN+P7G3DID8f7AZo2yr3DDlsQF551lvLdvG31AGxQUsTP7bLdYUoJbJa4w8oBtAEMb0/5wWjLMh91Y36jtzlaEJUO2yR7ljo6gkdXgSMvY/kCOwewjWca/6intIu7nfCIWdYCgGfbz4lcFEFDCa1kg+hTY64LHwv5DirMfIYtX7RZpYPaAQ6Vb1HxZO0Is7Q=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7416014)(56012099006)(3023799007)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s8oqUSBN+X8HopAmsT9gYH7Wo5fhF5MV3jWK9ZTxtV2lUC+6q249d2kvbavT28NctfKMBrnU3tF1KbfbXVBP54cIVL+C5VGgWaA9amFHh4KM8oh7RDMaQtEXXScnkZwt2kNoaRL9mgXLonnPDSqnBK/BsEXSEZinP2SDsfo7Nys3aANnP9QcyLtOlza4IoOSEU+YckNd9G5ZayDgFx50az/NYb46aTGPfC5S+7kRjYjTevI1p6lvRwOxXCrpwMUQN1jeGk7tPBDppipQQ39Pe2/rkZDaF153/QXh0wHkHTpF6hD4MpPD8RDB8RcmgFJ9IhvwdXGo+S8jILjZnF+iwpcx2I7XaOU+jKjDiVsR2cyi2G78k/vqZiW9NOVc3vVODlySgSXg7oNPzdoL1b60oDNm+0MBwcbrOK0Z2zLBoE+e+j+8M9W9wpyoEgw2uyvN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:43.9263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad5af7a-6c8b-4a7c-06a1-08debc78ba39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059

Add per-PCI-segment kvmfd xarray amd_iommu_kvmfd_trans_entry with
refcounted so all vIOMMUs for one VM share one translate-device-id and
GPA->SPA DTE.

Expose helper functions:
  * amd_iommu_get_trans_devid_by_kvmfd()
  * amd_iommu_free_trans_devid_by_kvmfd()
  * amd_iommu_trans_devid_alloc()
and extend segment init/fini for the kvmfd map.

Wire iommufd vIOMMU init/destroy to obtain the ID, program the translation
DTE and VFctrl TransDevID field, and tear down on error or uninit. Clear
translation state in amd_viommu_uninit_one().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   4 +
 drivers/iommu/amd/amd_iommu_types.h |  13 ++
 drivers/iommu/amd/iommu.c           |   2 +-
 drivers/iommu/amd/iommufd.c         |  18 ++-
 drivers/iommu/amd/trans_devid.c     | 194 +++++++++++++++++++++++++++-
 drivers/iommu/amd/viommu.c          |   3 +
 6 files changed, 230 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ddfc6329d235..cf2b051948a3 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -223,6 +223,10 @@ void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
 int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
 					      struct device *dev);
+int amd_iommu_get_trans_devid_by_kvmfd(struct amd_iommu_pci_seg *pci_seg,
+				       u32 kvmfd, u16 *trans_devid);
+void amd_iommu_free_trans_devid_by_kvmfd(struct amd_iommu_pci_seg *pci_seg,
+					 u32 kvmfd);
 #else
 static inline void
 amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg) { }
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ffa338c8735f..92c83c68b2b1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -559,6 +559,7 @@ struct amd_iommu_viommu {
 
 	u64 *devid_table;
 	u64 *domid_table;
+	u16 trans_devid;
 
 	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
 	unsigned long vfmmio_mmap_offset;
@@ -621,6 +622,11 @@ enum trans_devid_state {
 	TRANS_DEVID_RESERVED,
 	TRANS_DEVID_ALLOCATED,
 };
+
+struct amd_iommu_kvmfd_trans_entry {
+	refcount_t refs;
+	u16 trans_devid;
+};
 #endif
 
 /*
@@ -692,6 +698,13 @@ struct amd_iommu_pci_seg {
 	 */
 	struct mutex trans_devid_mutex;
 	struct xarray trans_devid_xa;
+
+	/*
+	 * Per-segment kvmfd mapping. The xarray is indexed by the kvmfd.
+	 * Values are struct amd_iommu_kvmfd_trans_entry * or xa_mk_value(trans_devid).
+	 */
+	struct mutex kvmfd_xa_mutex;
+	struct xarray kvmfd_xa;
 #endif
 };
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2f9ca8f2d3c6..2530c8e5490c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3058,7 +3058,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
 	/* Translate-device-id reservation must be done before setting up
 	 * the DTE for the device to make sure that the id has not been allocated
-	 * yet. (See amd_iommu_trans_devid_alloc().)
+	 * yet. (See trans_devid_alloc() in trans_devid.c.)
 	 */
 	ret = amd_iommu_trans_devid_reserve(iommu->pci_seg, dev_data->devid);
 	if (ret) {
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 7c7ef267088b..23a2c8c20365 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -64,6 +64,7 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	int ret;
 	phys_addr_t page_base;
 	unsigned long flags;
+	u16 trans_devid;
 	struct iommu_viommu_amd data = {};
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
@@ -104,9 +105,17 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 		goto err_kvmfd;
 	}
 
+	ret = amd_iommu_get_trans_devid_by_kvmfd(iommu->pci_seg, data.kvmfd,
+						 &trans_devid);
+	if (ret)
+		goto err_kvmfd;
+
 	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
 	iommu_reset_vmmio(iommu, aviommu->gid);
 
+	amd_iommu_set_translate_dte(iommu, aviommu->gid, pdom, trans_devid);
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, trans_devid);
+
 	ret = amd_viommu_init_one(iommu, aviommu);
 	if (ret)
 		goto err_init;
@@ -117,6 +126,7 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	if (ret)
 		goto err_init;
 
+	aviommu->trans_devid = trans_devid;
 	aviommu->kvmfd = data.kvmfd;
 	viommu->ops = &amd_viommu_ops;
 
@@ -126,6 +136,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	return 0;
 err_init:
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
+	amd_iommu_clear_translate_dte(iommu, aviommu->gid, trans_devid);
+	amd_iommu_free_trans_devid_by_kvmfd(iommu->pci_seg, data.kvmfd);
 err_kvmfd:
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 err_mmap:
@@ -147,10 +160,11 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	list_del(&aviommu->pdom_list);
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
-	if (aviommu->vfmmio_mmap_offset)
-		iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 	amd_iommu_gid_free(iommu, aviommu->gid);
 	amd_viommu_uninit_one(iommu, aviommu);
+	if (aviommu->vfmmio_mmap_offset)
+		iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
+	amd_iommu_free_trans_devid_by_kvmfd(iommu->pci_seg, aviommu->kvmfd);
 }
 
 /*
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
index 76450d1735e2..712e0aabcd94 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -2,15 +2,22 @@
 /*
  * Copyright (C) 2025 Advanced Micro Devices, Inc.
  *
- * AMD vIOMMU translate-device-id pool per PCI segment.
+ * AMD vIOMMU translate-device-id management.
+ *
+ * The id must be allocated from unused range. It is used to program the vIOMMU VF Control
+ * register to specify the DTE used to contain the GPA->SPA mapping (v1 page table).
  */
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
 #include <linux/xarray.h>
 
 #include "amd_iommu.h"
 
+static void trans_devid_free(struct amd_iommu_pci_seg *pci_seg, u16 id);
+
 static inline enum trans_devid_state trans_devid_xa_get_state(void *entry)
 {
 	if (!entry)
@@ -29,10 +36,32 @@ void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg)
 {
 	mutex_init(&pci_seg->trans_devid_mutex);
 	xa_init(&pci_seg->trans_devid_xa);
+	mutex_init(&pci_seg->kvmfd_xa_mutex);
+	xa_init(&pci_seg->kvmfd_xa);
 }
 
 void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg)
 {
+	unsigned long index = 0;
+	void *e;
+
+	while ((e = xa_find(&pci_seg->kvmfd_xa, &index, ULONG_MAX, XA_PRESENT))) {
+		unsigned long cur = index;
+
+		if (xa_is_value(e))
+			trans_devid_free(pci_seg, (u16)xa_to_value(e));
+		else {
+			struct amd_iommu_kvmfd_trans_entry *entry = e;
+
+			trans_devid_free(pci_seg, entry->trans_devid);
+			kfree(entry);
+		}
+		xa_erase(&pci_seg->kvmfd_xa, cur);
+		if (cur == ULONG_MAX)
+			break;
+		index = cur + 1;
+	}
+	xa_destroy(&pci_seg->kvmfd_xa);
 	xa_destroy(&pci_seg->trans_devid_xa);
 }
 
@@ -123,3 +152,166 @@ int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
 	return pci_for_each_dma_alias(pdev, reserve_trans_devid_each_dma_alias,
 				      pci_seg);
 }
+
+/**
+ * trans_devid_alloc - allocate a translate-device-id for @pci_seg
+ *
+ * The trans_devid is allocated from the highest id to the lowest id.
+ * Generally, the PCI devices enumerated from the beginning of the bus range.
+ * Therefore, ids in the high range are likely to not be used.
+ *
+ * Return: allocated id on success, negative errno on failure.
+ */
+static int trans_devid_alloc(struct amd_iommu_pci_seg *pci_seg)
+{
+	int id;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	for (id = U16_MAX; id >= 0; id--) {
+		void *entry, *old;
+
+		entry = xa_load(&pci_seg->trans_devid_xa, id);
+		if (entry)
+			continue;
+
+		old = xa_store(&pci_seg->trans_devid_xa, id,
+			       trans_devid_xa_mk_state(TRANS_DEVID_ALLOCATED), GFP_KERNEL);
+		if (xa_is_err(old)) {
+			int err = xa_err(old);
+
+			mutex_unlock(&pci_seg->trans_devid_mutex);
+			return err;
+		}
+		WARN_ON_ONCE(old);
+		mutex_unlock(&pci_seg->trans_devid_mutex);
+		pr_debug("%s: Allocated trans_devid %#x (seg %#x)\n", __func__, id,
+			 pci_seg->id);
+		return id;
+	}
+	pr_err("%s: No free trans_devid found (seg %#x)\n", __func__, pci_seg->id);
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+	return -ENOSPC;
+}
+
+static void trans_devid_free(struct amd_iommu_pci_seg *pci_seg, u16 id)
+{
+	void *old;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	old = xa_erase(&pci_seg->trans_devid_xa, id);
+	if (WARN_ON_ONCE(!old || trans_devid_xa_get_state(old) == TRANS_DEVID_FREE))
+		goto out;
+	pr_debug("%s: Freed trans_devid %#x (seg %#x)\n", __func__, id, pci_seg->id);
+out:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+}
+
+/**
+ * amd_iommu_get_trans_devid_by_kvmfd - look up or allocate trans_devid for @kvmfd
+ *
+ * If an entry already exists for @kvmfd, bumps its refcount and returns the same
+ * @trans_devid. Otherwise allocates a new translate devid, inserts an entry with
+ * refcount 1, and returns it.
+ *
+ * Note: Each translate-device-id is allocated per VM (kvmfd) since there is one
+ * GPA->SPA mapping per VM. In case of multiple vIOMMUs, all vIOMMUs share the same
+ * translate-device-id.
+ *
+ * Return: 0 on success, %-ENOMEM on allocation failure, %-EIO if the map holds an
+ * unexpected entry type.
+ */
+int amd_iommu_get_trans_devid_by_kvmfd(struct amd_iommu_pci_seg *pci_seg, u32 kvmfd,
+				       u16 *trans_devid)
+{
+	struct amd_iommu_kvmfd_trans_entry *entry;
+	void *prev;
+	int id, ret = 0;
+
+	mutex_lock(&pci_seg->kvmfd_xa_mutex);
+	entry = xa_load(&pci_seg->kvmfd_xa, kvmfd);
+	if (entry) {
+		if (WARN_ON_ONCE(xa_is_value(entry))) {
+			ret = -EIO;
+			goto out_unlock;
+		}
+		refcount_inc(&entry->refs);
+		*trans_devid = entry->trans_devid;
+		pr_debug("%s: Got trans_devid %#x for kvmfd %#x (seg %#x)\n",
+			 __func__, *trans_devid, kvmfd, pci_seg->id);
+		goto out_unlock;
+	}
+
+	id = trans_devid_alloc(pci_seg);
+	if (id < 0) {
+		pr_err("%s: Failed to allocate trans_devid (kvmfd=%#x seg=%#x err=%d)\n",
+		       __func__, kvmfd, pci_seg->id, id);
+		ret = id;
+		goto out_unlock;
+	}
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		trans_devid_free(pci_seg, id);
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	refcount_set(&entry->refs, 1);
+	entry->trans_devid = id;
+
+	prev = xa_store(&pci_seg->kvmfd_xa, kvmfd, entry, GFP_KERNEL);
+	if (xa_is_err(prev)) {
+		ret = xa_err(prev);
+		kfree(entry);
+		trans_devid_free(pci_seg, id);
+		goto out_unlock;
+	}
+	WARN_ON_ONCE(prev);
+
+	*trans_devid = id;
+	pr_debug("%s: Allocated trans_devid %#x for kvmfd %#x (seg %#x)\n",
+		 __func__, id, kvmfd, pci_seg->id);
+
+out_unlock:
+	mutex_unlock(&pci_seg->kvmfd_xa_mutex);
+	return ret;
+}
+
+/**
+ * amd_iommu_free_trans_devid_by_kvmfd - drop one reference for @kvmfd
+ *
+ * Decrements the per-kvmfd refcount. The translate devid is returned to the
+ * segment pool and the map entry is removed only when the refcount reaches zero.
+ */
+void amd_iommu_free_trans_devid_by_kvmfd(struct amd_iommu_pci_seg *pci_seg, u32 kvmfd)
+{
+	struct amd_iommu_kvmfd_trans_entry *entry;
+	u16 tid;
+
+	mutex_lock(&pci_seg->kvmfd_xa_mutex);
+	entry = xa_load(&pci_seg->kvmfd_xa, kvmfd);
+	if (!entry) {
+		mutex_unlock(&pci_seg->kvmfd_xa_mutex);
+		return;
+	}
+
+	if (WARN_ON_ONCE(xa_is_value(entry))) {
+		mutex_unlock(&pci_seg->kvmfd_xa_mutex);
+		return;
+	}
+
+	if (!refcount_dec_and_test(&entry->refs)) {
+		pr_debug("%s: kvmfd %#x, trans_devid %#x (seg %#x)\n",
+			 __func__, kvmfd, entry->trans_devid, pci_seg->id);
+		mutex_unlock(&pci_seg->kvmfd_xa_mutex);
+		return;
+	}
+
+	tid = entry->trans_devid;
+	trans_devid_free(pci_seg, tid);
+	xa_erase(&pci_seg->kvmfd_xa, kvmfd);
+	kfree(entry);
+	mutex_unlock(&pci_seg->kvmfd_xa_mutex);
+	pr_debug("%s: Freed trans_devid %#x for kvmfd %#x (seg %#x)\n", __func__, tid,
+		 kvmfd, pci_seg->id);
+}
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index b3150f7bcec3..d2c883e314f8 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -449,6 +449,9 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *avi
 			       VIOMMU_DOMID_MAPPING_BASE,
 			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
 			       aviommu->gid);
+
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
+	amd_iommu_clear_translate_dte(iommu, aviommu->gid, aviommu->trans_devid);
 	viommu_clear_mapping(iommu, aviommu);
 }
 
-- 
2.34.1

