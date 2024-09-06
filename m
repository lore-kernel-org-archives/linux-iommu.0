Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254915AD9C
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659686; cv=none; b=Rnulmn9yGhFceSybTx0xE31rCcMwfTeh4SNye54IPeJnpY/y4Aonq4ydfvj7q6PiOQQvNvf9K8dr/HCg+OxhGO3N78L6Sc06n8tKYr/JqUwLlcWjF7OFUyceC8SSrz3HM0FzeeWwegToKMSorVyZjds94J/P4P6MUmwaSF6K4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659686; c=relaxed/simple;
	bh=0nQN06vxBLik5RYFwmShuM8bgPJCYLYTgw4kh1Onzyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oXQak3dy9bunXaP3PlXG2afHCHRcswFEd+n83Ml/DoRO2O9xvNimghT+EYH4EPbMTKT2zVrKZ9cM9yMKIlHVjg0ZfuumUJ+wia0qVp17CUzCfjS46BVgfBXfo0u+wC3w5Jgv00T3SY2zakgfMNmKHF3WZSMNA/G+psvAZzCmQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tQuTH6SU; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tQuTH6SU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725659680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ajeSDJb0FyNUL+ZgXxMYR8Meno+EnUEDZmVAUCZRm8w=;
	b=tQuTH6SUSlbmvxURAxuIa6ULlHx8oPT1sURa5x/ZXHI7eZcK5Xl6LFVjp4n9K3X/TUA/DZ
	sSZEFrD30isAq4YO8tQWP4JugAJm/L4cavfbl33k1nTo84O90UcA+tl40kMYojQ3Cs+2Dw
	I7sppOhPGBYEidFH6s8mjOseMzVewOE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4] dma-mapping: add tracing for dma-mapping API calls
Date: Fri,  6 Sep 2024 17:54:34 -0400
Message-Id: <20240906215435.636352-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When debugging drivers, it can often be useful to trace when memory gets
(un)mapped for DMA (and can be accessed by the device). Add some
tracepoints for this purpose.

We use unsigned long long instead of phys_addr_t and dma_addr_t (and
similarly %llx instead of %pa) because libtraceevent can't handle
typedefs.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
Well, I ended up needing the other stuff to debug a different driver, so
here's the whole API.

Changes in v4:
- Use u64 instead of unsigned long long pending a patch to libtraceevent
  for arrays.
- Reword patch subject to better reflect contents

Changes in v3:
- Trace the rest too

