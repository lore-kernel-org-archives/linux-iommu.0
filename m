Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC23AC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 22:25:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098ED64F60
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 22:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098ED64F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9067D43339;
	Fri, 12 Mar 2021 22:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rq4lKL9tVE4x; Fri, 12 Mar 2021 22:25:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F2FD43335;
	Fri, 12 Mar 2021 22:25:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38A93C000B;
	Fri, 12 Mar 2021 22:25:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A07A8C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 22:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80F8C8457A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 22:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oZXGpVl3rWb5 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 22:25:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4789E84465
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 22:25:48 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id j3so10125663edp.11
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 14:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4dgM2/DDoItjYDKF9jNp8m3z4qdT9b9yhcQRE0doXbs=;
 b=kO3ibA8LKs7kqvsQ8vyTuY2sFhjFi0bPOnHfdqIARGYMaF3qppdmivc/d+lSf/uRXq
 WI3PxaG+uCzcuGurg4pJqbZrbkQrrh2lxxH7aU0vBunWhkyHDca0rRHQteE/T90WpSg5
 l58Gdw2UZyz4d6SUfcwoI7IItzsUW5j3HjTEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4dgM2/DDoItjYDKF9jNp8m3z4qdT9b9yhcQRE0doXbs=;
 b=WXUmMx035b+pZLdaWjYQHPptkzRDRD1xka3qjLYEwRe9tIoQ12uHwLWwD7HCuMjGqj
 si3vqHnPgBbYPw9Vd//b+B9wDGIr6o2rdsx9V4/zleW4ZjiyOUS+S+5tM+WrjWq6GPfM
 sUlSiX+xmQVcr3nVGhdePZJDgt1mpaP+/kZ83uKGv8gpxNFN2x1Y6WvTMUCrr8yBZ8Qi
 MrQFJlOZjJBJ2sjqqhobpSfnNf4VVwL7La13Y9q4ptO89R/e80rme2L2MNaqkaeYDXbK
 7UqgRVCinvKsazoBTtCfmQaZ/fb2LwqERuGOpaCEjFbIIgzvV54rrYtxs+36yBhbXWAM
 RBhA==
X-Gm-Message-State: AOAM5330myndOlygQcSxBLL75L9URHUrOu/gZBbZ5nb1jma7HqK5NLUD
 4phu1qKWoucQV8/v9jpahydkjQ==
X-Google-Smtp-Source: ABdhPJztvim7jXcgxWVPAvmLy5+gme7StGpT1L0YJdsOghQEwlhbm0VjtmpVZYDVcJ5W5t658kW/sg==
X-Received: by 2002:aa7:d547:: with SMTP id u7mr16945994edr.347.1615587946270; 
 Fri, 12 Mar 2021 14:25:46 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
 by smtp.gmail.com with ESMTPSA id v8sm3611196edx.38.2021.03.12.14.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 14:25:46 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: Christoph Hellwig <hch@lst.de>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v3 6/6] media: uvcvideo: Use dma_alloc_noncontiguous API
Date: Fri, 12 Mar 2021 23:25:39 +0100
Message-Id: <20210312222539.1403488-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
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

On architectures where there is no coherent caching such as ARM use the
dma_alloc_noncontiguous API and handle manually the cache flushing using
dma_sync_sgtable().

With this patch on the affected architectures we can measure up to 20x
performance improvement in uvc_video_copy_data_work().

Eg: aarch64 with an external usb camera

NON_CONTIGUOUS
frames:  999
packets: 999
empty:   0 (0 %)
errors:  0
invalid: 0
pts: 0 early, 0 initial, 999 ok
scr: 0 count ok, 0 diff ok
sof: 2048 <= sof <= 0, freq 0.000 kHz
bytes 67034480 : duration 33303
FPS: 29.99
URB: 523446/4993 uS/qty: 104.836 avg 132.532 std 13.230 min 831.094 max (uS)
header: 76564/4993 uS/qty: 15.334 avg 15.229 std 3.438 min 186.875 max (uS)
latency: 468945/4992 uS/qty: 93.939 avg 132.577 std 9.531 min 824.010 max (uS)
decode: 54161/4993 uS/qty: 10.847 avg 6.313 std 1.614 min 111.458 max (uS)
raw decode speed: 9.931 Gbits/s
raw URB handling speed: 1.025 Gbits/s
throughput: 16.102 Mbits/s
URB decode CPU usage 0.162600 %

