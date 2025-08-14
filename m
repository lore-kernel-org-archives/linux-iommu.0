Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4E2FC877
	for <iommu@lists.linux.dev>; Thu, 14 Aug 2025 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163821; cv=none; b=MJxeULfbKlhXJTCrGFZnujMsywAM0/KroAaZIZZ8jE4Mv3pXqG8HEvTKrO4EvZ1Kgr2vVpOHN1PQMjXhI5rwzzW+u69R8pCT44WSMLWl4mYvfIMEXtJGEk/SQN1gShrecEzDQSu/epua3HO509D5b2/gwx8z63UdROcaaqQ5ctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163821; c=relaxed/simple;
	bh=3DkszcYRwc0tIhu3mjks3cZGjjYrdY3cAAuJxXBnL+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMD+gAS9zMFCLlBI7hn2eCbhc32JW0IQ9FfN7i9TVlJJ9oSCAcZEozflsIhq2TuIwxEqZ/RDv6/yb8C9oNUhoYDyYMYqFxURgTwESmApHzjjpwSgh1cvM9ATfDXeQJI671kkeDkeMRCkb9DNeHRlbXf2xSK66eOW1B1JL91Ck70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c2g3P70KDz2dMH0;
	Thu, 14 Aug 2025 17:31:13 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id B430B1A016C;
	Thu, 14 Aug 2025 17:30:09 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 17:30:08 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <yangyicong@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH 1/2] iommu/debug: Add IOMMU page table dump debug facility
Date: Thu, 14 Aug 2025 17:30:04 +0800
Message-ID: <20250814093005.2040511-2-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250814093005.2040511-1-xiaqinxin@huawei.com>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)

This patch introduces a comprehensive debugging mechanism for IOMMU
page tables, providing visibility into IOVA mappings and protection
information. The feature is particularly valuable for debugging
complex DMA mapping issues and validating IOMMU configurations.

Key components:
1. New debugfs interface: Creates /sys/kernel/debug/io_page_tables
2. Domain-group hierarchy: Organizes output by domain and group
3. IOVA mapping dump: Shows allocated IOVA ranges and protections
4. Device enumeration: Lists all devices in each IOMMU group

Implementation details:
- Added dump_iova_prot callback to iommu_domain_ops
- Implemented iommu_group_and_iova_dump() to traverse groups
- Created iommu_iova_info_dump() to walk IOVA allocations
- Added CONFIG_IO_PTDUMP_DEBUGFS for compile-time enablement
- Provided iommu_domain_to_iovad() helper for IOVA access

The debug output includes:
-- domain [address] --
- group [id]
  - [device1]
  - [device2]
---[ RANGE START ]---
[IOVA mapping details]
---[ RANGE END   ]---

This feature helps diagnose:
- IOVA allocation patterns
- Protection flag mismatches
- Unexpected domain/group mappings
- Device-to-domain assignment issues

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/dma-iommu.c |  15 ++++
 drivers/iommu/dma-iommu.h |   4 +
 drivers/iommu/iommu.c     | 175 ++++++++++++++++++++++++++++++++++++++
 include/linux/io_ptdump.h |  16 ++++
 include/linux/iommu.h     |  10 ++-
 mm/Kconfig.debug          |  19 +++++
 mm/Makefile               |   2 +
 mm/io_ptdump.c            |  24 ++++++
 mm/io_ptdump_debugfs.c    |  17 ++++
 9 files changed, 281 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/io_ptdump.h
 create mode 100644 mm/io_ptdump.c
 create mode 100644 mm/io_ptdump_debugfs.c

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea2ef53bd4fe..d44cd613ea69 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -448,6 +448,21 @@ void iommu_put_msi_cookie(struct iommu_domain *domain)
 	kfree(cookie);
 }
 
+#ifdef CONFIG_IO_PTDUMP
+/**
+ * iommu_domain_to_iovad - Retrieve the IOVA domain from an IOMMU domain
+ * @domain: IOMMU domain with an associated IOVA cookie
+ *
+ * This function returns the IOVA domain (iovad) structure associated with
+ * the given IOMMU domain. The domain must have been initialized with an
+ * IOVA cookie (typically through iommu_dma_init_domain()).
+ */
+struct iova_domain *iommu_domain_to_iovad(struct iommu_domain *domain)
+{
+	return &domain->iova_cookie->iovad;
+}
+#endif
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index eca201c1f963..18b06c62af9d 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -24,6 +24,10 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 
 extern bool iommu_dma_forcedac;
 
+#ifdef CONFIG_IO_PTDUMP
+struct iova_domain *iommu_domain_to_iovad(struct iommu_domain *domain);
+#endif
+
 #else /* CONFIG_IOMMU_DMA */
 
 static inline void iommu_setup_dma_ops(struct device *dev)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee1..8fc89a5b34b8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1061,6 +1061,181 @@ struct iommu_group *iommu_group_alloc(void)
 }
 EXPORT_SYMBOL_GPL(iommu_group_alloc);
 
