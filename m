Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13275C433EB
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 06:57:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E7720825
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 06:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B+Kbvqdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E7720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9EB2A86BC6;
	Wed, 19 Aug 2020 06:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IXYNiE9H6fTv; Wed, 19 Aug 2020 06:57:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 43E5486B55;
	Wed, 19 Aug 2020 06:57:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BA54C0890;
	Wed, 19 Aug 2020 06:57:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D32C2C0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C18D487AFF
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:56:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DfbUlM1B4dbC for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 06:56:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 47CAC87B1D
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=t/kUI/553mQLkPn2YstRQ1uK7QcbAe6EXdXOlcFiX/o=; b=B+Kbvqduoiia1ONSXw50+AAvII
 SDCx6Q5i1wD1ezj1lsE/JQF3YbqSMgFxv6KOUYJxjYqh+96u7plrV+/YdrNpz8WDFhQW1S4H5Srxd
 /svckscBzNBWdiFRGXc2AbTzAzlrdpesdCvrY46aj8wx3UqzriA+qG5PDFJHIufcy2Szc07uAzFjB
 A9bjJtEhAaOU0mBzU+YkTgw4yRv/Y0j0IVpmaClidPQq8MFJqjPcXNDdKkAEO/BSDZFQ9pgQ7EfIo
 NG5HP1xs9rulYgK4ERUivl4xbpNxfSmTYqP8Uxwxc0Fm5HhzEwUo1cHA/Is6oiJmP0q5bUvgMU50R
 pqfWn1Xg==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I16-0008NH-FO; Wed, 19 Aug 2020 06:56:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 08/28] MIPS: make dma_sync_*_for_cpu a little less overzealous
Date: Wed, 19 Aug 2020 08:55:35 +0200
Message-Id: <20200819065555.1802761-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819065555.1802761-1-hch@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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
