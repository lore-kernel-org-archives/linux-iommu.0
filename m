From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 3/9] iommu/vt-d: Add address walk helper
Date: Tue, 12 Mar 2019 13:59:59 +0800
Message-ID: <20190312060005.12189-4-baolu.lu@linux.intel.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312060005.12189-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds a helper to walk a contiguous dma address
and divide the address space into possiblely three
parts: a start partial page, middle full pages and
an end partial page, and call the callback for each
part of the address.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/Makefile        |   2 +-
 drivers/iommu/intel-pgtable.c | 109 ++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h   |   6 ++
 3 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/intel-pgtable.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 8b5fb8051281..562c6a526d63 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
-obj-$(CONFIG_INTEL_IOMMU) += intel-trace.o
+obj-$(CONFIG_INTEL_IOMMU) += intel-trace.o intel-pgtable.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel-iommu-debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/intel-pgtable.c b/drivers/iommu/intel-pgtable.c
new file mode 100644
index 000000000000..ad3347d7ac1d
--- /dev/null
+++ b/drivers/iommu/intel-pgtable.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * intel-pgtable.c - Utilities for page table manipulation
+ *
+ * Copyright (C) 2019 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ */
+
+#define pr_fmt(fmt)	"DMAR: " fmt
+
+#include <linux/dmar.h>
+#include <linux/highmem.h>
+#include <linux/intel-iommu.h>
+#include <linux/iommu.h>
+#include <trace/events/intel_iommu.h>
+
+struct addr_walk {
+	int (*low)(struct dmar_domain *domain, dma_addr_t addr,
+			phys_addr_t paddr, size_t size,
+			struct bounce_param *param);
+	int (*middle)(struct dmar_domain *domain, dma_addr_t addr,
+			phys_addr_t paddr, size_t size,
+			struct bounce_param *param);
+	int (*high)(struct dmar_domain *domain, dma_addr_t addr,
+			phys_addr_t paddr, size_t size,
+			struct bounce_param *param);
+};
+
+/*
+ * Bounce buffer support for external devices:
+ *
+ * Intel VT-d hardware uses paging for DMA remapping. The minimum mapped
+ * window is a page size. The device drivers may map buffers not filling
+ * whole IOMMU window. This allows device to access to possibly unrelated
+ * memory and malicious device can exploit this to perform a DMA attack.
+ * Use a bounce page for the buffer which doesn't fill a whole IOMU page.
+ */
+
+static inline unsigned long domain_page_size(struct dmar_domain *domain)
+{
+	return 1UL << __ffs(domain->domain.pgsize_bitmap);
+}
+
+/* Calculate how many pages does a range of [addr, addr + size) cross. */
+static inline unsigned long
+range_nrpages(dma_addr_t addr, size_t size, unsigned long page_size)
+{
+	unsigned long offset = page_size - 1;
+
+	return ALIGN((addr & offset) + size, page_size) >> __ffs(page_size);
+}
+
+int domain_walk_addr_range(const struct addr_walk *walk,
+			   struct dmar_domain *domain,
+			   dma_addr_t addr, phys_addr_t paddr,
+			   size_t size, struct bounce_param *param)
+{
+	u64 page_size = domain_page_size(domain);
+	u64 page_offset = page_size - 1;
+	u64 page_mask = ~page_offset;
+	u64 length = 0;
+	int ret;
+
+	/*
+	 * The first vt-d page is partial. Use bounce buffer for
+	 * security concern if necessary.
+	 */
+	if (addr & page_offset) {
+		length = ALIGN(addr, page_size) - addr;
+		if (length > size)
+			length = size;
+		ret = walk->low(domain, addr, paddr, length, param);
+		if (ret)
+			return ret;
+
+		/* The buffer only covers on page. */
+		if (range_nrpages(addr, size, page_size) <= 1)
+			return 0;
+
+		size -= length;
+		addr = ALIGN(addr, page_size);
+		paddr = ALIGN(paddr, page_size);
+	}
+
+	/*
+	 * There might be several pages which could totally accessed
+	 * by a device in the middle. It's unnecessary to use bounce
+	 * buffer against these pages.
+	 */
+	if (size & page_mask) {
+		length = size & page_mask;
+		ret = walk->middle(domain, addr, paddr, length, param);
+		if (ret)
+			return ret;
+
+		addr += size & page_mask;
+		paddr += size & page_mask;
+		size &= page_offset;
+	}
+
+	/*
+	 * Okay, last page might be partial. Use bounce buffer if necessary.
+	 */
+	if (size)
+		return walk->high(domain, addr, paddr, size, param);
+
+	return 0;
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 74afedfe193b..f74aed6ecc33 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -668,6 +668,12 @@ int domain_iomap_range(struct dmar_domain *domain, unsigned long addr,
 struct page *domain_iounmap_range(struct dmar_domain *domain,
 				  unsigned long addr, size_t size);
 
+struct bounce_param {
+	int			prot;
+	enum dma_data_direction	dir;
+	struct page		**freelist;
+};
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
-- 
2.17.1
