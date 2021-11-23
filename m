Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7FEC433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 14:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77A9860776;
	Tue, 23 Nov 2021 14:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nOXlVl92jExA; Tue, 23 Nov 2021 14:11:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFA4A60A43;
	Tue, 23 Nov 2021 14:11:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B773BC002E;
	Tue, 23 Nov 2021 14:11:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 085D7C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0342180E36
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fx_oEp7K5XiZ for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 14:11:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8C3680ED7
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:11:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C68C1063;
 Tue, 23 Nov 2021 06:11:05 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3250B3F66F;
 Tue, 23 Nov 2021 06:11:04 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 6/9] iommu/vt-d: Use put_pages_list
Date: Tue, 23 Nov 2021 14:10:41 +0000
Message-Id: <d8fe034fb10dc66bc20624fe9ffe9d7b338413b6.1637671820.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1637671820.git.robin.murphy@arm.com>
References: <cover.1637671820.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, willy@infradead.org,
 iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

page->freelist is for the use of slab.  We already have the ability
to free a list of pages in the core mm, but it requires the use of a
list_head and for the pages to be chained together through page->lru.
Switch the Intel IOMMU and IOVA code over to using free_pages_list().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[rm: split from original patch, cosmetic tweaks, fix fq entries]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c   |  2 +-
 drivers/iommu/intel/iommu.c | 89 +++++++++++++------------------------
 drivers/iommu/iova.c        | 26 ++++-------
 include/linux/iommu.h       |  3 +-
 include/linux/iova.h        |  4 +-
 5 files changed, 45 insertions(+), 79 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cde887530549..f139b77caee0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -455,7 +455,7 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	else if (gather && gather->queued)
 		queue_iova(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad),
-				gather->freelist);
+				&gather->freelist);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0bde0c8b4126..f65206dac485 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1303,35 +1303,30 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
    know the hardware page-walk will no longer touch them.
    The 'pte' argument is the *parent* PTE, pointing to the page that is to
    be freed. */
-static struct page *dma_pte_list_pagetables(struct dmar_domain *domain,
-					    int level, struct dma_pte *pte,
-					    struct page *freelist)
+static void dma_pte_list_pagetables(struct dmar_domain *domain,
+				    int level, struct dma_pte *pte,
+				    struct list_head *freelist)
 {
 	struct page *pg;
 
 	pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
-	pg->freelist = freelist;
-	freelist = pg;
+	list_add_tail(&pg->lru, freelist);
 
 	if (level == 1)
-		return freelist;
+		return;
 
 	pte = page_address(pg);
 	do {
 		if (dma_pte_present(pte) && !dma_pte_superpage(pte))
-			freelist = dma_pte_list_pagetables(domain, level - 1,
-							   pte, freelist);
+			dma_pte_list_pagetables(domain, level - 1, pte, freelist);
 		pte++;
 	} while (!first_pte_in_page(pte));
-
-	return freelist;
 }
 
-static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
-					struct dma_pte *pte, unsigned long pfn,
-					unsigned long start_pfn,
-					unsigned long last_pfn,
-					struct page *freelist)
+static void dma_pte_clear_level(struct dmar_domain *domain, int level,
+				struct dma_pte *pte, unsigned long pfn,
+				unsigned long start_pfn, unsigned long last_pfn,
+				struct list_head *freelist)
 {
 	struct dma_pte *first_pte = NULL, *last_pte = NULL;
 
@@ -1352,7 +1347,7 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
 			/* These suborbinate page tables are going away entirely. Don't
 			   bother to clear them; we're just going to *free* them. */
 			if (level > 1 && !dma_pte_superpage(pte))
-				freelist = dma_pte_list_pagetables(domain, level - 1, pte, freelist);
+				dma_pte_list_pagetables(domain, level - 1, pte, freelist);
 
 			dma_clear_pte(pte);
 			if (!first_pte)
@@ -1360,10 +1355,10 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
 			last_pte = pte;
 		} else if (level > 1) {
 			/* Recurse down into a level that isn't *entirely* obsolete */
-			freelist = dma_pte_clear_level(domain, level - 1,
-						       phys_to_virt(dma_pte_addr(pte)),
-						       level_pfn, start_pfn, last_pfn,
-						       freelist);
+			dma_pte_clear_level(domain, level - 1,
+					    phys_to_virt(dma_pte_addr(pte)),
+					    level_pfn, start_pfn, last_pfn,
+					    freelist);
 		}
 next:
 		pfn += level_size(level);
