Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75919EEDF
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253648; cv=none; b=CPoWIMyywXVqtnK2/QLWinCcQjNUa85J+7LtYnskDFIDj3jsLDfbyKIG2nyzo/QNhC/bIlWUcz0Te8WEiNh+Kp4+uZLFbxM9gxifnUrP+Yuc9XefEUel67qTXxy9wp+xwuAE9qt5veDA1bKFtDjQzrqJH7XR1zZr/MiKFPMXS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253648; c=relaxed/simple;
	bh=Ejr03O19TrJEODq2u2VVLMyqy5sulXiBL1Qu4ni/tL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8te8EIxwmZ7WFpZUBy1fCXv57GrqnQIcBBtuA6ClWDIZRjFGOZIVCIXsfAmnjx5YJB1RcIKcEcndrXgggI7FiVfF/8cPX2DCiA6pmIwlBcDqOh7sV5y6dQbIUtdBqt/j3saIwnbR3Ik5llRReXLNHx5OMbqzBItzsdOzzsMaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=MfPuNZnD; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="MfPuNZnD"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfef5980a69so4445057276.3
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1719253646; x=1719858446; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TS7GRJVBSbiXIfOc3555Cy+7DvtDs4tYIL95YiKGyb0=;
        b=MfPuNZnD4rXWYcNOHcBAFt+q4FaaSGFtzxV12DpHSR6TJoa7TdoZjUe/G0JdMYy1sh
         rDVJMYQHNPkbz77QAWmBBUqDU+Ta+SMdkjUeWfu+sHExLqnMVjHQzhfAhbwiufOCyYKC
         FiTkbmpzwqpLgCfi0+uYP2Gk3W5vn5W4w37TjshA8FSr0nhfT9v0L9BFWPmPNIv9OPHm
         7cLiwhgT0NmJEyM3Fetw9jTHhS00go+3kP9yTmKv7N6LVrecwN7YkkBbe+T/tvbJANzV
         y1ONjmdA3gnc+2tq6gLc9yjCXT8apSnmqeiJ+PXF8hHSCcQnOEXzjEiFJtD+A+fHCbJw
         nOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719253646; x=1719858446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TS7GRJVBSbiXIfOc3555Cy+7DvtDs4tYIL95YiKGyb0=;
        b=UBf9NAJB02aZi7QsxhWcwZ49lGAHJHUlts9GTD6IeB4fsEabi95+g1o8GukuCbAyQ9
         3IMs3ceY9fc3cmG7qMP6LelFDVXZdSz1WBMHwKNFqo0iE/CY3OgjjQ+6mmokiJKEo6dB
         c1nqhLw1uhuXL8v63Kec1VwT5TySMgQ9ZVMv9i87CEqBmAaHgIBb8dFPCXoAg65ujcR/
         DDdNGLTo05RPkmWTLkvFjCvghx7wfqwwI/KZlszD6sZMv95rjukFGUVhC4T4LYysygfr
         5lmz+xmfsCOUQ4BXiZXQQAEyfc1CIZIprJypOYR2eHqP1y945z6y9ibw8kE5Q/LfqgFL
         mr5A==
X-Forwarded-Encrypted: i=1; AJvYcCXbc62sGQEv2Hp+eI14B8waO+soViCs9CJIKvFdbusAppYH0l+r2gySGotvlQPFgHKOQjmzwTQa7lf4g7l2JIktiFFR+ZQ=
X-Gm-Message-State: AOJu0YzwJMKZ2rqqDXf46v/kgIEEvxekvO7RdpCovlYKKJCBxrCOqhJd
	Y3YHzU/82CDTXKYlCBZ5WIJBZHSKfE5AlZ4WvmxsLbfY5Nzk2oULu8b32qsKQwrNoXbgL6WlZi0
	evXIdMlcnmfiuXNm1WTr2YXV31w7VEIHiVa3OLQ==
X-Google-Smtp-Source: AGHT+IHNIsxL7IdqCLVSyINZgDjQkCRHKPTAM+t9FlDhG+E0Ru/sJKPmgt69/U4c0BD886Tzeyv8OL4cFF7/wYneLNI=
X-Received: by 2002:a25:8442:0:b0:dfe:199d:798f with SMTP id
 3f1490d57ef6-e0300f40230mr5287028276.19.1719253645903; Mon, 24 Jun 2024
 11:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
 <20240524182702.1317935-10-dave.stevenson@raspberrypi.com> <ZmCqxhv2jF3bT8dH@lizhi-Precision-Tower-5810>
