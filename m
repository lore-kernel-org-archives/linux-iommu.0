From: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH v9 13/13] xpfo,
	mm: Optimize XPFO TLB flushes by batching them together
Date: Wed,  3 Apr 2019 11:34:14 -0600
Message-ID: <be3868d4514e969f22d37d76a591683be9f6b3ee.1554248002.git.khalid.aziz@oracle.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1554248001.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <cover.1554248001.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
References: <cover.1554248001.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: juergh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tycho-E0fblnxP3wo@public.gmane.org, jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, liran.alon-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org, rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, chris.hyser-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>, aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org, james.morse@ar
List-Id: iommu@lists.linux-foundation.org

When XPFO forces a TLB flush on all cores, the performance impact is
very significant. Batching as many of these TLB updates as
possible can help lower this impact. When a userspace allocates a
page, kernel tries to get that page from the per-cpu free list.
This free list is replenished in bulk when it runs low. Free
list is being replenished for future allocation to userspace is a
good opportunity to update TLB entries in batch and reduce the
impact of multiple TLB flushes later. This patch adds new tags for
the page so a page can be marked as available for userspace
allocation and unmapped from kernel address space. All such pages
are removed from kernel address space in bulk at the time they are
added to per-cpu free list. This patch when combined with deferred
TLB flushes improves performance further. Using the same benchmark
as before of building kernel in parallel, here are the system
times on two differently sized systems:

Hardware: 96-core Intel Xeon Platinum 8160 CPU @ 2.10GHz, 768 GB RAM
make -j60 all

5.0					913.862s
5.0+XPFO+Deferred flush+Batch update	1165.259s	1.28x

Hardware: 4-core Intel Core i5-3550 CPU @ 3.30GHz, 8G RAM
make -j4 all

5.0					610.642s
5.0+XPFO+Deferred flush+Batch update	773.075s	1.27x

Signed-off-by: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>
Signed-off-by: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>
---
v9:
	- Do not map a page freed by userspace back into kernel. Mark
	 it as unmapped instead and map it back in only when needed. This
	 avoids the cost of unmap and TLBV flush if the page is allocated
	 back to userspace.

 arch/x86/include/asm/pgtable.h |  2 +-
 arch/x86/mm/pageattr.c         |  9 ++++--
 arch/x86/mm/xpfo.c             | 11 +++++--
 include/linux/xpfo.h           | 11 +++++++
 mm/page_alloc.c                |  9 ++++++
 mm/xpfo.c                      | 54 +++++++++++++++++++++++++++-------
 6 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5c0e1581fa56..61f64c6c687c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1461,7 +1461,7 @@ should_split_large_page(pte_t *kpte, unsigned long address,
 extern spinlock_t cpa_lock;
 int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
-		   struct page *base);
+		   struct page *base, bool xpfo_split);
 
 #include <asm-generic/pgtable.h>
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 530b5df0617e..8fe86ac6bff0 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -911,7 +911,7 @@ static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 
 int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