+#ifdef CONFIG_IO_PTDUMP
+#include <linux/seq_file.h>
+#include <linux/iova.h>
+
+struct dump_domain {
+	struct iommu_domain *domain;
+	struct list_head groups;
+	struct list_head list;
+};
+
+struct dump_group {
+	struct iommu_group *group;
+	struct list_head list;
+};
+
+/**
+ * iova_info_dump - dump iova alloced
+ * @s - file structure used to generate serialized output
+ * @iovad: - iova domain in question.
+ */
+static int iommu_iova_info_dump(struct seq_file *s, struct iommu_domain *domain)
+{
+	struct iova_domain *iovad;
+	unsigned long long pfn;
+	unsigned long i_shift;
+	struct rb_node *node;
+	unsigned long flags;
+	size_t prot_size;
+
+	iovad = iommu_domain_to_iovad(domain);
+	if (!iovad)
+		return -ENOMEM;
+
+	i_shift = iova_shift(iovad);
+
+	/* Take the lock so that no other thread is manipulating the rbtree */
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	assert_spin_locked(&iovad->iova_rbtree_lock);
+
+	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
+		struct iova *iova = rb_entry(node, struct iova, node);
+
+		if (iova->pfn_hi <= iova->pfn_lo)
+			continue;
+
+		for (pfn = iova->pfn_lo; pfn <= iova->pfn_hi; ) {
+			prot_size = domain->ops->dump_iova_prot(s, domain, pfn << i_shift);
+			pfn = ((pfn << i_shift) + prot_size) >> i_shift;
+		}
+	}
+
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	return 0;
+}
+
+/**
+ * iommu_group_and_iova_dump - Collect and dump IOMMU group and IOVA mapping information
+ * @s: seq_file target for output
+ *
+ * This function traverses all IOMMU groups in the system and dumps hierarchical information
+ * about domains, groups, devices, and IOVA mappings. Only groups with default domains using
+ * DMA_IOVA cookie type are processed.
+ *
+ * Key operations:
+ * 1. Iterates through all registered IOMMU groups
+ * 2. Filters groups with default domains of type IOMMU_COOKIE_DMA_IOVA
+ * 3. Organizes groups by domain to avoid duplicate domain output
+ * 4. Outputs hierarchical information including:
+ *    - Domain address
+ *    - Group IDs and their member devices
+ *    - IOVA mapping ranges via iommu_iova_info_dump()
+ *
+ * Data structure hierarchy:
+ *   domain_list (list_head)
+ *   ├── dump_domain
+ *   │   ├── domain: pointer to iommu_domain
+ *   │   └── groups (list_head)
+ *   │       └── dump_group
+ *   │           └── group: pointer to iommu_group
+ *
+ */
+int iommu_group_and_iova_dump(struct seq_file *s)
+{
+	struct dump_domain *domain_entry, *d_tmp;
+	struct dump_group *group_entry, *g_tmp;
+	struct list_head domain_list;
+	struct iommu_group *group;
+	struct group_device *gdev;
+	struct kobject *kobj;
+	int ret = 0;
+	bool found;
+
+	INIT_LIST_HEAD(&domain_list);
+
+	list_for_each_entry(kobj, &iommu_group_kset->list, entry) {
+		group = container_of(kobj, struct iommu_group, kobj);
+
+		/* Skip groups that do not meet the criteria */
+		if (!group->default_domain ||
+		    group->default_domain->cookie_type != IOMMU_COOKIE_DMA_IOVA)
+			continue;
+
+		/* Check whether the domain already exists. */
+		found = false;
+		list_for_each_entry(domain_entry, &domain_list, list) {
+			if (domain_entry->domain == group->default_domain) {
+				found = true;
+				break;
+			}
+		}
+
+		/* New domain, create entry */
+		if (!found) {
+			domain_entry = kzalloc(sizeof(*domain_entry), GFP_KERNEL);
+			if (!domain_entry) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			domain_entry->domain = group->default_domain;
+			INIT_LIST_HEAD(&domain_entry->groups);
+			list_add_tail(&domain_entry->list, &domain_list);
+		}
+
+		/* Create group entries */
+		group_entry = kzalloc(sizeof(*group_entry), GFP_KERNEL);
+		if (!group_entry) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		group_entry->group = group;
+		list_add_tail(&group_entry->list, &domain_entry->groups);
+	}
+
+	/* Output all domain information */
+	list_for_each_entry(domain_entry, &domain_list, list) {
+		seq_printf(s, "-- domain %p --\n", domain_entry->domain);
+
+		/* Output all groups in the current domain */
+		list_for_each_entry(group_entry, &domain_entry->groups, list) {
+			seq_printf(s, "- group %d\n", group_entry->group->id);
+
+			/* Output all devices in the group */
+			for_each_group_device(group_entry->group, gdev) {
+				seq_printf(s, "  - %s\n", dev_name(gdev->dev));
+			}
+		}
+
+		/* Output IOVA range */
+		seq_puts(s, "---[ RANGE START ]---\n");
+		ret = iommu_iova_info_dump(s, domain_entry->domain);
+		if (ret)
+			seq_puts(s, "IOVA INFO DUMP FAIL...\n");
+
+		seq_puts(s, "---[ RANGE END   ]---\n");
+	}
+
+out:
+	/* Release domain_list and group_list */
+	list_for_each_entry_safe(domain_entry, d_tmp, &domain_list, list) {
+		list_for_each_entry_safe(group_entry, g_tmp, &domain_entry->groups, list) {
+			list_del(&group_entry->list);
+			kfree(group_entry);
+		}
+
+		list_del(&domain_entry->list);
+		kfree(domain_entry);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_group_and_iova_dump);
+#endif
+
 /**
  * iommu_group_get_iommudata - retrieve iommu_data registered for a group
  * @group: the group
diff --git a/include/linux/io_ptdump.h b/include/linux/io_ptdump.h
new file mode 100644
index 000000000000..e087bb7751c2
--- /dev/null
+++ b/include/linux/io_ptdump.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (C) 2025 HiSilicon Limited
+ * Author: Qinxin Xia <xiaqinxin@huawei.com>
+ *
+ */
+
+#ifndef __ASM_IO_PTDUMP_H
+#define __ASM_IO_PTDUMP_H
+
+#ifdef CONFIG_IO_PTDUMP_DEBUGFS
+void __init io_ptdump_debugfs_register(const char *name);
+#else
+void __init io_ptdump_debugfs_register(const char *name) { }
+#endif /* CONFIG_IO_PTDUMP_DEBUGFS  */
+
+#endif
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473..494a4960b8c7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -772,7 +772,10 @@ struct iommu_domain_ops {
 
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
-
+#ifdef CONFIG_IO_PTDUMP
+	size_t (*dump_iova_prot)(struct seq_file *s, struct iommu_domain *domain,
+					dma_addr_t iova);
+#endif
 	bool (*enforce_cache_coherency)(struct iommu_domain *domain);
 	int (*set_pgtable_quirks)(struct iommu_domain *domain,
 				  unsigned long quirks);
@@ -1698,4 +1701,9 @@ static inline void iopf_group_response(struct iopf_group *group,
 {
 }
 #endif /* CONFIG_IOMMU_IOPF */
+
+#ifdef CONFIG_IO_PTDUMP
+int iommu_group_and_iova_dump(struct seq_file *s);
+#endif /* CONFIG_IO_PTDUMP */
+
 #endif /* __LINUX_IOMMU_H */
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 32b65073d0cc..e09c9995c496 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -219,6 +219,9 @@ config ARCH_HAS_PTDUMP
 config PTDUMP
 	bool
 
+config IO_PTDUMP
+	bool
+
 config PTDUMP_DEBUGFS
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
@@ -234,6 +237,22 @@ config PTDUMP_DEBUGFS
 
 	  If in doubt, say N.
 
+config IO_PTDUMP_DEBUGFS
+	bool "Export io pagetable layout to userspace via debugfs"
+	depends on DEBUG_KERNEL
+	depends on DEBUG_FS
+	depends on IOMMU_IOVA
+	select IO_PTDUMP
+	help
+	  Say Y here if you want to show the io pagetable layout in a
+	  debugfs file. This information is only useful for kernel developers
+	  who are working in architecture specific areas of the iommu.
+	  It is probably not a good idea to enable this feature in a production
+	  kernel.
+
+	  If in doubt, say N.
+
+
 config HAVE_DEBUG_KMEMLEAK
 	bool
 
diff --git a/mm/Makefile b/mm/Makefile
index ef54aa615d9d..95759ccf93c1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -147,3 +147,5 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
+obj-$(CONFIG_IO_PTDUMP) += io_ptdump.o
+obj-$(CONFIG_IO_PTDUMP_DEBUGFS) += io_ptdump_debugfs.o
diff --git a/mm/io_ptdump.c b/mm/io_ptdump.c
new file mode 100644
index 000000000000..9aa133de5119
--- /dev/null
+++ b/mm/io_ptdump.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, hisilion limited.
+ * Debug helper to dump the current IO pagetables of the system
+ * so that we can see what the various memory ranges are set to.
+ *
+ * Author: Qinxin Xia <xiaqinxin@huawei.com>
+ */
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/init.h>
+#include <linux/io_ptdump.h>
+#include <linux/mm.h>
+#include <linux/seq_file.h>
+
+static int __init io_ptdump_init(void)
+{
+	io_ptdump_debugfs_register("io_page_tables");
+	return 0;
+}
+
+device_initcall(io_ptdump_init);
diff --git a/mm/io_ptdump_debugfs.c b/mm/io_ptdump_debugfs.c
new file mode 100644
index 000000000000..704ca306957e
--- /dev/null
+++ b/mm/io_ptdump_debugfs.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/debugfs.h>
+#include <linux/iommu.h>
+#include <linux/memory_hotplug.h>
+#include <linux/seq_file.h>
+
+static int io_ptdump_show(struct seq_file *m, void *v)
+{
+	iommu_group_and_iova_dump(m);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(io_ptdump);
+
+void __init io_ptdump_debugfs_register(const char *name)
+{
+	debugfs_create_file(name, 0400, NULL, NULL, &io_ptdump_fops);
+}
-- 
2.33.0

