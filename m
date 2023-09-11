Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7965CA4D
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcSdd5YZ3S+X1h9V2tCbWSfT9YvSVT/iRgpn/mQA5T59jbCF5n/yoNZJUGpsPsyoy3TO4gFeoOQZ0QEjoZhXiDGU2fvpMqrjR76hoklzoB+skz62q85Zu+46Dy2j3KRJURWW3CDlWQ25cdDbCKfL+X+nuntVEbqpuFhYRuznpSJ1g+nXyV8lGOBS/uZzIRJX+PcUxRQeAj/Drr7Rr0LdJGMwnWQFnBecRVjhRpouWbLyPfQCd8Y/eiyor8dBhMoMTs6mhpJGKXPPUla2ijqfojGL+o4R4Lcnn04LSPjIZTTwDY29xT9DFsMsA9YxJkm37HmqZA/tj4D3fgOmup6XQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbb1ldglQrekjLCWv7ld63Av6F3sHCM3dRdWW4nxUcY=;
 b=BhNGQRg50KlcyJPFkOotBzxKYFgz8TvHLhRRg1SwnHVHqR/xZlBa28LD3vYknHM5Vvzq8ZLkgWuixUfH39DDpcQoZQfxbrxDLlwFSXfh5FE5+oT3B7NtvvGb2Xyd6iiiEKjHphcDIKvDhRqZOSThDli8+DtyqbD/hE/LjKIvz+Lbfdi96Qu1iryyCEF+Qy0pYf+9EZY9W6Uut4/yw3898kNhiUbuSHM/mDj9WEC/b6/lq9nSdT+IdGFQsNJGQplWOsNfDw6NBxnesVPB/9ccBOg2fISUotoaona4XHEBZkrGthx+a4GDJREmkOM34KIug6Ttw78G2ZOBHuj02yeh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbb1ldglQrekjLCWv7ld63Av6F3sHCM3dRdWW4nxUcY=;
 b=cTGcgpYeMkjugZT2Ys1YmSncDscrHSDnHLUa1dwTZEIuFSKZ+8Ymx9M/oUg/2B/8K/wTVvjFTbMjgAqexvcHxvG0OsufcMDKktxOE5ZNKiOcBRNgqF4wjzibjjjNbKKwDRCn6gN6IKQNq3JiM4roTGMih3udDFc0hEK0p1niMIg=
Received: from DS7PR05CA0039.namprd05.prod.outlook.com (2603:10b6:8:2f::16) by
 CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Mon, 11 Sep 2023 12:12:40 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::64) by DS7PR05CA0039.outlook.office365.com
 (2603:10b6:8:2f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.12 via Frontend
 Transport; Mon, 11 Sep 2023 12:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 12:12:39 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:12:36 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 04/11] iommu/amd: Initial SVA support for AMD IOMMU
