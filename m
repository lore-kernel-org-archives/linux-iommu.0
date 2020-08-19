Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86029C433F7
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 06:57:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577292083B
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 06:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QGiD82cB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577292083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 351E521507;
	Wed, 19 Aug 2020 06:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e-n16nt2lDSw; Wed, 19 Aug 2020 06:57:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D618020791;
	Wed, 19 Aug 2020 06:57:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D00A0C07FF;
	Wed, 19 Aug 2020 06:57:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D851C0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 46D1F87B25
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id De1ktbO13zmh for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 06:57:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9460687AFF
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=AqKsIDRs27kIZ3qz8X8DimzxTNWdhtouY4ELawYdd20=; b=QGiD82cBnkvzgZSiKZTzQz9zIn
 xSBHf+C7K68+XJdLDlRisPbeW7e/fs+g/zRU1QnPbRWodLy3lfP1/FLluqbSZbe/9dI/YejsrQu6O
 nrPFR9LurAMCJrtwP62XqUXFsqR6jT+FopBHoW0oLC8p4iub1fJG2lGUohv6RtUIDi4kHQtkyFWgn
 Fh+mS5lGRe0XMgmxya6J8eZvNzE4F+1U0c1toIwpqy6DIiYV/7fbtNlnAqtXdbWk1l9XJf5DFSNZQ
 4qTZJRGTE0WcYGyD5RCcOfuIlgu6DeTh7eddCBGZ6BJoWyvTq/w13wG1XH1W71TFY67uTO9ZBBUOl
 No4Eu8YQ==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1Z-0008TG-Ct; Wed, 19 Aug 2020 06:56:41 +0000
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
Subject: [PATCH 20/28] sgiwd93: convert from dma_cache_sync to
 dma_sync_single_for_device
Date: Wed, 19 Aug 2020 08:55:47 +0200
Message-Id: <20200819065555.1802761-21-hch@lst.de>
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

Use the proper modern API to transfer cache ownership for incoherent DMA.
This also means we can allocate the memory as DMA_TO_DEVICE instead
of bidirectional.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sgiwd93.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sgiwd93.c b/drivers/scsi/sgiwd93.c
index 133adcf99e9340..1538f65307f22f 100644
--- a/drivers/scsi/sgiwd93.c
+++ b/drivers/scsi/sgiwd93.c
@@ -95,7 +95,7 @@ void fill_hpc_entries(struct ip22_hostdata *hd, struct scsi_cmnd *cmd, int din)
 	 */
 	hcp->desc.pbuf = 0;
 	hcp->desc.cntinfo = HPCDMA_EOX;
-	dma_cache_sync(hd->dev, hd->cpu,
+	dma_sync_single_for_device(hd->dev, hd->dma,
 		       (unsigned long)(hcp + 1) - (unsigned long)hd->cpu,
 		       DMA_TO_DEVICE);
 }
@@ -235,7 +235,7 @@ static int sgiwd93_probe(struct platform_device *pdev)
 	hdata = host_to_hostdata(host);
 	hdata->dev = &pdev->dev;
 	hdata->cpu = dma_alloc_pages(&pdev->dev, HPC_DMA_SIZE, &hdata->dma,
-				     DMA_BIDIRECTIONAL, GFP_KERNEL);
+				     DMA_TO_DEVICE, GFP_KERNEL);
 	if (!hdata->cpu) {
 		printk(KERN_WARNING "sgiwd93: Could not allocate memory for "
 		       "host %d buffer.\n", unit);
@@ -275,7 +275,7 @@ static int sgiwd93_probe(struct platform_device *pdev)
 	free_irq(irq, host);
 out_free:
 	dma_free_pages(&pdev->dev, HPC_DMA_SIZE, hdata->cpu, hdata->dma,
-			DMA_BIDIRECTIONAL);
+			DMA_TO_DEVICE);
 out_put:
 	scsi_host_put(host);
 out:
@@ -292,7 +292,7 @@ static int sgiwd93_remove(struct platform_device *pdev)
 	scsi_remove_host(host);
 	free_irq(pd->irq, host);
 	dma_free_pages(&pdev->dev, HPC_DMA_SIZE, hdata->cpu, hdata->dma,
-			DMA_BIDIRECTIONAL);
+			DMA_TO_DEVICE);
 	scsi_host_put(host);
 	return 0;
 }
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
