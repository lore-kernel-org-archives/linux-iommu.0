Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7CB1C04
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BVnDJlq9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfzEitJHj4FeZvfPt4Swzt0ckvSc5Gd0wK+G9Yn1lhN6ewBkD7BC5d+CV8ALaNPPXXe9qjPU8ZEw/9iPcRprbPKQ8/MEhRsLANK0SQU9TuGFdCy7fwJsHA+4++BuprzVAD2CgPr9P+wmU6yhFCEOJavT1ys18GuMU14uG1XUrX9KEIPVt/zs0L8tsM1RGXxvznnLmueF4inDtWI/nQH/RyR+3jzntemvqluBPMe9daKUPA2457KFKQPU5XRqTDAh8O5uByEMHFOAXAnoeb76HcXmPNvLpOy/ETRDZI7O+Rqhpok7UHDlT3rj72FEWolmERVNILhxjFZfXSP80Y9gYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pQdhbTPZU2YheNlz0j1Yg8Iizm6ZrvOcqkOvCfYTmg=;
 b=TBjS7jLY2FHdAx8AHu70mocxARQ5SRqg5EoUUUmqPyD24+iM/t3wmWuaFrhzE6XmAvdnXihmd0cgpDdGZcd6lGY17o9p9XymSv1ziTDxzUgROIhzxwyy+S1jdNPcZEcz7Q+khc8VLBxsmvLjdrsu4KJdwP6E4p3EhRqdOznE+qeqDwrjkHz+oW5sEWmIm3d+o5LPJU2S1WMIw0QRRKNvYfr8MpKvWj+a6zaIDFOuyj5sS5v8T7gIr9sdCHaLDbgDpooMJH5mNg0C9RmnEpXgZEuAlLfP7bMdCAYCdXlRmS5X36h9jn3ekwx9UeEoE3/TjS9Tm2Q1aOX22RdDMXORog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pQdhbTPZU2YheNlz0j1Yg8Iizm6ZrvOcqkOvCfYTmg=;
 b=BVnDJlq9nvBwADdsn5IR2LCEll2jUXBZVoKH2HV1BQu2dbpUcsaUqdk66HCurZupmLCPqzveu3WvmNtifZuGur6ggh1c8mZ6M9aQccHqNh41hE3hWyBYEVJ1cBhl+G0qn7/t2LAVJuyj405e4idUl5u5M8VTAcj8pD7936ADAD4=
Received: from MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 10:46:49 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::e0) by MN2PR20CA0043.outlook.office365.com
 (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:46:49 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:46:33 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 05/12] iommu/amd: Initial SVA support for AMD IOMMU
