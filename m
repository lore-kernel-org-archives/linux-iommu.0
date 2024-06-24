Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581C1A00F2
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252678; cv=none; b=nYwEf6W2NfaLr+L3KKE/HGGzQKxdsCPMtEFdFqu/1LHzk8dpO6Ggrt3GzxpZXM57Etpv+0+bw1OSK8hrO326KyfFw7qJtzGmY4ndhS+Ek1tIhmKNadwvHJe1Wwg9rXTtWXISkkVVXCU2STdEqPnAna1sH8QSCJNZjhSV4eZczqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252678; c=relaxed/simple;
	bh=nIUdy22oglBfUryv7MbqxD7BiJz15+mnbfSouo20eE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUONbxVSefsRHBDNajDtJDIBAsXxfDuTUrQItXvFzA2vHaI12B1ULA3IITBV1pbDCisl8Guo5V5VGjpY7ZVvigOSdvrA9zKSpNytfX3R8SD+GjbzgLlsG2euBzbZf1zbs5aiqMtRUBLGMqjKtJsETdtoRM9JWka4m8+npxpD5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=imvOUA9l; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="imvOUA9l"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-630640c1e14so47692897b3.1
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1719252675; x=1719857475; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5jGR9g/Bb8Va571zVMLt5UXvxDZ++mFdkIqRAoUvAic=;
        b=imvOUA9licA6/LJdZPYNKwnByY0jsI4wygYLj52EyPWFaFKKa6M6zPSSvk1nCbn30N
         afvSPI/mZIkwXeWA+pi9Buq/e6dcUC4jKJDWqNSVq+itzGUaj4D/0nqxfL3GEGGsQFEw
         TZ+xHfVKZBmR9QX3HFgcyEmWw7EHk3UXPLMXfmvSXKsUj8i5fIl+tghAgh11+gjHs+x5
         N3GkWcN9w9GVDJI9TFICzuEH+nIyMqGDZMC9WZSdEB2x7fNuq0iiejSEP3uLzS5vSPCk
         n8sT0QR3SN2sYC5C5fHv4eGU2sfwqOQ2ioGOK4SeFGcN0GccV1+cnqxNfjNIT7mUaSwr
         Bwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252675; x=1719857475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jGR9g/Bb8Va571zVMLt5UXvxDZ++mFdkIqRAoUvAic=;
        b=U/ZIbYk+8ZQj03yi51RvxpJxEnLqbrJVvHTgShGLGo6tU19ZTiA6HpMmxK/7EhQ4iv
         FIPlo0Pqghh7SBynK0gYWSF95bRJZmIRR5CupFbHoEWLPPQz5+L1OQLkBHLCXYZ9dCI1
         WU6SW3PUCL0bZaaER1v6CePGwJOcm1aWWg4KEyVhphFs4O3VC5aH8U7xV7AsNth/LFqI
         d3U6XO2suUTFqxrgYf6DlDDf9ltY+eUTO9abhEUnDC/XT1jofxiXk9+/Pu7j0RS2EjCb
         nK308JNEoXW8Aj7hmbPvBCqL96dUXDWGMXh65PVnwo4fPzbAiWTajgZIiaCcUu8x9ZEU
         vctA==
X-Forwarded-Encrypted: i=1; AJvYcCWBuyrv3NnHLdaiVMhfGPcCs24LHopcTtS7BATBNXne0YtI588Im01Qq3skycigbhCNJD1/Iv/y5JFCrh5tWaEfVJ70Gps=
X-Gm-Message-State: AOJu0YzWJnXXIP7yTz7KKAtJnbPPXsQBzgGNyiz3df4+UTUVQrEVtKUs
	aNMYN3sueWz6wKavh+rWO4J0VH+liR3CFulCh28Qzi9KfXZ2tHVfnpSOyP+WxAVtxIZK/t7iiR4
	MzurHdcmXpUFmOG52wvYtRt5lL9IYH0blIcpsug==
X-Google-Smtp-Source: AGHT+IFaAqmhNPlm6MCoDVgffhkfuksOWP1wIZM8AnbBnkW6RDpNrHr6R7v3rNj3Wz45MorU/sgEZjJu5xv7+4bnw1s=
X-Received: by 2002:a25:c54d:0:b0:e02:bf87:7cd4 with SMTP id
 3f1490d57ef6-e0303fea2bdmr5469380276.53.1719252675064; Mon, 24 Jun 2024
 11:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
 <20240524182702.1317935-9-dave.stevenson@raspberrypi.com> <ZmCo4IfRhEzMf9gs@lizhi-Precision-Tower-5810>
In-Reply-To: <ZmCo4IfRhEzMf9gs@lizhi-Precision-Tower-5810>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 24 Jun 2024 19:10:58 +0100
Message-ID: <CAPY8ntBNz5tGfVz7FJ0wvzxWZ+AyjbTn7JbDFX=cNq-EN2Vu5A@mail.gmail.com>
Subject: Re: [PATCH 08/18] dmaengine: bcm2835: pass dma_chan to generic functions
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

