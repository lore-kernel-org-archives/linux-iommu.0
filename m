Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2171C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 22:39:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB5764F6A
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 22:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB5764F6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43E60707EB;
	Fri, 12 Mar 2021 22:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H_3YP_otk7m1; Fri, 12 Mar 2021 22:39:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B45776FF2C;
	Fri, 12 Mar 2021 22:39:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F1E3C000B;
	Fri, 12 Mar 2021 22:39:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30A05C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 22:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BBE3605B2
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 22:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lZPkWR2lRxvH for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 22:16:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 486826059E
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 22:16:05 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id e7so47729294lft.2
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 14:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R+VuipI8GDfaAAjeJEZCdXa5pRu8BLtYELXgF7w4NuU=;
 b=A+9yLyb8gMKSbtfRgBEy22hG16q4UVU1d0lDdifY2PdkURP+TyOl8Angl9JTr4F6wo
 AX25liYIxgnhCMIpIyaDP6FQppvjfrUgaVgkRlNkO3dqaKFrCkYNBt9f75IMqfEU6rfG
 sNWSND4qqUTkz7LBeowJdWOqEXGKOmkkFvpxuHwZjpM6kOn28XE5p9LYo62J1QS5v8jQ
 Q68FXdVoGKkrMQBs38TvYti/mF7zXScVnc/YOuPuJMDLgh1oKKgY/RQA1teDVB4FzEeh
 e0ogn+wBtVGt3PsMYYI9iGjwsWbwM3RGVxBMfw+v4hmwPW1hnTVvYrhtAqBbeqVPWvCp
 exqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R+VuipI8GDfaAAjeJEZCdXa5pRu8BLtYELXgF7w4NuU=;
 b=nNKL/05Vtu9izjwZxxjx6iMFdv44Z0e6rqyHG9g/6oOcNzkVV6qfII3Z7aGqAs5MGZ
 YJk+jmWwoe64QwhOKwQzy3EFMy9Duf7qGLnin1CHDLfix0/BvCK3P7cdTY1moKMW1F+P
 sWqxvbJZnwKUPgvG+DOpOmKZ7Fwxos+mCfxZ4iwY0aW9JzsQHRiaen+JqX4soZgf8+kg
 TMlfS1NyKe8l5g+FmWq3uLBqejrs2JKxWY7DVt3qilXLEQnDGAJZ3VA2AJlno3M+iyP9
 bgQcGCVT+f5CYQ1NLAU0LAJJ8SFKhzIuxGZ4tj4BUB4ZS7lV3euTncOR+faYxbSds93Z
 yWGQ==
X-Gm-Message-State: AOAM531I6Xzz9K3OJEF0umB7EHq8LzIvoIoNncngO+V32RAb0SNFcRDF
 k8lHDAoTxohqZIOesQRuVDnqJCxBuG+odNiS88o=
X-Google-Smtp-Source: ABdhPJytZ340QxWrOyyyZRjRpzvK+UReq2zUBxkqQHruH3HwXeQwdFr0XB0keebxcuNZbvh/3My3+C9O1p03BicQJvE=
X-Received: by 2002:a19:74c:: with SMTP id 73mr773699lfh.316.1615587363056;
 Fri, 12 Mar 2021 14:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20210312125709.1347177-1-ribalda@chromium.org>
 <YEvZ17VIP6WbpHdm@pendragon.ideasonboard.com>
In-Reply-To: <YEvZ17VIP6WbpHdm@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 12 Mar 2021 23:15:46 +0100
Message-ID: <CAPybu_1EvEWuAOXM5yK4yY=2EH+9yWYGf5Rky5aKb4NUatG9Ug@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] media: uvcvideo: Use dma_alloc_noncontiguous API
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailman-Approved-At: Fri, 12 Mar 2021 22:39:10 +0000
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 linux-media <linux-media@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Laurent

Thanks a lot for the review

On Fri, Mar 12, 2021 at 10:19 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Fri, Mar 12, 2021 at 01:57:09PM +0100, Ricardo Ribalda wrote:
> > On architectures where there is no coherent caching such as ARM use the
> > dma_alloc_noncontiguous API and handle manually the cache flushing using
> > dma_sync_sgtable().
>
> You're actually switching to dma_alloc_noncontiguous() unconditionally,
> not only on those architectures :-) Do I assume correctly that
> dma_alloc_noncontiguous() will do the right thing on x86 too ?

