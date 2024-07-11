Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351D155A59;
	Thu, 11 Jul 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694348; cv=none; b=VWVZQzMWlmEVlQFHkm/aueIk5S43tMMU17v9uotHawCUBmK4u0dPnh308gS7NdAoq+Ig367myTI/i6HyNlFH1nV0vrt0uWhhIN/57hSkHL1E7jd3ahlY2MvoztkyK+8+z/Em24VMJHVSWYPCOxrJGAgzNrY4Ed/ydR42l+D+8zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694348; c=relaxed/simple;
	bh=BuMlWcjgxDT7I5kHjbM7MIng0+9ukjjfqnUNNTvOyEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ngssl7LJ2ZVy/eJAWGPG8sGWI0af2WD5fakB+3unGvw5KLNeo0q68dwEn2K2EZdhgxltxSg0Vn4nHxVyVkMDEToKC1mX+m4G6YF4tfA5bU/qA/pMpqdRn/1sM9b2BIYNYYeuRGVQ3Z3UE9kvV9nMCv3iyDu2EXIYX1ljkGECxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1xm83rB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1xm83rB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98F4C116B1;
	Thu, 11 Jul 2024 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720694347;
	bh=BuMlWcjgxDT7I5kHjbM7MIng0+9ukjjfqnUNNTvOyEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1xm83rBgXc1oKtzWPeQe+d1A2wToyfWm2yIjWqiHGyuhTpVROZNcX36PuzwsTWOx
	 79lV1a51UOsjHZa8vgsj9qHJF0VEp+RAfQmJ8uo1LmpIzZzp5AszyFCm/SmA78T9uA
	 jglU253O9vxy5ntDwl5FAe9guXs3H2sfJtqaRaBxK4RMzvP/6blUQt7zBn8Tv1aDJ7
	 JFqpl00uUPt+lTUfS6oRPplRJdfjrIZwiLxOJuMROxLpvPao3E2gqgSf7V29Dqlbj9
	 jXz+teR8Rr1MQEQYdtS6hQw03BHa9QOZQwiwWzUDe9P3Or/bst74Bthx0ZUTBtOiaH
	 W6X4rdOzHhEAw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
Date: Thu, 11 Jul 2024 13:38:55 +0300
Message-ID: <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Most of the IOMMU drivers are using the same DMA operations, which are
default ones implemented in drivers/iomem/dma-iomem.c. So it makes sense
to properly set them as a default with direct call without need to
perform function pointer dereference.

During system initialization, the IOMMU driver can set its own DMA and
in such case, the default DMA operations will be overridden.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 MAINTAINERS               |  1 +
 drivers/iommu/dma-iommu.c | 24 +++++++-------
 include/linux/iommu-dma.h | 50 +++++++++++++++++++++++++++++
 kernel/dma/iommu.h        | 67 +++++++++++++++++++++++++++++++++++++++
 kernel/dma/mapping.c      |  9 +++---
 5 files changed, 134 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/iommu-dma.h
 create mode 100644 kernel/dma/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index da5352dbd4f3..1e64be463da7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11544,6 +11544,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/
 F:	Documentation/userspace-api/iommu.rst
 F:	drivers/iommu/
+F:	include/linux/iommu-dma.h
 F:	include/linux/iommu.h
 F:	include/linux/iova.h
 F:	include/linux/of_iommu.h
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 43520e7275cc..54e95792ed90 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -17,6 +17,7 @@
 #include <linux/gfp.h>
 #include <linux/huge_mm.h>
 #include <linux/iommu.h>
+#include <linux/iommu-dma.h>
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/list_sort.h>
@@ -1134,9 +1135,9 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
 }
 
-static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
+			      unsigned long offset, size_t size,
+			      enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
@@ -1194,8 +1195,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	return iova;
 }
 
-static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
+void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
+			  size_t size, enum dma_data_direction dir,
+			  unsigned long attrs)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	phys_addr_t phys;
@@ -1348,8 +1350,8 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
  * impedance-matching, to be able to hand off a suitably-aligned list,
  * but still preserve the original offsets and sizes for the caller.
  */
-static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
+int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		     enum dma_data_direction dir, unsigned long attrs)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -1468,8 +1470,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	return ret;
 }
 
