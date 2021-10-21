Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C960C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A8A60F56
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15A8A60F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECF9783B71;
	Thu, 21 Oct 2021 09:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iq6qT4bwvFbk; Thu, 21 Oct 2021 09:06:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E286083B3B;
	Thu, 21 Oct 2021 09:06:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE0A0C001C;
	Thu, 21 Oct 2021 09:06:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00310C0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E44B0407D5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jvvD1b-61rS5 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:06:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6ECEA407CE
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=tL678UByyN9JeCxcwTAfw/47e/4mMuEzIRqYeD6LdHw=; b=VxWT4WTtkcD7msngrFktRHRoI/
 NMVcKD++MtC2QuNr2XUD+vUO3JyHKM2JA4Wq6d3JkEtoDmGDa0+xWNofMknS5j+CAnfo2hDRP79wZ
 2lXx5TgJ1nI2saZmg1EIpqzjR9meWRQmqrMDPNjQjXekl0ixeLEATNz8Gf5IB3umXZ/lOgY4F/1CH
 pLuPXJin/ZnzStcy5NDb3H3go0AcVcApid709Gm8tEoarzjy8kEJljv0s0CXBuDagu17aEqy/NF6P
 d94yvWq+DOWV9Bki/VGExWJSqVhzkl47MtY7YjPwDs835neOQDdYnuZ3wSyp2UCd/Q1ql2fsWaQc4
 K0hb+6IQ==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdU25-006xyi-6o; Thu, 21 Oct 2021 09:06:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 08/10] dma-direct: drop two CONFIG_DMA_RESTRICTED_POOL
 conditionals
Date: Thu, 21 Oct 2021 11:06:09 +0200
Message-Id: <20211021090611.488281-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021090611.488281-1-hch@lst.de>
References: <20211021090611.488281-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Robin Murphy <robin.murphy@arm.com>, David Rientjes <rientjes@google.com>
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

swiotlb_alloc and swiotlb_free are properly stubbed out if
CONFIG_DMA_RESTRICTED_POOL is not set, so skip the extra checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 680fe10410645..f4ac2e1cdf469 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -92,8 +92,7 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 static void __dma_direct_free_pages(struct device *dev, struct page *page,
 				    size_t size)
 {
-	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
-	    swiotlb_free(dev, page, size))
+	if (swiotlb_free(dev, page, size))
 		return;
 	dma_free_contiguous(dev, page, size);
 }
@@ -109,8 +108,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
-	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
-	    is_swiotlb_for_alloc(dev)) {
+	if (is_swiotlb_for_alloc(dev)) {
 		page = swiotlb_alloc(dev, size);
 		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 			__dma_direct_free_pages(dev, page, size);
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
