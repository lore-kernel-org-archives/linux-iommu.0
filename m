Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB17E41C2F8
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159124; cv=fail; b=PXDWvJGGnB4MLGaZkKut36dg+ZOTz5VgtuDXwcOHxDqmTIf0G9TwgSWe9y5+oBUPuI+0rBUQte3D7Bgbq0vXvBI2kFcOIsn5kPPGjpFWxI2DHfTI5IyW1e0ov6aYwd4MEHAPH0efqDCKZ4Pzo0prtd8Bpg10qC1voD2g1n3I0+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159124; c=relaxed/simple;
	bh=+03bbCXSh5TU1gLtXXtLFqeCfC286+biKFmNCr8hpHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeG02trksERAR9dwXIpcDAXt6bIBxlh1On3EM7s2hqajsYMWem/jQIYVwbrIg7du3eFQK2ReSetKwS3PJaqMnILQBvx3LLxBzt3Ai0B+UO4YNp0RXB1NBOvLHDHOYiBdBGFCuRlfQhKNkMGSoy2tk6Sz6tbmaqiV23SKykjywxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4dxnzss1; arc=fail smtp.client-ip=52.101.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4dxnzss1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hv5gcoNSIAW7KVdCsEpszyr64Ilc1Uz/6x5tA5kWcUPklun0gLJI9sCoes0Oom1dijtsgyLwmqeoRCgGX0m0TpugGsaHt0Vh1SluH4WAL68yUQBJwDBde4cnSEiQZKBP9j525taaCbZzHeSoKar1Ud+vccrtp85C5rZdRPsVyMozcQdNLmwDQJRMqkKjZFiNYp1Ts+eqp5d3B5R4bQVQqzK3P/BsnFztnbj+Cj3ortGGrY5Znb48UHfeswuScHWJYZr4Vf0BRKIz31IjuPU0wdyNMqyH5IG6MJcE/p6X8zcxoUzUqX+qGa4VPeiSrCGD0dSnrIwo3ZyxnKO3Ntr9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLo7l9e4dsrUdRwixzhbEj1n99W1SmzRwkafYYAUIpQ=;
 b=sH2OTLnsMD/Ek3yGomOBktoIZ2y2+k2vKH8TqN/eOoMP3JToM9MJXK+zXfFIpkiaX50q5QL3dhFOvmtCiCej+EXOORTD2ChQfwrhkmYTtCoGAl9y9hTITQKgWiuGWk387E9hDzd2JRytJjOf3f4qCAuVDOwe8dJ0kE2F+itsEK5eSJdTRhdCornw7C9MR6oY8cS+aQh4Wc6DZ6u+qohQfRJgvR8gqTLeLsdSb7k7bZ1Kz3TK+b8R57QejGfFNTUbisAHNt6Q+fXXxitFSQuP2076IANzkJyUBcyL9g5x5hH+Qdd4kx58Xl+2IXwmxbdc8kTDozzDwU8Qq/49FSWE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLo7l9e4dsrUdRwixzhbEj1n99W1SmzRwkafYYAUIpQ=;
 b=4dxnzss1uWF8pCVJsgdu3JeTK3LcQt57mh5biB8PSpR0GbEd03T7lzYVZjCGSG/+uHSqKQ/vC+bll62RVjgdx5fTzY2Wl+N61wdO0j8EG5MO8IqLTEv9nK4Hv1D74moyWuV9726ewmpn3+Wa261c2J3bhPllwr4YUstulPM7b64=
Received: from PH8PR02CA0054.namprd02.prod.outlook.com (2603:10b6:510:2da::14)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:53 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::4e) by PH8PR02CA0054.outlook.office365.com
 (2603:10b6:510:2da::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:52 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:43 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 19/24] iommu/amd: Add per-segment translate device ID pool
Date: Mon, 27 Jul 2026 13:29:08 +0000
Message-ID: <20260727132913.22475-20-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c13a2e-ea41-4995-2a78-08deebe36b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|18002099003|10067099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2sqESRAULa0YtWseXb4Rb0Hcr8lCZ1JyusJFhXRtoi69IT1E1wzJGsEx9BPagqBHZ4bF/1YARCyLVeahqGbyf+uu0GMZl1LwnQW7vI9Mb99ijoCQgfg+XdXZwzdz3dfETMk5TKYsnnhZahop0bvn7qs8d8ciuxRqKaRrtVH+9SOe70Y2OtgtAeoHWkfewnJaO3IWrQvC/6ZtQ69Gw4EE2cFZEtnTF3U1eTJITZ/sM+XyMhm1sp/20D2swcCxWupBLwFu5AswKkTzKi9O0RaAuDtkAUpSzbk9vmNZqNfQNQLkNXxs+5gs3Q11uKAjJ9T6vo9+cqeT/WwPBu+po1B6chIyYAFyvn0HYbbOY2qu4czBaoQ5TRRTYV1VR1CGsfQrlA2VRhs1Lm08npXmf4c0Bwp3PTyIWQDSKeKL8u0Vs/kwmIS5BL/SpzWoVZZ+6iLg5dyB/iAqqIdb3hRHUR8r4i2AtcLiI8ZaTyGHabffV/xGSpZZfKPTKsLYbsLu0OzrZYDv7ICGUGK5ArwIAMbikPsQzLJp+gx9ODbZql6IHBbyK3S6ODhwJMUBU25vQiedTT0CJk/1JGGwFI1dV7nS0eep03P+ZM+npTJXy4zU30BOGeOyHXx+t2X0synJGuPApvtVJQcBTumKZh6gtvqn16yf1KQ7+0mwnYpnVpgbcz0bsm/R4dAenTB7MHJyBZk88PQIXWasQq+1HgRynUUWNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EXM3HzQD07zzVE1UW1vc4DFMc8Q7I3zi++xdUks1dwx7KK9WO5A8XNvm3J3gX1r9Z9fQifXsCJG8aW8iFKoYJ2/bjKwz6PxV18vadC/VSu8GuTpZlDKIEjZX2F1PFPKelv80DGGcIGb45QUt3Hve4ROzxSXElBAkPHDtK7DcnBkTxmSOUZ/VZ9fw3e/QsxftfRbFPjFBngBrz57VRx4zhi9pNK/vfMyE90eUwz4bVyGuTIdp6gwcnX3whjbiMVKxGhzvIJqEVRyslviVx307E74SeGyZjamAEIiZWKeim4RVPWAJsbP+dvmrnvdXkKqXMCKcG3Z1GZZvza/ESW4jhDu2KhxrNvGruvPO+LSil93xFQV3+qbnG2ugcxQhxiefX67oRn9g6p1ur6Zc29dnSH1mq5oiR/MqRAuOedK2Aqc5KIe8xO7xL8Xsd7E+qwfG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:52.6236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c13a2e-ea41-4995-2a78-08deebe36b81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

