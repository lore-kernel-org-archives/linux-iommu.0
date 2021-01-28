Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08DBC433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 01:02:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DE864DD8
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 01:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DE864DD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B199086448;
	Thu, 28 Jan 2021 01:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qT0GFEvqP02F; Thu, 28 Jan 2021 01:02:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2DF8E8626B;
	Thu, 28 Jan 2021 01:02:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DAFDC08A1;
	Thu, 28 Jan 2021 01:02:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20AC8C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 01:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0DEAF86448
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 01:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uNNaGxQejOmQ for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 01:02:03 +0000 (UTC)
X-Greylist: delayed 00:16:29 by SQLgrey-1.7.6
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com
 [209.85.167.201])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 66DB48626B
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 01:02:03 +0000 (UTC)
Received: by mail-oi1-f201.google.com with SMTP id z140so1671393oia.12
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 17:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=qnjnlmt/aDtctSbauuE/youvqobwVlPzhUiWyRCjmfE=;
 b=qJxdZcF/2iL7L7BpzsbCYhi4F1nBavg4WlPlFpgXDOY5JnypjMuB5Jl8F1glrX+A4C
 n5cFVsxGI6pfe/w0G7OBYdhPN9oZnZgnLpywUZwj5ri8PaSP2OWVp0agQOBxmWy3mIvz
 KSFd69aDCb0KQBfTmnJ62PQ3um4VDyswVGzu5SPQyhwapIATIv82EijymGjd/0268xT2
 wv/zpLEU0J95cFOqUQnbGni/pwRmqfy6nQ96Wx3eJcvOVyYCLU49ayvU8D/1YZcpSmEQ
 cQVhVPIIf6skPQ09HLkASCP/JwRrVQzdGPjF5JYdynrGeqJ4Xp2kxKWvkcG5Zs6dpAi0
 huSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=qnjnlmt/aDtctSbauuE/youvqobwVlPzhUiWyRCjmfE=;
 b=NuHivkP745hW/lQArDZA+tGvJNQKrP5sok1Aso9d/frLGp4IqRiEYSko017GgKZdvg
 v+l0oTY7C9NnGzpPYQhit4GagwdRUTjbzQcwHD8T2h/mHEXFs8O+dbODqbVb1pKGo2EO
 MH0SyEyNdhRT111GHkDvQuXwoLmv3pw/myxVIJpc4BNi2nAGng/oFlcChTjZeYyNepDV
 T8kHnzblfwORKSunLaPXq2iIcBWjvRLdHwbHPYRjW97Ruv0C9kWQTSfUxkVDGQ6/YtQi
 Pb4eE7obiM4SRDd9ZlQNbfLJUzABMYOd9kSvEoo7ccnsX3liS2vWvLaNDkTiQtaUJgIT
 4Jkw==
X-Gm-Message-State: AOAM5315bZJSKfW/qw1GlxMZ+LhsMF4Twf31k1E9qTtkpUisQ29ymbT+
 i7D6aPAZTpcPnTsGC/EJnPxksKNQpQ==
X-Google-Smtp-Source: ABdhPJxItXQ1+mD1tytZkMFhh6fWETP78nnpd+zRsRgJzoZEVagoHzp8VktIvxmKZTm1x9AHDy922qsZ4Q==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a17:90a:d181:: with SMTP id
 fu1mr8266312pjb.188.1611794325104; Wed, 27 Jan 2021 16:38:45 -0800 (PST)
Date: Wed, 27 Jan 2021 16:38:28 -0800
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
Message-Id: <20210128003829.1892018-3-jxgao@google.com>
Mime-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 2/3] Add swiotlb offset preserving mapping when
 dma_dma_parameters->page_offset_mask is non zero.
To: jxgao@google.com, erdemaktas@google.com, marcorr@google.com, hch@lst.de, 
 m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org,
 saravanak@google.com, heikki.krogerus@linux.intel.com, 
 rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
 dan.j.williams@intel.com, bgolaszewski@baylibre.com, jroedel@suse.de, 
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org, 
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

For devices that need to preserve address offset on mapping through
swiotlb, this patch adds offset preserving based on page_offset_mask
and keeps the offset if the mask is non zero. This is needed for
device drivers like NVMe.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 kernel/dma/swiotlb.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e6100..4cab35f2c9bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -468,7 +468,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
 	unsigned long flags;
 	phys_addr_t tlb_addr;
-	unsigned int nslots, stride, index, wrap;
+	unsigned int nslots, stride, index, wrap, page_offset_mask, page_offset;
 	int i;
 	unsigned long mask;
 	unsigned long offset_slots;
@@ -500,12 +500,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
 
+	page_offset_mask = dma_get_page_offset_mask(hwdev);
+	page_offset = orig_addr & page_offset_mask;
+	alloc_size += page_offset;
+
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
 	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	if (alloc_size >= PAGE_SIZE)
+	if ((alloc_size >= PAGE_SIZE) || (page_offset_mask > (1 << IO_TLB_SHIFT)))
 		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
 	else
 		stride = 1;
@@ -583,6 +587,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+	/*
+	 * When keeping the offset of the original data, we need to advance
+	 * the tlb_addr by the offset of orig_addr.
+	 */
+	tlb_addr += page_offset;
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
@@ -598,7 +607,9 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	unsigned int num_page_offset_slabs, page_offset_mask = dma_get_page_offset_mask(hwdev);
+	int i, count;
+	int nslots = ALIGN(alloc_size + tlb_addr & page_offset_mask, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
@@ -610,6 +621,14 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
+	/*
+	 * When dma_get_page_offset_mask is used, we may have padded more slabs
+	 * when padding exceeds one slab. We need to move index back to the
+	 * beginning of the padding.
+	 */
+	num_page_offset_slabs =  (tlb_addr & page_offset_mask) / (1 << IO_TLB_SHIFT);
+	index -= num_page_offset_slabs;
+
 	/*
 	 * Return the buffer to the free list by setting the corresponding
 	 * entries to indicate the number of contiguous entries available.
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
