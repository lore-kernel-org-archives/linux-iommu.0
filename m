Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D653672A8
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182585; cv=fail; b=F8GNqVZRzRTLaFwzZDWGj8XznXE4wzP9buVTs1VnfHljd9w1Iy7WBgSayGY1Q1nEgtn7y3phkr2mHtAogZ83u4UJLPlHrPLD9l7jkdH/CqNJRLKm75mroSrIHDm/70kT4VvHBTPtoNnJRCik01DNj9lOKmBQ63HBr98OtoWbN/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182585; c=relaxed/simple;
	bh=itwOAFFlRFbOZMZeUtUpIwYVhhOavwA45e/RsVq7LHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTYCk7B5Lm109Whb3xNAQaGhTEkMXnV6iTR3vvacQpvqxgzNTkxhVEThkaFTvw7W4oWAHANhQV2C6keHRfBQBfUxqP/0ihvK/zFYR9257Ho7MonSnFtJ82UTQUrP0DWHkx3jh8xa5BGwBxOAEfkSUNiCgvXyO25LHmFh3EY+ZL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RSy0aK7D; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RSy0aK7D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0/az2oNS7gM4sN51zm6rJn0+NUf9UfVn1Yh/V3IJ4NEdRkBrG7RvEY5HA4jq38ge6mkhZJo5+k4VcF2SsUG3To8O1WOoNgFde5cWWGCKLoeFgKmqiec4LT1hOu+wMytHUvcDuDzTC/SQrbOLrUVX0PZNHk+0scyZJ1mA8rpKIcYhVIzfm7SleaXi7l3VnuPExfBvGsCNflisMxBFe0xwqjkpSZ2xkAHBsdESwC99ZzK+5xZJnfZwyxo1VLnpYSccw091PvzcspfwJi7I8wCpoIoi7sUA5OZNUiILXqCronQZs48lxeGQNgyf2EBfVayfU1C/WgN9+z4z5X7mAGDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/RbVZpVdpKgZdzpy0VeT/U4Pg6dvpQP/ByuVMdUbD0=;
 b=EuEMBYvTquJKeN0JG7e/Hm4v/tSIUTVuipE5V7ocYPGuWBDKQ7OcjFgNA5Mf4o6tVNOXM5TtYOjeA43+A0/KrffsdglFlGq6XFkUIVJBvIrDBTLOZbsAFduN9/7kuOTcNDly6huHHcL2YTIB9AXYVKpvnWZ2c1Chimm1hoWGd7CNbrKKDf5sh4NF2xJtUCHxCwZdNuTvzylQwF6/WD9VC1Y5iF7Gk27gi8xwwEJvPIxSKUt3dWQjvb4NPKtZARvFNcMNrUuVgE3rPI1A0YOMtXAzGeQuVdRD9Ayq9Kfcm6a0g+xHF0wVdWe4CXEd4Wy4EN2d4ig3BcZ4MWz4QP3jzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/RbVZpVdpKgZdzpy0VeT/U4Pg6dvpQP/ByuVMdUbD0=;
 b=RSy0aK7DAlBO8KW1jeNWzn0VeEsBVRNyVcsU9jedwTlW6lHz0ek9BVL6UaMR2KRxOAdYiHUDjcuCjojaCy8XUUwWZ/ExGSEKzi0stNgGGWfFNE35Q+Z1eK09dKqEAIlZogenQcqLA5/uvhIMgtgOocFk+zllNoUcSjbAhkPH3b0=
Received: from MW4PR04CA0244.namprd04.prod.outlook.com (2603:10b6:303:88::9)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:42:57 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::8) by MW4PR04CA0244.outlook.office365.com
 (2603:10b6:303:88::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 06:42:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 06:42:56 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 01:42:48 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<jgg@nvidia.com>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<robin.murphy@arm.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, <pasha.tatashin@soleen.com>,
	<rppt@kernel.org>, <pratyush@kernel.org>, <skhawaja@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<kevin.tian@intel.com>, <dmatlack@google.com>, <vipinsh@google.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 6/7] iommu/amd: restore preserved state on a live-update boot