-static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
+void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+			enum dma_data_direction dir, unsigned long attrs)
 {
 	dma_addr_t end = 0, start;
 	struct scatterlist *tmp;
@@ -1731,10 +1733,6 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.free_noncontiguous	= iommu_dma_free_noncontiguous,
 	.mmap			= iommu_dma_mmap,
 	.get_sgtable		= iommu_dma_get_sgtable,
-	.map_page		= iommu_dma_map_page,
-	.unmap_page		= iommu_dma_unmap_page,
-	.map_sg			= iommu_dma_map_sg,
-	.unmap_sg		= iommu_dma_unmap_sg,
 	.sync_single_for_cpu	= iommu_dma_sync_single_for_cpu,
 	.sync_single_for_device	= iommu_dma_sync_single_for_device,
 	.sync_sg_for_cpu	= iommu_dma_sync_sg_for_cpu,
diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
new file mode 100644
index 000000000000..b42487bf8f8e
--- /dev/null
+++ b/include/linux/iommu-dma.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * DMA operations that map physical memory through IOMMU.
+ */
+#ifndef _LINUX_IOMMU_DMA_H
+#define _LINUX_IOMMU_DMA_H
+
+#include <linux/dma-direction.h>
+
+#ifdef CONFIG_IOMMU_API
+dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
+			      unsigned long offset, size_t size,
+			      enum dma_data_direction dir, unsigned long attrs);
+void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
+			  size_t size, enum dma_data_direction dir,
+			  unsigned long attrs);
+int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		     enum dma_data_direction dir, unsigned long attrs);
+void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+			enum dma_data_direction dir, unsigned long attrs);
+#else
+static inline dma_addr_t iommu_dma_map_page(struct device *dev,
+					    struct page *page,
+					    unsigned long offset, size_t size,
+					    enum dma_data_direction dir,
+					    unsigned long attrs)
+{
+	return DMA_MAPPING_ERROR;
+}
+static inline void iommu_dma_unmap_page(struct device *dev,
+					dma_addr_t dma_handle, size_t size,
+					enum dma_data_direction dir,
+					unsigned long attrs)
+{
+}
+static inline int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
+				   int nents, enum dma_data_direction dir,
+				   unsigned long attrs)
+{
+	return -EINVAL;
+}
+static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+			       int nents, enum dma_data_direction dir,
+			       unsigned long attrs)
+{
+}
+#endif /* CONFIG_IOMMU_API */
+#endif /* _LINUX_IOMMU_DMA_H */
diff --git a/kernel/dma/iommu.h b/kernel/dma/iommu.h
new file mode 100644
index 000000000000..4abaea2dfc49
--- /dev/null
+++ b/kernel/dma/iommu.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * DMA operations that map physical memory through IOMMU.
+ */
+#ifndef _KERNEL_DMA_IOMMU_H
+#define _KERNEL_DMA_IOMMU_H
+
+#include <linux/iommu-dma.h>
+
+static inline dma_addr_t dma_iommu_map_page(struct device *dev,
+					    struct page *page, size_t offset,
+					    size_t size,
+					    enum dma_data_direction dir,
+					    unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (ops->map_page)
+		return ops->map_page(dev, page, offset, size, dir, attrs);
+
+	return iommu_dma_map_page(dev, page, offset, size, dir, attrs);
+}
+
+static inline void dma_iommu_unmap_page(struct device *dev, dma_addr_t addr,
+					size_t size,
+					enum dma_data_direction dir,
+					unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (ops->unmap_page) {
+		ops->unmap_page(dev, addr, size, dir, attrs);
+		return;
+	}
+
+	iommu_dma_unmap_page(dev, addr, size, dir, attrs);
+}
+
+static inline int dma_iommu_map_sg(struct device *dev, struct scatterlist *sg,
+				   int nents, enum dma_data_direction dir,
+				   unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (ops->map_sg)
+		return ops->map_sg(dev, sg, nents, dir, attrs);
+
+	return iommu_dma_map_sg(dev, sg, nents, dir, attrs);
+}
+
+static inline void dma_iommu_unmap_sg(struct device *dev,
+				      struct scatterlist *sg, int nents,
+				      enum dma_data_direction dir,
+				      unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (ops->unmap_sg) {
+		ops->unmap_sg(dev, sg, nents, dir, attrs);
+		return;
+	}
+
+	iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
+}
+#endif /* _KERNEL_DMA_IOMMU_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 6832fd6f0796..a9aa4036362a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -16,6 +16,7 @@
 #include <linux/vmalloc.h>
 #include "debug.h"
 #include "direct.h"
+#include "iommu.h"
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
@@ -160,7 +161,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 	    arch_dma_map_page_direct(dev, page_to_phys(page) + offset + size))
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
-		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+		addr = dma_iommu_map_page(dev, page, offset, size, dir, attrs);
 	kmsan_handle_dma(page, offset, size, dir);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
 
@@ -178,7 +179,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 	    arch_dma_unmap_page_direct(dev, addr + size))
 		dma_direct_unmap_page(dev, addr, size, dir, attrs);
 	else
-		ops->unmap_page(dev, addr, size, dir, attrs);
+		dma_iommu_unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir);
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
@@ -198,7 +199,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	    arch_dma_map_sg_direct(dev, sg, nents))
 		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
 	else
-		ents = ops->map_sg(dev, sg, nents, dir, attrs);
+		ents = dma_iommu_map_sg(dev, sg, nents, dir, attrs);
 
 	if (ents > 0) {
 		kmsan_handle_dma_sg(sg, nents, dir);
@@ -292,7 +293,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 	    arch_dma_unmap_sg_direct(dev, sg, nents))
 		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
 	else
-		ops->unmap_sg(dev, sg, nents, dir, attrs);
+		dma_iommu_unmap_sg(dev, sg, nents, dir, attrs);
 }
 EXPORT_SYMBOL(dma_unmap_sg_attrs);
 
-- 
2.45.2

