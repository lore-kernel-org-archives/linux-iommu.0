Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807433E51F3
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747710; cv=fail; b=Ju0wrp9X50n3hOBimYo+mgyTs7tFXOji3iFHBQbgWcNIZ/xtkxt56hsFQ1PTvIBSCT7Y57jSS2pnCG0RloDaZYFR8R4PnvjIBRsf1HpTgfR9UPYgcAcYlusV10PdRO62E7Ru9wETQMDrGZPHpXbmrGFdwCxhVVcDJCFezTayc80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747710; c=relaxed/simple;
	bh=7kVFxLHr3ahap66Bnb6OzVvZCAIOOQIqeoYT4X9B4cY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7qwVpLUsDgWcIpwSVpUBPKTtK3V4BEPE5Je0OXsFsgNdWtgslLjlXYFYIenLOgeEoUU3TlaVtyj9XNctmjBzuWa8Q7xFixcFfu4gUYlxGwb29XFEICSGglrfsXyiO0ZX5KV2pqQfJWXIizZmiV98htJikUIkBIwBjQ9YZM90PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0nSW0Rjk; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0nSW0Rjk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkp0zjb9ZhMAU2cnd1l7W1FlFlkP2Zl4CH62OQu/Y/u080d9KT5bQxplDtXdbxV05n6fLsN/qE9kA8KTpwp3XZC1apJHTh1tHV87jDssom/xs5EFV4hHeab1PIYdl3+WLdKTdiAOqtbhYEWTcqIJ7FsJWLL3FT/pk7mQpaz70QnUbFQ7yYwtN1Uj/m2y7K8siUGMbRg7shjx7q6CtoQeLQ/899MFdjGMAh181SsIuIJuJFCInS9gb1Pp5GWo137ftnfTKFe0Wx9EsdcFWWT4TG/L5Bnk8Ng4wHZcdia8c1P8WXySWgsq8q1U8vIKTkynLQD3GDhlt+tZeiWctlVRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+wS1B54GPSdJdIUZcRqJlw5GpEnewktmSI5zL7WQaM=;
 b=Hpt97kxz34b1PDg/M2zFUrI76GCW0bCpwEikBVnhLSAzIEgag8XWohkp4vQoL74c1aI/BvAg15fhUYC2gelqFn9q88ym+jgDKmUxCR6XqoLCdqborCyHrRv1GgD2CScy2P5TO2lAarNMGbaG927ysN3HwzVI9nVgrBdYM5vELl8ahtfB5zQEAPcz5VGyFfJ59azeBxM63c/9jTIJNSkwQlv1vS7iIDK50oFoICiIizsxX7yEcmQ8HLqVSxVeX+HEwOPGpLfwRfOManLtI3uR8IK2azHZbhABpVbFMwnnRLTGpujrLXG12oKQh6kSLkyk1obp9wIh28Q2BDQmzk1A5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+wS1B54GPSdJdIUZcRqJlw5GpEnewktmSI5zL7WQaM=;
 b=0nSW0Rjkl+Iv6EMWVTRMNnIhIa/NWfQV369Lj67BCPET0Yll5P2BhHByBwm2+uvr57DLlINiH4GC+5m6rLnH4DQuHKoNKhyP/di2FhNgcDLZfPvIIQlxp8Q1TnQzQMflnIE3QCEMU39JdNIQD6UEYpGY9MPJ2D7bOLzc1i6oh10=
Received: from BN0PR08CA0012.namprd08.prod.outlook.com (2603:10b6:408:142::34)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:41:41 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::61) by BN0PR08CA0012.outlook.office365.com
 (2603:10b6:408:142::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:41:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:36 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:38:52 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 22/22] iommu/amd: Assign per-vIOMMU translate device ID
Date: Mon, 29 Jun 2026 15:35:35 +0000
Message-ID: <20260629153535.15775-23-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 7212bd87-9c75-4555-b915-08ded5f4ea44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|23010399003|376014|1800799024|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	REyug4/TZjuWeJtzMnGJsVtQEy/PxW2Ho7+b1WNaUfEpqBihfOz3hG9GFuje5+HyCAoVHlNSJ8mFqYb9QgNjh8zq6ti2yKYOebmwHatxsWyX4TeytN+Olrc9V4RQUIeXjKj4ySyNanBRwExNqAdTMf5prdYs7nKBr/NbNz9cvnvyXdFqn7gk9M04Y2C6p6t2XNW4YoYpuLSV8tZe8kDSRL/BN9meLFpg8L4TRGr8HNAstkmQmm7+EKMNK1dbbOEm6jLfAExixA9IqcXQQL0dCFu9qAES1RMvXAf84J/fwAtLndj4f5Hoqr8Fe7x5X0JM5/jXfB5tYtNLyRAS3viZzpY7lnPbQfshnw1IYvY/z8U2bleXAUSRpWr8lRCwld6JokowVeR8MlIkGe60jTbYKR8pBwHtu8ZofqJ39b1FVJ0z82dYHacKFJMjK0YjkLuNE4TuyDoH/VXdS4OilYwsYl2K0Bx65MwvLmn8DXdZVTYYeUF21vWs8Y+mq+HgFfir/VsO0RjXddspYx24HayLw5PhgDQFx3BRZHG1TtIQ/AIDcxyjg/kZv/p7ptt+SxYYgAJfjyy06+CpAVGoZp+5D377HB495c5/vh+baEX5lwtnP/4o8patq3vANkGh1otrMjqgHHBKtsiDD4bsQQBBvuoj8ara9lr4zx1jgiW4h1cjJFDVS1DtJ2qV+BUehkxPwuAF6RRL204+0te4Lk19rA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LnGGvIyrWPVwcXySjKXYe9ZtY5v1JlYSMLIdSyAWYHNYP/V3OqUp/aYK019WoKU3PnejLky4CKvXgmiRYi5XOpRJMd95notptijPlh10xVC9IZHpzV4cLsi1wkcWLGkigZZybY0H7i0bN3Piny5kQmT5jbOSMuFG52T4xscaTun4W1T5B9SDUFCXSewd5RDvfyu2f4zkTYsvBKOLlPB/Bw4JrPt4WT3Al5Eut2W5qUbMEpIDL6Q6B9KRjVQrnYNHPqLjKSuIQxJzyAkPP3HiV5Nt4F2oboOgm38oC/C8zx1G5pLYIgb4WlPplO7nnV5H1Q9MKhky2VxalNjH2CkRnnHBH5lIsvp8Thv6bJJZW03XkKpcGHIDv7NmvEj1h+a9iGFh9p0m9CwXpcPieM7W38DdkPxioCuk7oEt/UtQe8k2ZCy7AchTctYivDifSJXm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:41.1885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7212bd87-9c75-4555-b915-08ded5f4ea44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140

