Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA8C131
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+sRW/lhHtQNfATInP3dCMQVNAGmSHyOmXv6RTBQecWzdCr43VEMMeopezyp5I4BW8m6CvZU0G7t1h+KXcrhxrLRV+3eNVbGDtRvEk+jRb9epDEoOiuMAHHyn0R2xChaJPcSdRlY1szu56HvW/J2ps/C5k+g8Oo8o9+Tl4Fh51jjI7IC59Jp7KznskfQlpFuVAz3obOmYOSf2coAgoIhqoHSBWgns99pEsGbtHo0xuNhxIey5CLM1ovXJyr/zeT3b8lxdYbx/en9VUcQ/2z5U77rSauVKAK9mAcQI1oMgPBJkrZUo4UvWRIty5D/WWWySAyDyS/tI/IOlD1K9t0BtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2gf6N/Ns1imekVUQ/kAuICWsXsUFLwDJOEUkd/Iu84=;
 b=kGYYz3DhLcGK1VlvoS0ORm3zY/zFgLjHX3h2C7RI7UttD7GJHxcL5JR9BJNgHWeELDW09Anl2rsyyBEqYIl1SJoU8Ws5WNNVIqWKO15OeGbZn5/p5eH4VnvSA8WmrOYpAMi3EMHu2OLD5IBcUjfv7Zq/YJftUNiXi+smvwhPlXyMFv+L8tlb4tFCwt5Zu/CaN8XpmSuHNl6svxcvpidMGtqAecJORZWzn/Sb0C/Qcsstt8LLfAWF28kD8F+8GOJxYzzF2SZCCZGaz8oK5Nl09BBWSo7Z/QtMkeZfX/VS8q0cVKbntBRjguGNTDVDb/k/nOyyIY5g+n4Fv7k/gYsgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2gf6N/Ns1imekVUQ/kAuICWsXsUFLwDJOEUkd/Iu84=;
 b=CyKunm51/d2WZGhu+0XNcb5kTOv+XEi9cfyPA5FO2XOpvHJJuhheaLzFtN1ruy2+vkGu/PxswVM3VpS8zegCkGp6BQivTEOIHmfxpai3KrQzPJIOLZ8DqxC7fl5PZdmfIf+c24oQbSINimeZ+FepxIaVI17A/xu8s/SAD3PDVFQ=
Received: from MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::33)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 14:05:39 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::70) by MW4P223CA0028.outlook.office365.com
 (2603:10b6:303:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 14:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 14:05:39 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 09:05:35 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH RESEND 03/10] iommu/amd: Initial SVA support for AMD IOMMU
