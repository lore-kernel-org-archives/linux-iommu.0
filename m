Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DD1C433FE
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 16:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A16B8343F;
	Mon,  2 May 2022 16:43:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n_fnzxANRMrl; Mon,  2 May 2022 16:43:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B0E1783E38;
	Mon,  2 May 2022 16:43:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F615C0092;
	Mon,  2 May 2022 16:43:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16325C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39B9740A8E
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vhady335-icC for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:43:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2AA440A79
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=YRxfFpkbQsx1EUibLNYfHputvYE0bL1cCaKl4vl9ssA=; b=HSphTjn8XFThM4Rzf+Q34RfT4N
 kg/llst62oK6asnraAOiPbvtqY6slda+XJucnH46OuVyH/46EtqMxTgOIh2YELngxfRRcV4qQVp4E
 XBGBbJzSbvuw7gq5r0DFN+cv/gQxyugtTb5Y3JvXtK6lrLGGA2j0wTv9vrYGwDcROaoACNBss3e4T
 HTJgLNu6/7RBkLURiq/1uFWI1ICGijHzqEYyjBsTPBCzZp3EmL6Pth+uNWv6qz2qCNCDA/BfUgdYG
 8Gzusu6sj0dQB2Se/gPmTTvXCsMMapTcTiHH2r4Hc/toDGoKdu39jFbdV6jlmkRXcUOhl5QwLu9o5
 0FJGOb0w==;
Received: from [8.34.116.185] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlZ95-001kfN-S1; Mon, 02 May 2022 16:43:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 05/10] ARM/dma-mapping: use dma_to_phys/phys_to_dma in the
 dma-mapping code
Date: Mon,  2 May 2022 09:43:25 -0700
Message-Id: <20220502164330.229685-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502164330.229685-1-hch@lst.de>
References: <20220502164330.229685-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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

Use the helpers as expected by the dma-direct code in the old arm
dma-mapping code to ease a gradual switch to the common DMA code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/dma-mapping.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0ee5adbdd3f1d..e09d79a328fa1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -128,14 +128,14 @@ static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
 {
 	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__dma_page_cpu_to_dev(page, offset, size, dir);
-	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
+	return phys_to_dma(dev, page_to_phys(page) + offset);
 }
 
 static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     unsigned long attrs)
 {
-	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
+	return phys_to_dma(dev, page_to_phys(page) + offset);
 }
 
 /**
@@ -156,7 +156,7 @@ static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__dma_page_dev_to_cpu(pfn_to_page(dma_to_pfn(dev, handle)),
+		__dma_page_dev_to_cpu(phys_to_page(dma_to_phys(dev, handle)),
 				      handle & ~PAGE_MASK, size, dir);
 }
 
@@ -164,7 +164,7 @@ static void arm_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
 	unsigned int offset = handle & (PAGE_SIZE - 1);
-	struct page *page = pfn_to_page(dma_to_pfn(dev, handle-offset));
+	struct page *page = phys_to_page(dma_to_phys(dev, handle-offset));
 	__dma_page_dev_to_cpu(page, offset, size, dir);
 }
 
@@ -172,7 +172,7 @@ static void arm_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
 	unsigned int offset = handle & (PAGE_SIZE - 1);
-	struct page *page = pfn_to_page(dma_to_pfn(dev, handle-offset));
+	struct page *page = phys_to_page(dma_to_phys(dev, handle-offset));
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
@@ -190,7 +190,7 @@ static int arm_dma_supported(struct device *dev, u64 mask)
 	 * Translate the device's DMA mask to a PFN limit.  This
 	 * PFN number includes the page which we can DMA to.
 	 */
-	return dma_to_pfn(dev, mask) >= max_dma_pfn;
+	return PHYS_PFN(dma_to_phys(dev, mask)) >= max_dma_pfn;
 }
 
 static void __dma_clear_buffer(struct page *page, size_t size, int coherent_flag)
@@ -681,7 +681,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (page) {
 		unsigned long flags;
 
-		*handle = pfn_to_dma(dev, page_to_pfn(page));
+		*handle = phys_to_dma(dev, page_to_phys(page));
 		buf->virt = args.want_vaddr ? addr : page;
 
 		spin_lock_irqsave(&arm_dma_bufs_lock, flags);
@@ -721,7 +721,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	int ret = -ENXIO;
 	unsigned long nr_vma_pages = vma_pages(vma);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long pfn = dma_to_pfn(dev, dma_addr);
+	unsigned long pfn = PHYS_PFN(dma_to_phys(dev, dma_addr));
 	unsigned long off = vma->vm_pgoff;
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
@@ -762,7 +762,7 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 			   dma_addr_t handle, unsigned long attrs,
 			   bool is_coherent)
 {
-	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
+	struct page *page = phys_to_page(dma_to_phys(dev, handle));
 	struct arm_dma_buffer *buf;
 	struct arm_dma_free_args args = {
 		.dev = dev,
@@ -796,15 +796,15 @@ static int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t handle, size_t size,
 		 unsigned long attrs)
 {
-	unsigned long pfn = dma_to_pfn(dev, handle);
+	phys_addr_t paddr = dma_to_phys(dev, handle);
 	struct page *page;
 	int ret;
 
 	/* If the PFN is not valid, we do not have a struct page */
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(PHYS_PFN(paddr)))
 		return -ENXIO;
 
-	page = pfn_to_page(pfn);
+	page = phys_to_page(paddr);
 
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 	if (unlikely(ret))
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
