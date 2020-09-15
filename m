Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF21C43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 16:22:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4142520708
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 16:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v6KK3niw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4142520708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E42A486508;
	Tue, 15 Sep 2020 16:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TT0RcuN80nVX; Tue, 15 Sep 2020 16:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6865F864EE;
	Tue, 15 Sep 2020 16:22:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F09AC0859;
	Tue, 15 Sep 2020 16:22:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F515C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 16:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6AFA686963
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 16:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gsj52aqs6OKL for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 16:22:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ACE3B8695A
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 16:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=mmB55bH+GiUUvBX0M0a6szLbipBnoYrPJkFDbEmOQ1A=; b=v6KK3niwpozfF1/2CfD6WHxNPL
 WqvFpacqnDj3z9tYmi/pCGDS4z0oXk6NtOBL1BLADzIgwG1onwe45i+/vfOAiWW3UaLG67rkYKyIQ
 qYyTPXhlsv9L61oin0xyPlfwxm8ScKrki616QbbrBKOsqqTdx1AYD6TrfVZHWkCxcpkXnZocO6Q21
 KUd/FJBD0EuBHjgeKbThhL7/xCITOQAC82vwNY8boSiFbb6hLz32xAWneMUqd8lAsAMkOKmKza1gW
 u5D+AzibSLVedVjrdRy0io+aG8PpinWAP+wwGTbCoD279kK26rdQa8JJlhfLm868dJfkZDbZb6CVT
 oLMCe2Mw==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIDiR-0005Q0-Sw; Tue, 15 Sep 2020 16:22:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 13/18] 53c700: convert to dma_alloc_noncoherent
Date: Tue, 15 Sep 2020 17:51:17 +0200
Message-Id: <20200915155122.1768241-14-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915155122.1768241-1-hch@lst.de>
References: <20200915155122.1768241-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, netdev@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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

Use the new non-coherent DMA API including proper ownership transfers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/53c700.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index c59226d7e2f6b5..5117d90ccd9edf 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -269,18 +269,25 @@ NCR_700_get_SXFER(struct scsi_device *SDp)
 					      spi_period(SDp->sdev_target));
 }
 
+static inline dma_addr_t virt_to_dma(struct NCR_700_Host_Parameters *h, void *p)
+{
+	return h->pScript + ((uintptr_t)p - (uintptr_t)h->script);
+}
+
 static inline void dma_sync_to_dev(struct NCR_700_Host_Parameters *h,
 		void *addr, size_t size)
 {
 	if (h->noncoherent)
-		dma_cache_sync(h->dev, addr, size, DMA_TO_DEVICE);
+		dma_sync_single_for_device(h->dev, virt_to_dma(h, addr),
+					   size, DMA_BIDIRECTIONAL);
 }
 
 static inline void dma_sync_from_dev(struct NCR_700_Host_Parameters *h,
 		void *addr, size_t size)
 {
 	if (h->noncoherent)
-		dma_cache_sync(h->dev, addr, size, DMA_FROM_DEVICE);
+		dma_sync_single_for_device(h->dev, virt_to_dma(h, addr), size,
+					   DMA_BIDIRECTIONAL);
 }
 
 struct Scsi_Host *
@@ -300,8 +307,8 @@ NCR_700_detect(struct scsi_host_template *tpnt,
 	memory = dma_alloc_coherent(dev, TOTAL_MEM_SIZE, &pScript, GFP_KERNEL);
 	if (!memory) {
 		hostdata->noncoherent = 1;
-		memory = dma_alloc_attrs(dev, TOTAL_MEM_SIZE, &pScript,
-					 GFP_KERNEL, DMA_ATTR_NON_CONSISTENT);
+		memory = dma_alloc_noncoherent(dev, TOTAL_MEM_SIZE, &pScript,
+					 DMA_BIDIRECTIONAL, GFP_KERNEL);
 	}
 	if (!memory) {
 		printk(KERN_ERR "53c700: Failed to allocate memory for driver, detaching\n");
@@ -414,8 +421,9 @@ NCR_700_release(struct Scsi_Host *host)
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 
 	if (hostdata->noncoherent)
-		dma_free_attrs(hostdata->dev, TOTAL_MEM_SIZE, hostdata->script,
-			       hostdata->pScript, DMA_ATTR_NON_CONSISTENT);
+		dma_free_noncoherent(hostdata->dev, TOTAL_MEM_SIZE,
+				hostdata->script, hostdata->pScript,
+				DMA_BIDIRECTIONAL);
 	else
 		dma_free_coherent(hostdata->dev, TOTAL_MEM_SIZE,
 				  hostdata->script, hostdata->pScript);
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
