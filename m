Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DEF3F7897;
	Wed,  3 Jun 2026 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457841; cv=none; b=KTW9w2KHzXsj0/WbKIZ75VELc27/yOyYhrU9MjIZi0p5PkAQVwclGNfonESb2sOkyhIt1XQli5FQ7cWz9pVXs13botS7MF8VcrgIRL7Y89l1Ivuybz/ee2ZVyM+pCO+ADe9rHgZ/CUhaMAkiG9vs4pBYmt7p8g0qgp+D8zHdN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457841; c=relaxed/simple;
	bh=RTXNSl9tzV2JhUxrhyViDaR1SVISk4XO1r4OZXm0vRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6lVn07dzHPjCPaCZ079StpqPek6MIVgXR+OP5/Pr596/5lx7T+hALC80/WuOP/o7l0/cWRWyslroE+ct2yNnC8ubmWqce+dtwrNBUJ5G3FrkAn7ot/Ole5h4JehT/VIxZfaaUv7xCjgK3ROiwtl1RcH8yYLQoVpdLBFRTq4ZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=QUdqRXsz; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="QUdqRXsz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UzbOAxtdeLtO5GN7ci5TBmbpzOG8jujIM+3oC4Zy8NI=; b=QUdqRXsz3eQ1XsyASt3Y7eAhB+
	KWPL2A6jkzLbb3nNVSTynC9HGwrHPO2b0U/+675d4b+iDYYzYQqkH5cr7DaxqFN3MyE40ZV1Z0yJ4
	15yvnASSVUV5kXBbOu+11ruyTHp/4N49v/GzajMlf4dpSF1CAPDhG9eEbWrOZJMYaFevcsGJDzadJ
	koFdMPop7hcUrblYuL7x46wiRZLLZYMzq65AlCaV8pQjs5Kw4oZEWa9kDanNv/A7OTtqBDxR7JMK7
	OQYv9bk/egjYaZXA/S608b0pjZSGl2u8pkSFbSW9JLaL3DRZPsePIbo3A0w1yDHxRaRFOuq7RXLLX
	esnQz2CQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wUcPg-000000002VG-1WYZ;
	Tue, 02 Jun 2026 23:37:04 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	kyle@mcmartin.ca,
	Rik van Riel <riel@meta.com>,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Date: Tue,  2 Jun 2026 23:35:48 -0400
Message-ID: <20260603033653.4144138-4-riel@surriel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603033653.4144138-1-riel@surriel.com>
References: <20260603033653.4144138-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@meta.com>

The maple tree may need to allocate nodes during erase operations
for tree rebalancing. Unlike the old rbtree where rb_erase() never
allocated, mas_store_gfp(NULL, GFP_ATOMIC) can fail under memory
pressure. Since the IOVA allocator runs in atomic context (DMA
map/unmap can be called from hardirq, softirq, or with spinlocks
held), GFP_KERNEL allocation is not possible.

Add a deferred free mechanism: when mas_store_gfp(NULL, GFP_ATOMIC)
fails, the iova entry remains in the maple tree (preventing address
reuse and keeping the pointer valid) and is added to a lockless
per-domain deferred free list. A delayed workqueue retries the erase
with GFP_ATOMIC after a 10ms delay -- by the time the workqueue runs,
transient memory pressure has typically subsided and the allocation
succeeds.

The deferred free path temporarily reduces available IOVA address
space until the workqueue processes the backlog, but causes no
corruption -- the entry stays in the tree and the struct iova is not
freed until the erase succeeds.

put_iova_domain() cancels the delayed work and discards the deferred
list before destroying the tree. Since deferred entries remain in
the maple tree, the mas_for_each teardown loop frees them along with
all other entries, avoiding a double-free.

In practice, GFP_ATOMIC erase failures are quite rare: the slab
allocator maintains emergency reserves for GFP_ATOMIC, and the common
erase case (exact_fit, slot_store) needs zero node allocations. This
mechanism is a safety net for the exceptional case.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/iommu/iova.c | 84 +++++++++++++++++++++++++++++++++++++++-----
 include/linux/iova.h |  3 ++
 2 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 1ceab6cbefc2..ae89d780fce5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -7,6 +7,7 @@
 
 #include <linux/iova.h>
 #include <linux/kmemleak.h>
+#include <linux/llist.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -26,6 +27,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_global_cached_iovas(struct iova_domain *iovad);
+static void iova_deferred_free_work(struct work_struct *work);
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
@@ -46,6 +48,8 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
+	init_llist_head(&iovad->deferred_frees);
+	INIT_DELAYED_WORK(&iovad->deferred_free_work, iova_deferred_free_work);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
@@ -156,7 +160,13 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 	return mas_walk(&mas);
 }
 
