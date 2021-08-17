Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B04C4320A
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 01:39:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B7660EAF
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 01:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4B7660EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C554F814B1;
	Tue, 17 Aug 2021 01:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hObmnM2oXN8c; Tue, 17 Aug 2021 01:39:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D8F6E81501;
	Tue, 17 Aug 2021 01:39:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B69ADC001A;
	Tue, 17 Aug 2021 01:39:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71F53C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F49B40272
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id laACxQ7xs3Dz for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 01:39:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80689401C8
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:42 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id e19so22863865pla.10
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 18:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q9XB86DIe6440U7Wgn53Q54Y7DGoSwATnF9snUA3Icc=;
 b=TuSFkK3uO0HniVv/r5ufTbTIiD3OJgHt1f5UO/HGLUtUckfYJ+OPELuyBrA+OqWjo5
 CyOGnh5lvCuk0t1/E7DOv3nPDLz/1cpWnAZ5EEoQTgniXPH2/FQN3LG/rjbw7JveSUv4
 hdmmaxvK2Vnh+6DRY8Q/a+PxkU2Xz2m9P4xSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q9XB86DIe6440U7Wgn53Q54Y7DGoSwATnF9snUA3Icc=;
 b=eEEL1Us7zjMwp0lfPkVm10Ju74NdrXYqVFNfW2HvZYXNtw/hjzqWhjmK/VmAPYPIWS
 TsexjBRpbtwvKT+LcXbz62rqkpJ5iUAt7GniJz+e9jezJjhDG2aezSleeaqRS84eHw8E
 W2t7ZPLL0dduITZURl2Zt0OnEJGdpnu4MeqZHA4AKt0738DA/kq1sc3ttGCVoqK26hQ+
 LRcgajeRGrkkQhNXyyLK40Agu+MlELdVXXWUH46Cx5QblKy1cIVyO8PklKoLND7I2Liq
 JpghgY9sLX9MtAz8SY3m+D2zIOLMUTF4+sDNurqsjjiVcfsmJfQxtafXyTVODdmuWz4U
 4gmA==
X-Gm-Message-State: AOAM533f9979DtQjmVXXbnFf0ZknjODws+u4VtSNQ1pIPmd+jxgR4+gn
 1Ku6zsBAT+PE45itWBON3KhgJw==
X-Google-Smtp-Source: ABdhPJziVMZGAz3+/7NmsxzmGWn1PVMenahFvVaOfrANZvx0kOhStJye2gVjIh1y+8PDzwytb9iAwg==
X-Received: by 2002:a17:90a:cf8e:: with SMTP id
 i14mr870389pju.136.1629164382105; 
 Mon, 16 Aug 2021 18:39:42 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6864:767c:2ff8:749d])
 by smtp.gmail.com with UTF8SMTPSA id l14sm331970pjq.13.2021.08.16.18.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Aug 2021 18:39:41 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 7/7] dma-iommu: account for min_align_mask
Date: Tue, 17 Aug 2021 10:38:52 +0900
Message-Id: <20210817013852.3222824-8-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210817013852.3222824-1-stevensd@google.com>
References: <20210817013852.3222824-1-stevensd@google.com>
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
index 6738420fc081..f2fb360c2907 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -788,7 +788,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = size;
 	dma_addr_t iova, dma_mask = dma_get_mask(dev);
 
 	/*
@@ -796,8 +795,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 * page aligned, we don't need to use a bounce page.
 	 */
 	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
-		void *padding_start;
-		size_t padding_size;
+		void *tlb_start;
+		size_t aligned_size, iova_off, mapping_end_off;
 
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
@@ -806,23 +805,26 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
 
-		/* Cleanup the padding area. */
-		padding_start = phys_to_virt(phys);
-		padding_size = aligned_size;
+		iova_off = iova_offset(iovad, phys);
+		tlb_start = phys_to_virt(phys - iova_off);
 
 		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 		    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
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