Date: Mon, 5 Oct 2026 06:40:16 +0000
Message-ID: <20261005064018.1558-7-Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005064018.1558-1-Ankit.Soni@amd.com>
References: <20261005064018.1558-1-Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d34347-7c34-4cb7-41d9-08df22abe415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	8+N/rpAPaCs6e7dXslDqz05LU4u7ehHULwburScYkPos3RPAzZvzRWMhNrz934loqeShpcfrMNYB+w9Ogu8sdlUqF2JYYuQK7RsZyO110roRz5/gpLGjeUfuNE0VDONPBePVOT0cT8prVznj1YSXg3NqbfBayP29B3ODZKiHHKL795YVS7cPYem6LtlHj+P582vJASEqtMbjq+ZhqmvMd1d8GvE3NT7viOiVg9lwPgcDVmgUoJHM2k8NxwScfKSTDAz4CksK/6jtvAEbSBJh1gLTbaInzWj+TnAlO/8KUqRM1DOcZSVHLkkL7bhP7PPDCoOZMt0j7OslrS7P8P9y7aRiXRRdzWZ7OistOBSw+sdn1oab5rkEyBeWE04EYb6sb9W+CiH1W4bf5e30xYXRR6TtC3JXsAVZmzfWDXz0knzZOmdjgZsfNWgMcAsXsGB11VRr/Y0WLpjYCkJ0zmVJuXFrRUP2hgDB/hOErjD9v7V/SeE3gde1btq+34uDmm+mm3VWHowrFDU87jDAIDy4v1dSiUVNCGjLIsvnwSv3OBGCWqvFtja2DKfwkc4lTO9o4288Qs/lfIwVeBuw+7T9htQDXfGYkP3XYo4fENArCOrDvzFyeV4x8OX1gM8YAQir1QkWqSHQyqJjAdppe04ABlqlPPBkuIXjTJhFJe0oW29IuCWq0cDkJ6CIaABBahnu72jSa2XWJYF8pN+0GLNg9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I11i7zuUNSBiAIBBrKbCzF0ZnD/t+MWhP3mXMUsykBVbcSFk8aAXFb6DCC5VCWTbhYcrzntUzjIh3ZeObyxUn37saYKeHl5mL8seLYDSeJjoa1kchoOnS/REv5jtpg0gUCGO4tgxc3omhU9cryNRlSBNy05Ke/rnCHgpBYIoVhifpfi07bMMjEVmM9KFYh3J9r/yZFz5Pc6TjZie1ahANZ+IZb8jHkl1F18F28u/tWCO92DSFrciiOiddeKwKQkoeZQNtVn1Ev06PIZnkMRP1tOZ9B1dM8uBwibAlS44lXSqmWH8JHqAsKjwDJrFXe6bhxOP2JO3/pWmzv8OphAIgoBrJM0MI0ELRL28SeQuWayhJL1OMT1K2KsnS7yx5JXyyBfjSoDtg32MZYqX4PQoXNNWZd6ETKR8NWRI6w0EG/fWLgu5eLw5pULx0hq3gHVj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:42:56.9862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d34347-7c34-4cb7-41d9-08df22abe415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922

Adopt the preserved device table for the PCI segment instead of
allocating a fresh one, and reserve the domain IDs it already carries so
a domain allocated by this kernel cannot be handed an ID the hardware is
still tagging cache entries with.

