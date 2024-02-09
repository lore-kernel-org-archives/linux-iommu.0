Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805C288A7
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478478; cv=fail; b=rXIeHvzbqjdSVwHsG6wvmItqgHcaW2sPqak9dAgD83LG8Ofmgkl2yUmFGFJvM48kl0HKbBQtlevEtzYFpSzvU3MbqvE9kgnQVOi9sXeeGlhDDfo6I5ncYG0QyamyPKMwjqgwSyOWYevpg+fTqQfPEL57ON6RLig0fHEUyDG6xuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478478; c=relaxed/simple;
	bh=dqiw9iITigAvdULwZMJoBDslZylZqli8C/rfgHzr+1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFjOxcMaUb3Nxog1rAVaeDkXrCNRBTlk+ElYEMZldGhSi1lMLvDLxxCRWozDyjVCYEtxUOKEQvY5PpYkWKAOk9VvHwAZXSFDCSpXGj560LhuUnFWyN58KzXeB4siqOcl8cLOosXity8YWrC8x/PaGLsxBO1q4eU1Uk7UBjJzMLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LvY4fkM2; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LvY4fkM2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tcya+TmTMWu+t/NlIrfKOE/rnEE2ILhQfk8iXWQ7FrbWa6Z3zjz/UAILc80oiAgpyO5OXwguuvS9qRg8CJdXC2T5EK3fbXynS8ezzWJgeyJAAsajOyxso1jQT2fKc7j3jlx2SU97Ej8+N2wmO3IxNU55QXeBeVG5bc/M669trzBr+v6zjUKCG8dshbIz+05i5/DwlF4VTkAUGP46gXEyiQEt7nqg5SPsnKuk12KiWXMq7+d9BKH7eGlbwKwc1g+zWZsQaaKy5/IZgJNAEEZwAiKfmuMDsBpTH6BPmNUnPALk6fc+WJbfcEzJmfidaUnnnOQ7CunVzqhdIX206ifM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48Ebg9JuPFo3mvWZbcdIh3MgJ8UehdJCZ/Pj2K8HMd4=;
 b=EYlE02HG6LZNLPkdyt3YeDClXuSt0kCWxuVdcMACukT0Tdg9N8oawTL8i01emoj79aDwDNtuW24JAYAV6VndSh8dEcpnWitJYgewaSZbg9LPDzEG3qK8avXzYJl3gu4+pSsfLMh0COlZLzE1nY/LDtnWjpdf2QjDgYDrzL7CIpNlhOcoZ55CilddCN8Qo3rOX5dwLh7GnhVUbt4Sa98HrkVCW5UYZygNCAX4C7/pXQ2OjP8rl1olnw37w/rprXFG2QFYM7mbUTPxp40MkXQJWYpVN2EErVGgAnq7yEJjSzk85BYDTLmWRW2v+FtxldWyjoZZ36B2w9wbb+4Nb9vhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48Ebg9JuPFo3mvWZbcdIh3MgJ8UehdJCZ/Pj2K8HMd4=;
 b=LvY4fkM2T6GjKd3QZD6tMAR1Gc7kd1r4gg5hm/fSvFow2FcuhJwPbQRjHBoMFALgsaKePCSZ06IRvEkfJEO/SfYvr1Miv0DcyS6iZF2fut75ZnbvdzDklhjLm7nMp49W32ViKzSEvuyQ2ozrFVkIMKJbV2T5saxKh7oErb2wvgw=
Received: from CH0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:610:74::9)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Fri, 9 Feb
 2024 11:34:31 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::ca) by CH0PR04CA0064.outlook.office365.com
 (2603:10b6:610:74::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 11:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:34:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:34:28 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 13/15] iommu/amd: Initial SVA support for AMD IOMMU
