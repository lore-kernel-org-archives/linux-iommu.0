Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142919FA61
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251281; cv=none; b=obIhSnvBkutfEH4gfq+BFGd293JOntlTesSogrAQ6dGLxj+1BC5RHZifaDX5ASN/xWXeVRdNSJXQGF1Kp0uHS2IOw//E5vdH0JkdLsdqdsKJhUTdFjUcjb2BCHr86jHWZ9c7t73bQqrUwSzOFJIbKsa9yuhO6/LF3JBxo0X3RNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251281; c=relaxed/simple;
	bh=P1jGE0yj+W9MBcCc+1zGVoDh+/I8AA93BhngLeHVOT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kq34c6s7cbKfaryTGXagWVL/bXCpwbWv1rsD0cq0e5IxXECfo0CMGZuvTRYY2SfX4jgnYI5RTK88VkWFWQP83hHWY9RO014UMJzqRu0UEeM8FYxeoK3AM0bc52BR+XUcuvGeiYoAan0ndMSYU6ogHuo6zCG4CBXMPjHaXbNC1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=gdXtFr95; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="gdXtFr95"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e02748b2402so4919151276.0
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1719251278; x=1719856078; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GD6JszPohU81NGGS/aKdIrLNqexC1KvwW9h5dgcZ2tY=;
        b=gdXtFr95D4cb652y3+eweFABJectnzatSxa4rRbT1B6Tq+x8WgH4JeSBM/GYcKrLeN
         jrLyRCwlpGqiQ05Rmfe0IxbjSfZhyRToxlUPynQRBUqWISX3hPH1nsZhioDqIh5V0j1m
         gmliWZmAxK4cebaMr9P0pHuUUvRP66yG9eKIFk/SJ9AtG4ZTK7jy5cNvDrswnAUcl8+e
         9uAx4irXGH1CPTSBznEmsG42xgDp63bpxqHvhpZHFP5MH/1vRDEOtJ9pzqIqWkctkbgI
         8dMsWGzy3rFDmtQlIPcnz+44UlilVMPBOktNWRXHn/FG4neSSQc5UH35Hmj09yI6oBG/
         RMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251278; x=1719856078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GD6JszPohU81NGGS/aKdIrLNqexC1KvwW9h5dgcZ2tY=;
        b=kRobm3/tadfPrezMpfGpKT2I3a6j6F3Ngq2/4wN04TrZlzOEPxWq8yPVfhTdKkuXfb
         RvDVqYOO2VurqohHEYxq3hGj7XmqNBx0Xvv38I5+WXxy+e8yh7ApwGvH6+oc718NpK5r
         N11V6xkwwENtvzRCO80ye3mt8/kOWo7PpZtkSK2aMUWnCFq+ZUNGFQqNXMm5tmXnyJQ6
         vOHEf9sWo/cuQUrz4H4pBXADOIBDnO8FlhF3oLswwPSRcefa/Q3GEFX8tQnxCXzjdI3y
         PPtMjZjHodQ/HInng9TsqVKE2ComqHZcG2H+xM1aY8pJKEGuPcnu+SZwFodlZdLEnFex
         SDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcB4GDqYcX1WbQJhlkugEkCQ0mzY+OwuIJ5IPm4sF9oFXwYhvijAl2smfV3OOtB7pxuO1szoBManmopbP5EEln6k4w+w0=
X-Gm-Message-State: AOJu0Yw0OMJo75auzpqPcr3qJzh5UVp88OPBMvdOgfcJUEUglvIwlkF3
	SRKPT7YvhAV4VMTJFG5cAmtpB5IxAqEJy3lYMbla+jIfJrei6fUTJgb8E9Hp6bleWihE/aXPLZW
	SL7Vovl5+GyDBK3wImVT/pXlMLxRmigCj/BHRdQ==
X-Google-Smtp-Source: AGHT+IEam62Ke7h6aMEIOfZkOn8q0O/x65GpW/b4zmed/2bsjgtR1QeT3Q2l3hKiUKoRuWDKy+pcqMjQukMAFKYFW9Y=
X-Received: by 2002:a25:291:0:b0:df4:f2d2:fcd6 with SMTP id
 3f1490d57ef6-e0303fe9b62mr4805338276.44.1719251277992; Mon, 24 Jun 2024
 10:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
 <20240524182702.1317935-7-dave.stevenson@raspberrypi.com> <ZmCl7LXbdCwJm/wJ@lizhi-Precision-Tower-5810>
