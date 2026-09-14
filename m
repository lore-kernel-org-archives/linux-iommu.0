Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D98358D00
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411869; cv=fail; b=qAUDOJy3clC7QCYv6o8FnTIqv2m50lrH7HBUAPJ+bnNEW6OeR+NqkFINgLgxjN+gfDHzxXXErM+IoT4A6UC+xPuqYdCnVra2MorAGnE4moH3QYJ/onDmeEdmJYDHAYrDe77BW3HR5uaTR7OipAMXtt9Sgil3c2MQ8Gfb9NJZ/P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411869; c=relaxed/simple;
	bh=lX+bNIkEB29tOxrT8AuUvkwVT0h75LHIr20zSMoyisg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLME6e1ajBlWWVwSD9R9Pa56+CbwWGY2t3bV9F8bSls1KBvdZHlbDpze2MeDhkMbpvFDKyqPQjD1he7ULEQPkBLEISXby9m6IRH0UYabqi+zGpSSLCvzDj+sKGsbD+vqUj0gWTyYt75Jdnew3PAMz7RVx7vx+r16yWMmsJDwjDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KwER0iqb; arc=fail smtp.client-ip=52.101.57.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KwER0iqb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U04IXM//I56/OI5dotW/JfiiUzP+4SYzghHlc/E0+W8gAySUlumV4SgUhIUooqox2MEsB/5/rydQ87NbMdjnwICM3ET2RpaaebReFRjVXJboy2UPg3/YLvAJ2UC9fq9N04rKQEuz+8BnpykokpPdths0UM2l8iv0cTDlsGtDLIGiO6PsxMnQis34+Yz6i0L0owkIgkCkIqCXY/Y9OaKWwVcEFaKfZbgHtXjkaZFBQ7o8ut4T4UcsspbFWMyxh7URlXbJ81kRqnFwoTlkLEOnqK9y0y9q6E1DtnCOjhIwIbL83TykMHB+/uKDa5QWEexblE0oj6zDZuIAOTGGTXvLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZJ7ftxYGaOG3hsWiojJHAMiTE7pCVEEYmWBxLJS8Tg=;
 b=T++pnTrC9UBVyEK3/6llDdsaxvbrRWJdQtQIZ6bY3VdJ0uMlZZyCgM6UpuxEeGoASsb0l/bmqIPnYv5RixCxtN0D7p4H+RSlI83mPbRNMlyQXRAHizYkxKD1OFnxIps6t7RSvWiKAYiFVM+SQROljkILqVJE+3IOpAvu8XM1wviomimC3bQ03Cbc0qdY4HrTffDW6cgqJupUUl0xIr9Nw/rcrG2EsvT2nxJrWvSyfrnlsXsk++srX/B1xx3mzBXaYXbQHiVoTfSdF8HDiemvHLlxrCMry+xkXJ4tHdfC+uqHV+P6qTh8gDQBXBBWjWSWcx8A47cVrBgtcOjl0FVdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZJ7ftxYGaOG3hsWiojJHAMiTE7pCVEEYmWBxLJS8Tg=;
 b=KwER0iqbzUJCUOBY4uKdwSrQhFgfcv2LS5p7kBQAxB+OoBauUHshVgm2bSlnEXijmP9/C379GqrhHwIFGcIuL92ZYIF7h4h7D4dfdTez9seCd7+gBQO0xMU+ClhfXtsinLoVtz0OYoxR8ahKPOzWSYyWEz0UOTD8MEVg+cLzFbc=
Received: from BN9PR03CA0189.namprd03.prod.outlook.com (2603:10b6:408:f9::14)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:50:46 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::4f) by BN9PR03CA0189.outlook.office365.com
 (2603:10b6:408:f9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:50:46 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:50:35 -0500
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
Subject: [PATCH v5 24/24] iommu/amd: Relocate vIOMMU translate-device-id on PCI reserve
Date: Mon, 14 Sep 2026 18:47:50 +0000
Message-ID: <20260914184750.222939-25-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 2740c92d-4d7c-471f-6e0f-08df12911623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	E8VzlNapoUOk4Nvbkfxpwdxwt0X+WCCKPywO2oaqzz6pd53Umt+ZjIPzNBYneRvW3SYFB7f29CCpNyjiPtmzlD0tCGj+LQslV/jYYH+41NH9vGua/F6xcRiZIFZFP9sfcXHLFcABNJNe2vnlXl0Jfn6UFI1diBF/+/IwLDgXBrt+NJOwgiQ/Hiq7sSfXDoW5yLJMgX5rN06Y/Sn17MekxfApzLQK8qpHnOTKtt4PKI2Dxj7inX3GySAlQIakMHOBayi4bmGu13DtK91dHWI3oC5gySIcatgDfhOCCxrkubBrpiN5E4+91irKaF2Sw/gQ51YjwBABE6GFcuvet/L9uk4cpMGruYtHsLJ38vj9o33IrTtVekFDACQjJFweo3c8Hmy3SFdeGhu+H1IvOjVVswxs+366A92pFJ5m5CtFXxogEpFLWk5TPvMRNaM7ASll75oJhMyn0tGwApL6qrpwgavHB+7paD4KUEtgMOmZ8+Q8D/c9ewDZbIYRUv31Pgsi0bjoyEr/KtQH+py5dKwbVeg3l4NCKnYDCRh4vOIjiKsL5o4QoFXjFg2ikF6jDD64Fj9ZQ4CQ3vvE8VpLOo3yvW4xA2tx59gcNIo9T5D30QQJo5ZsTC5lJJ99sulukIotkgefNcctnQzNZ1TWvr+9B0Fhnk5nfATHBpkcWfqlYtgWwm9KQ01h4JM/dz5kdgsa1BID/Cd0UfJr09gDul3nhw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ri69uazwq/t8d27yw1GA0W5g38HGq5khyLhgKEgaRpdfDEzLLoLvKqn4MyigELditP8V1MBe35wivpjitie78d7QzouuWIwMBX0aJ02hlWgWEsSBP0ct4w6gzrC9XocGncWRJa60S6Ic7FpXLfFG1hVmygsFyn3aPchh4dkXvMbyYcC2I/8depsTf/BRf2T7eAmkkFwFvaes7k/leyPfVeaJe55a3M5D9Q6TH+gtuXt80La6pZfh2qWYfATyIgAA5Ft+Iz4YYYOG+RNTcxOKQu/f8VqmtChgSGQ+/oAwWFKukBMK8LP6e7coerCmqpNfUVC0uYL1q4iXF1ziTMHiFfJDLfttwJa5tQKkzoN/+JaeD4KL1XvJq03N9hGX+74MEgVBoEmn970qNB4496Tw/swQ6y7yRNxKyxPejLM2m9pBq3RIEnwqsGztCWDV0rPo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:50:46.0392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2740c92d-4d7c-471f-6e0f-08df12911623
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550

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
index 3a4e09fe39d5..785f829db719 100644
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
@@ -96,18 +209,49 @@ void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg)
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

