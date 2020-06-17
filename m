Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C93C433E1
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 18:17:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B712082F
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 18:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HVVJWkZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B712082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0ECEB89063;
	Wed, 17 Jun 2020 18:17:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9bQ4r1o1wXl5; Wed, 17 Jun 2020 18:17:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4FFCD88905;
	Wed, 17 Jun 2020 18:17:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43A4CC0863;
	Wed, 17 Jun 2020 18:17:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53BA4C016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3F2CA88905
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:17:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lFxFamSwoKbI for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 18:17:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7823A888FD
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:17:50 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id l26so2778266wme.3
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GNuW4DLwTBQChO/w6b63g3sIOzooS9NaSBa2XKqAsPk=;
 b=HVVJWkZDZZh62rgq5TcwWzj9OGMbS5g6A+QBmiSeKSYjT0/p83zMoQ9AZA3Z9n7Z49
 GXrBxj7XUuvFMqtuvLnFTb8nq8u9TM1v8LXIS02nv/Yw2VdJzkZgEMb6U04FXzZhPsVK
 2snCp+BSgajYbGyTk5E3ht5PP5Gw49UtFVcp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GNuW4DLwTBQChO/w6b63g3sIOzooS9NaSBa2XKqAsPk=;
 b=VauVmzGL0Fut9Oips8elkpJqyN9dojrVbSp20F7+ahhisuR/in3Dq69SEjvdNCkMyj
 hkmvKA2/AKp1uNcb25KdZLj3u0wesN5eygtz6uexJfPD4WRrH5vfLs6VvqpvPZ0SMd8m
 4mws13zIBXSV0twlvm5aCvDclJ9SMXHcR+MwMHokkQfl6bDOa4TpoDYVw7pZBZgBjNP3
 b1NlXW1oYuIrjKAj1rBjyhFtQ9L8lcdVRZVNswRidnlmteaB/RK6N5YyzwBbetwepp8/
 toSaCvNkvQesgXDYH6QaVKeD+oKks33Lu918mc0p9tm/Op/Vp3x9MrFNI5EC8qcmJUcJ
 Uwqg==
X-Gm-Message-State: AOAM532SuNVqHzH/FGjYWacNqj/Mj7VX20F2ulNpCZ1ZDBFYsmvAHRY7
 gxSdFfx9o6/HPThK00kIF+R872wlq2pDW90hRMtbKA==
X-Google-Smtp-Source: ABdhPJwCOCarFnPVmCXyp4cpXzJ0uN1eXKFwmPhHXPanOof81T2/N88OZe8pdxgNQo+BB3gZ7h7B9fOBg7JidDi7Ss0=
X-Received: by 2002:a7b:c44a:: with SMTP id l10mr40352wmi.92.1592417868643;
 Wed, 17 Jun 2020 11:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200616205533.3513-1-james.quinlan@broadcom.com>
 <20200616205533.3513-9-james.quinlan@broadcom.com>
 <b0feb616-63f3-8563-fbc1-663816d344ea@arm.com>
In-Reply-To: <b0feb616-63f3-8563-fbc1-663816d344ea@arm.com>
Date: Wed, 17 Jun 2020 14:17:36 -0400
Message-ID: <CA+-6iNxUymRBQY-xEVFXBQsAPXKCB4X9knFNSgNvtUwEUYpKTA@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] device core: Introduce multiple dma pfn offsets
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Julien Grall <julien.grall@arm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Wolfram Sang <wsa@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
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
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
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
 Mark Brown <broonie@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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

On Wed, Jun 17, 2020 at 9:00 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Jim,
>
> Thanks for taking this on!

Hi Robin,

>
> On 2020-06-16 21:55, Jim Quinlan wrote:
> > The new field in struct device 'dma_pfn_offset_map' is used to facilitate
> > the use of single or multiple pfn offsets between cpu addrs and dma addrs.
> > It subsumes the role of dev->dma_pfn_offset -- a uniform offset.
>
> This isn't just about offsets - it should (eventually) subsume
> bus_dma_limit as well, so I'd be inclined to call it something like
> "dma_ranges"/"dma_range_map"/"dma_regions"/etc.
I will change my wording here.

