Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C830C432BE
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 05:00:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D562560295
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 05:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D562560295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B801C60616;
	Mon, 30 Aug 2021 05:00:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pfbax73jWES2; Mon, 30 Aug 2021 05:00:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F96260755;
	Mon, 30 Aug 2021 05:00:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA09C0010;
	Mon, 30 Aug 2021 05:00:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D044C000E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 05:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED43E4043E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 05:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iCVFJS0vYxP for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 05:00:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E86340426
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 05:00:42 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id j1so8631708pjv.3
 for <iommu@lists.linux-foundation.org>; Sun, 29 Aug 2021 22:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/VS4mvo3sV1dyJzQfdauWA5TTO+Tom8rl19Tszwo+xo=;
 b=anQ0zN7j+GJcEuaUBLLQmwHIVBH60mpnps17q81PSlJdxmIwWgErHTJ1KHG1dkLr45
 ANsJgtQM8xdy4QcNl4vsCcEJn8xww1p2fhaIBC73GtlX5oc2QBdSaieXOGnivPh/UOHT
 fe/f77MY9HPvk1d7O3qj8aMEXLPRkNhUOzB5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/VS4mvo3sV1dyJzQfdauWA5TTO+Tom8rl19Tszwo+xo=;
 b=CeVVWhRLjSmgflyEQR3THFealcD1zOBmgNhrknm56RjbjDPbvL15Tb0Mt1Z2xo5QaM
 f1kL9Tbzapng5jWruG2mKC1pnfNUpAYsD2+ZSt3/Eqdxkby24Lr5oH/hzHdQjKhxCKTv
 vy8OI7WF1ClJ8mrMmp17PZUzZj/VU+b9RPah0sUIK6taBhAGhEC82P55AEGfydyxyDDs
 eumMi9PrQyUISHC68wqeuhSeFNC47hUBptIqSP58p3zSbxuU31eaf/97sEnV2nh/r80v
 JUunplxtuIhtHuNUdh/UQIKGXDZ68NNf+5JdNQ/1xTbbwYeWeEHpc2/jLjcHTnjbQ2jB
 PQ1Q==
X-Gm-Message-State: AOAM530ihmkZhW3XNGI0l5DSnM+1kLsjE0ir5DqEE0zJ3m8uDXpZvL95
 /Da47Zoayah1M7XZEX7SuAFSig==
X-Google-Smtp-Source: ABdhPJyx1l/gwIFaNymoiKGDrYWkTaqOD9FXeIxsFCrlnVTtHCQHfOEblXAk0c12OY9B7qcrV8H9/Q==
X-Received: by 2002:a17:90a:6b83:: with SMTP id
 w3mr24253385pjj.114.1630299638643; 
 Sun, 29 Aug 2021 22:00:38 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:28a5:1b9f:af1d:5542])
 by smtp.gmail.com with UTF8SMTPSA id d17sm13065128pfn.110.2021.08.29.22.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Aug 2021 22:00:38 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 7/7] dma-iommu: account for min_align_mask w/swiotlb
Date: Mon, 30 Aug 2021 13:59:25 +0900
Message-Id: <20210830045925.4163412-8-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
References: <20210830045925.4163412-1-stevensd@google.com>
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
index 9b8c17c3d29b..addcaa09db12 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -805,7 +805,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = size;
 	dma_addr_t iova, dma_mask = dma_get_mask(dev);
 
 	/*
@@ -814,7 +813,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 */
 	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
 		void *padding_start;
-		size_t padding_size;
+		size_t padding_size, aligned_size;
 
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
@@ -839,7 +838,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
-- 
2.33.0.259.gc128427fd7-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
