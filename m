Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E941192B73
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495452; cv=none; b=PvW+sD14+g0FjkXyu3jGnpE4SbfAzhWpE+SUmsGE0P2TKRtOi0aCCCNHPQwYITry/vahu2Qt2fQ0EH2bzVNtrMPcPb8ffCwB3RBzvqpYsRnQW3fmxDaRHWe0XEPD7vce/XCUNdMsFrT2OrDFRRq5Sdc35kvrFX7B4G1GkUT8ohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495452; c=relaxed/simple;
	bh=z9r1E1n1MkfQblbK869WFtMCFJHi5kCmMD8SiA+v0As=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X6PY0D4BmpFfRD6aOIkbQtnBNvVmDmDrGtl07dgUiVoNRpACoUQ8AkePjUtJ/bk+XAQqe94Rw/TcFA+YfLHXx3s6GdBa8LGwnsXT0iGQ9V55MVxSBjwhKlytVqAW4yrAQJVHi5LwKqTS/5qbEPEITPqJZAf+VPz/t9Uu4srgwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ACWXkZtd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ACWXkZtd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723495448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JUGlscjZ9It4yeML5SBXjbq8uMlJLcwt2MQT8BsMieE=;
	b=ACWXkZtdgHhhKdSYegvJHQyXY5IwIYQFkzV7UIe5Ht+kq31wKayOJ9wOH+Ay/+HCi+RmGe
	njHNJjEVBCaARwmv8YdpUEKdRk/6f3tB2dxou2XrUB17FVipKmgUKzH2CPauXI/D7xiRPu
	OtjHqSMqSgkB3AqDHAoP0CH0TtlG2DQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] dma: Trace dma_map/unmap_page
Date: Mon, 12 Aug 2024 16:43:57 -0400
Message-Id: <20240812204358.3587730-1-sean.anderson@linux.dev>
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
tracepoints for this purpose. While there are many other interesting DMA
functions, this is a useful start for simpler drivers.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 include/trace/events/dma.h | 103 +++++++++++++++++++++++++++++++++++++
 kernel/dma/mapping.c       |   5 ++
 2 files changed, 108 insertions(+)
 create mode 100644 include/trace/events/dma.h

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
new file mode 100644
index 000000000000..bc32e4302fde
--- /dev/null
+++ b/include/trace/events/dma.h
@@ -0,0 +1,103 @@
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
+TRACE_EVENT(dma_map_page,
+	TP_PROTO(struct device *dev, const struct page *page, size_t offset,
+		 size_t size, enum dma_data_direction dir, dma_addr_t addr,
+		 unsigned long attrs),
+	TP_ARGS(dev, page, offset, size, dir, addr, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(const struct page *, page)
+		__field(size_t, offset)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+		__field(dma_addr_t, addr)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->page = page;
+		__entry->offset = offset;
+		__entry->size = size;
+		__entry->dir = dir;
+		__entry->addr = addr;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s page=%p offset=%zu size=%zu dir=%s addr=%llx attrs=%s",
+		__get_str(device),
+		__entry->page,
+		__entry->offset,
+		__entry->size,
+		decode_dma_data_direction(__entry->dir),
+		(unsigned long long)__entry->addr,
+		decode_dma_attrs(__entry->attrs))
+);
+
+TRACE_EVENT(dma_unmap_page,
+	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
+		 enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, addr, size, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(dma_addr_t, addr)
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
+	TP_printk("%s addr=%llx size=%zu dir=%s attrs=%s",
+		__get_str(device),
+		(unsigned long long)__entry->addr,
+		__entry->size,
+		decode_dma_data_direction(__entry->dir),
+		decode_dma_attrs(__entry->attrs))
+);
+
+#endif /*  _TRACE_DMA_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b1c18058d55f..fb4c77f6f7cc 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -17,6 +17,9 @@
 #include "debug.h"
 #include "direct.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/dma.h>
+
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -162,6 +165,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
 	kmsan_handle_dma(page, offset, size, dir);
+	trace_dma_map_page(dev, page, offset, size, dir, addr, attrs);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
 
 	return addr;
@@ -179,6 +183,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		dma_direct_unmap_page(dev, addr, size, dir, attrs);
 	else if (ops->unmap_page)
 		ops->unmap_page(dev, addr, size, dir, attrs);
+	trace_dma_unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir);
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
-- 
2.35.1.1320.gc452695387.dirty

