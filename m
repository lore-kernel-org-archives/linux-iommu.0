From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] On unmap, flush IOMMU TLB and return correct size
Date: Sat, 21 Sep 2013 21:59:00 -0500
Message-ID: <1379818740.2547.51.camel@shinybook.infradead.org>
References: <CE494510.41547%hshankar@netapp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3255765739127998600=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CE494510.41547%hshankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Shankar, Hari" <Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Singh, Varinder" <Varinder.Singh-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Sundaram,
	Rajesh" <Rajesh.Sundaram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Spiller,
	John" <John.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Kimmel, Jeff" <jeff.kimmel-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============3255765739127998600==
Content-Type: multipart/signed; micalg="sha-1"; protocol="application/x-pkcs7-signature";
	boundary="=-dnB42FBdoO4OBOdS+YwO"


--=-dnB42FBdoO4OBOdS+YwO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2013-09-02 at 02:24 +0000, Shankar, Hari wrote:
> Patch Description: The patch is for Intel IOMMU driver. It forces
> IOMMU TLB flush for the particular domain and return correct unmap
> size when intel_iommu_unmap() is called

I *hate* the bizarre calling convention for iommu_unmap(). Is it
actually clearly documented anywhere? Why on earth is it not just
returning void, and expected to unmap what it was *asked* to unmap?

I keep getting patches which "fix" the return value, with no clear
explanation of what it's actually supposed to do. I ask sometimes, but
the answer is always so weird that I end up forgetting it again.

The main user seems to be kvm_iommu_put_pages() in virt/kvm/iommu.c
which appears to be *designed* to get poor performance, making a single
call (with associated clflush and IOTLB flush) for every individual
*page* instead of just unmapping a whole virtual range at a time.

One thing you neglected to fix in this patch is the fact that the
intel_iommu_unmap() function doesn't call dma_pte_free_pagetable() after
it calls dma_pte_clear_range(). For reasons not entirely clear to me,
adding that call fixes a significant performance issue where the time
taken to do unmaps is exponential w.r.t. the size of the region.

And in fact, if we fix that then you suffer the same bug that exists
everywhere *else* we do unmaps... which is that we actually need to
flush the IOTLB (with the IH bit cleared) *before* we free the page
table pages, because the hardware could have cached them and could still
be doing a page walk after you've returned the pages to the pool.

Here's a completely untested work-in-progress that attempts to fix that.
I'll be able to test it myself on about Tuesday when I'm home from New
Orleans and awake...

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 15e9b57..69980a1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -413,6 +413,7 @@ struct deferred_flush_tables {
 	int next;
 	struct iova *iova[HIGH_WATER_MARK];
 	struct dmar_domain *domain[HIGH_WATER_MARK];
+	struct page *freelist[HIGH_WATER_MARK];
 };
=20
 static struct deferred_flush_tables *deferred_flush;
