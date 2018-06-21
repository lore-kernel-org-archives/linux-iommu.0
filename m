From: Dmitry Safonov <dima@arista.com>
Subject: [RFC 1/3] iommu/iova: Find and split iova under rbtree's lock
Date: Thu, 21 Jun 2018 19:08:21 +0100
Message-ID: <20180621180823.805-2-dima@arista.com>
References: <20180621180823.805-1-dima@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621180823.805-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <dima@arista.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Dmitry Safonov <0x7f454c46@gmail.com>
List-Id: iommu@lists.linux-foundation.org

find_iova() holds iova_rbtree_lock only during the traversing rbtree.
After the lock is released, returned iova may be freed (e.g., during
module's release).
Hold the spinlock during search and removal of iova from the rbtree,
eleminating possible use-after-free or/and double-free of iova.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/intel-iommu.c | 14 +++-----------
 drivers/iommu/iova.c        | 19 ++++++++++++-------
 include/linux/iova.h        | 10 ++++------
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 14e4b3722428..494394ef0f92 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4530,19 +4530,11 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 			struct intel_iommu *iommu;
 			struct page *freelist;
 
-			iova = find_iova(&si_domain->iovad, start_vpfn);
+			iova = iova_split_and_pop(&si_domain->iovad, start_vpfn, last_vpfn);
 			if (iova == NULL) {
-				pr_debug("Failed get IOVA for PFN %lx\n",
-					 start_vpfn);
-				break;
-			}
-
-			iova = split_and_remove_iova(&si_domain->iovad, iova,
-						     start_vpfn, last_vpfn);
-			if (iova == NULL) {
-				pr_warn("Failed to split IOVA PFN [%lx-%lx]\n",
+				pr_warn("Failed to split & pop IOVA PFN [%lx-%lx]\n",
 					start_vpfn, last_vpfn);
-				return NOTIFY_BAD;
+				break;
 			}
 
 			freelist = domain_unmap(si_domain, iova->pfn_lo,
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 83fe2621effe..4b38eb507670 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -715,23 +715,27 @@ copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
 }
 EXPORT_SYMBOL_GPL(copy_reserved_iova);
 
-struct iova *
-split_and_remove_iova(struct iova_domain *iovad, struct iova *iova,
+struct iova *iova_split_and_pop(struct iova_domain *iovad,
 		      unsigned long pfn_lo, unsigned long pfn_hi)
 {
-	unsigned long flags;
 	struct iova *prev = NULL, *next = NULL;
+	unsigned long flags;
+	struct iova *iova;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn_lo);
+	if (iova == NULL)
+		goto err_unlock;
+
 	if (iova->pfn_lo < pfn_lo) {
 		prev = alloc_and_init_iova(iova->pfn_lo, pfn_lo - 1);
 		if (prev == NULL)
-			goto error;
+			goto err_unlock;
 	}
 	if (iova->pfn_hi > pfn_hi) {
 		next = alloc_and_init_iova(pfn_hi + 1, iova->pfn_hi);
 		if (next == NULL)
-			goto error;
+			goto err_free;
 	}
 
 	__cached_rbnode_delete_update(iovad, iova);
@@ -749,10 +753,11 @@ split_and_remove_iova(struct iova_domain *iovad, struct iova *iova,
 
 	return iova;
 
-error:
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+err_free:
 	if (prev)
 		free_iova_mem(prev);
+err_unlock:
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return NULL;
 }
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 928442dda565..803472b77919 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -160,8 +160,8 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
-struct iova *split_and_remove_iova(struct iova_domain *iovad,
-	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
+struct iova *iova_split_and_pop(struct iova_domain *iovad,
+		unsigned long pfn_lo, unsigned long pfn_hi);
 void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 #else
 static inline int iova_cache_get(void)
@@ -253,10 +253,8 @@ static inline void put_iova_domain(struct iova_domain *iovad)
 {
 }
 
-static inline struct iova *split_and_remove_iova(struct iova_domain *iovad,
-						 struct iova *iova,
-						 unsigned long pfn_lo,
-						 unsigned long pfn_hi)
+static inline struct iova *iova_split_and_pop(struct iova_domain *iovad,
+		unsigned long pfn_lo, unsigned long pfn_hi)
 {
 	return NULL;
 }
-- 
2.13.6
