Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F289C433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 15:13:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D062193E
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 15:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dP3pKRmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D062193E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A75C6860F6;
	Mon, 14 Sep 2020 15:13:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id djq7DM8lU9Kk; Mon, 14 Sep 2020 15:13:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1308B860EF;
	Mon, 14 Sep 2020 15:13:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 092D2C088B;
	Mon, 14 Sep 2020 15:13:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1882C0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C83DD860F0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XpXlJxnImWVg for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 15:13:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1F0B7860EF
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=RqQGv7rUrofRqLyMSzfEtcHVgVUslC8cDoNR577KrIg=; b=dP3pKRmpC+I0E+dOSbraRXJ35X
 3haQwB40uPuLpGR5zn67wQbMCYeYUDIDCnlsB5tNCLi9vaoDWIjbKg2ty0ncKAbUYHiAWQ1Gwe4T2
 /L1d3ii2rUMCke8WZymWHb2tl/HocPOnGFPqgOwVy0kntsQ5+2r+a5DBRhRIc7Qwt5AhJHft+rUwc
 cUuL4BH3aNOU3nrCkiiuv/cztMGgjnYHVBqE36sUV2hPE4iUig7eK9l316jWvenjHMhEIQ2Nevj2v
 NzaWOE2Dnmj9Uqr/OYUKSLadMvLX2JkZjrKxFODSeBkgfvxBjLKXD/2ClVZgj/x7V7GdULKR4vyHX
 B3N9jL+g==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHqAB-0003UL-04; Mon, 14 Sep 2020 15:13:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 12/17] 53c700: convert to dma_alloc_noncoherent
Date: Mon, 14 Sep 2020 16:44:28 +0200
Message-Id: <20200914144433.1622958-13-hch@lst.de>
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

Use the new non-coherent DMA API including proper ownership transfers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/53c700.c | 11 +++++++++--
 drivers/scsi/53c700.h | 16 ++++++++--------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 9a343f8ecb6c3e..5117d90ccd9edf 100644
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
diff --git a/drivers/scsi/53c700.h b/drivers/scsi/53c700.h
index 0f545b05fe611d..c9f8c497babb3d 100644
--- a/drivers/scsi/53c700.h
+++ b/drivers/scsi/53c700.h
@@ -423,33 +423,33 @@ struct NCR_700_Host_Parameters {
 #define NCR_710_MIN_XFERP	0
 #define NCR_700_MIN_PERIOD	25 /* for SDTR message, 100ns */
 
-#define script_patch_32(dev, script, symbol, value) \
+#define script_patch_32(h, script, symbol, value) \
 { \
 	int i; \
 	dma_addr_t da = value; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
 		__u32 val = bS_to_cpu((script)[A_##symbol##_used[i]]) + da; \
 		(script)[A_##symbol##_used[i]] = bS_to_host(val); \
-		dma_sync_to_dev((dev), &(script)[A_##symbol##_used[i]], 4); \
+		dma_sync_to_dev((h), &(script)[A_##symbol##_used[i]], 4); \
 		DEBUG((" script, patching %s at %d to %pad\n", \
 		       #symbol, A_##symbol##_used[i], &da)); \
 	} \
 }
 
-#define script_patch_32_abs(dev, script, symbol, value) \
+#define script_patch_32_abs(h, script, symbol, value) \
 { \
 	int i; \
 	dma_addr_t da = value; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
 		(script)[A_##symbol##_used[i]] = bS_to_host(da); \
-		dma_sync_to_dev((dev), &(script)[A_##symbol##_used[i]], 4); \
+		dma_sync_to_dev((h), &(script)[A_##symbol##_used[i]], 4); \
 		DEBUG((" script, patching %s at %d to %pad\n", \
 		       #symbol, A_##symbol##_used[i], &da)); \
 	} \
 }
 
 /* Used for patching the SCSI ID in the SELECT instruction */
-#define script_patch_ID(dev, script, symbol, value) \
+#define script_patch_ID(h, script, symbol, value) \
 { \
 	int i; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
@@ -457,13 +457,13 @@ struct NCR_700_Host_Parameters {
 		val &= 0xff00ffff; \
 		val |= ((value) & 0xff) << 16; \
 		(script)[A_##symbol##_used[i]] = bS_to_host(val); \
-		dma_sync_to_dev((dev), &(script)[A_##symbol##_used[i]], 4); \
+		dma_sync_to_dev((h), &(script)[A_##symbol##_used[i]], 4); \
 		DEBUG((" script, patching ID field %s at %d to 0x%x\n", \
 		       #symbol, A_##symbol##_used[i], val)); \
 	} \
 }
 
-#define script_patch_16(dev, script, symbol, value) \
+#define script_patch_16(h, script, symbol, value) \
 { \
 	int i; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
@@ -471,7 +471,7 @@ struct NCR_700_Host_Parameters {
 		val &= 0xffff0000; \
 		val |= ((value) & 0xffff); \
 		(script)[A_##symbol##_used[i]] = bS_to_host(val); \
-		dma_sync_to_dev((dev), &(script)[A_##symbol##_used[i]], 4); \
+		dma_sync_to_dev((h), &(script)[A_##symbol##_used[i]], 4); \
 		DEBUG((" script, patching short field %s at %d to 0x%x\n", \
 		       #symbol, A_##symbol##_used[i], val)); \
 	} \
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
