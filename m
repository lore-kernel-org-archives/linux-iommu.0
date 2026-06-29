Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D543E48D
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747738; cv=fail; b=ntxjx+vholye4jkSqrdiFeQUep3ArCCeziQ+FH3yIn+3PWSj0iFyDGCyA74ZwZclVJHnQ0SIobxQDHhTtsHd1irUosurZZFGBbJ61FOPudEGLCgSKrzgio8FWRXQybxm06do5QSf1pAdNQ7VmDer8eSwTeC9XwxyrTJXJs+xy7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747738; c=relaxed/simple;
	bh=oL803EeBHcYS4MZVopkNpngjI17a9e2Q0Vyr67oxPp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crYrmnpWUTeK/qlOt5c3ZRLtQobqs4x47FeMzClTpNp6hgg4z/OG+OPvidU71XIbUR9ZPhtW8qlP9QZ6C9YpmfnnTzjtB28WSy91d6GAtInr2UGhUVP8z/QOKI6p9g4UE/7Vm/rxgi8cJRcX45EVXHtjTfGUk1ZzWumPHEyZ9yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AzFX1iN+; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AzFX1iN+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERh0aX252fgk375iCk5voHYWiV/ovQ0N+pLFQYyTnDthVCLRpURAAy+n2KIS9EKK2ydT+rblxdoDPUh8nnet8sapQr61VPwFMuzLAQqwrD8eQysTzw23/PX7PQ8fH6I/Y08FhF6rnsPOjFqwAU5hr+KpctKHVmbiVZi0YuHSQgEzvy2WFrJfg2KmeWOHzCVtDIIlllzh7amSA1yid3d51QCK8XNlcZ4uMKDJ5f/q68S2LjG8UTKVAmbYou3mns1jTK8DznwNj8ZkFNy2ls3tfOH6gWZCnB18IQOD2ewiE6YMSNPPRICFFle32K60vxcVvTcjWf3xpplGEMLioXtSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNjzJXYlLcoHU4iP16pk8nghPLups5Ku64yT3s0A03g=;
 b=POwuh9qPaCp/55Nl0gwKTtHPrCQSzfNvsH13ELX5+E3nvepaWYietPgZiSXsO86L1IwNOqeEkMax+auQlCQWcVWLEvRcSNyeFLYJHZ59D6LTUPkVPFcnntvZ2NhKKiPNnJm3w7V6N4gXfoe1rhl0/BcDONXKsbe6dz0yJBxAOMFV8fxHS4WtgrMLczke0meGw8xvke9QQAjaycnZMYGCY8nIm2PcGV/mTY6EGYpDClWgHvJ06DUhljdMs3Kwn/mOW2VyjYr5h/mrGDWDDFE5gDugk569ndQLkztJQ7I0lLo0gAC8a/wyPv6bs4GCxeXNaFcjZDXjw/koZIexltdWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNjzJXYlLcoHU4iP16pk8nghPLups5Ku64yT3s0A03g=;
 b=AzFX1iN+pirE4l5xlTZ84DBO+y8eBQapcM4C9bYDFzF2xSOJtop/kc4G9HcM8E4IDDZNTHuFAs25mS3RIOxKJCvd9GflsbdLKI8Xgi0r2bgC9kqmRzsmbCHflenN652azli5GwdFHlcPJbkwOVM4Ll3otq7MRuz8Nri2g9w6DUA=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:42:10 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::26) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:42:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:58 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:37:22 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 19/22] iommu/amd: Add per-segment translate device ID pool
