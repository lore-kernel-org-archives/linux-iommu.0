Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA76ABB9
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j44sW3mK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ybr0qBnQSv9M9DgXCoAF4ZsfxrAxmviotfGa6I8ooR8Qx/1xoMEhYdrOIQk68SDRqnjRZMorixFiPuk1ML8W+Vn6n7B6dz5jRZiKaXi7Q9VtJpaDYxCW3KxgXY79YqRquovBtXa6BbJHu+UNwtRpRJSWhJDZsazqfxWXJNY5sJb8JvQeudea4Z6cM63SlLxMUoTI5wvq2KdyQrHvXtQ9lHTrGFq+NMygXMG1BMzHnrqZqolFo9UV0BVLoB5/gzjzHDInd94Ivws0ym/t64Gz9VX/Mly2dtoGvrQt1ZuZSwgulxPRT86Sh25ZP0lCpheSpIY+llwYtvHU2uHvv9+Fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZc01Y4sTrPF5mpyKC+f03HTpOlPw4i8NUM4nGRxdKk=;
 b=b9uciwZ5aDqsMFJrd9xp2lWJRKoIOyk8kN4iehT1FMsbFmtizVepRjTgGzt6XGpTTHEiIJF0rrNssSUcWHqfvtP7SCExYj6N1wFBeFpwgxEWAe+ALvt7uzXw+8b2oghIR0USa1DOwRB6OM1EDIxjJy4ZgpsRQ6FEk8mxxGN5vT8KxggFfrrPc5UQWGvYHZMVSfqbpcUf7JpeOvMhh0WadJVMRe1Ecq64mH2JaGT1Z3pGDz9PRAxh/Zq9/05KKuemfhCoWf2ud2E/cUoR0rSsyJeBgEVyKip1J0RAaQuIVuMSlufqHQF6fA4V/ye2zigU8hnHm1uQX/ZtXReNtlKv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZc01Y4sTrPF5mpyKC+f03HTpOlPw4i8NUM4nGRxdKk=;
 b=j44sW3mK3fr05Dre1HZ6KnruW9/vpZYtxTgHzT//iNEWKcr7uWkbIqIb4VOEwku2mHAMUDGbWIZAW3RMMB58C6Bn8JIqME9URoHnpZGlcSAwdDBsM0YOQJwUuKmMP9bO3+C4xLSf8Soc6JjX7roQepX3LSlfDaSh5yYNHZ7XZx0=
Received: from MW4PR03CA0349.namprd03.prod.outlook.com (2603:10b6:303:dc::24)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 11:19:53 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::22) by MW4PR03CA0349.outlook.office365.com
 (2603:10b6:303:dc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 11:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:19:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:19:49 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 12/14] iommu/amd: Initial SVA support for AMD IOMMU
Date: Thu, 21 Dec 2023 11:15:56 +0000
Message-ID: <20231221111558.64652-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221111558.64652-1-vasant.hegde@amd.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 152b2508-1293-432c-484b-08dc0216c125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1wU8bYX9f0ydHPcyceviWOVFl4KFCagCJ+g8N0e3Huwo7nwtej8ZItenDCnwf82rtleAmNo+rE/WaqYofGUt9i6L33mPMjB6g6c1O8dbc0q5WHHCT7jirH1kHCigYVXw68MVwkXK8q/x96amEuJ9rxCWQme2FIA8kCbIJbpnzWmW5F6/LmfVXX47M0SEcnSIibiuFHeWuZ2Su5VEg08jv+q5/GtXinfWA3px+fSU9dwwAgk1PT7aECNZFXoU6LacpWRXWTZy+luoEeG1GZ2OPYAztTh8lnfrXiafHJxtYWEPEEGjmQKcIN5fVrGjD7iqnoUs59YE4Vc2D9XJ8mjxMBAyjc/gU54UgncclJWoP5dQbvE7xQ6d7JngruzCR8gmtnyze5dHMk1cLOxvvckFHeKFEF6v//q9VOfSeVAq4GuGae2r6wRiYlhyDqUVWFKXxr8VCNz+CqUANNuiDTB3vc7yspGJczEO/qRohya3b+YX5hSNSkrDDtMdicE9H8yPl4ll9HpnpSuhZgBMmrjxQlGIRnx4tMx2bigojfODoN8zTZxbyZtMBexZpCOVzQgeEhlo8fApeOz/5RilqXSjV/IF+lO3XMghnoy+A1i9ch8LlOBVIGXVw+uZvdXKDiD+BXvG6ZRmmB2j9nAwO5tNhf8CZluyvkqFZ79mPeaqYfjB0+vigh4qxyIt+FH+BXTLyQjdrp5P9BqpYOcSRKxqf9uDdOB6XyAVw7Vnf75/kSwGnFejVbQXmjmwl7gkEEjNtGY8ax50i6Jxiy6bwaea2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(36756003)(40480700001)(86362001)(40460700003)(70206006)(70586007)(7696005)(6666004)(356005)(81166007)(26005)(5660300002)(83380400001)(4326008)(16526019)(316002)(336012)(2616005)(41300700001)(47076005)(426003)(54906003)(30864003)(8676002)(44832011)(1076003)(478600001)(110136005)(8936002)(2906002)(36860700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:19:53.1343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 152b2508-1293-432c-484b-08dc0216c125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609