Track translate-device-id slots per PCI segment so real PCI device IDs can
be reserved for normal DTE programming and excluded from dynamic allocation
for vIOMMU translation DTEs.  The pool is per-segment because the AMD
IOMMU device table is per-segment.

Add amd_iommu_pci_seg_trans_devid_init/fini() during segment setup and
teardown, amd_iommu_trans_devid_reserve() for attach-time reservation, and
trans_devid.c implementing the xarray-backed pool.  Allocated slots are
recorded as pointers to the owning vIOMMU once allocation is added.

Call the reserve hook from amd_iommu_attach_device() before programming
the DTE.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu.h       | 12 +++++
 drivers/iommu/amd/amd_iommu_types.h | 17 +++++++
 drivers/iommu/amd/init.c            |  3 ++
 drivers/iommu/amd/iommu.c           | 12 +++++
 drivers/iommu/amd/trans_devid.c     | 78 +++++++++++++++++++++++++++++
 6 files changed, 123 insertions(+), 1 deletion(-)
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
index 951757c2507f..284830673a87 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -218,6 +218,18 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
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
 static inline void
 amd_iommu_make_clear_dte(struct amd_iommu *iommu, u16 devid,
 			 struct dev_table_entry *new)
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 39aa872c2741..c102d059964a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -612,6 +612,13 @@ PT_IOMMU_CHECK_DOMAIN(struct protection_domain, iommu, domain);
 PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv1.iommu, domain);
 PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv2.iommu, domain);
 
+#ifdef CONFIG_AMD_IOMMU_IOMMUFD
+enum trans_devid_state {
+	TRANS_DEVID_FREE = 0,
+	TRANS_DEVID_RESERVED,
+};
+#endif
+
 /*
  * This structure contains information about one PCI segment in the system.
  */
@@ -673,6 +680,16 @@ struct amd_iommu_pci_seg {
 	 * parsing time.
 	 */
 	struct list_head unity_map;
+
+#ifdef CONFIG_AMD_IOMMU_IOMMUFD
+	/*
+	 * Per-segment translate-device-id pool indexed by id.  Entries are:
+	 * absent (FREE), xa value TRANS_DEVID_RESERVED, or a pointer to the
+	 * owning struct amd_iommu_viommu (ALLOCATED).
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
index 6895629cc8a5..02b3d3c19936 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3069,6 +3069,18 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
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
index 000000000000..42ab19180e1c
--- /dev/null
+++ b/drivers/iommu/amd/trans_devid.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ *
+ * AMD vIOMMU translate-device-id management.
+ *
+ * The pool is per PCI segment because the AMD IOMMU device table is
+ * per-segment.  Each id must be allocated from unused slots in that
+ * segment.  It is used to program the vIOMMU VF Control register to
+ * specify the DTE used to contain the GPA->SPA mapping (v1 page table).
+ */
+
+#include <linux/kernel.h>
+#include <linux/xarray.h>
+
+#include "amd_iommu.h"
+
+static inline bool trans_devid_xa_is_reserved(void *entry)
+{
+	return entry && xa_is_value(entry) &&
+	       xa_to_value(entry) == TRANS_DEVID_RESERVED;
+}
+
+static inline void *trans_devid_xa_mk_reserved(void)
+{
+	return xa_mk_value(TRANS_DEVID_RESERVED);
+}
+
+static int trans_devid_xa_install_reserved_locked(struct amd_iommu_pci_seg *pci_seg,
+						  u16 id)
+{
+	void *old;
+
+	old = xa_store(&pci_seg->trans_devid_xa, id,
+		       trans_devid_xa_mk_reserved(), GFP_KERNEL);
+	if (xa_is_err(old))
+		return xa_err(old);
+	WARN_ON_ONCE(old);
+	return 0;
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
+ * Return: 0 on success.  A second reserve of an already-reserved @id succeeds.
+ */
+int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
+{
+	void *entry;
+	int ret = 0;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	entry = xa_load(&pci_seg->trans_devid_xa, id);
+	if (trans_devid_xa_is_reserved(entry))
+		goto unlock;
+
+	ret = trans_devid_xa_install_reserved_locked(pci_seg, id);
+unlock:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+
+	if (!ret)
+		pr_debug("%s: Reserved trans_devid %#x (seg %#x)\n", __func__, id,
+			 pci_seg->id);
+	return ret;
+}
-- 
2.34.1