In-Reply-To: <ZmCqxhv2jF3bT8dH@lizhi-Precision-Tower-5810>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 24 Jun 2024 19:27:10 +0100
Message-ID: <CAPY8ntBZaS_hrDnrrEUohsc+V27fFho3Je+bJRDYFKcQ5vfPgQ@mail.gmail.com>
Subject: Re: [PATCH 09/18] dmaengine: bcm2835: Add function to handle DMA mapping
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
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 19:13, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, May 24, 2024 at 07:26:53PM +0100, Dave Stevenson wrote:
> > The code handling DMA mapping is currently incorrect and
> > needs a sequence of fixups.
>
> Can you descript what incorrect here?

Clients are passing in DMA addresses, not CPU physical addresses. I'll
update the commit message.

> > Move the mapping out into a separate function and structure
> > to allow for those fixes to be applied more cleanly.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > ---
> >  drivers/dma/bcm2835-dma.c | 46 ++++++++++++++++++++++++++++++++-------
> >  1 file changed, 38 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> > index aefaa1f01d7f..ef1d95bae84e 100644
> > --- a/drivers/dma/bcm2835-dma.c
> > +++ b/drivers/dma/bcm2835-dma.c
> > @@ -65,6 +65,10 @@ struct bcm2835_cb_entry {
> >       dma_addr_t paddr;
> >  };
> >
> > +struct bcm2835_dma_chan_map {
> > +     dma_addr_t addr;
> > +};
> > +
> >  struct bcm2835_chan {
> >       struct virt_dma_chan vc;
> >
> > @@ -74,6 +78,7 @@ struct bcm2835_chan {
> >       int ch;
> >       struct bcm2835_desc *desc;
> >       struct dma_pool *cb_pool;
> > +     struct bcm2835_dma_chan_map map;
>
> I suppose map should in bcm2835_desc.  if put in chan, how about client
> driver create two desc by bcm2835_dma_prep_slave_sg()?
>
> prep_slave_sg()
> submit()
> prep_savle_sg()
> submit()
> issue_pending()

I'm basing this on rcar-dmac.c which has a similar mode of operation.

For devices such as HDMI audio, I2S, SPI, etc, the peripheral's
address is constant. Mapping and unmapping adds an overhead. Retaining
the mapping in the chan structure allows the mapping to be cached
whilst the address remains the same, and is released whenever the
address changes.

If the map is in bcm2835_desc then as the desc is freed after every
transfer you'd have to unmap.

  Dave

> Frank
>
> >
> >       void __iomem *chan_base;
> >       int irq_number;
> > @@ -268,6 +273,19 @@ static inline bool need_dst_incr(enum dma_transfer_direction direction)
> >       }
> >
> >       return false;
> > +};
> > +
> > +static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
> > +                                   phys_addr_t dev_addr,
> > +                                   size_t dev_size,
> > +                                   enum dma_data_direction dev_dir)
> > +{
> > +     struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> > +     struct bcm2835_dma_chan_map *map = &c->map;
> > +
> > +     map->addr = dev_addr;
> > +
> > +     return 0;
> >  }
> >
> >  static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
> > @@ -734,13 +752,19 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
> >       }
> >
> >       if (direction == DMA_DEV_TO_MEM) {
> > -             if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
> > +             if (bcm2835_dma_map_slave_addr(chan, c->cfg.src_addr,
> > +                                            c->cfg.src_addr_width,
> > +                                            DMA_TO_DEVICE))
> >                       return NULL;
> > -             src = c->cfg.src_addr;
> > +
> > +             src = c->map.addr;
> >       } else {
> > -             if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
> > +             if (bcm2835_dma_map_slave_addr(chan, c->cfg.dst_addr,
> > +                                            c->cfg.dst_addr_width,
> > +                                            DMA_FROM_DEVICE))
> >                       return NULL;
> > -             dst = c->cfg.dst_addr;
> > +
> > +             dst = c->map.addr;
> >       }
> >
> >       /* count frames in sg list */
> > @@ -795,14 +819,20 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
> >                             __func__, buf_len, period_len);
> >
> >       if (direction == DMA_DEV_TO_MEM) {
> > -             if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
> > +             if (bcm2835_dma_map_slave_addr(chan, c->cfg.src_addr,
> > +                                            c->cfg.src_addr_width,
> > +                                            DMA_TO_DEVICE))
> >                       return NULL;
> > -             src = c->cfg.src_addr;
> > +
> > +             src = c->map.addr;
> >               dst = buf_addr;
> >       } else {
> > -             if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
> > +             if (bcm2835_dma_map_slave_addr(chan, c->cfg.dst_addr,
> > +                                            c->cfg.dst_addr_width,
> > +                                            DMA_FROM_DEVICE))
> >                       return NULL;
> > -             dst = c->cfg.dst_addr;
> > +
> > +             dst = c->map.addr;
> >               src = buf_addr;
> >       }
> >
> > --
> > 2.34.1
> >