@@ -1372,47 +1367,28 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
 	if (first_pte)
 		domain_flush_cache(domain, first_pte,
 				   (void *)++last_pte - (void *)first_pte);
-
-	return freelist;
 }
 
 /* We can't just free the pages because the IOMMU may still be walking
    the page tables, and may have cached the intermediate levels. The
    pages can only be freed after the IOTLB flush has been done. */
-static struct page *domain_unmap(struct dmar_domain *domain,
-				 unsigned long start_pfn,
-				 unsigned long last_pfn,
-				 struct page *freelist)
+static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
+			 unsigned long last_pfn, struct list_head *freelist)
 {
 	BUG_ON(!domain_pfn_supported(domain, start_pfn));
 	BUG_ON(!domain_pfn_supported(domain, last_pfn));
 	BUG_ON(start_pfn > last_pfn);
 
 	/* we don't need lock here; nobody else touches the iova range */
-	freelist = dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-				       domain->pgd, 0, start_pfn, last_pfn,
-				       freelist);
+	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
+			    domain->pgd, 0, start_pfn, last_pfn, freelist);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
 		struct page *pgd_page = virt_to_page(domain->pgd);
-		pgd_page->freelist = freelist;
-		freelist = pgd_page;
-
+		list_add_tail(&pgd_page->lru, freelist);
 		domain->pgd = NULL;
 	}
-
-	return freelist;
-}
-
-static void dma_free_pagelist(struct page *freelist)
-{
-	struct page *pg;
-
-	while ((pg = freelist)) {
-		freelist = pg->freelist;
-		free_pgtable_page(page_address(pg));
-	}
 }
 
 /* iommu handling */
@@ -2097,11 +2073,10 @@ static void domain_exit(struct dmar_domain *domain)
 	domain_remove_dev_info(domain);
 
 	if (domain->pgd) {
-		struct page *freelist;
+		LIST_HEAD(freelist);
 
-		freelist = domain_unmap(domain, 0,
-					DOMAIN_MAX_PFN(domain->gaw), NULL);
-		dma_free_pagelist(freelist);
+		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
+		put_pages_list(&freelist);
 	}
 
 	free_domain_mem(domain);
@@ -4194,19 +4169,17 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 		{
 			struct dmar_drhd_unit *drhd;
 			struct intel_iommu *iommu;
-			struct page *freelist;
+			LIST_HEAD(freelist);
 
-			freelist = domain_unmap(si_domain,
-						start_vpfn, last_vpfn,
-						NULL);
+			domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);
 
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
 				iommu_flush_iotlb_psi(iommu, si_domain,
 					start_vpfn, mhp->nr_pages,
-					!freelist, 0);
+					list_empty(&freelist), 0);
 			rcu_read_unlock();
-			dma_free_pagelist(freelist);
+			put_pages_list(&freelist);
 		}
 		break;
 	}
@@ -5213,8 +5186,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	start_pfn = iova >> VTD_PAGE_SHIFT;
 	last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
 
-	gather->freelist = domain_unmap(dmar_domain, start_pfn,
-					last_pfn, gather->freelist);
+	domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist);
 
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
@@ -5250,9 +5222,10 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 
 	for_each_domain_iommu(iommu_id, dmar_domain)
 		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
-				      start_pfn, nrpages, !gather->freelist, 0);
+				      start_pfn, nrpages,
+				      list_empty(&gather->freelist), 0);
 
