Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB1CC433E2
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 16:48:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B6520759
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c2ZnrSe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B6520759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0774486CFD;
	Tue,  8 Sep 2020 16:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j4WtR0dpebLJ; Tue,  8 Sep 2020 16:48:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D25E8690B;
	Tue,  8 Sep 2020 16:48:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62D57C088B;
	Tue,  8 Sep 2020 16:48:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1D70C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9026685EF5
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BnXtqnGuJg-x for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 16:48:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7B9688588A
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=al0ag1j1mhlnjNfR7j4kD7CUfxxYaZBiv73JAkyo30Q=; b=c2ZnrSe2X6va8zAfelp2V/exIM
 hwcLDaVgsRkmxTApT2R4WKPdHTn4Y/Cx6BoSPvMrqulcKzxOqOEroLmrZCoG5GV619Ou5t0p24Ap5
 FzWUe07Ff/CQ2GwhhWYzbSioLNbsUHlkM+NxA0akLBhY/BPykuDhR3iy9VNWZ4DPsNKXhPPM6kGWj
 12Pr6pX8v5s9wMnaYEmMRivjZy6GdSa40AE5ko0P7gIC4cf3pBnGb40zeSHSUESoil3jeaXYAKhev
 I4/VinsIgOcWeaROvSrTabkj0eCQ3IgG8kUVFdsLNt14IFi+2f0P+OHbK/sRYXOpxGeKeH8tLRr5v
 HR5eHbvA==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFgmt-0001Sf-Qe; Tue, 08 Sep 2020 16:48:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 07/12] dma-direct: lift gfp_t manipulation out
 of__dma_direct_alloc_pages
Date: Tue,  8 Sep 2020 18:47:53 +0200
Message-Id: <20200908164758.3177341-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908164758.3177341-1-hch@lst.de>
References: <20200908164758.3177341-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
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

Move the detailed gfp_t setup from __dma_direct_alloc_pages into the
caller to clean things up a little.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 1d564bea58571b..12e9f5f75dfe4b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -108,7 +108,7 @@ static inline bool dma_should_free_from_pool(struct device *dev,
 }
 
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
-		gfp_t gfp, unsigned long attrs)
+		gfp_t gfp)
 {
 	int node = dev_to_node(dev);
 	struct page *page = NULL;
@@ -116,11 +116,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
-	if (attrs & DMA_ATTR_NO_WARN)
-		gfp |= __GFP_NOWARN;
-
-	/* we always manually zero the memory once we are done: */
-	gfp &= ~__GFP_ZERO;
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
@@ -164,6 +159,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 
 	size = PAGE_ALIGN(size);
+	if (attrs & DMA_ATTR_NO_WARN)
+		gfp |= __GFP_NOWARN;
 
 	if (dma_should_alloc_from_pool(dev, gfp, attrs)) {
 		u64 phys_mask;
@@ -177,7 +174,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		goto done;
 	}
 
-	page = __dma_direct_alloc_pages(dev, size, gfp, attrs);
+	/* we always manually zero the memory once we are done */
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
 	if (!page)
 		return NULL;
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
