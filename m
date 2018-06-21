From: Dmitry Safonov <dima@arista.com>
Subject: [RFC 3/3] iommu/iova: Remove find_iova()
Date: Thu, 21 Jun 2018 19:08:23 +0100
Message-ID: <20180621180823.805-4-dima@arista.com>
References: <20180621180823.805-1-dima@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621180823.805-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <dima@arista.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Dmitry Safonov <0x7f454c46@gmail.com>
List-Id: iommu@lists.linux-foundation.org

This function is potentially dangerous: nothing protects returned iova.
As there is no user in tree anymore, delete it.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/iova.c | 20 --------------------
 include/linux/iova.h |  7 -------
 2 files changed, 27 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4c63d92afaf7..4a568e28a633 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -336,26 +336,6 @@ static void private_free_iova(struct iova_domain *iovad, struct iova *iova)
 }
 
 /**
- * find_iova - finds an iova for a given pfn
- * @iovad: - iova domain in question.
- * @pfn: - page frame number
- * This function finds and returns an iova belonging to the
- * given doamin which matches the given pfn.
- */
-struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
-{
-	unsigned long flags;
-	struct iova *iova;
-
-	/* Take the lock so that no other thread is manipulating the rbtree */
-	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	iova = private_find_iova(iovad, pfn);
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-	return iova;
-}
-EXPORT_SYMBOL_GPL(find_iova);
-
-/**
  * __free_iova - frees the given iova
  * @iovad: iova domain in question.
  * @iova: iova in question.
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 803472b77919..006911306a84 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -158,7 +158,6 @@ void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
 int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
-struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 struct iova *iova_split_and_pop(struct iova_domain *iovad,
 		unsigned long pfn_lo, unsigned long pfn_hi);
@@ -243,12 +242,6 @@ static inline int init_iova_flush_queue(struct iova_domain *iovad,
 	return -ENODEV;
 }
 
-static inline struct iova *find_iova(struct iova_domain *iovad,
-				     unsigned long pfn)
-{
-	return NULL;
-}
-
 static inline void put_iova_domain(struct iova_domain *iovad)
 {
 }
-- 
2.13.6