Changes in v2:
- Trace dma_(un)map_sg and dma_(un)map_resource

 include/trace/events/dma.h | 341 +++++++++++++++++++++++++++++++++++++
 kernel/dma/mapping.c       |  24 ++-
 2 files changed, 364 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/dma.h

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
new file mode 100644
index 000000000000..f57f05331d73
--- /dev/null
+++ b/include/trace/events/dma.h
@@ -0,0 +1,341 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dma
+
+#if !defined(_TRACE_DMA_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DMA_H
+
+#include <linux/tracepoint.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <trace/events/mmflags.h>
+
+TRACE_DEFINE_ENUM(DMA_BIDIRECTIONAL);
+TRACE_DEFINE_ENUM(DMA_TO_DEVICE);
+TRACE_DEFINE_ENUM(DMA_FROM_DEVICE);
+TRACE_DEFINE_ENUM(DMA_NONE);
+
+#define decode_dma_data_direction(dir) \
+	__print_symbolic(dir, \
+		{ DMA_BIDIRECTIONAL, "BIDIRECTIONAL" }, \
+		{ DMA_TO_DEVICE, "TO_DEVICE" }, \
+		{ DMA_FROM_DEVICE, "FROM_DEVICE" }, \
+		{ DMA_NONE, "NONE" })
+
+#define decode_dma_attrs(attrs) \
+	__print_flags(attrs, "|", \
+		{ DMA_ATTR_WEAK_ORDERING, "WEAK_ORDERING" }, \
+		{ DMA_ATTR_WRITE_COMBINE, "WRITE_COMBINE" }, \
+		{ DMA_ATTR_NO_KERNEL_MAPPING, "NO_KERNEL_MAPPING" }, \
+		{ DMA_ATTR_SKIP_CPU_SYNC, "SKIP_CPU_SYNC" }, \
+		{ DMA_ATTR_FORCE_CONTIGUOUS, "FORCE_CONTIGUOUS" }, \
+		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
+		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
+		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" })
+
+DECLARE_EVENT_CLASS(dma_map,
+	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(u64, phys_addr)
+		__field(u64, dma_addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->phys_addr = phys_addr;
+		__entry->dma_addr = dma_addr;
+		__entry->size = size;
+		__entry->dir = dir;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu phys_addr=%llx attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->dma_addr,
+		__entry->size,
+		__entry->phys_addr,
+		decode_dma_attrs(__entry->attrs))
+);
+
+DEFINE_EVENT(dma_map, dma_map_page,
+	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs));
+
+DEFINE_EVENT(dma_map, dma_map_resource,
+	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs));
+
+DECLARE_EVENT_CLASS(dma_unmap,
+	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
+		 enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, addr, size, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(u64, addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->addr = addr;
+		__entry->size = size;
+		__entry->dir = dir;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->addr,
+		__entry->size,
+		decode_dma_attrs(__entry->attrs))
+);
+
+DEFINE_EVENT(dma_unmap, dma_unmap_page,
+	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
+		 enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, addr, size, dir, attrs));
+
+DEFINE_EVENT(dma_unmap, dma_unmap_resource,
+	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
+		 enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, addr, size, dir, attrs));
+
+TRACE_EVENT(dma_alloc,
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
+		 size_t size, gfp_t flags, unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, flags, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(u64, phys_addr)
+		__field(u64, dma_addr)
+		__field(size_t, size)
+		__field(gfp_t, flags)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->phys_addr = virt_to_phys(virt_addr);
+		__entry->dma_addr = dma_addr;
+		__entry->size = size;
+		__entry->flags = flags;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dma_addr=%llx size=%zu phys_addr=%llx flags=%s attrs=%s",
+		__get_str(device),
+		__entry->dma_addr,
+		__entry->size,
+		__entry->phys_addr,
+		show_gfp_flags(__entry->flags),
+		decode_dma_attrs(__entry->attrs))
+);
+
+TRACE_EVENT(dma_free,
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
+		 size_t size, unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(u64, phys_addr)
+		__field(u64, dma_addr)
+		__field(size_t, size)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->phys_addr = virt_to_phys(virt_addr);
+		__entry->dma_addr = dma_addr;
+		__entry->size = size;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dma_addr=%llx size=%zu phys_addr=%llx attrs=%s",
+		__get_str(device),
+		__entry->dma_addr,
+		__entry->size,
+		__entry->phys_addr,
+		decode_dma_attrs(__entry->attrs))
+);
+
+TRACE_EVENT(dma_map_sg,
+	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+		 int ents, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, sg, nents, ents, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, phys_addrs, nents)
+		__dynamic_array(u64, dma_addrs, ents)
+		__dynamic_array(unsigned int, lengths, ents)
+		__field(enum dma_data_direction, dir)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		int i;
+
+		__assign_str(device);
+		for (i = 0; i < nents; i++)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] =
+				sg_phys(sg + i);
+		for (i = 0; i < ents; i++) {
+			((u64 *)__get_dynamic_array(dma_addrs))[i] =
+				sg_dma_address(sg + i);
+			((unsigned int *)__get_dynamic_array(lengths))[i] =
+				sg_dma_len(sg + i);
+		}
+		__entry->dir = dir;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addrs=%s sizes=%s phys_addrs=%s attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__print_array(__get_dynamic_array(dma_addrs),
+			      __get_dynamic_array_len(dma_addrs) /
+				sizeof(u64), sizeof(u64)),
+		__print_array(__get_dynamic_array(lengths),
+			      __get_dynamic_array_len(lengths) /
+				sizeof(unsigned int), sizeof(unsigned int)),
+		__print_array(__get_dynamic_array(phys_addrs),
+			      __get_dynamic_array_len(phys_addrs) /
+				sizeof(u64), sizeof(u64)),
+		decode_dma_attrs(__entry->attrs))
+);
+
+TRACE_EVENT(dma_unmap_sg,
+	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+		 enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, sg, nents, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, addrs, nents)
+		__field(enum dma_data_direction, dir)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		int i;
+
+		__assign_str(device);
+		for (i = 0; i < nents; i++)
+			((u64 *)__get_dynamic_array(addrs))[i] =
+				sg_phys(sg + i);
+		__entry->dir = dir;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s phys_addrs=%s attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__print_array(__get_dynamic_array(addrs),
+			      __get_dynamic_array_len(addrs) /
+				sizeof(u64), sizeof(u64)),
+		decode_dma_attrs(__entry->attrs))
+);
+
+DECLARE_EVENT_CLASS(dma_sync_single,
+	TP_PROTO(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction dir),
+	TP_ARGS(dev, dma_addr, size, dir),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(u64, dma_addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->dma_addr = dma_addr;
+		__entry->size = size;
+		__entry->dir = dir;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->dma_addr,
+		__entry->size)
+);
+
+DEFINE_EVENT(dma_sync_single, dma_sync_single_for_cpu,
+	TP_PROTO(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction dir),
+	TP_ARGS(dev, dma_addr, size, dir));
+
+DEFINE_EVENT(dma_sync_single, dma_sync_single_for_device,
+	TP_PROTO(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction dir),
+	TP_ARGS(dev, dma_addr, size, dir));
+
+DECLARE_EVENT_CLASS(dma_sync_sg,
+	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+		 enum dma_data_direction dir),
+	TP_ARGS(dev, sg, nents, dir),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, dma_addrs, nents)
+		__dynamic_array(unsigned int, lengths, nents)
+		__field(enum dma_data_direction, dir)
+	),
+
+	TP_fast_assign(
+		int i;
+
+		__assign_str(device);
+		for (i = 0; i < nents; i++) {
+			((u64 *)__get_dynamic_array(dma_addrs))[i] =
+				sg_dma_address(sg + i);
+			((unsigned int *)__get_dynamic_array(lengths))[i] =
+				sg_dma_len(sg + i);
+		}
+		__entry->dir = dir;
+	),
+
+	TP_printk("%s dir=%s dma_addrs=%s sizes=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__print_array(__get_dynamic_array(dma_addrs),
+			      __get_dynamic_array_len(dma_addrs) /
+				sizeof(u64), sizeof(u64)),
+		__print_array(__get_dynamic_array(lengths),
+			      __get_dynamic_array_len(lengths) /
+				sizeof(unsigned int), sizeof(unsigned int)))
+);
+
+DEFINE_EVENT(dma_sync_sg, dma_sync_sg_for_cpu,
+	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+		 enum dma_data_direction dir),
+	TP_ARGS(dev, sg, nents, dir));
+
+DEFINE_EVENT(dma_sync_sg, dma_sync_sg_for_device,
+	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+		 enum dma_data_direction dir),
+	TP_ARGS(dev, sg, nents, dir));
+
+#endif /*  _TRACE_DMA_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b50ae3d198a6..94823d779f68 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -18,6 +18,9 @@
 #include "debug.h"
 #include "direct.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/dma.h>
