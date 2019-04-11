Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8714C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:20:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64102133D
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HE46vwkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64102133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9D7A82260;
	Thu, 11 Apr 2019 07:20:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 356B71ECF
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:20:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B5CA0F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FF4ZehdqOXhKqu4DPUrealDh/79fHjA9uM886RGi9sY=;
	b=HE46vwkIrIDMAFPXm50RK9Vvyo
	ftx1z3jxIYX1+izPHspT9KixYpXlRL8y9Eikr5eWKvc7qRcBnbSKZOWxHgCVj8KCkDfNWghaYI2l2
	L3boOq3Ppo04+I8E3BzhCkifjC+HHmwVa/AWTHfGB3grE/ADhSe7xLNTlevl+q1+3bH8fo36HtE62
	4HL2SSsFRzMb0qdupHqD6UAtWjA1HT47c9EAORaB2hWQMFw+jDIofmHoTzOGfNEtriNEmer5vcY/h
	J/rsfc5L1v+btCqgA+dD2NAxL1YatGY18Z+E8pk8Ega5Q5J+5mrQN3QQQ6zwCJdpBYxYYcFWCu1im
	YgwcIC+A==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hEU0c-0002jP-3x; Thu, 11 Apr 2019 07:20:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 3/4] swiotlb-xen: simplify the DMA sync method implementations
Date: Thu, 11 Apr 2019 09:19:59 +0200
Message-Id: <20190411072000.4306-4-hch@lst.de>
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
Message-ID: <20190411071959.aa07iqqWR9pJ_GTdA0vazkyhxZmQA5P4H0x-mgGfifY@z>

Get rid of the grand multiplexer and implement the sync_single_for_cpu
and sync_single_for_device methods directly, and then loop over them
for the scatterlist based variants.

Note that this also loses a few comments related to highlevel DMA API
concepts, which have nothing to do with the swiotlb-xen implementation
details.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 84 +++++++++++++--------------------------
 1 file changed, 28 insertions(+), 56 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 97a55c225593..9a951504dc12 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -455,48 +455,28 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 	xen_unmap_single(hwdev, dev_addr, size, dir, attrs);
 }
 
-/*
- * Make physical memory consistent for a single streaming mode DMA translation
- * after a transfer.
- *
- * If you perform a xen_swiotlb_map_page() but wish to interrogate the buffer
- * using the cpu, yet do not wish to teardown the dma mapping, you must
- * call this function before doing so.  At the next point you give the dma
- * address back to the card, you must first perform a
- * xen_swiotlb_dma_sync_for_device, and then the device again owns the buffer
- */
 static void
-xen_swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
-			size_t size, enum dma_data_direction dir,
-			enum dma_sync_target target)
+xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir)
 {
-	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
+	phys_addr_t paddr = xen_bus_to_phys(dma_addr);
 
-	BUG_ON(dir == DMA_NONE);
-
-	if (target == SYNC_FOR_CPU)
-		xen_dma_sync_single_for_cpu(hwdev, dev_addr, size, dir);
+	xen_dma_sync_single_for_cpu(dev, dma_addr, size, dir);
 
-	/* NOTE: We use dev_addr here, not paddr! */
-	if (is_xen_swiotlb_buffer(dev_addr))
-		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
-
-	if (target == SYNC_FOR_DEVICE)
-		xen_dma_sync_single_for_device(hwdev, dev_addr, size, dir);
+	if (is_xen_swiotlb_buffer(dma_addr))
+		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 }
 
-void
-xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-				size_t size, enum dma_data_direction dir)
+static void
+xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir)
 {
-	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
-}
+	phys_addr_t paddr = xen_bus_to_phys(dma_addr);
 
-void
-xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
-				   size_t size, enum dma_data_direction dir)
-{
-	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
+	if (is_xen_swiotlb_buffer(dma_addr))
+		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
+
+	xen_dma_sync_single_for_device(dev, dma_addr, size, dir);
 }
 
 /*
@@ -541,38 +521,30 @@ xen_swiotlb_map_sg(struct device *dev, struct scatterlist *sgl, int nelems,
 	return 0;
 }
 
-/*
- * Make physical memory consistent for a set of streaming mode DMA translations
- * after a transfer.
- *
- * The same as swiotlb_sync_single_* but for a scatter-gather list, same rules
- * and usage.
- */
 static void
-xen_swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sgl,
-		    int nelems, enum dma_data_direction dir,
-		    enum dma_sync_target target)
+xen_swiotlb_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
+			    int nelems, enum dma_data_direction dir)
 {
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(sgl, sg, nelems, i)
-		xen_swiotlb_sync_single(hwdev, sg->dma_address,
-					sg_dma_len(sg), dir, target);
-}
-
-static void
-xen_swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
-			    int nelems, enum dma_data_direction dir)
-{
-	xen_swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
+	for_each_sg(sgl, sg, nelems, i) {
+		xen_swiotlb_sync_single_for_cpu(dev, sg->dma_address,
+				sg->length, dir);
+	}
 }
 
 static void
-xen_swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
+xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 			       int nelems, enum dma_data_direction dir)
 {
-	xen_swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nelems, i) {
+		xen_swiotlb_sync_single_for_device(dev, sg->dma_address,
+				sg->length, dir);
+	}
 }
 
 /*
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