>
> > The function of_dma_get_range() has been modified to take two additional
> > arguments: the "map", which is an array that holds the information
> > regarding the pfn offset regions, and map_size, which is the size in bytes
> > of the map array.
> >
> > of_dma_configure() is the typical manner to set pfn offsets but there are a
> > number of ad hoc assignments to dev->dma_pfn_offset in the kernel driver
> > code.  These cases now invoke the function
> > dma_attach_uniform_pfn_offset(dev, pfn_offset).
>
> I'm also not convinced that sticking to the PFN paradigm is necessarily
> the right way to go - when there's only a single nicely-aligned offset
> to consider then an unsigned long that's immune to PAE/LPAE/etc.
> disruption is indeed the cheapest and easiest option from core code's
> PoV. However it already means that all the users have to do some degree
> of conversion back and forth between PFNs and usable addresses; once the
> core code itself also has to start bouncing back and forth between
> addresses and PFNs internally then we end up effectively just doing work
> to cancel out other work, and the whole lot would end up simpler and
> more efficient if the API worked purely in terms of addresses.
If you want me to change the paradigm to an address offset, I will.
If so please specify its type: dma_addr_t, phys_addr_t, or u64?

>
> [...]
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 8eea3f6e29a4..767fa3b492c8 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -918,12 +918,48 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
> >   }
> >   EXPORT_SYMBOL(of_io_request_and_map);
> >
> > +static int dma_attach_pfn_offset_map(struct device_node *node, int num_ranges,
> > +                                  struct bus_dma_region **map, size_t *map_size)
> > +{
> > +     struct of_range_parser parser;
> > +     struct of_range range;
> > +     struct bus_dma_region *r;
> > +
> > +     *map_size = (num_ranges + 1) * sizeof(**map);
> > +     r = kcalloc(num_ranges + 1, sizeof(**map), GFP_KERNEL);
> > +     if (!r)
> > +             return -ENOMEM;
> > +     *map = r;
> > +
> > +     of_dma_range_parser_init(&parser, node);
> > +     /*
> > +      * Record all info for DMA ranges array.  We could
> > +      * just use the of_range struct, but if we did that it
>
> Not making the entire DMA API depend on OF is a far better justification
> for having its own dedicated structure.
>
> > +      * would require more calculations for phys_to_dma and
> > +      * dma_to_phys conversions.
> > +      */
>
> However that part is pretty much nonsense. Consider your "efficient"
> operation for looking up and consuming a DMA offset:
>
>         API                             caller
> 1. load cpu_start
> 2. compare addr >= cpu_start
> 3. load cpu_end
> 4. compare addr <= cpu_end
> 5. load pfn_offset
> 6.                              shift pfn_offset << PAGE_SHIFT
> 7.                              add "offset" + addr
> 8.                              [use the result]
>
> versus the "more calculations" approach (once the PFN cruft is peeled away):
>
>         API                             caller
> 1. load cpu_addr
> 2. compare addr >= cpu_addr
> 3. subtract addr - cpu_addr
> 4. load size
> 5. compare "addr_offset" < size
> 6. load dma_start
> 7. add dma_start + "addr_offset"
> 8.                              [use the result]
>
> Oh look, it's the exact same number of memory accesses and ALU
> operations, but with a smaller code footprint (assuming, reasonably,
> more than one caller) and less storage overhead ;)
I feel you have conflated two independent issues to get your
comparison.  Issue one is having two  extra fields -- cpu_end, dma_end
-- and issue two is using address verses PFN offsets.  If you look at
both code sequences when using an address offset verses PFN offset,
the of_range way requires an extra computation.  Do you  agree?

