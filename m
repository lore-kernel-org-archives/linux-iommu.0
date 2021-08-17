Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270F3C4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 01:39:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2ECF60EAF
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 01:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2ECF60EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BDDF3402DF;
	Tue, 17 Aug 2021 01:39:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfgKqAFIrwpU; Tue, 17 Aug 2021 01:39:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B40D0402F2;
	Tue, 17 Aug 2021 01:39:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84FFCC001A;
	Tue, 17 Aug 2021 01:39:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73132C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 634EB814A9
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DlJe8PEDkdHW for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 01:39:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7BCED81053
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:38 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 mq2-20020a17090b3802b0290178911d298bso3456759pjb.1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 18:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0R67WoufU00ip9iCX9fzqxnYQeyaIOPhgbue6hEnOr0=;
 b=hGbL19jjWmHw8nAYUHXwd8NF210L0j0CKbQtv+UXtex88TvrhqprciQmwNHIS0iMmi
 5ATsVQMY0ldRD8AXbp+JAdqVjUoSp3Qy170JJ3zv01+GhaYRkC4bH/h/5IZ9LZbpWFde
 8OEVXS6yybPBAntb6tibkwpW/cQF8JVQkN3iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0R67WoufU00ip9iCX9fzqxnYQeyaIOPhgbue6hEnOr0=;
 b=UT8HkZOfhxKpDkdD6qaTQWPTrRK8J6suCV8+T0HigV7wBIKMstaKy9gLov30jZ5g9z
 0S2IqrEOuc4M8xyech62E7yluIfFiVTgy444JYGQnRGsOoDCRDB/CG+Sgn5HnHXP2pgC
 VYJOYuStyTRcnXcSHdxy9N4f1IjPk4ChLUuhWSLP4y34948VKV6fFi3wGMGaHUaZkCxe
 Rv8M1RYaYbbqNrvMRGvd+gZpEMjqdlyZYyAarZ3jAW5SqkoeksiXkHV2hF22EXLdmEuf
 rhUOhvNxnTPW0al69MF1/OSR9ThJ92BPR4zjiIbBnG9syB08KSZNxe0oCqsAgDKGDDhn
 H7Mw==
X-Gm-Message-State: AOAM532YpzycDxpv8clqhvcE0Ra440tAnDzfgEo3OXcR3UYGzM+eB02w
 otOkqDUledq5u2ZQ1TNGxFDlqwKAQh/k4A==
X-Google-Smtp-Source: ABdhPJxqX+LI3ZSz4m1ilBWiZC/jnwEdxFfgdFtzgOBP3X9Efe+6cVPmEmAjX7fu7rj8hhh9X5GUJQ==
X-Received: by 2002:a63:480a:: with SMTP id v10mr958746pga.113.1629164378063; 
 Mon, 16 Aug 2021 18:39:38 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6864:767c:2ff8:749d])
 by smtp.gmail.com with UTF8SMTPSA id t38sm394013pfg.207.2021.08.16.18.39.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Aug 2021 18:39:37 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 6/7] swiotlb: support aligned swiotlb buffers
Date: Tue, 17 Aug 2021 10:38:51 +0900
Message-Id: <20210817013852.3222824-7-stevensd@google.com>
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

Add an argument to swiotlb_tbl_map_single that specifies the desired
alignment of the allocated buffer. This is used by dma-iommu to ensure
the buffer is aligned to the iova granule size when using swiotlb with
untrusted sub-granule mappings. This addresses an issue where adjacent
slots could be exposed to the untrusted device if IO_TLB_SIZE < iova
granule < PAGE_SIZE.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c |  4 ++--
 drivers/xen/swiotlb-xen.c |  2 +-
 include/linux/swiotlb.h   |  3 ++-
 kernel/dma/swiotlb.c      | 11 +++++++----
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 49a0d4de5f6c..6738420fc081 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -800,8 +800,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		size_t padding_size;
 
 		aligned_size = iova_align(iovad, size);
-		phys = swiotlb_tbl_map_single(dev, phys, size,
-					      aligned_size, dir, attrs);
+		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
+					      iova_mask(iovad), dir, attrs);
 
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 24d11861ac7d..8b03d2c93428 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -382,7 +382,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
 
-	map = swiotlb_tbl_map_single(dev, phys, size, size, dir, attrs);
+	map = swiotlb_tbl_map_single(dev, phys, size, size, 0, dir, attrs);
 	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 216854a5e513..93d82e43eb3a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -44,7 +44,8 @@ extern void __init swiotlb_update_mem_attributes(void);
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
 		size_t mapping_size, size_t alloc_size,
-		enum dma_data_direction dir, unsigned long attrs);
+		unsigned int alloc_aligned_mask, enum dma_data_direction dir,
+		unsigned long attrs);
 
 extern void swiotlb_tbl_unmap_single(struct device *hwdev,
 				     phys_addr_t tlb_addr,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e50df8d8f87e..d4c45d8cd1fa 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -427,7 +427,7 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
  * allocate a buffer from that IO TLB pool.
  */
 static int find_slots(struct device *dev, phys_addr_t orig_addr,
-		size_t alloc_size)
+		size_t alloc_size, unsigned int alloc_align_mask)
 {
 	struct io_tlb_mem *mem = io_tlb_default_mem;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
@@ -450,6 +450,7 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
 	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
 	if (alloc_size >= PAGE_SIZE)
 		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
+	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
 
 	spin_lock_irqsave(&mem->lock, flags);
 	if (unlikely(nslots > mem->nslabs - mem->used))
@@ -504,7 +505,8 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
 
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
-		enum dma_data_direction dir, unsigned long attrs)
+		unsigned int alloc_align_mask, enum dma_data_direction dir,
+		unsigned long attrs)
 {
 	struct io_tlb_mem *mem = io_tlb_default_mem;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
@@ -524,7 +526,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
-	index = find_slots(dev, orig_addr, alloc_size + offset);
+	index = find_slots(dev, orig_addr,
+			   alloc_size + offset, alloc_align_mask);
 	if (index == -1) {
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
@@ -636,7 +639,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size,
 			      swiotlb_force);
 
-	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, dir,
+	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, 0, dir,
 			attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
