Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26ABC433F5
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 00:16:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1D463245
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 00:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B1D463245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C87E607C2;
	Tue, 16 Nov 2021 00:16:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b9wuomfTaZuH; Tue, 16 Nov 2021 00:16:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82A92607BB;
	Tue, 16 Nov 2021 00:16:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6110CC001E;
	Tue, 16 Nov 2021 00:16:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE3C2C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 00:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC6AA4024E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 00:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.cz header.b="SoXcLJBB";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.cz header.b="pA2oxaV7"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bH0IAVzibuoC for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 00:16:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97DEB40208
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 00:16:43 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC24C1FD72;
 Tue, 16 Nov 2021 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637021801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rQ09sVuRwFtyRV5yxoRRrQPkRyXR1M/Ww4uDC8hD0c=;
 b=SoXcLJBBKkjvWWkGuSnt+/eVeaWsvkiG6dZsaz05YqxAr8J1X9JDppCmj15pmVuz0tBx4H
 E2ghbGNRbl0jYbPp1zgCXBFefpuIKgsrq5i9zafBET711nfkZoxF8FjB8lAwJKbuErOt2Z
 ShCv9fSVySRTDG/GNGJqY01tsHpYqVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637021801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rQ09sVuRwFtyRV5yxoRRrQPkRyXR1M/Ww4uDC8hD0c=;
 b=pA2oxaV7sT8ZN3ByB52g5R7iPPFDjxvuTPUoWUhDdsj0BcxTLShXZBP5635i6W88eUbO9f
 HJ4FUI4DYdMMF9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8951D13F72;
 Tue, 16 Nov 2021 00:16:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ALbsIGn4kmFjXAAAMHmgww
 (envelope-from <vbabka@suse.cz>); Tue, 16 Nov 2021 00:16:41 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>
Subject: [RFC PATCH 28/32] iommu: Use put_pages_list
Date: Tue, 16 Nov 2021 01:16:24 +0100
Message-Id: <20211116001628.24216-29-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211116001628.24216-1-vbabka@suse.cz>
References: <20211116001628.24216-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14159; i=vbabka@suse.cz;
 h=from:subject; bh=ZycMevEyuP2bV/o88hipfk87XhrSp7sjDKCscjIVwL0=;
 b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhkvhTNBEYoTRtwQudnSYBocpn6yFHolLTLRv/XfqV
 O/Kq/peJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYZL4UwAKCRDgIcpz8YmpEIBgB/
 9qPR4A06p0m/LVew37hHOrFNPV2U+KkSn06NdDALbX5JhBDLLhO0xNE9V410ubhw6HuqmyXPfJxpRn
 HX6Ah3/RHQrCM5oCFyPKuhD8ZyLA4dfidRREarxJvU938LQHz4v5HV/jgDlgZMlQujbxdyFb/pCx7Y
 n5ckWpg7k2INi3GPi7RZJd26Ju3RzweMjW3EIrr/hZLNEPBEye7W0Kpp8rYENAgXluk0Yah9EFXJgH
 9UpqpdGoA/zmiUEDxHDv4W29wY7VFvFea+3aZmSg8KkMbSSqguMeKzsU5A5yWUU/x1fXYn+w14mpVr
 znfNLUJ44HBe/OCuA/GAxi7VF6Z8jc
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Vlastimil Babka <vbabka@suse.cz>
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
Switch the iommu code over to using free_pages_list().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: <iommu@lists.linux-foundation.org>
---
 drivers/iommu/amd/io_pgtable.c | 59 +++++++++-------------
 drivers/iommu/dma-iommu.c      | 11 +----
 drivers/iommu/intel/iommu.c    | 89 ++++++++++++----------------------
 include/linux/iommu.h          |  3 +-
 4 files changed, 57 insertions(+), 105 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 182c93a43efd..d4f83e1b633f 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -74,27 +74,15 @@ static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
  *
  ****************************************************************************/
 
