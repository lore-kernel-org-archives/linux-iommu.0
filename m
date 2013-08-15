From: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/7] iommu: Add event tracing feature to iommu
Date: Thu, 15 Aug 2013 11:59:23 -0600
Message-ID: <80adec4568f19b3e640bb4570edf0b806796a983.1376587770.git.shuah.kh@samsung.com>
References: <cover.1376587770.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1376587770.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
In-Reply-To: <cover.1376587770.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
References: <cover.1376587770.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add tracing feature to iommu to report various iommu events. Classes
iommu_group, iommu_device, and iommu_map_unmap are defined.

iommu_group class events can be enabled to trigger when devices get added
to and removed from an iommu group. Trace information includes iommu group
id and device name.

iommu:add_device_to_group
iommu:remove_device_from_group

iommu_device class events can be enabled to trigger when devices are attached
to and detached from a domain. Trace information includes device name.

iommu:attach_device_to_domain
iommu:detach_device_from_domain

iommu_map_unmap class events can be enabled to trigger when iommu map and
unmap iommu ops. Trace information includes iova, physical address (map event
only), and size.

iommu:map
iommu:unmap

Signed-off-by: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/Makefile       |    1 +
 drivers/iommu/iommu-traces.c |   24 ++++++++
 drivers/iommu/iommu.c        |    1 +
 include/trace/events/iommu.h |  129 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 155 insertions(+)
 create mode 100644 drivers/iommu/iommu-traces.c
 create mode 100644 include/trace/events/iommu.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index bbe7041..9015c45 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_IOMMU_API) += iommu.o
+obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
diff --git a/drivers/iommu/iommu-traces.c b/drivers/iommu/iommu-traces.c
new file mode 100644
index 0000000..a2af60f
--- /dev/null
+++ b/drivers/iommu/iommu-traces.c
@@ -0,0 +1,24 @@
+/*
+ * iommu trace points
+ *
+ * Copyright (C) 2013 Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+ *
+ */
+
+#include <linux/string.h>
+#include <linux/types.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/iommu.h>
+
+/* iommu_group_event */
+EXPORT_TRACEPOINT_SYMBOL_GPL(add_device_to_group);
+EXPORT_TRACEPOINT_SYMBOL_GPL(remove_device_from_group);
+
+/* iommu_device_event */
+EXPORT_TRACEPOINT_SYMBOL_GPL(attach_device_to_domain);
+EXPORT_TRACEPOINT_SYMBOL_GPL(detach_device_from_domain);
+
+/* iommu_map_unmap */
+EXPORT_TRACEPOINT_SYMBOL_GPL(map);
+EXPORT_TRACEPOINT_SYMBOL_GPL(unmap);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fbe9ca7..58f6a16 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/notifier.h>
 #include <linux/err.h>
+#include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
 static struct ida iommu_group_ida;
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
new file mode 100644
index 0000000..86bcc5a
--- /dev/null
+++ b/include/trace/events/iommu.h
@@ -0,0 +1,129 @@
+/*
+ * iommu trace points
+ *
+ * Copyright (C) 2013 Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+ *
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM iommu
+
+#if !defined(_TRACE_IOMMU_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_IOMMU_H
+
+#include <linux/tracepoint.h>
+#include <linux/pci.h>
+
+struct device;
+
+DECLARE_EVENT_CLASS(iommu_group_event,
+
+	TP_PROTO(int group_id, struct device *dev),
+
+	TP_ARGS(group_id, dev),
+
+	TP_STRUCT__entry(
+		__field(int, gid)
+		__string(device, dev_name(dev))
+	),
+
+	TP_fast_assign(
+		__entry->gid = group_id;
+		__assign_str(device, dev_name(dev));
+	),
+
+	TP_printk("IOMMU: groupID=%d device=%s",
+			__entry->gid, __get_str(device)
+	)
+);
+
+DEFINE_EVENT(iommu_group_event, add_device_to_group,
+
+	TP_PROTO(int group_id, struct device *dev),
+
+	TP_ARGS(group_id, dev)
+
+);
+
+DEFINE_EVENT(iommu_group_event, remove_device_from_group,
+
+	TP_PROTO(int group_id, struct device *dev),
+
+	TP_ARGS(group_id, dev)
+);
+
+DECLARE_EVENT_CLASS(iommu_device_event,
+
+	TP_PROTO(struct device *dev),
+
+	TP_ARGS(dev),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(dev));
+	),
+
+	TP_printk("IOMMU: device=%s", __get_str(device)
+	)
+);
+
+DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
+
+	TP_PROTO(struct device *dev),
+
+	TP_ARGS(dev)
+);
+
+DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
+
+	TP_PROTO(struct device *dev),
+
+	TP_ARGS(dev)
+);
+
+DECLARE_EVENT_CLASS(iommu_map_unmap,
+
+	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
+
+	TP_ARGS(iova, paddr, size),
+
+	TP_STRUCT__entry(
+		__field(u64, iova)
+		__field(u64, paddr)
+		__field(int, size)
+	),
+
+	TP_fast_assign(
+		__entry->iova = iova;
+		__entry->paddr = paddr;
+		__entry->size = size;
+	),
+
+	TP_printk("IOMMU: iova=0x%016llx paddr=0x%016llx size=0x%x",
+			__entry->iova, __entry->paddr, __entry->size
+	)
+);
+
+DEFINE_EVENT(iommu_map_unmap, map,
+
+	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
+
+	TP_ARGS(iova, paddr, size)
+);
+
+DEFINE_EVENT_PRINT(iommu_map_unmap, unmap,
+
+	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
+
+	TP_ARGS(iova, paddr, size),
+
+	TP_printk("IOMMU: iova=0x%016llx size=0x%x",
+			__entry->iova, __entry->size
+	)
+);
+#endif /* _TRACE_IOMMU_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.10.4
