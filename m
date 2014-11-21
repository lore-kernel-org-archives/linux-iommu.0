From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 2/4] iommu: iova: Export symbols
Date: Fri, 21 Nov 2014 13:11:41 +0200
Message-ID: <1416568303-677-3-git-send-email-sakari.ailus@linux.intel.com>
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

Use EXPORT_SYMBOL_GPL() to export the iova library symbols. The symbols
include:

	init_iova_domain();
	iova_cache_get();
	iova_cache_put();
	alloc_iova();
	find_iova();
	__free_iova();
	free_iova();
	put_iova_domain();
	reserve_iova();

This is necessary in order to use the iova library from a kernel module.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/iova.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 6bc7022..e9e62f4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -28,6 +28,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long pfn_32bit)
 	iovad->cached32_node = NULL;
 	iovad->dma_32bit_pfn = pfn_32bit;
 }
+EXPORT_SYMBOL_GPL(init_iova_domain);
 
 static struct rb_node *
 __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
@@ -230,6 +231,7 @@ int iova_cache_get(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iova_cache_get);
 
 void iova_cache_put(void)
 {
@@ -243,6 +245,7 @@ void iova_cache_put(void)
 		kmem_cache_destroy(iova_cache);
 	mutex_unlock(&iova_cache_mutex);
 }
+EXPORT_SYMBOL_GPL(iova_cache_put);
 
 /**
  * alloc_iova - allocates an iova
@@ -283,6 +286,7 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova;
 }
+EXPORT_SYMBOL_GPL(alloc_iova);
 
 /**
  * find_iova - find's an iova for a given pfn
@@ -323,6 +327,7 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(find_iova);
 
 /**
  * __free_iova - frees the given iova
@@ -341,6 +346,7 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	free_iova_mem(iova);
 }
+EXPORT_SYMBOL_GPL(__free_iova);
 
 /**
  * free_iova - finds and frees the iova for a given pfn
@@ -357,6 +363,7 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 		__free_iova(iovad, iova);
 
 }
+EXPORT_SYMBOL_GPL(free_iova);
 
 /**
  * put_iova_domain - destroys the iova doamin
@@ -378,6 +385,7 @@ void put_iova_domain(struct iova_domain *iovad)
 	}
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 }
+EXPORT_SYMBOL_GPL(put_iova_domain);
 
 static int
 __is_range_overlap(struct rb_node *node,
@@ -467,6 +475,7 @@ finish:
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return iova;
 }
+EXPORT_SYMBOL_GPL(reserve_iova);
 
 /**
  * copy_reserved_iova - copies the reserved between domains
-- 
2.1.0.231.g7484e3b
