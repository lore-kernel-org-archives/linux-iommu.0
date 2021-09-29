Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B05C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 02:33:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0D9613DB
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 02:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D0D9613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECAA782C91;
	Wed, 29 Sep 2021 02:33:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MLy-hXDnoV9E; Wed, 29 Sep 2021 02:33:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8C59D82C8E;
	Wed, 29 Sep 2021 02:33:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D85FC0011;
	Wed, 29 Sep 2021 02:33:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90BBBC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72ABD4028D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VYGte5EYTvSG for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 02:33:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2738400BE
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:33:38 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id e7so1158257pgk.2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ncVgCXT4Z1CIhR1u88HEHYmVpIWXoD+MY9qQieZl6fM=;
 b=BnNXrs7L3mIdN4nBUghOyR1aiYFnymhBVsC3hBZb3jzWR+4uEv6x4GXD4oOmN/USYy
 pdrOMcdzx1FXbnTbDmaX2dzbnXMmafc80Lq+Qa7vHz86WpWQi7CstZVXULvxOYNLAXb2
 3NqnB3HlTxHveX784+oZREdLW9Z3IyZWxiyos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ncVgCXT4Z1CIhR1u88HEHYmVpIWXoD+MY9qQieZl6fM=;
 b=q5b6wuG4TUHbcG4dNTzGoYFJcBLwiGCCJMV/4JF2kKnTRPdv6ILZcM4lqyrRzifFbt
 pxOU5aRXKbLXaV9Kek5nwreOuLJT1Mv0zkHJwojSLB8PxU97SCwH4FIfNJEJ+SiCDcla
 eeEQNiZsmu/HeXug8qbtBkIo4+WMUCFDjwsHke6FmHFCUMLGW7PjNrWf0l/5UThgtizG
 SZYG/SMq9U8JbbID3y5490rLO7Ul4+KTYP1O93WV3Rhpmm4y22CZsuMEMdjgrzUZ+sRO
 mcl5ld8m4mZeV39oocxCGVhKq+ePlfCmBpeEzbXiQiLpWOXfIzg4IQRfuuLPVh/3JX3n
 BGAw==
X-Gm-Message-State: AOAM531jua0zZgYRiea/KVFtRkpraqe3u1iFyp8tLWluaRM/69v+uxZZ
 fZkIy8VC5NRIeTbVc7JozXXwkQ==
X-Google-Smtp-Source: ABdhPJxa5WFK6hbd7FlHUYRoJD1f7XQ8pIFVG+qn2L5VwqQEXX3JkmUoEZcxr9jOkCOYHy0n1iiPAQ==
X-Received: by 2002:a62:3606:0:b0:445:38d5:98bf with SMTP id
 d6-20020a623606000000b0044538d598bfmr1003479pfa.4.1632882818209; 
 Tue, 28 Sep 2021 19:33:38 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
 by smtp.gmail.com with UTF8SMTPSA id x19sm503568pgk.37.2021.09.28.19.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Sep 2021 19:33:37 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 7/7] dma-iommu: account for min_align_mask w/swiotlb
Date: Wed, 29 Sep 2021 11:33:00 +0900
Message-Id: <20210929023300.335969-8-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929023300.335969-1-stevensd@google.com>
References: <20210929023300.335969-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Rajat Jain <rajatja@google.com>, Will Deacon <will@kernel.org>
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

From: David Stevens <stevensd@chromium.org>

Pass the non-aligned size to __iommu_dma_map when using swiotlb bounce
buffers in iommu_dma_map_page, to account for min_align_mask.

To deal with granule alignment, __iommu_dma_map maps iova_align(size +
iova_off) bytes starting at phys - iova_off. If iommu_dma_map_page
passes aligned size when using swiotlb, then this becomes
iova_align(iova_align(orig_size) + iova_off). Normally iova_off will be
zero when using swiotlb. However, this is not the case for devices that
set min_align_mask. When iova_off is non-zero, __iommu_dma_map ends up
mapping an extra page at the end of the buffer. Beyond just being a
security issue, the extra page is not cleaned up by __iommu_dma_unmap.
This causes problems when the IOVA is reused, due to collisions in the
iommu driver.  Just passing the original size is sufficient, since
__iommu_dma_map will take care of granule alignment.

Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 289c49ead01a..342359727a59 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -806,7 +806,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = size;
 	dma_addr_t iova, dma_mask = dma_get_mask(dev);
 
 	/*
@@ -815,7 +814,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 */
 	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
 		void *padding_start;
-		size_t padding_size;
+		size_t padding_size, aligned_size;
 
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
@@ -840,7 +839,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
-- 
2.33.0.685.g46640cef36-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
