From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/4] iommu: iova: Export symbols
Date: Mon, 13 Jul 2015 14:31:29 +0300
Message-ID: <1436787091-11943-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1436787091-11943-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1436787091-11943-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jian.xu.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Use EXPORT_SYMBOL_GPL() to export the iova library symbols. The symbols
include:

	init_iova_domain();
	iova_cache_get();
	iova_cache_put();
	iova_cache_init();
	alloc_iova();
	find_iova();
	__free_iova();
	free_iova();
	put_iova_domain();
	reserve_iova();
	copy_reserved_iova();

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/iova.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 400f4d1..dd87123 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -38,6 +38,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = pfn_32bit;
 }
+EXPORT_SYMBOL_GPL(init_iova_domain);
 
 static struct rb_node *
 __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
@@ -243,6 +244,7 @@ int iova_cache_get(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iova_cache_get);
 
 void iova_cache_put(void)
 {
@@ -256,6 +258,7 @@ void iova_cache_put(void)
 		kmem_cache_destroy(iova_cache);
 	mutex_unlock(&iova_cache_mutex);
 }
+EXPORT_SYMBOL_GPL(iova_cache_put);
 
 /**
  * alloc_iova - allocates an iova
@@ -296,6 +299,7 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova;
 }
+EXPORT_SYMBOL_GPL(alloc_iova);
 
 /**
  * find_iova - find's an iova for a given pfn
@@ -336,6 +340,7 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(find_iova);
 
 /**
  * __free_iova - frees the given iova
@@ -354,6 +359,7 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	free_iova_mem(iova);
 }
+EXPORT_SYMBOL_GPL(__free_iova);
 
 /**
  * free_iova - finds and frees the iova for a given pfn
@@ -371,6 +377,7 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 		__free_iova(iovad, iova);
 
 }
+EXPORT_SYMBOL_GPL(free_iova);
 
 /**
  * put_iova_domain - destroys the iova doamin
@@ -393,6 +400,7 @@ void put_iova_domain(struct iova_domain *iovad)
 	}
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 }
+EXPORT_SYMBOL_GPL(put_iova_domain);
 
 static int
 __is_range_overlap(struct rb_node *node,
@@ -482,6 +490,7 @@ finish:
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return iova;
 }
+EXPORT_SYMBOL_GPL(reserve_iova);
 
 /**
  * copy_reserved_iova - copies the reserved between domains
@@ -508,6 +517,7 @@ copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
 	}
 	spin_unlock_irqrestore(&from->iova_rbtree_lock, flags);
 }
+EXPORT_SYMBOL_GPL(copy_reserved_iova);
 
 struct iova *
 split_and_remove_iova(struct iova_domain *iovad, struct iova *iova,
-- 
2.1.0.231.g7484e3b
