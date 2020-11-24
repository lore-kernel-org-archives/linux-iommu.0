Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D5AC64E75
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 17:25:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F792087C
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 17:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O1otos6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F792087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1A6D0214EC;
	Tue, 24 Nov 2020 17:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXE3GGNKVS68; Tue, 24 Nov 2020 17:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 173412045C;
	Tue, 24 Nov 2020 17:25:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF2C5C163C;
	Tue, 24 Nov 2020 17:25:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68783C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 17:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5F247214EC
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 17:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IXdOLB6grcQ8 for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 17:25:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
 [209.85.166.196])
 by silver.osuosl.org (Postfix) with ESMTPS id AD1282045C
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 17:25:44 +0000 (UTC)
Received: by mail-il1-f196.google.com with SMTP id z12so7259398ilu.8
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z6tlEwV2va2PDMozZGMdT895LM4tZsvIbgGRKWaEoV4=;
 b=O1otos6rFw3st6xur2OtmZ59kmbeoRug0Ytr6D48haYnFV/4i5YTnbi7zgXShcxOYw
 qW4Lxi/kxwNU/9Q+YW3586WdhZjbM0GSSV2zXURBFZGjJuH+gfoFZj+6309L5sfOP7Uz
 ZNE/98YEWZrRlCURKbfdWnqDbiBV906YsvYKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z6tlEwV2va2PDMozZGMdT895LM4tZsvIbgGRKWaEoV4=;
 b=nRiH6td5mw/5vXGjBHxL+yCDxwDgZv/XouAcUwVDY537ZzhpkZIaT4AVJ3nHcBsfvT
 llKn2jtSIyDk+IKEZyHOAwVkSXe9z0r1/u++JpeEv24zjTHXhjLIMdw9904sRbJ20RP4
 VneVY1zw4MC3Ci8AuC3g+5rX8ZORmb1FDmhTZKlmAyva8ynOOjCaqDyYN58SUXzC/nXR
 Lzc+/5/ksD+8aAAiANbcmCO2QMuIwUwzqWXyynb1vywpPs9K91eUdn5FZo1EN8+cTUBt
 R3mLYFD1bbePsBOw95cd5xQG+gIZ4A/ig87AcoMmxlgIGYNyA8Q3wkcih2TY34P6j1Ik
 CBUQ==
X-Gm-Message-State: AOAM533B5d+FRpXEX5l/onSGOsVeRBRct5n5RiTtAvuT2HrWmEQaVNq6
 iEDwvVGG0KNX79KbcewhtfJXhQfudoiNTz5v
X-Google-Smtp-Source: ABdhPJzkC2qjHNRlBAJrgQNXtFJ0k9yuWg5OnYD3BgS+byCAeqm8Q6Kl6ktCvAAARYUf0p8S4xtWCQ==
X-Received: by 2002:a92:1306:: with SMTP id 6mr2136352ilt.87.1606238743446;
 Tue, 24 Nov 2020 09:25:43 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com.
 [209.85.166.44])
 by smtp.gmail.com with ESMTPSA id w89sm10745718ili.73.2020.11.24.09.25.41
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2020 09:25:42 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id s10so22765060ioe.1
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:25:41 -0800 (PST)
X-Received: by 2002:a02:b144:: with SMTP id s4mr5587937jah.32.1606238741494;
 Tue, 24 Nov 2020 09:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20201124153845.132207-1-ribalda@chromium.org>
 <20201124153845.132207-5-ribalda@chromium.org>
 <f1055d12-8bde-80d0-29f3-dfbfbf59cc11@arm.com>
