From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 4/4] mm: EXPORT_SYMBOL_GPL({find_vm_area,get_vm_area_caller});
Date: Fri, 21 Nov 2014 13:11:43 +0200
Message-ID: <1416568303-677-5-git-send-email-sakari.ailus@linux.intel.com>
References: <1416568303-677-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1416568303-677-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

These APIs are needed in DMA mapping API implementation as a module. Device
specific IOMMUs with associated DMA mapping implementations should be
buildable as modules.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 90520af..f22c01c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1379,6 +1379,7 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 	return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
 				  NUMA_NO_NODE, GFP_KERNEL, caller);
 }
+EXPORT_SYMBOL_GPL(get_vm_area_caller);
 
 /**
  *	find_vm_area  -  find a continuous kernel virtual area
@@ -1398,6 +1399,7 @@ struct vm_struct *find_vm_area(const void *addr)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(find_vm_area);
 
 /**
  *	remove_vm_area  -  find and remove a continuous kernel virtual area
-- 
2.1.0.231.g7484e3b