Yes dma_alloc_noncontiguous does all the magic. It falls back to
alloc_dma_pages. Christoph has done a great job.

I tried it in my notebook and although the images are nothing but
pretty it is not the APIs fault. It is because the barbers are closed
due to the pandemic ;).

>
> > With this patch on the affected architectures we can measure up to 20x
> > performance improvement in uvc_video_copy_data_work().
>
> Have you measured performances on x86 to ensure there's no regression ?

Yes in the early stages. I am adding the latest x86 measurements in
the commit message in v3 to make it more clear.

>
> > Eg: aarch64 with an external usb camera
> >
> > NON_CONTIGUOUS
> > frames:  999
> > packets: 999
> > empty:   0 (0 %)
> > errors:  0
> > invalid: 0
> > pts: 0 early, 0 initial, 999 ok
> > scr: 0 count ok, 0 diff ok
> > sof: 2048 <= sof <= 0, freq 0.000 kHz
> > bytes 67034480 : duration 33303
> > FPS: 29.99
> > URB: 523446/4993 uS/qty: 104.836 avg 132.532 std 13.230 min 831.094 max (uS)
> > header: 76564/4993 uS/qty: 15.334 avg 15.229 std 3.438 min 186.875 max (uS)
> > latency: 468945/4992 uS/qty: 93.939 avg 132.577 std 9.531 min 824.010 max (uS)
> > decode: 54161/4993 uS/qty: 10.847 avg 6.313 std 1.614 min 111.458 max (uS)
> > raw decode speed: 9.931 Gbits/s
> > raw URB handling speed: 1.025 Gbits/s
> > throughput: 16.102 Mbits/s
> > URB decode CPU usage 0.162600 %
> >
> > COHERENT
> > frames:  999
> > packets: 999
> > empty:   0 (0 %)
> > errors:  0
> > invalid: 0
> > pts: 0 early, 0 initial, 999 ok
> > scr: 0 count ok, 0 diff ok
> > sof: 2048 <= sof <= 0, freq 0.000 kHz
> > bytes 54683536 : duration 33302
> > FPS: 29.99
> > URB: 1478135/4000 uS/qty: 369.533 avg 390.357 std 22.968 min 3337.865 max (uS)
> > header: 79761/4000 uS/qty: 19.940 avg 18.495 std 1.875 min 336.719 max (uS)
> > latency: 281077/4000 uS/qty: 70.269 avg 83.102 std 5.104 min 735.000 max (uS)
> > decode: 1197057/4000 uS/qty: 299.264 avg 318.080 std 1.615 min 2806.667 max (uS)
> > raw decode speed: 365.470 Mbits/s
> > raw URB handling speed: 295.986 Mbits/s
> > throughput: 13.136 Mbits/s
> > URB decode CPU usage 3.594500 %
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >
> > Changelog from v2: (Thanks Laurent)
> >
> > - Fix typos
> > - Use the right dma direction if not capturing
> > - Clear sgt during free
> >
> >  drivers/media/usb/uvc/uvc_video.c | 92 +++++++++++++++++++++++--------
> >  drivers/media/usb/uvc/uvcvideo.h  |  5 +-
> >  2 files changed, 74 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index f2f565281e63..8e60f81e2257 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -6,11 +6,14 @@
> >   *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
> >   */
> >
> > +#include <linux/dma-mapping.h>
> > +#include <linux/highmem.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/usb.h>
> > +#include <linux/usb/hcd.h>
> >  #include <linux/videodev2.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/wait.h>
> > @@ -1096,6 +1099,34 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
> >       return data[0];
> >  }
> >
> > +static inline enum dma_data_direction stream_dir(struct uvc_streaming *stream)
> > +{
> > +     if (stream->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
> > +             return DMA_FROM_DEVICE;
> > +     else
> > +             return DMA_TO_DEVICE;
> > +}
> > +
> > +static inline struct device *stream_to_dmadev(struct uvc_streaming *stream)
> > +{
> > +     return bus_to_hcd(stream->dev->udev->bus)->self.sysdev;
> > +}
> > +
> > +static void uvc_urb_dma_sync(struct uvc_urb *uvc_urb, bool for_device)
>
> Maybe nitpicking a little bit, but wouldn't the code be clearer if you
> created uvc_urb_dma_sync_for_cpu() and uvc_urb_dma_sync_for_device() ?
> When reading
>
>         uvc_urb_dma_sync(uvc_urb, true);
>
> I have to constantly look up the definition of the function to figure
> out what boolean value corresponds to what direction.
>
> Given that uvc_urb_dma_sync(..., true) is always called right before
> submitting the URB, we could even create a uvc_submit_urb() function
> that groups the dma_sync_sgtable_for_device() and usb_submit_urb()
> calls, and do without uvc_urb_dma_sync_for_device(). Up to you on this
> one.

I Like it! thanks for the idea

>
> With those small changes, and assuming there's no performance regression
> on x86,

How do we take it from here. Christoph merges it from his tree?

>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > +{
> > +     struct device *dma_dev = stream_to_dmadev(uvc_urb->stream);
> > +
> > +     if (for_device) {
> > +             dma_sync_sgtable_for_device(dma_dev, uvc_urb->sgt,
> > +                                         stream_dir(uvc_urb->stream));
> > +     } else {
> > +             dma_sync_sgtable_for_cpu(dma_dev, uvc_urb->sgt,
> > +                                      stream_dir(uvc_urb->stream));
> > +             invalidate_kernel_vmap_range(uvc_urb->buffer,
> > +                                          uvc_urb->stream->urb_size);
> > +     }
> > +}
> > +
> >  /*
> >   * uvc_video_decode_data_work: Asynchronous memcpy processing
> >   *
> > @@ -1117,6 +1148,8 @@ static void uvc_video_copy_data_work(struct work_struct *work)
> >               uvc_queue_buffer_release(op->buf);
> >       }
> >
> > +     uvc_urb_dma_sync(uvc_urb, true);
> > +
> >       ret = usb_submit_urb(uvc_urb->urb, GFP_KERNEL);
> >       if (ret < 0)
> >               dev_err(&uvc_urb->stream->intf->dev,
> > @@ -1541,10 +1574,12 @@ static void uvc_video_complete(struct urb *urb)
> >        * Process the URB headers, and optionally queue expensive memcpy tasks
> >        * to be deferred to a work queue.
> >        */
> > +     uvc_urb_dma_sync(uvc_urb, false);
> >       stream->decode(uvc_urb, buf, buf_meta);
> >
> >       /* If no async work is needed, resubmit the URB immediately. */
> >       if (!uvc_urb->async_operations) {
> > +             uvc_urb_dma_sync(uvc_urb, true);
> >               ret = usb_submit_urb(uvc_urb->urb, GFP_ATOMIC);
> >               if (ret < 0)
> >                       dev_err(&stream->intf->dev,
> > @@ -1560,24 +1595,49 @@ static void uvc_video_complete(struct urb *urb)
> >   */
> >  static void uvc_free_urb_buffers(struct uvc_streaming *stream)
> >  {
> > +     struct device *dma_dev = stream_to_dmadev(stream);
> >       struct uvc_urb *uvc_urb;
> >
> >       for_each_uvc_urb(uvc_urb, stream) {
> >               if (!uvc_urb->buffer)
> >                       continue;
> >
> > -#ifndef CONFIG_DMA_NONCOHERENT
> > -             usb_free_coherent(stream->dev->udev, stream->urb_size,
> > -                               uvc_urb->buffer, uvc_urb->dma);
> > -#else
> > -             kfree(uvc_urb->buffer);
> > -#endif
> > +             dma_vunmap_noncontiguous(dma_dev, uvc_urb->buffer);
> > +             dma_free_noncontiguous(dma_dev, stream->urb_size, uvc_urb->sgt,
> > +                                    stream_dir(stream));
> > +
> >               uvc_urb->buffer = NULL;
> > +             uvc_urb->sgt = NULL;
> >       }
> >
> >       stream->urb_size = 0;
> >  }
> >
> > +static bool uvc_alloc_urb_buffer(struct uvc_streaming *stream,
> > +                              struct uvc_urb *uvc_urb, gfp_t gfp_flags)
> > +{
> > +     struct device *dma_dev = stream_to_dmadev(stream);
> > +
> > +     uvc_urb->sgt = dma_alloc_noncontiguous(dma_dev, stream->urb_size,
> > +                                            stream_dir(stream),
> > +                                            gfp_flags, 0);
> > +     if (!uvc_urb->sgt)
> > +             return false;
> > +     uvc_urb->dma = uvc_urb->sgt->sgl->dma_address;
> > +
> > +     uvc_urb->buffer = dma_vmap_noncontiguous(dma_dev, stream->urb_size,
> > +                                              uvc_urb->sgt);
> > +     if (!uvc_urb->buffer) {
> > +             dma_free_noncontiguous(dma_dev, stream->urb_size,
> > +                                    uvc_urb->sgt,
> > +                                    stream_dir(stream));
> > +             uvc_urb->sgt = NULL;
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >  /*
> >   * Allocate transfer buffers. This function can be called with buffers
> >   * already allocated when resuming from suspend, in which case it will
> > @@ -1608,19 +1668,12 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
> >
> >       /* Retry allocations until one succeed. */
> >       for (; npackets > 1; npackets /= 2) {
> > +             stream->urb_size = psize * npackets;
> > +
> >               for (i = 0; i < UVC_URBS; ++i) {
> >                       struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
> >
> > -                     stream->urb_size = psize * npackets;
> > -#ifndef CONFIG_DMA_NONCOHERENT
> > -                     uvc_urb->buffer = usb_alloc_coherent(
> > -                             stream->dev->udev, stream->urb_size,
> > -                             gfp_flags | __GFP_NOWARN, &uvc_urb->dma);
> > -#else
> > -                     uvc_urb->buffer =
> > -                         kmalloc(stream->urb_size, gfp_flags | __GFP_NOWARN);
> > -#endif
> > -                     if (!uvc_urb->buffer) {
> > +                     if (!uvc_alloc_urb_buffer(stream, uvc_urb, gfp_flags)) {
> >                               uvc_free_urb_buffers(stream);
> >                               break;
> >                       }
> > @@ -1730,12 +1783,8 @@ static int uvc_init_video_isoc(struct uvc_streaming *stream,
> >               urb->context = uvc_urb;
> >               urb->pipe = usb_rcvisocpipe(stream->dev->udev,
> >                               ep->desc.bEndpointAddress);
> > -#ifndef CONFIG_DMA_NONCOHERENT
> >               urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
> >               urb->transfer_dma = uvc_urb->dma;
> > -#else
> > -             urb->transfer_flags = URB_ISO_ASAP;
> > -#endif
> >               urb->interval = ep->desc.bInterval;
> >               urb->transfer_buffer = uvc_urb->buffer;
> >               urb->complete = uvc_video_complete;
> > @@ -1795,10 +1844,8 @@ static int uvc_init_video_bulk(struct uvc_streaming *stream,
> >
> >               usb_fill_bulk_urb(urb, stream->dev->udev, pipe, uvc_urb->buffer,
> >                                 size, uvc_video_complete, uvc_urb);
> > -#ifndef CONFIG_DMA_NONCOHERENT
> >               urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
> >               urb->transfer_dma = uvc_urb->dma;
> > -#endif
> >
> >               uvc_urb->urb = urb;
> >       }
> > @@ -1895,6 +1942,7 @@ static int uvc_video_start_transfer(struct uvc_streaming *stream,
> >
> >       /* Submit the URBs. */
> >       for_each_uvc_urb(uvc_urb, stream) {
> > +             uvc_urb_dma_sync(uvc_urb, true);
> >               ret = usb_submit_urb(uvc_urb->urb, gfp_flags);
> >               if (ret < 0) {
> >                       dev_err(&stream->intf->dev,
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 97df5ecd66c9..cce5e38133cd 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -219,6 +219,7 @@
> >   */
> >
> >  struct gpio_desc;
> > +struct sg_table;
> >  struct uvc_device;
> >
> >  /* TODO: Put the most frequently accessed fields at the beginning of
> > @@ -545,7 +546,8 @@ struct uvc_copy_op {
> >   * @urb: the URB described by this context structure
> >   * @stream: UVC streaming context
> >   * @buffer: memory storage for the URB
> > - * @dma: DMA coherent addressing for the urb_buffer
> > + * @dma: Allocated DMA handle
> > + * @sgt: sgt_table with the urb locations in memory
> >   * @async_operations: counter to indicate the number of copy operations
> >   * @copy_operations: work descriptors for asynchronous copy operations
> >   * @work: work queue entry for asynchronous decode
> > @@ -556,6 +558,7 @@ struct uvc_urb {
> >
> >       char *buffer;
> >       dma_addr_t dma;
> > +     struct sg_table *sgt;
> >
> >       unsigned int async_operations;
> >       struct uvc_copy_op copy_operations[UVC_MAX_PACKETS];
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
