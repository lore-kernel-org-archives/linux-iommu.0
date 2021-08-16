Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9295FC4338F
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 02:59:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFD96140B
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 02:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4BFD96140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B5DA6062F;
	Mon, 16 Aug 2021 02:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gPsO03DkRnMT; Mon, 16 Aug 2021 02:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B0155605B0;
	Mon, 16 Aug 2021 02:59:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F7BDC001A;
	Mon, 16 Aug 2021 02:59:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D461BC000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDAEB40012
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AdCmqaP0hFrk for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 02:59:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C526040204
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:37 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id q2so19175715plr.11
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5As/V4f+0am36FOl0SodjRRhXjFKVt0DU7SUbqZvWtw=;
 b=IaZIFfxDzmXMKgfAzeBEh/e9caVHk1x+4fnIviZP/wjeof5ZoT6hS221lgrRdMUbPU
 yv67EwgzDsVdjQNbt9mOKFpC/zvGXnPyQRDHPIt4J7QcGiLdCgj46gO/Y2ELJRJiyHrf
 adUij3HkMMWus94bEeRwXvfw6XuRGHwo6+DYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5As/V4f+0am36FOl0SodjRRhXjFKVt0DU7SUbqZvWtw=;
 b=DlYqN15K0TjMsJ7PzBJJ9vgo9JVQDn0dpHJ4+I1yVsPc7SbzS9rlMSqggys1TpdzL0
 QJqCqu3ZyUBpIYQrCunKhkPc3KpM6YEapBKIzyZNbCB7DM2f9FqiX2xxJ71R5egPnhG6
 6AZ6WdGIsqZyVtodiyOdykX3opzhxWLz7Ts9geDQgQQlwFMvM6PRgs76CUGleZ2jgJas
 7KE4qlTrxDC4eDvZZohz0Jg9PrBNv0DLD2EnoypS7ZK6ekYHp++ghMXp5CtlsZvCP9+P
 dkQiiOAsI/m/mvT+nUlXWWy8Hi0ABlrI6Jzy9hiLEeREc+Cbe6Bd5JU+77ZNdO27aR4/
 lxFw==
X-Gm-Message-State: AOAM531Zueg8uHCSV8iCcw2diybJoeVndQdiO+zGtarcYVC3Ga0SkbAU
 +RM461QDMl9IHt1nB7Qy5iZ9dQ==
X-Google-Smtp-Source: ABdhPJyxOdLjfVnwMQrkAjueCoGy5//425bOYBWSR3MUY7I3gaBGfQlkSW/4SqNyxn+hgLPlCG/hxQ==
X-Received: by 2002:a05:6a00:1796:b029:3c4:25d6:9ee1 with SMTP id
 s22-20020a056a001796b02903c425d69ee1mr14141512pfg.21.1629082777241; 
 Sun, 15 Aug 2021 19:59:37 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:17b8:f07a:2a52:317a])
 by smtp.gmail.com with UTF8SMTPSA id y23sm9658650pfb.130.2021.08.15.19.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Aug 2021 19:59:37 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 4/7] dma-iommu: fold _swiotlb helpers into callers
Date: Mon, 16 Aug 2021 11:57:52 +0900
Message-Id: <20210816025755.2906695-5-stevensd@google.com>
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

Fold the _swiotlb helper functions into the respective _page functions,
since recent fixes have moved all logic from the _page functions to the
_swiotlb functions.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 136 +++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 76 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5dd2c517dbf5..f7da4934f7e6 100644
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
@@ -848,15 +779,69 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
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
 
-	return __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
-			coherent, dir, attrs);
+		aligned_size = iova_align(iovad, size);
+		phys = swiotlb_tbl_map_single(dev, phys, size,
+					      aligned_size, dir, attrs);
+
+		if (phys == DMA_MAPPING_ERROR)
+			return DMA_MAPPING_ERROR;
+
+		/* Cleanup the padding area. */
+		padding_start = phys_to_virt(phys);
+		padding_size = aligned_size;
+
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		    (dir == DMA_TO_DEVICE ||
+		     dir == DMA_BIDIRECTIONAL)) {
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
@@ -941,7 +926,7 @@ static void iommu_dma_unmap_sg_swiotlb(struct device *dev, struct scatterlist *s
 	int i;
 
 	for_each_sg(sg, s, nents, i)
-		__iommu_dma_unmap_swiotlb(dev, sg_dma_address(s),
+		iommu_dma_unmap_page(dev, sg_dma_address(s),
 				sg_dma_len(s), dir, attrs);
 }
 
@@ -952,9 +937,8 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
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