-static void free_page_list(struct page *freelist)
-{
-	while (freelist != NULL) {
-		unsigned long p = (unsigned long)page_address(freelist);
-
-		freelist = freelist->freelist;
-		free_page(p);
-	}
-}
-
-static struct page *free_pt_page(unsigned long pt, struct page *freelist)
+static void free_pt_page(unsigned long pt, struct list_head *list)
 {
 	struct page *p = virt_to_page((void *)pt);
 
-	p->freelist = freelist;
-
-	return p;
+	list_add_tail(&p->lru, list);
 }
 
 #define DEFINE_FREE_PT_FN(LVL, FN)						\
-static struct page *free_pt_##LVL (unsigned long __pt, struct page *freelist)	\
+static void free_pt_##LVL (unsigned long __pt, struct list_head *list)		\
 {										\
 	unsigned long p;							\
 	u64 *pt;								\
@@ -113,10 +101,10 @@ static struct page *free_pt_##LVL (unsigned long __pt, struct page *freelist)	\
 			continue;						\
 										\
 		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);			\
-		freelist = FN(p, freelist);					\
+		FN(p, list);							\
 	}									\
 										\
-	return free_pt_page((unsigned long)pt, freelist);			\
+	free_pt_page((unsigned long)pt, list);					\
 }
 
 DEFINE_FREE_PT_FN(l2, free_pt_page)
@@ -125,36 +113,33 @@ DEFINE_FREE_PT_FN(l4, free_pt_l3)
 DEFINE_FREE_PT_FN(l5, free_pt_l4)
 DEFINE_FREE_PT_FN(l6, free_pt_l5)
 
-static struct page *free_sub_pt(unsigned long root, int mode,
-				struct page *freelist)
+static void free_sub_pt(unsigned long root, int mode, struct list_head *list)
 {
 	switch (mode) {
 	case PAGE_MODE_NONE:
 	case PAGE_MODE_7_LEVEL:
 		break;
 	case PAGE_MODE_1_LEVEL:
-		freelist = free_pt_page(root, freelist);
+		free_pt_page(root, list);
 		break;
 	case PAGE_MODE_2_LEVEL:
-		freelist = free_pt_l2(root, freelist);
+		free_pt_l2(root, list);
 		break;
 	case PAGE_MODE_3_LEVEL:
-		freelist = free_pt_l3(root, freelist);
+		free_pt_l3(root, list);
 		break;
 	case PAGE_MODE_4_LEVEL:
-		freelist = free_pt_l4(root, freelist);
+		free_pt_l4(root, list);
 		break;
 	case PAGE_MODE_5_LEVEL:
-		freelist = free_pt_l5(root, freelist);
+		free_pt_l5(root, list);
 		break;
 	case PAGE_MODE_6_LEVEL:
-		freelist = free_pt_l6(root, freelist);
+		free_pt_l6(root, list);
 		break;
 	default:
 		BUG();
 	}
-
-	return freelist;
 }
 
 void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
@@ -362,7 +347,7 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 	return pte;
 }
 
-static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
+static void free_clear_pte(u64 *pte, u64 pteval, struct list_head *list)
 {
 	unsigned long pt;
 	int mode;
@@ -373,12 +358,12 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
 	}
 
 	if (!IOMMU_PTE_PRESENT(pteval))
-		return freelist;
+		return;
 
 	pt   = (unsigned long)IOMMU_PTE_PAGE(pteval);
 	mode = IOMMU_PTE_MODE(pteval);
 
-	return free_sub_pt(pt, mode, freelist);
+	free_sub_pt(pt, mode, list);
 }
 
 /*
@@ -392,7 +377,7 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
 			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct protection_domain *dom = io_pgtable_ops_to_domain(ops);
-	struct page *freelist = NULL;
+	LIST_HEAD(freelist);
 	bool updated = false;
 	u64 __pte, *pte;
 	int ret, i, count;
@@ -412,9 +397,9 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
 		goto out;
 
 	for (i = 0; i < count; ++i)
-		freelist = free_clear_pte(&pte[i], pte[i], freelist);
+		free_clear_pte(&pte[i], pte[i], &freelist);
 
-	if (freelist != NULL)
+	if (!list_empty(&freelist))
 		updated = true;
 
 	if (count > 1) {
@@ -449,7 +434,7 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
 	}
 
 	/* Everything flushed out, free pages now */
-	free_page_list(freelist);
+	put_pages_list(&freelist);
 
 	return ret;
 }