This includes :
  - Add data structure to track per protection domain dev/pasid binding details

  - Add support to check PASID is supported or not. Also setup gcr3
    table. Also if PRI is supported then enable IOPF.

  - Move 'to_pdomain()' to header file

  - Add iommu_sva_set_dev_pasid(). It will check whether PASID is supported
    or not. Also adds PASID to SVA protection domain list as well as to
    device GCR3 table.

  - Add iommu_ops.remove_dev_pasid support. It will unbind PASID from
    device. Also remove pasid data from protection domain.

  - Add IOMMU_SVA as dependency to AMD_IOMMU driver

For a given PASID, iommu_set_dev_pasid() will bind all devices to same
SVA protection domain (1 PASID : 1 SVA protection domain : N devices).
This protection domain is different from device protection domain (one
that's mapped in attach_device() path). IOMMU uses domain ID for caching,
invalidation, etc. In SVA mode it will use per-device-domain-ID. Hence in
invalidation path we retrieve domain ID from iommu_dev_data structure and
use that for invalidation.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  11 ++
 drivers/iommu/amd/amd_iommu_types.h |  14 ++
 drivers/iommu/amd/iommu.c           |  14 +-
 drivers/iommu/amd/pasid.c           | 193 ++++++++++++++++++++++++++++
 6 files changed, 229 insertions(+), 6 deletions(-)
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
index 7bc6d530c9a6..c21e7d64ad88 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -44,6 +44,11 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
+/* Protection domain ops */
+int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
+			    struct device *dev, ioasid_t pasid);
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+
 /* SVA/PASID */
 bool amd_iommu_pasid_supported(void);
 int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids);
@@ -72,6 +77,7 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 /* Device capabilities */
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
+bool amd_iommu_pdev_pri_supported(struct pci_dev *pdev);
 
 /* GCR3 setup */
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
@@ -192,6 +198,11 @@ static inline struct amd_iommu *get_amd_iommu_from_dev(struct device *dev)
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
index 626171f0c067..9662a56a3a83 100644
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
@@ -559,6 +561,16 @@ enum protection_domain_mode {
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
@@ -575,6 +587,8 @@ struct protection_domain {
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+
+	struct list_head pasid_list; /* List of pdom_pasid_data */
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 12ac6968c136..7aea652cebd8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -196,11 +196,6 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
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
@@ -346,6 +341,13 @@ static inline bool pdev_pasid_supported(struct iommu_dev_data *dev_data)
 	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP);
 }
 