Date: Mon, 16 Oct 2023 10:43:44 +0000
Message-ID: <20231016104351.5749-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016104351.5749-1-vasant.hegde@amd.com>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 883bb711-25f7-47dc-6ea5-08dbce353371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	67SWalupHfqNlDuBH7cgpuhYnadHd5ZuWdcIaZWpE/Hiq+cfJB3XaZLBXhC8wYmiAcbPjwAYXoNHfJHWfcICQF5iadHq1ADYFbSydM3Q1V1j72HM1P/UBQsvZSK9jPLBSW2vFXHfAY6lHhacqIJqFiwcpB/XPySnJZIQi0ZD6t0phpsSm6CXLpQIASBfkkXxKd8HzHptEHlsvgu+XvTog2naoQBLLAbCAIbdeioQDxVvQ6O7z7d4TN14FOgMXBhfu2bbmY4F1jZrwNZHIRO9s0BKNkXAybqRAd/Wp9GgfN3TFYtsnRmkRa4hYApBJIEbb5mveK8qjqKIYVltOPl70ra62T63VwFlfmjRrh3AkPfV0PHyb6+FqLqzbX/NI8rqfK+JnLzDGw12dA1BwshmBzCmpq/z1vfikyJkELAz6J0Q3Qn4ICOsib/U4D3xx9pKg7EP1vHV/qBPTl3ApiqWegwV0NJ7zx/AlWWwFUd2k0W1dAmLnef47DhyMmrwheL6XqhswUmWY1hCa54D/oNBUn6NzMMiHVTjMMKtur9Zy3JdHkuDFiRTf1HhRDlHVNSaCJ6fOBrZfBRD3lSKNxjsd5jLQ2hJV8n+p7hYY599QYQads+/RcnCre+9jKBPmtsXmxcsy0EBTYqgiRuVZkLOzAeQo/w4binA5gsZzbLPrQ0o+yGDRiEqZPW7CIPIEeSOXU3ZoHFiuU2NkCUUECa2Vohrbi/DSBHGNT7WdzHhbjJNFGAlyFeQG232lkThN+/03eJ2ddmajbYTKgv7WDLlkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(110136005)(2906002)(30864003)(40480700001)(41300700001)(81166007)(356005)(86362001)(478600001)(36756003)(54906003)(70206006)(70586007)(36860700001)(7696005)(6666004)(316002)(8676002)(8936002)(40460700003)(44832011)(16526019)(336012)(426003)(26005)(1076003)(82740400003)(2616005)(83380400001)(4326008)(47076005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:46:49.4248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 883bb711-25f7-47dc-6ea5-08dbce353371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641

This includes :
  - Add data structure to track per protection domain dev/pasid binding details

  - Add mmu notifier to protection domain, so that we can retrieve SVA
    protection domain in invalidation path.

  - Move 'to_pdomain()' to header file

  - Add helper function to allocate/free SVA domain

  - Add iommu_ops.remove_dev_pasid support. It will unbind PASID from
    device. Also remove pasid data from protection domain.

  - mmu notifier for TLB invalidation

  - Add IOMMU_SVA as dependency to AMD_IOMMU driver

For a given PASID, iommu_set_dev_pasid() will bind all devices to same
SVA protection domain (1 PASID : 1 SVA protection domain : N devices).
This protection domain is different from device protection domain (one
that's mapped in attach_device() path). IOMMU uses domain ID for caching,
etc. In invalidation path we retrieve domain ID from iommu_dev_data
structure and use that for invalidation.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  13 ++
 drivers/iommu/amd/amd_iommu_types.h |  15 +++
 drivers/iommu/amd/iommu.c           |  11 +-
 drivers/iommu/amd/pasid.c           | 200 ++++++++++++++++++++++++++++
 6 files changed, 235 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iommu/amd/pasid.c

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 75132ae861a2..cabf4ccde1ed 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,6 +10,7 @@ config AMD_IOMMU
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
+	select IOMMU_SVA
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
 	  With this option you can enable support for AMD IOMMU hardware in
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index f454fbb1569e..a83e31208cdb 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o pasid.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index e3c7b99977c5..efcbec84d096 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -38,7 +38,15 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
+/* Protection domain ops */
+struct protection_domain *amd_iommu_sva_domain_alloc(
+				     struct protection_domain *pdom);
+void amd_iommu_domain_free(struct iommu_domain *dom);
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+
+/* SVA/PASID */
 bool amd_iommu_pasid_supported(void);
+
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
@@ -170,6 +178,11 @@ static inline struct amd_iommu *get_amd_iommu_from_dev(struct device *dev)
 	return container_of(iommu, struct amd_iommu, iommu);
 }
 
+static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct protection_domain, domain);
+}
+
 bool translation_pre_enabled(struct amd_iommu *iommu);
 bool amd_iommu_is_attach_deferred(struct device *dev);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index da94dca1eb92..20961353460d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -8,7 +8,9 @@
 #ifndef _ASM_X86_AMD_IOMMU_TYPES_H
 #define _ASM_X86_AMD_IOMMU_TYPES_H
 
+#include <linux/iommu.h>
 #include <linux/types.h>
+#include <linux/mmu_notifier.h>
 #include <linux/mutex.h>
 #include <linux/msi.h>
 #include <linux/list.h>
@@ -541,6 +543,16 @@ enum protection_domain_mode {
 	PD_MODE_V2,
 };
 
+/* Track PASID list for the protection domain */
+struct pdom_pasid_data {
+	/* PASID attached to the protection domain */
+	ioasid_t pasid;
+	/* Points to attached device data */
+	struct iommu_dev_data *dev_data;
+	/* Link to protection domain */
+	struct list_head pdom_link;
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -556,6 +568,9 @@ struct protection_domain {
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+
+	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
+	struct list_head pasid_list; /* List of pdom_pasid_data */
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 22e0703cb500..0974c88e39ce 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -201,11 +201,6 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
-static struct protection_domain *to_pdomain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct protection_domain, domain);
-}
-
 static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -2415,6 +2410,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
+	INIT_LIST_HEAD(&domain->pasid_list);
 	domain->nid = NUMA_NO_NODE;
 
 	switch (type) {
@@ -2432,6 +2428,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	case IOMMU_DOMAIN_UNMANAGED:
 		pgtable = AMD_IOMMU_V1;
 		break;
+	case IOMMU_DOMAIN_SVA:
+		return amd_iommu_sva_domain_alloc(domain);
 	default:
 		goto out_err;
 	}
@@ -2492,7 +2490,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 	return &domain->domain;
 }
 