Date: Fri, 9 Feb 2024 11:29:28 +0000
Message-ID: <20240209112930.63663-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d4b9b4-185f-4e14-c43d-08dc29631505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KtZAQSWnZAsj0/IqWr/JBBHHSdygUDL6rgrmNxWPIcicEOXj6q8SAqcoKVoG2Z+FEVSXOeGWXHd/mD9ReBIAHQgAWXWHBSvynxS/sES2Z80VUAsuLrpcp6vhNAKjJOOISpcSeWiVOv0PAWM22Pf2evqR7dcmxWPR8TfNTqrARLV78N8j2msZH3QQfICM4atQy2CmONKoeViG5GdMA0GULGhBmS1OMYv8g5RO0IzhfOHVpnlHhE6dJJPNE2HC3mpVhWE8qTIqUMbMq4dQ62mjCH5a1TnhpHARcqx4MppShD8Gp9KGz6lRdhDg963xqTf9rOm0+jTqruLITShiJHQDhIgBHTNdefEWWNkDIA3WCdZ1UMS/Ai0vjtjOWvy+4s6gJ3JeUWCL2FaV6V/83zq5HJrmCLKMctT7ElmzYgVmzNn46FmrdxKyuGhqr1wPolWSF6LvFN9kLtTNXoLGgTU8Rp3JRCfQl19d5MUbUpw8jkLieSdmsy/EX/qKrO/OnBvOF5o5GwmILOfL15KOnXC5tB4FslKF6HhO3bhiQtw+8e1sqEnyYgwpPHh7YKksjU7Hs+Stm6aganuOTlEVOOBPz1mHtWWlQEVh2UEXX78HPPE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(7696005)(478600001)(83380400001)(1076003)(16526019)(26005)(2616005)(41300700001)(44832011)(426003)(336012)(2906002)(5660300002)(110136005)(54906003)(316002)(70586007)(70206006)(8936002)(4326008)(8676002)(36756003)(81166007)(82740400003)(356005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:34:31.0343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d4b9b4-185f-4e14-c43d-08dc29631505
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587

This includes :
  - Add data structure to track per protection domain dev/pasid binding details
    protection_domain->dev_data_list will track attached list of
    dev_data/PASIDs.

  - Move 'to_pdomain()' to header file

  - Add iommu_sva_set_dev_pasid(). It will check whether PASID is supported
    or not. Also adds PASID to SVA protection domain list as well as to
    device GCR3 table.

  - Add iommu_ops.remove_dev_pasid support. It will unbind PASID from
    device. Also remove pasid data from protection domain device list.

  - Add IOMMU_SVA as dependency to AMD_IOMMU driver

For a given PASID, iommu_set_dev_pasid() will bind all devices to same
SVA protection domain (1 PASID : 1 SVA protection domain : N devices).
This protection domain is different from device protection domain (one
that's mapped in attach_device() path). IOMMU uses domain ID for caching,
invalidation, etc. In SVA mode it will use per-device-domain-ID. Hence in
invalidation path we retrieve domain ID from gcr3_info_table structure and
use that for invalidation.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  11 +++
 drivers/iommu/amd/amd_iommu_types.h |  19 +++++
 drivers/iommu/amd/iommu.c           |   7 +-
 drivers/iommu/amd/pasid.c           | 122 ++++++++++++++++++++++++++++
 6 files changed, 156 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/amd/pasid.c

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index d563f6d496ca..68d8fc107cb9 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,6 +10,7 @@ config AMD_IOMMU
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
+	select IOMMU_SVA
 	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 93b11b6d764f..9de33b2d42f5 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 384298206a2d..ceecc18279ab 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -44,6 +44,12 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
+/* Protection domain ops */
+int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
+			    struct device *dev, ioasid_t pasid);
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+
+/* SVA/PASID */
 bool amd_iommu_pasid_supported(void);
 
 /* IOPF */
@@ -187,6 +193,11 @@ static inline struct amd_iommu *get_amd_iommu_from_dev_data(struct iommu_dev_dat
 	return iommu_get_iommu_dev(dev_data->dev, struct amd_iommu, iommu);
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
index de637006dc82..1ae2a9b3e383 100644
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
@@ -511,6 +513,11 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 	list_for_each_entry((iommu), &amd_iommu_list, list)
 #define for_each_iommu_safe(iommu, next) \
 	list_for_each_entry_safe((iommu), (next), &amd_iommu_list, list)
+/* Making iterating over protection_domain->dev_data_list easier */
+#define for_each_pdom_dev_data(pdom_dev_data, pdom) \
+	list_for_each_entry(pdom_dev_data, &pdom->dev_data_list, list)
+#define for_each_pdom_dev_data_safe(pdom_dev_data, next, pdom) \
+	list_for_each_entry_safe((pdom_dev_data), (next), &pdom->dev_data_list, list)
 
 #define APERTURE_RANGE_SHIFT	27	/* 128 MB */
 #define APERTURE_RANGE_SIZE	(1ULL << APERTURE_RANGE_SHIFT)
@@ -560,6 +567,16 @@ enum protection_domain_mode {
 	PD_MODE_V2,
 };
 
+/* Track dev_data/PASID list for the protection domain */
+struct pdom_dev_data {
+	/* Points to attached device data */
+	struct iommu_dev_data *dev_data;
+	/* PASID attached to the protection domain */
+	ioasid_t pasid;
+	/* For protection_domain->dev_data_list */
+	struct list_head list;
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -576,6 +593,8 @@ struct protection_domain {
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+
+	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 21cc6654410f..36ae01d53bfa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -198,11 +198,6 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
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
@@ -2348,6 +2343,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
+	INIT_LIST_HEAD(&domain->dev_data_list);
 	domain->nid = NUMA_NO_NODE;
 
 	switch (type) {
@@ -2877,6 +2873,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
+	.remove_dev_pasid = amd_iommu_remove_dev_pasid,
 	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
new file mode 100644
index 000000000000..c96384ae3442
--- /dev/null
+++ b/drivers/iommu/amd/pasid.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
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
+static inline bool is_pasid_enabled(struct iommu_dev_data *dev_data)
+{
+	if (dev_data->pasid_enabled && dev_data->max_pasids &&
+	    dev_data->gcr3_info.gcr3_tbl != NULL)
+		return true;
+
+	return false;
+}
+
+static inline bool is_pasid_valid(struct iommu_dev_data *dev_data,
+				  ioasid_t pasid)
+{
+	if (pasid > 0 && pasid < dev_data->max_pasids)
+		return true;
+
+	return false;
+}
+
+static void remove_dev_pasid(struct pdom_dev_data *pdom_dev_data)
+{
+	/* Update GCR3 table and flush IOTLB */
+	amd_iommu_clear_gcr3(pdom_dev_data->dev_data, pdom_dev_data->pasid);
+
+	list_del(&pdom_dev_data->list);
+	kfree(pdom_dev_data);
+}
+
+/* Clear PASID from device GCR3 table and remove pdom_dev_data from list */
+static void remove_pdom_dev_pasid(struct protection_domain *pdom,
+				  struct device *dev, ioasid_t pasid)
+{
+	struct pdom_dev_data *pdom_dev_data;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	lockdep_assert_held(&pdom->lock);
+
+	for_each_pdom_dev_data(pdom_dev_data, pdom) {
+		if (pdom_dev_data->dev_data == dev_data &&
+		    pdom_dev_data->pasid == pasid) {
+			remove_dev_pasid(pdom_dev_data);
+			break;
+		}
+	}
+}
+
+int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
+			    struct device *dev, ioasid_t pasid)
+{
+	struct pdom_dev_data *pdom_dev_data;
+	struct protection_domain *sva_pdom = to_pdomain(domain);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	/* PASID zero is used for requests from the I/O device without PASID */
+	if (!is_pasid_valid(dev_data, pasid))
+		return ret;
+
+	/* Make sure PASID is enabled */
+	if (!is_pasid_enabled(dev_data))
+		return ret;
+
+	/* Add PASID to protection domain pasid list */
+	pdom_dev_data = kzalloc(sizeof(*pdom_dev_data), GFP_KERNEL);
+	if (pdom_dev_data == NULL)
+		return ret;
+
+	pdom_dev_data->pasid = pasid;
+	pdom_dev_data->dev_data = dev_data;
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	/* Setup GCR3 table */
+	ret = amd_iommu_set_gcr3(dev_data, pasid,
+				 iommu_virt_to_phys(domain->mm->pgd));
+	if (ret) {
+		kfree(pdom_dev_data);
+		goto out_unlock;
+	}
+
+	list_add(&pdom_dev_data->list, &sva_pdom->dev_data_list);
+
+out_unlock:
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+	return ret;
+}
+
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct protection_domain *sva_pdom;
+	struct iommu_domain *domain;
+	unsigned long flags;
+
+	if (!is_pasid_valid(dev_iommu_priv_get(dev), pasid))
+		return;
+
+	/* Get protection domain */
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
+	if (!domain)
+		return;
+	sva_pdom = to_pdomain(domain);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	/* Remove PASID from dev_data_list */
+	remove_pdom_dev_pasid(sva_pdom, dev, pasid);
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
-- 
2.31.1