Allocate one translate-device-id per IOMMUFD vIOMMU instance from
the per-segment pool. Program translation DTE and VFctrl TransDevID
on init; clear both on error and destroy.

Each vIOMMU owns its trans_devid independently.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommufd.c         | 25 +++++++++++++
 drivers/iommu/amd/trans_devid.c     | 58 +++++++++++++++++++++++++++++
 drivers/iommu/amd/viommu.c          |  2 +
 5 files changed, 88 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7300f07e7a39..f0293d636718 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -225,6 +225,8 @@ void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
 int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
 					      struct device *dev);
+int amd_iommu_trans_devid_alloc(struct amd_iommu_pci_seg *pci_seg);
+void amd_iommu_trans_devid_free(struct amd_iommu_pci_seg *pci_seg, u16 id);
 #else
 static inline void
 amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg) { }
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index cd10e33c1317..1090d7796ce5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -557,6 +557,7 @@ struct amd_iommu_viommu {
 
 	u64 *devid_table;
 	u64 *domid_table;
+	u16 trans_devid;
 
 	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
 	unsigned long vfmmio_mmap_offset;
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 8b569b469a07..0d80eaeee662 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -48,6 +48,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	int ret;
 	phys_addr_t page_base;
 	unsigned long flags;
+	u16 trans_devid;
+	bool trans_devid_allocated = false;
+	bool trans_dte_set = false;
 	struct iommu_viommu_amd data = {};
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
@@ -81,9 +84,22 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
 
+	ret = amd_iommu_trans_devid_alloc(iommu->pci_seg);
+	if (ret < 0)
+		goto err_trans_devid;
+	trans_devid = ret;
+	trans_devid_allocated = true;
+	aviommu->trans_devid = trans_devid;
+
 	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
 	iommu_reset_vmmio(iommu, aviommu->gid);
 
+	ret = amd_iommu_set_translate_dte(iommu, pdom, aviommu->gid, trans_devid);
+	if (ret)
+		goto err_init;
+	trans_dte_set = true;
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, trans_devid);
+
 	ret = amd_viommu_init_one(iommu, aviommu);
 	if (ret)
 		goto err_init;
@@ -102,6 +118,13 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	return 0;
 err_init:
+	if (trans_dte_set) {
+		amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
+		amd_iommu_clear_translate_dte(iommu, trans_devid);
+	}
+	if (trans_devid_allocated)
+		amd_iommu_trans_devid_free(iommu->pci_seg, trans_devid);
+err_trans_devid:
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 err_mmap:
 	amd_iommu_gid_free(iommu, aviommu->gid);
@@ -124,6 +147,8 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	xa_destroy(&aviommu->gdomid_array);
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 	amd_viommu_uninit_one(iommu, aviommu);
+	amd_iommu_clear_translate_dte(iommu, aviommu->trans_devid);
+	amd_iommu_trans_devid_free(iommu->pci_seg, aviommu->trans_devid);
 	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
index 7c57087bfa10..6dd291d63607 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -126,3 +126,61 @@ int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
 	return pci_for_each_dma_alias(pdev, reserve_trans_devid_each_dma_alias,
 				      pci_seg);
 }
+
+/**
+ * amd_iommu_trans_devid_alloc - allocate a translate-device-id for @pci_seg
+ *
+ * The trans_devid is allocated from the highest id to the lowest id.
+ * Generally, the PCI devices enumerated from the beginning of the bus range.
+ * Therefore, ids in the high range are likely to not be used.
+ *
+ * Each vIOMMU receives its own translate-device-id from the per-segment pool.
+ *
+ * Return: allocated id on success, negative errno on failure.
+ */
+int amd_iommu_trans_devid_alloc(struct amd_iommu_pci_seg *pci_seg)
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
+/**
+ * amd_iommu_trans_devid_free - return @id to the per-segment pool
+ */
+void amd_iommu_trans_devid_free(struct amd_iommu_pci_seg *pci_seg, u16 id)
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
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 7b3127d829c5..e38d919dcec3 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -509,6 +509,8 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *avi
 			       VIOMMU_DOMID_MAPPING_BASE,
 			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
 			       aviommu->gid);
+
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
 	viommu_clear_mapping(iommu, aviommu);
 }
 
-- 
2.34.1

