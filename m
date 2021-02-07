Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99733C433E0
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 16:09:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589FD64E15
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 16:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589FD64E15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4094C822C6;
	Sun,  7 Feb 2021 16:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bCmEWz5h5aMz; Sun,  7 Feb 2021 16:09:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 425368453F;
	Sun,  7 Feb 2021 16:09:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CFE3C0174;
	Sun,  7 Feb 2021 16:09:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2FB7C013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 16:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BD6D586853
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 16:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tB6kiLOp4SlZ for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 16:09:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 875778685C
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=rEuv14TWvGuv4AUXj7YefRFQ9Xyg6sjJXdKXUy0YdBM=; b=UVaqF+zxpqx611WOIaQ9KZyzB2
 re821/ddYXmPPjC9ugy3GaeRlBLWplBRXsujMtZd1vW0IfK3iPfhxgkhWlj2pOCPKDk/Z64FWg9qG
 dHIZsb/VOpLlw9FxnFS3s24XnncV7ayWGvtT/dbQBX6YTxwlS6vcHhsA7xy7YtsaYbgBAhJZqy23B
 /IzKWcYn+2++207f++acZ9XrPm1qBYQ85sJ/oBgoVFBCDx4vKxYxRdkp0Tg1TUUSit0t2UDqHUBk9
 Ow1JcHjpXfjK8ybhbOQEqngr1mR8y92BfM/Wbg7c+DwzEOanYt56k0DlKSTDYvqhkRe3aLgg08Pvo
 tf8I8czw==;
Received: from [2001:4bb8:184:7d04:4590:5583:6cb7:77c7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l8md7-004tmh-DD; Sun, 07 Feb 2021 16:09:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 5/8] xen-swiotlb: remove xen_io_tlb_start and xen_io_tlb_nslabs
Date: Sun,  7 Feb 2021 17:09:31 +0100
Message-Id: <20210207160934.2955931-6-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210207160934.2955931-1-hch@lst.de>
References: <20210207160934.2955931-1-hch@lst.de>
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

The xen_io_tlb_start and xen_io_tlb_nslabs variables ar now only used in
xen_swiotlb_init, so replace them with local variables.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 57 +++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 57f8d5fadc1fcd..6e0f2c5ecd1a2f 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -40,14 +40,7 @@
 
 #include <trace/events/swiotlb.h>
 #define MAX_DMA_BITS 32
-/*
- * Used to do a quick range check in swiotlb_tbl_unmap_single and
- * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
- * API.
- */
 
-static char *xen_io_tlb_start;
-static unsigned long xen_io_tlb_nslabs;
 /*
  * Quick lookup value of the bus address of the IOTLB.
  */
@@ -169,75 +162,75 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	int rc = -ENOMEM;
 	enum xen_swiotlb_err m_ret = XEN_SWIOTLB_UNKNOWN;
 	unsigned int repeat = 3;
+	char *start;
+	unsigned long nslabs;
 
-	xen_io_tlb_nslabs = swiotlb_nr_tbl();
+	nslabs = swiotlb_nr_tbl();
 retry:
-	if (!xen_io_tlb_nslabs)
-		xen_io_tlb_nslabs = DEFAULT_NSLABS;
-	bytes = xen_io_tlb_nslabs << IO_TLB_SHIFT;
+	if (!nslabs)
+		nslabs = DEFAULT_NSLABS;
+	bytes = nslabs << IO_TLB_SHIFT;
 	order = get_order(bytes);
 
 	/*
 	 * IO TLB memory already allocated. Just use it.
 	 */
-	if (io_tlb_start != 0) {
-		xen_io_tlb_start = phys_to_virt(io_tlb_start);
+	if (io_tlb_start != 0)
 		goto end;
-	}
 
 	/*
 	 * Get IO TLB memory from any location.
 	 */
 	if (early) {
-		xen_io_tlb_start = memblock_alloc(PAGE_ALIGN(bytes),
+		start = memblock_alloc(PAGE_ALIGN(bytes),
 						  PAGE_SIZE);
-		if (!xen_io_tlb_start)
+		if (!start)
 			panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
 			      __func__, PAGE_ALIGN(bytes), PAGE_SIZE);
 	} else {
 #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
 		while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
-			xen_io_tlb_start = (void *)xen_get_swiotlb_free_pages(order);
-			if (xen_io_tlb_start)
+			start = (void *)xen_get_swiotlb_free_pages(order);
+			if (start)
 				break;
 			order--;
 		}
 		if (order != get_order(bytes)) {
 			pr_warn("Warning: only able to allocate %ld MB for software IO TLB\n",
 				(PAGE_SIZE << order) >> 20);
-			xen_io_tlb_nslabs = SLABS_PER_PAGE << order;
-			bytes = xen_io_tlb_nslabs << IO_TLB_SHIFT;
+			nslabs = SLABS_PER_PAGE << order;
+			bytes = nslabs << IO_TLB_SHIFT;
 		}
 	}
-	if (!xen_io_tlb_start) {
+	if (!start) {
 		m_ret = XEN_SWIOTLB_ENOMEM;
 		goto error;
 	}
 	/*
 	 * And replace that memory with pages under 4GB.
 	 */
-	rc = xen_swiotlb_fixup(xen_io_tlb_start,
+	rc = xen_swiotlb_fixup(start,
 			       bytes,
-			       xen_io_tlb_nslabs);
+			       nslabs);
 	if (rc) {
 		if (early)
-			memblock_free(__pa(xen_io_tlb_start),
+			memblock_free(__pa(start),
 				      PAGE_ALIGN(bytes));
 		else {
-			free_pages((unsigned long)xen_io_tlb_start, order);
-			xen_io_tlb_start = NULL;
+			free_pages((unsigned long)start, order);
+			start = NULL;
 		}
 		m_ret = XEN_SWIOTLB_EFIXUP;
 		goto error;
 	}
 	if (early) {
-		if (swiotlb_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs,
+		if (swiotlb_init_with_tbl(start, nslabs,
 			 verbose))
 			panic("Cannot allocate SWIOTLB buffer");
 		rc = 0;
 	} else
-		rc = swiotlb_late_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs);
+		rc = swiotlb_late_init_with_tbl(start, nslabs);
 
 end:
 	if (!rc)
@@ -246,17 +239,17 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	return rc;
 error:
 	if (repeat--) {
-		xen_io_tlb_nslabs = max(1024UL, /* Min is 2MB */
-					(xen_io_tlb_nslabs >> 1));
+		nslabs = max(1024UL, /* Min is 2MB */
+					(nslabs >> 1));
 		pr_info("Lowering to %luMB\n",
-			(xen_io_tlb_nslabs << IO_TLB_SHIFT) >> 20);
+			(nslabs << IO_TLB_SHIFT) >> 20);
 		goto retry;
 	}
 	pr_err("%s (rc:%d)\n", xen_swiotlb_error(m_ret), rc);
 	if (early)
 		panic("%s (rc:%d)", xen_swiotlb_error(m_ret), rc);
 	else
-		free_pages((unsigned long)xen_io_tlb_start, order);
+		free_pages((unsigned long)start, order);
 	return rc;
 }
 
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
