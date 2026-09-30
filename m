Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBA47986A
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760506; cv=fail; b=ONur24RqbEv9/ytDMHwtGtJdd/N2R0IzVyF7LnUKsk5etXF8y9VFTsB2VAEI/A1rFtegA/+1mGaZ3gOXKhs6G7RMAC6XiVWwJSvTrn3/v7LhZANknfIGBnLPxfDxDOQcebk4PvdMBn7xKaTuBLztFX5xh8I6qDSNEgMB6avthnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760506; c=relaxed/simple;
	bh=UTzI7mU+C7nOhcUqyh7Vb0nREMdLUxG0LwRF1v7awQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoP3pawZ1YV4kzksZtieO3kZwKATA2sUldynKPLzVSv0ARmloAar2wLE099yCgNmZRZreEeZAHrfHz5DL1Px7EGUfMb6Gb+TWlnz/R8bnUXaYcR3la9p5ekyC7Hl2uqRnFJ8Y0j9PzRWGj9hE28U7yNO5qCRpvy1kvGBRiWZ+dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YNG84V/W; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YNG84V/W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oweHLFFi6Tqp6OpjC71yV8ac4hq41E13hB7DmnO2UMby7kFl8NMMHR6Tq6ht4LGuXzixuAhfyviWyk2Eu2y0T4M/jBjNoaPt+l25VesAgyJ2zEd3aNSTJPVTXk1wGdKWrjKKVH3o+axNd9PcUpt1ls2AkeDBExR+eTWDGnaiI5QQ+IoYnHPLF++kOqPA2t0rO1wpeQ8o4Ws1wCGvOOTjd6jEJeN1/2xlApT6MgypVtsXirb4N+WOZr5QugNuFcii/ADoyyrUs+tU9ykTvaImEKKrOc4xyvUpJ2eSZdsRrfy5FW8D6tRhgov6bgfhswEmoqNYTXDIXnNSq/vcgAoJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4edJX/MEZ/51kUOXg6B9O5BGkY7HncE3mI9ZNlTSJQ=;
 b=sp4XQkzut9l65F3fwLQvtEWh5/+mG0qo065vXinCYzIyLxl2sWA0Fr0ePW7FRcNF0qre+Tno+/RxisLlYHdE2vSOXa7OIEiEoz9vbdGirbV0vOOfEl9tshvXE1IrTaIJGcuLuazhyIsh+Q+jhStWHqQTqniRe34KMKn/9OVOZoF+LJqZy4uGrzrB/yTgqjezBUdnJoevbr97+CQHKlivA6CPaHWVv3HFYS93Tk+lYmtUBmKaxfhM36o5F7Ledj02zIwhqh2RYlNCdbjblyKeJwjmZMtbY0zAnSWJp7KtXnfFz4xrgwDgbsU+J/gnOhLVjqY/gwlXCFBdH2D/MXJWKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4edJX/MEZ/51kUOXg6B9O5BGkY7HncE3mI9ZNlTSJQ=;
 b=YNG84V/WoKvqRjRBEWPK/uqLGQ1DAaAA2LSEFbHHjAAT7TcYyYv31yX1Jw/bKFVG9R/t8BIVmlW2XpYq8cgjrppGaDSJIcKmEhMVvCm15TAWaKqtcIPsEzNkc948NuPjQ3yk/zHIibAy0En1JJur3KYB0lpNobe4kRMYKLV7TrA=
