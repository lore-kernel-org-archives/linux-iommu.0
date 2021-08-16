Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190ADC4338F
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 02:59:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D112761458
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 02:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D112761458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1D1A605B0;
	Mon, 16 Aug 2021 02:59:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5iLyD1VjqCkr; Mon, 16 Aug 2021 02:59:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 51B3360602;
	Mon, 16 Aug 2021 02:59:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CAB5C001A;
	Mon, 16 Aug 2021 02:59:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E91FBC000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D90964021F
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oRnkoXKx0GHK for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 02:59:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E77A14027A
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:48 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 28-20020a17090a031cb0290178dcd8a4d1so16867547pje.0
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 19:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tBsX0MVHwtbJoJcOekTIeXMGpx0HIEfEiJde7/PcK80=;
 b=h7hFFN+jkFco/mFLULcI/bu9oY6wROBT3J9B6dCnV4361nEgGdTn0efcRxko0+2D6v
 +ZovAXQ2ehzDNqBPDf+F46Sx21AcZ7qmxyHDqtldO5Yb9WBIbgeKJJZ14xmd+K7ViagI
 va70ZypCyXFfJHdwgKlDLhyxtLfhjMgLLvc8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tBsX0MVHwtbJoJcOekTIeXMGpx0HIEfEiJde7/PcK80=;
 b=CZ4KwXSXIJmqJg7hXonE7+0G3ixj54sgadkmIgwJ+hAT/zpC3cyjLOqiguoQnSBlSu
 shFQFGJMpHVze51rQY1DNSBqSw7NRkQjUIYJW/w2/Vq1GLsfdUqid2yTYROE5hurGF8c
 ZLhHvcZhBBi4hF4XCQbuQmCY5k0xyIgXwf0H5Vjkv1xwCtIOGdjLep+RUOYjq65GPSJP
 cABkl2diGoB+pB0shDVpS5YivO+cdzMjPIG0faCYzZh/hJIfszpOCtmGLPJEy79tQSYB
 IFQCRVDEet8YmeHIL29MnueVi/Wu0oGA/K13qeKhD6lsURq88d/eLve7y4i9wTsuxG+A
 VjnA==
X-Gm-Message-State: AOAM532bKlZ8lpf4upTVJfrnJDwm38R3nWtyOJNKwhNRbWJcO7Wb0MAM
 n7SCBrea68g96FEYrDPbn0D/7A==
X-Google-Smtp-Source: ABdhPJw5kRWeiG684u2c+wwBQ/CYVAVDC86ZbvD3g80fj6ClOGygn7WMChbwv5+8yOAc/XN0hMDDIw==
X-Received: by 2002:a17:902:e891:b0:12d:97bf:b2d8 with SMTP id
 w17-20020a170902e89100b0012d97bfb2d8mr10712167plg.84.1629082788345; 
 Sun, 15 Aug 2021 19:59:48 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:17b8:f07a:2a52:317a])
 by smtp.gmail.com with UTF8SMTPSA id nl9sm7666335pjb.33.2021.08.15.19.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Aug 2021 19:59:48 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 7/7] dma-iommu: account for min_align_mask
Date: Mon, 16 Aug 2021 11:57:55 +0900
Message-Id: <20210816025755.2906695-8-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210816025755.2906695-1-stevensd@google.com>
References: <20210816025755.2906695-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Will Deacon <will@kernel.org>
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

For devices which set min_align_mask, swiotlb preserves the offset of
the original physical address within that mask. Since __iommu_dma_map
accounts for non-aligned addresses, passing a non-aligned swiotlb
address with the swiotlb aligned size results in the offset being
accounted for twice in the size passed to iommu_map_atomic. The extra
page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
that function unmaps with the correct size. This causes mapping failures
if the iova gets reused, due to collisions in the iommu page tables.

To fix this, pass the original size to __iommu_dma_map, since that
function already handles alignment.

Additionally, when swiotlb returns non-aligned addresses, there is
padding at the start of the bounce buffer that needs to be cleared.

Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b1b0327cc2f6..b44b367839c2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -788,7 +788,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = size;
 	dma_addr_t iova, dma_mask = dma_get_mask(dev);
 
 	/*
@@ -797,8 +796,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 */
 	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_use_swiotlb(dev) &&
 	    iova_offset(iovad, phys | size)) {
-		void *padding_start;
-		size_t padding_size;
+		void *tlb_start;
+		size_t aligned_size, iova_off, mapping_end_off;
 
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
@@ -807,24 +806,27 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
 
-		/* Cleanup the padding area. */
-		padding_start = phys_to_virt(phys);
-		padding_size = aligned_size;
+		iova_off = iova_offset(iovad, phys);
+		tlb_start = phys_to_virt(phys - iova_off);
 
 		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 		    (dir == DMA_TO_DEVICE ||
 		     dir == DMA_BIDIRECTIONAL)) {
-			padding_start += size;
-			padding_size -= size;
+			/* Cleanup the padding area. */
+			mapping_end_off = iova_off + size;
+			memset(tlb_start, 0, iova_off);
+			memset(tlb_start + mapping_end_off, 0,
+			       aligned_size - mapping_end_off);
+		} else {
+			/* Nothing was sync'ed, so clear the whole buffer. */
+			memset(tlb_start, 0, aligned_size);
 		}
-
-		memset(padding_start, 0, padding_size);
 	}
 
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
