Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6ABC4338F
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 10:35:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620DE60E52
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 10:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 620DE60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28F8640303;
	Fri,  6 Aug 2021 10:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n4KtrjkeMMou; Fri,  6 Aug 2021 10:35:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C1DC240201;
	Fri,  6 Aug 2021 10:35:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98F45C001A;
	Fri,  6 Aug 2021 10:35:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A02CC000E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 02E78401D7
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mqlBSS5TgjcR for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 10:34:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0395402F6
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:34:59 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id q2so6456846plr.11
 for <iommu@lists.linux-foundation.org>; Fri, 06 Aug 2021 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dVWryzKK3BUGuHjsA7PrBTq2CisXKsVGNCESDa0JHJY=;
 b=i+ObHCiNbdWFaCWmDHjcIq2KQPG8joU10Eu7eteXV24TSiPaS1Rbub6KG3Iz1w93LD
 UZhnCYyJT1BbHvFU9PKTLutsdonwwCDumd72r9fivz+M0zlDy5nDWeq4NN0gAWTSga/0
 Aqre6CHePEQ5/DhWBMKuo+Z68hdSA8nQps/eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dVWryzKK3BUGuHjsA7PrBTq2CisXKsVGNCESDa0JHJY=;
 b=ulWXp+xIQheuZOozblruFq6BV9PbPo/k2LmqAruIvfCBItBMjrHA1yUwgTTaX2QXzM
 vtamiamhdhEPM7g3nOM6S+GPo1o8WmuPhIu3I7v8xbuhyc7mqR66syVEKRukQYT1azz6
 RUfM1N+6UgSyKOW/fKlLOUz+3d36G2x4fTnu4j3yd5wZLAZllEwnY9JlTJ1cldo1lrS3
 CNgCrQYESutvAanH1b0T+rfTGLArrNZd8k1KoRME0gGOF/SApj4xSHpYqkPWfbpwqxpa
 ww0EzWEU1b0cfICIdcdZTrVqFaMUQKNunu0aWPyMxAILw08JEIAcuJ2ko2QVOYepOuBt
 TJdg==
X-Gm-Message-State: AOAM531m3vYTCLgHu1B/kZ0hx1gSFbwAw96WPYX/mKVuX2ZbtavCnVMY
 qJtyUCAAbvtZJkmVbn4fjGeEUg==
X-Google-Smtp-Source: ABdhPJww7RjX9HW2j0ug6l3+yVHu9aoDrDH3wCIKIbXjb2lpvsy26Rp+8Dm2Pcp+uMo4RnIm7f0UHQ==
X-Received: by 2002:a17:90b:21c9:: with SMTP id
 ll9mr20633253pjb.161.1628246099311; 
 Fri, 06 Aug 2021 03:34:59 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6f20:cf00:347a:afc2])
 by smtp.gmail.com with UTF8SMTPSA id q1sm10283357pfn.6.2021.08.06.03.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 03:34:58 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 1/9] Revert "iommu: Allow the dma-iommu api to use bounce
 buffers"
Date: Fri,  6 Aug 2021 19:34:15 +0900
Message-Id: <20210806103423.3341285-2-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806103423.3341285-1-stevensd@google.com>
References: <20210806103423.3341285-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
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

A new pooled bounce buffer implementation will be added to reduce IOMMU
interactions on platforms with slow IOMMUs. The new implementation can
also support using bounce buffers with untrusted devices, so the current
basic bounce buffer support can be reverted.

This reverts commit 82612d66d51d3bacdd789e31d2e875d2494b7514.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 152 ++++----------------------------------
 1 file changed, 13 insertions(+), 139 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 98ba927aee1a..1491b5450246 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,11 +20,9 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
-#include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
-#include <linux/dma-direct.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -493,23 +491,6 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
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
-	__iommu_dma_unmap(dev, dma_addr, size);
-
-	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
-}
-
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot, u64 dma_mask)
 {
@@ -536,52 +517,6 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
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
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
-	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
-		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
-	return iova;
-}
-
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -776,15 +711,11 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	if (!dev_is_dma_coherent(dev))
-		arch_sync_dma_for_cpu(phys, size, dir);
-
-	if (is_swiotlb_buffer(phys))
-		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
+	arch_sync_dma_for_cpu(phys, size, dir);
 }
 
 static void iommu_dma_sync_single_for_device(struct device *dev,
@@ -792,15 +723,11 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	if (is_swiotlb_buffer(phys))
-		swiotlb_sync_single_for_device(dev, phys, size, dir);
-
-	if (!dev_is_dma_coherent(dev))
-		arch_sync_dma_for_device(phys, size, dir);
+	arch_sync_dma_for_device(phys, size, dir);
 }
 
 static void iommu_dma_sync_sg_for_cpu(struct device *dev,
@@ -810,17 +737,11 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
-
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
-						    sg->length, dir);
-	}
+	for_each_sg(sgl, sg, nelems, i)
+		arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -830,17 +751,11 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_device(dev, sg_phys(sg),
-						       sg->length, dir);
-
-		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
-	}
+	for_each_sg(sgl, sg, nelems, i)
+		arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
@@ -849,10 +764,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
+	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
-			coherent, dir, attrs);
+	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(phys, size, dir);
@@ -864,7 +779,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
-	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
+	__iommu_dma_unmap(dev, dma_handle, size);
 }
 
 /*
@@ -942,39 +857,6 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 	}
 }
 
-static void iommu_dma_unmap_sg_swiotlb(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		__iommu_dma_unmap_swiotlb(dev, sg_dma_address(s),
-				sg_dma_len(s), dir, attrs);
-}
-
-static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		sg_dma_address(s) = __iommu_dma_map_swiotlb(dev, sg_phys(s),
-				s->length, dma_get_mask(dev),
-				dev_is_dma_coherent(dev), dir, attrs);
-		if (sg_dma_address(s) == DMA_MAPPING_ERROR)
-			goto out_unmap;
-		sg_dma_len(s) = s->length;
-	}
-
-	return nents;
-
-out_unmap:
-	iommu_dma_unmap_sg_swiotlb(dev, sg, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
-	return 0;
-}
-
 /*
  * The DMA API client is passing in a scatterlist which could describe
  * any old buffer layout, but the IOMMU API requires everything to be
@@ -1002,9 +884,6 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
-	if (dev_is_untrusted(dev))
-		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
-
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
 	 * IOVA granules for the IOMMU driver to handle. With some clever
@@ -1074,11 +953,6 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 
-	if (dev_is_untrusted(dev)) {
-		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
-		return;
-	}
-
 	/*
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
