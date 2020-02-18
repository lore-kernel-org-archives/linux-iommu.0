Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C97C34026
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E231321D56
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MkhvQq02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E231321D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA8DA853E6;
	Tue, 18 Feb 2020 18:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9QgRLS+aqcH7; Tue, 18 Feb 2020 18:41:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E1E838550D;
	Tue, 18 Feb 2020 18:41:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B508DC1D84;
	Tue, 18 Feb 2020 18:41:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB38C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1B90F851CC
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:41:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bRSHNas8QZDw for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 18:41:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0988B85193
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=EZUsIWVxCJfKAp5hgBO8pkkyeDryPZ3RWZ2CwNUmvoc=; b=MkhvQq02mjxCd/klcHYtxI9pZJ
 Gi+LmyZlBydxwxjCS9CpsMwRYfSsgAKMRWzUqBEzmmjZI/NLjVVWEju3UM1I9PAxvav0klAA5zjp2
 OsMk3XDE1Ethwsx3kTriO5gqA9TjmkyLO0YS7hPUC3rzBqsnCcGPm9xo/KIwr/lmWfFnfwpWNR6yl
 F1ZjtTRI5sRE69P8mDurQf6wgYJWOPdlW5+k9zANTl0L0S7WOmCBi+fACxL5txvzCiMXheFdYD42S
 nw88WY02bpPu6mEDn7cm4tFsm87OY96HkrYYH8OJbBTT6RO3NVRjGKJVofwVoJ8NccM+gDS+UDxLF
 NncayH1Q==;
Received: from [199.255.44.128] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j47oW-0002jH-ED; Tue, 18 Feb 2020 18:41:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH 1/3] ARM/dma-mapping: remove get_coherent_dma_mask
Date: Tue, 18 Feb 2020 10:41:01 -0800
Message-Id: <20200218184103.35932-2-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218184103.35932-1-hch@lst.de>
References: <20200218184103.35932-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
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

The core DMA code already checks for valid DMA masks earlier on, and
doesn't allow NULL struct device pointers.  Remove the now not required
checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 41 ++++-----------------------------------
 1 file changed, 4 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9414d72f664b..72ddc3d0f5eb 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -219,7 +219,7 @@ const struct dma_map_ops arm_coherent_dma_ops = {
 };
 EXPORT_SYMBOL(arm_coherent_dma_ops);
 
-static int __dma_supported(struct device *dev, u64 mask, bool warn)
+static int __dma_supported(struct device *dev, u64 mask)
 {
 	unsigned long max_dma_pfn = min(max_pfn - 1, arm_dma_pfn_limit);
 
@@ -227,41 +227,11 @@ static int __dma_supported(struct device *dev, u64 mask, bool warn)
 	 * Translate the device's DMA mask to a PFN limit.  This
 	 * PFN number includes the page which we can DMA to.
 	 */
-	if (dma_to_pfn(dev, mask) < max_dma_pfn) {
-		if (warn)
-			dev_warn(dev, "Coherent DMA mask %#llx (pfn %#lx-%#lx) covers a smaller range of system memory than the DMA zone pfn 0x0-%#lx\n",
-				 mask,
-				 dma_to_pfn(dev, 0), dma_to_pfn(dev, mask) + 1,
-				 max_dma_pfn + 1);
+	if (dma_to_pfn(dev, mask) < max_dma_pfn)
 		return 0;
-	}
-
 	return 1;
 }
 
-static u64 get_coherent_dma_mask(struct device *dev)
-{
-	u64 mask = (u64)DMA_BIT_MASK(32);
-
-	if (dev) {
-		mask = dev->coherent_dma_mask;
-
-		/*
-		 * Sanity check the DMA mask - it must be non-zero, and
-		 * must be able to be satisfied by a DMA allocation.
-		 */
-		if (mask == 0) {
-			dev_warn(dev, "coherent DMA mask is unset\n");
-			return 0;
-		}
-
-		if (!__dma_supported(dev, mask, true))
-			return 0;
-	}
-
-	return mask;
-}
-
 static void __dma_clear_buffer(struct page *page, size_t size, int coherent_flag)
 {
 	/*
@@ -688,7 +658,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 			 gfp_t gfp, pgprot_t prot, bool is_coherent,
 			 unsigned long attrs, const void *caller)
 {
-	u64 mask = get_coherent_dma_mask(dev);
+	u64 mask = dev->coherent_dma_mask;
 	struct page *page = NULL;
 	void *addr;
 	bool allowblock, cma;
@@ -712,9 +682,6 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	}
 #endif
 
-	if (!mask)
-		return NULL;
-
 	buf = kzalloc(sizeof(*buf),
 		      gfp & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM));
 	if (!buf)
@@ -1095,7 +1062,7 @@ void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
  */
 int arm_dma_supported(struct device *dev, u64 mask)
 {
-	return __dma_supported(dev, mask, false);
+	return __dma_supported(dev, mask);
 }
 
 static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
