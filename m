From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [RFC PATCH] iommu/vt-d: Clean up and fix page table clear/free
	behaviour
Date: Thu, 06 Mar 2014 16:57:23 +0000
Message-ID: <1394125043.9994.13.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6544416403836086438=="
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
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: cantuc-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============6544416403836086438==
Content-Type: multipart/signed; micalg="sha-1"; protocol="application/x-pkcs7-signature";
	boundary="=-v947l+1q7k0MadWUY/b0"


--=-v947l+1q7k0MadWUY/b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is a race condition between the existing clear/free code and the
hardware. The IOMMU is actually permitted to cache the intermediate
levels of the page tables, and doesn't need to walk the table from the
very top of the PGD each time. So the existing back-to-back calls to
dma_pte_clear_range() and dma_pte_free_pagetable() can lead to a
use-after-free where the IOMMU reads from a freed page table.

When freeing page tables we need to do things in the following order:
 - First unlink the pages from the higher-level page tables.
 - Then flush the IOTLB (with the 'invalidation hint' bit clear).
 - Finally, free the page table pages which are no longer in use.

So in the rewritten domain_unmap() we just return a list of pages (using
pg->freelist to make a list of them), and then the caller is expected to
do the appropriate IOTLB flush (or tear down the domain completely,
whatever), before finally calling dma_free_pagelist() to free the pages.

As an added bonus, we no longer need to flush the CPU's data cache for
pages which are about to be *removed* from the page table hierarchy anyway,
in the non-cache-coherent case. This drastically improves the performance
of large unmaps.

As a side-effect of all these changes, this also fixes the fact that
intel_iommu_unmap() was neglecting to free the page tables for the range
in question after clearing them.

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
Potential issues:
 - Is it OK to use page->freelist like this?

 - I've made intel_iommu_unmap() unmap and return the size it was asked
   to unmap, and assume that it *won't* be asked to do "partial" unmaps,
   unmapping a smaller size than was originally requested with the
   corresponding map() call. So it's assuming it'll never be asked to
   break superpages apart.

   The existing API is that *if* it's asked to break superpages apart,
   it will just unmap the whole superpage and return a 'size' result
   indicating that it's done so. Does anything really *use* that
   insanity?

 drivers/iommu/intel-iommu.c | 234 +++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 188 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 484d669..6740942 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2006, Intel Corporation.
+ * Copyright =C2=A9 2006-2014 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -10,15 +10,11 @@
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
  * more details.
  *
- * You should have received a copy of the GNU General Public License along=
 with
- * this program; if not, write to the Free Software Foundation, Inc., 59 T=
emple
- * Place - Suite 330, Boston, MA 02111-1307 USA.
- *
- * Copyright (C) 2006-2008 Intel Corporation
- * Author: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
- * Author: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
- * Author: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
- * Author: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ * Authors: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
+ *          Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
+ *          Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
+ *          Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
+ *          Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
  */
=20
 #include <linux/init.h>
@@ -413,6 +409,7 @@ struct deferred_flush_tables {
 	int next;
 	struct iova *iova[HIGH_WATER_MARK];
 	struct dmar_domain *domain[HIGH_WATER_MARK];
+	struct page *freelist[HIGH_WATER_MARK];
 };
=20
 static struct deferred_flush_tables *deferred_flush;
@@ -957,6 +954,123 @@ static void dma_pte_free_pagetable(struct dmar_domain=
 *domain,
 	}
 }