Hi Frank.

On Wed, 5 Jun 2024 at 19:05, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, May 24, 2024 at 07:26:52PM +0100, Dave Stevenson wrote:
> > From: Stefan Wahren <stefan.wahren@i2se.com>
> >
> > In preparation to support more platforms pass the dma_chan to the
> > generic functions. This provides access to the DMA device and possible
> > platform specific data.
>
> why need this change? you can easy convert between dma_chan and
> bcm2835_chan.

These patches are leading to adding a bcm2711_chan structure for a new
(but very closely related) variant of the DMA controller.

dma_chan is the generic structure, therefore we can keep more
commonality between the variants if we use that wherever possible.

  Dave

> >
> > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > ---
> >  drivers/dma/bcm2835-dma.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> > index e2f9c8692e6b..aefaa1f01d7f 100644
> > --- a/drivers/dma/bcm2835-dma.c
> > +++ b/drivers/dma/bcm2835-dma.c
> > @@ -288,12 +288,13 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
> >  }
> >
> >  static bool
> > -bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
> > +bcm2835_dma_create_cb_set_length(struct dma_chan *chan,
> >                                struct bcm2835_dma_cb *control_block,
> >                                size_t len, size_t period_len,
> >                                size_t *total_len)
> >  {
> > -     size_t max_len = bcm2835_dma_max_frame_length(chan);
> > +     struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> > +     size_t max_len = bcm2835_dma_max_frame_length(c);
> >
> >       /* set the length taking lite-channel limitations into account */
> >       control_block->length = min_t(u32, len, max_len);
> > @@ -417,7 +418,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
> >               /* set up length in control_block if requested */
> >               if (buf_len) {
> >                       /* calculate length honoring period_length */
> > -                     if (bcm2835_dma_create_cb_set_length(c, control_block,
> > +                     if (bcm2835_dma_create_cb_set_length(chan, control_block,
> >                                                            len, period_len,
> >                                                            &total_len)) {
> >                               /* add extrainfo bits in info */
> > @@ -485,8 +486,9 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
> >       }
> >  }
> >
> > -static void bcm2835_dma_abort(struct bcm2835_chan *c)
> > +static void bcm2835_dma_abort(struct dma_chan *chan)
> >  {
> > +     struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> >       void __iomem *chan_base = c->chan_base;
> >       long int timeout = 10000;
> >
> > @@ -513,8 +515,9 @@ static void bcm2835_dma_abort(struct bcm2835_chan *c)
> >       writel(BCM2835_DMA_RESET, chan_base + BCM2835_DMA_CS);
> >  }
> >
> > -static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
> > +static void bcm2835_dma_start_desc(struct dma_chan *chan)
> >  {
> > +     struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> >       struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
> >       struct bcm2835_desc *d;
> >
> > @@ -533,7 +536,8 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
> >
> >  static irqreturn_t bcm2835_dma_callback(int irq, void *data)
> >  {
> > -     struct bcm2835_chan *c = data;
> > +     struct dma_chan *chan = data;
> > +     struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> >       struct bcm2835_desc *d;
> >       unsigned long flags;
> >
> > @@ -566,7 +570,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
> >                       vchan_cyclic_callback(&d->vd);
> >               } else if (!readl(c->chan_base + BCM2835_DMA_ADDR)) {
> >                       vchan_cookie_complete(&c->desc->vd);
> > -                     bcm2835_dma_start_desc(c);
> > +                     bcm2835_dma_start_desc(chan);
> >               }
> >       }
> >
> > @@ -594,7 +598,7 @@ static int bcm2835_dma_alloc_chan_resources(struct dma_chan *chan)
> >       }
> >
> >       return request_irq(c->irq_number, bcm2835_dma_callback,
> > -                        c->irq_flags, "DMA IRQ", c);
> > +                        c->irq_flags, "DMA IRQ", chan);
> >  }
> >
> >  static void bcm2835_dma_free_chan_resources(struct dma_chan *chan)
> > @@ -682,7 +686,7 @@ static void bcm2835_dma_issue_pending(struct dma_chan *chan)
> >
> >       spin_lock_irqsave(&c->vc.lock, flags);
> >       if (vchan_issue_pending(&c->vc) && !c->desc)
> > -             bcm2835_dma_start_desc(c);
> > +             bcm2835_dma_start_desc(chan);
> >
> >       spin_unlock_irqrestore(&c->vc.lock, flags);
> >  }
> > @@ -846,7 +850,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
> >       if (c->desc) {
> >               vchan_terminate_vdesc(&c->desc->vd);
> >               c->desc = NULL;
> > -             bcm2835_dma_abort(c);
> > +             bcm2835_dma_abort(chan);
> >       }
> >
> >       vchan_get_all_descriptors(&c->vc, &head);
> > --
> > 2.34.1
> >