Received: from CY5PR15CA0186.namprd15.prod.outlook.com (2603:10b6:930:81::28)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:26:32 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::25) by CY5PR15CA0186.outlook.office365.com
 (2603:10b6:930:81::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:26:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:26:32 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:26:23 -0500
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
Subject: [PATCH v6 24/24] iommu/amd: Relocate vIOMMU translate-device-id on PCI reserve
Date: Wed, 30 Sep 2026 09:23:44 +0000
Message-ID: <20260930092344.5616-25-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7d8e73-d427-40f9-bf3c-08df1ed4ea40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|7416014|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FN6VT8edi46+4CgYyfVEyQD+nVMCIGhAY5uTlyk57uYOeUD4xz8uTdrWHNVldRzpHWGDoxOjyPtMOGFk3VPBVb405q9EshQZyUm7zFkpIaQC/3izM+rbb0GP5CRTYAfeKr75U6CL2NpiggSVkNm8GtuqRdc5zgdc7Fdqd3NEJm6kjL4ErBldz45EImGfidwgRYNLHyjgQ9rkKhSVJ3XJhm7AEd58aJcyOXgcJIb5NGFxIup+mnEI/aWY0aUjBe0ZMCUNydpz+Hk/M2cmsjHC9J4aJHvg0uhAx1azfV+fffKDQibXQYInUQeeVEhVakHJvrixIl/71iRb6H3GgLNqkhPxhialZEmVHgWUQpTzzNiRmVmeFZ6CkNQjcdUJob+TVa/ZGbt3s915lBJOEpD9lk2jsoIZEaR13VCUXI4cIbfkNuIh2V3X4FMSn6y/R6oGMHCKrs7TY5bQDoHSonGIZRcAVXIsK8WgE2JK31+jnIIJEwrWYzv/PURL6cO5SiMBEA4lltWG7OBA5RrlHx4AnhXhDPtjkeCuYAkVilKyXuVaer7UUaxM0f3i974PHzNOu3AC1Lp67Nd230QNbi6eCDLx90ZE75CV/UlApR3s6chrjg1mNC4z+3PXuSgvB09SXLNDj6epukntz1Z0ePw93rLd/KVxvP019pMmLbITr4/3rcYEvE7RIBEWENEK37AWospzO0R79G29mbisptcLrw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(7416014)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QXwh8oxr+8NEYTcv0zIZMggQFa6MG7g9edapIfVYZegbmRXoMP9Myqa8reBLMb5i1vzb1x0Swu4x4OMOKOaoCdtHNsPMC6qhYGeRhGXhPfJjQ8HxBeivFfyEgS9C+hwu0GmIgkiACKt0dKQNojq4v31LEiD0xNXmo95TDwcQCggnfqF3n2vFzpwsMQzXHAHmkN9XqWBpWnm+9ViJkF48ddU82EPltuwvFltk/YeCr8bhZs2UPJGFPZRvBZesOo5GpXNI+rkIfiueMI8NZd0I+aQ1eGUH3aNJz1cpgzMZigLeGOVBw8fMW2SnAiMi97KxiVdcjObW5NTjKS96Hv2EbZW2QIOyuDncTrSkOig+oETpknJVl6ASvpag7SbaokzI5mT0SeVSPO3fgRQrfIJJRt9e3DJzZuxur69o/zJLo5/y+kR5lplyno/sysA0NEgE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:26:32.1564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7d8e73-d427-40f9-bf3c-08df1ed4ea40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971

When PCI probe reserves a BDF already allocated to a vIOMMU, relocate
that vIOMMU to a newly allocated translate-device-id before marking the
BDF reserved for the device. Reserve holds the segment mutex and
trylocks trans_devid_lock so the vIOMMU pointer stays valid without
reversing the nested lock order. Reprogram translation DTE and VFctrl
under trans_devid_lock; roll back the pool on failure.

Mark from_id reserved with a raw xa_store so ALLOCATED->RESERVED does
not WARN on the non-NULL owner. On MMIO failure, restore from_id the
same way (RESERVED->owner) instead of install_allocated.

Reuse the vIOMMU's trans_dev_data object. After programming the new
slot, clear the old DTE without freeing the object.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  10 +-
 drivers/iommu/amd/trans_devid.c     | 146 +++++++++++++++++++++++++++-
 2 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c748bab27509..347c6954439d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -558,11 +558,15 @@ struct amd_iommu_viommu {
 
 	/*
 	 * Serializes this vIOMMU's translation DTE and VFctrl TransDevID
-	 * updates on init and teardown. VFctrl TransDevID is not written
-	 * from amd_viommu_uninit_one().
+	 * updates on init and teardown against PCI-probe relocation, which
+	 * may reprogram the same registers to a newly allocated id.
+	 * VFctrl TransDevID is not written from amd_viommu_uninit_one().
 	 *
 	 * Nested lock order: trans_devid_lock, then
-	 * pci_seg->trans_devid_mutex.
+	 * pci_seg->trans_devid_mutex (same as destroy). Relocate drops
+	 * the segment mutex around the MMIO updates. Reserve holds the
+	 * segment mutex and mutex_trylock()s trans_devid_lock so the
+	 * aviommu pointer stays valid without reversing lock order.
 	 */
 	struct mutex trans_devid_lock;
 
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
index a63ee5626912..e844afe6da77 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/sched.h>
 #include <linux/xarray.h>
 
 #include "amd_iommu.h"
@@ -89,6 +90,118 @@ void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg)
 	mutex_destroy(&pci_seg->trans_devid_mutex);
 }
 