-static void remove_iova(struct iova_domain *iovad, struct iova *iova)
+/*
+ * Remove an IOVA entry from the maple tree. Returns true on success.
+ * On failure (maple tree node allocation under GFP_ATOMIC failed),
+ * returns false — the entry remains in the tree and the caller must
+ * not free the struct iova.
+ */
+static bool remove_iova(struct iova_domain *iovad, struct iova *iova)
 {
 	MA_STATE(mas, &iovad->mtree, iova->pfn_lo, iova->pfn_hi);
 
@@ -165,7 +175,36 @@ static void remove_iova(struct iova_domain *iovad, struct iova *iova)
 	if (iova->pfn_lo < iovad->dma_32bit_pfn)
 		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 
-	mas_store_gfp(&mas, NULL, GFP_ATOMIC);
+	if (mas_store_gfp(&mas, NULL, GFP_ATOMIC))
+		return false;
+	return true;
+}
+
+static void iova_deferred_free_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct iova_domain *iovad = container_of(dwork, struct iova_domain,
+						 deferred_free_work);
+	struct llist_node *list = llist_del_all(&iovad->deferred_frees);
+	struct llist_node *node, *next;
+
+	llist_for_each_safe(node, next, list) {
+		struct iova *iova = container_of(node, struct iova,
+						 deferred_free);
+		unsigned long flags;
+
+		spin_lock_irqsave(&iovad->iova_lock, flags);
+		if (remove_iova(iovad, iova))
+			free_iova_mem(iova);
+		else
+			llist_add(&iova->deferred_free,
+				  &iovad->deferred_frees);
+		spin_unlock_irqrestore(&iovad->iova_lock, flags);
+	}
+
+	if (!llist_empty(&iovad->deferred_frees))
+		schedule_delayed_work(&iovad->deferred_free_work,
+				      msecs_to_jiffies(10));
 }
 
 /**
@@ -199,9 +238,15 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
 	unsigned long flags;
 
 	spin_lock_irqsave(&iovad->iova_lock, flags);
-	remove_iova(iovad, iova);
+	if (remove_iova(iovad, iova)) {
+		spin_unlock_irqrestore(&iovad->iova_lock, flags);
+		free_iova_mem(iova);
+		return;
+	}
 	spin_unlock_irqrestore(&iovad->iova_lock, flags);
-	free_iova_mem(iova);
+	llist_add(&iova->deferred_free, &iovad->deferred_frees);
+	schedule_delayed_work(&iovad->deferred_free_work,
+			      msecs_to_jiffies(10));
 }
 EXPORT_SYMBOL_GPL(__free_iova);
 
@@ -224,9 +269,15 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 		spin_unlock_irqrestore(&iovad->iova_lock, flags);
 		return;
 	}
-	remove_iova(iovad, iova);
+	if (remove_iova(iovad, iova)) {
+		spin_unlock_irqrestore(&iovad->iova_lock, flags);
+		free_iova_mem(iova);
+		return;
+	}
 	spin_unlock_irqrestore(&iovad->iova_lock, flags);
-	free_iova_mem(iova);
+	llist_add(&iova->deferred_free, &iovad->deferred_frees);
+	schedule_delayed_work(&iovad->deferred_free_work,
+			      msecs_to_jiffies(10));
 }
 EXPORT_SYMBOL_GPL(free_iova);
 
@@ -318,6 +369,15 @@ void put_iova_domain(struct iova_domain *iovad)
 	if (iovad->rcaches)
 		iova_domain_free_rcaches(iovad);
 
+	cancel_delayed_work_sync(&iovad->deferred_free_work);
+
+	/*
+	 * Deferred entries are still in the maple tree, so the
+	 * mas_for_each loop below frees them along with everything else.
+	 * Just discard the deferred list without double-freeing.
+	 */
+	llist_del_all(&iovad->deferred_frees);
+
 	mas_for_each(&mas, iova, ULONG_MAX)
 		free_iova_mem(iova);
 	__mt_destroy(&iovad->mtree);
@@ -481,12 +541,20 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 		if (WARN_ON(!iova))
 			continue;
 
-		remove_iova(iovad, iova);
-		free_iova_mem(iova);
+		if (remove_iova(iovad, iova)) {
+			free_iova_mem(iova);
+		} else {
+			llist_add(&iova->deferred_free,
+				  &iovad->deferred_frees);
+		}
 	}
 
 	spin_unlock_irqrestore(&iovad->iova_lock, flags);
 
+	if (!llist_empty(&iovad->deferred_frees))
+		schedule_delayed_work(&iovad->deferred_free_work,
+				      msecs_to_jiffies(10));
+
 	mag->size = 0;
 }
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 6fc070a4f58e..cc1b5441a058 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -16,6 +16,7 @@
 
 /* iova structure */
 struct iova {
+	struct llist_node	deferred_free;
 	unsigned long	pfn_hi; /* Highest allocated pfn */
 	unsigned long	pfn_lo; /* Lowest allocated pfn */
 };
@@ -31,6 +32,8 @@ struct iova_domain {
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
+	struct llist_head deferred_frees;
+	struct delayed_work deferred_free_work;
 
 	struct iova_rcache	*rcaches;
 	struct hlist_node	cpuhp_dead;
-- 
2.54.0