=20
+/* When a page at a given level is being unlinked from its parent, we don'=
t
+   need to *modify* it at all. All we need to do is make a list of all the
+   pages which can be freed just as soon as we've flushed the IOTLB and we
+   know the hardware page-walk will no longer touch them.
+   The 'pte' argument is the *parent* PTE, pointing to the page that is to
+   be freed. */
+static struct page *dma_pte_list_pagetables(struct dmar_domain *domain,
+					    int level, struct dma_pte *pte,
+					    struct page *freelist)
+{
+	struct page *pg;
+
+	pg =3D pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
+	pg->freelist =3D freelist;
+	freelist =3D pg;
+
+	if (level =3D=3D 1)
+		return freelist;
+
+	for (pte =3D page_address(pg); !first_pte_in_page(pte); pte++) {
+		if (dma_pte_present(pte) && !dma_pte_superpage(pte))
+			freelist =3D dma_pte_list_pagetables(domain, level - 1,
+							   pte, freelist);
+	}
+
+	return freelist;
+}
+
+static struct page *dma_pte_clear_level(struct dmar_domain *domain, int le=
vel,
+					struct dma_pte *pte, unsigned long pfn,
+					unsigned long start_pfn,
+					unsigned long last_pfn,
+					struct page *freelist)
+{
+	struct dma_pte *first_pte =3D NULL, *last_pte =3D NULL;
+
+	pfn =3D max(start_pfn, pfn);
+	pte =3D &pte[pfn_level_offset(pfn, level)];
+
+	do {
+		unsigned long level_pfn;
+
+		if (!dma_pte_present(pte))
+			goto next;
+
+		level_pfn =3D pfn & level_mask(level);
+
+		/* If range covers entire pagetable, free it */
+		if (start_pfn <=3D level_pfn &&
+		    last_pfn >=3D level_pfn + level_size(level) - 1) {
+			/* These suborbinate page tables are going away entirely. Don't
+			   bother to clear them; we're just going to *free* them. */
+			if (level > 1 && !dma_pte_superpage(pte))
+				freelist =3D dma_pte_list_pagetables(domain, level - 1, pte, freelist)=
;
+
+			dma_clear_pte(pte);
+			if (!first_pte)
+				first_pte =3D pte;
+			last_pte =3D pte;
+		} else if (level > 1) {
+			/* Recurse down into a level that isn't *entirely* obsolete */
+			freelist =3D dma_pte_clear_level(domain, level - 1,
+						       phys_to_virt(dma_pte_addr(pte)),
+						       level_pfn, start_pfn, last_pfn,
+						       freelist);
+		}
+next:
+		pfn +=3D level_size(level);
+	} while (!first_pte_in_page(++pte) && pfn <=3D last_pfn);
+
+	if (first_pte)
+		domain_flush_cache(domain, first_pte,
+				   (void *)++last_pte - (void *)first_pte);
+
+	return freelist;
+}
+
+/* We can't just free the pages because the IOMMU may still be walking
+   the page tables, and may have cached the intermediate levels. The
+   pages can only be freed after the IOTLB flush has been done. */
+struct page *domain_unmap(struct dmar_domain *domain,
+			  unsigned long start_pfn,
+			  unsigned long last_pfn)
+{
+	int addr_width =3D agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
+	struct page *freelist =3D NULL;
+
+	BUG_ON(addr_width < BITS_PER_LONG && start_pfn >> addr_width);
+	BUG_ON(addr_width < BITS_PER_LONG && last_pfn >> addr_width);
+	BUG_ON(start_pfn > last_pfn);
+
+	/* we don't need lock here; nobody else touches the iova range */
+	freelist =3D dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
+				       domain->pgd, 0, start_pfn, last_pfn, NULL);
+
+	/* free pgd */
+	if (start_pfn =3D=3D 0 && last_pfn =3D=3D DOMAIN_MAX_PFN(domain->gaw)) {
+		struct page *pgd_page =3D virt_to_page(domain->pgd);
+		pgd_page->freelist =3D freelist;
+		freelist =3D pgd_page;
+
+		domain->pgd =3D NULL;
+	}
+
+	return freelist;
+}
+
+void dma_free_pagelist(struct page *freelist)
+{
+	struct page *pg;
+
+	while ((pg =3D freelist)) {
+		freelist =3D pg->freelist;
+		free_pgtable_page(page_address(pg));
+	}
+}
+
 /* iommu handling */
 static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 {
@@ -1066,7 +1180,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *i=
ommu, u16 did,
 		break;
 	case DMA_TLB_PSI_FLUSH:
 		val =3D DMA_TLB_PSI_FLUSH|DMA_TLB_IVT|DMA_TLB_DID(did);
-		/* Note: always flush non-leaf currently */
+		/* IH bit is passed in as part of address */
 		val_iva =3D size_order | addr;
 		break;
 	default:
@@ -1177,13 +1291,15 @@ static void iommu_flush_dev_iotlb(struct dmar_domai=
n *domain,
 }
=20
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu, u16 did,
-				  unsigned long pfn, unsigned int pages, int map)
+				  unsigned long pfn, unsigned int pages, int ih, int map)
 {
 	unsigned int mask =3D ilog2(__roundup_pow_of_two(pages));
 	uint64_t addr =3D (uint64_t)pfn << VTD_PAGE_SHIFT;
=20
 	BUG_ON(pages =3D=3D 0);
=20
+	if (ih)
+		ih =3D 1 << 6;
 	/*
 	 * Fallback to domain selective flush if no PSI support or the size is
 	 * too big.
@@ -1194,7 +1310,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu =
*iommu, u16 did,
 		iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						DMA_TLB_DSI_FLUSH);
 	else
-		iommu->flush.flush_iotlb(iommu, did, addr, mask,
+		iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
 						DMA_TLB_PSI_FLUSH);
=20
 	/*
@@ -1519,6 +1635,7 @@ static void domain_exit(struct dmar_domain *domain)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
+	struct page *freelist =3D NULL;
=20
 	/* Domain 0 is reserved, so dont process it */
 	if (!domain)
@@ -1534,11 +1651,7 @@ static void domain_exit(struct dmar_domain *domain)
 	/* destroy iovas */
 	put_iova_domain(&domain->iovad);
=20
-	/* clear ptes */
-	dma_pte_clear_range(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
-
-	/* free page tables */
-	dma_pte_free_pagetable(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
+	freelist =3D domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
=20
 	/* clear attached or cached domains */
 	rcu_read_lock();
@@ -1548,6 +1661,8 @@ static void domain_exit(struct dmar_domain *domain)
 			iommu_detach_domain(domain, iommu);
 	rcu_read_unlock();
=20
+	dma_free_pagelist(freelist);
+
 	free_domain_mem(domain);
 }
=20
@@ -2847,7 +2962,7 @@ static dma_addr_t __intel_map_single(struct device *h=
wdev, phys_addr_t paddr,
=20
 	/* it's a non-present to present mapping. Only flush if caching mode */
 	if (cap_caching_mode(iommu->cap))
-		iommu_flush_iotlb_psi(iommu, domain->id, mm_to_dma_pfn(iova->pfn_lo), si=
ze, 1);
+		iommu_flush_iotlb_psi(iommu, domain->id, mm_to_dma_pfn(iova->pfn_lo), si=
ze, 0, 1);
 	else
 		iommu_flush_write_buffer(iommu);
=20
@@ -2899,13 +3014,16 @@ static void flush_unmaps(void)
 			/* On real hardware multiple invalidations are expensive */
 			if (cap_caching_mode(iommu->cap))
 				iommu_flush_iotlb_psi(iommu, domain->id,
-				iova->pfn_lo, iova->pfn_hi - iova->pfn_lo + 1, 0);
+					iova->pfn_lo, iova->pfn_hi - iova->pfn_lo + 1,
+					!deferred_flush[i].freelist[j], 0);
 			else {
 				mask =3D ilog2(mm_to_dma_pfn(iova->pfn_hi - iova->pfn_lo + 1));
 				iommu_flush_dev_iotlb(deferred_flush[i].domain[j],
 						(uint64_t)iova->pfn_lo << PAGE_SHIFT, mask);
 			}
 			__free_iova(&deferred_flush[i].domain[j]->iovad, iova);
+			if (deferred_flush[i].freelist[j])
+				dma_free_pagelist(deferred_flush[i].freelist[j]);
 		}
 		deferred_flush[i].next =3D 0;
 	}
