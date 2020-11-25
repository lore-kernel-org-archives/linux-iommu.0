Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE11CC56202
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 20:31:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F955207BB
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 20:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BIbP6CPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F955207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF59287443;
	Wed, 25 Nov 2020 20:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kEW9cOix2QCg; Wed, 25 Nov 2020 20:31:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE9C187429;
	Wed, 25 Nov 2020 20:31:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98526C0891;
	Wed, 25 Nov 2020 20:31:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D6A9C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 20:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8B82387689
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 20:31:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YotUKmzn0ICj for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 20:31:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 812F787658
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 20:31:21 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id i2so3192485wrs.4
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 12:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=q710+yuAXMJxe0nd7TtiMj+ZjNL+TkbdcSV2kJANPFc=;
 b=BIbP6CPisTVorSg5qoPf0+dLgPrcTLlTwlVp8ftZSvaFgDocUfy9W0QG0G5Ods6KYD
 yNuT+KUHJ3LuzVLi2aruhMW4cOqXa3HmxH07ArrA7Ka9z6jrGkuyP/FM26RjBdMrBi+s
 P4RXP9NBi6sM7Lf6VlkFS3ouGBO+VOYD2B60o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=q710+yuAXMJxe0nd7TtiMj+ZjNL+TkbdcSV2kJANPFc=;
 b=MuOXPSFO/QNfcO+ZjifQxqzMJGPQYo01uutzUvWQ1LPKk+Gc3h3HXlSKKOOstA10mz
 3k+nHFbUYm3Z61dKFqDhuUVMOwEh4isJzdgs3gHCF1qYGjy6lLqb8aKqto0I/rllfPeU
 YAWI3UK2yGNOwAnolSn+7zClw23skAfBWKCOICLCPDTxwbw8xT+plpd/CDglaLkaGEsg
 GUqMnNW0tOx/VEN/xSAi5S3/eRPiTJCCRntU847W4BetJCTAQuDwPffKo/KLoufFxg9O
 PWh/hw2B16Nj0JhQZUT1+sIT3L8fLn3b66CH+DK7QZ1NDKNOLPLqMBaLZHj8q6F+xzX1
 JgFg==
X-Gm-Message-State: AOAM53360FdV440CELURyYudWTMzHPxNPheXlQS23QpLCUMID/w2EK0f
 hM7kTEWhCmyccFyj/7WCSjfizA==
X-Google-Smtp-Source: ABdhPJyaT4T+JFlra8+I0dMKQzQ88jRUsULWXg1Du+OwyPFSmH7nHfduCIkjo/9lH+6AkK7sbuYwqA==
X-Received: by 2002:adf:fd52:: with SMTP id h18mr6084459wrs.90.1606336279903; 
 Wed, 25 Nov 2020 12:31:19 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
 by smtp.gmail.com with ESMTPSA id h83sm4827088wmf.9.2020.11.25.12.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 12:31:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 auro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>