-static void amd_iommu_domain_free(struct iommu_domain *dom)
+void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 	unsigned long flags;
@@ -2813,6 +2811,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
+	.remove_dev_pasid = amd_iommu_remove_dev_pasid,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
new file mode 100644
index 000000000000..c251b274eda0
--- /dev/null
+++ b/drivers/iommu/amd/pasid.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ */
+
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
+
+#include <linux/iommu.h>
+#include <linux/mm_types.h>
+
+#include "amd_iommu.h"
+
+static void dev_pasid_remove(struct pdom_pasid_data *pasid_data)
+{
+	/* make it visible */
+	smp_wmb();
+
+	/* Update GCR3 table and flush IOTLB */
+	amd_iommu_clear_gcr3(pasid_data->dev_data, pasid_data->pasid);
+
+	list_del(&pasid_data->pdom_link);
+	kfree(pasid_data);
+}
+
+static struct pdom_pasid_data *get_pdom_pasid_data(struct protection_domain *pdom,
+					   struct device *dev, ioasid_t pasid)
+{
+	struct pdom_pasid_data *pasid_data;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	list_for_each_entry(pasid_data, &pdom->pasid_list, pdom_link) {
+		if (pasid_data->pasid == pasid &&
+		    pasid_data->dev_data == dev_data)
+			return pasid_data;
+	}
+
+	return NULL;
+}
+
+static void sva_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
+				    struct mm_struct *mm,
+				    unsigned long start, unsigned long end)
+{
+	struct protection_domain *sva_pdom;
+	struct pdom_pasid_data *pasid_data;
+	struct iommu_dev_data *dev_data;
+	unsigned long flags;
+
+	sva_pdom = container_of(mn, struct protection_domain, mn);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	list_for_each_entry(pasid_data, &sva_pdom->pasid_list, pdom_link) {
+		dev_data = pasid_data->dev_data;
+
+		spin_lock(&dev_data->lock);
+		amd_iommu_dev_flush_pasid_pages(dev_data, pasid_data->pasid,
+						start, end - start);
+		spin_unlock(&dev_data->lock);
+	}
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
+
+static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct pdom_pasid_data *pasid_data, *next;
+	struct protection_domain *sva_pdom;
+	unsigned long flags;
+
+	sva_pdom = container_of(mn, struct protection_domain, mn);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	/* Assume pasid_list contains same PASID with different devices */
+	list_for_each_entry_safe(pasid_data, next,
+				 &sva_pdom->pasid_list, pdom_link) {
+		dev_pasid_remove(pasid_data);
+	}
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
+
+static const struct mmu_notifier_ops sva_mn = {
+	.arch_invalidate_secondary_tlbs = sva_arch_invalidate_secondary_tlbs,
+	.release = sva_mn_release,
+};
+
+static int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid)
+{
+	struct pdom_pasid_data *pasid_data;
+	struct protection_domain *sva_pdom = to_pdomain(domain);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	/* PASID zero is used for requests from the I/O device without PASID */
+	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
+		return ret;
+
+	/* Use SVA protection domain lock */
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	/* Add PASID to protection domain pasid list */
+	pasid_data = kzalloc(sizeof(*pasid_data), GFP_KERNEL);
+	if (pasid_data == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pasid_data->pasid = pasid;
+	pasid_data->dev_data = dev_data;
+
+	if (list_empty(&sva_pdom->pasid_list)) {
+		sva_pdom->mn.ops = &sva_mn;
+
+		ret = mmu_notifier_register(&sva_pdom->mn, domain->mm);
+		if (ret) {
+			sva_pdom->mn.ops = NULL;
+			goto out_free_pasid_data;
+		}
+	}
+
+	/* Setup GCR3 table */
+	ret = amd_iommu_set_gcr3(dev_data, pasid,
+				 iommu_virt_to_phys(domain->mm->pgd));
+	if (ret)
+		goto out_unreg_notifier;
+
+	list_add(&pasid_data->pdom_link, &sva_pdom->pasid_list);
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+	return ret;
+
+out_unreg_notifier:
+	mmu_notifier_unregister(&sva_pdom->mn, domain->mm);
+	sva_pdom->mn.ops = NULL;
+
+out_free_pasid_data:
+	kfree(pasid_data);
+
+out:
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+	return ret;
+}
+
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct pdom_pasid_data *pasid_data;
+	struct protection_domain *sva_pdom;
+	struct iommu_domain *domain;
+	unsigned long flags;
+
+	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
+		return;
+
+	/* Get protection domain */
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
+	if (!domain)
+		return;
+	sva_pdom = to_pdomain(domain);
+
+	/* Ensure that all queued faults have been processed */
+	iopf_queue_flush_dev(dev, pasid);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	pasid_data = get_pdom_pasid_data(sva_pdom, dev, pasid);
+	if (!pasid_data) {
+		spin_unlock_irqrestore(&sva_pdom->lock, flags);
+		return;
+	}
+
+	dev_pasid_remove(pasid_data);
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
+
+static void iommu_sva_domain_free(struct iommu_domain *domain)
+{
+	struct protection_domain *sva_pdom = to_pdomain(domain);
+
+	if (sva_pdom->mn.ops)
+		mmu_notifier_unregister(&sva_pdom->mn, domain->mm);
+
+	amd_iommu_domain_free(domain);
+}
+
+static const struct iommu_domain_ops amd_sva_domain_ops = {
+	.set_dev_pasid = iommu_sva_set_dev_pasid,
+	.free	       = iommu_sva_domain_free
+};
+
+struct protection_domain *amd_iommu_sva_domain_alloc(struct protection_domain *pdom)
+{
+	pdom->domain.ops = &amd_sva_domain_ops;
+
+	return pdom;
+}
-- 
2.31.1