In-Reply-To: <ZmCl7LXbdCwJm/wJ@lizhi-Precision-Tower-5810>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 24 Jun 2024 18:47:41 +0100
Message-ID: <CAPY8ntCUzU=T_RgJPGvunYXM2Zmd39Kei-qFaoM37-Vc62TyUQ@mail.gmail.com>
Subject: Re: [PATCH 06/18] dmaengine: bcm2835: make address increment platform independent
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Vladimir Murzin <vladimir.murzin@arm.com>, Phil Elwell <phil@raspberrypi.com>, 
	Stefan Wahren <wahrenst@gmx.net>, Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux.dev, 
	linux-sound@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"

Hi Frank

Thanks for the review, and sorry for the delay in coming back to this.

On Wed, 5 Jun 2024 at 18:53, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, May 24, 2024 at 07:26:50PM +0100, Dave Stevenson wrote:
> > From: Stefan Wahren <stefan.wahren@i2se.com>
> >
> > Actually the criteria to increment source & destination address doesn't
> > based on platform specific bits. It's just the DMA transfer direction which
> > is translated into the info bits. So introduce two new helper functions
> > and get the rid of these platform specifics.
> >
>
> Fix increment source & destination address depend on the platform drvdata.

This is not platform drvdata.

The code was converting from the generic DMA transfer direction enum
into the hardware specific bitmask, and then looking at that for
whether it was using an address increment or not.
It's more readable, and easier to add in the newer variant of the
hardware, if we check the generic transfer direction.

I've reworded it for V2 as

"The criteria for whether an address increment is required is based
solely on the DMA transfer direction. The driver was converting from
direction into the hardware's "info" bitmask and using that, which
is therefore dependent on the hardware variant.

Change to using the DMA transfer direction via helper functions
to remove this hardware specific dependency."

Hopefully makes the situation clearer.

> It should be depend on dma_transfer_direction.
>
> look like it is bug fixes. Can you add fixes tag.

No, as described above, it's not a bug fix.

  Dave

> > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > ---
> >  drivers/dma/bcm2835-dma.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> > index ef452ebb3c15..d6c5a2762a46 100644
> > --- a/drivers/dma/bcm2835-dma.c
> > +++ b/drivers/dma/bcm2835-dma.c
> > @@ -252,6 +252,24 @@ static u32 bcm2835_dma_prepare_cb_extra(struct bcm2835_chan *c,
> >       return result;
> >  }
> >
> > +static inline bool need_src_incr(enum dma_transfer_direction direction)
> > +{
> > +     return direction != DMA_DEV_TO_MEM;
> > +}
> > +
> > +static inline bool need_dst_incr(enum dma_transfer_direction direction)
> > +{
> > +     switch (direction) {
> > +     case DMA_MEM_TO_MEM:
> > +     case DMA_DEV_TO_MEM:
> > +             return true;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
> >  {
> >       size_t i;
> > @@ -336,10 +354,8 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
> >   * @cyclic:         it is a cyclic transfer
> >   * @info:           the default info bits to apply per controlblock
> >   * @frames:         number of controlblocks to allocate
> > - * @src:            the src address to assign (if the S_INC bit is set
> > - *                  in @info, then it gets incremented)
> > - * @dst:            the dst address to assign (if the D_INC bit is set
> > - *                  in @info, then it gets incremented)
> > + * @src:            the src address to assign
> > + * @dst:            the dst address to assign
> >   * @buf_len:        the full buffer length (may also be 0)
> >   * @period_len:     the period length when to apply @finalextrainfo
> >   *                  in addition to the last transfer
> > @@ -408,9 +424,9 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
> >                       d->cb_list[frame - 1].cb->next = cb_entry->paddr;
> >
> >               /* update src and dst and length */
> > -             if (src && (info & BCM2835_DMA_S_INC))
> > +             if (src && need_src_incr(direction))
> >                       src += control_block->length;
> > -             if (dst && (info & BCM2835_DMA_D_INC))
> > +             if (dst && need_dst_incr(direction))
> >                       dst += control_block->length;
> >
> >               /* Length of total transfer */
> > --
> > 2.34.1
> >
