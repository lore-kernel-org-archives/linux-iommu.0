Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837047C11C
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760384; cv=fail; b=CRn+WjDhbBPAnaj+kMTyiZC9MCgYGtdIoUl1e9TJMzpPfaVmAv6UZpwKeQN4Z9KkHou0IIvbFOs4BJqdqFSNdOE6gUpBdlANhVThs8xkAL3txhW0G/CJaDEXuOnQsiS0LiC3Ls9xN1m5TRAsKjozo/D0ms36jfLRAtZPyntD88Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760384; c=relaxed/simple;
	bh=VqCvVvBhFqGRqa5TTLJgmTJJjAkVdjFzunZULsvqbNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXdkJKxshiNqhOwAlxT3qzvLQtka0hQ+OLmrs5XIP0nGtHZXG+M2LTG8KPihmVCnAXIyGxwETGO92NwQGmVWgzKWQn4f0jrPTSDS2JvUc3NgO6NgGK1Q62pPylDWhub08gAoeo1+pLDG5N7Kk/olOcd/moTDor18V6U3y3ELunk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mRFvBnWy; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mRFvBnWy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIhlLWuXl1/GxnkdOWnP6Fyfza/0RgYWCwKr3xd+se5i4o+F9AuAcX0vK6kdA1Pdmr8pJkRls/H6rPlpn6crdojeLWKgR/hmGOjlKp2V3MPuml474VojFG2yV942rDgaXCvbXd6WC/Lw3YUM24pYXUNEKzzc8R7UCYAUw1uU4a4aVm6BZB/ISl+XY5l9Nbbke9yZyvWioU4IOd2tM9dj1EC3+XkZdfWzdjE7lcDyscGuMfLeMFuqbPotD2UgInlgPfcSlhOMw7WDGFKajwpDIb1orHAYW3F5j30rm0v3AiC4v+BVnIgguoQdwYgqwEG7Ih5ODyfAXJuZ/nUOAM3iYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LHBU03UiQQ5srjukLkX0SbezWnNvlITvp5xhi2jvWQ=;
 b=qMb0MFggX15p0XAfhg2D50fI8Th42tPd2Ukb1p69+aInSInCB6UMsaQd7jcWfYpj9ViMAATmmFz5yTWFNl7v9KBwN/Hf7/9d161Ewjycf/HxAlhyffhl7RjynezZg2YjvO6pnaf0So7rEKf+q5mLSizL94K22HXYy80uTJ0ktFf9ergLEoFSFzyQUbA6OkI3tDkX+xFaNQmIYWPclX2uVhaJjqOsbsJPkhCPnw2+zPuAZrt89x2Wes/Hu/EmZfJ3QoFggndYYP/Pwn909g6xgK7EtPMsINem0hsD5WYUu3s3QNtyvKYY/mGPMXpDnoeK41T85qlz292sGbUu9ikHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LHBU03UiQQ5srjukLkX0SbezWnNvlITvp5xhi2jvWQ=;
 b=mRFvBnWyW2K+46QnngKzMmdyEQxNpMNXLarNhwdAF2q+7WDesQtX3l7F7lmRNT+5W8tT65haGPHxMA9JTB/xmc/eCGEoAE2S5XHz+nm+JzP61cLVzplkNNjw0FiSWvYrLwlHC8nAAZcyVjTCdXXE07pEXw6acqd+Tcqui+9tJ48=
