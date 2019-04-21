From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 06/10] iommu/vt-d: Add trace events for domain map/unmap
Date: Sun, 21 Apr 2019 09:17:15 +0800
Message-ID: <20190421011719.14909-7-baolu.lu@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190421011719.14909-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This adds trace support for the Intel IOMMU driver. It
also declares some events which could be used to trace
the events when an IOVA is being mapped or unmapped in
a domain.

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/Makefile             |   1 +
 drivers/iommu/intel-trace.c        |  14 +++
 include/trace/events/intel_iommu.h | 132 +++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/iommu/intel-trace.c
 create mode 100644 include/trace/events/intel_iommu.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 8c71a15e986b..8b5fb8051281 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
+obj-$(CONFIG_INTEL_IOMMU) += intel-trace.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel-iommu-debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/intel-trace.c b/drivers/iommu/intel-trace.c
new file mode 100644
index 000000000000..bfb6a6e37a88
--- /dev/null
+++ b/drivers/iommu/intel-trace.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel IOMMU trace support
+ *
+ * Copyright (C) 2019 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
+ */
+
+#include <linux/string.h>
+#include <linux/types.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/intel_iommu.h>
diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
new file mode 100644
index 000000000000..49ca57a90079
--- /dev/null
+++ b/include/trace/events/intel_iommu.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel IOMMU trace support
+ *
+ * Copyright (C) 2019 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM intel_iommu
+
+#if !defined(_TRACE_INTEL_IOMMU_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_INTEL_IOMMU_H
+
+#include <linux/tracepoint.h>
+#include <linux/intel-iommu.h>
+
+TRACE_EVENT(bounce_map_single,
+	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
+		 size_t size),
+
+	TP_ARGS(dev, dev_addr, phys_addr, size),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(dma_addr_t, dev_addr)
+		__field(phys_addr_t, phys_addr)
+		__field(size_t,	size)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(dev));
+		__entry->dev_addr = dev_addr;
+		__entry->phys_addr = phys_addr;
+		__entry->size = size;
+	),
+
+	TP_printk("dev=%s dev_addr=0x%llx phys_addr=0x%llx size=%zu",
+		  __get_str(dev_name),
+		  (unsigned long long)__entry->dev_addr,
+		  (unsigned long long)__entry->phys_addr,
+		  __entry->size)
+);
+
+TRACE_EVENT(bounce_unmap_single,
+	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
+
+	TP_ARGS(dev, dev_addr, size),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(dma_addr_t, dev_addr)
+		__field(size_t,	size)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(dev));
+		__entry->dev_addr = dev_addr;
+		__entry->size = size;
+	),
+
+	TP_printk("dev=%s dev_addr=0x%llx size=%zu",
+		  __get_str(dev_name),
+		  (unsigned long long)__entry->dev_addr,
+		  __entry->size)
+);
+
+TRACE_EVENT(bounce_map_sg,
+	TP_PROTO(struct device *dev, unsigned int i, unsigned int nelems,
+		 dma_addr_t dev_addr, phys_addr_t phys_addr, size_t size),
+
+	TP_ARGS(dev, i, nelems, dev_addr, phys_addr, size),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(unsigned int, i)
+		__field(unsigned int, last)
+		__field(dma_addr_t, dev_addr)
+		__field(phys_addr_t, phys_addr)
+		__field(size_t,	size)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(dev));
+		__entry->i = i;
+		__entry->last = nelems - 1;
+		__entry->dev_addr = dev_addr;
+		__entry->phys_addr = phys_addr;
+		__entry->size = size;
+	),
+
+	TP_printk("dev=%s elem=%u/%u dev_addr=0x%llx phys_addr=0x%llx size=%zu",
+		  __get_str(dev_name), __entry->i, __entry->last,
+		  (unsigned long long)__entry->dev_addr,
+		  (unsigned long long)__entry->phys_addr,
+		  __entry->size)
+);
+
+TRACE_EVENT(bounce_unmap_sg,
+	TP_PROTO(struct device *dev, unsigned int i, unsigned int nelems,
+		 dma_addr_t dev_addr, phys_addr_t phys_addr, size_t size),
+
+	TP_ARGS(dev, i, nelems, dev_addr, phys_addr, size),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(unsigned int, i)
+		__field(unsigned int, last)
+		__field(dma_addr_t, dev_addr)
+		__field(phys_addr_t, phys_addr)
+		__field(size_t,	size)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(dev));
+		__entry->i = i;
+		__entry->last = nelems - 1;
+		__entry->dev_addr = dev_addr;
+		__entry->phys_addr = phys_addr;
+		__entry->size = size;
+	),
+
+	TP_printk("dev=%s elem=%u/%u dev_addr=0x%llx phys_addr=0x%llx size=%zu",
+		  __get_str(dev_name), __entry->i, __entry->last,
+		  (unsigned long long)__entry->dev_addr,
+		  (unsigned long long)__entry->phys_addr,
+		  __entry->size)
+);
+#endif /* _TRACE_INTEL_IOMMU_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1