Also stop clearing the enable bit on a unit that was handed over
translating. Doing so would drop its devices into untranslated
passthrough while their DMA is still in flight.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |   7 ++
 drivers/iommu/amd/init.c       | 165 ++++++++++++++++++++++++++-------
 drivers/iommu/amd/liveupdate.c |  33 +++++++
 3 files changed, 174 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 4402724bfd06..ac6d7a17eb40 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -237,9 +237,16 @@ int amd_iommu_preserve_device(struct device *dev,
 void amd_iommu_unpreserve_device(struct device *dev,
 				 struct iommu_device_ser *device_ser);
 void amd_iommu_clear_unpreserved_dtes(struct amd_iommu *iommu);
+void amd_iommu_restore_dev_table(struct amd_iommu *iommu,
+				 struct iommu_hw_ser *ser);
 #else
 static inline void amd_iommu_clear_unpreserved_dtes(struct amd_iommu *iommu)
 {
 }
+
+static inline void amd_iommu_restore_dev_table(struct amd_iommu *iommu,
+					       struct iommu_hw_ser *ser)
+{
+}
 #endif /* CONFIG_IOMMU_LIVEUPDATE */
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3b46d46f7143..8aba3b715a02 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -33,6 +33,7 @@
 
 #include <linux/crash_dump.h>
 #include <linux/iommu-liveupdate.h>
+#include <linux/kexec_handover.h>
 
 #include "amd_iommu.h"
 #include "../irq_remapping.h"
@@ -1135,14 +1136,42 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
 	dte->data[i] |= (1UL << _bit);
 }
 
-static bool __reuse_device_table(struct amd_iommu *iommu)
+/*
+ * Reserve the domain IDs the previous kernel programmed into the adopted Device
+ * Table, so this kernel never hands out an ID the hardware still tags cache
+ * entries with. @pci_seg->old_dev_tbl_cpy must already point at that table.
+ */
+static bool reserve_dev_table_domain_ids(struct amd_iommu_pci_seg *pci_seg)
 {
-	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	struct dev_table_entry *old_dev_tbl_entry;
-	u32 lo, hi, old_devtb_size, devid;
-	phys_addr_t old_devtb_phys;
+	u32 devid;
 	u16 dom_id;
 	bool dte_v;
+
+	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
+		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
+		dte_v = FIELD_GET(DTE_FLAG_V, old_dev_tbl_entry->data[0]);
+		dom_id = FIELD_GET(DTE_DOMID_MASK, old_dev_tbl_entry->data[1]);
+
+		if (!dte_v || !dom_id)
+			continue;
+		/*
+		 * ID reservation can fail with -ENOSPC when there
+		 * are multiple devices present in the same domain,
+		 * hence check only for -ENOMEM.
+		 */
+		if (amd_iommu_pdom_id_reserve(dom_id, GFP_KERNEL) == -ENOMEM)
+			return false;
+	}
+
+	return true;
+}
+
+static bool __reuse_device_table(struct amd_iommu *iommu)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	u32 lo, hi, old_devtb_size;
+	phys_addr_t old_devtb_phys;
 	u64 entry;
 
 	/* Each IOMMU use separate device table with the same size */
@@ -1178,22 +1207,6 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
 		return false;
 	}
 
-	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
-		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
-		dte_v = FIELD_GET(DTE_FLAG_V, old_dev_tbl_entry->data[0]);
-		dom_id = FIELD_GET(DTE_DOMID_MASK, old_dev_tbl_entry->data[1]);
-
-		if (!dte_v || !dom_id)
-			continue;
-		/*
-		 * ID reservation can fail with -ENOSPC when there
-		 * are multiple devices present in the same domain,
-		 * hence check only for -ENOMEM.
-		 */
-		if (amd_iommu_pdom_id_reserve(dom_id, GFP_KERNEL) == -ENOMEM)
-			return false;
-	}
-
 	return true;
 }
 