-		   struct page *base)
+		   struct page *base, bool xpfo_split)
 {
 	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc = 1;
 	pte_t *pbase = (pte_t *)page_address(base);
@@ -1008,7 +1008,10 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 * page attribute in parallel, that also falls into the
 	 * just split large page entry.
 	 */
-	flush_tlb_all();
+	if (xpfo_split)
+		xpfo_flush_tlb_all();
+	else
+		flush_tlb_all();
 	spin_unlock(&pgd_lock);
 
 	return 0;
@@ -1027,7 +1030,7 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 	if (!base)
 		return -ENOMEM;
 
-	if (__split_large_page(cpa, kpte, address, base))
+	if (__split_large_page(cpa, kpte, address, base, false))
 		__free_page(base);
 
 	return 0;
diff --git a/arch/x86/mm/xpfo.c b/arch/x86/mm/xpfo.c
index 638eee5b1f09..8c482c7b54f5 100644
--- a/arch/x86/mm/xpfo.c
+++ b/arch/x86/mm/xpfo.c
@@ -47,7 +47,7 @@ inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
 
 		cpa.vaddr = kaddr;
 		cpa.pages = &page;
-		cpa.mask_set = prot;
+		cpa.mask_set = canon_pgprot(prot);
 		cpa.mask_clr = msk_clr;
 		cpa.numpages = 1;
 		cpa.flags = 0;
@@ -57,7 +57,7 @@ inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
 
 		do_split = should_split_large_page(pte, (unsigned long)kaddr,
 						   &cpa);
-		if (do_split) {
+		if (do_split > 0) {
 			struct page *base;
 
 			base = alloc_pages(GFP_ATOMIC, 0);
@@ -69,7 +69,7 @@ inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
 			if (!debug_pagealloc_enabled())
 				spin_lock(&cpa_lock);
 			if  (__split_large_page(&cpa, pte, (unsigned long)kaddr,
-						base) < 0) {
+						base, true) < 0) {
 				__free_page(base);
 				WARN(1, "xpfo: failed to split large page\n");
 			}
@@ -90,6 +90,11 @@ inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
 }
 EXPORT_SYMBOL_GPL(set_kpte);
 
+void xpfo_flush_tlb_all(void)
+{
+	xpfo_flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
+}
+
 inline void xpfo_flush_kernel_tlb(struct page *page, int order)
 {
 	int level;
diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
index 37e7f52fa6ce..01da4bb31cd6 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -32,6 +32,7 @@ DECLARE_STATIC_KEY_TRUE(xpfo_inited);
 /* Architecture specific implementations */
 void set_kpte(void *kaddr, struct page *page, pgprot_t prot);
 void xpfo_flush_kernel_tlb(struct page *page, int order);
+void xpfo_flush_tlb_all(void);
 
 void xpfo_init_single_page(struct page *page);
 
@@ -106,6 +107,9 @@ void xpfo_temp_map(const void *addr, size_t size, void **mapping,
 void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
 		     size_t mapping_len);
 
+bool xpfo_pcp_refill(struct page *page, enum migratetype migratetype,
+		     int order);
+
 #else /* !CONFIG_XPFO */
 
 static inline void xpfo_init_single_page(struct page *page) { }
@@ -118,6 +122,7 @@ static inline void xpfo_free_pages(struct page *page, int order) { }
 
 static inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot) { }
 static inline void xpfo_flush_kernel_tlb(struct page *page, int order) { }
+static inline void xpfo_flush_tlb_all(void) { }
 
 static inline phys_addr_t user_virt_to_phys(unsigned long addr) { return 0; }
 
@@ -133,6 +138,12 @@ static inline void xpfo_temp_unmap(const void *addr, size_t size,
 {
 }
 
+static inline bool xpfo_pcp_refill(struct page *page,
+				   enum migratetype migratetype, int order)
+{
+	return false;
+}
+
 #endif /* CONFIG_XPFO */
 
 #if (!defined(CONFIG_HIGHMEM)) && (!defined(ARCH_HAS_KMAP))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e0dda1322a2..7846b2590ef0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3031,6 +3031,8 @@ static struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
 			struct list_head *list)
 {
 	struct page *page;
+	struct list_head *cur;
+	bool flush_tlb = false;
 
 	do {
 		if (list_empty(list)) {
@@ -3039,6 +3041,13 @@ static struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
 					migratetype, alloc_flags);
 			if (unlikely(list_empty(list)))
 				return NULL;
+			list_for_each(cur, list) {
+				page = list_entry(cur, struct page, lru);
+				flush_tlb |= xpfo_pcp_refill(page,
+							     migratetype, 0);
+			}
+			if (flush_tlb)
+				xpfo_flush_tlb_all();
 		}
 
 		page = list_first_entry(list, struct page, lru);
diff --git a/mm/xpfo.c b/mm/xpfo.c
index 974f1b70ccd9..47d400f1fc65 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -62,17 +62,22 @@ void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp, bool will_map)
 		WARN_ON(atomic_read(&(page + i)->xpfo_mapcount));
 #endif
 		if ((gfp & GFP_HIGHUSER) == GFP_HIGHUSER) {
+			bool user_page = TestSetPageXpfoUser(page + i);
+
 			/*
 			 * Tag the page as a user page and flush the TLB if it
 			 * was previously allocated to the kernel.
 			 */
-			if ((!TestSetPageXpfoUser(page + i)) || !will_map) {
-				SetPageXpfoUnmapped(page + i);
-				flush_tlb = true;
+			if (!user_page || !will_map) {
+				if (!TestSetPageXpfoUnmapped(page + i))
+					flush_tlb = true;
 			}
 		} else {
 			/* Tag the page as a non-user (kernel) page */
 			ClearPageXpfoUser(page + i);
+			if (TestClearPageXpfoUnmapped(page + i))
+				set_kpte(page_address(page + i), page + i,
+					 PAGE_KERNEL);
 		}
 	}
 
@@ -95,14 +100,12 @@ void xpfo_free_pages(struct page *page, int order)
 #endif
 
 		/*
-		 * Map the page back into the kernel if it was previously
-		 * allocated to user space.
+		 * Leave the page as unmapped from kernel. If this page
+		 * gets allocated to userspace soon again, it saves us
+		 * the cost of TLB flush at that time.
 		 */
-		if (TestClearPageXpfoUser(page + i)) {
-			ClearPageXpfoUnmapped(page + i);
-			set_kpte(page_address(page + i), page + i,
-				 PAGE_KERNEL);
-		}
+		if (PageXpfoUser(page + i))
+			SetPageXpfoUnmapped(page + i);
 	}
 }
 
@@ -134,3 +137,34 @@ void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
 			kunmap_atomic(mapping[i]);
 }
 EXPORT_SYMBOL(xpfo_temp_unmap);
+
+bool xpfo_pcp_refill(struct page *page, enum migratetype migratetype,
+		     int order)
+{
+	int i;
+	bool flush_tlb = false;
+
+	if (!static_branch_unlikely(&xpfo_inited))
+		return false;
+
+	for (i = 0; i < 1 << order; i++) {
+		if (migratetype == MIGRATE_MOVABLE) {
+			/* GPF_HIGHUSER **
+			 * Tag the page as a user page, mark it as unmapped
+			 * in kernel space and flush the TLB if it was
+			 * previously allocated to the kernel.
+			 */
+			SetPageXpfoUser(page + i);
+			if (!TestSetPageXpfoUnmapped(page + i))
+				flush_tlb = true;
+		} else {
+			/* Tag the page as a non-user (kernel) page */
+			ClearPageXpfoUser(page + i);
+		}
+	}
+
+	if (flush_tlb)
+		set_kpte(page_address(page), page, __pgprot(0));
+
+	return flush_tlb;
+}
-- 
2.17.1