@@ -945,6 +946,114 @@ static void dma_pte_free_pagetable(struct dmar_domain=
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
+static struct page *dma_pte_list_pagetables(struct dmar_domain *domain, in=
t level,
+					    struct dma_pte *pte, struct page *freelist)
+{
+	struct page *pg;
+
+	pg =3D pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
+	pg->freelist =3D freelist;
+	freelist =3D pg;
+
+	if (level > 1) {
+		pte =3D page_address(pg);
+
+		do {
+			if (dma_pte_present(pte) && !dma_pte_superpage(pte))
+				freelist =3D dma_pte_list_pagetables(domain, level - 1, pte, freelist)=
;
+
+		} while (!first_pte_in_page(++pte));
+	}
+
+	return freelist;
+}
+
+static struct page *dma_pte_clear_level(struct dmar_domain *domain, int le=
vel,
+					struct dma_pte *pte, unsigned long pfn,
+					unsigned long start_pfn, unsigned long last_pfn,
+					struct page *freelist)
+{
+	struct dma_pte *first_pte =3D NULL, *last_pte =3D NULL;
+
+	pfn =3D max(start_pfn, pfn);
+	pte =3D &pte[pfn_level_offset(pfn, level)];
+
+	do {
+		unsigned long level_pfn;
+		struct dma_pte *level_pte;
+
+		if (!dma_pte_present(pte))
+			goto next;
+
+		level_pfn =3D pfn & level_mask(level - 1);
+		level_pte =3D phys_to_virt(dma_pte_addr(pte));
+
+		/* If range covers entire pagetable, free it */
+		if (start_pfn <=3D level_pfn &&
+		    last_pfn >=3D level_pfn + level_size(level)) {
+
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
+		} else {
+			/* Recurse down into a level that isn't *entirely* obsolete */
+			freelist =3D dma_pte_clear_level(domain, level - 1, level_pte,
+						       level_pfn, start_pfn, last_pfn, freelist);
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
+	return freelist;
+}
+
+void dma_free_pagelist(struct page *freelist)
+{
+	struct page *pg;
+
+	while ((pg =3D freelist)) {
+		freelist =3D pg->freelist;
+		free_pgtable_page(pg);
+	}
+}
+
 /* iommu handling */
 static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 {
@@ -1054,7 +1163,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *i=
ommu, u16 did,
 		break;
 	case DMA_TLB_PSI_FLUSH:
 		val =3D DMA_TLB_PSI_FLUSH|DMA_TLB_IVT|DMA_TLB_DID(did);
-		/* Note: always flush non-leaf currently */
+		/* IH bit is passed in as part of address */
 		val_iva =3D size_order | addr;
 		break;
 	default:
@@ -1165,13 +1274,15 @@ static void iommu_flush_dev_iotlb(struct dmar_domai=
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
@@ -1182,7 +1293,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu =
*iommu, u16 did,
 		iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						DMA_TLB_DSI_FLUSH);
 	else
-		iommu->flush.flush_iotlb(iommu, did, addr, mask,
+		iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
 						DMA_TLB_PSI_FLUSH);
=20
 	/*
@@ -2850,7 +2961,7 @@ static dma_addr_t __intel_map_single(struct device *h=
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
@@ -2902,13 +3013,16 @@ static void flush_unmaps(void)
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
@@ -2925,7 +3039,7 @@ static void flush_unmaps_timeout(unsigned long data)
 	spin_unlock_irqrestore(&async_umap_flush_lock, flags);
 }
=20
-static void add_unmap(struct dmar_domain *dom, struct iova *iova)
+static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct p=
age *freelist)
 {
 	unsigned long flags;
 	int next, iommu_id;
@@ -2941,6 +3055,7 @@ static void add_unmap(struct dmar_domain *dom, struct=
 iova *iova)
 	next =3D deferred_flush[iommu_id].next;
 	deferred_flush[iommu_id].domain[next] =3D dom;
 	deferred_flush[iommu_id].iova[next] =3D iova;
+	deferred_flush[iommu_id].freelist[next] =3D freelist;
 	deferred_flush[iommu_id].next++;
=20
 	if (!timer_on) {
@@ -2960,6 +3075,7 @@ static void intel_unmap_page(struct device *dev, dma_=
addr_t dev_addr,
 	unsigned long start_pfn, last_pfn;
 	struct iova *iova;
 	struct intel_iommu *iommu;
+	struct page *freelist;
=20
 	if (iommu_no_mapping(dev))
 		return;
@@ -2980,19 +3096,16 @@ static void intel_unmap_page(struct device *dev, dm=
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
@@ -3054,6 +3167,7 @@ static void intel_unmap_sg(struct device *hwdev, stru=
ct scatterlist *sglist,
 	unsigned long start_pfn, last_pfn;
 	struct iova *iova;
 	struct intel_iommu *iommu;
+	struct page *freelist;
=20
 	if (iommu_no_mapping(hwdev))
 		return;
@@ -3071,19 +3185,16 @@ static void intel_unmap_sg(struct device *hwdev, st=
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
@@ -3166,7 +3277,7 @@ static int intel_map_sg(struct device *hwdev, struct =
scatterlist *sglist, int ne
=20
 	/* it's a non-present to present mapping. Only flush if caching mode */
 	if (cap_caching_mode(iommu->cap))
-		iommu_flush_iotlb_psi(iommu, domain->id, start_vpfn, size, 1);
+		iommu_flush_iotlb_psi(iommu, domain->id, start_vpfn, size, 0, 1);
 	else
 		iommu_flush_write_buffer(iommu);
=20
@@ -4116,7 +4227,10 @@ static size_t intel_iommu_unmap(struct iommu_domain =
*domain,
 	int order;
=20
 	order =3D dma_pte_clear_range(dmar_domain, iova >> VTD_PAGE_SHIFT,
-			    (iova + size - 1) >> VTD_PAGE_SHIFT);
+				    (iova + size - 1) >> VTD_PAGE_SHIFT);
+
+	dma_pte_free_pagetable(dmar_domain, iova >> VTD_PAGE_SHIFT,
+			       (iova + size - 1) >> VTD_PAGE_SHIFT);
=20
 	if (dmar_domain->max_addr =3D=3D iova + size)
 		dmar_domain->max_addr =3D iova;



--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporation

--=-dnB42FBdoO4OBOdS+YwO
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
DxcNMTMwOTIyMDI1OTAwWjAjBgkqhkiG9w0BCQQxFgQU2v6h00d77r1VfmbKllq0bDqybzgwgaUG
CSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4x
KzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0
YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMGhc4wgacGCyqG
SIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEr
MCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3Rh
cnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwaFzjANBgkqhkiG
9w0BAQEFAASCAQBxXF70cdP7h4xLj5AkFnLttBn7h0BONy4s78yg5hG3ncJLDe4jFxUa/ymnaQcq
pYDKT7ANxMfzAaHlmq542IksTBsxI6Cu2FMf48Dzvem8Ovmf1foR+7H3pWBOK72nDpeCSzWhj8hL
TgLgUCbF61CYRDvTrVffJNicEjjD/N/QRWKMX7qOR/QJs9VveMW9P6f55m2XHHFQ1//rokgqRrVJ
N2+83zIbtfgFdN2rQOFI5eBz+fSSFEsWWkW1CeGJT9W5rMHhEs1WQ2y/qNf3OiJ2uSXkirUTLGhx
WxUmmKggeLp5allP8YYYH3kv5eFIw3D0wKwhdYfo5YkHJ+PbXm1nAAAAAAAA


--=-dnB42FBdoO4OBOdS+YwO--


--===============3255765739127998600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3255765739127998600==--