@@ -1201,27 +1214,69 @@ static bool reuse_device_table(void)
 {
 	struct amd_iommu *iommu;
 	struct amd_iommu_pci_seg *pci_seg;
-
-	if (!amd_iommu_pre_enabled)
-		return false;
-
-	pr_warn("Translation is already enabled - trying to reuse translation structures\n");
+	bool reused = false;
 
 	/*
 	 * All IOMMUs within PCI segment shares common device table.
 	 * Hence reuse device table only once per PCI segment.
 	 */
 	for_each_pci_segment(pci_seg) {
+		struct amd_iommu *preserved_iommu = NULL;
+		struct iommu_hw_ser *ser = NULL;
+
+		/*
+		 * The device table is shared by the whole segment and pinned
+		 * by whichever unit preserved it, so any member holding
+		 * preserved state can describe it for all of them.
+		 */
+		for_each_iommu(iommu) {
+			if (pci_seg->id != iommu->pci_seg->id)
+				continue;
+
+			ser = iommu_get_preserved_data(iommu->mmio_phys,
+						       IOMMU_AMD);
+			if (ser) {
+				preserved_iommu = iommu;
+				break;
+			}
+		}
+
+		if (preserved_iommu) {
+			amd_iommu_restore_dev_table(preserved_iommu, ser);
+			/*
+			 * Fatal for the same reason a failed table adopt is;
+			 * see amd_iommu_restore_dev_table().
+			 */
+			if (!reserve_dev_table_domain_ids(pci_seg))
+				panic("AMD-Vi: IOMMU:%d cannot reserve the preserved domain IDs\n",
+				      preserved_iommu->index);
+			reused = true;
+			continue;
+		}
+
+		/*
+		 * Nothing was handed over for this segment. The kdump path can
+		 * still remap the previous kernel's table, but only when every
+		 * IOMMU came up with translation already enabled.
+		 */
+		if (!amd_iommu_pre_enabled)
+			return false;
+
+		pr_warn("Translation is already enabled - trying to reuse translation structures\n");
+
 		for_each_iommu(iommu) {
 			if (pci_seg->id != iommu->pci_seg->id)
 				continue;
 			if (!__reuse_device_table(iommu))
 				return false;
+			if (!reserve_dev_table_domain_ids(pci_seg))
+				return false;
+			reused = true;
 			break;
 		}
 	}
 
-	return true;
+	return reused;
 }
 
 struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid)
