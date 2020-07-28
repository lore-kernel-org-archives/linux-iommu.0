Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BD7C433E0
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 18:25:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CB020714
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 18:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PytfZCmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CB020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E2A872051B;
	Tue, 28 Jul 2020 18:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p96MO-59khYc; Tue, 28 Jul 2020 18:25:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AF763204B9;
	Tue, 28 Jul 2020 18:25:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8635AC0050;
	Tue, 28 Jul 2020 18:25:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9343FC004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 18:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 807648867D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 18:25:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PjzjVEWv9GEb for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 18:25:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E9F94885C7
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 18:25:07 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id r4so16258781wrx.9
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qMMzLyh9N4KLzRR7OnEb/CRueQwc3bzGAN4n9taot+0=;
 b=PytfZCmkQbzq9fb2mPahs4lhfuu5DgZ1oCa6WnGZNEZjDB3y38SNqrZFZYvn8OFYRU
 uGVee3+HlLeZ8Q7vaYyxcnfBiuUJFYVMKWGhfdbajfthrWVDxIkYEChlXakQeGsuOIf4
 jdhb6KHV26Y8/QW2HKGQvzzf8DWMeVFBpIQyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qMMzLyh9N4KLzRR7OnEb/CRueQwc3bzGAN4n9taot+0=;
 b=q6BfamJNgjmtlTpOMtji2ReZm4DJdIsRQmdJVSx76Qdjq4xfxRiehzc3fyPG6wXKMA
 DGf18J1IkHjUqz0X0D5Lda1TikzFuUaXQPv8r89uGc8tH32gzPYbD4y9XpTL5UQCG3kM
 gdMMqTaidwbb7/Xu9EjNcQhRWfLnOvphFO22ODjPyyedrU7/YXJbIz6wpnaxFwKiHTXN
 bAjhxI4wL+J8iHeR5NMJ6Psq7nq5X5+Hmdbi0unWmewXS4k56G1vecwkWKcL9QO5nauw
 r/ihZGnOijZxSntLWbuCamIwEumkUS54pk0ZxBPQ+HRW0CNNZ8ZDAF6EHmi2K/adelOr
 b7vg==
X-Gm-Message-State: AOAM530Yx7u3x4IXfWLGkAHFpifrYZY0g6f3h0lDiPtrU0j9rppYXs2j
 6u9H6bKmA8Lwm5CXbdpQTJUWBxBAHUGTeUsORPCD4w==
X-Google-Smtp-Source: ABdhPJxFu6bO7iTBIW4zb3RnQdJ4/IfwAkMcQcLz7bsGlQ0xKBBWgehf79k+jng/ZmP3kThHYgsUE0lS3nEkS/2rCmM=
X-Received: by 2002:a5d:484d:: with SMTP id n13mr26439994wrs.297.1595960706116; 
 Tue, 28 Jul 2020 11:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
 <20200724203407.16972-9-james.quinlan@broadcom.com>
 <CAL_Jsq+9QE_uz+81O-Bm3xycSrJptx0xmwpPdP3x65KG00ugDQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+9QE_uz+81O-Bm3xycSrJptx0xmwpPdP3x65KG00ugDQ@mail.gmail.com>
Date: Tue, 28 Jul 2020 14:24:51 -0400
Message-ID: <CA+-6iNwD1ehy6LPJ6gZJjvVeTBXAG_ybhyfUHTCvsDnM-HnmXA@mail.gmail.com>
Subject: Re: [PATCH v9 08/12] device core: Introduce DMA range map,
 supplanting dma_pfn_offset
