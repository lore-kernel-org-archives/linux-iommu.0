Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC33ACEFF
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411829; cv=fail; b=otCLz/FTgDNpuKpnE1VeMvZ59ZJzJd80xdLULcKLVT+d+yS+Dck0ak4t/pEPx46meaPql7+nDiKcj7QQDCbVpAMeqpQA6zGZlQ/wbqV+LRw/P+TawQQE2LDvwdBENiSy/ExI4GjG7DOFSJ0IuXEi8gl+y5fYZP2bIRO0SZDWbCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411829; c=relaxed/simple;
	bh=AZRREDB0SLpAmnJH4ULHtpMjFlIFFAQR/Ff3vi9QnFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYsjsQd79GmQ3ldA4b2hD9EX9Ce2yi315dannZu5uQ1UwJnpM7ujsmxvCi/Kk8oQNz7RXHF8cb5I173VRI8k4Po8O9jzaJ69fUBs4LWucZfq+Nme5R7O7aPWnm1WQzIZhA4ORvhsFJzzzE5SfcTBYunhzhr2QRONd+Ir/qGlZpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DjjJS8Ti; arc=fail smtp.client-ip=40.93.194.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DjjJS8Ti"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNlTTKmXBOenwnh0zMBnKyKPC/1xhzuFhm+GWoyyK2nUx8UoPXeCcCdQ+ulE1IeqwlOoF4PvTxgHOHm7iehFkH5YhB1nJ6spgA1PTBaFbl+RL6Bjrp/Q2z6C5CO+hCqnMrAKVy2Coexez4U5RcJMsXQkXKu6kLQD0g+ekmah35wrNssrFGyPAawEL3ZRI1v0Fk3ozZw2hYN6GKVodfh43ruJPqZQr5mPamd4R/vCT4jUcu3UrB245KCFkDHrAvnVkfcCNq07OhJtcUMMrtCwb0bo7juZU7gmM93PPKv3yQ8p0JT7xyBQttnd/vT23G8ZXJTGFnBfBV4UtTU9dwBPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT9rfQSSLFZaJNih1naOmCgNsL1b6fIOZ9Mb9NnFspA=;
 b=YyS6/KmCpSEy8fOeem0/noqUe20YocIWqltZMJHUXkimp+ljDWli5L5p9BWYsWaZMu+TwIlwOhUTieH/l81k9jA4yUgNhJ/vfnRtv8zxpwuLgUeGR65dsH5Yy3KgyFcm+v9NR4P6k+j8t0oh0uyaIzeAzl0dVSTbDjZyppQsX+NJzTQ3scFMFdKHHOCD0TJX2iOv0XvWde54wlwcBpVoyMTJMYC9ZQTmTpAEx6DkCDu7JHjzl4KSLtqCgRa+nJySmFhnoTKpZ7m02XcKMP4uFCXrePOoKlkpdF1jQG6MdzViLAArG3vzZrKgrGRIY7Q3p31z/j84iGhMY17mpp3kHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT9rfQSSLFZaJNih1naOmCgNsL1b6fIOZ9Mb9NnFspA=;
 b=DjjJS8Ti2CzexFT4LXKiniKHR6GBRH90L5n0dplLpUk28cKg/IVSWbyGQvOIOcYz7JcJxBl6+EbNYXf8QB04vPpb9vjAB8zuR7pj9b0V36k5UbQqFuXk4K6jnm4NupZrOnd3h7d0xJ0xXvT/ZyUBDRCOTN3DyeyX8BOoV2nj7oc=