Date: Wed, 23 Aug 2023 14:04:08 +0000
Message-ID: <20230823140415.729050-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823140415.729050-1-vasant.hegde@amd.com>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 911c7c4d-bd29-4d88-f69d-08dba3e207f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6yO0fMQ86LbZaJP2RNFFS4d6IE1HWcGC252CO0HvGu8lNqdwLlf5CUOAbKRzlKVRLQ3ptS7i7b7Wh2n69z4HTainK5V7HMhyBCpMfG1FyClQV6+HVgw+6mRYrlgY5jn0IN5V71K/osRcD1QGv3K2ADVlRsVaAVEKgUqtDhO6EfxFimX/rocPcGBd76yEoMEy3MdRfBj63g/OfxKDmzW3hCwxhRE5w6loSk37382F3+MA4QX4kuU9tjTG1Pey0vo6ZJqBZfHe0NEHX3UYeD3Kc0h+fmg+TGyaDcXg5PDSWR8cRVuduO94Qgb+TLLxjARLPxaLhuUKpu9vApneFKQma7hlLIeVpE9BV+Hv7qQ2nQKQdHWc+z/G93xUucVSBCdtZiiy7g89MZibJIoKRiQG+OukeCo2hp2WMeYNdsJE6TCmkSafYYkBoViBCORLrNtq0cfzfBtV8vaWL/TsHry1wXRkMlRzQ+FyULOeuzO9EwTpY1Qi3bcyMWGbmXT+/umtgr2SVBRHVWK2PDUpsF0UYNtwKUvrgyP0ogPSzLoVWrmHwxrNqSepZhvEeLADKWWfAEws49LoUQAVe62VimNIJCdRC7wDeOaWf7rIZOBKem64ItWgzc+dva9XlpNFeTMZ8XBfo+TBFRGF7i9rI9wOYlVojmO3RVGnDcYMCZ5YRQ4QW79K2jTuxxykXUIaBvk+ifsmYPPYUoM1SrKGSBdglDPSlRVUMZANvE3S1UaSZAHTjm+BOPbS3PfvOscHLlUICzXHzPsG4lFfz6plKZeatA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(30864003)(83380400001)(2906002)(70586007)(7696005)(478600001)(8936002)(16526019)(2616005)(5660300002)(26005)(426003)(336012)(44832011)(1076003)(47076005)(4326008)(8676002)(70206006)(82740400003)(81166007)(356005)(36860700001)(110136005)(6666004)(316002)(54906003)(41300700001)(40480700001)(86362001)(40460700003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:05:39.2925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 911c7c4d-bd29-4d88-f69d-08dba3e207f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

This includes :
  - Add support to allocate SVA domain. It also sets 'set_dev_pasid'
    to bind PASID to device and make necessary updates to DTE.

  - Add iommu_ops.remove_dev_pasid support. It will unbind PASID from
    device and makes necessary update to DTE.

  - PASID management
    xarray to keep track the PASIDs
    struct amd_sva_pasid
      It will contain mm struct, mmu notifier, protection domain and list
      of devices within IOMMU group using this pasid.
    struct amd_sva_dev
      This contains device list and pointer to iommu_dev_data. So that we
      can track pasid to device binding.

  - mmu notifier for iotlb invalidation

  - Add IOMMU_SVA as dependency to AMD_IOMMU driver

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |   5 +
 drivers/iommu/amd/amd_iommu_types.h |  10 +
 drivers/iommu/amd/iommu.c           |  10 +
 drivers/iommu/amd/sva.c             | 299 ++++++++++++++++++++++++++++
 6 files changed, 326 insertions(+), 1 deletion(-)
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
index f236d540c917..6fdad7a54781 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -41,7 +41,12 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
+/* SVA */
 bool amd_iommu_sva_supported(void);
+int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
+			    struct device *dev, ioasid_t pasid);
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index b1a54d8c7506..88b9e41b6fbc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -922,6 +922,16 @@ static inline int get_hpet_devid(int id)
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
index 8fd647c0d657..46bb1bfdc322 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -76,6 +76,7 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
+static void amd_iommu_domain_free(struct iommu_domain *dom);
 
 static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 			  struct gcr3_tbl_info *gcr3_info,
@@ -2187,6 +2188,11 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
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
@@ -2221,6 +2227,9 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	case IOMMU_DOMAIN_UNMANAGED:
 		pgtable = AMD_IOMMU_V1;
 		break;
+	case IOMMU_DOMAIN_SVA:
+		domain->domain.ops = &amd_svm_domain_ops;
+		return domain;
 	default:
 		goto out_err;
 	}
