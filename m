Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B23C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:20:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039152133D
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SfYBR7F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039152133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 56CCF2249;
	Thu, 11 Apr 2019 07:20:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 150061ECF
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:20:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A997E854
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cu64RjX653xuK5qqDGAabuS7Z+CzqQQ9YPkFZpxZb/M=;
	b=SfYBR7F6iaL+iT0Ftg60r/Pnii
	ali5asdjSmmyyFQWQLwgu+VD3z92XJJOcoXRmvUP4bs751yw7jJ5pKQbsKwDQa3KS8zuNBgBDxWRy
	OyHNpMesb10eDhjiw+rk4tEXHXT7CgjtpsUZJCT0KvWThZC2WB739uoVwjIFpXupgkFz6exWnQZ3h
	msOMoTFPu+KGm1sERBXAhpyY2T1R8aH1mAUIfGTsU10AAntmyVRcY45oAReT8g2EbpurmMmDyCgUv
	Eu6GKczhmlh9S4UgiCvSJS2kIwt0WjjjnrYsvR4RlaKy+neF/ltRJcU2+pN00tch6GspWsznnRCFf
	g18c3IIQ==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hEU0X-0002ik-1h; Thu, 11 Apr 2019 07:20:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 1/4] swiotlb-xen: make instances match their method names
Date: Thu, 11 Apr 2019 09:19:57 +0200
Message-Id: <20190411072000.4306-2-hch@lst.de>
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
Message-ID: <20190411071957.fZYIBYAdGWPkg69AEHLBw_k2PWodqzQzuZDcWAMFhvs@z>

Just drop two pointless _attrs prefixes to make the code a little
more grep-able.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 877baf2a94f4..d4bc3aabd44d 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -504,9 +504,8 @@ xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
  * concerning calls here are the same as for swiotlb_unmap_page() above.
  */
 static void
-xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
-			   int nelems, enum dma_data_direction dir,
-			   unsigned long attrs)
+xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -535,9 +534,8 @@ xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
  * same here.
  */
 static int
-xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
-			 int nelems, enum dma_data_direction dir,
-			 unsigned long attrs)
+xen_swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -562,8 +560,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 				/* Don't panic here, we expect map_sg users
 				   to do proper error handling. */
 				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
-				xen_swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
-							   attrs);
+				xen_swiotlb_unmap_sg(hwdev, sgl, i, dir, attrs);
 				sg_dma_len(sgl) = 0;
 				return 0;
 			}
@@ -690,8 +687,8 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.sync_single_for_device = xen_swiotlb_sync_single_for_device,
 	.sync_sg_for_cpu = xen_swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = xen_swiotlb_sync_sg_for_device,
-	.map_sg = xen_swiotlb_map_sg_attrs,
-	.unmap_sg = xen_swiotlb_unmap_sg_attrs,
+	.map_sg = xen_swiotlb_map_sg,
+	.unmap_sg = xen_swiotlb_unmap_sg,
 	.map_page = xen_swiotlb_map_page,
 	.unmap_page = xen_swiotlb_unmap_page,
 	.dma_supported = xen_swiotlb_dma_supported,
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