+inline bool amd_iommu_pdev_pri_supported(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP);
+}
+
 static u32 pdev_get_caps(struct pci_dev *pdev)
 {
 	int features;
@@ -2336,6 +2338,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
+	INIT_LIST_HEAD(&domain->pasid_list);
 	domain->nid = NUMA_NO_NODE;
 
 	switch (type) {
@@ -2865,6 +2868,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
+	.remove_dev_pasid = amd_iommu_remove_dev_pasid,
 	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
new file mode 100644
index 000000000000..cf14ddbc2c4f
--- /dev/null
+++ b/drivers/iommu/amd/pasid.c
@@ -0,0 +1,193 @@
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
+static inline bool is_gcr3_table_empty(struct iommu_dev_data *dev_data)
+{
+	return (dev_data->gcr3_info.pasid_cnt == 0);
+}
+
+static inline bool is_pasid_enabled(struct iommu_dev_data *dev_data)
+{
+	if (dev_data->gcr3_info.gcr3_tbl != NULL &&
+	    !is_gcr3_table_empty(dev_data)) {
+		return true;
+	}
+
+	return false;
+}
+
+static int iommu_pasid_enable(struct iommu_dev_data *dev_data)
+{
+	struct device *dev = dev_data->dev;
+	int ret = 0;
+
+	spin_lock(&dev_data->lock);
+
+	if (is_pasid_enabled(dev_data))
+		goto out;
+
+	if (!amd_iommu_pasid_supported()) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* attach_device path enables device PASID feature */
+	if (!dev_data->pasid_enabled) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = amd_iommu_gcr3_init(dev_data, dev->iommu->max_pasids);
+
+out:
+	spin_unlock(&dev_data->lock);
+	return ret;
+}
+
+static void iommu_pasid_disable(struct iommu_dev_data *dev_data)
+{
+	spin_lock(&dev_data->lock);
+
+	if (!is_gcr3_table_empty(dev_data))
+		goto out;
+
+	if (dev_data->gcr3_info.gcr3_tbl == NULL)
+		goto out;
+
+	amd_iommu_gcr3_uninit(dev_data);
+
+out:
+	spin_unlock(&dev_data->lock);
+}
+
+static int iommu_setup_pasid_pri(struct iommu_dev_data *dev_data)
+{
+	struct pci_dev *pdev;
+	int ret;
+
+	if (is_pasid_enabled(dev_data))
+		return 0;
+
+	ret = iommu_pasid_enable(dev_data);
+	if (ret)
+		return ret;
+
+	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
+	if (!pdev || !amd_iommu_pdev_pri_supported(pdev))
+		return 0;
+
+	if (!dev_data->pri_enabled)
+		return -EINVAL;
+
+	ret = amd_iommu_iopf_enable_device(dev_data->dev);
+
+	return ret;
+}
+
+static void remove_dev_pasid(struct pdom_pasid_data *pasid_data)
+{
+	/* Update GCR3 table and flush IOTLB */
+	amd_iommu_clear_gcr3(pasid_data->dev_data, pasid_data->pasid);
+
+	list_del(&pasid_data->pdom_link);
+	kfree(pasid_data);
+}
+
+static void remove_pdom_dev_pasid(struct protection_domain *pdom,
+				  struct device *dev, ioasid_t pasid)
+{
+	struct pdom_pasid_data *pasid_data;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	lockdep_assert_held(&pdom->lock);
+
+	list_for_each_entry(pasid_data, &pdom->pasid_list, pdom_link) {
+		if (pasid_data->pasid == pasid &&
+		    pasid_data->dev_data == dev_data) {
+			remove_dev_pasid(pasid_data);
+			break;
+		}
+	}
+}
+
+int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
+			    struct device *dev, ioasid_t pasid)
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
+	/* Make sure PASID/PRI is enabled */
+	ret = iommu_setup_pasid_pri(dev_data);
+	if (ret)
+		return ret;
+
+	/* Add PASID to protection domain pasid list */
+	pasid_data = kzalloc(sizeof(*pasid_data), GFP_KERNEL);
+	if (pasid_data == NULL)
+		return ret;
+
+	pasid_data->pasid = pasid;
+	pasid_data->dev_data = dev_data;
+
+	/* Setup GCR3 table */
+	ret = amd_iommu_set_gcr3(dev_data, pasid,
+				 iommu_virt_to_phys(domain->mm->pgd));
+	if (ret) {
+		kfree(pasid_data);
+		return ret;
+	}
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+	list_add(&pasid_data->pdom_link, &sva_pdom->pasid_list);
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+
+	return ret;
+}
+
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
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
+	iopf_queue_flush_dev(dev, pasid);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	/* Remove PASID */
+	remove_pdom_dev_pasid(sva_pdom, dev, pasid);
+
+	/* Remove GCR3 table */
+	if (is_gcr3_table_empty(dev_data))
+		iommu_pasid_disable(dev_data);
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
-- 
2.31.1