Received: from CY5PR10CA0021.namprd10.prod.outlook.com (2603:10b6:930:1c::25)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 09:26:18 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::46) by CY5PR10CA0021.outlook.office365.com
 (2603:10b6:930:1c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 09:26:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:26:18 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:26:11 -0500
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
Subject: [PATCH v6 22/24] iommu/amd: Add translate-device-id alloc/free with vIOMMU owner
Date: Wed, 30 Sep 2026 09:23:42 +0000
Message-ID: <20260930092344.5616-23-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: f6898721-9da8-413b-13fc-08df1ed4e20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|7416014|82310400026|376014|10067099003|56012099006|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	skMH2O5aDJOztGBDyiyF/sRVZzvGE0oL5PXeA7S/bjWScjdHKGq3zj9J8vWjJ3Zebf1lO9HK+yX9XjG0lK/jKd17GsEBjwvwu0TXjvHUGAZ+cuBr0VDQa37469m7b3+h25iDryDIBr81p55WhV+UdUTSXv7i7pJ7rL2eBVWV5Ge8WVNCbpuwNcETFBM399DlKrlDAAvVh17GA8CI/EdF6X2vBsctBbLqZbhuhnRAWMixcDtGZvxCluGr8tLJ5SzDzCpOlafFrkJ9IZzvEaAZC7EXT9PKA7AoX8R/h/P8eksKpN5rkXrq9H7wuEqJ4iTBlsBGMgzZqe8Gb5SvSh5BZX7nbWY52MIo0gK6EbCKE6uRPWQSRDZaAgTCDEpXMFnmRPckFqJFTc835OBHCDPtjhpU5l5mn1wdom83CGtsqdDPbWHi/MR2CJY9ztOxExT+Fjs373tH+7AQ3A7tW6qc7iXs+xXV0n0ATWY7ltO/ojvG+vuP3Bv1KngnWjSqYcfFjZyGVhVPZwpt3m3HiNxGQgnxt7dnwITLfEgOxbrWA7NJUmgqxlsFhrcuZgBQWwNtI44p2PYkSmQhFfb/ML8rVpb/ggsNFRn+DL02RLHF7DNKzWJSLiFnQZg+xAJOz8raWFlNuDrOzP6hAr8R4qSKZ75fxD2OZEDWxehkkNlp5RUbQftPUWmZT6yvYGxBRM6ScTzPCtR2pcCZF3dYialbQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(7416014)(82310400026)(376014)(10067099003)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wCDwOMscHAucK6fvYpVfRzHOtzMIc8n40Y9zP+2hZ3PeO14jp3SXWvTJ4lWOl0EYSdRBmzuc10CmNe6chM6LyFVvptCWp1ABwy7SRqb5I0QpUqmjlvOo7HOYX0E6AK9uTyGmnJYoaq5zxjdqkqc2eXpMkc4wedni+2XkPdXxjztLE1U0Ljh/qf7jto3m2s5/OgESpovW/fzIVQPjixzy2+dZjrbWmlRlVEnQVRLBtOgy/oWzb38eQog6oKBnYLsnxOGKNNV3lP+PHZDSuYNcZXEa3VEtSJ0XSPykd9N1G9koxIAuD2xSGgE6y+4RbjmtY4XuCithaHldQdmnRxtP5oyKbt/mrgYe2+hixzdBI5G5nbpcgalU+vbHC4JXP1bff077OHerZYoRbYCYFYxQbohK8CP++Iu5Yi3auM5wK45kl2jIccciLhzS3bKIlaiD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:26:18.3872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6898721-9da8-413b-13fc-08df1ed4e20c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262

Extend the per-segment translate-device-id pool to record the owning
struct amd_iommu_viommu in the xarray.  Add amd_iommu_trans_devid_alloc()
and amd_iommu_trans_devid_free() to allocate ids from last_bdf down
to 0 so each id indexes the device and alias tables, then return them
on teardown.  Free loads the xarray slot and erases it only when the
owner matches @aviommu.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_viommu.h  |   4 ++
 drivers/iommu/amd/trans_devid.c | 105 ++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 44a342608d43..3cf140d6439a 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -34,6 +34,10 @@ void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
 int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
 					      struct device *dev);
