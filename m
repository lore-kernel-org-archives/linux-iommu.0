Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50554C433E6
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 14:43:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1183E207BB
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 14:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QXR3xbir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1183E207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 89387886C0;
	Wed, 22 Jul 2020 14:43:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JAgEh0Zwzebs; Wed, 22 Jul 2020 14:43:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C32688861E;
	Wed, 22 Jul 2020 14:43:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7B04C004E;
	Wed, 22 Jul 2020 14:43:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 412A6C004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2631B8865A
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6wz1FZI+gn6B for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 14:43:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 102998861E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=O3ttYMFFt6meJ6SGAlQv2syk0QrhUeYKY5hU4xF0jQ4=; b=QXR3xbirXNzgnggXuDNhnTbu+l
 TnCLvwqRpQj3Q1x8yAt5x3+8SMW/4144Jc0oYMG0Mcz/PlkLIaRYGNy4nunmylVrXp2Y0gQQ7KWow
 1SwJ6fF3pkJLSQBNun/POdupbEcaqwj/rmvarO8UHIxk2W+YhZJg4eKio2uzE+4MNvkEeTyKXb+Yg
 5xpHBkI9G4W/rLfncrPoOY+nAm7GR69HTh/b981IqGC0OGDW7Ba/FtCui83h4+NZcJkiKQQejyrp4
 hUk00qO+ig+S+P0xWkvYC3nt1IQs6GSu/usbwlRagnkF6dc0QDs2csAZv1sq5m23saKqnv7BupKML
 2MuTTX6g==;
Received: from [2001:4bb8:18c:2acc:e732:eaca:901c:b35d] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyFxd-0006j6-8h; Wed, 22 Jul 2020 14:43:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] dma-contiguous: cleanup dma_alloc_contiguous
Date: Wed, 22 Jul 2020 16:43:07 +0200
Message-Id: <20200722144307.30318-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: robin.murphy@arm.com
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

Split out a cma_alloc_aligned helper to deal with the "interesting"
calling conventions for cma_alloc, which then allows to the main
function to be written straight forward.  This also takes advantage
of the fact that NULL dev arguments have been gone from the DMA API
for a while.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/contiguous.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 15bc5026c485f2..f16b8d3f9932de 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -215,6 +215,13 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 	return cma_release(dev_get_cma_area(dev), pages, count);
 }
 
+static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
+{
+	return cma_alloc(dma_contiguous_default_area, size >> PAGE_SHIFT,
+			 min_t(size_t, get_order(size), CONFIG_CMA_ALIGNMENT),
+			 gfp & __GFP_NOWARN);
+}
+
 /**
  * dma_alloc_contiguous() - allocate contiguous pages
  * @dev:   Pointer to device for which the allocation is performed.
@@ -231,24 +238,14 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
-	size_t count = size >> PAGE_SHIFT;
-	struct page *page = NULL;
-	struct cma *cma = NULL;
-
-	if (dev && dev->cma_area)
-		cma = dev->cma_area;
-	else if (count > 1)
-		cma = dma_contiguous_default_area;
-
 	/* CMA can be used only in the context which permits sleeping */
-	if (cma && gfpflags_allow_blocking(gfp)) {
-		size_t align = get_order(size);
-		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
-
-		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
-	}
-
-	return page;
+	if (!gfpflags_allow_blocking(gfp))
+		return NULL;
+	if (dev->cma_area)
+		return cma_alloc_aligned(dev->cma_area, size, gfp);
+	if (size <= PAGE_SIZE || !dma_contiguous_default_area)
+		return NULL;
+	return cma_alloc_aligned(dma_contiguous_default_area, size, gfp);
 }
 
 /**
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