+/**
+ * trans_devid_do_relocate - move vIOMMU translation DTE from @old_id to @new_id
+ *
+ * Caller holds @aviommu->trans_devid_lock.  Pool xarray already records @new_id
+ * as allocated to @aviommu and @old_id as reserved.
+ *
+ * amd_iommu_set_translate_dte() cannot fail here: trans_dev_data is
+ * allocated in the same trans_devid_lock section as the xarray owner
+ * and is only cleared with trans_devid_free(). A later failure after
+ * the new DTE is programmed must clear that DTE before the pool drops
+ * @new_id.
+ */
+static int trans_devid_do_relocate(struct amd_iommu_viommu *aviommu,
+				   u16 old_id, u16 new_id)
+{
+	struct iommufd_viommu *viommu = &aviommu->core;
+	struct amd_iommu *iommu =
+		container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	int ret;
+
+	aviommu->trans_devid = new_id;
+
+	ret = amd_iommu_set_translate_dte(viommu);
+	if (ret)
+		goto err_restore_id;
+
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, new_id);
+
+	amd_iommu_clear_translate_dte(iommu, aviommu->trans_dev_data, old_id);
+
+	return 0;
+
+err_restore_id:
+	aviommu->trans_devid = old_id;
+	return ret;
+}
+
+/**
+ * trans_devid_relocate - move an allocated id to a new slot and reserve @from_id
+ *
+ * Called when PCI probe needs a BDF that a vIOMMU already owns.  Updates the
+ * per-segment pool, then reprograms DTE and VFctrl on the owning vIOMMU.
+ *
+ * Locking: caller holds @aviommu->trans_devid_lock and
+ * pci_seg->trans_devid_mutex.  Hardware steps run with the viommu lock
+ * held and the segment mutex dropped.
+ */
+static int trans_devid_relocate(struct amd_iommu_pci_seg *pci_seg, u16 from_id,
+				struct amd_iommu_viommu *aviommu)
+{
+	void *old;
+	int new_id, ret;
+
+	if (trans_devid_xa_owner(xa_load(&pci_seg->trans_devid_xa, from_id)) !=
+	    aviommu) {
+		ret = -ENOENT;
+		goto unlock_seg;
+	}
+
+	if (aviommu->trans_devid != from_id) {
+		ret = -EINVAL;
+		goto unlock_seg;
+	}
+
+	new_id = trans_devid_find_free_locked(pci_seg);
+	if (new_id < 0) {
+		ret = new_id;
+		goto unlock_seg;
+	}
+
+	ret = trans_devid_xa_install_allocated_locked(pci_seg, new_id, aviommu);
+	if (ret)
+		goto unlock_seg;
+
+	/*
+	 * Replace ALLOCATED with RESERVED in place. install_reserved
+	 * WARNs on a non-NULL old entry; do not erase first or a failed
+	 * store would leave from_id FREE while hardware still uses it.
+	 */
+	old = xa_store(&pci_seg->trans_devid_xa, from_id,
+		       trans_devid_xa_mk_reserved(), GFP_KERNEL);
+	if (xa_is_err(old)) {
+		xa_erase(&pci_seg->trans_devid_xa, new_id);
+		ret = xa_err(old);
+		goto unlock_seg;
+	}
+	WARN_ON_ONCE(trans_devid_xa_owner(old) != aviommu);
+
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+
+	ret = trans_devid_do_relocate(aviommu, from_id, new_id);
+	if (ret) {
+		mutex_lock(&pci_seg->trans_devid_mutex);
+		xa_erase(&pci_seg->trans_devid_xa, new_id);
+		old = xa_store(&pci_seg->trans_devid_xa, from_id, aviommu,
+			       GFP_KERNEL);
+		if (xa_is_err(old))
+			ret = xa_err(old);
+		else
+			WARN_ON_ONCE(!trans_devid_xa_is_reserved(old));
+		mutex_unlock(&pci_seg->trans_devid_mutex);
+	}
+
+	mutex_unlock(&aviommu->trans_devid_lock);
+	return ret;
+
+unlock_seg:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+	mutex_unlock(&aviommu->trans_devid_lock);
+	return ret;
+}
+
 /*
  * amd_iommu_trans_devid_reserve - occupy @id so it is never returned by alloc
  *
@@ -99,18 +212,49 @@ void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg)
  * It is not released from amd_iommu_release_device(); the slot stays
  * reserved for the pci_seg lifetime so replug cannot race later alloc.
  *
- * Return: 0 on success.  A second reserve of an already-reserved @id succeeds.
+ * When @id is allocated to a vIOMMU (e.g. after PCI hot-plug), the driver relocates
+ * that vIOMMU to a newly allocated translate-device-id and reserves @id for the PCI
+ * function.
+ *
+ * Return: 0 on success, %-ENOSPC if relocation cannot find a free id, or another
+ * errno from relocation.  A second reserve of an already-reserved @id succeeds.
  */
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
 {
 	void *entry;
+	struct amd_iommu_viommu *aviommu;
 	int ret = 0;
 
+retry:
 	mutex_lock(&pci_seg->trans_devid_mutex);
 	entry = xa_load(&pci_seg->trans_devid_xa, id);
 	if (trans_devid_xa_is_reserved(entry))
 		goto unlock;
 
+	aviommu = trans_devid_xa_owner(entry);
+	if (aviommu) {
+		/*
+		 * Pin aviommu with trylock while the mutex still covers
+		 * the xarray pointer. A blocking lock here would invert
+		 * the nested order (ABBA with destroy). Dropping the
+		 * mutex first would UAF if destroy frees aviommu.
+		 *
+		 * No retry bound. cond_resched() avoids a soft lockup;
+		 * progress is this owner dropping trans_devid_lock or
+		 * freeing the slot.
+		 */
+		if (!mutex_trylock(&aviommu->trans_devid_lock)) {
+			mutex_unlock(&pci_seg->trans_devid_mutex);
+			cond_resched();
+			goto retry;
+		}
+		ret = trans_devid_relocate(pci_seg, id, aviommu);
+		if (!ret)
+			pr_debug("%s: Reserved trans_devid %#x after relocation (seg %#x)\n",
+				 __func__, id, pci_seg->id);
+		return ret;
+	}
+
 	ret = trans_devid_xa_install_reserved_locked(pci_seg, id);
 unlock:
 	mutex_unlock(&pci_seg->trans_devid_mutex);
-- 
2.34.1