COHERENT
frames:  999
packets: 999
empty:   0 (0 %)
errors:  0
invalid: 0
pts: 0 early, 0 initial, 999 ok
scr: 0 count ok, 0 diff ok
sof: 2048 <= sof <= 0, freq 0.000 kHz
bytes 54683536 : duration 33302
FPS: 29.99
URB: 1478135/4000 uS/qty: 369.533 avg 390.357 std 22.968 min 3337.865 max (uS)
header: 79761/4000 uS/qty: 19.940 avg 18.495 std 1.875 min 336.719 max (uS)
latency: 281077/4000 uS/qty: 70.269 avg 83.102 std 5.104 min 735.000 max (uS)
decode: 1197057/4000 uS/qty: 299.264 avg 318.080 std 1.615 min 2806.667 max (uS)
raw decode speed: 365.470 Mbits/s
raw URB handling speed: 295.986 Mbits/s
throughput: 13.136 Mbits/s
URB decode CPU usage 3.594500 %

In non-affected architectures we see no significant impact.

Eg: x86 with an external usb camera

NON_CONTIGUOUS
frames:  999
packets: 999
empty:   0 (0 %)
errors:  0
invalid: 0
pts: 0 early, 0 initial, 999 ok
scr: 0 count ok, 0 diff ok
sof: 2048 <= sof <= 0, freq 0.000 kHz
bytes 70179056 : duration 33301
FPS: 29.99
URB: 288901/4897 uS/qty: 58.995 avg 26.022 std 4.319 min 253.853 max (uS)
header: 54792/4897 uS/qty: 11.189 avg 6.218 std 0.620 min 61.750 max (uS)
latency: 236602/4897 uS/qty: 48.315 avg 24.244 std 1.764 min 240.924 max (uS)
decode: 52298/4897 uS/qty: 10.679 avg 8.299 std 1.638 min 108.861 max (uS)
raw decode speed: 10.796 Gbits/s
raw URB handling speed: 1.949 Gbits/s
throughput: 16.859 Mbits/s
URB decode CPU usage 0.157000 %

COHERENT
frames:  999
packets: 999
empty:   0 (0 %)
errors:  0
invalid: 0
pts: 0 early, 0 initial, 999 ok
scr: 0 count ok, 0 diff ok
sof: 2048 <= sof <= 0, freq 0.000 kHz
bytes 71818320 : duration 33301
FPS: 29.99
URB: 321021/5000 uS/qty: 64.204 avg 23.001 std 10.430 min 268.837 max (uS)
header: 54308/5000 uS/qty: 10.861 avg 5.104 std 0.778 min 54.736 max (uS)
latency: 268799/5000 uS/qty: 53.759 avg 21.827 std 6.095 min 255.153 max (uS)
decode: 52222/5000 uS/qty: 10.444 avg 7.137 std 1.874 min 71.103 max (uS)
raw decode speed: 11.048 Gbits/s
raw URB handling speed: 1.789 Gbits/s
throughput: 17.253 Mbits/s
URB decode CPU usage 0.156800 %

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changelog from v2 (Thanks Laurent!):

- Replace uvc_urb_dma_sync with uvc_submit_urb
- Add x86 stats in commit message

 drivers/media/usb/uvc/uvc_video.c | 92 ++++++++++++++++++++++---------
 drivers/media/usb/uvc/uvcvideo.h  |  5 +-
 2 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index f2f565281e63..37ee39412b83 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -6,11 +6,14 @@
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
  */
 
