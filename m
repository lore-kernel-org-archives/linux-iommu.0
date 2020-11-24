Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26530C2D0E4
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 15:38:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA8A20715
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 15:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MyQgzUY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA8A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4B0C8203F9;
	Tue, 24 Nov 2020 15:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 95oK80Z4sAOs; Tue, 24 Nov 2020 15:38:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3E6642039C;
	Tue, 24 Nov 2020 15:38:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BAF3C163C;
	Tue, 24 Nov 2020 15:38:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA740C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AA8DF204E1
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7+YjHqCWATiz for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 15:38:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 4577F204DE
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:38:52 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z7so6950562wrn.3
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 07:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EpyMQrLTrHVI5txNBrKgPsmGUgrXglJVTVw+m/0Ouds=;
 b=MyQgzUY2byHdFSx/r89I4t+T+2w/nKt4sOcaLSo7MrKy8Ir89ajb4aO0+vl+xzdFNB
 OpSlE7xnd/+/+6WDTbNQFh51Ew487JIaCXtKuzfGiqISmmcvLj/Dzp3cKS+RwDVh5z+1
 +1VCIwXMZBuwSmzdchZPZ2xbRnbB1UlaV3QSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EpyMQrLTrHVI5txNBrKgPsmGUgrXglJVTVw+m/0Ouds=;
 b=WmB8QIG3os6LZ80GgV7xK5RbKJ3EZ049QYgAdqLwcENU4VCk0V2g8vVUbXWDLoR+Zo
 HCyU75woAwzAOc2NmIYFHZZ7RjCI9lw1FCTICqrznfrDn6gFUqmrtD48GLVCtBlMpmg9
 VyNZY2OsRvgzMEYzD3jXDds/4ptFYgTedHcXwXCEul9aSYX4DavsIPPsuybPwzJGuX7S
 GnZg4d9qsfvlXJhYUNnydXZs8MLgKdZewMqSOoIQZY3mGduPLUssGDJw6O58YZWgaCbf
 5DDGapBXcE6bKNqYOCU1sc7uOfZJZ/oRMqWwmbCjIb37rmDGaTSlaIPUZunkvEWtbERU
 sPKg==
X-Gm-Message-State: AOAM530MzwGgOplBh8UH+dTZNJirL/Ok9gVJDOu71+3jdjjDM2wPFxJA
 OnJC4LQIVcC/GA/08INYHmaviQ==
X-Google-Smtp-Source: ABdhPJwNdpaLE8ojeiuxLUG9loFdJWcDfRi4IrJGedmjtWxZwsbIrZ+gGhlPEvJkjoCQXT/9u2JRwg==
X-Received: by 2002:adf:f1c2:: with SMTP id z2mr5751777wro.281.1606232330808; 
 Tue, 24 Nov 2020 07:38:50 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
 by smtp.gmail.com with ESMTPSA id 25sm5814752wmk.19.2020.11.24.07.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 07:38:50 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: Christoph Hellwig <hch@lst.de>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>
Subject: [PATCH 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
Date: Tue, 24 Nov 2020 16:38:44 +0100
Message-Id: <20201124153845.132207-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201124153845.132207-1-ribalda@chromium.org>
References: <20201124153845.132207-1-ribalda@chromium.org>
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
dma_sync_single().

With this patch on the affected architectures we can measure up to 20x
performance improvement in uvc_video_copy_data_work().

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 74 ++++++++++++++++++++++++++-----
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index a6a441d92b94..9e90b261428a 100644
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
@@ -1539,6 +1544,11 @@ static void uvc_video_complete(struct urb *urb)
 	 * Process the URB headers, and optionally queue expensive memcpy tasks
 	 * to be deferred to a work queue.
 	 */
+	if (uvc_urb->pages)
+		dma_sync_single_for_cpu(stream_to_dmadev(stream),
+					urb->transfer_dma,
+					urb->transfer_buffer_length,
+					DMA_FROM_DEVICE);
 	stream->decode(uvc_urb, buf, buf_meta);
 
 	/* If no async work is needed, resubmit the URB immediately. */
@@ -1566,8 +1576,15 @@ static void uvc_free_urb_buffers(struct uvc_streaming *stream)
 			continue;
 
 #ifndef CONFIG_DMA_NONCOHERENT
-		usb_free_coherent(stream->dev->udev, stream->urb_size,
-				  uvc_urb->buffer, uvc_urb->dma);
+		if (uvc_urb->pages) {
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
@@ -1577,6 +1594,47 @@ static void uvc_free_urb_buffers(struct uvc_streaming *stream)
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
@@ -1607,19 +1665,11 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
 
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
index a3dfacf069c4..3e3ef1f1daa5 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -532,6 +532,7 @@ struct uvc_urb {
 
 	char *buffer;
 	dma_addr_t dma;
+	struct page **pages;
 
 	unsigned int async_operations;
 	struct uvc_copy_op copy_operations[UVC_MAX_PACKETS];
-- 
2.29.2.454.gaff20da3a2-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