+
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -181,6 +184,8 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
 	kmsan_handle_dma(page, offset, size, dir);
+	trace_dma_map_page(dev, page_to_phys(page) + offset, addr, size, dir,
+			   attrs);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
 
 	return addr;
@@ -200,6 +205,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		iommu_dma_unmap_page(dev, addr, size, dir, attrs);
 	else
 		ops->unmap_page(dev, addr, size, dir, attrs);
+	trace_dma_unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir);
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
@@ -225,6 +231,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	if (ents > 0) {
 		kmsan_handle_dma_sg(sg, nents, dir);
+		trace_dma_map_sg(dev, sg, nents, ents, dir, attrs);
 		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
 	} else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
 				ents != -EIO && ents != -EREMOTEIO)) {
@@ -310,6 +317,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
+	trace_dma_unmap_sg(dev, sg, nents, dir, attrs);
 	debug_dma_unmap_sg(dev, sg, nents, dir);
 	if (dma_map_direct(dev, ops) ||
 	    arch_dma_unmap_sg_direct(dev, sg, nents))
@@ -339,6 +347,7 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 	else if (ops->map_resource)
 		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
 
+	trace_dma_map_resource(dev, phys_addr, addr, size, dir, attrs);
 	debug_dma_map_resource(dev, phys_addr, size, dir, addr, attrs);
 	return addr;
 }