@@ -2922,7 +3040,7 @@ static void flush_unmaps_timeout(unsigned long data)
 	spin_unlock_irqrestore(&async_umap_flush_lock, flags);
 }
=20
-static void add_unmap(struct dmar_domain *dom, struct iova *iova)
+static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct p=
age *freelist)
 {
 	unsigned long flags;
 	int next, iommu_id;
@@ -2938,6 +3056,7 @@ static void add_unmap(struct dmar_domain *dom, struct=
 iova *iova)
 	next =3D deferred_flush[iommu_id].next;
 	deferred_flush[iommu_id].domain[next] =3D dom;
 	deferred_flush[iommu_id].iova[next] =3D iova;
+	deferred_flush[iommu_id].freelist[next] =3D freelist;
 	deferred_flush[iommu_id].next++;
=20
 	if (!timer_on) {
@@ -2957,6 +3076,7 @@ static void intel_unmap_page(struct device *dev, dma_=
addr_t dev_addr,
 	unsigned long start_pfn, last_pfn;
 	struct iova *iova;
 	struct intel_iommu *iommu;
+	struct page *freelist;
=20
 	if (iommu_no_mapping(dev))
 		return;
@@ -2977,19 +3097,16 @@ static void intel_unmap_page(struct device *dev, dm=
a_addr_t dev_addr,
 	pr_debug("Device %s unmapping: pfn %lx-%lx\n",
 		 pci_name(pdev), start_pfn, last_pfn);
=20
-	/*  clear the whole page */
-	dma_pte_clear_range(domain, start_pfn, last_pfn);
-
-	/* free page tables */
-	dma_pte_free_pagetable(domain, start_pfn, last_pfn);
+	freelist =3D domain_unmap(domain, start_pfn, last_pfn);
=20
 	if (intel_iommu_strict) {
 		iommu_flush_iotlb_psi(iommu, domain->id, start_pfn,
-				      last_pfn - start_pfn + 1, 0);
+				      last_pfn - start_pfn + 1, !freelist, 0);
 		/* free iova */
 		__free_iova(&domain->iovad, iova);
+		dma_free_pagelist(freelist);
 	} else {
-		add_unmap(domain, iova);
+		add_unmap(domain, iova, freelist);
 		/*
 		 * queue up the release of the unmap to save the 1/6th of the
 		 * cpu used up by the iotlb flush operation...
@@ -3051,6 +3168,7 @@ static void intel_unmap_sg(struct device *hwdev, stru=
ct scatterlist *sglist,
 	unsigned long start_pfn, last_pfn;
 	struct iova *iova;
 	struct intel_iommu *iommu;
+	struct page *freelist;
=20
 	if (iommu_no_mapping(hwdev))
 		return;
@@ -3068,19 +3186,16 @@ static void intel_unmap_sg(struct device *hwdev, st=
ruct scatterlist *sglist,
 	start_pfn =3D mm_to_dma_pfn(iova->pfn_lo);
 	last_pfn =3D mm_to_dma_pfn(iova->pfn_hi + 1) - 1;
=20
-	/*  clear the whole page */
-	dma_pte_clear_range(domain, start_pfn, last_pfn);
-
-	/* free page tables */
-	dma_pte_free_pagetable(domain, start_pfn, last_pfn);
+	freelist =3D domain_unmap(domain, start_pfn, last_pfn);
=20
 	if (intel_iommu_strict) {
 		iommu_flush_iotlb_psi(iommu, domain->id, start_pfn,
-				      last_pfn - start_pfn + 1, 0);
+				      last_pfn - start_pfn + 1, !freelist, 0);
 		/* free iova */
 		__free_iova(&domain->iovad, iova);
+		dma_free_pagelist(freelist);
 	} else {
-		add_unmap(domain, iova);
+		add_unmap(domain, iova, freelist);
 		/*
 		 * queue up the release of the unmap to save the 1/6th of the
 		 * cpu used up by the iotlb flush operation...
@@ -3163,7 +3278,7 @@ static int intel_map_sg(struct device *hwdev, struct =
scatterlist *sglist, int ne
=20
 	/* it's a non-present to present mapping. Only flush if caching mode */
 	if (cap_caching_mode(iommu->cap))
-		iommu_flush_iotlb_psi(iommu, domain->id, start_vpfn, size, 1);
+		iommu_flush_iotlb_psi(iommu, domain->id, start_vpfn, size, 0, 1);
 	else
 		iommu_flush_write_buffer(iommu);
=20
@@ -3710,6 +3825,7 @@ static int intel_iommu_memory_notifier(struct notifie=
r_block *nb,
 			struct iova *iova;
 			struct dmar_drhd_unit *drhd;
 			struct intel_iommu *iommu;
+			struct page *freelist;
=20
 			iova =3D find_iova(&si_domain->iovad, start_vpfn);
 			if (iova =3D=3D NULL) {
@@ -3726,16 +3842,17 @@ static int intel_iommu_memory_notifier(struct notif=
ier_block *nb,
 				return NOTIFY_BAD;
 			}
=20
+			freelist =3D domain_unmap(si_domain, iova->pfn_lo,
+					       iova->pfn_hi);
+
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
 				iommu_flush_iotlb_psi(iommu, si_domain->id,
 					iova->pfn_lo,
-					iova->pfn_hi - iova->pfn_lo + 1, 0);
+					iova->pfn_hi - iova->pfn_lo + 1,
+					!freelist, 0);
 			rcu_read_unlock();
-			dma_pte_clear_range(si_domain, iova->pfn_lo,
-					    iova->pfn_hi);
-			dma_pte_free_pagetable(si_domain, iova->pfn_lo,
-					       iova->pfn_hi);
+			dma_free_pagelist(freelist);
=20
 			start_vpfn =3D iova->pfn_hi + 1;
 			free_iova_mem(iova);
@@ -4096,18 +4213,43 @@ static int intel_iommu_map(struct iommu_domain *dom=
ain,
 }
=20
 static size_t intel_iommu_unmap(struct iommu_domain *domain,
-			     unsigned long iova, size_t size)
+				unsigned long iova, size_t size)
 {
 	struct dmar_domain *dmar_domain =3D domain->priv;
-	int order;
+	struct page *freelist =3D NULL;
+	struct intel_iommu *iommu;
+	unsigned long start_pfn, last_pfn;
+	unsigned int npages;
+	int iommu_id, num, ndomains;
+
+	start_pfn =3D iova >> VTD_PAGE_SHIFT;
+	last_pfn =3D (iova + size - 1) >> VTD_PAGE_SHIFT;
+
+	freelist =3D domain_unmap(dmar_domain, start_pfn, last_pfn);
+
+	npages =3D last_pfn - start_pfn + 1;
+
+	for_each_set_bit(iommu_id, dmar_domain->iommu_bmp, g_num_of_iommus) {
+               iommu =3D g_iommus[iommu_id];
+
+               /*
+                * find bit position of dmar_domain
+                */
+               ndomains =3D cap_ndoms(iommu->cap);
+               for_each_set_bit(num, iommu->domain_ids, ndomains) {
+                       if (iommu->domains[num] =3D=3D dmar_domain)
+                               iommu_flush_iotlb_psi(iommu, num, start_pfn=
,
+						     npages, !freelist, 0);
+	       }
+
+	}
=20
-	order =3D dma_pte_clear_range(dmar_domain, iova >> VTD_PAGE_SHIFT,
-			    (iova + size - 1) >> VTD_PAGE_SHIFT);
+	dma_free_pagelist(freelist);
=20
 	if (dmar_domain->max_addr =3D=3D iova + size)
 		dmar_domain->max_addr =3D iova;
=20
-	return PAGE_SIZE << order;
+	return size;
 }
=20
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
--=20
1.8.5.3


--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporation

--=-v947l+1q7k0MadWUY/b0
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISxDCCBjQw
ggQcoAMCAQICAR4wDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxKTAn
BgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3MTAyNDIxMDE1NVoX
DTE3MTAyNDIxMDE1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSsw
KQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFy
dENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMcJg8zOLdgasSmkLhOrlr6KMoOMpohBllVHrdRvEg/q6r8jR+EK
75xCGhR8ToREoqe7zM9/UnC6TS2y9UKTpT1v7RSMzR0t6ndl0TWBuUr/UXBhPk+Kmy7bI4yW4urC
+y7P3/1/X7U8ocb8VpH/Clt+4iq7nirMcNh6qJR+xjOhV+VHzQMALuGYn5KZmc1NbJQYclsGkDxD
z2UbFqE2+6vIZoL+jb9x4Pa5gNf1TwSDkOkikZB1xtB4ZqtXThaABSONdfmv/Z1pua3FYxnCFmdr
/+N2JLKutIxMYqQOJebr/f/h5t95m4JgrM3Y/w7YX9d7YAL9jvN4SydHsU6n65cCAwEAAaOCAa0w
ggGpMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRTcu2SnODaywFc
fH6WNU7y1LhRgjAfBgNVHSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRa
MFgwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYh
aHR0cDovL3d3dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5j
b20vc2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBAAqDCH14qywG
XLhjjF6uHLkjd02hcdh9hrw+VUsv+q1eeQWB21jWj3kJ96AUlPCoEGZ/ynJNScWy6QMVQjbbMXlt
UfO4n4bGGdKo3awPWp61tjAFgraLJgDk+DsSvUD6EowjMTNx25GQgyYJ5RPIzKKR9tQW8gGK+2+R
HxkUCTbYFnL6kl8Ch507rUdPPipJ9CgJFws3kDS3gOS5WFMxcjO5DwKfKSETEPrHh7p5shuuNktv
sv6hxHTLhiMKX893gxdT3XLS9OKmCv87vkINQcNEcIIoFWbP9HORz9v3vQwR4e3ksLc2JZOAFK+s
sS5XMEoznzpihEP0PLc4dCBYjbvSD7kxgDwZ+Aj8Q9PkbvE9sIPP7ON0fz095HdThKjiVJe6vofq
+n6b1NBc8XdrQvBmunwxD5nvtTW4vtN6VY7mUCmxsCieuoBJ9OlqmsVWQvifIYf40dJPZkk9YgGT
zWLpXDSfLSplbY2LL9C9U0ptvjcDjefLTvqSFc7tw1sEhF0n/qpA2r0GpvkLRDmcSwVyPvmjFBGq
Up/pNy8ZuPGQmHwFi2/14+xeSUDG2bwnsYJQG2EdJCB6luQ57GEnTA/yKZSTKI8dDQa8Sd3zfXb1
9mOgSF0bBdXbuKhEpuP9wirslFe6fQ1t5j5R0xi72MZ8ikMu1RQZKCyDbMwazlHiMIIGQjCCBSqg
AwIBAgIDBoXOMA0GCSqGSIb3DQEBBQUAMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRD
b20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYG
A1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcN
MTMwNTAyMDYyMDQ2WhcNMTQwNTAzMTIxNDAyWjBdMRkwFwYDVQQNExBNd0k3ODIxNTRpV21lZVkw
MRwwGgYDVQQDDBNkd213MkBpbmZyYWRlYWQub3JnMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZy
YWRlYWQub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvWGuRDHiXVpOgaFkBaz8
c3jQTfiEw7j0iKZnktCQi0xjY29QJ7GwL+fgQlbofXgYTm8E9fWERvw2tAy2BxHzAPguBzziS7JN
hsGP9lf3L8hFJBvmdyyyj8b9A6Oi7s3JLtMRWIvyvE+DbuTkP+htuT4+XuTJr8Y5yIqd1WXr2gJk
ANr77vTyjeNxceevP58Tqr0f+4v5g6+vNARO3bk3SaVQPDUTwGrpoPtLh3d+mQzZ4iiW3MwQS7Wr
UVT3l2aTVHCpgtAaBs3zHWarvmIqhbWj8zdcnELNzwqTrOjaoWxuWY4k05GGfzmdjOBUiL7FDNvI
ZwweJEPwJAQI72YhUwIDAQABo4IC2TCCAtUwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBSs0hZhUgQwqGVXzLuH6pJH0hMZwTAf
BgNVHSMEGDAWgBRTcu2SnODaywFcfH6WNU7y1LhRgjAeBgNVHREEFzAVgRNkd213MkBpbmZyYWRl
YWQub3JnMIIBTAYDVR0gBIIBQzCCAT8wggE7BgsrBgEEAYG1NwECAzCCASowLgYIKwYBBQUHAgEW
Imh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0
YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdh
cyBpc3N1ZWQgYWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAxIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRz
IG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRl
ZCBwdXJwb3NlIGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMu
MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUxLWNybC5jcmww
gY4GCCsGAQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9z
dWIvY2xhc3MxL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20v
Y2VydHMvc3ViLmNsYXNzMS5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3Rh
cnRzc2wuY29tLzANBgkqhkiG9w0BAQUFAAOCAQEACFLDQnyO8+XA/TiTltjJ/ZAvM+qmBEKN43Vd
+Wio2lM/Wq/scJpkupXGHrl9CueobkDxMAogXbMxqLZYO13PvgjMh+PHxDPnQv8EGxOig+k/Hqvc
qEdTlm9YEHcbXbWS6XB+zRO7VVIpGMYQ1f1qCOcukxmwIm6iMSHXbOr/7paQm4bO0ULptjBotfiO
Zo6q8No6SroQlOSyc6v8FYSxTNIAXMaM2FYkjqrxgdnJmSIAfr11gROuF69WuOICxP0zTEjJle+7
aO9lUWNaWMWPMyFSNCxF6kkRuvUCami7vlhLOTRC1kb+OMhx7keN9At3tdTI3rtuFeSB1Pa3VXVs
0DCCBkIwggUqoAMCAQICAwaFzjANBgkqhkiG9w0BAQUFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNV
BAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xp
ZW50IENBMB4XDTEzMDUwMjA2MjA0NloXDTE0MDUwMzEyMTQwMlowXTEZMBcGA1UEDRMQTXdJNzgy
MTU0aVdtZWVZMDEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzEiMCAGCSqGSIb3DQEJARYT
ZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL1hrkQx
4l1aToGhZAWs/HN40E34hMO49IimZ5LQkItMY2NvUCexsC/n4EJW6H14GE5vBPX1hEb8NrQMtgcR
8wD4Lgc84kuyTYbBj/ZX9y/IRSQb5ncsso/G/QOjou7NyS7TEViL8rxPg27k5D/obbk+Pl7kya/G
OciKndVl69oCZADa++708o3jcXHnrz+fE6q9H/uL+YOvrzQETt25N0mlUDw1E8Bq6aD7S4d3fpkM
2eIoltzMEEu1q1FU95dmk1RwqYLQGgbN8x1mq75iKoW1o/M3XJxCzc8Kk6zo2qFsblmOJNORhn85
nYzgVIi+xQzbyGcMHiRD8CQECO9mIVMCAwEAAaOCAtkwggLVMAkGA1UdEwQCMAAwCwYDVR0PBAQD
AgSwMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUrNIWYVIEMKhlV8y7
h+qSR9ITGcEwHwYDVR0jBBgwFoAUU3Ltkpzg2ssBXHx+ljVO8tS4UYIwHgYDVR0RBBcwFYETZHdt
dzJAaW5mcmFkZWFkLm9yZzCCAUwGA1UdIASCAUMwggE/MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4G
CCsGAQUFBwIBFiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMIH3BggrBgEFBQcC
AjCB6jAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0
aWZpY2F0ZSB3YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJl
cXVpcmVtZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5LCByZWxpYW5jZSBvbmx5IGZvciB0
aGUgaW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBhcnR5IG9i
bGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9jcnR1
MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5zdGFy
dHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYIKwYBBQUHMAKGNmh0dHA6Ly9haWEuc3Rh
cnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50LmNhLmNydDAjBgNVHRIEHDAahhhodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQEFBQADggEBAAhSw0J8jvPlwP04k5bYyf2Q
LzPqpgRCjeN1XfloqNpTP1qv7HCaZLqVxh65fQrnqG5A8TAKIF2zMai2WDtdz74IzIfjx8Qz50L/
BBsTooPpPx6r3KhHU5ZvWBB3G121kulwfs0Tu1VSKRjGENX9agjnLpMZsCJuojEh12zq/+6WkJuG
ztFC6bYwaLX4jmaOqvDaOkq6EJTksnOr/BWEsUzSAFzGjNhWJI6q8YHZyZkiAH69dYETrhevVrji
AsT9M0xIyZXvu2jvZVFjWljFjzMhUjQsRepJEbr1Ampou75YSzk0QtZG/jjIce5HjfQLd7XUyN67
bhXkgdT2t1V1bNAxggNvMIIDawIBATCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2
BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMG
hc4wCQYFKw4DAhoFAKCCAa8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMTQwMzA2MTY1NzI0WjAjBgkqhkiG9w0BCQQxFgQUYLdvLSHaUnkCm5BAz8i8HRapDVMwgaUG
CSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4x
KzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0
YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMGhc4wgacGCyqG
SIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEr
MCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3Rh
cnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwaFzjANBgkqhkiG
9w0BAQEFAASCAQB7JKi9MlcI/Svuf8HyZuNcIsrem9WQPVHpyTxFgMAzWLiGerIo7RzdG+qJAEy0
y2idFrcv8rCDta2Eb067zdeZ7wwrr1mB+ONJqb+TxhFYJuwR84xQ9kVezJhJbkv7jnMLe+AOf0Eq
+hAnzJE4aaiDQo6iREesFZofiJtL1R8BWXUrvtXbuxmzMmcwAfNY5obQ85LDdsfbdHHVeuFfG0mm
I0m731HciBQfv8ZweRuBxeBo2qUgmSmV9dCqkIRzsTRbngJ5eumbTYC2GWwjTVqKbj4FLncYu8+3
camuhR9yFPr4MKyvUpxsTC/CX6PZz2+SuZ0+Z7IJWrCS+qHIG6TmAAAAAAAA


--=-v947l+1q7k0MadWUY/b0--


--===============6544416403836086438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6544416403836086438==--
