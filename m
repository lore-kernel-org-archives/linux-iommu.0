Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56443C1D
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W02IXYahC5LetYBQx3QgIV15fiCcQFyWWsJ/wvD+08Jwk6nUns2k0A5t53dRwfpNH3oFTSAC0hvmVDqkH+C2Z5gAVAKb0J5guMmfY3hsjc9irftxW8Fs+R8OvSw5g6TPilbQtNunrlUV7CaG+q68pIdlid4V5oVEgjPS/6cDaZ+Qj/IbvdChRZkQ2mWw24fisH+rrDGWagtTHsDYUiXYr+AiL34Sj8feWS6MuP1s+l2NO4Xd8KdvCI+EKzRisfHEC43yVJuN4c5J9QS0ss3YT6tvzbEmw19P7Raf064OlCD1NSdReDGixKg0WmYaTJ2Qt0ynbXTW1cRzqL8ISy2jLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7CEXqGoao5F7cfbYOL4mXXlkaAsrpyQQHNjftEmIAE=;
 b=kuEzwz4NGxDViiND2Sm+TR7JebTUXtg8FOZOKlPtbH9DMsXfWmQZW4LzZ876IZ0vFGh1ormZH/HtsWY7zv6a2tJiGms4v2n5ZzjR7Rq56wtOgqkHNrZskOSKcV08yDXZuOssANb726gjEzG0Yi3pJrI8kjvozzXxN3ygx/Mdn8e6zGZTPw28/dMxuCab9W4U2w5EOp5GMNDmVwpe3XtAp5XDWOklbPWazimLFfx2gM2357wJtIu1gxoRMode7SmsVDgox3HUTEhM2jAtdX25FBjMubReBGMknevq3c5kdMP2qp8mKWeKMeCyrF8xRwK771Dji3aA81tOkak70mPheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7CEXqGoao5F7cfbYOL4mXXlkaAsrpyQQHNjftEmIAE=;
 b=faVpDcq2klTfFydENhxmAWsjR3LkYyMJJLAVMZIyUoMwbqqRNPh1ImA3Li9tt2MvWMdv3EaBIBOYl9n5QdmvU/CCzc9Zzhx9mpiLgQ5SdwtGxg6v7/LnA69/eQAv4vod/By8uFvRikZNYhEY7+njNFhOipQl+TU5dtTHeH1pPAs=