Received: from CH2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:4e::18)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:50:16 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::af) by CH2PR02CA0008.outlook.office365.com
 (2603:10b6:610:4e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:50:15 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:50:05 -0500
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
Subject: [PATCH v5 19/24] iommu/amd: Add per-segment translate device ID pool
Date: Mon, 14 Sep 2026 18:47:45 +0000
Message-ID: <20260914184750.222939-20-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 0457ff2d-c487-452f-224d-08df12910405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gInHl6CqGzJnZhSWPPjNyc9UHt+D6xkENvBJP4k9BuB8z7YkhhWys8FUQUz20xNAUm48KVDBvzsQc8/OCgM1TYd1yUMcdM7SJ4HTrKlEdcUfTy7Z8p1AcBEEtB7k4gy1iZ7bxRj82sZ4B7Il7G6obx5Zxs2MmukTQWaHKcNBHxNWNJ1lwWtNv6Rv7jlD95nHO3loUM+g1hEyrzz0zjonOKswgPO1kqAjNdft9OMNl8LW13fI99dp1w7zUXgY8XKrRW1OddoV1zOl/RgFnYXmXXN3bwq4hByJm++JDJFFFffv5XPJ/j3UKaYd6mGcwClesOvuINWq5CnA9NgKjW/w9tYCLidaIPCzuNZrpOv9kxt5cNdZSFf1nA9fnJ5K4asj2OisLDRunsqgE9CSfzSiohgZSVmbv0GApHC+TsDiwfxuZ37RtMsZYe93Q41sUmYQo2X8eKppgATfxViuXChkM4dq+nzzFRoONr2LwBMxpz8EKCdY//3lteHllIulCGLS2VXeCne4z9dEwGAmTCIf1JNZa8egW++6KoXWo4YIS5x+e039KOosbbYCKqT6ekvBzIee4WUFU6zsTKb4ZrLLpl3PA/GefKnY8J+JweRsC1hyd+H9vhxPwonLDiuEHy3BP9ZrXyk9gUG2uHc89TVMcok9raTzG8QrWPbr/qnTEGFgo3GAmDAH3yBnbN96EUnr3cLMhOtE6E1Eznz8OuIw6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OyjCroIl/7r5dmx1rVHYHveSXzZ5Y60jtV2XqXtWT7GmCIDi1FJLGG/y7tEvabkSCrFe/N8lelwOZXNbYZ4ab8ZSHCpJrV10FOHQSchLc2ECst8+IWrnQ2okcDI5en7LMRaSWaqScX0SgKoqQ8qifdfAK2k2YbUo7Vs64Zx3Y3ExBuWPvIZcGZP16oV8noQz8d37LafiX/Y5qqi5IwlLK9MleuYohaNDHGLH4MT8VQ0Su2PBQCm7Lyb1IQWsfc9ATRzYpUZoqg1vHrGNux7Aac//tfwhdkiJ27M4UILJJpAKSLSTTsa9L4NIpbbld2i8fJv5xACdXi6Jrmc23UEzJekCV2AUKYpedh++pdMoHWUD5Odu6iyc9JcBtq1Mp2ZsWHBmjE6gCXHrx04izry/rDz5vaBV6rtavAV2IFtcOjhwuo/emkSUVJaRA9jOdDvF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:50:15.6452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0457ff2d-c487-452f-224d-08df12910405
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356

A translate device ID (TransDevID) is a host device-table index used
by hardware vIOMMU. VFCTRL guest-misc names the slot; that DTE holds
the nest-parent v1 table for GPA->SPA walks of guest IOMMU traffic.

Reserve PCI requestor IDs in a per-segment pool so they are not
used as vIOMMU translation DTEs. The device table is per-segment,
so the pool is too.

Add trans_devid.c with pci_seg init/fini and
amd_iommu_trans_devid_reserve() from probe_device(). Keep
reservations for the pci_seg lifetime, including after
amd_iommu_release_device().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu_types.h | 10 ++++
 drivers/iommu/amd/amd_viommu.h      | 14 +++++
 drivers/iommu/amd/init.c            |  3 +
 drivers/iommu/amd/iommu.c           | 19 +++++++
 drivers/iommu/amd/trans_devid.c     | 87 +++++++++++++++++++++++++++++
 6 files changed, 134 insertions(+), 1 deletion(-)
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
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index b5d1b23791da..6b3a43952797 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -681,6 +681,16 @@ struct amd_iommu_pci_seg {
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
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index f17ac13da213..b3717a006301 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -30,6 +30,10 @@ void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
 
 void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
 				   u16 hdev_id, u16 gdev_id);
+
+void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg);
+void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
+int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
 #else
 
 /*
@@ -66,6 +70,16 @@ static inline void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *a
 {
 }
 
+static inline void
+amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg)
+{
+}
+
+static inline void
+amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg)
+{
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1616fcfd361b..c646cf6bea6e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1740,6 +1740,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	xa_init(&pci_seg->dev_data_xa);
 	INIT_LIST_HEAD(&pci_seg->unity_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
+	amd_iommu_pci_seg_trans_devid_init(pci_seg);
 
 	if (alloc_dev_table(pci_seg))
 		goto err_free_pci_seg;
@@ -1756,6 +1757,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	free_dev_table(pci_seg);
 err_free_pci_seg:
 	list_del(&pci_seg->list);
+	amd_iommu_pci_seg_trans_devid_fini(pci_seg);
 	xa_destroy(&pci_seg->dev_data_xa);
 	kfree(pci_seg);
 	return NULL;
@@ -1780,6 +1782,7 @@ static void __init free_pci_segments(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		amd_iommu_pci_seg_trans_devid_fini(pci_seg);
 		xa_destroy(&pci_seg->dev_data_xa);
 		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d620586d5734..34915e5ff156 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2731,6 +2731,22 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (dev_is_pci(dev))
 		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
 
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+	/*
+	 * Occupy this RID in the per-segment translate-device-id pool
+	 * so vIOMMU alloc cannot reuse it. Probe is the RID lifetime;
+	 * it is not released on unplug. If reserve fails, the IOMMU
+	 * core frees dev->iommu and a later re-probe retries.
+	 */
+	ret = amd_iommu_trans_devid_reserve(iommu->pci_seg, dev_data->devid);
+	if (ret) {
+		pr_err("%s: Failed to reserve device id %#x\n", __func__,
+		       dev_data->devid);
+		iommu_dev = ERR_PTR(ret);
+		goto out_err;
+	}
+#endif
+
 out_err:
 	return iommu_dev;
 }
@@ -2744,6 +2760,9 @@ static void amd_iommu_release_device(struct device *dev)
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
 	 * device is re-plugged - not doing so would introduce a ton of races.
+	 * Translate-device-id reservations stay as well: the RID remains
+	 * occupied for the pci_seg lifetime so later alloc cannot reuse a
+	 * DTE index that still belongs to this function.
 	 */
 }
 
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
new file mode 100644
index 000000000000..195551fcfc1a
--- /dev/null
+++ b/drivers/iommu/amd/trans_devid.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
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
+#include "amd_viommu.h"
+
+enum trans_devid_state {
+	TRANS_DEVID_FREE = 0,
+	TRANS_DEVID_RESERVED,
+};
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
+	mutex_destroy(&pci_seg->trans_devid_mutex);
+}
+
+/*
+ * amd_iommu_trans_devid_reserve - occupy @id so it is never returned by alloc
+ *
+ * Reservation is done when probing the device (see amd_iommu_probe_device()).
+ * It is not released from amd_iommu_release_device(); the slot stays
+ * reserved for the pci_seg lifetime so replug cannot race later alloc.
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

