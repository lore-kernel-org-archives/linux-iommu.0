Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8BCC433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 07:45:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112F964E01
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 07:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112F964E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D79F74F287;
	Mon,  1 Mar 2021 07:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Gz6-XXrIufo; Mon,  1 Mar 2021 07:45:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 872B34F289;
	Mon,  1 Mar 2021 07:45:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66101C000B;
	Mon,  1 Mar 2021 07:45:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89059C0001
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:45:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77BD060685
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:45:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7oMaFTaCCnuN for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:45:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0A0A6066B
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Ds/ACDNRu58btmZG/NqJ4lBgbf4+MYCDj5+pQ+XVzpM=; b=Woztf5KlRadzF1qDJdsaN2b6jM
 F8qWgj/k/tKZ4TYWm/AYmy26ne94IWhyXBXotmr6ZMC2165WaVQ0HTcxuOZlbeVPRgeaDbU9tPbk6
 b1+viMTPj3CMaTXoXiKCSmZ7osK63GGeshw5QNx/sYvqsaDd+dXbdEpaqbUF7xUXVaqz1aTIQ+sXB
 NgnUGMgUWy//zxAqn8O6EvVL4sb4zQrrgB8TYz0XC/mJGicpRKi4j6KyFM7g0lV1wMwCAPkPNUjoK
 59SY3DMBp5chNynkNLgir+OXDa4hEDqhRh8xvDXl/lPGZGPo5vMoG0sUo/Zfva4X8S0ufaB4hAII9
 2/ISnCMw==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGdEq-00FRBJ-Uh; Mon, 01 Mar 2021 07:45:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 03/14] swiotlb: move orig addr and size validation into
 swiotlb_bounce
Date: Mon,  1 Mar 2021 08:44:25 +0100
Message-Id: <20210301074436.919889-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210301074436.919889-1-hch@lst.de>
References: <20210301074436.919889-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, Claire Chang <tientzu@chromium.org>,
 linuxppc-dev@lists.ozlabs.org, Dongli Zhang <dongli.zhang@oracle.com>
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

Move the code to find and validate the original buffer address and size
from the callers into swiotlb_bounce.  This means a tiny bit of extra
work in the swiotlb_map path, but avoids code duplication and a leads to
a better code structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 59 +++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 03aa614565e417..a9063092f6f566 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -460,12 +460,25 @@ void __init swiotlb_exit(void)
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
-static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
-			   size_t size, enum dma_data_direction dir)
+static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
+		enum dma_data_direction dir)
 {
+	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
+	size_t alloc_size = io_tlb_alloc_size[index];
+	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = phys_to_virt(tlb_addr);
 
+	if (orig_addr == INVALID_PHYS_ADDR)
+		return;
+
+	if (size > alloc_size) {
+		dev_WARN_ONCE(dev, 1,
+			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu.\n",
+			alloc_size, size);
+		size = alloc_size;
+	}
+
 	if (PageHighMem(pfn_to_page(pfn))) {
 		/* The buffer does not have a mapping.  Map it in and copy */
 		unsigned int offset = orig_addr & ~PAGE_MASK;
@@ -644,21 +657,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	tlb_addr = slot_addr(io_tlb_start, index) + offset;
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
+		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
 	return tlb_addr;
 }
 
-static void validate_sync_size_and_truncate(struct device *hwdev, size_t alloc_size, size_t *size)
-{
-	if (*size > alloc_size) {
-		/* Warn and truncate mapping_size */
-		dev_WARN_ONCE(hwdev, 1,
-			"Attempt for buffer overflow. Original size: %zu. Mapping size: %zu.\n",
-			alloc_size, *size);
-		*size = alloc_size;
-	}
-}
-
 /*
  * tlb_addr is the physical address of the bounce buffer to unmap.
  */
@@ -669,19 +671,15 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(hwdev, tlb_addr);
 	int index = (tlb_addr - offset - io_tlb_start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = io_tlb_orig_addr[index];
-	size_t alloc_size = io_tlb_alloc_size[index];
-	int i, count, nslots = nr_slots(alloc_size + offset);
-
-	validate_sync_size_and_truncate(hwdev, alloc_size, &mapping_size);
+	int nslots = nr_slots(io_tlb_alloc_size[index] + offset);
+	int count, i;
 
 	/*
 	 * First, sync the memory before unmapping the entry
 	 */
-	if (orig_addr != INVALID_PHYS_ADDR &&
-	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
+		swiotlb_bounce(hwdev, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -721,27 +719,16 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 			     size_t size, enum dma_data_direction dir,
 			     enum dma_sync_target target)
 {
-	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
-	size_t alloc_size = io_tlb_alloc_size[index];
-	phys_addr_t orig_addr = io_tlb_orig_addr[index];
-
-	if (orig_addr == INVALID_PHYS_ADDR)
-		return;
-
-	validate_sync_size_and_truncate(hwdev, alloc_size, &size);
-
 	switch (target) {
 	case SYNC_FOR_CPU:
 		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-			swiotlb_bounce(orig_addr, tlb_addr,
-				       size, DMA_FROM_DEVICE);
+			swiotlb_bounce(hwdev, tlb_addr, size, DMA_FROM_DEVICE);
 		else
 			BUG_ON(dir != DMA_TO_DEVICE);
 		break;
 	case SYNC_FOR_DEVICE:
 		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-			swiotlb_bounce(orig_addr, tlb_addr,
-				       size, DMA_TO_DEVICE);
+			swiotlb_bounce(hwdev, tlb_addr, size, DMA_TO_DEVICE);
 		else
 			BUG_ON(dir != DMA_FROM_DEVICE);
 		break;
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