+int amd_iommu_trans_devid_alloc(struct amd_iommu_pci_seg *pci_seg,
+				struct amd_iommu_viommu *aviommu);
+void amd_iommu_trans_devid_free(struct amd_iommu_pci_seg *pci_seg, u16 id,
+				struct amd_iommu_viommu *aviommu);
 #else
 
 /*
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
index f51a332fbc72..a63ee5626912 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -28,24 +28,55 @@ static inline bool trans_devid_xa_is_reserved(void *entry)
 	       xa_to_value(entry) == TRANS_DEVID_RESERVED;
 }
 
+static inline struct amd_iommu_viommu *trans_devid_xa_owner(void *entry)
+{
+	if (!entry || xa_is_value(entry))
+		return NULL;
+	return entry;
+}
+
 static inline void *trans_devid_xa_mk_reserved(void)
 {
 	return xa_mk_value(TRANS_DEVID_RESERVED);
 }
 
-static int trans_devid_xa_install_reserved_locked(struct amd_iommu_pci_seg *pci_seg,
-						  u16 id)
+static int trans_devid_find_free_locked(struct amd_iommu_pci_seg *pci_seg)
+{
+	int id;
+
+	for (id = pci_seg->last_bdf; id >= 0; id--) {
+		if (!xa_load(&pci_seg->trans_devid_xa, id))
+			return id;
+	}
+	return -ENOSPC;
+}
+
+static int trans_devid_xa_install_locked(struct amd_iommu_pci_seg *pci_seg,
+					 u16 id, void *entry)
 {
 	void *old;
 
-	old = xa_store(&pci_seg->trans_devid_xa, id,
-		       trans_devid_xa_mk_reserved(), GFP_KERNEL);
+	old = xa_store(&pci_seg->trans_devid_xa, id, entry, GFP_KERNEL);
 	if (xa_is_err(old))
 		return xa_err(old);
 	WARN_ON_ONCE(old);
 	return 0;
 }
 
+static int trans_devid_xa_install_allocated_locked(struct amd_iommu_pci_seg *pci_seg,
+						   u16 id,
+						   struct amd_iommu_viommu *aviommu)
+{
+	return trans_devid_xa_install_locked(pci_seg, id, aviommu);
+}
+
+static int trans_devid_xa_install_reserved_locked(struct amd_iommu_pci_seg *pci_seg,
+						u16 id)
+{
+	return trans_devid_xa_install_locked(pci_seg, id,
+					      trans_devid_xa_mk_reserved());
+}
+
 void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg)
 {
 	mutex_init(&pci_seg->trans_devid_mutex);
@@ -133,3 +164,69 @@ int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
 	return pci_for_each_dma_alias(pdev, reserve_trans_devid_each_dma_alias,
 				      pci_seg);
 }
+
+/**
+ * amd_iommu_trans_devid_alloc - allocate a translate-device-id for @pci_seg
+ *
+ * The trans_devid is allocated from pci_seg->last_bdf down to 0 so the
+ * id is always a valid device-table and alias-table index.  PCI devices
+ * are generally enumerated from the low end of the bus range, so high
+ * ids are likely unused.
+ *
+ * Each vIOMMU receives its own translate-device-id from the per-segment pool.
+ * @aviommu is stored in the xarray as the slot owner.
+ *
+ * Return: allocated id on success, negative errno on failure.
+ */
+int amd_iommu_trans_devid_alloc(struct amd_iommu_pci_seg *pci_seg,
+				struct amd_iommu_viommu *aviommu)
+{
+	int id, ret;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	id = trans_devid_find_free_locked(pci_seg);
+	if (id < 0) {
+		ret = id;
+		goto unlock;
+	}
+
+	ret = trans_devid_xa_install_allocated_locked(pci_seg, id, aviommu);
+	if (ret)
+		goto unlock;
+
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+	pr_debug("%s: Allocated trans_devid %#x (seg %#x)\n", __func__, id,
+		 pci_seg->id);
+	return id;
+
+unlock:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+	if (ret == -ENOSPC)
+		pr_err("%s: No free trans_devid found (seg %#x)\n", __func__,
+		       pci_seg->id);
+	return ret;
+}
+
+/**
+ * amd_iommu_trans_devid_free - return @id to the per-segment pool
+ *
+ * Erase @id only if the xarray owner is @aviommu. A reserved or foreign
+ * slot is left unchanged.
+ *
+ * Caller must hold @aviommu->trans_devid_lock if racing with relocation.
+ */
+void amd_iommu_trans_devid_free(struct amd_iommu_pci_seg *pci_seg, u16 id,
+				struct amd_iommu_viommu *aviommu)
+{
+	void *entry;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	entry = xa_load(&pci_seg->trans_devid_xa, id);
+	if (WARN_ON_ONCE(trans_devid_xa_owner(entry) != aviommu))
+		goto out;
+	xa_erase(&pci_seg->trans_devid_xa, id);
+	pr_debug("%s: Freed trans_devid %#x (seg %#x)\n", __func__, id,
+		 pci_seg->id);
+out:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+}
-- 
2.34.1