>
> Basically, having this degree of redundancy is somewhere between silly
> and actively harmful (what if pfn_offset gets out of sync with
> cpu_start/dma_start?
How can this happen if the range map is set once and passed as a const
structure?

> What if cpu_end/dma_end don't represent equivalent lengths?)
They are set once using the same +size operation so they must be
equal.  They are not changed after they are set.

Nonetheless, I really don't care which way we do it.  If you want me
to have an of_range-like structure I am fine with that.

>
> > +     for_each_of_range(&parser, &range) {
> > +             r->cpu_start = range.cpu_addr;
> > +             r->cpu_end = r->cpu_start + range.size - 1;
> > +             r->dma_start = range.bus_addr;
> > +             r->dma_end = r->dma_start + range.size - 1;
> > +             r->pfn_offset = PFN_DOWN(range.cpu_addr) - PFN_DOWN(range.bus_addr);
> > +             r++;
> > +     }
> > +     return 0;
> > +}
> > +
> >   /**
> >    * of_dma_get_range - Get DMA range info
> >    * @np:             device node to get DMA range info
> >    * @dma_addr:       pointer to store initial DMA address of DMA range
> >    * @paddr:  pointer to store initial CPU address of DMA range
> >    * @size:   pointer to store size of DMA range
> > + * @map:     pointer to a pointer of an array of structs.  This is updated
> > + *           to point to NULL (no offsets needed) or kmalloc'd array of
> > + *           structs.  In the latter case, it is the caller's obligation to
> > + *           kfree the array in the case it is no longer in use.
> > + * @map_size:        updated to be the size in bytes of memory allocated to the map
> >    *
> >    * Look in bottom up direction for the first "dma-ranges" property
> >    * and parse it.
> > @@ -932,10 +968,11 @@ EXPORT_SYMBOL(of_io_request_and_map);
> >    *  CPU addr (phys_addr_t)  : pna cells
> >    *  size                    : nsize cells
> >    *
> > - * It returns -ENODEV if "dma-ranges" property was not found
> > - * for this device in DT.
> > + * It returns -ENODEV if "dma-ranges" property was not found for this
> > + * device in the DT.
> >    */
> > -int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
> > +int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr,
> > +                  u64 *size, struct bus_dma_region **map, size_t *map_size)
>
> dma_addr, paddr and size don't really make much sense any more when we
> could be handling multiple ranges - it would seem logical to simplify
> the interface entirely:
>
> struct bus_dma_region *of_dma_get_range(struct device_node *np);
>
> which returns either a valid map, NULL if dma-ranges is absent, or an
> ERR_PTR.
Fair enough, I'll change this.  As you may have guessed I typically
lean towards just changing the minimal code I need to change and
preserving the rest.

