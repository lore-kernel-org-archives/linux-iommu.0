Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C146C433FE
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3ABC6128E
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3ABC6128E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1104400FB;
	Thu, 11 Nov 2021 06:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BrMA1kN6Ye5X; Thu, 11 Nov 2021 06:50:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 78D6D40444;
	Thu, 11 Nov 2021 06:50:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16583C0037;
	Thu, 11 Nov 2021 06:50:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8433C001E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B999060B18
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sjlTCGhIFe0S for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EFE62605CD
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=C/rEDlQYs5pWgZwCXstr4mvKdMQeleFzK/cXEu2MnQY=; b=Iu8jAk8BX+VCYiBzi3HTjj/fSi
 baI+3IEH6U1hizGv4dzrmcvFxyyXDZq73ABmAcSGagM1LzAf7ICzGE3xLjeThRxXmqeNjcHutuLPk
 oymLDaCWMVMBp8AFIjz88TmBM8wC3SxmNnNY4VJumDfdsJKomiW/Rx27UmdvBbku3JFrNwzMYUedu
 mJXr+FWPkIdUPdpJAPJtuSw6Jp4Vg6w/wYt1XIr92l7ilDuY1nligFuqJ9X4xtQM9jtQgq1VSB5jt
 7lFIxVNpvCEGQ0bcTYLNrLrfjpJR2kqMNZUv1Fv5zzALhDzYo1H+vUbOoiBHZ9dfKyoE+22GTaC/k
 24eORscA==;
Received: from [2001:4bb8:19a:7ee7:dc25:8b64:278b:ff22] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml3uy-002VyQ-3i; Thu, 11 Nov 2021 06:50:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 09/11] dma-direct: drop two CONFIG_DMA_RESTRICTED_POOL
 conditionals
Date: Thu, 11 Nov 2021 07:50:25 +0100
Message-Id: <20211111065028.32761-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111065028.32761-1-hch@lst.de>
References: <20211111065028.32761-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/direct.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 84226a764471b..cf75bfb2f499e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -97,8 +97,7 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 static void __dma_direct_free_pages(struct device *dev, struct page *page,
 				    size_t size)
 {
-	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
-	    swiotlb_free(dev, page, size))
+	if (swiotlb_free(dev, page, size))
 		return;
 	dma_free_contiguous(dev, page, size);
 }
@@ -114,8 +113,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
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
