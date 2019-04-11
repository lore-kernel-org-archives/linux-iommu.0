Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB824C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:21:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EE62133D
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZcVJqm0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EE62133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 28BF9229A;
	Thu, 11 Apr 2019 07:20:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 35A251ECF
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:20:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D95EBF4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FYiYFX3eg2WXGlXW6/DFT8QDPeE9y3XIAunmMPhB284=;
	b=ZcVJqm0XyJ4JVyOw5F4VMNXsm/
	aUoR7AgKq0nEFUzJ76b+nHGfI1rXEO5GFhTKGslPK8uPW8Z4Wxyss8XxSwezyvxfHoOLxXeaeniRf
	crvFcwtNGXf7xPT9UqILYYWP23ak4R9eeANbL3ZOeZb6fMr9zA9JeJVVt9iRTtTDV/6gz+zte8DOI
	jEEebY/FNTTJRkg6FLuOYDMb0ybKU1lnswIa0IY9IIhdmxN9pTX3+PKYqt0VWiqGLz35T5+nvDihl
	AY9aB3OcNgZFx8ucP/6e4OTUHQDALXwa7uz6YOmG5J2tGPmHuEaNrGEKevMdmMoGLJbQ0KhRc3RCU
	sxZZligQ==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hEU0e-0002jU-K5; Thu, 11 Apr 2019 07:20:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 4/4] swiotlb-xen: ensure we have a single callsite for
	xen_dma_map_page
Date: Thu, 11 Apr 2019 09:20:00 +0200
Message-Id: <20190411072000.4306-5-hch@lst.de>
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
Message-ID: <20190411072000.uDJzZBtpeiWAcPOwH0n6e0JpJttyPRgeCzB2OwRC5mY@z>

Refactor the code a bit to make further changes easier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 9a951504dc12..5dcb06fe9667 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -391,13 +391,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	if (dma_capable(dev, dev_addr, size) &&
 	    !range_straddles_page_boundary(phys, size) &&
 		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
-		(swiotlb_force != SWIOTLB_FORCE)) {
-		/* we are not interested in the dma_addr returned by
-		 * xen_dma_map_page, only in the potential cache flushes executed
-		 * by the function. */
-		xen_dma_map_page(dev, page, dev_addr, offset, size, dir, attrs);
-		return dev_addr;
-	}
+		swiotlb_force != SWIOTLB_FORCE)
+		goto done;
 
 	/*
 	 * Oh well, have to allocate and map a bounce buffer.
@@ -410,19 +405,25 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 		return DMA_MAPPING_ERROR;
 
 	dev_addr = xen_phys_to_bus(map);
-	xen_dma_map_page(dev, pfn_to_page(map >> PAGE_SHIFT),
-					dev_addr, map & ~PAGE_MASK, size, dir, attrs);
 
 	/*
 	 * Ensure that the address returned is DMA'ble
 	 */
-	if (dma_capable(dev, dev_addr, size))
-		return dev_addr;
-
-	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
-	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
+	if (unlikely(!dma_capable(dev, dev_addr, size))) {
+		swiotlb_tbl_unmap_single(dev, map, size, dir,
+				attrs | DMA_ATTR_SKIP_CPU_SYNC);
+		return DMA_MAPPING_ERROR;
+	}
 
-	return DMA_MAPPING_ERROR;
+	page = pfn_to_page(map >> PAGE_SHIFT);
+	offset = map & ~PAGE_MASK;
+done:
+	/*
+	 * we are not interested in the dma_addr returned by xen_dma_map_page,
+	 * only in the potential cache flushes executed by the function.
+	 */
+	xen_dma_map_page(dev, page, dev_addr, offset, size, dir, attrs);
+	return dev_addr;
 }
 
 /*
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
