Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0803C4332F
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE966135E
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AE966135E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C63660B10;
	Thu, 11 Nov 2021 06:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MMX5HbXERGpa; Thu, 11 Nov 2021 06:50:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4269160799;
	Thu, 11 Nov 2021 06:50:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53E27C003F;
	Thu, 11 Nov 2021 06:50:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0909AC001E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC168404F8
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ospcPQfiz79c for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CF56404DF
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=RdlvmsrIJWeG3RKIKS/n4xvVyfH3Wxerr72mRLMT6nc=; b=R1HXI+azkAN9v3rjNPK3EHIPfz
 LB2FwFeFBGEJ/U+bsMUIb3PDQaGuH7BN/PaXNrU5VR82NKUe76jQdfWQnaD2VnBJ3zBAWYjQYqt3z
 FrD+EuEL4etXLtT4YIYPSUXbdVSbCQWvFggBE54hGvQpJQaPamUF3gHnp54XOx/rYgUB52pKJlwrI
 /hMugsVoLvHMCcdk4p24hGK5rNfmTCHldTNMRLDN0yhOASUdZyewFB1xK2DZARa+33sWkJqRDdD7y
 upZ14eFYdEYF78Z6eVsUcyfUyg+YZrlWU85eO/DXTznij8iDbmVB7uhlUZqukIcISTZcbbBeCXsuY
 AkAp9cng==;
Received: from [2001:4bb8:19a:7ee7:dc25:8b64:278b:ff22] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml3uz-002Vyq-Ck; Thu, 11 Nov 2021 06:50:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 10/11] dma-direct: factor the swiotlb code out of
 __dma_direct_alloc_pages
Date: Thu, 11 Nov 2021 07:50:26 +0100
Message-Id: <20211111065028.32761-11-hch@lst.de>
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

Add a new helper to deal with the swiotlb case.  This keeps the code
nicely boundled and removes the not required call to
dma_direct_optimal_gfp_mask for the swiotlb case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/direct.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index cf75bfb2f499e..924937c54e8ab 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -102,6 +102,18 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
 	dma_free_contiguous(dev, page, size);
 }
 
+static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
+{
+	struct page *page = swiotlb_alloc(dev, size);
+
+	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+		swiotlb_free(dev, page, size);
+		return NULL;
+	}
+
+	return page;
+}
+
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp)
 {
@@ -111,17 +123,11 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
+	if (is_swiotlb_for_alloc(dev))
+		return dma_direct_alloc_swiotlb(dev, size);
+
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
-	if (is_swiotlb_for_alloc(dev)) {
-		page = swiotlb_alloc(dev, size);
-		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-			__dma_direct_free_pages(dev, page, size);
-			return NULL;
-		}
-		return page;
-	}
-
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, size);
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
