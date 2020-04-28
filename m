Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E86AC83000
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 12:05:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C2B206D7
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jmyHZBy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C2B206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 16E0A8817D;
	Tue, 28 Apr 2020 12:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r5wrAzgQGBJS; Tue, 28 Apr 2020 12:05:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EB6818815D;
	Tue, 28 Apr 2020 12:05:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8BECC0889;
	Tue, 28 Apr 2020 12:05:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F321C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EC3FC88046
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gV83qSjlPXau for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 11:39:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CEE7F88058
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:39:56 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588073999; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=+B++ebBAF6JRFSA5Mk6Qhv4WL/YpE+dNWWEEO2SgL98=;
 b=jmyHZBy9Uai/sCtPieihxESA7KKRXxIQeAlygrQCUnu6ldIhagTKZGqUfBe9SPMa0rMjnAmg
 YnR3IQdCexla3GzbTdfCHcMi2nYBOCfasSixIeYWjo0/dHqtG0bX5nAB21NYpSZfUItCg3l5
 VGYNdYZlb02yk2rPz9j+kfkntkU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea815fe.7fe1f216e960-smtp-out-n05;
 Tue, 28 Apr 2020 11:39:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 61659C433F2; Tue, 28 Apr 2020 11:39:41 +0000 (UTC)
Received: from blr-ubuntu-31.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DD1ABC433D2;
 Tue, 28 Apr 2020 11:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD1ABC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
 jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Subject: [PATCH 2/5] swiotlb: Allow for non-linear mapping between paddr and
 vaddr
Date: Tue, 28 Apr 2020 17:09:15 +0530
Message-Id: <1588073958-1793-3-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
X-Mailman-Approved-At: Tue, 28 Apr 2020 12:05:44 +0000
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 alex.bennee@linaro.org, vatsa@codeaurora.org, christoffer.dall@arm.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Some of the memory pool managed by swiotlb driver could fall
outside the direct-mapped range, made accessible via memremap()
routine. To facilitate easy conversion between virtual and
physical address of such memory, store the virtual address of
memory pool in addition to its physical address.

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 include/linux/swiotlb.h |  2 ++
 kernel/dma/swiotlb.c    | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 8c7843f..c634b4d 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -61,6 +61,8 @@ struct swiotlb_pool {
 
 	phys_addr_t io_tlb_start, io_tlb_end;
 
+	void *io_tlb_vstart;
+
 	/*
 	 * The number of IO TLB blocks (in groups of 64) between io_tlb_start
 	 * and io_tlb_end.  This is command line adjustable via
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9c504d3..8cf0b57 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -178,6 +178,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	default_swiotlb_pool.io_tlb_start = __pa(tlb);
 	default_swiotlb_pool.io_tlb_end =
 			default_swiotlb_pool.io_tlb_start + bytes;
+	default_swiotlb_pool.io_tlb_vstart = tlb;
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -307,6 +308,7 @@ static void swiotlb_cleanup(void)
 	default_swiotlb_pool.io_tlb_start = 0;
 	default_swiotlb_pool.io_tlb_nslabs = 0;
 	default_swiotlb_pool.max_segment = 0;
+	default_swiotlb_pool.io_tlb_vstart = NULL;
 }
 
 int
@@ -320,6 +322,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	default_swiotlb_pool.io_tlb_start = virt_to_phys(tlb);
 	default_swiotlb_pool.io_tlb_end =
 			default_swiotlb_pool.io_tlb_start + bytes;
+	default_swiotlb_pool.io_tlb_vstart = tlb;
 
 	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	memset(tlb, 0, bytes);
@@ -400,11 +403,10 @@ void __init swiotlb_exit(void)
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
-static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
+static void swiotlb_bounce(phys_addr_t orig_addr, void *vaddr,
 			   size_t size, enum dma_data_direction dir)
 {
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = phys_to_virt(tlb_addr);
 
 	if (PageHighMem(pfn_to_page(pfn))) {
 		/* The buffer does not have a mapping.  Map it in and copy */
@@ -437,6 +439,11 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 	}
 }
 
+static inline void *tlb_vaddr(struct swiotlb_pool *pool, phys_addr_t tlb_addr)
+{
+	return pool->io_tlb_vstart + (tlb_addr - pool->io_tlb_start);
+}
+
 phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
 				   struct device *hwdev,
 				   dma_addr_t tbl_dma_addr,
@@ -569,7 +576,7 @@ phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
 						(i << IO_TLB_SHIFT);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_addr,
+		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
 					mapping_size, DMA_TO_DEVICE);
 
 	return tlb_addr;
@@ -594,7 +601,8 @@ void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
 	if (orig_addr != INVALID_PHYS_ADDR &&
 	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
+						mapping_size, DMA_FROM_DEVICE);
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -643,14 +651,14 @@ void _swiotlb_tbl_sync_single(struct swiotlb_pool *pool,
 	switch (target) {
 	case SYNC_FOR_CPU:
 		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-			swiotlb_bounce(orig_addr, tlb_addr,
+			swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
 				       size, DMA_FROM_DEVICE);
 		else
 			BUG_ON(dir != DMA_TO_DEVICE);
 		break;
 	case SYNC_FOR_DEVICE:
 		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-			swiotlb_bounce(orig_addr, tlb_addr,
+			swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
 				       size, DMA_TO_DEVICE);
 		else
 			BUG_ON(dir != DMA_FROM_DEVICE);
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
