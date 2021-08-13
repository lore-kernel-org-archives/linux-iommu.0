Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7717BC4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 07:43:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A6F6104F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 07:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42A6F6104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A8F640771;
	Fri, 13 Aug 2021 07:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 68zEEDNHleOZ; Fri, 13 Aug 2021 07:42:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0E724012E;
	Fri, 13 Aug 2021 07:42:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA355C001A;
	Fri, 13 Aug 2021 07:42:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD325C000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F71940597
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:42:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KrzsulBS6SRJ for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 07:42:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17C49405AA
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:42:53 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 cp15-20020a17090afb8fb029017891959dcbso19498655pjb.2
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rP4GgDTu9bjAnYypJHgfqIqtEWZeT+eHGMSHhkdUgBk=;
 b=blB8YXGO2KdX/7C4bR6aPvh+DiFzKoX/53wOKBfEetogX9UNme2pP558uNaJxjgMfe
 Jo5Lmifq91NNT3S5K6N1kwM0LY4/DWTJp1KMlSHxnk9zdzND4aOsyCsYWN+H8+tfWYBX
 vsspO4ddofYYMn1ycEYWqaBEJVZorZbX0sib4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rP4GgDTu9bjAnYypJHgfqIqtEWZeT+eHGMSHhkdUgBk=;
 b=d5mMWF89Iu0McbO5NRH/NBbv1jG6KZ4WIzot8RcM8wToyqDybahMFbVcLB7m/LK4rw
 7VinlYs0CEZsKx/IQYmUlT3z6wM5TyfUqlxBuRMlhMwJpmCdBBGLmhOy3QUTXGNdIMIh
 saAyppdac41LWP8JzAKWHdwSg3pY+nqfqRewIT30a1lwpwLVfkLBR2OP8xygXzCODyQm
 0fb4cWFbVuX418JF6+P7JCR7NVwF4wLldUDW8EWu03K9N3dJGZ4imORQXJCduZ0ai3zF
 9hDiCimgnP+p2SE7a0f0ma3aFhiox4EfIFtknbH6RzAMGIbBmNeRZ9Iw08jmSxfHFZ/j
 wdXA==
X-Gm-Message-State: AOAM533CcOWoRMw72CHulFrAfbFYQzckSXU5ozwXI5EbV4/NSe8wSRLt
 wmLHShz8owKfqxx5+feWoQf9/w==
X-Google-Smtp-Source: ABdhPJzbeiCHJ9ON9og5c1patQf5Hn3FybowEOp0i22X/csxVN1yXraDjzCKBXhfMY7h3RDD23bmcg==
X-Received: by 2002:a17:90a:2e88:: with SMTP id
 r8mr1349417pjd.169.1628840572592; 
 Fri, 13 Aug 2021 00:42:52 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:cbc8:5998:527e:5f43])
 by smtp.gmail.com with UTF8SMTPSA id c2sm1195862pfi.80.2021.08.13.00.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Aug 2021 00:42:52 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 5/6] swiotlb: support aligned swiotlb buffers
Date: Fri, 13 Aug 2021 16:38:38 +0900
Message-Id: <20210813073839.1562438-6-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210813073839.1562438-1-stevensd@google.com>
References: <20210813073839.1562438-1-stevensd@google.com>
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
---
 drivers/iommu/dma-iommu.c |  4 ++--
 include/linux/swiotlb.h   |  3 ++-
 kernel/dma/swiotlb.c      | 11 +++++++----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index bad813d63ea6..b1b0327cc2f6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -801,8 +801,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		size_t padding_size;
 
 		aligned_size = iova_align(iovad, size);
-		phys = swiotlb_tbl_map_single(dev, phys, size,
-					      aligned_size, dir, attrs);
+		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
+					      iova_mask(iovad), dir, attrs);
 
 		if (phys == DMA_MAPPING_ERROR)
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
