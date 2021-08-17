Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1F5C4320E
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 01:39:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616E860E90
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 01:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 616E860E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 427E460A44;
	Tue, 17 Aug 2021 01:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8OKpa6tKAHxm; Tue, 17 Aug 2021 01:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B742608AE;
	Tue, 17 Aug 2021 01:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28F99C001A;
	Tue, 17 Aug 2021 01:39:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BC2DC000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F3AF40181
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BI7_HRiMaM00 for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 01:39:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D96D401F2
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:30 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id a5so22861751plh.5
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 18:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XmLa4Egl3RbFTsKEXycierEXGblZ1yb/jiV30ninE4M=;
 b=lTDp8WDVyXsFHl09LsAoHKc2Z1SB9SzRnrxlTirBJb6Ym4k+5OfHh9EXZhMBxBI6sT
 pHsBVeywg3B28Gz7N4T52B2eg2SN4DaXyKRw+u26EiTlCUa9uNthg7CV4zqKirnYRy1m
 xeVl0I3lFTQA+vNQ+9OQnf0rzNJnaE35zT7Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XmLa4Egl3RbFTsKEXycierEXGblZ1yb/jiV30ninE4M=;
 b=IndSCgasKmAsGgXZdmrjv67e+cKDm5PcDpDTHRvFTgG4z63vNZCiiN/5luS1eP93qE
 KkKyL/063EDyiOE6Q/K59R6GT6bocXu4M8wp4DF5XxvZXBIkrDjwumqWazEuAKCNsbGK
 tQUkjELe57Dj5nDoCDulHWtIIW3tiEU/RxcKg9vKDE20xfX2A2CMP/eO6wQAFKjp7Nrs
 Lcsw1VruU64Xg2Q5AwZZcRv3jWA8P2qKqRPQ5KsX/zaKBA/yzeuzevIQGtyf/cLBdYfH
 x8HYEi8L93qJz3ymdgTrZW8eoGzwhGrX4iB15174RJTbnVwhU6ep/DTDkFKQkRTj0x4c
 vTzg==
X-Gm-Message-State: AOAM530RaNX8lcFCIPrc98TmNncdGdZyZsvIWNJmPd1st6z+Q2cB03j2
 FcLDH/8qXP+PoXRB8veXM8tdHlWWsIiHCg==
X-Google-Smtp-Source: ABdhPJzO8Pkg7iwRbKibF0YiFTc9E/F750IMRqiD4s4iG9IPu2fAnmP27oNdodJHqUu900p4/lR3PQ==
X-Received: by 2002:a63:4245:: with SMTP id p66mr979599pga.402.1629164369872; 
 Mon, 16 Aug 2021 18:39:29 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6864:767c:2ff8:749d])
 by smtp.gmail.com with UTF8SMTPSA id y23sm468518pgf.38.2021.08.16.18.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Aug 2021 18:39:29 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 4/7] dma-iommu: fold _swiotlb helpers into callers
Date: Tue, 17 Aug 2021 10:38:49 +0900
Message-Id: <20210817013852.3222824-5-stevensd@google.com>
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

Fold the _swiotlb helper functions into the respective _page functions,
since recent fixes have moved all logic from the _page functions to the
_swiotlb functions.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 135 +++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 76 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5dd2c517dbf5..8152efada8b2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -493,26 +493,6 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
-static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
-	phys_addr_t phys;
-
-	phys = iommu_iova_to_phys(domain, dma_addr);
-	if (WARN_ON(!phys))
-		return;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
-		arch_sync_dma_for_cpu(phys, size, dir);
-
-	__iommu_dma_unmap(dev, dma_addr, size);
-
-	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
-}
-
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot, u64 dma_mask)
 {
@@ -539,55 +519,6 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	return iova + iova_off;
 }
 
-static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
-		size_t org_size, dma_addr_t dma_mask, bool coherent,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	int prot = dma_info_to_prot(dir, coherent, attrs);
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = org_size;
-	void *padding_start;
-	size_t padding_size;
-	dma_addr_t iova;
-
-	/*
-	 * If both the physical buffer start address and size are
-	 * page aligned, we don't need to use a bounce page.
-	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
-	    iova_offset(iovad, phys | org_size)) {
-		aligned_size = iova_align(iovad, org_size);
-		phys = swiotlb_tbl_map_single(dev, phys, org_size,
-					      aligned_size, dir, attrs);
-
-		if (phys == DMA_MAPPING_ERROR)
-			return DMA_MAPPING_ERROR;
-
-		/* Cleanup the padding area. */
-		padding_start = phys_to_virt(phys);
-		padding_size = aligned_size;
-
-		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-		    (dir == DMA_TO_DEVICE ||
-		     dir == DMA_BIDIRECTIONAL)) {
-			padding_start += org_size;
-			padding_size -= org_size;
-		}
-
-		memset(padding_start, 0, padding_size);
-	}
-
-	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(phys, org_size, dir);
-
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
-	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
-		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
-	return iova;
-}
-
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -848,15 +779,68 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
+	int prot = dma_info_to_prot(dir, coherent, attrs);
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	size_t aligned_size = size;
+	dma_addr_t iova, dma_mask = dma_get_mask(dev);
+
+	/*
+	 * If both the physical buffer start address and size are
+	 * page aligned, we don't need to use a bounce page.
+	 */
+	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
+	    iova_offset(iovad, phys | size)) {
+		void *padding_start;
+		size_t padding_size;
+
+		aligned_size = iova_align(iovad, size);
+		phys = swiotlb_tbl_map_single(dev, phys, size,
+					      aligned_size, dir, attrs);
+
+		if (phys == DMA_MAPPING_ERROR)
+			return DMA_MAPPING_ERROR;
 
-	return __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
-			coherent, dir, attrs);
+		/* Cleanup the padding area. */
+		padding_start = phys_to_virt(phys);
+		padding_size = aligned_size;
+
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
+			padding_start += size;
+			padding_size -= size;
+		}
+
+		memset(padding_start, 0, padding_size);
+	}
+
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, size, dir);
+
+	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
+		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+	return iova;
 }
 
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	phys_addr_t phys;
+
+	phys = iommu_iova_to_phys(domain, dma_handle);
+	if (WARN_ON(!phys))
+		return;
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu(phys, size, dir);
+
+	__iommu_dma_unmap(dev, dma_handle, size);
+
+	if (unlikely(is_swiotlb_buffer(phys)))
+		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 }
 
 /*
@@ -941,7 +925,7 @@ static void iommu_dma_unmap_sg_swiotlb(struct device *dev, struct scatterlist *s
 	int i;
 
 	for_each_sg(sg, s, nents, i)
-		__iommu_dma_unmap_swiotlb(dev, sg_dma_address(s),
+		iommu_dma_unmap_page(dev, sg_dma_address(s),
 				sg_dma_len(s), dir, attrs);
 }
 
@@ -952,9 +936,8 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		sg_dma_address(s) = __iommu_dma_map_swiotlb(dev, sg_phys(s),
-				s->length, dma_get_mask(dev),
-				dev_is_dma_coherent(dev), dir, attrs);
+		sg_dma_address(s) = iommu_dma_map_page(dev, sg_page(s),
+				s->offset, s->length, dir, attrs);
 		if (sg_dma_address(s) == DMA_MAPPING_ERROR)
 			goto out_unmap;
 		sg_dma_len(s) = s->length;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
