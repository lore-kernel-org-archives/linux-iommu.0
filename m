From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 21/22] trace/iommu: add sva trace events
Date: Mon, 16 Apr 2018 14:49:10 -0700
Message-ID: <1523915351-54415-22-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/trace/events/iommu.h | 112 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 72b4582..e64eb29 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -12,6 +12,8 @@
 #define _TRACE_IOMMU_H
 
 #include <linux/tracepoint.h>
+#include <linux/iommu.h>
+#include <uapi/linux/iommu.h>
 
 struct device;
 
@@ -161,6 +163,116 @@ DEFINE_EVENT(iommu_error, io_page_fault,
 
 	TP_ARGS(dev, iova, flags)
 );
+
+TRACE_EVENT(dev_fault,
+
+	TP_PROTO(struct device *dev,  struct iommu_fault_event *evt),
+
+	TP_ARGS(dev, evt),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(int, type)
+		__field(int, reason)
+		__field(u64, addr)
+		__field(u32, pasid)
+		__field(u32, pgid)
+		__field(u32, last_req)
+		__field(u32, prot)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(dev));
+		__entry->type = evt->type;
+		__entry->reason = evt->reason;
+		__entry->addr = evt->addr;
+		__entry->pasid = evt->pasid;
+		__entry->pgid = evt->page_req_group_id;
+		__entry->last_req = evt->last_req;
+		__entry->prot = evt->prot;
+	),
+
+	TP_printk("IOMMU:%s type=%d reason=%d addr=0x%016llx pasid=%d group=%d last=%d prot=%d",
+		__get_str(device),
+		__entry->type,
+		__entry->reason,
+		__entry->addr,
+		__entry->pasid,
+		__entry->pgid,
+		__entry->last_req,
+		__entry->prot
+	)
+);
+
+TRACE_EVENT(dev_page_response,
+
+	TP_PROTO(struct device *dev,  struct page_response_msg *msg),
+
+	TP_ARGS(dev, msg),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(int, code)
+		__field(u64, addr)
+		__field(u32, pasid)
+		__field(u32, pgid)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(dev));
+		__entry->code = msg->resp_code;
+		__entry->addr = msg->addr;
+		__entry->pasid = msg->pasid;
+		__entry->pgid = msg->page_req_group_id;
+	),
+
+	TP_printk("IOMMU:%s code=%d addr=0x%016llx pasid=%d group=%d",
+		__get_str(device),
+		__entry->code,
+		__entry->addr,
+		__entry->pasid,
+		__entry->pgid
+	)
+);
+
+TRACE_EVENT(sva_invalidate,
+
+	TP_PROTO(struct device *dev,  struct tlb_invalidate_info *ti),
+
+	TP_ARGS(dev, ti),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(int, type)
+		__field(u32, granu)
+		__field(u32, flags)
+		__field(u8, size)
+		__field(u32, pasid)
+		__field(u64, addr)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(dev));
+		__entry->type = ti->hdr.type;
+		__entry->flags = ti->flags;
+		__entry->granu = ti->granularity;
+		__entry->size = ti->size;
+		__entry->pasid = ti->pasid;
+		__entry->addr = ti->addr;
+	),
+
+	TP_printk("IOMMU:%s type=%d flags=0x%08x granu=%d size=%d pasid=%d addr=0x%016llx",
+		__get_str(device),
+		__entry->type,
+		__entry->flags,
+		__entry->granu,
+		__entry->size,
+		__entry->pasid,
+		__entry->addr
+	)
+);
+
+
 #endif /* _TRACE_IOMMU_H */
 
 /* This part must be outside protection */
-- 
2.7.4
