Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF364C10F14
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:20:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7DF2133D
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ssqlzStP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7DF2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D4A402297;
	Thu, 11 Apr 2019 07:20:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0009B1ECF
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:20:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9127CF4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A/NEr2biDwgkhdYdNyvQFqlbV9vo3JFPIHcjRjIbiYY=;
	b=ssqlzStP+dXATSWv4MBC85tba7
	PXzq3I4BLkvOBrtXp9Knaq2Ki386NyR6OvYI0fajqvA/9GiVU4jw8Py/eJSez2gIg/d9xqe9QNS6u
	2AhQFH0GZERRIVA9XoVQ1IQWubq+oeBqiySoEnot8IzDKK3c2xCLxn4OhU1aRi8J38KVi4C6IwuTK
	4Bf84rH3ANzLtS/yf6wcBMxwu73Kt94cgf5jOaalXl0MMutkTOkJhw+qUMi2yOuuarLt2FipR/2NB
	Hj8Aj7YOnwrEmqBmnIan3y+N1JKua/l0bWLB3AuuWBODKZg1iukzZe9NgL08HOVE0DaA6yLJ1qL+I
	dcR0CihQ==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hEU0Z-0002it-J7; Thu, 11 Apr 2019 07:20:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 2/4] swiotlb-xen: use ->map_page to implement ->map_sg
Date: Thu, 11 Apr 2019 09:19:58 +0200
Message-Id: <20190411072000.4306-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411072000.4306-1-hch@lst.de>
References: <20190411072000.4306-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411071958.nygAVLDvmS3VrKtVEOa_wDyEbzppjGEJ3gHsZa9v9FA@z>

We can simply loop over the segments and map them, removing lots of
duplicate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 68 ++++++---------------------------------
 1 file changed, 10 insertions(+), 58 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index d4bc3aabd44d..97a55c225593 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -517,24 +517,8 @@ xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 
 }
 
-/*
- * Map a set of buffers described by scatterlist in streaming mode for DMA.
- * This is the scatter-gather version of the above xen_swiotlb_map_page
- * interface.  Here the scatter gather list elements are each tagged with the
- * appropriate dma address and length.  They are obtained via
- * sg_dma_{address,length}(SG).
- *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
- * Device ownership issues as mentioned above for xen_swiotlb_map_page are the
- * same here.
- */
 static int
-xen_swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
+xen_swiotlb_map_sg(struct device *dev, struct scatterlist *sgl, int nelems,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
@@ -543,50 +527,18 @@ xen_swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i) {
-		phys_addr_t paddr = sg_phys(sg);
-		dma_addr_t dev_addr = xen_phys_to_bus(paddr);
-
-		if (swiotlb_force == SWIOTLB_FORCE ||
-		    xen_arch_need_swiotlb(hwdev, paddr, dev_addr) ||
-		    !dma_capable(hwdev, dev_addr, sg->length) ||
-		    range_straddles_page_boundary(paddr, sg->length)) {
-			phys_addr_t map = swiotlb_tbl_map_single(hwdev,
-								 start_dma_addr,
-								 sg_phys(sg),
-								 sg->length,
-								 dir, attrs);
-			if (map == DMA_MAPPING_ERROR) {
-				dev_warn(hwdev, "swiotlb buffer is full\n");
-				/* Don't panic here, we expect map_sg users
-				   to do proper error handling. */
-				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
-				xen_swiotlb_unmap_sg(hwdev, sgl, i, dir, attrs);
-				sg_dma_len(sgl) = 0;
-				return 0;
-			}
-			dev_addr = xen_phys_to_bus(map);
-			xen_dma_map_page(hwdev, pfn_to_page(map >> PAGE_SHIFT),
-						dev_addr,
-						map & ~PAGE_MASK,
-						sg->length,
-						dir,
-						attrs);
-			sg->dma_address = dev_addr;
-		} else {
-			/* we are not interested in the dma_addr returned by
-			 * xen_dma_map_page, only in the potential cache flushes executed
-			 * by the function. */
-			xen_dma_map_page(hwdev, pfn_to_page(paddr >> PAGE_SHIFT),
-						dev_addr,
-						paddr & ~PAGE_MASK,
-						sg->length,
-						dir,
-						attrs);
-			sg->dma_address = dev_addr;
-		}
+		sg->dma_address = xen_swiotlb_map_page(dev, sg_page(sg),
+				sg->offset, sg->length, dir, attrs);
+		if (sg->dma_address == DMA_MAPPING_ERROR)
+			goto out_unmap;
 		sg_dma_len(sg) = sg->length;
 	}
+
 	return nelems;
+out_unmap:
+	xen_swiotlb_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
+	sg_dma_len(sgl) = 0;
+	return 0;
 }
 
 /*
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
