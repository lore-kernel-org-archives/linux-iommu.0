From: Shuah Khan <shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH] iommu: change trace unmap api to report unmapped size
Date: Fri, 16 Jan 2015 20:53:17 -0700
Message-ID: <1421466797-8885-1-git-send-email-shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Shuah Khan <shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently map and unmap are implemented as events under a
common trace class declaration. The common class forces
trace_unmap() to require a bogus physical address argument
that it doesn't use. Changing unmap to report unmapped size
will provide useful information for debugging. Remove common
map_unmap trace class and change map and unmap into separate
events as opposed to events under the same class to allow for
differences in the reporting information. In addition, map and
unmap are changed to handle size value as size_t instead of int
to match the passed size value and avoid overflow.

Signed-off-by: Shuah Khan <shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Suggested-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iommu.c        |  2 +-
 include/trace/events/iommu.h | 31 ++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2eb7554..9e0dcdb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1134,7 +1134,7 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 		unmapped += unmapped_page;
 	}
 
-	trace_unmap(orig_iova, 0, size);
+	trace_unmap(orig_iova, size, unmapped);
 	return unmapped;
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index a8f5c32..2c7befb 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -83,7 +83,7 @@ DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
 	TP_ARGS(dev)
 );
 
-DECLARE_EVENT_CLASS(iommu_map_unmap,
+TRACE_EVENT(map,
 
 	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
 
@@ -92,7 +92,7 @@ DECLARE_EVENT_CLASS(iommu_map_unmap,
 	TP_STRUCT__entry(
 		__field(u64, iova)
 		__field(u64, paddr)
-		__field(int, size)
+		__field(size_t, size)
 	),
 
 	TP_fast_assign(
@@ -101,26 +101,31 @@ DECLARE_EVENT_CLASS(iommu_map_unmap,
 		__entry->size = size;
 	),
 
-	TP_printk("IOMMU: iova=0x%016llx paddr=0x%016llx size=0x%x",
+	TP_printk("IOMMU: iova=0x%016llx paddr=0x%016llx size=%zu",
 			__entry->iova, __entry->paddr, __entry->size
 	)
 );
 
-DEFINE_EVENT(iommu_map_unmap, map,
+TRACE_EVENT(unmap,
 
-	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
-
-	TP_ARGS(iova, paddr, size)
-);
+	TP_PROTO(unsigned long iova, size_t size, size_t unmapped_size),
 
-DEFINE_EVENT_PRINT(iommu_map_unmap, unmap,
+	TP_ARGS(iova, size, unmapped_size),
 
-	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
+	TP_STRUCT__entry(
+		__field(u64, iova)
+		__field(size_t, size)
+		__field(size_t, unmapped_size)
+	),
 
-	TP_ARGS(iova, paddr, size),
+	TP_fast_assign(
+		__entry->iova = iova;
+		__entry->size = size;
+		__entry->unmapped_size = unmapped_size;
+	),
 
-	TP_printk("IOMMU: iova=0x%016llx size=0x%x",
-			__entry->iova, __entry->size
+	TP_printk("IOMMU: iova=0x%016llx size=%zu unmapped_size=%zu",
+			__entry->iova, __entry->size, __entry->unmapped_size
 	)
 );
 
-- 
2.1.0
