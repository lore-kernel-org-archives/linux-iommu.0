Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81518C433ED
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 06:39:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB0F61186
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 06:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB0F61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE53040491;
	Thu, 20 May 2021 06:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8fiIIkLX5-BA; Thu, 20 May 2021 06:39:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0D68400AB;
	Thu, 20 May 2021 06:39:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 949CAC000D;
	Thu, 20 May 2021 06:39:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D18CC0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 06:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35AD94039A
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 06:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4BSQMiDx2J6M for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 06:39:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2122340396
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 06:39:23 +0000 (UTC)
Received: by mail-io1-xd2f.google.com with SMTP id a11so15529925ioo.0
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e/NSxqpkIDrHAb8EdngT+J5y92xOhsZUELUZeumbo14=;
 b=XZhu4NB364LO5HgzFR5xaRq+2+Ny8I/tbuM557W/djcP2WZR5/YY1P3k16G0KqQZ5g
 9wOC75EFGAaEHt77aJ4y5qFZynUNK1/otklqj7so1biOf1FGROrwm/ILpXyxkwLvM+aC
 k3452c8bAQ6BEmJklQOi+zYSoBDbgxiFQQFO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e/NSxqpkIDrHAb8EdngT+J5y92xOhsZUELUZeumbo14=;
 b=lul2hOTTpQCqycIm6s/8luzB7V/H8A5ZjsxCn36J0vTCwUSNqiKOqu0Cq9/Vcs6S1r
 aAGk3wbZ/MT31on/SKzYi+zCgUVKRKZVU4BlYq/ZVH8MX9pwhLyLIhjeND3esoW7pLSm
 CN57g//g6Gc9+nwBTb6NDb9wQPxlHKU9weVK0HQk2FxICNMFpvv8PK3orXQXYhxt/mr4
 vj73aJ9J80kRSEx7XHXEmkKEHq1yX8zr04POyEfngHVN4DBibwo09IdNaA9gohwrKVrq
 UNmk98nvv2axwAEN6OA5Yb6ESWy1a4OzdFL9cQv/6jg2xK6owkFzqLvCO63FKHFB4VrP
 Nt2A==
X-Gm-Message-State: AOAM5334HqGijN3yaaDsigzyUv6kJFacPxPCiDfT7XFMkPRHk7b5wQMx
 aN2dSbF7y8l56WkqdunDqhoEMPyc6THDwQ==
X-Google-Smtp-Source: ABdhPJwa1Z4GmR18wdaYjRDqGQafU8ursYvJaKS8r3aojBMwb4whpapT7JvvDr5rGoKdf4w0bfYcjA==
X-Received: by 2002:a6b:f311:: with SMTP id m17mr3660377ioh.162.1621492761731; 
 Wed, 19 May 2021 23:39:21 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com.
 [209.85.166.44])
 by smtp.gmail.com with ESMTPSA id l2sm1817214ilh.58.2021.05.19.23.39.19
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 23:39:20 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id p8so15439281iol.11
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:39:19 -0700 (PDT)
X-Received: by 2002:a05:6638:14ce:: with SMTP id
 l14mr3931980jak.90.1621492759440; 
 Wed, 19 May 2021 23:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-5-tientzu@chromium.org>
 <ae050c36-8179-e465-84f0-e46c361bd71e@gmail.com>
In-Reply-To: <ae050c36-8179-e465-84f0-e46c361bd71e@gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Thu, 20 May 2021 14:39:08 +0800
X-Gmail-Original-Message-ID: <CALiNf29jpi7=UKFPc7TK8wiNbq6TL=Uj-Mvmj9HRvOLnr-r_Ow@mail.gmail.com>
Message-ID: <CALiNf29jpi7=UKFPc7TK8wiNbq6TL=Uj-Mvmj9HRvOLnr-r_Ow@mail.gmail.com>
Subject: Re: [PATCH v7 04/15] swiotlb: Add restricted DMA pool initialization
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
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

On Thu, May 20, 2021 at 2:54 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 5/17/2021 11:42 PM, Claire Chang wrote:
> > Add the initialization function to create restricted DMA pools from
> > matching reserved-memory nodes.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >  include/linux/device.h  |  4 +++
> >  include/linux/swiotlb.h |  3 +-
> >  kernel/dma/swiotlb.c    | 76 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 82 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 38a2071cf776..4987608ea4ff 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -416,6 +416,7 @@ struct dev_links_info {
> >   * @dma_pools:       Dma pools (if dma'ble device).
> >   * @dma_mem: Internal for coherent mem override.
> >   * @cma_area:        Contiguous memory area for dma allocations
> > + * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
> >   * @archdata:        For arch-specific additions.
> >   * @of_node: Associated device tree node.
> >   * @fwnode:  Associated device node supplied by platform firmware.
> > @@ -521,6 +522,9 @@ struct device {
> >  #ifdef CONFIG_DMA_CMA
> >       struct cma *cma_area;           /* contiguous memory area for dma
> >                                          allocations */
> > +#endif
> > +#ifdef CONFIG_DMA_RESTRICTED_POOL
> > +     struct io_tlb_mem *dma_io_tlb_mem;
> >  #endif
> >       /* arch specific additions */
> >       struct dev_archdata     archdata;
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 216854a5e513..03ad6e3b4056 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -72,7 +72,8 @@ extern enum swiotlb_force swiotlb_force;
> >   *           range check to see if the memory was in fact allocated by this
> >   *           API.
> >   * @nslabs:  The number of IO TLB blocks (in groups of 64) between @start and
> > - *           @end. This is command line adjustable via setup_io_tlb_npages.
> > + *           @end. For default swiotlb, this is command line adjustable via
> > + *           setup_io_tlb_npages.
> >   * @used:    The number of used IO TLB block.
> >   * @list:    The free list describing the number of free entries available
> >   *           from each index.
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index b849b01a446f..1d8eb4de0d01 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -39,6 +39,13 @@
> >  #ifdef CONFIG_DEBUG_FS
> >  #include <linux/debugfs.h>
> >  #endif
> > +#ifdef CONFIG_DMA_RESTRICTED_POOL
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/slab.h>
> > +#endif
> >
> >  #include <asm/io.h>
> >  #include <asm/dma.h>
> > @@ -690,3 +697,72 @@ static int __init swiotlb_create_default_debugfs(void)
> >  late_initcall(swiotlb_create_default_debugfs);
> >
> >  #endif
> > +
> > +#ifdef CONFIG_DMA_RESTRICTED_POOL
> > +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> > +                                 struct device *dev)
> > +{
> > +     struct io_tlb_mem *mem = rmem->priv;
> > +     unsigned long nslabs = rmem->size >> IO_TLB_SHIFT;
> > +
> > +     if (dev->dma_io_tlb_mem)
> > +             return 0;
> > +
> > +     /*
> > +      * Since multiple devices can share the same pool, the private data,
> > +      * io_tlb_mem struct, will be initialized by the first device attached
> > +      * to it.
> > +      */
> > +     if (!mem) {
> > +             mem = kzalloc(struct_size(mem, slots, nslabs), GFP_KERNEL);
> > +             if (!mem)
> > +                     return -ENOMEM;
> > +
> > +             if (PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
> > +                     kfree(mem);
> > +                     return -EINVAL;
>
> This could probably deserve a warning here to indicate that the reserved
> area must be accessible within the linear mapping as I would expect a
> lot of people to trip over that.

Ok. Will add it.

>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> --
> Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
