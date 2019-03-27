From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 03/10] iommu/vt-d: Add address walk helper
Date: Wed, 27 Mar 2019 14:34:59 +0800
Message-ID: <20190327063506.32564-4-baolu.lu@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327063506.32564-1-baolu.lu@linux.intel.com>
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
 drivers/iommu/intel-pgtable.c | 130 ++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 1 deletion(-)
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
index 000000000000..fd170157325a
--- /dev/null
+++ b/drivers/iommu/intel-pgtable.c
@@ -0,0 +1,130 @@
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
+#include <asm/cacheflush.h>
+#include <asm/pgtable.h>
+#include <linux/dmar.h>
+#include <linux/dma-direct.h>
+#include <linux/export.h>
+#include <linux/highmem.h>
+#include <linux/intel-iommu.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/vmalloc.h>
+#include <trace/events/intel_iommu.h>
+
+struct addr_walk {
+	int (*low)(struct device *dev, struct dmar_domain *domain,
+			dma_addr_t addr, phys_addr_t paddr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs, void *data);
+	int (*middle)(struct device *dev, struct dmar_domain *domain,
+			dma_addr_t addr, phys_addr_t paddr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs, void *data);
+	int (*high)(struct device *dev, struct dmar_domain *domain,
+			dma_addr_t addr, phys_addr_t paddr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs, void *data);
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
+	return VTD_PAGE_SIZE;
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
+int
+domain_walk_addr_range(const struct addr_walk *walk, struct device *dev,
+		       struct dmar_domain *domain, dma_addr_t addr,
+		       phys_addr_t paddr, size_t size,
+		       enum dma_data_direction dir,
+		       unsigned long attrs,
+		       void *data)
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
+		if (walk->low) {
+			ret = walk->low(dev, domain, addr, paddr,
+					length, dir, attrs, data);
+			if (ret)
+				return ret;
+		}
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
+		if (walk->middle) {
+			ret = walk->middle(dev, domain, addr, paddr,
+					   length, dir, attrs, data);
+			if (ret)
+				return ret;
+		}
+
+		addr += size & page_mask;
+		paddr += size & page_mask;
+		size &= page_offset;
+	}
+
+	/*
+	 * Okay, last page might be partial. Use bounce buffer if necessary.
+	 */
+	if (size && walk->high)
+		return walk->high(dev, domain, addr, paddr,
+				  size, dir, attrs, data);
+
+	return 0;
+}
-- 
2.17.1
