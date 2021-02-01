Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6D8C433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 19:21:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494C064E97
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 19:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494C064E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1538185308;
	Mon,  1 Feb 2021 19:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A+ty7GypJ4bv; Mon,  1 Feb 2021 19:21:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6012581B6C;
	Mon,  1 Feb 2021 19:21:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E300C0FA7;
	Mon,  1 Feb 2021 19:21:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB21C013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 19:21:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8E2BC8551F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 19:21:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iDtsQjG-Z9qT for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 19:21:04 +0000 (UTC)
X-Greylist: delayed 00:29:09 by SQLgrey-1.7.6
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com
 [209.85.166.74])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E1FC384AA7
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 19:21:03 +0000 (UTC)
Received: by mail-io1-f74.google.com with SMTP id k7so12679324ioj.5
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=y6NSNhQIEZdVx/Woig+GF08BnyECPQsRFpv07tNfeBE=;
 b=XldHocSXWNUmvdcXbIrpvBTLb8nXbBn2Zduuok2rj8hE3W3V31QvgZdnPupEQPoZYP
 ETcbawsrzB76ohyeg2EXVwurYZEhXJ/VZgHEXTMjIpxXKEksDxYo6OVzRXSgYOttSMez
 fpHSpVUOfiiyl97UtYRwutY0a8N+NzpRYjiVoQnubo8dMHCinvMkqw9DLbx60CPQaKu5
 aAmM3CSeUECVn0FaX9Rvc3tsejqbDZGEniUKipSNYQ8lldAM3RhDm5KJKUols8brZ5bO
 oqQq1Ii8r1vO+vj8I+iVgBnRx/30desHgf9YzFbiYY4AtFRcgWAoeraREgbHciFMwXa2
 /f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=y6NSNhQIEZdVx/Woig+GF08BnyECPQsRFpv07tNfeBE=;
 b=OewSHow049zymNtGeZu+37gJEGvsbHbnQx9ypbuoWBZxHCWGM5Z3h5+lznvyYSdX7H
 fs2PCIZYDaWh1gBgAHtYGvO5V4PUDqE58XOdIvu+AiTIfAknVq/+rTR6AhY1D2pHXtpZ
 kVZop64dCrdjjA+GWw/obpysK7DFdrTJHYYCJ25Zysdl6B5cXRTkqo+pykkL9SRezwQl
 4NzSzajUOXBoqYbsrtq4e0ixsgTLCNvp4iDbvzKwkuNJAp8EjnzX9aqojh/xQO3LGVv1
 G8h1C5rR3wn7TfyFHv5JeTtMCqe2xcSoHZ98AtBbQQVae6KN9wsPfwCQ/J1JjLoW3pB4
 LYAw==
X-Gm-Message-State: AOAM530UggaTU9qwiOZiVDVerpLF8MURpMkFtTZHTolQ5u5WyaoHkoyA
 YN4LTOFwKQz2gSZwcue2H7BTBlba7g==
X-Google-Smtp-Source: ABdhPJyEh8WHTSX3KID/KGB0QXG7CYFZ82eK6gqBoiX6SQN2IPJo3M4LuIvQvOzXGRBAfT0DQgR6FOjGCw==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a63:5223:: with SMTP id
 g35mr18277246pgb.255.1612204225231; 
 Mon, 01 Feb 2021 10:30:25 -0800 (PST)
Date: Mon,  1 Feb 2021 10:30:16 -0800
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
Message-Id: <20210201183017.3339130-3-jxgao@google.com>
Mime-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 2/3] Add swiotlb offset preserving mapping when
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
 kernel/dma/swiotlb.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e6100..eeb640df35f3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -468,7 +468,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
 	unsigned long flags;
 	phys_addr_t tlb_addr;
-	unsigned int nslots, stride, index, wrap;
+	unsigned int nslots, stride, index, wrap, min_align_mask, page_offset;
 	int i;
 	unsigned long mask;
 	unsigned long offset_slots;
@@ -500,12 +500,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
 
+	min_align_mask = dma_get_min_align_mask(hwdev);
+	page_offset = orig_addr & min_align_mask;
+	alloc_size += page_offset;
+
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
 	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	if (alloc_size >= PAGE_SIZE)
+	if ((alloc_size >= PAGE_SIZE) || (min_align_mask > (1 << IO_TLB_SHIFT)))
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
@@ -598,7 +607,11 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	unsigned int num_page_offset_slabs;
+	unsigned int min_align_mask = dma_get_min_align_mask(hwdev);
+	int i, count;
+	int nslots = ALIGN(alloc_size + (tlb_addr & min_align_mask),
+			1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
@@ -610,6 +623,14 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
+	/*
+	 * When dma_get_min_align_mask is used, we may have padded more slabs
+	 * when padding exceeds one slab. We need to move index back to the
+	 * beginning of the padding.
+	 */
+	num_page_offset_slabs = (tlb_addr & min_align_mask) / (1 << IO_TLB_SHIFT);
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