Date: Mon, 29 Jun 2026 15:35:32 +0000
Message-ID: <20260629153535.15775-20-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bd170c-0f63-435f-cacf-08ded5f4fbd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	AC8GgCFZS6gUBImeTJWSnd4qbTIhzKVKlGdb3iT9Uu69zh4zQUHRBxtnbIK+WDA0lsNCSUwjf3WsfCAzSo9/uuOXE0LkOoLGihh5gMdAgcMkjOQwZ4KD6yjUSyQ2lmcdt7+BpCAj6nG9Vglcx5V/Yqw47MGJhpHdevTi4LYl4/Lfbc1qNOgzCLqX9NdHBE+I2v66/ypZa4ngIweDxX9Et9wwpfXI/ni6gpS46Wb2GqEHjf7dqK8HnDy6j5mqgYiq3mXqWTBdrWHyK7xSQxCvn3Hx4bDczmJsILrT+Om3YRncJhzLx2nSefr+Ogt3ssIYuYf9enFRQYqc2x9nrZFShO1qbXjb/13SAuuCaGJIY5La0o94NsZNdbq/6tsiXydl9tzLH0tgwy5PucFZj/VCgh+xaCddnax41AdzIhm82IRU1XYpmzt0Uw+VHyHvRxFkqKVN5PR6VrV7i/TpujSfvc3Rd056iCkoRhM8zgKP06uPmsv9r1xcmowFVQzBAYHlKiJLDqySZm+ZA7pqypgBUTrWyIkW4mIf8WbI0n0W8djBmCKVDRC89OBXcm97jiYHfJZ0Yv62ABQRKSOQWCioYOsiX6X5xGGAYQF3cnbQhrxO+FFxWk/azeShk084AlanxCH9fzbQ4KVdGuIxuzgMRM3kg5ep4MCidIWwB18H4ycMXw0K2u1Er1CY0v2t52DpePKlMlo2Bg13Ao94026C5g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tbbbUj4Bv0pnuE1aY2/Q+2BF1FmgcII/jMax6r0z06HkUtxYwnbIYYvqDCSWsJ89KzyhB100g07to+zz+2MCh/JudbsAbI3o9AdbC7IyLg8Z3Uv1vEKyb7+WvxaCLLt+wLJZ5K07DNmISYCtF9O4h1BYgSiijXNNqdKFDUzQfRAcTrwTyBtoeDQAo1bRzR+VtVx7LkFwadGY7JN1uAq+x8TT1kAlw+Jb4GWX6JPMpTgjc2rTADvtjzVtNznhbUb8z6gxr6xeRkj6m6qaPAFCdaOsCkHEm6ExEFP6CvnjU72sDFUVbGeckEVFG7DrrzcuF/lG23KnJYvQqaNohvqkfx7GOyN/RPBTl9YL++DCAVKStrWagvT+v5HJpMLYghLowObPwH/SEu7EL2Cf/fZsU+hlzB9rt+CH17aOPSx058UH2GaM8T875rnyKoxw7aJq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:42:10.6459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bd170c-0f63-435f-cacf-08ded5f4fbd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447

Track translate-device-id slots per PCI segment so real PCI device IDs can
be reserved for normal DTE programming and excluded from dynamic allocation
for vIOMMU translation DTEs.

Add amd_iommu_pci_seg_trans_devid_init/fini() during segment setup and
teardown, amd_iommu_trans_devid_reserve() for attach-time reservation, and
trans_devid.c implementing the xarray-backed state machine.

Call the reserve hook from amd_iommu_attach_device() before programming
the DTE.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu.h       | 19 +++++++
 drivers/iommu/amd/amd_iommu_types.h | 17 ++++++
 drivers/iommu/amd/init.c            |  3 ++
 drivers/iommu/amd/iommu.c           | 12 +++++
 drivers/iommu/amd/trans_devid.c     | 83 +++++++++++++++++++++++++++++
 6 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/amd/trans_devid.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index e1e824b9c7b0..12c3fe83e4ce 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o ppr.o pasid.o
-obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o viommu.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o viommu.o trans_devid.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index aaa57840e904..f99225be5d07 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -218,6 +218,25 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct dev_table_entry *new);
 int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
+/* Per-segment translate-device-id pool (CONFIG_AMD_IOMMU_IOMMUFD) */
+#ifdef CONFIG_AMD_IOMMU_IOMMUFD
+void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg);
+void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
+int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
+#else
+static inline void
+amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg) { }
+static inline void
+amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg) { }
+#endif
+
+int amd_iommu_set_translate_dte(struct amd_iommu *iommu,
+				 struct protection_domain *pdom,
+				 u16 gid, u32 trans_devid);
+void amd_iommu_clear_translate_dte(struct amd_iommu *iommu, u32 trans_devid);
+void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
+						  u16 gid, u32 trans_devid);
+
 static inline void
 amd_iommu_make_clear_dte(struct amd_iommu *iommu, u16 devid,
 			 struct dev_table_entry *new)
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 027d9cfa5533..91cdb61b5254 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -612,6 +612,14 @@ PT_IOMMU_CHECK_DOMAIN(struct protection_domain, iommu, domain);
 PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv1.iommu, domain);
 PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv2.iommu, domain);
 
+#ifdef CONFIG_AMD_IOMMU_IOMMUFD
+enum trans_devid_state {
+	TRANS_DEVID_FREE = 0,
+	TRANS_DEVID_RESERVED,
+	TRANS_DEVID_ALLOCATED,
+};
+#endif
+
 /*
  * This structure contains information about one PCI segment in the system.
  */