Subject: [PATCH v2 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
Date: Wed, 25 Nov 2020 21:31:14 +0100
Message-Id: <20201125203114.130967-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Cc: Ricardo Ribalda <ribalda@chromium.org>
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

On architectures where the is no coherent caching such as ARM use the
dma_alloc_noncontiguos API and handle manually the cache flushing using
dma_sync_sg().

With this patch on the affected architectures we can measure up to 20x
performance improvement in uvc_video_copy_data_work().

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---

v2: Thanks to Robin!

Use dma_sync_sg instead of dma_sync_single


 drivers/media/usb/uvc/uvc_video.c | 83 ++++++++++++++++++++++++++-----
 drivers/media/usb/uvc/uvcvideo.h  |  2 +
 2 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index a6a441d92b94..b2e6a9522999 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1490,6 +1490,11 @@ static void uvc_video_encode_bulk(struct uvc_urb *uvc_urb,
 	urb->transfer_buffer_length = stream->urb_size - len;
 }
 
+static inline struct device *stream_to_dmadev(struct uvc_streaming *stream)
+{
+	return stream->dev->udev->bus->controller->parent;
+}
+
 static void uvc_video_complete(struct urb *urb)
 {
 	struct uvc_urb *uvc_urb = urb->context;
@@ -1539,6 +1544,10 @@ static void uvc_video_complete(struct urb *urb)
 	 * Process the URB headers, and optionally queue expensive memcpy tasks
 	 * to be deferred to a work queue.
 	 */
+	if (uvc_urb->pages) {
+		dma_sync_sg_for_cpu(stream_to_dmadev(stream), uvc_urb->sgt.sgl,
+				    uvc_urb->sgt.nents,	DMA_FROM_DEVICE);
+	}
 	stream->decode(uvc_urb, buf, buf_meta);
 
 	/* If no async work is needed, resubmit the URB immediately. */
@@ -1566,8 +1575,16 @@ static void uvc_free_urb_buffers(struct uvc_streaming *stream)
 			continue;
 
 #ifndef CONFIG_DMA_NONCOHERENT
-		usb_free_coherent(stream->dev->udev, stream->urb_size,
-				  uvc_urb->buffer, uvc_urb->dma);
+		if (uvc_urb->pages) {
+			sg_free_table(&uvc_urb->sgt);
+			vunmap(uvc_urb->buffer);
+			dma_free_noncontiguous(stream_to_dmadev(stream),
+					       stream->urb_size,
+					       uvc_urb->pages, uvc_urb->dma);
+		} else {
+			usb_free_coherent(stream->dev->udev, stream->urb_size,
+					  uvc_urb->buffer, uvc_urb->dma);
+		}
 #else
 		kfree(uvc_urb->buffer);
 #endif
@@ -1577,6 +1594,56 @@ static void uvc_free_urb_buffers(struct uvc_streaming *stream)
 	stream->urb_size = 0;
 }
 
+#ifndef CONFIG_DMA_NONCOHERENT
+static bool uvc_alloc_urb_buffer(struct uvc_streaming *stream,
+				 struct uvc_urb *uvc_urb, gfp_t gfp_flags)
+{
+	struct device *dma_dev = dma_dev = stream_to_dmadev(stream);
+
+	if (!dma_can_alloc_noncontiguous(dma_dev)) {
+		uvc_urb->buffer = usb_alloc_coherent(stream->dev->udev,
+						     stream->urb_size,
+						     gfp_flags | __GFP_NOWARN,
+						     &uvc_urb->dma);
+		return uvc_urb->buffer != NULL;
+	}
+
+	uvc_urb->pages = dma_alloc_noncontiguous(dma_dev, stream->urb_size,
+						 &uvc_urb->dma,
+						 gfp_flags | __GFP_NOWARN, 0);
+	if (!uvc_urb->pages)
+		return false;
+
+	uvc_urb->buffer = vmap(uvc_urb->pages,
+			       PAGE_ALIGN(stream->urb_size) >> PAGE_SHIFT,
+			       VM_DMA_COHERENT, PAGE_KERNEL);
+	if (!uvc_urb->buffer) {
+		dma_free_noncontiguous(dma_dev, stream->urb_size,
+				       uvc_urb->pages, uvc_urb->dma);
+		return false;
+	}
+
+	if (sg_alloc_table_from_pages(&uvc_urb->sgt, uvc_urb->pages,
+				PAGE_ALIGN(stream->urb_size) >> PAGE_SHIFT, 0,
+				stream->urb_size, GFP_KERNEL)) {
+		vunmap(uvc_urb->buffer);
+		dma_free_noncontiguous(dma_dev, stream->urb_size,
+				       uvc_urb->pages, uvc_urb->dma);
+		return false;
+	}
+
+	return true;
+}
+#else
+static bool uvc_alloc_urb_buffer(struct uvc_streaming *stream,
+				 struct uvc_urb *uvc_urb, gfp_t gfp_flags)
+{
+	uvc_urb->buffer = kmalloc(stream->urb_size, gfp_flags | __GFP_NOWARN);
+
+	return uvc_urb->buffer != NULL;
+}
+#endif
+
 /*
  * Allocate transfer buffers. This function can be called with buffers
  * already allocated when resuming from suspend, in which case it will
@@ -1607,19 +1674,11 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
 
 	/* Retry allocations until one succeed. */
 	for (; npackets > 1; npackets /= 2) {
+		stream->urb_size = psize * npackets;
 		for (i = 0; i < UVC_URBS; ++i) {
 			struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
 
-			stream->urb_size = psize * npackets;
-#ifndef CONFIG_DMA_NONCOHERENT
-			uvc_urb->buffer = usb_alloc_coherent(
-				stream->dev->udev, stream->urb_size,
-				gfp_flags | __GFP_NOWARN, &uvc_urb->dma);
-#else
-			uvc_urb->buffer =
-			    kmalloc(stream->urb_size, gfp_flags | __GFP_NOWARN);
-#endif
-			if (!uvc_urb->buffer) {
+			if (!uvc_alloc_urb_buffer(stream, uvc_urb, gfp_flags)) {
 				uvc_free_urb_buffers(stream);
 				break;
 			}
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a3dfacf069c4..3e6618a2ac82 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -532,6 +532,8 @@ struct uvc_urb {
 
 	char *buffer;
 	dma_addr_t dma;
+	struct page **pages;
+	struct sg_table sgt;
 
 	unsigned int async_operations;
 	struct uvc_copy_op copy_operations[UVC_MAX_PACKETS];
-- 
2.29.2.454.gaff20da3a2-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