@@ -2602,6 +2611,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
+	.remove_dev_pasid = amd_iommu_remove_dev_pasid,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
diff --git a/drivers/iommu/amd/sva.c b/drivers/iommu/amd/sva.c
new file mode 100644
index 000000000000..c7c7e7cb5414
--- /dev/null
+++ b/drivers/iommu/amd/sva.c
@@ -0,0 +1,299 @@
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
+#include "../iommu-sva.h"
+
+struct amd_sva_pasid {
+	u32			pasid;	/* PASID index */
+	struct mm_struct	*mm;	/* mm_struct for the faults */
+	struct mmu_notifier	mn;	/* mmu_notifier handle */
+	struct list_head	dev_list; /* List of devices for this pasid */
+};
+
+struct amd_sva_dev {
+	struct device		*dev;
+	struct iommu_dev_data	*dev_data;
+	struct list_head	list;
+	struct rcu_head		rcu;
+};
+
+static DEFINE_MUTEX(pasid_mutex);
+static DEFINE_XARRAY_ALLOC(sva_pasid_array);
+
+
+static int sva_pasid_private_add(u32 pasid, void *priv)
+{
+	return xa_alloc(&sva_pasid_array, &pasid, priv,
+			XA_LIMIT(pasid, pasid), GFP_ATOMIC);
+}
+
+static void sva_pasid_private_remove(u32 pasid)
+{
+	xa_erase(&sva_pasid_array, pasid);
+}
+
+static void *sva_pasid_private_find(u32 pasid)
+{
+	return xa_load(&sva_pasid_array, pasid);
+}
+
+static struct amd_sva_dev *sva_dev_alloc(struct device *dev)
+{
+	struct amd_sva_dev *sva_dev;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	sva_dev = kzalloc(sizeof(*sva_dev), GFP_KERNEL);
+	if (!sva_dev)
+		return NULL;
+
+	sva_dev->dev = dev;
+	sva_dev->dev_data = dev_data;
+	init_rcu_head(&sva_dev->rcu);
+
+	return sva_dev;
+}
+
+static inline void sva_dev_free(struct amd_sva_dev *sva_dev)
+{
+	kfree_rcu(sva_dev, rcu);
+}
+
+static void sva_mn_invalidate_range(struct mmu_notifier *mn,
+				    struct mm_struct *mm,
+				    unsigned long start, unsigned long end)
+{
+	struct amd_sva_pasid *sva_pasid;
+	struct amd_sva_dev *sva_dev;
+
+	rcu_read_lock();
+
+	sva_pasid = container_of(mn, struct amd_sva_pasid, mn);
+	if (!sva_pasid) {
+		rcu_read_unlock();
+		return;
+	}
+
+	list_for_each_entry_rcu(sva_dev, &sva_pasid->dev_list, list) {
+		if ((start ^ (end - 1)) < PAGE_SIZE)
+			amd_iommu_flush_page(sva_dev->dev_data->domain, sva_pasid->pasid, start);
+		else
+			amd_iommu_flush_tlb(sva_dev->dev_data->domain, sva_pasid->pasid);
+	}
+
+	rcu_read_unlock();
+}
+
+static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct amd_sva_pasid *sva_pasid;
+	struct amd_sva_dev *sva_dev;
+
+	rcu_read_lock();
+
+	sva_pasid = container_of(mn, struct amd_sva_pasid, mn);
+	if (!sva_pasid) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/* make it visible */
+	smp_wmb();
+
+	/*
+	 * This might end up being called from exit_mmap(), *before* unbinding
+	 * the PASID. In such cases we clear the PASID table and flush IOTLB.
+	 */
+	list_for_each_entry_rcu(sva_dev, &sva_pasid->dev_list, list)
+		amd_iommu_clear_gcr3(sva_dev->dev_data, sva_pasid->pasid);
+
+	rcu_read_unlock();
+}
+
+static const struct mmu_notifier_ops sva_mn = {
+	.invalidate_range = sva_mn_invalidate_range,
+	.release = sva_mn_release,
+};
+
+static struct amd_sva_pasid *sva_pasid_alloc(struct mm_struct *mm)
+{
+	struct amd_sva_pasid *sva_pasid;
+
+	sva_pasid = kzalloc(sizeof(*sva_pasid), GFP_KERNEL);
+	if (!sva_pasid)
+		return NULL;
+
+	sva_pasid->pasid = mm->pasid;
+	sva_pasid->mm = mm;
+	sva_pasid->mn.ops = &sva_mn;
+	INIT_LIST_HEAD(&sva_pasid->dev_list);
+
+	return sva_pasid;
+}
+
+static inline void sva_pasid_free(struct amd_sva_pasid *sva_pasid)
+{
+	kfree(sva_pasid);
+}
+
+static struct amd_sva_dev *pasid_to_sva_dev(struct device *dev,
+					    struct amd_sva_pasid *sva_pasid)
+{
+	struct amd_sva_dev *sva_dev;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(sva_dev, &sva_pasid->dev_list, list) {
+		if (sva_dev->dev == dev) {
+			rcu_read_unlock();
+			return sva_dev;
+		}
+	}
+
+	rcu_read_unlock();
+	return NULL;
+}
+
+static int sva_bind_mm(struct device *dev, struct mm_struct *mm)
+{
+	struct amd_sva_pasid *sva_pasid;
+	struct amd_sva_dev *sva_dev;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	int ret = -EINVAL;
+
+	sva_dev = sva_dev_alloc(dev);
+	if (!sva_dev)
+		return ret;
+
+	sva_pasid = sva_pasid_private_find(mm->pasid);
+	if (!sva_pasid) {
+		sva_pasid = sva_pasid_alloc(mm);
+		if (!sva_pasid)
+			goto out_sva_dev;
+
+		ret = sva_pasid_private_add(sva_pasid->pasid, sva_pasid);
+		if (ret)
+			goto out_sva_pasid;
+
+		ret = amd_iommu_set_gcr3(dev_data, sva_pasid->pasid,
+					 iommu_virt_to_phys(sva_pasid->mm->pgd));
+		if (ret)
+			goto out_pasid_remove;
+
+		ret = mmu_notifier_register(&sva_pasid->mn, mm);
+		if (ret)
+			goto out_clear_gcr3;
+	}
+
+	/* Add sva_dev into list */
+	list_add(&sva_dev->list, &sva_pasid->dev_list);
+	return 0;
+
+out_clear_gcr3:
+	amd_iommu_clear_gcr3(dev_data, sva_pasid->pasid);
+
+out_pasid_remove:
+	sva_pasid_private_remove(sva_pasid->pasid);
+
+out_sva_pasid:
+	sva_pasid_free(sva_pasid);
+
+out_sva_dev:
+	sva_dev_free(sva_dev);
+	return ret;
+}
+
+static void sva_unbind_mm(struct device *dev, u32 pasid)
+{
+	struct amd_sva_pasid *sva_pasid;
+	struct amd_sva_dev *sva_dev;
+
+	sva_pasid = sva_pasid_private_find(pasid);
+	if (!sva_pasid)
+		return;
+
+	sva_dev = pasid_to_sva_dev(dev, sva_pasid);
+	if (!sva_dev)
+		return;
+
+	/* make it visible */
+	smp_wmb();
+
+	/* Update GCR3 table and flush IOTLB */
+	amd_iommu_clear_gcr3(sva_dev->dev_data, sva_pasid->pasid);
+
+	list_del_rcu(&sva_dev->list);
+	sva_dev_free(sva_dev);
+
+	if (list_empty(&sva_pasid->dev_list)) {
+		if (sva_pasid->mn.ops)
+			mmu_notifier_unregister(&sva_pasid->mn, sva_pasid->mm);
+
+		sva_pasid_private_remove(pasid);
+		sva_pasid_free(sva_pasid);
+	}
+}
+
+int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
+			    struct device *dev, ioasid_t pasid)
+{
+	struct protection_domain *pdom;
+	struct mm_struct *mm = domain->mm;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	int ret = -EINVAL;
+
+	/* PASID zero is used for requests from the I/O device without PASID */
+	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
+		return ret;
+
+	/* Make sure SVA mode is enabled for device default domain */
+	pdom = amd_iommu_get_pdomain(dev);
+
+	if (!pdom || pdom->pd_mode != PD_MODE_V2 ||
+	    dev_data->gcr3_info.gcr3_tbl == NULL)
+		return ret;
+
+	/* Init sva_pasid and bind mm */
+	mutex_lock(&pasid_mutex);
+	ret = sva_bind_mm(dev, mm);
+	mutex_unlock(&pasid_mutex);
+
+	return ret;
+}
+
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+
+	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
+		return;
+
+	/* Get SVA domain */
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
+	if (!domain)
+		return;
+
+	switch (domain->type) {
+	case IOMMU_DOMAIN_SVA:
+		/* Ensure that all queued faults have been processed */
+		iopf_queue_flush_dev(dev);
+
+		mutex_lock(&pasid_mutex);
+		sva_unbind_mm(dev, pasid);
+		mutex_unlock(&pasid_mutex);
+		break;
+	default:
+		/* Should never reach here */
+		WARN_ON(1);
+		break;
+	}
+}
-- 
2.31.1