-	dma_free_pagelist(gather->freelist);
+	put_pages_list(&gather->freelist);
 }
 
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 7619ccb726cc..a32007c950e5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -97,7 +97,7 @@ static void free_iova_flush_queue(struct iova_domain *iovad)
 int init_iova_flush_queue(struct iova_domain *iovad, struct iommu_domain *fq_domain)
 {
 	struct iova_fq __percpu *queue;
-	int cpu;
+	int i, cpu;
 
 	atomic64_set(&iovad->fq_flush_start_cnt,  0);
 	atomic64_set(&iovad->fq_flush_finish_cnt, 0);
@@ -114,6 +114,9 @@ int init_iova_flush_queue(struct iova_domain *iovad, struct iommu_domain *fq_dom
 		fq->tail = 0;
 
 		spin_lock_init(&fq->lock);
+
+		for (i = 0; i < IOVA_FQ_SIZE; i++)
+			INIT_LIST_HEAD(&fq->entries[i].freelist);
 	}
 
 	iovad->fq_domain = fq_domain;
@@ -535,16 +538,6 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(free_iova_fast);
 
-static void fq_entry_dtor(struct page *freelist)
-{
-	while (freelist) {
-		unsigned long p = (unsigned long)page_address(freelist);
-
-		freelist = freelist->freelist;
-		free_page(p);
-	}
-}
-
 #define fq_ring_for_each(i, fq) \
 	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
 
@@ -577,7 +570,7 @@ static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
 		if (fq->entries[idx].counter >= counter)
 			break;
 
-		fq_entry_dtor(fq->entries[idx].freelist);
+		put_pages_list(&fq->entries[idx].freelist);
 		free_iova_fast(iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
@@ -599,15 +592,14 @@ static void fq_destroy_all_entries(struct iova_domain *iovad)
 
 	/*
 	 * This code runs when the iova_domain is being detroyed, so don't
-	 * bother to free iovas, just call the entry_dtor on all remaining
-	 * entries.
+	 * bother to free iovas, just free any remaining pagetable pages.
 	 */
 	for_each_possible_cpu(cpu) {
 		struct iova_fq *fq = per_cpu_ptr(iovad->fq, cpu);
 		int idx;
 
 		fq_ring_for_each(idx, fq)
-			fq_entry_dtor(fq->entries[idx].freelist);
+			put_pages_list(&fq->entries[idx].freelist);
 	}
 }
 
@@ -632,7 +624,7 @@ static void fq_flush_timeout(struct timer_list *t)
 
 void queue_iova(struct iova_domain *iovad,
 		unsigned long pfn, unsigned long pages,
-		struct page *freelist)
+		struct list_head *freelist)
 {
 	struct iova_fq *fq;
 	unsigned long flags;
@@ -666,8 +658,8 @@ void queue_iova(struct iova_domain *iovad,
 
 	fq->entries[idx].iova_pfn = pfn;
 	fq->entries[idx].pages    = pages;
-	fq->entries[idx].freelist = freelist;
 	fq->entries[idx].counter  = atomic64_read(&iovad->fq_flush_start_cnt);
+	list_splice(freelist, &fq->entries[idx].freelist);
 
 	spin_unlock_irqrestore(&fq->lock, flags);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d2f3435e7d17..de0c57a567c8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -186,7 +186,7 @@ struct iommu_iotlb_gather {
 	unsigned long		start;
 	unsigned long		end;
 	size_t			pgsize;
-	struct page		*freelist;
+	struct list_head	freelist;
 	bool			queued;
 };
 
@@ -399,6 +399,7 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 {
 	*gather = (struct iommu_iotlb_gather) {
 		.start	= ULONG_MAX,
+		.freelist = LIST_HEAD_INIT(gather->freelist),
 	};
 }
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 99be4fcea4f3..072a09c06e8a 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -46,7 +46,7 @@ struct iova_rcache {
 struct iova_fq_entry {
 	unsigned long iova_pfn;
 	unsigned long pages;
-	struct page *freelist;
+	struct list_head freelist;
 	u64 counter; /* Flush counter when this entrie was added */
 };
 
@@ -135,7 +135,7 @@ void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
 		    unsigned long size);
 void queue_iova(struct iova_domain *iovad,
 		unsigned long pfn, unsigned long pages,
-		struct page *freelist);
+		struct list_head *freelist);
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 			      unsigned long limit_pfn, bool flush_rcache);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
