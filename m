Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E1C433DF
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 06:56:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CA320825
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 06:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FfmYzkf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CA320825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 68E212094B;
	Wed, 19 Aug 2020 06:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eFdpwbwHEgp3; Wed, 19 Aug 2020 06:56:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D438020791;
	Wed, 19 Aug 2020 06:56:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9EC1C07FF;
	Wed, 19 Aug 2020 06:56:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4902EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 37714865B8
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xJHHFGuW7Umn for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 06:56:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5EE2186542
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=3H4NansDDN6m4kLuhIk/kp+Z4N3mSn8cpB0zE9ycnQw=; b=FfmYzkf9G6zwFUNNR629I5LzS3
 sycbpl6XBJNQxWdPFjivtYFvAIE2BLJ2qzBGSbrb4qsZMMfJP9/eHP8S4mQZ2+1Qp/sFoX35RiYzA
 HkdgOwz29iCkQAeMrmvVDYWraKQlEbIhijWnbLTMYghTv+7s9PA7sbl0esYUqgLYg5nrbhp5tTocC
 MkluoLqBfAzc4H5hViUIudDFe/lF5vGUx/dU2cLYx7jpBj8d8QnwTRzaMwN5nNPDKwz3V69GXE5aG
 zl6z181fqk4Jsg3atxLUAO9BbSDDhHAHpg0t5QmSPP39kziJBaZbtnr9s/ut+FwVdfRsInPqqIqLh
 2U/MY4HQ==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1A-0008Nq-7N; Wed, 19 Aug 2020 06:56:16 +0000
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
Subject: [PATCH 10/28] MIPS/jazzdma: decouple from dma-direct
Date: Wed, 19 Aug 2020 08:55:37 +0200
Message-Id: <20200819065555.1802761-11-hch@lst.de>
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

The jazzdma ops implement support for a very basic IOMMU.  Thus we really
should not use the dma-direct code that takes physical address limits
into account.  This survived through the great MIPS DMA ops cleanup mostly
because I was lazy, but now it is time to fully split the implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/jazz/jazzdma.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index fe40dbed04c1d6..d0b5a2ba2b1a8a 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -16,7 +16,6 @@
 #include <linux/memblock.h>
 #include <linux/spinlock.h>
 #include <linux/gfp.h>
-#include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <asm/mipsregs.h>
 #include <asm/jazz.h>
@@ -492,26 +491,38 @@ int vdma_get_enable(int channel)
 static void *jazz_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	struct page *page;
 	void *ret;
 
-	ret = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
-	if (!ret)
-		return NULL;
+	if (attrs & DMA_ATTR_NO_WARN)
+		gfp |= __GFP_NOWARN;
 
-	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
-	if (*dma_handle == DMA_MAPPING_ERROR) {
-		dma_direct_free_pages(dev, size, ret, *dma_handle, attrs);
+	size = PAGE_ALIGN(size);
+	page = alloc_pages(gfp, get_order(size));
+	if (!page)
 		return NULL;
-	}
+	ret = page_address(page);
+	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
+	if (*dma_handle == DMA_MAPPING_ERROR)
+		goto out_free_pages;
+
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
+		return ret;
+	arch_dma_prep_coherent(page, size);
+	return (void *)(UNCAC_BASE + __pa(ret));
 
-	return ret;
+out_free_pages:
+	__free_pages(page, get_order(size));
+	return NULL;
 }
 
 static void jazz_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	vdma_free(dma_handle);
-	dma_direct_free_pages(dev, size, vaddr, dma_handle, attrs);
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
+		vaddr = __va(vaddr - UNCAC_BASE);
+	__free_pages(virt_to_page(vaddr), get_order(size));
 }
 
 static dma_addr_t jazz_dma_map_page(struct device *dev, struct page *page,
@@ -608,7 +619,6 @@ const struct dma_map_ops jazz_dma_ops = {
 	.sync_single_for_device	= jazz_dma_sync_single_for_device,
 	.sync_sg_for_cpu	= jazz_dma_sync_sg_for_cpu,
 	.sync_sg_for_device	= jazz_dma_sync_sg_for_device,
-	.dma_supported		= dma_direct_supported,
 	.cache_sync		= arch_dma_cache_sync,
 	.mmap			= dma_common_mmap,
 	.get_sgtable		= dma_common_get_sgtable,
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