@@ -673,6 +681,15 @@ struct amd_iommu_pci_seg {
 	 * parsing time.
 	 */
 	struct list_head unity_map;
+
+#ifdef CONFIG_AMD_IOMMU_IOMMUFD
+	/*
+	 * Per-segment translate-device-id allocation. The xarray is indexed by
+	 * the translate-device-id. The value is the state (enum trans_devid_state).
+	 */
+	struct mutex trans_devid_mutex;
+	struct xarray trans_devid_xa;
+#endif
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6e69b3dd8b1e..622bc0337eda 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1737,6 +1737,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	if (alloc_rlookup_table(pci_seg))
 		goto err_free_alias_table;
 
+	amd_iommu_pci_seg_trans_devid_init(pci_seg);
+
 	return pci_seg;
 
 err_free_alias_table:
@@ -1768,6 +1770,7 @@ static void __init free_pci_segments(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		amd_iommu_pci_seg_trans_devid_fini(pci_seg);
 		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
 		free_alias_table(pci_seg);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3b59938c2f86..01b755a2baed 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3075,6 +3075,18 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	if (dom->dirty_ops && !amd_iommu_hd_support(iommu))
 		return -EINVAL;
 
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+	/* Translate-device-id reservation must be done before setting up
+	 * the DTE for the device to make sure that the id has not been allocated
+	 * yet. (See amd_iommu_trans_devid_alloc().)
+	 */
+	ret = amd_iommu_trans_devid_reserve(iommu->pci_seg, dev_data->devid);
+	if (ret) {
+		pr_err("%s: Failed to reserve device id %#x\n", __func__, dev_data->devid);
+		return ret;
+	}
+#endif
+
 	if (dev_data->domain)
 		detach_device(dev);
 
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
new file mode 100644
index 000000000000..e5cca409d134
--- /dev/null
+++ b/drivers/iommu/amd/trans_devid.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ *
+ * AMD vIOMMU translate-device-id management.
+ *
+ * The id must be allocated from unused range. It is used to program the vIOMMU VF Control
+ * register to specify the DTE used to contain the GPA->SPA mapping (v1 page table).
+ */
+
+#include <linux/kernel.h>
+#include <linux/xarray.h>
+
+#include "amd_iommu.h"
+
+static inline enum trans_devid_state trans_devid_xa_get_state(void *entry)
+{
+	if (!entry)
+		return TRANS_DEVID_FREE;
+	if (WARN_ON_ONCE(!xa_is_value(entry)))
+		return TRANS_DEVID_FREE;
+	return (enum trans_devid_state)xa_to_value(entry);
+}
+
+static inline void *trans_devid_xa_mk_state(enum trans_devid_state s)
+{
+	return xa_mk_value((unsigned long)s);
+}
+
+void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg)
+{
+	mutex_init(&pci_seg->trans_devid_mutex);
+	xa_init(&pci_seg->trans_devid_xa);
+}
+
+void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg)
+{
+	xa_destroy(&pci_seg->trans_devid_xa);
+}
+
+/**
+ * amd_iommu_trans_devid_reserve - occupy @id so it is never returned by alloc
+ *
+ * Reservation is done when attaching device to a domain (see amd_iommu_attach_device()).
+ *
+ * Note: Since PCI hot-plug devices are enumerated during runtime, they could clash
+ * with the translate-device-id allocation. In such case, amd_iommu_trans_devid_reserve()
+ * could fail with %-EBUSY. This can be avoided by reserving the hot-plug id range if it
+ * is known in advance.
+ *
+ * Return: 0 on success, %-EBUSY if @id is already allocated. A second reserve of
+ * an already-reserved @id succeeds.
+ */
+int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
+{
+	void *entry, *old;
+	int ret = 0;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	entry = xa_load(&pci_seg->trans_devid_xa, id);
+	switch (trans_devid_xa_get_state(entry)) {
+	case TRANS_DEVID_ALLOCATED:
+		ret = -EBUSY;
+		break;
+	case TRANS_DEVID_RESERVED:
+		break;
+	case TRANS_DEVID_FREE:
+		old = xa_store(&pci_seg->trans_devid_xa, id,
+			       trans_devid_xa_mk_state(TRANS_DEVID_RESERVED), GFP_KERNEL);
+		if (xa_is_err(old)) {
+			ret = xa_err(old);
+			break;
+		}
+		WARN_ON_ONCE(old);
+		break;
+	}
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+
+	if (!ret)
+		pr_debug("%s: Reserved trans_devid %#x (seg %#x)\n", __func__, id,
+			 pci_seg->id);
+	return ret;
+}
-- 
2.34.1

