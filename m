Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCD8C3A5A7
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 13:13:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9471220820
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 13:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6461RqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9471220820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 77DE4E3D;
	Mon,  2 Sep 2019 13:13:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4FECBE32
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 13:13:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E7468756
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WUT2tiM88hPNkRtYXbHex8vC4m/OZCxIoGmn21PiEzg=;
	b=B6461RqGBtBH0KvXzaW8gyE1di
	GNR0A4uyyj8ExfMELYP3VZkyAGwY6+begEERVgg7lTlpC0MJuiW7f8kqUm2GgK6gMnmLcNPDcrkmh
	z3MxWlMA7p8dH+gac4nQqy46dF0HtEaYLr57yX90WRs51OeH5NH825iZp70lz03vDITtknrHmGZyT
	zPmNPVQwbUonkMu/pkmu2tKa/HiQScOjFywXrII680+PS8FHxVj+Z91/w8g71hstuq/AQJfgaklzv
	men9DAHq4czBJLy8Q1O/YWZSAlbjfdVDjU1o111d7b1N4Ynuaao5JCOn1pDg1pEPV3h+GPKO0Qya5
	jj8KCK9A==;
Received: from 213-225-38-191.nat.highway.a1.net ([213.225.38.191]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1i4m8l-0000VK-Cr; Mon, 02 Sep 2019 13:13:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, gross@suse.com,
	boris.ostrovsky@oracle.com
Subject: [PATCH 12/13] swiotlb-xen: merge xen_unmap_single into
	xen_swiotlb_unmap_page
Date: Mon,  2 Sep 2019 15:03:38 +0200
Message-Id: <20190902130339.23163-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902130339.23163-1-hch@lst.de>
References: <20190902130339.23163-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

No need for a no-op wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 drivers/xen/swiotlb-xen.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 95911ff9c11c..384304a77020 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -414,9 +414,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
  * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
-static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
-			     size_t size, enum dma_data_direction dir,
-			     unsigned long attrs)
+static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
 
@@ -430,13 +429,6 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
 }
 
-static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
-			    size_t size, enum dma_data_direction dir,
-			    unsigned long attrs)
-{
-	xen_unmap_single(hwdev, dev_addr, size, dir, attrs);
-}
-
 static void
 xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
@@ -477,7 +469,8 @@ xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i)
-		xen_unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir, attrs);
+		xen_swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg),
+				dir, attrs);
 
 }
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