@@ -1948,6 +2003,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 
 static int __init init_iommu_one_late(struct amd_iommu *iommu)
 {
+	struct iommu_hw_ser *ser;
 	int ret;
 
 	ret = alloc_iommu_buffers(iommu);
@@ -1957,7 +2013,25 @@ static int __init init_iommu_one_late(struct amd_iommu *iommu)
 	iommu->int_enabled = false;
 
 	init_translation_status(iommu);
-	if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
+
+	/* The MMIO physical base is the handoff token; NULL means a cold boot. */
+	ser = iommu_get_preserved_data(iommu->mmio_phys, IOMMU_AMD);
+
+	if (translation_pre_enabled(iommu) && !is_kdump_kernel() && !ser) {
+		/*
+		 * A handover boot that left this unit translating but produced
+		 * no record for it is not a stale enable. Either the handover
+		 * was never consumable (this kernel booted without
+		 * liveupdate=1) or it was not visible yet. Clearing the enable
+		 * bit drops every device behind this unit into untranslated
+		 * passthrough while its DMA is still in flight, aimed at
+		 * addresses that mean nothing in this kernel's physical map,
+		 * so stop instead of doing it silently.
+		 */
+		if (is_kho_boot())
+			panic("AMD-Vi: IOMMU:%d was handed over translating but no preserved state is available; refusing to disable it under live DMA\n",
+			      iommu->index);
+
 		iommu_disable(iommu);
 		clear_translation_pre_enabled(iommu);
 		pr_warn("Translation was enabled for IOMMU:%d but we are not in kdump mode\n",
@@ -2944,6 +3018,18 @@ static void early_enable_iommus(void)
 		}
 
 		for_each_iommu(iommu) {
+			/*
+			 * Units with no preserved devices come back with
+			 * translation off. Programming their buffers without
+			 * enabling them leaves amd_iommu_flush_all_caches()
+			 * waiting on a completion idle hardware never posts,
+			 * so bring them up the normal way.
+			 */
+			if (!translation_pre_enabled(iommu)) {
+				early_enable_iommu(iommu);
+				continue;
+			}
+
 			iommu_disable_command_buffer(iommu);
 			iommu_disable_event_buffer(iommu);
 			iommu_disable_irtcachedis(iommu);
@@ -3033,12 +3119,25 @@ static void enable_iommus_vapic(void)
 #endif
 }
 
-static void disable_iommus(void)
+static bool iommu_was_handed_over(struct amd_iommu *iommu)
+{
+	struct iommu_hw_ser *ser;
+
+	ser = iommu_get_preserved_data(iommu->mmio_phys, IOMMU_AMD);
+
+	return ser;
+}
+
+static void __disable_iommus(bool keep_handed_over)
 {
 	struct amd_iommu *iommu;
 
-	for_each_iommu(iommu)
+	for_each_iommu(iommu) {
+		if (keep_handed_over && iommu_was_handed_over(iommu))
+			continue;
+
 		iommu_disable(iommu);
+	}
 
 #ifdef CONFIG_IRQ_REMAP
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
@@ -3046,6 +3145,11 @@ static void disable_iommus(void)
 #endif
 }
 
+static void disable_iommus(void)
+{
+	__disable_iommus(false);
+}
+
 /*
  * Bound the wait for a log engine to report itself idle. An engine only has
  * to finish a write it has already started, which takes microseconds, so this
@@ -3388,9 +3492,8 @@ static int __init early_amd_iommu_init(void)
 			amd_iommu_pgtable = PD_MODE_NONE;
 	}
 
-	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
-		disable_iommus();
+		__disable_iommus(true);
 
 	if (amd_iommu_irq_remap)
 		amd_iommu_irq_remap = check_ioapic_information();
diff --git a/drivers/iommu/amd/liveupdate.c b/drivers/iommu/amd/liveupdate.c
index a3a9ebea5138..2e9a1de6b1ff 100644
--- a/drivers/iommu/amd/liveupdate.c
+++ b/drivers/iommu/amd/liveupdate.c
@@ -362,3 +362,36 @@ void amd_iommu_clear_unpreserved_dtes(struct amd_iommu *iommu)
 
 	amd_iommu_flush_all_caches(iommu);
 }
+
+void amd_iommu_restore_dev_table(struct amd_iommu *iommu,
+				 struct iommu_hw_ser *ser)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	if (ser->amd.dev_table_size != pci_seg->dev_table_size)
+		panic("AMD-Vi: IOMMU:%d preserved device table size mismatch (0x%x vs 0x%x)\n",
+		      iommu->index, ser->amd.dev_table_size,
+		      pci_seg->dev_table_size);
+
+	if (ser->amd.pci_seg_id != pci_seg->id)
+		panic("AMD-Vi: IOMMU:%d preserved PCI segment mismatch (%u vs %u)\n",
+		      iommu->index, ser->amd.pci_seg_id, pci_seg->id);
+
+	if (ser->amd.efr != iommu->features ||
+	    ser->amd.efr2 != iommu->features2)
+		panic("AMD-Vi: IOMMU:%d preserved feature registers mismatch (EFR 0x%llx/0x%llx vs 0x%llx/0x%llx)\n",
+		      iommu->index, ser->amd.efr, ser->amd.efr2,
+		      iommu->features, iommu->features2);
+
+	/*
+	 * Reclaim the folio from KHO the first time this segment's table is
+	 * seen, then adopt it. Later IOMMUs in the same segment reference the
+	 * same physical table and must not restore it again.
+	 */
+	if (!ser->amd.restored) {
+		iommu_restore_pages(ser->amd.dev_table_phys);
+		ser->amd.restored = 1;
+	}
+
+	pci_seg->old_dev_tbl_cpy = __va(ser->amd.dev_table_phys);
+}
-- 
2.43.0