To: Rob Herring <robh+dt@kernel.org>
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 PCI <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Julien Grall <julien.grall@arm.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Maxime Ripard <mripard@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Borislav Petkov <bp@alien8.de>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jul 28, 2020 at 11:05 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Jul 24, 2020 at 2:45 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> >
> > The new field 'dma_range_map' in struct device is used to facilitate the
> > use of single or multiple offsets between mapping regions of cpu addrs and
> > dma addrs.  It subsumes the role of "dev->dma_pfn_offset" which was only
> > capable of holding a single uniform offset and had no region bounds
> > checking.
> >
> > The function of_dma_get_range() has been modified so that it takes a single
> > argument -- the device node -- and returns a map, NULL, or an error code.
> > The map is an array that holds the information regarding the DMA regions.
> > Each range entry contains the address offset, the cpu_start address, the
> > dma_start address, and the size of the region.
> >
> > of_dma_configure() is the typical manner to set range offsets but there are
> > a number of ad hoc assignments to "dev->dma_pfn_offset" in the kernel
> > driver code.  These cases now invoke the function
> > dma_attach_offset_range(dev, cpu_addr, dma_addr, size).
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
>
> [...]
>
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 8eea3f6e29a4..4b718d199efe 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -918,33 +918,33 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
> >  }
> >  EXPORT_SYMBOL(of_io_request_and_map);
> >
> > +#ifdef CONFIG_HAS_DMA
> >  /**
> > - * of_dma_get_range - Get DMA range info
> > + * of_dma_get_range - Get DMA range info and put it into a map array
> >   * @np:                device node to get DMA range info
> > - * @dma_addr:  pointer to store initial DMA address of DMA range
> > - * @paddr:     pointer to store initial CPU address of DMA range
> > - * @size:      pointer to store size of DMA range
> > + * @map:       dma range structure to return
> >   *
> >   * Look in bottom up direction for the first "dma-ranges" property
> > - * and parse it.
> > - *  dma-ranges format:
> > + * and parse it.  Put the information into a DMA offset map array.
> > + *
> > + * dma-ranges format:
> >   *     DMA addr (dma_addr)     : naddr cells
> >   *     CPU addr (phys_addr_t)  : pna cells
> >   *     size                    : nsize cells
> >   *
> > - * It returns -ENODEV if "dma-ranges" property was not found
> > - * for this device in DT.
> > + * It returns -ENODEV if "dma-ranges" property was not found for this
> > + * device in the DT.
> >   */
> > -int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
> > +int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
> >  {
> >         struct device_node *node = of_node_get(np);
> >         const __be32 *ranges = NULL;
> > -       int len;
> > -       int ret = 0;
> >         bool found_dma_ranges = false;
> >         struct of_range_parser parser;
> >         struct of_range range;
> > -       u64 dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> > +       struct bus_dma_region *r;
> > +       int len, num_ranges = 0;
> > +       int ret;
> >
> >         while (node) {
> >                 ranges = of_get_property(node, "dma-ranges", &len);
> > @@ -970,44 +970,35 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
> >         }
> >
> >         of_dma_range_parser_init(&parser, node);
> > +       for_each_of_range(&parser, &range)
> > +               num_ranges++;
> > +
> > +       of_dma_range_parser_init(&parser, node);
> > +
> > +       ret = -ENOMEM;
> > +       r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
> > +       if (!r)
> > +               goto out;
>
> AFAICT, you have the error cases covered, but you are leaking memory
> if the device is removed.

Hi Rob,

I started using devm_kcalloc() but at least two reviewers convinced me
to just use kcalloc().  In addition, when I was using devm_kcalloc()
it was awkward because 'dev' is not available to this function.

It comes down to whether unbind/binding the device N times is actually
a reasonable usage.  As for my experience I've seen two cases: (1) my
overnight "bind/unbind the PCIe RC driver" script, and we have a
customer who does an unbind/bind as a hail mary to bring back life to
their dead EP device.  If the latter case happens repeatedly, there
are bigger problems.

>
>
> [...]
>b
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 9f04c30c4aaf..49242dd6176e 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -519,7 +519,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
> >         /* Initialise vdev subdevice */
> >         snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> >         rvdev->dev.parent = &rproc->dev;
> > -       rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
> > +       rvdev->dev.dma_range_map = rproc->dev.parent->dma_range_map;
>
> But doing this means you can't just free the dma_range_map. You need
> to do a copy here or you'd have to refcount it. Or I suppose you could
> check if it the child has a different dma_range_map ptr than the
> parent.

I don't believe the code here attempts to free the dma_range_map or
needs to.  Assuming that we devm_kcalloc'd() the dev->dma_range_map --
which we are not currently doing -- my reasoning is that this device
does not need to free anything since the dev->dma_range_map belongs to
a device higher up in the bus hierarchy, and the lower device will be
removed long before the higher device is removed and
dev->dma_range_map goes away.

Regards,
Jim

Regards,
Jim

>
>
> Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
