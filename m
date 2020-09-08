Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92637C43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 16:48:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445F92080A
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IQ7sGbx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445F92080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 308A486C6C;
	Tue,  8 Sep 2020 16:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tmCJFKvtN60w; Tue,  8 Sep 2020 16:48:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A023B86C3B;
	Tue,  8 Sep 2020 16:48:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DABFC0052;
	Tue,  8 Sep 2020 16:48:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35FA6C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2EB1F86C6E
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0F2ersSc6B_q for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 16:48:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 639F286C3B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=+nOSLIs9LkSjQJt0Q5qAmk8nkbWCQbovg2Llv5RLZtk=; b=IQ7sGbx+t6W2URYGAOKZfn6yYh
 JWIo9H8+pwAdOUvhjhfUAs2ggnOgWWcNDVAkixK61nw59vUUoSHBtr8ci/p/CkiVEZdX3lqJpc6md
 jCjTOziJO4l5EWDap3Wct/xQUY+QqWAoBNMLBc8/rDE3iqX1WQZwiYECBzvVAsUQ9APLCrlkKiLlF
 6dktr7vivViBBmsenA50pIFoJ5de5v0CWB7/r84SPvhv2j5JdzZNmwn/fBawbYUvcOmD0+shnGlaO
 dEbh3gNu0J03xzwCCQtqqSTZPiAVTwKUib9PmEV3i6T6ESrjW11KLyCKDzjHow+Wrg8IsaatI+N2i
 eaa0CdKQ==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFgmm-0001Qz-8R; Tue, 08 Sep 2020 16:48:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 01/12] MIPS: make dma_sync_*_for_cpu a little less overzealous
Date: Tue,  8 Sep 2020 18:47:47 +0200
Message-Id: <20200908164758.3177341-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908164758.3177341-1-hch@lst.de>
References: <20200908164758.3177341-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
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

When transferring DMA ownership back to the CPU there should never
be any writeback from the cache, as the buffer was owned by the
device until now.  Instead it should just be invalidated for the
mapping directions where the device could have written data.
Note that the changes rely on the fact that kmap_atomic is stubbed
out for the !HIGHMEM case to simplify the code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/mm/dma-noncoherent.c | 44 +++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 563c2c0d0c8193..97a14adbafc99c 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -55,22 +55,34 @@ void *arch_dma_set_uncached(void *addr, size_t size)
 	return (void *)(__pa(addr) + UNCAC_BASE);
 }
 
-static inline void dma_sync_virt(void *addr, size_t size,
+static inline void dma_sync_virt_for_device(void *addr, size_t size,
 		enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		dma_cache_wback((unsigned long)addr, size);
 		break;
-
 	case DMA_FROM_DEVICE:
 		dma_cache_inv((unsigned long)addr, size);
 		break;
-
 	case DMA_BIDIRECTIONAL:
 		dma_cache_wback_inv((unsigned long)addr, size);
 		break;
+	default:
+		BUG();
+	}
+}
 
+static inline void dma_sync_virt_for_cpu(void *addr, size_t size,
+		enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		dma_cache_inv((unsigned long)addr, size);
+		break;
 	default:
 		BUG();
 	}
@@ -82,7 +94,7 @@ static inline void dma_sync_virt(void *addr, size_t size,
  * configured then the bulk of this loop gets optimized out.
  */
 static inline void dma_sync_phys(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
+		enum dma_data_direction dir, bool for_device)
 {
 	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
 	unsigned long offset = paddr & ~PAGE_MASK;
@@ -90,18 +102,20 @@ static inline void dma_sync_phys(phys_addr_t paddr, size_t size,
 
 	do {
 		size_t len = left;
+		void *addr;
 
 		if (PageHighMem(page)) {
-			void *addr;
-
 			if (offset + len > PAGE_SIZE)
 				len = PAGE_SIZE - offset;
+		}
+
+		addr = kmap_atomic(page);
+		if (for_device)
+			dma_sync_virt_for_device(addr + offset, len, dir);
+		else
+			dma_sync_virt_for_cpu(addr + offset, len, dir);
+		kunmap_atomic(addr);
 
-			addr = kmap_atomic(page);
-			dma_sync_virt(addr + offset, len, dir);
-			kunmap_atomic(addr);
-		} else
-			dma_sync_virt(page_address(page) + offset, size, dir);
 		offset = 0;
 		page++;
 		left -= len;
@@ -111,7 +125,7 @@ static inline void dma_sync_phys(phys_addr_t paddr, size_t size,
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	dma_sync_phys(paddr, size, dir);
+	dma_sync_phys(paddr, size, dir, true);
 }
 
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
@@ -119,16 +133,14 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
 	if (cpu_needs_post_dma_flush())
-		dma_sync_phys(paddr, size, dir);
+		dma_sync_phys(paddr, size, dir, false);
 }
 #endif
 
 void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-
-	dma_sync_virt(vaddr, size, direction);
+	dma_sync_virt_for_device(vaddr, size, direction);
 }
 
 #ifdef CONFIG_DMA_PERDEV_COHERENT
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
