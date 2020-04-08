Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A82C2BB55
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:00:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630392145D
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Aw93+jFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630392145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6B9BB87E88;
	Wed,  8 Apr 2020 12:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U8-M1+V9HUYa; Wed,  8 Apr 2020 12:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B001887EA9;
	Wed,  8 Apr 2020 12:00:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABDAFC1D85;
	Wed,  8 Apr 2020 12:00:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3ABFC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9F83986A51
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DLveBunWpvNA for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 12:00:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4252C86A2D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=hvIl8nFdM9AKvvDd2B5Ptj/sPZlvFIjnu0sAKeiFvVM=; b=Aw93+jFA2GdNKeSsa38wNjnfeJ
 /Hxs35R5BvUIjAi75y9i06TKeMeJbZEpxu+5xdycGhgCnuMKfysp5Xo29U87h+hjXj05dBgfGKrWf
 i91U3+oTCKj4kvk5IzZbHTAvVhzAiQp/zMp5dFUe+PvkjRZkXTi92j4SSBAM/VBRNxIotnDHo5aQ/
 2mXhOdSdmKmXpCO8V3CsqLFu1Bjml4USrfdhJMKZ631fM0E0nBcJirRT2+fCqkHq+fRYLuqt949GV
 Si/voJR5Bp21VepCL6NCwOddv+lAijSqgdykatW2/GLZ2L/I+/7pJ67IF1ZHnLDSPWi+KEDDMxI8x
 NESmQdmQ==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM9Mo-0001cr-R8; Wed, 08 Apr 2020 11:59:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 x86@kernel.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Subject: [PATCH 03/28] staging: media: ipu3: use vmap insted of reimplementing
 it
Date: Wed,  8 Apr 2020 13:59:01 +0200
Message-Id: <20200408115926.1467567-4-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, bpf@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Just use vmap instead of messing with vmalloc internals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/staging/media/ipu3/ipu3-css-pool.h |  4 +--
 drivers/staging/media/ipu3/ipu3-dmamap.c   | 30 ++++++----------------
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-css-pool.h b/drivers/staging/media/ipu3/ipu3-css-pool.h
index f4a60b41401b..a8ccd4f70320 100644
--- a/drivers/staging/media/ipu3/ipu3-css-pool.h
+++ b/drivers/staging/media/ipu3/ipu3-css-pool.h
@@ -15,14 +15,12 @@ struct imgu_device;
  * @size:		size of the buffer in bytes.
  * @vaddr:		kernel virtual address.
  * @daddr:		iova dma address to access IPU3.
- * @vma:		private, a pointer to &struct vm_struct,
- *			used for imgu_dmamap_free.
  */
 struct imgu_css_map {
 	size_t size;
 	void *vaddr;
 	dma_addr_t daddr;
-	struct vm_struct *vma;
+	struct page **pages;
 };
 
 /**
diff --git a/drivers/staging/media/ipu3/ipu3-dmamap.c b/drivers/staging/media/ipu3/ipu3-dmamap.c
index 7431322379f6..8a19b0024152 100644
--- a/drivers/staging/media/ipu3/ipu3-dmamap.c
+++ b/drivers/staging/media/ipu3/ipu3-dmamap.c
@@ -96,6 +96,7 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu, struct imgu_css_map *map,
 	unsigned long shift = iova_shift(&imgu->iova_domain);
 	struct device *dev = &imgu->pci_dev->dev;
 	size_t size = PAGE_ALIGN(len);
+	int count = size >> PAGE_SHIFT;
 	struct page **pages;
 	dma_addr_t iovaddr;
 	struct iova *iova;
@@ -114,7 +115,7 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu, struct imgu_css_map *map,
 
 	/* Call IOMMU driver to setup pgt */
 	iovaddr = iova_dma_addr(&imgu->iova_domain, iova);
-	for (i = 0; i < size / PAGE_SIZE; ++i) {
+	for (i = 0; i < count; ++i) {
 		rval = imgu_mmu_map(imgu->mmu, iovaddr,
 				    page_to_phys(pages[i]), PAGE_SIZE);
 		if (rval)
@@ -123,33 +124,23 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu, struct imgu_css_map *map,
 		iovaddr += PAGE_SIZE;
 	}
 
-	/* Now grab a virtual region */
-	map->vma = __get_vm_area(size, VM_USERMAP, VMALLOC_START, VMALLOC_END);
-	if (!map->vma)
+	map->vaddr = vmap(pages, count, VM_USERMAP, PAGE_KERNEL);
+	if (!map->vaddr)
 		goto out_unmap;
 
-	map->vma->pages = pages;
-	/* And map it in KVA */
-	if (map_vm_area(map->vma, PAGE_KERNEL, pages))
-		goto out_vunmap;
-
+	map->pages = pages;
 	map->size = size;
 	map->daddr = iova_dma_addr(&imgu->iova_domain, iova);
-	map->vaddr = map->vma->addr;
 
 	dev_dbg(dev, "%s: allocated %zu @ IOVA %pad @ VA %p\n", __func__,
-		size, &map->daddr, map->vma->addr);
-
-	return map->vma->addr;
+		size, &map->daddr, map->vaddr);
 
-out_vunmap:
-	vunmap(map->vma->addr);
+	return map->vaddr;
 
 out_unmap:
 	imgu_dmamap_free_buffer(pages, size);
 	imgu_mmu_unmap(imgu->mmu, iova_dma_addr(&imgu->iova_domain, iova),
 		       i * PAGE_SIZE);
-	map->vma = NULL;
 
 out_free_iova:
 	__free_iova(&imgu->iova_domain, iova);
@@ -177,8 +168,6 @@ void imgu_dmamap_unmap(struct imgu_device *imgu, struct imgu_css_map *map)
  */
 void imgu_dmamap_free(struct imgu_device *imgu, struct imgu_css_map *map)
 {
-	struct vm_struct *area = map->vma;
-
 	dev_dbg(&imgu->pci_dev->dev, "%s: freeing %zu @ IOVA %pad @ VA %p\n",
 		__func__, map->size, &map->daddr, map->vaddr);
 
@@ -187,11 +176,8 @@ void imgu_dmamap_free(struct imgu_device *imgu, struct imgu_css_map *map)
 
 	imgu_dmamap_unmap(imgu, map);
 
-	if (WARN_ON(!area) || WARN_ON(!area->pages))
-		return;
-
-	imgu_dmamap_free_buffer(area->pages, map->size);
 	vunmap(map->vaddr);
+	imgu_dmamap_free_buffer(map->pages, map->size);
 	map->vaddr = NULL;
 }
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