Date: Mon, 11 Sep 2023 12:10:39 +0000
Message-ID: <20230911121046.1025732-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911121046.1025732-1-vasant.hegde@amd.com>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f9ccfb-39da-4d2f-1ba4-08dbb2c06488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QGJY+p9aPHC9la2hCkTU0mhRW2ImRJffNIwDSD5X1msLhcGHJbA7wSodgwX5TucJe2QdAAD8ZCbyB1TnVAJrTzicrRCV8tMLWQ/PWzLMnPiaEXNP+GzwafC/Spn7xfyMScbArD5ZIVCcveSAlODp41LtteRroZosTj9P6KdD4gH756HXz1fQ5R8kwDyObkBsAdNae754472EbO38c5Pj8mNVSU8k+C4LTzmcAS24GePBj1Yb1vM2HeUXqK0AVH9JtA70l8TTOJIVIR/tk9S5xePalcAyf1AtbvCBNyWWyWWUAKyXmpOUvu9pRfldBhLm8YBdW1HpONpzL/2/VJwqhDsCxWL3k+tUHAUffjbTXza0eZ0Bn8PFU0djQZW0geWu82Z5u7wE/ma1T4LcD0UbxRqr7Mwgka/Ot/Vqvr8VjhgQoX40zjhYdB3wrAO88H/RyHgMRGNMQJEX9WNjGAK6uuDL+V8TEE2NsMEztPY6caRXSdFjDJubX6K7h/HWVDXNo9K8WIDFJROmxyrG3tfrsGKC6JQkUR7eK43ttHSo09+WlxcD56Bgx9eYQ4ReyhbaHracG57BjfZ3ATl7jwxGmG3QTZeOXe2uJLMd9JK6drK4dgfLLA5goTvoQ+H53lvKYlZW47DqOnr69GDuMoKBNWjGF6ZcYNmDS+iMJjDniS0P+qB3VoHLXZecko6z6okB9FM/a1mVAFK5QLRgQzIMVZCLcTkpAZl9oUP4Bx5ZcHww3/cQK2A4m02WQzPkMnht/GbNeTvxsIVJ/ZDVdsRjXw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(81166007)(356005)(7696005)(86362001)(36756003)(36860700001)(40480700001)(82740400003)(40460700003)(47076005)(2616005)(26005)(41300700001)(426003)(30864003)(2906002)(4326008)(16526019)(336012)(83380400001)(478600001)(70206006)(1076003)(110136005)(8676002)(70586007)(8936002)(5660300002)(54906003)(44832011)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:12:39.2538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f9ccfb-39da-4d2f-1ba4-08dbb2c06488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227

This includes :
  - Add data structure to track per protection domain dev/pasid binding details

  - Add mmu notifier to protection domain, so that we can retrieve SVA
    protection domain in invalidation path.

  - Add iommu_ops.remove_dev_pasid support. It will unbind PASID from
    device. Also remove pasid data from protection domain.

  - mmu notifier for iotlb invalidation

  - Add IOMMU_SVA as dependency to AMD_IOMMU driver

  - Move 'to_pdomain()' to header file

For a given PASID, amd_iommu_set_dev_pasid() will bind all devices to same
SVA protection domain (1 PASID : 1 SVA protection domain : N devices).
This protection domain is different from device protection domain (one
that's mapped in attach_device() path). IOMMU uses device protection
domain for caching, etc. Hence in invalidation path we retrieve device
protection domain from iommu_dev_data structure and use that for
invalidation.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  10 ++
 drivers/iommu/amd/amd_iommu_types.h |  25 +++++
 drivers/iommu/amd/iommu.c           |  16 ++-
 drivers/iommu/amd/sva.c             | 158 ++++++++++++++++++++++++++++
 6 files changed, 206 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/amd/sva.c

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
index f454fbb1569e..848c89fa5238 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o sva.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7d18addb731e..7159b2610702 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -38,7 +38,12 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
+/* SVA/PASID */
 bool amd_iommu_sva_supported(void);
+int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
+			    struct device *dev, ioasid_t pasid);
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
@@ -153,6 +158,11 @@ static inline struct amd_iommu *get_amd_iommu_from_dev(struct device *dev)
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
index b1a54d8c7506..c866fbfa0dd8 100644
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
+	/* Points to attach device data */
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
@@ -922,6 +937,16 @@ static inline int get_hpet_devid(int id)
 	return -EINVAL;
 }
 
+static inline struct protection_domain *amd_iommu_get_pdomain(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!dev_data || !dev_data->domain)
+		return NULL;
+
+	return dev_data->domain;
+}
+
 enum amd_iommu_intr_mode_type {
 	AMD_IOMMU_GUEST_IR_LEGACY,
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a573e3534656..94eec3dac8f6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -76,6 +76,7 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
+static void amd_iommu_domain_free(struct iommu_domain *dom);
 
 static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 			  struct gcr3_tbl_info *gcr3_info,
@@ -183,11 +184,6 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
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
@@ -2192,6 +2188,11 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
 	return 0;
 }
 
+static const struct iommu_domain_ops amd_svm_domain_ops = {
+	.set_dev_pasid = amd_iommu_set_dev_pasid,
+	.free	       = amd_iommu_domain_free
+};
+
 static struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