>
> >   {
> >       struct device_node *node = of_node_get(np);
> >       const __be32 *ranges = NULL;
> > @@ -944,7 +981,10 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
> >       bool found_dma_ranges = false;
> >       struct of_range_parser parser;
> >       struct of_range range;
> > -     u64 dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> > +     phys_addr_t cpu_start = ~(phys_addr_t)0;
> > +     u64 dma_start = U64_MAX, dma_end = 0;
> > +     bool offset_map_needed = false;
> > +     int num_ranges = 0;
> >
> >       while (node) {
> >               ranges = of_get_property(node, "dma-ranges", &len);
> [...]
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 15460a5ac024..a17da8e271a2 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -492,7 +492,7 @@ struct dev_links_info {
> >    *          such descriptors.
> >    * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
> >    *          DMA limit than the device itself supports.
> > - * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> > + * @dma_pfn_offset_map: offset map for DMA memory range relatively of RAM
> >    * @dma_parms:      A low level driver may set these to teach IOMMU code about
> >    *          segment limitations.
> >    * @dma_pools:      Dma pools (if dma'ble device).
> > @@ -577,7 +577,7 @@ struct device {
> >                                            64 bit addresses for consistent
> >                                            allocations such descriptors. */
> >       u64             bus_dma_limit;  /* upstream dma constraint */
> > -     unsigned long   dma_pfn_offset;
> > +     struct bus_dma_region *dma_pfn_offset_map;
>
> I think it's a very good idea for this to be const.
Agree.

>
> >       struct device_dma_parameters *dma_parms;
> >
> [...]
> > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > index 98e3d873792e..20149a29d136 100644
> > --- a/kernel/dma/mapping.c
> > +++ b/kernel/dma/mapping.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/dma-noncoherent.h>
> >   #include <linux/export.h>
> >   #include <linux/gfp.h>
> > +#include <linux/limits.h>
> >   #include <linux/of_device.h>
> >   #include <linux/slab.h>
> >   #include <linux/vmalloc.h>
> > @@ -407,3 +408,41 @@ unsigned long dma_get_merge_boundary(struct device *dev)
> >       return ops->get_merge_boundary(dev);
> >   }
> >   EXPORT_SYMBOL_GPL(dma_get_merge_boundary);
> > +
> > +/**
> > + * dma_attach_uniform_pfn_offset - Assign scalar offset for all addresses.
> > + * @dev:     device pointer; needed to "own" the alloced memory.
> > + * @pfn_offset:      offset to apply when converting from phys addr
> > + *           to dma addr and vice versa.
> > + *
> > + * This is for the simple case of a uniform offset which requires
> > + * no bounds calculations for its use.
>
> That's crap - just because we've been (mostly) getting away without them
> doesn't mean bounds checks aren't relevant to a uniform offset. Take a
> look at this saga for an example of phys_to_dma() on something *below*
> the offset being a very nasty problem indeed:
>
> https://lore.kernel.org/linux-arm-kernel/9bbd87c2-5b6c-069c-dd22-5105dc827428@ti.com/
Fair enough, I would love to have bounds for this and enforce them.
The problem is that all of the drivers that are setting the offset do
not indicate what the bounds actually are.  How do I get around this
(other than removing my comment)?

>
> >  It is the equivalent the role
> > + * of the former dev->dma_pfn_offset; ie it is just blindly added
> > + * or subtracted in all cases.
> > + *
> > + * It returns -ENOMEM if out of memory, -ENODEV if dev == NULL, otherwise 0.
> > + */
> > +int dma_attach_uniform_pfn_offset(struct device *dev, unsigned long pfn_offset)
> > +{
> > +     struct bus_dma_region *map;
> > +
> > +     if (!dev)
> > +             return -ENODEV;
> > +
> > +     if (!pfn_offset)
> > +             return 0;
> > +
> > +     map = devm_kcalloc(dev, 2, sizeof(*map), GFP_KERNEL);
>
> Nope, if you want to call this from bus notifiers then it can't use
> devres - see the list_empty(&dev->devres_head) check in really_probe().
> However, I think those platform-level cases are probably better off
> statically allocating a single map for all devices to share (I had an
> idea about doing similar in the DT code, but that could be a future
> optimisation); this function is really only needed for nasty
> driver-level hacks like the sunxi ones.
Yes, but there are a decent number of these drivers.  To be clear, you
have reservations but no change in code is required?

>
> And for those driver-level hacks, I think it would also be worth being a
> bit cleverer here, i.e. not blindly replacing any existing ranges (but
> returning success if the desired offset is already in place).
Got it.

>
> > +     if (!map)
> > +             return -ENOMEM;
> > +
> > +     map->pfn_offset = pfn_offset;
> > +     map->cpu_start = 0;
> > +     map->cpu_end = PHYS_ADDR_MAX;
> > +     map->dma_start = 0;
> > +     map->dma_end = ~(dma_addr_t)0;
>
> As above, allowing these to be out-of-sync with the fundamental
> constraints of dma_pfn_offset seems really bad - there is no valid DMA
> address corresponding to cpu_start and no representable physical address
> corresponding to dma_end, and no good can come of that. But of course
> getting rid of the redundancy entirely is even better.
Understood.

Thanks much for your time and review,
Jim Quinlan

>
> Robin.
>
> > +     dev->dma_pfn_offset_map = map;
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dma_attach_uniform_pfn_offset);
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
