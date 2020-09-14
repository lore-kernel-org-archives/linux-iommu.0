Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0BC43461
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 15:24:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DF820639
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 15:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U0IBgU2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DF820639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3FF6721511;
	Mon, 14 Sep 2020 15:24:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WUDTH5U4YkQ3; Mon, 14 Sep 2020 15:24:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7E2C520439;
	Mon, 14 Sep 2020 15:24:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DD66C088B;
	Mon, 14 Sep 2020 15:24:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1F07C0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9118F860EF
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:24:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2gNkXcV82LGX for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 15:24:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1302281E2A
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=3uuWATlux5CLwoYUg+NN5gOtHb6T7EXPohKT/lTJKJI=; b=U0IBgU2QceYv7cYz0f441RijWy
 jX6Uz56bUrKfzqiHUqW4Am8nd+6lVMXE3/VPeI6Dyctys5vWsqG7p9TZjmsaB4shTobADfofWCt2s
 1s3TKwLjbf+g5qtDtSLFgL8DmFzhOuChm2RFQ+dWaxRQVaecIXZU24GAOneelMTCvJ13zxrzITOvg
 ExNdpySucaD8C2anmkAXbMOJB2da5zC7FBZvWjUSKNpv1i+Go/vuMfGDKG5gApZgbramlUxDAnvlC
 0pbLEfVZA10XQ/7JqJFE/O3mSpo7OqirHTyfcD2gC9N8uRPiSLShe9jiyo8nmIV8jkTp7pR6eEG4A
 UuqWKTxw==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHqKm-0004Mq-MA; Mon, 14 Sep 2020 15:24:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 17/17] firewire-ohci: use dma_alloc_pages
Date: Mon, 14 Sep 2020 16:44:33 +0200
Message-Id: <20200914144433.1622958-18-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914144433.1622958-1-hch@lst.de>
References: <20200914144433.1622958-1-hch@lst.de>
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

Use dma_alloc_pages to allocate DMAable pages instead of hoping that
the architecture either has GFP_DMA32 or not more than 4G of memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/firewire/ohci.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 020cb15a4d8fcc..9811c40956e54d 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -674,17 +674,16 @@ static void ar_context_link_page(struct ar_context *ctx, unsigned int index)
 
 static void ar_context_release(struct ar_context *ctx)
 {
+	struct device *dev = ctx->ohci->card.device;
 	unsigned int i;
 
 	vunmap(ctx->buffer);
 
-	for (i = 0; i < AR_BUFFERS; i++)
-		if (ctx->pages[i]) {
-			dma_unmap_page(ctx->ohci->card.device,
-				       ar_buffer_bus(ctx, i),
-				       PAGE_SIZE, DMA_FROM_DEVICE);
-			__free_page(ctx->pages[i]);
-		}
+	for (i = 0; i < AR_BUFFERS; i++) {
+		if (ctx->pages[i])
+			dma_free_pages(dev, PAGE_SIZE, ctx->pages[i],
+				       ar_buffer_bus(ctx, i), DMA_FROM_DEVICE);
+	}
 }
 
 static void ar_context_abort(struct ar_context *ctx, const char *error_msg)
@@ -970,6 +969,7 @@ static void ar_context_tasklet(unsigned long data)
 static int ar_context_init(struct ar_context *ctx, struct fw_ohci *ohci,
 			   unsigned int descriptors_offset, u32 regs)
 {
+	struct device *dev = ohci->card.device;
 	unsigned int i;
 	dma_addr_t dma_addr;
 	struct page *pages[AR_BUFFERS + AR_WRAPAROUND_PAGES];
@@ -980,17 +980,13 @@ static int ar_context_init(struct ar_context *ctx, struct fw_ohci *ohci,
 	tasklet_init(&ctx->tasklet, ar_context_tasklet, (unsigned long)ctx);
 
 	for (i = 0; i < AR_BUFFERS; i++) {
-		ctx->pages[i] = alloc_page(GFP_KERNEL | GFP_DMA32);
+		ctx->pages[i] = dma_alloc_pages(dev, PAGE_SIZE, &dma_addr,
+						DMA_FROM_DEVICE, GFP_KERNEL);
 		if (!ctx->pages[i])
 			goto out_of_memory;
-		dma_addr = dma_map_page(ohci->card.device, ctx->pages[i],
-					0, PAGE_SIZE, DMA_FROM_DEVICE);
-		if (dma_mapping_error(ohci->card.device, dma_addr)) {
-			__free_page(ctx->pages[i]);
-			ctx->pages[i] = NULL;
-			goto out_of_memory;
-		}
 		set_page_private(ctx->pages[i], dma_addr);
+		dma_sync_single_for_device(dev, dma_addr, PAGE_SIZE,
+					   DMA_FROM_DEVICE);
 	}
 
 	for (i = 0; i < AR_BUFFERS; i++)
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