Received: from DM6PR06CA0083.namprd06.prod.outlook.com (2603:10b6:5:336::16)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:33:32 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::40) by DM6PR06CA0083.outlook.office365.com
 (2603:10b6:5:336::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 10:33:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:33:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
	<Felix.Kuehling@amd.com>
Subject: [PATCH 1/4] iommu/amd: Remove iommu_v2 module
Date: Tue, 15 Aug 2023 10:32:52 +0000
Message-ID: <20230815103255.565295-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815103255.565295-1-vasant.hegde@amd.com>
References: <20230815103255.565295-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: e171707a-86c0-4643-36f8-08db9d7b125c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ho6spStWCaV36GWZrNIINm06Km3Y/y85x2dHM/2goYpXybd7B+64ylkj5tkcG1N2HMYMZbbqClcjPjlc51nD0+B97MjCbZzVIb3EyzMxVCm7s8RilTUFBYuGecJYzcJwlbbLcySYdVrR4veswDtC5IdjXO4w6FeHvnUQDF8OR9OPlBE9HOwIT+cGHI+rACVv5RqmvIc8artj4CF88O6gnvgIXD9MFyLv86uLupeYdOXwefcpCABPbwD2y0phuuC0HHwjnKTBbhW4moAqF8Lws6wRSewjn++8kMloTMGG8FEkK86FlBcxKB1lRZVPfd3da+XMbhIiU3P9SlaxO1EgRHO3NMt2PRomUdN9MYzkSZMoO8L2tOtxRA+k+O2GeH1o5C8QhuuR1EOdrGpgdEH18fOzfbOKgJ6/7SMXxtThq93NFCSH/GiRmqhf8vqLlxOhPRkG1pYL/9vwWRocLGaqSXW8BvVbsEdNVUxnV8R6Ok/XggxDW4mIPZ2uOIxmta4zYRhfgxf3TFasdndFD6QE6MM6xAlPw4Y/SKJRdLHgVqBlgglOWWqtF3p52+N+ZcF3N8G6Xp0dRZbcLZT8b29wsD/RElqqh4AxBUHd+Atd1zt1wfbrjuZdw8NAO0k6YsHpiZAnmXcUn4fyzYGRgOKMUCy/Q5mddjjuJfg+nzt/1lg40GQhEXvF2X8exLNT+PpFXSP4SFIbhuhKfFAZY9NJD5wAzjGORVIHc6ZTdWSbjpqmgJFczI9/yZdDz6FbABE3
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(1800799006)(186006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(966005)(6666004)(70206006)(70586007)(478600001)(7696005)(110136005)(1076003)(336012)(2616005)(426003)(26005)(40480700001)(2906002)(8676002)(8936002)(54906003)(5660300002)(41300700001)(30864003)(316002)(4326008)(82740400003)(356005)(81166007)(36756003)(86362001)(83380400001)(47076005)(16526019)(36860700001)(44832011)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:33:31.6691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e171707a-86c0-4643-36f8-08db9d7b125c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

AMD GPU driver which was the only in-kernel user of iommu_v2 module is
removing dependency on iommu_v2 module [1].

[1] https://patchwork.freedesktop.org/series/122124/

Also we are working on adding SVA support in AMD IOMMU driver. Device
drivers are expected to use common SVA framework to enable device
PASID/PRI features.

Removing iommu_v2 module and then adding SVA simplifies the development.
Hence remove iommu_v2 module.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig     |   9 -
 drivers/iommu/amd/Makefile    |   1 -
 drivers/iommu/amd/amd_iommu.h |   5 -
 drivers/iommu/amd/iommu.c     |  40 --
 drivers/iommu/amd/iommu_v2.c  | 996 ----------------------------------
 include/linux/amd-iommu.h     |  94 ----
 6 files changed, 1145 deletions(-)
 delete mode 100644 drivers/iommu/amd/iommu_v2.c

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 9b5fc3356bf2..75132ae861a2 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -22,15 +22,6 @@ config AMD_IOMMU
 	  your BIOS for an option to enable it or if you have an IVRS ACPI
 	  table.
 
-config AMD_IOMMU_V2
-	tristate "AMD IOMMU Version 2 driver"
-	depends on AMD_IOMMU
-	select MMU_NOTIFIER
-	help
-	  This option enables support for the AMD IOMMUv2 features of the IOMMU
-	  hardware. Select this option if you want to use devices that support
-	  the PCI PRI and PASID interface.
-
 config AMD_IOMMU_DEBUGFS
 	bool "Enable AMD IOMMU internals in DebugFS"
 	depends on AMD_IOMMU && IOMMU_DEBUGFS
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 773d8aa00283..f454fbb1569e 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
-obj-$(CONFIG_AMD_IOMMU_V2) += iommu_v2.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 88a05f1a61e0..1b8295db60e7 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -41,9 +41,6 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
-/* IOMMUv2 specific functions */
-struct iommu_domain;
-
 bool amd_iommu_v2_supported(void);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
@@ -60,8 +57,6 @@ void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 
 int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
 int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
-void amd_iommu_domain_direct_map(struct iommu_domain *dom);
-int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
 int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 26e09b584e70..9bd0c66ad881 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2568,46 +2568,6 @@ int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(amd_iommu_unregister_ppr_notifier);
 
-void amd_iommu_domain_direct_map(struct iommu_domain *dom)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	if (domain->iop.pgtbl_cfg.tlb)
-		free_io_pgtable_ops(&domain->iop.iop.ops);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-EXPORT_SYMBOL(amd_iommu_domain_direct_map);
-
-int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
-{
-	struct protection_domain *pdom = to_pdomain(dom);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&pdom->lock, flags);
-
-	/*
-	 * Save us all sanity checks whether devices already in the
-	 * domain support IOMMUv2. Just force that the domain has no
-	 * devices attached when it is switched into IOMMUv2 mode.
-	 */
-	ret = -EBUSY;
-	if (pdom->dev_cnt > 0 || pdom->flags & PD_IOMMUV2_MASK)
-		goto out;
-
-	if (!pdom->gcr3_tbl)
-		ret = setup_gcr3_table(pdom, pasids);
-
-out:
-	spin_unlock_irqrestore(&pdom->lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(amd_iommu_domain_enable_v2);
-
 static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			 u64 address, bool size)
 {
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
deleted file mode 100644
index c5825e0a6770..000000000000
--- a/drivers/iommu/amd/iommu_v2.c
+++ /dev/null
@@ -1,996 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2010-2012 Advanced Micro Devices, Inc.
- * Author: Joerg Roedel <jroedel@suse.de>
- */
-
-#define pr_fmt(fmt)     "AMD-Vi: " fmt
-
-#include <linux/refcount.h>
-#include <linux/mmu_notifier.h>
-#include <linux/amd-iommu.h>
-#include <linux/mm_types.h>
-#include <linux/profile.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/sched/mm.h>
-#include <linux/wait.h>
-#include <linux/pci.h>
-#include <linux/gfp.h>
-#include <linux/cc_platform.h>
-
-#include "amd_iommu.h"
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Joerg Roedel <jroedel@suse.de>");
-
-#define PRI_QUEUE_SIZE		512
-
-struct pri_queue {
-	atomic_t inflight;
-	bool finish;
-	int status;
-};
-
-struct pasid_state {
-	struct list_head list;			/* For global state-list */
-	refcount_t count;				/* Reference count */
-	unsigned mmu_notifier_count;		/* Counting nested mmu_notifier
-						   calls */
-	struct mm_struct *mm;			/* mm_struct for the faults */
-	struct mmu_notifier mn;                 /* mmu_notifier handle */
-	struct pri_queue pri[PRI_QUEUE_SIZE];	/* PRI tag states */
-	struct device_state *device_state;	/* Link to our device_state */
-	u32 pasid;				/* PASID index */
-	bool invalid;				/* Used during setup and
-						   teardown of the pasid */
-	spinlock_t lock;			/* Protect pri_queues and
-						   mmu_notifer_count */
-	wait_queue_head_t wq;			/* To wait for count == 0 */
-};
-
-struct device_state {
-	struct list_head list;
-	u32 sbdf;
-	atomic_t count;
-	struct pci_dev *pdev;
-	struct pasid_state **states;
-	struct iommu_domain *domain;
-	int pasid_levels;
-	int max_pasids;
-	amd_iommu_invalid_ppr_cb inv_ppr_cb;
-	amd_iommu_invalidate_ctx inv_ctx_cb;
-	spinlock_t lock;
-	wait_queue_head_t wq;
-};
-
-struct fault {
-	struct work_struct work;
-	struct device_state *dev_state;
-	struct pasid_state *state;
-	struct mm_struct *mm;
-	u64 address;
-	u32 pasid;
-	u16 tag;
-	u16 finish;
-	u16 flags;
-};
-
-static LIST_HEAD(state_list);
-static DEFINE_SPINLOCK(state_lock);
-
-static struct workqueue_struct *iommu_wq;
-
-static void free_pasid_states(struct device_state *dev_state);
-
-static struct device_state *__get_device_state(u32 sbdf)
-{
-	struct device_state *dev_state;
-
-	list_for_each_entry(dev_state, &state_list, list) {
-		if (dev_state->sbdf == sbdf)
-			return dev_state;
-	}
-
-	return NULL;
-}
-
-static struct device_state *get_device_state(u32 sbdf)
-{
-	struct device_state *dev_state;
-	unsigned long flags;
-
-	spin_lock_irqsave(&state_lock, flags);
-	dev_state = __get_device_state(sbdf);
-	if (dev_state != NULL)
-		atomic_inc(&dev_state->count);
-	spin_unlock_irqrestore(&state_lock, flags);
-
-	return dev_state;
-}
-
-static void free_device_state(struct device_state *dev_state)
-{
-	struct iommu_group *group;
-
-	/* Get rid of any remaining pasid states */
-	free_pasid_states(dev_state);
-
-	/*
-	 * Wait until the last reference is dropped before freeing
-	 * the device state.
-	 */
-	wait_event(dev_state->wq, !atomic_read(&dev_state->count));
-
-	/*
-	 * First detach device from domain - No more PRI requests will arrive
-	 * from that device after it is unbound from the IOMMUv2 domain.
-	 */
-	group = iommu_group_get(&dev_state->pdev->dev);
-	if (WARN_ON(!group))
-		return;
-
-	iommu_detach_group(dev_state->domain, group);
-
-	iommu_group_put(group);
-
-	/* Everything is down now, free the IOMMUv2 domain */
-	iommu_domain_free(dev_state->domain);
-
-	/* Finally get rid of the device-state */
-	kfree(dev_state);
-}
-
-static void put_device_state(struct device_state *dev_state)
-{
-	if (atomic_dec_and_test(&dev_state->count))
-		wake_up(&dev_state->wq);
-}
-
-/* Must be called under dev_state->lock */
-static struct pasid_state **__get_pasid_state_ptr(struct device_state *dev_state,
-						  u32 pasid, bool alloc)
-{
-	struct pasid_state **root, **ptr;
-	int level, index;
-
-	level = dev_state->pasid_levels;
-	root  = dev_state->states;
-
-	while (true) {
-
-		index = (pasid >> (9 * level)) & 0x1ff;
-		ptr   = &root[index];
-
-		if (level == 0)
-			break;
-
-		if (*ptr == NULL) {
-			if (!alloc)
-				return NULL;
-
-			*ptr = (void *)get_zeroed_page(GFP_ATOMIC);
-			if (*ptr == NULL)
-				return NULL;
-		}
-
-		root   = (struct pasid_state **)*ptr;
-		level -= 1;
-	}
-
-	return ptr;
-}
-
-static int set_pasid_state(struct device_state *dev_state,
-			   struct pasid_state *pasid_state,
-			   u32 pasid)
-{
-	struct pasid_state **ptr;
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&dev_state->lock, flags);
-	ptr = __get_pasid_state_ptr(dev_state, pasid, true);
-
-	ret = -ENOMEM;
-	if (ptr == NULL)
-		goto out_unlock;
-
-	ret = -ENOMEM;
-	if (*ptr != NULL)
-		goto out_unlock;
-
-	*ptr = pasid_state;
-
-	ret = 0;
-
-out_unlock:
-	spin_unlock_irqrestore(&dev_state->lock, flags);
-
-	return ret;
-}
-
-static void clear_pasid_state(struct device_state *dev_state, u32 pasid)
-{
-	struct pasid_state **ptr;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev_state->lock, flags);
-	ptr = __get_pasid_state_ptr(dev_state, pasid, true);
-
-	if (ptr == NULL)
-		goto out_unlock;
-
-	*ptr = NULL;
-
-out_unlock:
-	spin_unlock_irqrestore(&dev_state->lock, flags);
-}
-
-static struct pasid_state *get_pasid_state(struct device_state *dev_state,
-					   u32 pasid)
-{
-	struct pasid_state **ptr, *ret = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev_state->lock, flags);
-	ptr = __get_pasid_state_ptr(dev_state, pasid, false);
-
-	if (ptr == NULL)
-		goto out_unlock;
-
-	ret = *ptr;
-	if (ret)
-		refcount_inc(&ret->count);
-
-out_unlock:
-	spin_unlock_irqrestore(&dev_state->lock, flags);
-
-	return ret;
-}
-
-static void free_pasid_state(struct pasid_state *pasid_state)
-{
-	kfree(pasid_state);
-}
-
-static void put_pasid_state(struct pasid_state *pasid_state)
-{
-	if (refcount_dec_and_test(&pasid_state->count))
-		wake_up(&pasid_state->wq);
-}
-
-static void put_pasid_state_wait(struct pasid_state *pasid_state)
-{
-	if (!refcount_dec_and_test(&pasid_state->count))
-		wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
-	free_pasid_state(pasid_state);
-}
-
-static void unbind_pasid(struct pasid_state *pasid_state)
-{
-	struct iommu_domain *domain;
-
-	domain = pasid_state->device_state->domain;
-
-	/*
-	 * Mark pasid_state as invalid, no more faults will we added to the
-	 * work queue after this is visible everywhere.
-	 */
-	pasid_state->invalid = true;
-
-	/* Make sure this is visible */
-	smp_wmb();
-
-	/* After this the device/pasid can't access the mm anymore */
-	amd_iommu_domain_clear_gcr3(domain, pasid_state->pasid);
-
-	/* Make sure no more pending faults are in the queue */
-	flush_workqueue(iommu_wq);
-}
-
-static void free_pasid_states_level1(struct pasid_state **tbl)
-{
-	int i;
-
-	for (i = 0; i < 512; ++i) {
-		if (tbl[i] == NULL)
-			continue;
-
-		free_page((unsigned long)tbl[i]);
-	}
-}
-
-static void free_pasid_states_level2(struct pasid_state **tbl)
-{
-	struct pasid_state **ptr;
-	int i;
-
-	for (i = 0; i < 512; ++i) {
-		if (tbl[i] == NULL)
-			continue;
-
-		ptr = (struct pasid_state **)tbl[i];
-		free_pasid_states_level1(ptr);
-	}
-}
-
-static void free_pasid_states(struct device_state *dev_state)
-{
-	struct pasid_state *pasid_state;
-	int i;
-
-	for (i = 0; i < dev_state->max_pasids; ++i) {
-		pasid_state = get_pasid_state(dev_state, i);
-		if (pasid_state == NULL)
-			continue;
-
-		put_pasid_state(pasid_state);
-
-		/* Clear the pasid state so that the pasid can be re-used */
-		clear_pasid_state(dev_state, pasid_state->pasid);
-
-		/*
-		 * This will call the mn_release function and
-		 * unbind the PASID
-		 */
-		mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
-
-		put_pasid_state_wait(pasid_state); /* Reference taken in
-						      amd_iommu_bind_pasid */
-
-		/* Drop reference taken in amd_iommu_bind_pasid */
-		put_device_state(dev_state);
-	}
-
-	if (dev_state->pasid_levels == 2)
-		free_pasid_states_level2(dev_state->states);
-	else if (dev_state->pasid_levels == 1)
-		free_pasid_states_level1(dev_state->states);
-	else
-		BUG_ON(dev_state->pasid_levels != 0);
-
-	free_page((unsigned long)dev_state->states);
-}
-
-static struct pasid_state *mn_to_state(struct mmu_notifier *mn)
-{
-	return container_of(mn, struct pasid_state, mn);
-}
-
-static void mn_invalidate_range(struct mmu_notifier *mn,
-				struct mm_struct *mm,
-				unsigned long start, unsigned long end)
-{
-	struct pasid_state *pasid_state;
-	struct device_state *dev_state;
-
-	pasid_state = mn_to_state(mn);
-	dev_state   = pasid_state->device_state;
-
-	if ((start ^ (end - 1)) < PAGE_SIZE)
-		amd_iommu_flush_page(dev_state->domain, pasid_state->pasid,
-				     start);
-	else
-		amd_iommu_flush_tlb(dev_state->domain, pasid_state->pasid);
-}
-
-static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
-{
-	struct pasid_state *pasid_state;
-	struct device_state *dev_state;
-	bool run_inv_ctx_cb;
-
-	might_sleep();
-
-	pasid_state    = mn_to_state(mn);
-	dev_state      = pasid_state->device_state;
-	run_inv_ctx_cb = !pasid_state->invalid;
-
-	if (run_inv_ctx_cb && dev_state->inv_ctx_cb)
-		dev_state->inv_ctx_cb(dev_state->pdev, pasid_state->pasid);
-
-	unbind_pasid(pasid_state);
-}
-
-static const struct mmu_notifier_ops iommu_mn = {
-	.release		= mn_release,
-	.invalidate_range       = mn_invalidate_range,
-};
-
-static void set_pri_tag_status(struct pasid_state *pasid_state,
-			       u16 tag, int status)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&pasid_state->lock, flags);
-	pasid_state->pri[tag].status = status;
-	spin_unlock_irqrestore(&pasid_state->lock, flags);
-}
-
-static void finish_pri_tag(struct device_state *dev_state,
-			   struct pasid_state *pasid_state,
-			   u16 tag)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&pasid_state->lock, flags);
-	if (atomic_dec_and_test(&pasid_state->pri[tag].inflight) &&
-	    pasid_state->pri[tag].finish) {
-		amd_iommu_complete_ppr(dev_state->pdev, pasid_state->pasid,
-				       pasid_state->pri[tag].status, tag);
-		pasid_state->pri[tag].finish = false;
-		pasid_state->pri[tag].status = PPR_SUCCESS;
-	}
-	spin_unlock_irqrestore(&pasid_state->lock, flags);
-}
-
-static void handle_fault_error(struct fault *fault)
-{
-	int status;
-
-	if (!fault->dev_state->inv_ppr_cb) {
-		set_pri_tag_status(fault->state, fault->tag, PPR_INVALID);
-		return;
-	}
-
-	status = fault->dev_state->inv_ppr_cb(fault->dev_state->pdev,
-					      fault->pasid,
-					      fault->address,
-					      fault->flags);
-	switch (status) {
-	case AMD_IOMMU_INV_PRI_RSP_SUCCESS:
-		set_pri_tag_status(fault->state, fault->tag, PPR_SUCCESS);
-		break;
-	case AMD_IOMMU_INV_PRI_RSP_INVALID:
-		set_pri_tag_status(fault->state, fault->tag, PPR_INVALID);
-		break;
-	case AMD_IOMMU_INV_PRI_RSP_FAIL:
-		set_pri_tag_status(fault->state, fault->tag, PPR_FAILURE);
-		break;
-	default:
-		BUG();
-	}
-}
-
-static bool access_error(struct vm_area_struct *vma, struct fault *fault)
-{
-	unsigned long requested = 0;
-
-	if (fault->flags & PPR_FAULT_EXEC)
-		requested |= VM_EXEC;
-
-	if (fault->flags & PPR_FAULT_READ)
-		requested |= VM_READ;
-
-	if (fault->flags & PPR_FAULT_WRITE)
-		requested |= VM_WRITE;
-
-	return (requested & ~vma->vm_flags) != 0;
-}
-
-static void do_fault(struct work_struct *work)
-{
-	struct fault *fault = container_of(work, struct fault, work);
-	struct vm_area_struct *vma;
-	vm_fault_t ret = VM_FAULT_ERROR;
-	unsigned int flags = 0;
-	struct mm_struct *mm;
-	u64 address;
-
-	mm = fault->state->mm;
-	address = fault->address;
-
-	if (fault->flags & PPR_FAULT_USER)
-		flags |= FAULT_FLAG_USER;
-	if (fault->flags & PPR_FAULT_WRITE)
-		flags |= FAULT_FLAG_WRITE;
-	flags |= FAULT_FLAG_REMOTE;
-
-	mmap_read_lock(mm);
-	vma = vma_lookup(mm, address);
-	if (!vma)
-		/* failed to get a vma in the right range */
-		goto out;
-
-	/* Check if we have the right permissions on the vma */
-	if (access_error(vma, fault))
-		goto out;
-
-	ret = handle_mm_fault(vma, address, flags, NULL);
-out:
-	mmap_read_unlock(mm);
-
-	if (ret & VM_FAULT_ERROR)
-		/* failed to service fault */
-		handle_fault_error(fault);
-
-	finish_pri_tag(fault->dev_state, fault->state, fault->tag);
-
-	put_pasid_state(fault->state);
-
-	kfree(fault);
-}
-
-static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
-{
-	struct amd_iommu_fault *iommu_fault;
-	struct pasid_state *pasid_state;
-	struct device_state *dev_state;
-	struct pci_dev *pdev = NULL;
-	unsigned long flags;
-	struct fault *fault;
-	bool finish;
-	u16 tag, devid, seg_id;
-	int ret;
-
-	iommu_fault = data;
-	tag         = iommu_fault->tag & 0x1ff;
-	finish      = (iommu_fault->tag >> 9) & 1;
-
-	seg_id = PCI_SBDF_TO_SEGID(iommu_fault->sbdf);
-	devid = PCI_SBDF_TO_DEVID(iommu_fault->sbdf);
-	pdev = pci_get_domain_bus_and_slot(seg_id, PCI_BUS_NUM(devid),
-					   devid & 0xff);
-	if (!pdev)
-		return -ENODEV;
-
-	ret = NOTIFY_DONE;
-
-	/* In kdump kernel pci dev is not initialized yet -> send INVALID */
-	if (amd_iommu_is_attach_deferred(&pdev->dev)) {
-		amd_iommu_complete_ppr(pdev, iommu_fault->pasid,
-				       PPR_INVALID, tag);
-		goto out;
-	}
-
-	dev_state = get_device_state(iommu_fault->sbdf);
-	if (dev_state == NULL)
-		goto out;
-
-	pasid_state = get_pasid_state(dev_state, iommu_fault->pasid);
-	if (pasid_state == NULL || pasid_state->invalid) {
-		/* We know the device but not the PASID -> send INVALID */
-		amd_iommu_complete_ppr(dev_state->pdev, iommu_fault->pasid,
-				       PPR_INVALID, tag);
-		goto out_drop_state;
-	}
-
-	spin_lock_irqsave(&pasid_state->lock, flags);
-	atomic_inc(&pasid_state->pri[tag].inflight);
-	if (finish)
-		pasid_state->pri[tag].finish = true;
-	spin_unlock_irqrestore(&pasid_state->lock, flags);
-
-	fault = kzalloc(sizeof(*fault), GFP_ATOMIC);
-	if (fault == NULL) {
-		/* We are OOM - send success and let the device re-fault */
-		finish_pri_tag(dev_state, pasid_state, tag);
-		goto out_drop_state;
-	}
-
-	fault->dev_state = dev_state;
-	fault->address   = iommu_fault->address;
-	fault->state     = pasid_state;
-	fault->tag       = tag;
-	fault->finish    = finish;
-	fault->pasid     = iommu_fault->pasid;
-	fault->flags     = iommu_fault->flags;
-	INIT_WORK(&fault->work, do_fault);
-
-	queue_work(iommu_wq, &fault->work);
-
-	ret = NOTIFY_OK;
-
-out_drop_state:
-
-	if (ret != NOTIFY_OK && pasid_state)
-		put_pasid_state(pasid_state);
-
-	put_device_state(dev_state);
-
-out:
-	pci_dev_put(pdev);
-	return ret;
-}
-
-static struct notifier_block ppr_nb = {
-	.notifier_call = ppr_notifier,
-};
-
-int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
-			 struct task_struct *task)
-{
-	struct pasid_state *pasid_state;
-	struct device_state *dev_state;
-	struct mm_struct *mm;
-	u32 sbdf;
-	int ret;
-
-	might_sleep();
-
-	if (!amd_iommu_v2_supported())
-		return -ENODEV;
-
-	sbdf      = get_pci_sbdf_id(pdev);
-	dev_state = get_device_state(sbdf);
-
-	if (dev_state == NULL)
-		return -EINVAL;
-
-	ret = -EINVAL;
-	if (pasid >= dev_state->max_pasids)
-		goto out;
-
-	ret = -ENOMEM;
-	pasid_state = kzalloc(sizeof(*pasid_state), GFP_KERNEL);
-	if (pasid_state == NULL)
-		goto out;
-
-
-	refcount_set(&pasid_state->count, 1);
-	init_waitqueue_head(&pasid_state->wq);
-	spin_lock_init(&pasid_state->lock);
-
-	mm                        = get_task_mm(task);
-	pasid_state->mm           = mm;
-	pasid_state->device_state = dev_state;
-	pasid_state->pasid        = pasid;
-	pasid_state->invalid      = true; /* Mark as valid only if we are
-					     done with setting up the pasid */
-	pasid_state->mn.ops       = &iommu_mn;
-
-	if (pasid_state->mm == NULL)
-		goto out_free;
-
-	ret = mmu_notifier_register(&pasid_state->mn, mm);
-	if (ret)
-		goto out_free;
-
-	ret = set_pasid_state(dev_state, pasid_state, pasid);
-	if (ret)
-		goto out_unregister;
-
-	ret = amd_iommu_domain_set_gcr3(dev_state->domain, pasid,
-					__pa(pasid_state->mm->pgd));
-	if (ret)
-		goto out_clear_state;
-
-	/* Now we are ready to handle faults */
-	pasid_state->invalid = false;
-
-	/*
-	 * Drop the reference to the mm_struct here. We rely on the
-	 * mmu_notifier release call-back to inform us when the mm
-	 * is going away.
-	 */
-	mmput(mm);
-
-	return 0;
-
-out_clear_state:
-	clear_pasid_state(dev_state, pasid);
-
-out_unregister:
-	mmu_notifier_unregister(&pasid_state->mn, mm);
-	mmput(mm);
-
-out_free:
-	free_pasid_state(pasid_state);
-
-out:
-	put_device_state(dev_state);
-
-	return ret;
-}
-EXPORT_SYMBOL(amd_iommu_bind_pasid);
-
-void amd_iommu_unbind_pasid(struct pci_dev *pdev, u32 pasid)
-{
-	struct pasid_state *pasid_state;
-	struct device_state *dev_state;
-	u32 sbdf;
-
-	might_sleep();
-
-	if (!amd_iommu_v2_supported())
-		return;
-
-	sbdf = get_pci_sbdf_id(pdev);
-	dev_state = get_device_state(sbdf);
-	if (dev_state == NULL)
-		return;
-
-	if (pasid >= dev_state->max_pasids)
-		goto out;
-
-	pasid_state = get_pasid_state(dev_state, pasid);
-	if (pasid_state == NULL)
-		goto out;
-	/*
-	 * Drop reference taken here. We are safe because we still hold
-	 * the reference taken in the amd_iommu_bind_pasid function.
-	 */
-	put_pasid_state(pasid_state);
-
-	/* Clear the pasid state so that the pasid can be re-used */
-	clear_pasid_state(dev_state, pasid_state->pasid);
-
-	/*
-	 * Call mmu_notifier_unregister to drop our reference
-	 * to pasid_state->mm
-	 */
-	mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
-
-	put_pasid_state_wait(pasid_state); /* Reference taken in
-					      amd_iommu_bind_pasid */
-out:
-	/* Drop reference taken in this function */
-	put_device_state(dev_state);
-
-	/* Drop reference taken in amd_iommu_bind_pasid */
-	put_device_state(dev_state);
-}
-EXPORT_SYMBOL(amd_iommu_unbind_pasid);
-
-int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
-{
-	struct device_state *dev_state;
-	struct iommu_group *group;
-	unsigned long flags;
-	int ret, tmp;
-	u32 sbdf;
-
-	might_sleep();
-
-	/*
-	 * When memory encryption is active the device is likely not in a
-	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
-	 */
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return -ENODEV;
-
-	if (!amd_iommu_v2_supported())
-		return -ENODEV;
-
-	if (pasids <= 0 || pasids > (PASID_MASK + 1))
-		return -EINVAL;
-
-	sbdf = get_pci_sbdf_id(pdev);
-
-	dev_state = kzalloc(sizeof(*dev_state), GFP_KERNEL);
-	if (dev_state == NULL)
-		return -ENOMEM;
-
-	spin_lock_init(&dev_state->lock);
-	init_waitqueue_head(&dev_state->wq);
-	dev_state->pdev  = pdev;
-	dev_state->sbdf = sbdf;
-
-	tmp = pasids;
-	for (dev_state->pasid_levels = 0; (tmp - 1) & ~0x1ff; tmp >>= 9)
-		dev_state->pasid_levels += 1;
-
-	atomic_set(&dev_state->count, 1);
-	dev_state->max_pasids = pasids;
-
-	ret = -ENOMEM;
-	dev_state->states = (void *)get_zeroed_page(GFP_KERNEL);
-	if (dev_state->states == NULL)
-		goto out_free_dev_state;
-
-	dev_state->domain = iommu_domain_alloc(&pci_bus_type);
-	if (dev_state->domain == NULL)
-		goto out_free_states;
-
-	/* See iommu_is_default_domain() */
-	dev_state->domain->type = IOMMU_DOMAIN_IDENTITY;
-	amd_iommu_domain_direct_map(dev_state->domain);
-
-	ret = amd_iommu_domain_enable_v2(dev_state->domain, pasids);
-	if (ret)
-		goto out_free_domain;
-
-	group = iommu_group_get(&pdev->dev);
-	if (!group) {
-		ret = -EINVAL;
-		goto out_free_domain;
-	}
-
-	ret = iommu_attach_group(dev_state->domain, group);
-	if (ret != 0)
-		goto out_drop_group;
-
-	iommu_group_put(group);
-
-	spin_lock_irqsave(&state_lock, flags);
-
-	if (__get_device_state(sbdf) != NULL) {
-		spin_unlock_irqrestore(&state_lock, flags);
-		ret = -EBUSY;
-		goto out_free_domain;
-	}
-
-	list_add_tail(&dev_state->list, &state_list);
-
-	spin_unlock_irqrestore(&state_lock, flags);
-
-	return 0;
-
-out_drop_group:
-	iommu_group_put(group);
-
-out_free_domain:
-	iommu_domain_free(dev_state->domain);
-
-out_free_states:
-	free_page((unsigned long)dev_state->states);
-
-out_free_dev_state:
-	kfree(dev_state);
-
-	return ret;
-}
-EXPORT_SYMBOL(amd_iommu_init_device);
-
-void amd_iommu_free_device(struct pci_dev *pdev)
-{
-	struct device_state *dev_state;
-	unsigned long flags;
-	u32 sbdf;
-
-	if (!amd_iommu_v2_supported())
-		return;
-
-	sbdf = get_pci_sbdf_id(pdev);
-
-	spin_lock_irqsave(&state_lock, flags);
-
-	dev_state = __get_device_state(sbdf);
-	if (dev_state == NULL) {
-		spin_unlock_irqrestore(&state_lock, flags);
-		return;
-	}
-
-	list_del(&dev_state->list);
-
-	spin_unlock_irqrestore(&state_lock, flags);
-
-	put_device_state(dev_state);
-	free_device_state(dev_state);
-}
-EXPORT_SYMBOL(amd_iommu_free_device);
-
-int amd_iommu_set_invalid_ppr_cb(struct pci_dev *pdev,
-				 amd_iommu_invalid_ppr_cb cb)
-{
-	struct device_state *dev_state;
-	unsigned long flags;
-	u32 sbdf;
-	int ret;
-
-	if (!amd_iommu_v2_supported())
-		return -ENODEV;
-
-	sbdf = get_pci_sbdf_id(pdev);
-
-	spin_lock_irqsave(&state_lock, flags);
-
-	ret = -EINVAL;
-	dev_state = __get_device_state(sbdf);
-	if (dev_state == NULL)
-		goto out_unlock;
-
-	dev_state->inv_ppr_cb = cb;
-
-	ret = 0;
-
-out_unlock:
-	spin_unlock_irqrestore(&state_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(amd_iommu_set_invalid_ppr_cb);
-
-int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
-				    amd_iommu_invalidate_ctx cb)
-{
-	struct device_state *dev_state;
-	unsigned long flags;
-	u32 sbdf;
-	int ret;
-
-	if (!amd_iommu_v2_supported())
-		return -ENODEV;
-
-	sbdf = get_pci_sbdf_id(pdev);
-
-	spin_lock_irqsave(&state_lock, flags);
-
-	ret = -EINVAL;
-	dev_state = __get_device_state(sbdf);
-	if (dev_state == NULL)
-		goto out_unlock;
-
-	dev_state->inv_ctx_cb = cb;
-
-	ret = 0;
-
-out_unlock:
-	spin_unlock_irqrestore(&state_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(amd_iommu_set_invalidate_ctx_cb);
-
-static int __init amd_iommu_v2_init(void)
-{
-	int ret;
-
-	if (!amd_iommu_v2_supported()) {
-		pr_info("AMD IOMMUv2 functionality not available on this system - This is not a bug.\n");
-		/*
-		 * Load anyway to provide the symbols to other modules
-		 * which may use AMD IOMMUv2 optionally.
-		 */
-		return 0;
-	}
-
-	ret = -ENOMEM;
-	iommu_wq = alloc_workqueue("amd_iommu_v2", WQ_MEM_RECLAIM, 0);
-	if (iommu_wq == NULL)
-		goto out;
-
-	amd_iommu_register_ppr_notifier(&ppr_nb);
-
-	pr_info("AMD IOMMUv2 loaded and initialized\n");
-
-	return 0;
-
-out:
-	return ret;
-}
-
-static void __exit amd_iommu_v2_exit(void)
-{
-	struct device_state *dev_state, *next;
-	unsigned long flags;
-	LIST_HEAD(freelist);
-
-	if (!amd_iommu_v2_supported())
-		return;
-
-	amd_iommu_unregister_ppr_notifier(&ppr_nb);
-
-	flush_workqueue(iommu_wq);
-
-	/*
-	 * The loop below might call flush_workqueue(), so call
-	 * destroy_workqueue() after it
-	 */
-	spin_lock_irqsave(&state_lock, flags);
-
-	list_for_each_entry_safe(dev_state, next, &state_list, list) {
-		WARN_ON_ONCE(1);
-
-		put_device_state(dev_state);
-		list_del(&dev_state->list);
-		list_add_tail(&dev_state->list, &freelist);
-	}
-
-	spin_unlock_irqrestore(&state_lock, flags);
-
-	/*
-	 * Since free_device_state waits on the count to be zero,
-	 * we need to free dev_state outside the spinlock.
-	 */
-	list_for_each_entry_safe(dev_state, next, &freelist, list) {
-		list_del(&dev_state->list);
-		free_device_state(dev_state);
-	}
-
-	destroy_workqueue(iommu_wq);
-}
-
-module_init(amd_iommu_v2_init);
-module_exit(amd_iommu_v2_exit);
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 99a5201d9e62..35ca00b09384 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -33,84 +33,6 @@ struct pci_dev;
 
 extern int amd_iommu_detect(void);
 
-/**
- * amd_iommu_init_device() - Init device for use with IOMMUv2 driver
- * @pdev: The PCI device to initialize
- * @pasids: Number of PASIDs to support for this device
- *
- * This function does all setup for the device pdev so that it can be
- * used with IOMMUv2.
- * Returns 0 on success or negative value on error.
- */
-extern int amd_iommu_init_device(struct pci_dev *pdev, int pasids);
-
-/**
- * amd_iommu_free_device() - Free all IOMMUv2 related device resources
- *			     and disable IOMMUv2 usage for this device
- * @pdev: The PCI device to disable IOMMUv2 usage for'
- */
-extern void amd_iommu_free_device(struct pci_dev *pdev);
-
-/**
- * amd_iommu_bind_pasid() - Bind a given task to a PASID on a device
- * @pdev: The PCI device to bind the task to
- * @pasid: The PASID on the device the task should be bound to
- * @task: the task to bind
- *
- * The function returns 0 on success or a negative value on error.
- */
-extern int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
-				struct task_struct *task);
-
-/**
- * amd_iommu_unbind_pasid() - Unbind a PASID from its task on
- *			      a device
- * @pdev: The device of the PASID
- * @pasid: The PASID to unbind
- *
- * When this function returns the device is no longer using the PASID
- * and the PASID is no longer bound to its task.
- */
-extern void amd_iommu_unbind_pasid(struct pci_dev *pdev, u32 pasid);
-
-/**
- * amd_iommu_set_invalid_ppr_cb() - Register a call-back for failed
- *				    PRI requests
- * @pdev: The PCI device the call-back should be registered for
- * @cb: The call-back function
- *
- * The IOMMUv2 driver invokes this call-back when it is unable to
- * successfully handle a PRI request. The device driver can then decide
- * which PRI response the device should see. Possible return values for
- * the call-back are:
- *
- * - AMD_IOMMU_INV_PRI_RSP_SUCCESS - Send SUCCESS back to the device
- * - AMD_IOMMU_INV_PRI_RSP_INVALID - Send INVALID back to the device
- * - AMD_IOMMU_INV_PRI_RSP_FAIL    - Send Failure back to the device,
- *				     the device is required to disable
- *				     PRI when it receives this response
- *
- * The function returns 0 on success or negative value on error.
- */
-#define AMD_IOMMU_INV_PRI_RSP_SUCCESS	0
-#define AMD_IOMMU_INV_PRI_RSP_INVALID	1
-#define AMD_IOMMU_INV_PRI_RSP_FAIL	2
-
-typedef int (*amd_iommu_invalid_ppr_cb)(struct pci_dev *pdev,
-					u32 pasid,
-					unsigned long address,
-					u16);
-
-extern int amd_iommu_set_invalid_ppr_cb(struct pci_dev *pdev,
-					amd_iommu_invalid_ppr_cb cb);
-
-#define PPR_FAULT_EXEC	(1 << 1)
-#define PPR_FAULT_READ  (1 << 2)
-#define PPR_FAULT_WRITE (1 << 5)
-#define PPR_FAULT_USER  (1 << 6)
-#define PPR_FAULT_RSVD  (1 << 7)
-#define PPR_FAULT_GN    (1 << 8)
-
 /**
  * amd_iommu_device_info() - Get information about IOMMUv2 support of a
  *			     PCI device
@@ -137,22 +59,6 @@ struct amd_iommu_device_info {
 extern int amd_iommu_device_info(struct pci_dev *pdev,
 				 struct amd_iommu_device_info *info);
 
-/**
- * amd_iommu_set_invalidate_ctx_cb() - Register a call-back for invalidating
- *				       a pasid context. This call-back is
- *				       invoked when the IOMMUv2 driver needs to
- *				       invalidate a PASID context, for example
- *				       because the task that is bound to that
- *				       context is about to exit.
- *
- * @pdev: The PCI device the call-back should be registered for
- * @cb: The call-back function
- */
-
-typedef void (*amd_iommu_invalidate_ctx)(struct pci_dev *pdev, u32 pasid);
-
-extern int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
-					   amd_iommu_invalidate_ctx cb);
 #else /* CONFIG_AMD_IOMMU */
 
 static inline int amd_iommu_detect(void) { return -ENODEV; }
-- 
2.31.1