@@ -356,6 +365,7 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 		iommu_dma_unmap_resource(dev, addr, size, dir, attrs);
 	else if (ops->unmap_resource)
 		ops->unmap_resource(dev, addr, size, dir, attrs);
+	trace_dma_unmap_resource(dev, addr, size, dir, attrs);
 	debug_dma_unmap_resource(dev, addr, size, dir);
 }
 EXPORT_SYMBOL(dma_unmap_resource);
@@ -373,6 +383,7 @@ void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 		iommu_dma_sync_single_for_cpu(dev, addr, size, dir);
 	else if (ops->sync_single_for_cpu)
 		ops->sync_single_for_cpu(dev, addr, size, dir);
+	trace_dma_sync_single_for_cpu(dev, addr, size, dir);
 	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
 }
 EXPORT_SYMBOL(__dma_sync_single_for_cpu);
@@ -389,6 +400,7 @@ void __dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
 		iommu_dma_sync_single_for_device(dev, addr, size, dir);
 	else if (ops->sync_single_for_device)
 		ops->sync_single_for_device(dev, addr, size, dir);
+	trace_dma_sync_single_for_device(dev, addr, size, dir);
 	debug_dma_sync_single_for_device(dev, addr, size, dir);
 }
 EXPORT_SYMBOL(__dma_sync_single_for_device);
@@ -405,6 +417,7 @@ void __dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		iommu_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
 	else if (ops->sync_sg_for_cpu)
 		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
+	trace_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
 	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
 }
 EXPORT_SYMBOL(__dma_sync_sg_for_cpu);
@@ -421,6 +434,7 @@ void __dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		iommu_dma_sync_sg_for_device(dev, sg, nelems, dir);
 	else if (ops->sync_sg_for_device)
 		ops->sync_sg_for_device(dev, sg, nelems, dir);
+	trace_dma_sync_sg_for_device(dev, sg, nelems, dir);
 	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
 }
 EXPORT_SYMBOL(__dma_sync_sg_for_device);
@@ -613,6 +627,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	else
 		return NULL;
 
+	trace_dma_alloc(dev, cpu_addr, *dma_handle, size, flag, attrs);
 	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
 	return cpu_addr;
 }
@@ -637,6 +652,7 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	if (!cpu_addr)
 		return;
 
+	trace_dma_free(dev, cpu_addr, dma_handle, size, attrs);
 	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
 	if (dma_alloc_direct(dev, ops))
 		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
@@ -674,8 +690,11 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 {
 	struct page *page = __dma_alloc_pages(dev, size, dma_handle, dir, gfp);
 
-	if (page)
+	if (page) {
+		trace_dma_map_page(dev, page_to_phys(page), *dma_handle, size,
+				   dir, 0);
 		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
+	}
 	return page;
 }
 EXPORT_SYMBOL_GPL(dma_alloc_pages);
@@ -697,6 +716,7 @@ static void __dma_free_pages(struct device *dev, size_t size, struct page *page,
 void dma_free_pages(struct device *dev, size_t size, struct page *page,
 		dma_addr_t dma_handle, enum dma_data_direction dir)
 {
+	trace_dma_unmap_page(dev, dma_handle, size, dir, 0);
 	debug_dma_unmap_page(dev, dma_handle, size, dir);
 	__dma_free_pages(dev, size, page, dma_handle, dir);
 }
@@ -759,6 +779,7 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 
 	if (sgt) {
 		sgt->nents = 1;
+		trace_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
 		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
 	}
 	return sgt;
@@ -779,6 +800,7 @@ void dma_free_noncontiguous(struct device *dev, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
+	trace_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir, 0);
 	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
 	if (ops && ops->free_noncontiguous)
 		ops->free_noncontiguous(dev, size, sgt, dir);
-- 
2.35.1.1320.gc452695387.dirty