@@ -511,7 +496,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 {
 	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
 	struct protection_domain *dom;
-	struct page *freelist = NULL;
+	LIST_HEAD(freelist);
 	unsigned long root;
 
 	if (pgtable->mode == PAGE_MODE_NONE)
@@ -530,9 +515,9 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 	       pgtable->mode > PAGE_MODE_6_LEVEL);
 
 	root = (unsigned long)pgtable->root;
-	freelist = free_sub_pt(root, pgtable->mode, freelist);
+	free_sub_pt(root, pgtable->mode, &freelist);
 
-	free_page_list(freelist);
+	put_pages_list(&freelist);
 }
 
 static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b42e38a0dbe2..e61881c2c258 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -66,14 +66,7 @@ early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
 static void iommu_dma_entry_dtor(unsigned long data)
 {
-	struct page *freelist = (struct page *)data;
-
-	while (freelist) {
-		unsigned long p = (unsigned long)page_address(freelist);
-
-		freelist = freelist->freelist;
-		free_page(p);
-	}
+	put_pages_list((struct list_head *)data);
 }
 
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
@@ -479,7 +472,7 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	else if (gather && gather->queued)
 		queue_iova(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad),
-				(unsigned long)gather->freelist);
+				(unsigned long)&gather->freelist);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0bde0c8b4126..c1eead2c3f92 100644
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
+				    struct list_head *list)
 {
 	struct page *pg;
 
 	pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
-	pg->freelist = freelist;
-	freelist = pg;
+	list_add_tail(&pg->lru, list);
 
 	if (level == 1)
-		return freelist;
+		return;
 
 	pte = page_address(pg);
 	do {
 		if (dma_pte_present(pte) && !dma_pte_superpage(pte))
-			freelist = dma_pte_list_pagetables(domain, level - 1,
-							   pte, freelist);
+			dma_pte_list_pagetables(domain, level - 1, pte, list);
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
+				struct list_head *list)
 {
 	struct dma_pte *first_pte = NULL, *last_pte = NULL;
 
@@ -1352,7 +1347,7 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
 			/* These suborbinate page tables are going away entirely. Don't
 			   bother to clear them; we're just going to *free* them. */
 			if (level > 1 && !dma_pte_superpage(pte))
-				freelist = dma_pte_list_pagetables(domain, level - 1, pte, freelist);
+				dma_pte_list_pagetables(domain, level - 1, pte, list);
 
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
+					    list);
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
+			 unsigned long last_pfn, struct list_head *list)
 {
 	BUG_ON(!domain_pfn_supported(domain, start_pfn));
 	BUG_ON(!domain_pfn_supported(domain, last_pfn));
 	BUG_ON(start_pfn > last_pfn);
 
 	/* we don't need lock here; nobody else touches the iova range */
-	freelist = dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-				       domain->pgd, 0, start_pfn, last_pfn,
-				       freelist);
+	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
+			    domain->pgd, 0, start_pfn, last_pfn, list);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
 		struct page *pgd_page = virt_to_page(domain->pgd);
-		pgd_page->freelist = freelist;
-		freelist = pgd_page;
-
+		list_add_tail(&pgd_page->lru, list);
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
+		LIST_HEAD(pages);
 
-		freelist = domain_unmap(domain, 0,
-					DOMAIN_MAX_PFN(domain->gaw), NULL);
-		dma_free_pagelist(freelist);
+		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &pages);
+		put_pages_list(&pages);
 	}
 
 	free_domain_mem(domain);
@@ -4194,19 +4169,17 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 		{
 			struct dmar_drhd_unit *drhd;
 			struct intel_iommu *iommu;
-			struct page *freelist;
+			LIST_HEAD(pages);
 
-			freelist = domain_unmap(si_domain,
-						start_vpfn, last_vpfn,
-						NULL);
+			domain_unmap(si_domain, start_vpfn, last_vpfn, &pages);
 
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
 				iommu_flush_iotlb_psi(iommu, si_domain,
 					start_vpfn, mhp->nr_pages,
-					!freelist, 0);
+					list_empty(&pages), 0);
 			rcu_read_unlock();
-			dma_free_pagelist(freelist);
+			put_pages_list(&pages);
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
 
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