+#include <linux/dma-mapping.h>
+#include <linux/highmem.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
+#include <linux/usb/hcd.h>
 #include <linux/videodev2.h>
 #include <linux/vmalloc.h>
 #include <linux/wait.h>
@@ -1096,6 +1099,28 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	return data[0];
 }
 
+static inline enum dma_data_direction stream_dir(struct uvc_streaming *stream)
+{
+	if (stream->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return DMA_FROM_DEVICE;
+	else
+		return DMA_TO_DEVICE;
+}
+
+static inline struct device *stream_to_dmadev(struct uvc_streaming *stream)
+{
+	return bus_to_hcd(stream->dev->udev->bus)->self.sysdev;
+}
+
+static int uvc_submit_urb(struct uvc_urb *uvc_urb, gfp_t mem_flags)
+{
+	/* Sync DMA. */
+	dma_sync_sgtable_for_device(stream_to_dmadev(uvc_urb->stream),
+				    uvc_urb->sgt,
+				    stream_dir(uvc_urb->stream));
+	return usb_submit_urb(uvc_urb->urb, GFP_KERNEL);
+}
+
 /*
  * uvc_video_decode_data_work: Asynchronous memcpy processing
  *
@@ -1117,7 +1142,7 @@ static void uvc_video_copy_data_work(struct work_struct *work)
 		uvc_queue_buffer_release(op->buf);
 	}
 
-	ret = usb_submit_urb(uvc_urb->urb, GFP_KERNEL);
+	ret = uvc_submit_urb(uvc_urb, GFP_KERNEL);
 	if (ret < 0)
 		dev_err(&uvc_urb->stream->intf->dev,
 			"Failed to resubmit video URB (%d).\n", ret);
@@ -1537,6 +1562,11 @@ static void uvc_video_complete(struct urb *urb)
 	/* Re-initialise the URB async work. */
 	uvc_urb->async_operations = 0;
 
+	/* Sync DMA and invalidate vmap range. */
+	dma_sync_sgtable_for_cpu(stream_to_dmadev(uvc_urb->stream),
+				 uvc_urb->sgt, stream_dir(stream));
+	invalidate_kernel_vmap_range(uvc_urb->buffer,
+				     uvc_urb->stream->urb_size);
 	/*
 	 * Process the URB headers, and optionally queue expensive memcpy tasks
 	 * to be deferred to a work queue.
@@ -1545,7 +1575,7 @@ static void uvc_video_complete(struct urb *urb)
 
 	/* If no async work is needed, resubmit the URB immediately. */
 	if (!uvc_urb->async_operations) {
-		ret = usb_submit_urb(uvc_urb->urb, GFP_ATOMIC);
+		ret = uvc_submit_urb(uvc_urb, GFP_ATOMIC);
 		if (ret < 0)
 			dev_err(&stream->intf->dev,
 				"Failed to resubmit video URB (%d).\n", ret);
@@ -1560,24 +1590,49 @@ static void uvc_video_complete(struct urb *urb)
  */
 static void uvc_free_urb_buffers(struct uvc_streaming *stream)
 {
+	struct device *dma_dev = stream_to_dmadev(stream);
 	struct uvc_urb *uvc_urb;
 
 	for_each_uvc_urb(uvc_urb, stream) {
 		if (!uvc_urb->buffer)
 			continue;
 
-#ifndef CONFIG_DMA_NONCOHERENT
-		usb_free_coherent(stream->dev->udev, stream->urb_size,
-				  uvc_urb->buffer, uvc_urb->dma);
-#else
-		kfree(uvc_urb->buffer);
-#endif
+		dma_vunmap_noncontiguous(dma_dev, uvc_urb->buffer);
+		dma_free_noncontiguous(dma_dev, stream->urb_size, uvc_urb->sgt,
+				       stream_dir(stream));
+
 		uvc_urb->buffer = NULL;
+		uvc_urb->sgt = NULL;
 	}
 
 	stream->urb_size = 0;
 }
 
+static bool uvc_alloc_urb_buffer(struct uvc_streaming *stream,
+				 struct uvc_urb *uvc_urb, gfp_t gfp_flags)
+{
+	struct device *dma_dev = stream_to_dmadev(stream);
+
+	uvc_urb->sgt = dma_alloc_noncontiguous(dma_dev, stream->urb_size,
+					       stream_dir(stream),
+					       gfp_flags, 0);
+	if (!uvc_urb->sgt)
+		return false;
+	uvc_urb->dma = uvc_urb->sgt->sgl->dma_address;
+
+	uvc_urb->buffer = dma_vmap_noncontiguous(dma_dev, stream->urb_size,
+						 uvc_urb->sgt);
+	if (!uvc_urb->buffer) {
+		dma_free_noncontiguous(dma_dev, stream->urb_size,
+				       uvc_urb->sgt,
+				       stream_dir(stream));
+		uvc_urb->sgt = NULL;
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * Allocate transfer buffers. This function can be called with buffers
  * already allocated when resuming from suspend, in which case it will
@@ -1608,19 +1663,12 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
 
 	/* Retry allocations until one succeed. */
 	for (; npackets > 1; npackets /= 2) {
+		stream->urb_size = psize * npackets;
+
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
@@ -1730,12 +1778,8 @@ static int uvc_init_video_isoc(struct uvc_streaming *stream,
 		urb->context = uvc_urb;
 		urb->pipe = usb_rcvisocpipe(stream->dev->udev,
 				ep->desc.bEndpointAddress);
-#ifndef CONFIG_DMA_NONCOHERENT
 		urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
 		urb->transfer_dma = uvc_urb->dma;
-#else
-		urb->transfer_flags = URB_ISO_ASAP;
-#endif
 		urb->interval = ep->desc.bInterval;
 		urb->transfer_buffer = uvc_urb->buffer;
 		urb->complete = uvc_video_complete;
@@ -1795,10 +1839,8 @@ static int uvc_init_video_bulk(struct uvc_streaming *stream,
 
 		usb_fill_bulk_urb(urb, stream->dev->udev, pipe,	uvc_urb->buffer,
 				  size, uvc_video_complete, uvc_urb);
-#ifndef CONFIG_DMA_NONCOHERENT
 		urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
 		urb->transfer_dma = uvc_urb->dma;
-#endif
 
 		uvc_urb->urb = urb;
 	}
@@ -1895,7 +1937,7 @@ static int uvc_video_start_transfer(struct uvc_streaming *stream,
 
 	/* Submit the URBs. */
 	for_each_uvc_urb(uvc_urb, stream) {
-		ret = usb_submit_urb(uvc_urb->urb, gfp_flags);
+		ret = uvc_submit_urb(uvc_urb, gfp_flags);
 		if (ret < 0) {
 			dev_err(&stream->intf->dev,
 				"Failed to submit URB %u (%d).\n",
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 97df5ecd66c9..cce5e38133cd 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -219,6 +219,7 @@
  */
 
 struct gpio_desc;
+struct sg_table;
 struct uvc_device;
 
 /* TODO: Put the most frequently accessed fields at the beginning of
@@ -545,7 +546,8 @@ struct uvc_copy_op {
  * @urb: the URB described by this context structure
  * @stream: UVC streaming context
  * @buffer: memory storage for the URB
- * @dma: DMA coherent addressing for the urb_buffer
+ * @dma: Allocated DMA handle
+ * @sgt: sgt_table with the urb locations in memory
  * @async_operations: counter to indicate the number of copy operations
  * @copy_operations: work descriptors for asynchronous copy operations
  * @work: work queue entry for asynchronous decode
@@ -556,6 +558,7 @@ struct uvc_urb {
 
 	char *buffer;
 	dma_addr_t dma;
+	struct sg_table *sgt;
 
 	unsigned int async_operations;
 	struct uvc_copy_op copy_operations[UVC_MAX_PACKETS];
-- 
2.31.0.rc2.261.g7f71774620-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