@@ -2209,6 +2210,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
+	INIT_LIST_HEAD(&domain->pasid_list);
 	domain->nid = NUMA_NO_NODE;
 
 	switch (type) {
@@ -2226,6 +2228,9 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	case IOMMU_DOMAIN_UNMANAGED:
 		pgtable = AMD_IOMMU_V1;
 		break;
+	case IOMMU_DOMAIN_SVA:
+		domain->domain.ops = &amd_svm_domain_ops;
+		return domain;
 	default:
 		goto out_err;
 	}
@@ -2607,6 +2612,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
+	.remove_dev_pasid = amd_iommu_remove_dev_pasid,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
diff --git a/drivers/iommu/amd/sva.c b/drivers/iommu/amd/sva.c
new file mode 100644
index 000000000000..d18dc3f676b9
--- /dev/null
+++ b/drivers/iommu/amd/sva.c
@@ -0,0 +1,158 @@
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
+#include <linux/mmu_notifier.h>
+
+#include "amd_iommu.h"
+
+static void sva_mn_invalidate_range(struct mmu_notifier *mn,
+				    struct mm_struct *mm,
+				    unsigned long start, unsigned long end)
+{
+	struct protection_domain *sva_pdom;
+	struct pdom_pasid_data *pasid_data;
+	struct iommu_dev_data *dev_data;
+
+	sva_pdom = container_of(mn, struct protection_domain, mn);
+
+	list_for_each_entry(pasid_data, &sva_pdom->pasid_list, pdom_link) {
+		dev_data = pasid_data->dev_data;
+
+		if ((start ^ (end - 1)) < PAGE_SIZE) {
+			amd_iommu_flush_page(dev_data->domain,
+					     pasid_data->pasid, start);
+		} else {
+			amd_iommu_flush_tlb(dev_data->domain,
+					    pasid_data->pasid);
+		}
+	}
+}
+
+static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+}
+
+static const struct mmu_notifier_ops sva_mn = {
+	.invalidate_range = sva_mn_invalidate_range,
+	.release = sva_mn_release,
+};
+
+int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
+			    struct device *dev, ioasid_t pasid)
+{
+	struct protection_domain *sva_pdom = to_pdomain(domain);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct pdom_pasid_data *pasid_data;
+	int ret = -EINVAL;
+	unsigned long flags;
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
+	/* Setup GCR3 table */
+	ret = amd_iommu_set_gcr3(dev_data, pasid,
+				 iommu_virt_to_phys(domain->mm->pgd));
+	if (ret)
+		goto out_free_pasid_data;
+
+	if (list_empty(&sva_pdom->pasid_list)) {
+		sva_pdom->mn.ops = &sva_mn;
+
+		ret = mmu_notifier_register(&sva_pdom->mn, domain->mm);
+		if (ret)
+			goto out_clear_gcr3;
+	}
+
+	list_add(&pasid_data->pdom_link, &sva_pdom->pasid_list);
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+	return ret;
+
+out_clear_gcr3:
+	amd_iommu_clear_gcr3(dev_data, pasid);
+
+out_free_pasid_data:
+	kfree(pasid_data);
+
+out:
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+	return ret;
+}
+
+static struct pdom_pasid_data *get_pdom_pasid_data(struct protection_domain *pdom,
+						   struct device *dev, ioasid_t pasid)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct pdom_pasid_data *pasid_data;
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
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct pdom_pasid_data *pasid_data;
+	struct protection_domain *sva_pdom;
+	struct iommu_domain *domain;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
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
+	iopf_queue_flush_dev(dev);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	pasid_data = get_pdom_pasid_data(sva_pdom, dev, pasid);
+	if (!pasid_data) {
+		spin_unlock_irqrestore(&sva_pdom->lock, flags);
+		return;
+	}
+
+	list_del(&pasid_data->pdom_link);
+	kfree(pasid_data);
+
+	/* make it visible */
+	smp_wmb();
+
+	/* Update GCR3 table and flush IOTLB */
+	amd_iommu_clear_gcr3(dev_data, pasid);
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+
+	if (list_empty(&sva_pdom->pasid_list))
+		mmu_notifier_unregister(&sva_pdom->mn, domain->mm);
+}
-- 
2.31.1