In-Reply-To: <f1055d12-8bde-80d0-29f3-dfbfbf59cc11@arm.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 24 Nov 2020 18:25:30 +0100
X-Gmail-Original-Message-ID: <CANiDSCuVgN=d-TdW1T0EVxMALhyOcy2Sc511D4SkxN_1kh8h9A@mail.gmail.com>
Message-ID: <CANiDSCuVgN=d-TdW1T0EVxMALhyOcy2Sc511D4SkxN_1kh8h9A@mail.gmail.com>
Subject: Re: [PATCH 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To: Robin Murphy <robin.murphy@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Christoph Hellwig <hch@lst.de>
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

Hi Robin

On Tue, Nov 24, 2020 at 5:29 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-11-24 15:38, Ricardo Ribalda wrote:
> > On architectures where the is no coherent caching such as ARM use the
> > dma_alloc_noncontiguos API and handle manually the cache flushing using
> > dma_sync_single().
> >
> > With this patch on the affected architectures we can measure up to 20x
> > performance improvement in uvc_video_copy_data_work().
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >   drivers/media/usb/uvc/uvc_video.c | 74 ++++++++++++++++++++++++++-----
> >   drivers/media/usb/uvc/uvcvideo.h  |  1 +
> >   2 files changed, 63 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index a6a441d92b94..9e90b261428a 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -1490,6 +1490,11 @@ static void uvc_video_encode_bulk(struct uvc_urb *uvc_urb,
> >       urb->transfer_buffer_length = stream->urb_size - len;
> >   }
> >
> > +static inline struct device *stream_to_dmadev(struct uvc_streaming *stream)
> > +{
> > +     return stream->dev->udev->bus->controller->parent;
> > +}
> > +
> >   static void uvc_video_complete(struct urb *urb)
> >   {
> >       struct uvc_urb *uvc_urb = urb->context;
> > @@ -1539,6 +1544,11 @@ static void uvc_video_complete(struct urb *urb)
> >        * Process the URB headers, and optionally queue expensive memcpy tasks
> >        * to be deferred to a work queue.
> >        */
> > +     if (uvc_urb->pages)
> > +             dma_sync_single_for_cpu(stream_to_dmadev(stream),
> > +                                     urb->transfer_dma,
> > +                                     urb->transfer_buffer_length,
> > +                                     DMA_FROM_DEVICE);
>
> This doesn't work. Even in iommu-dma, the streaming API still expects to
> work on physically-contiguous memory that could have been passed to
> dma_map_single() in the first place. As-is, this will invalidate
> transfer_buffer_length bytes from the start of the *first* physical
> page, and thus destroy random other data if lines from subsequent
> unrelated pages are dirty in caches.
>
> The only feasible way to do a DMA sync on disjoint pages in a single
> call is with a scatterlist.

Thanks for pointing this out. I guess I was lucky on my hardware and
the areas were always  contiguous.

Will rework and send back to the list.

Thanks again.

>
> Robin.
>
> >       stream->decode(uvc_urb, buf, buf_meta);
> >
> >       /* If no async work is needed, resubmit the URB immediately. */
> > @@ -1566,8 +1576,15 @@ static void uvc_free_urb_buffers(struct uvc_streaming *stream)
> >                       continue;
> >
> >   #ifndef CONFIG_DMA_NONCOHERENT
> > -             usb_free_coherent(stream->dev->udev, stream->urb_size,
> > -                               uvc_urb->buffer, uvc_urb->dma);
> > +             if (uvc_urb->pages) {
> > +                     vunmap(uvc_urb->buffer);
> > +                     dma_free_noncontiguous(stream_to_dmadev(stream),
> > +                                            stream->urb_size,
> > +                                            uvc_urb->pages, uvc_urb->dma);
> > +             } else {
> > +                     usb_free_coherent(stream->dev->udev, stream->urb_size,
> > +                                       uvc_urb->buffer, uvc_urb->dma);
> > +             }
> >   #else
> >               kfree(uvc_urb->buffer);
> >   #endif
> > @@ -1577,6 +1594,47 @@ static void uvc_free_urb_buffers(struct uvc_streaming *stream)
> >       stream->urb_size = 0;
> >   }
> >
> > +#ifndef CONFIG_DMA_NONCOHERENT
> > +static bool uvc_alloc_urb_buffer(struct uvc_streaming *stream,
> > +                              struct uvc_urb *uvc_urb, gfp_t gfp_flags)
> > +{
> > +     struct device *dma_dev = dma_dev = stream_to_dmadev(stream);
> > +
> > +     if (!dma_can_alloc_noncontiguous(dma_dev)) {
> > +             uvc_urb->buffer = usb_alloc_coherent(stream->dev->udev,
> > +                                                  stream->urb_size,
> > +                                                  gfp_flags | __GFP_NOWARN,
> > +                                                  &uvc_urb->dma);
> > +             return uvc_urb->buffer != NULL;
> > +     }
> > +
> > +     uvc_urb->pages = dma_alloc_noncontiguous(dma_dev, stream->urb_size,
> > +                                              &uvc_urb->dma,
> > +                                              gfp_flags | __GFP_NOWARN, 0);
> > +     if (!uvc_urb->pages)
> > +             return false;
> > +
> > +     uvc_urb->buffer = vmap(uvc_urb->pages,
> > +                            PAGE_ALIGN(stream->urb_size) >> PAGE_SHIFT,
> > +                            VM_DMA_COHERENT, PAGE_KERNEL);
> > +     if (!uvc_urb->buffer) {
> > +             dma_free_noncontiguous(dma_dev, stream->urb_size,
> > +                                    uvc_urb->pages, uvc_urb->dma);
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +#else
> > +static bool uvc_alloc_urb_buffer(struct uvc_streaming *stream,
> > +                              struct uvc_urb *uvc_urb, gfp_t gfp_flags)
> > +{
> > +     uvc_urb->buffer = kmalloc(stream->urb_size, gfp_flags | __GFP_NOWARN);
> > +
> > +     return uvc_urb->buffer != NULL;
> > +}
> > +#endif
> > +
> >   /*
> >    * Allocate transfer buffers. This function can be called with buffers
> >    * already allocated when resuming from suspend, in which case it will
> > @@ -1607,19 +1665,11 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
> >
> >       /* Retry allocations until one succeed. */
> >       for (; npackets > 1; npackets /= 2) {
> > +             stream->urb_size = psize * npackets;
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
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index a3dfacf069c4..3e3ef1f1daa5 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -532,6 +532,7 @@ struct uvc_urb {
> >
> >       char *buffer;
> >       dma_addr_t dma;
> > +     struct page **pages;
> >
> >       unsigned int async_operations;
> >       struct uvc_copy_op copy_operations[UVC_MAX_PACKETS];
> >



-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
