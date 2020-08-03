Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417B6C433E0
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 12:49:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0356720678
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 12:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WxR8Ckv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0356720678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 74798204F0;
	Mon,  3 Aug 2020 12:49:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JDoTjF+dQN0b; Mon,  3 Aug 2020 12:49:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 755C220432;
	Mon,  3 Aug 2020 12:49:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F8C4C0050;
	Mon,  3 Aug 2020 12:49:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72ADCC004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 12:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6D9BD85BF2
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 12:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VAkFmXK9Hver for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 12:49:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1B30D85C52
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 12:49:44 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id f7so34125212wrw.1
 for <iommu@lists.linux-foundation.org>; Mon, 03 Aug 2020 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QKxUE+IKc+CK6EjCxCtoVE9UcF8T06WWbBk1xPjWCfI=;
 b=WxR8Ckv7PNATR8wTQvtma/bt+eBiXA2gwq5116AOGhNJUjDUydXyNQX5MiN8YUDh5E
 sbGs1vSeMHyyugbd/nnFZQJiv5e8Uh841QVKzBwSH1jujBoeF13SwXbt58ZxvSY/FGs5
 32wLeyqMA9spOmJ+A3uTgBEL25bHKk9Ru9/uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QKxUE+IKc+CK6EjCxCtoVE9UcF8T06WWbBk1xPjWCfI=;
 b=DjnFGA4sinsAU2+VKanN4emfdVk6PteGPKnADkew2B2f0pgUHJOyTY9nTo9G97F2hX
 6n0V5xYP6vFsdyQjfgEHDe6ruKM5YvNMw0w1S7wAUJYa8qlOve3w+6FIISGelN9n/w0h
 OftJ5/ATv+YGP5vqWGzZ3EtqEkK1Rd2fHsCbfyh+Ggfukzl8RquI4zJkzIV43ZtmTp26
 uoI+7VfdbqQFze+YGR7oWGvbwWiF7EvsCekpuP0Ady01AjEUZ85CuNR5vYt8Sk21H0Mv
 M2/yjdU/WBIoQUEiu6/iFgoe/Rc+9JScWHuiinghpgz7IlG7Rw0FeAeBewoqc3NKoDSy
 f16w==
X-Gm-Message-State: AOAM533tcsV8k34lJctz/nLVdoSGr4VHYPH0M/GjG+2e2M5U/ats/3rg
 pGxS9LtI47uuGj8l0b3W9n8I+pes1yZH0Kvac4ddFw==
X-Google-Smtp-Source: ABdhPJw2sfvdWakANswiw+kFKuUbfyHSkhusPzzyDFMYa/ISYVGsjNBt5TwbOzk7crmIMvJlieMaBdbsJjkeU4EkzIM=
X-Received: by 2002:adf:ebc5:: with SMTP id v5mr14987088wrn.100.1596458982058; 
 Mon, 03 Aug 2020 05:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
 <20200724203407.16972-9-james.quinlan@broadcom.com>
 <649c37347138ecf4d0bca9825fba989151757d02.camel@suse.de>
In-Reply-To: <649c37347138ecf4d0bca9825fba989151757d02.camel@suse.de>
Date: Mon, 3 Aug 2020 08:49:30 -0400
Message-ID: <CA+-6iNxT+xrDCAzPNfs2dXH7d5MTL8Bb+_MBbrvjHddsZHKKGQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/12] device core: Introduce DMA range map,
 supplanting dma_pfn_offset
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
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
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
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

On Sat, Aug 1, 2020 at 1:17 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Jim, here's some comments after testing your series against RPi4.
>
> On Fri, 2020-07-24 at 16:33 -0400, Jim Quinlan wrote:
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
> >   * @np:              device node to get DMA range info
> > - * @dma_addr:        pointer to store initial DMA address of DMA range
> > - * @paddr:   pointer to store initial CPU address of DMA range
> > - * @size:    pointer to store size of DMA range
> > + * @map:     dma range structure to return
> >   *
> >   * Look in bottom up direction for the first "dma-ranges" property
> > - * and parse it.
> > - *  dma-ranges format:
> > + * and parse it.  Put the information into a DMA offset map array.
> > + *
> > + * dma-ranges format:
> >   *   DMA addr (dma_addr)     : naddr cells
> >   *   CPU addr (phys_addr_t)  : pna cells
> >   *   size                    : nsize cells
> >   *
> > - * It returns -ENODEV if "dma-ranges" property was not found
> > - * for this device in DT.
> > + * It returns -ENODEV if "dma-ranges" property was not found for this
> > + * device in the DT.
> >   */
> > -int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
> > +int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
> >  {
> >       struct device_node *node = of_node_get(np);
> >       const __be32 *ranges = NULL;
> > -     int len;
> > -     int ret = 0;
> >       bool found_dma_ranges = false;
> >       struct of_range_parser parser;
> >       struct of_range range;
> > -     u64 dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> > +     struct bus_dma_region *r;
> > +     int len, num_ranges = 0;
> > +     int ret;
> >
> >       while (node) {
> >               ranges = of_get_property(node, "dma-ranges", &len);
> > @@ -970,44 +970,35 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
> >       }
> >
> >       of_dma_range_parser_init(&parser, node);
> > +     for_each_of_range(&parser, &range)
> > +             num_ranges++;
> > +
> > +     of_dma_range_parser_init(&parser, node);
> > +
> > +     ret = -ENOMEM;
> > +     r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
> > +     if (!r)
> > +             goto out;
> >
> > +     /*
> > +      * Record all info in the generic DMA ranges array for struct device.
> > +      */
> > +     *map = r;
> >       for_each_of_range(&parser, &range) {
> >               pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
> >                        range.bus_addr, range.cpu_addr, range.size);
> > -
> > -             if (dma_offset && range.cpu_addr - range.bus_addr != dma_offset) {
> > -                     pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
> > -                     /* Don't error out as we'd break some existing DTs */
> > -                     continue;
> > -             }
> > -             dma_offset = range.cpu_addr - range.bus_addr;
> > -
> > -             /* Take lower and upper limits */
> > -             if (range.bus_addr < dma_start)
> > -                     dma_start = range.bus_addr;
> > -             if (range.bus_addr + range.size > dma_end)
> > -                     dma_end = range.bus_addr + range.size;
> > -     }
> > -
> > -     if (dma_start >= dma_end) {
> > -             ret = -EINVAL;
> > -             pr_debug("Invalid DMA ranges configuration on node(%pOF)\n",
> > -                      node);
> > -             goto out;
> > +             r->cpu_start = range.cpu_addr;
> > +             r->dma_start = range.bus_addr;
> > +             r->size = range.size;
> > +             r->offset = (u64)range.cpu_addr - (u64)range.bus_addr;
> > +             r++;
> >       }
> >
> > -     *dma_addr = dma_start;
> > -     *size = dma_end - dma_start;
> > -     *paddr = dma_start + dma_offset;
> > -
> > -     pr_debug("final: dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
> > -              *dma_addr, *paddr, *size);
> > -
>
> I think you're missing here:
>
>         ret = 0;
Yes.  It somehow passed my tests because it still sets dev->dma_range_map.

Thanks again,
Jiom

>
> >  out:
> >       of_node_put(node);
> > -
> >       return ret;
> >  }
>
> Regards,
> Nicolas
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
