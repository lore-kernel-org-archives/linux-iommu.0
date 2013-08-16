From: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] iommu: Add iommu_fault class event to iommu trace
Date: Fri, 16 Aug 2013 11:20:16 -0600
Message-ID: <7a14c27d8341e53f2aed7b80e08a4480d89eac5e.1376672275.git.shuah.kh@samsung.com>
References: <cover.1376672275.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1376672275.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
In-Reply-To: <cover.1376672275.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
References: <cover.1376672275.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, udknight-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add iommu_fault class event can be enabled to trigger when an iommu
fault occurs. This trace event is intended to be called to report the
fault information. Trace information includes driver name, device name,
iova, and flags.

iommu_fault:report_fault

Signed-off-by: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/iommu-traces.c |    3 +++
 include/trace/events/iommu.h |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/iommu/iommu-traces.c b/drivers/iommu/iommu-traces.c
index a2af60f..314aa93 100644
--- a/drivers/iommu/iommu-traces.c
+++ b/drivers/iommu/iommu-traces.c
@@ -22,3 +22,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(detach_device_from_domain);
 /* iommu_map_unmap */
 EXPORT_TRACEPOINT_SYMBOL_GPL(map);
 EXPORT_TRACEPOINT_SYMBOL_GPL(unmap);
+
+/* iommu_fault */
+EXPORT_TRACEPOINT_SYMBOL_GPL(report_fault);
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 86bcc5a..74847fb 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -123,6 +123,39 @@ DEFINE_EVENT_PRINT(iommu_map_unmap, unmap,
 			__entry->iova, __entry->size
 	)
 );
+
+DECLARE_EVENT_CLASS(iommu_fault,
+
+	TP_PROTO(struct device *dev, unsigned long iova, int flags),
+
+	TP_ARGS(dev, iova, flags),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__string(driver, dev_driver_string(dev))
+		__field(u64, iova)
+		__field(int, flags)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(dev));
+		__assign_str(driver, dev_driver_string(dev));
+		__entry->iova = iova;
+		__entry->flags = flags;
+	),
+
+	TP_printk("IOMMU:%s %s iova=0x%016llx flags=0x%04x",
+			__get_str(driver), __get_str(device),
+			__entry->iova, __entry->flags
+	)
+);
+
+DEFINE_EVENT(iommu_fault, report_fault,
+
+	TP_PROTO(struct device *dev, unsigned long iova, int flags),
+
+	TP_ARGS(dev, iova, flags)
+);
 #endif /* _TRACE_IOMMU_H */
 
 /* This part must be outside protection */
-- 
1.7.10.4
