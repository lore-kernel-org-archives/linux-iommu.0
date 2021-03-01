Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E5BC433E6
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 07:46:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBEA64DE7
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 07:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBEA64DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88F4842C9F;
	Mon,  1 Mar 2021 07:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YAX8y6NdHVps; Mon,  1 Mar 2021 07:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB83D4F285;
	Mon,  1 Mar 2021 07:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F592C0011;
	Mon,  1 Mar 2021 07:46:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42734C0001
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2463483B1F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NPkqDTdP0ozS for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:46:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C778833A0
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=brl7E8YVp1JaasQZUSI4zOCBNU3VX5lh7I+3ZpJVKoQ=; b=cO0/CICsxS0v4hTlVtR0AshwTW
 BsQP4SA3okIlBHconzJAwHO1GHs+WlrszQeZX8PaBKPE4sTe4Pr60XvEotfhISYYsfb9GHUs6mxn5
 +LUPeX4e+PyqKPmerxpZOsSOplktgII87t8Q57xX5Wdtdc6sPRJ57juxwYJQ5uVZFhq9uXQY/vibm
 POlSfDXa1pP3OWLz54nN2HRVZh6xiQ91PsdXS5Qqon+lvO2cQD6Qc2bfExgGVpbGTpzis4zBJTAon
 zOhhS34/GFAL7SGt20X25yTtEm0DWXZEh1aPLIImYDKVUb9adcUs9rZkJP08CohwnsBQYdzbUs5V+
 gW+ODGhQ==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGdFr-00FRE9-3o; Mon, 01 Mar 2021 07:46:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 10/14] xen-swiotlb: split xen_swiotlb_init
Date: Mon,  1 Mar 2021 08:44:32 +0100
Message-Id: <20210301074436.919889-11-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210301074436.919889-1-hch@lst.de>
References: <20210301074436.919889-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, Claire Chang <tientzu@chromium.org>,
 linuxppc-dev@lists.ozlabs.org, Dongli Zhang <dongli.zhang@oracle.com>
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

Split xen_swiotlb_init into a normal an an early case.  That makes both
much simpler and more readable, and also allows marking the early
code as __init and x86-only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/xen/mm.c              |   2 +-
 arch/x86/xen/pci-swiotlb-xen.c |   4 +-
 drivers/xen/swiotlb-xen.c      | 124 +++++++++++++++++++--------------
 include/xen/swiotlb-xen.h      |   3 +-
 4 files changed, 75 insertions(+), 58 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 467fa225c3d0ed..aae950cd053fea 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -140,7 +140,7 @@ static int __init xen_mm_init(void)
 	struct gnttab_cache_flush cflush;
 	if (!xen_initial_domain())
 		return 0;
-	xen_swiotlb_init(1, false);
+	xen_swiotlb_init();
 
 	cflush.op = 0;
 	cflush.a.dev_bus_addr = 0;
diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
index 19ae3e4fe4e98e..54f9aa7e845739 100644
--- a/arch/x86/xen/pci-swiotlb-xen.c
+++ b/arch/x86/xen/pci-swiotlb-xen.c
@@ -59,7 +59,7 @@ int __init pci_xen_swiotlb_detect(void)
 void __init pci_xen_swiotlb_init(void)
 {
 	if (xen_swiotlb) {
-		xen_swiotlb_init(1, true /* early */);
+		xen_swiotlb_init_early();
 		dma_ops = &xen_swiotlb_dma_ops;
 
 #ifdef CONFIG_PCI
@@ -76,7 +76,7 @@ int pci_xen_swiotlb_init_late(void)
 	if (xen_swiotlb)
 		return 0;
 
-	rc = xen_swiotlb_init(1, false /* late */);
+	rc = xen_swiotlb_init();
 	if (rc)
 		return rc;
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 060eeb056486f5..00adeb95ebb9df 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -156,96 +156,112 @@ static const char *xen_swiotlb_error(enum xen_swiotlb_err err)
 
 #define DEFAULT_NSLABS		ALIGN(SZ_64M >> IO_TLB_SHIFT, IO_TLB_SEGSIZE)
 
-int __ref xen_swiotlb_init(int verbose, bool early)
+int __ref xen_swiotlb_init(void)
 {
-	unsigned long bytes, order;
-	int rc = -ENOMEM;
 	enum xen_swiotlb_err m_ret = XEN_SWIOTLB_UNKNOWN;
+	unsigned long nslabs, bytes, order;
 	unsigned int repeat = 3;
+	int rc = -ENOMEM;
 	char *start;
-	unsigned long nslabs;
 
 	nslabs = swiotlb_nr_tbl();
-retry:
 	if (!nslabs)
 		nslabs = DEFAULT_NSLABS;
+retry:
+	m_ret = XEN_SWIOTLB_ENOMEM;
 	bytes = nslabs << IO_TLB_SHIFT;
 	order = get_order(bytes);
 
 	/*
 	 * Get IO TLB memory from any location.
 	 */
-	if (early) {
-		start = memblock_alloc(PAGE_ALIGN(bytes),
-						  PAGE_SIZE);
-		if (!start)
-			panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
-			      __func__, PAGE_ALIGN(bytes), PAGE_SIZE);
-	} else {
 #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
-		while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
-			start = (void *)xen_get_swiotlb_free_pages(order);
-			if (start)
-				break;
-			order--;
-		}
-		if (order != get_order(bytes)) {
-			pr_warn("Warning: only able to allocate %ld MB for software IO TLB\n",
-				(PAGE_SIZE << order) >> 20);
-			nslabs = SLABS_PER_PAGE << order;
-			bytes = nslabs << IO_TLB_SHIFT;
-		}
+	while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
+		start = (void *)xen_get_swiotlb_free_pages(order);
+		if (start)
+			break;
+		order--;
 	}
-	if (!start) {
-		m_ret = XEN_SWIOTLB_ENOMEM;
+	if (!start)
 		goto error;
+	if (order != get_order(bytes)) {
+		pr_warn("Warning: only able to allocate %ld MB for software IO TLB\n",
+			(PAGE_SIZE << order) >> 20);
+		nslabs = SLABS_PER_PAGE << order;
+		bytes = nslabs << IO_TLB_SHIFT;
 	}
+
 	/*
 	 * And replace that memory with pages under 4GB.
 	 */
-	rc = xen_swiotlb_fixup(start,
-			       bytes,
-			       nslabs);
+	rc = xen_swiotlb_fixup(start, bytes, nslabs);
 	if (rc) {
-		if (early)
-			memblock_free(__pa(start),
-				      PAGE_ALIGN(bytes));
-		else {
-			free_pages((unsigned long)start, order);
-			start = NULL;
-		}
+		free_pages((unsigned long)start, order);
 		m_ret = XEN_SWIOTLB_EFIXUP;
 		goto error;
 	}
-	if (early) {
-		if (swiotlb_init_with_tbl(start, nslabs,
-			 verbose))
-			panic("Cannot allocate SWIOTLB buffer");
-		rc = 0;
-	} else
-		rc = swiotlb_late_init_with_tbl(start, nslabs);
-
-	if (!rc)
-		swiotlb_set_max_segment(PAGE_SIZE);
-
-	return rc;
+	rc = swiotlb_late_init_with_tbl(start, nslabs);
+	if (rc)
+		return rc;
+	swiotlb_set_max_segment(PAGE_SIZE);
+	return 0;
 error:
 	if (repeat--) {
-		nslabs = max(1024UL, /* Min is 2MB */
-					(nslabs >> 1));
+		/* Min is 2MB */
+		nslabs = max(1024UL, (nslabs >> 1));
 		pr_info("Lowering to %luMB\n",
 			(nslabs << IO_TLB_SHIFT) >> 20);
 		goto retry;
 	}
 	pr_err("%s (rc:%d)\n", xen_swiotlb_error(m_ret), rc);
-	if (early)
-		panic("%s (rc:%d)", xen_swiotlb_error(m_ret), rc);
-	else
-		free_pages((unsigned long)start, order);
+	free_pages((unsigned long)start, order);
 	return rc;
 }
 
+#ifdef CONFIG_X86
+void __init xen_swiotlb_init_early(void)
+{
+	unsigned long nslabs, bytes;
+	unsigned int repeat = 3;
+	char *start;
+	int rc;
+
+	nslabs = swiotlb_nr_tbl();
+	if (!nslabs)
+		nslabs = DEFAULT_NSLABS;
+retry:
+	/*
+	 * Get IO TLB memory from any location.
+	 */
+	bytes = nslabs << IO_TLB_SHIFT;
+	start = memblock_alloc(PAGE_ALIGN(bytes), PAGE_SIZE);
+	if (!start)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
+		      __func__, PAGE_ALIGN(bytes), PAGE_SIZE);
+
+	/*
+	 * And replace that memory with pages under 4GB.
+	 */
+	rc = xen_swiotlb_fixup(start, bytes, nslabs);
+	if (rc) {
+		memblock_free(__pa(start), PAGE_ALIGN(bytes));
+		if (repeat--) {
+			/* Min is 2MB */
+			nslabs = max(1024UL, (nslabs >> 1));
+			pr_info("Lowering to %luMB\n",
+				(nslabs << IO_TLB_SHIFT) >> 20);
+			goto retry;
+		}
+		panic("%s (rc:%d)", xen_swiotlb_error(XEN_SWIOTLB_EFIXUP), rc);
+	}
+
+	if (swiotlb_init_with_tbl(start, nslabs, false))
+		panic("Cannot allocate SWIOTLB buffer");
+	swiotlb_set_max_segment(PAGE_SIZE);
+}
+#endif /* CONFIG_X86 */
+
 static void *
 xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flags,
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index d5eaf9d682b804..6206b1ec99168a 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -9,7 +9,8 @@ void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
 void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
 			     size_t size, enum dma_data_direction dir);
 
-extern int xen_swiotlb_init(int verbose, bool early);
+int xen_swiotlb_init(void);
+void __init xen_swiotlb_init_early(void);
 extern const struct dma_map_ops xen_swiotlb_dma_ops;
 
 #endif /* __LINUX_SWIOTLB_XEN_H */
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
