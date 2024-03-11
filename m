Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0251F2375F
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148363; cv=fail; b=AlBdF0rnO9Okny/9H2g4/HiDAz+o6nExUBpe8DkKB0N1Q34+uo/4VJ62J2WNmtvpItKWi1UL6gIxnrIlw3Js70xxPbELG/z0eUYX6PjsFWeQc7veaJ7FbG7PyPtLCn/A9oeIEJ9H+REDKqJx8ddVz2745Q1HAVGkIj8kP1FO3g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148363; c=relaxed/simple;
	bh=naa1Tv+Y11sJn2mixEQ5IR4OPhgCjvFETzz6GP3XkGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKMviaHwLhXZZj9IovUqNcDjeFeRgcsAmk6aU6bydEE24JdyWdsO0BNr2h4uUlB1/pcity1gf6WPHdkjBQPXGG6DcMU3E9uWCp3AH3AwkgfieHtEejg06eepZENYiHoNC1RbX3kvh3cmx5F0nZNR6xXszYHqT+edAQcHeOAO1YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qyy5EvZr; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qyy5EvZr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYVhI+aPIFn+2j2U8wP8cdi1XdKrYCX1STA1IXqAqnG/Ra0SbEHnpbA/iLMpL0h1uHkh3tpjArtawqC2OgfQXJ/uNIlQW882E0sMKIf5W6ETvUSk7gJfq4hcTa8v7Y29QVNMoDf9AC5SsLQgd6VLcld3GN9R9ROkHdnrK4SFoc6na9IyPehszzBMF9qNA4vFaY+L0oBPmrTgPwcGz5mdo7gtQXoo/56LNPpqmMAdYacvANal38RuHZ6wNwlkxqvCSlnahgHSnMZjOH36fhdzR0AUrcgecZkJzQUfRRp/4YypbbTyBTg5Bx6tLVIqHPsO7WXJiXSW7J64TG++y6eqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYdFhVczbWgAJ5HHy6JxiP8s04Qv3NYA6gVgzrngnBM=;
 b=IZtPMFDYXQtzANxFoSWKDolnQA+qeHde86RjLSrJGM5jNKaJVlYQKb2Hal6OEKYJFVw714yx7KSuomEKx249hS1V+fahIFr/c1BrE7vj4//Xhb6sHYsRQVZpUaGOgrAT2osoUnJVMv9P6AUjiJMnegqNaBvKlEixdVnqC4eg/wE36i42z7zdFXZOeqYDOCMoafLc3ATUZgUCps9SgVZc7HmU30E3SjVwfn97dkGQrSOCTQFhfZOR1g/24MqLVsR0D+5VSlfYSrbkb25Yy6ccE014ozYT4GWTIJKRbtHncwpk5Tyo47VaNFSytwQVawspYJf0DCR9SK7fwX/ghuHM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYdFhVczbWgAJ5HHy6JxiP8s04Qv3NYA6gVgzrngnBM=;
 b=qyy5EvZr/RC+ygQT9UBPyMHasz4IMHmouWg2bGS1loZpGwHGZOo3HiEgpjZSi5CiiBuz0pJacWDcXH4uo95QTPo8luTFOeLpLKv78mGqzVdQMRJeOiTijFrEnLrAeUZj2EV7EIkW0BNqeXoxm7xN254NnThMl+uCjXpf/HWdn6s=
Received: from BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) by
 SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 09:12:36 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::34) by BL0PR0102CA0062.outlook.office365.com
 (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 09:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:12:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:12:32 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 13/15] iommu/amd: Initial SVA support for AMD IOMMU
Date: Mon, 11 Mar 2024 09:08:41 +0000
Message-ID: <20240311090843.133455-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cf5af6-3bb1-463f-140f-08dc41ab6438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l8WQbZGS+8ipaagvz9enYKgNSG+RiVPcXfvncoAEamjmmpN+O8biUM2YE0t66zTl4GDAPQJH5Jr8POOHdyOULtXthtKGWcDI5TiL6G/JcH+Wi1C9jk307phNaUUNIC9K3DGlNFgVCRSG9lcFEdt3PcNoZ2ChFawfQICxs7bbicO7A3ckLgda/HZvSLtHzaOk6NCulk/ZT/rxnbdb/pkgnAQrZ8gGOY1udlNLTTgapvNY4ZZKy4oysTRDSY5X+TakrL0GE7KtkBnGDUdavW78cq/LgV7tnVOKVyjL9oGreishzZlZIFYlQSctTPG8/4ihWmCXhBvlFEZ8rq0Rdznf+jhv+qH/9/AYKBfGjiU07OXi9o3eH1kqLT5M9Nlac92EwnBoGZuUK6MJQgndL6VmfavJrfYbYB0WOq8Hf9CuSt9S05A4OsZbzlXFsC7q0A8ndZ0vSdGJzG8YL+5+BErRUisxXAJatlN74OWfkjZ1hS1UrSo5WZr2o19Otykec9YzHrbJDqPV7rqOLVrrdTB4mkUzvOZhBozx+1t++0seFlQxntkqZtVrmQaC+9F1dPsoMGZ3tV8JISB7WeBXegR7slNBPv6c//puvSarST3keHYoELmhpBoX6LBFcY9uFBk2PS+mWSVdy9A9VQeZgzmRuSo1MrWLvfuNXTG766mpElMx9i7omQftRrFO53Bkk+wem5WLbj4xsObfnWlKeyCPuwYjLm/HWbwMBs0ZHWbhLBtf7t1Nzlc8Fbxn0UxhngzH
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:12:35.5908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cf5af6-3bb1-463f-140f-08dc41ab6438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
index 3eaae50dc66d..23e7449f16b8 100644
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
@@ -174,6 +180,11 @@ static inline struct amd_iommu *get_amd_iommu_from_dev_data(struct iommu_dev_dat
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
index 61ca32b7bb07..ed9971cd3f0e 100644
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
 
 struct amd_iommu;
 struct iommu_domain;
@@ -552,6 +559,16 @@ enum protection_domain_mode {
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
@@ -568,6 +585,8 @@ struct protection_domain {
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+
+	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 92a2df8cbdad..82fdfd68cf6d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -194,11 +194,6 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
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
@@ -2342,6 +2337,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
+	INIT_LIST_HEAD(&domain->dev_data_list);
 	domain->nid = NUMA_NO_NODE;
 
 	switch (type) {
@@ -2871,6 +2867,7 @@ const struct iommu_ops amd_iommu_ops = {
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

