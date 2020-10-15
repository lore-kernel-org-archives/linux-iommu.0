Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45471C433E7
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 09:18:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21882222E
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 09:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBNJ6mVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21882222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3D93D2044F;
	Thu, 15 Oct 2020 09:18:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7E4xf1Dj3zTL; Thu, 15 Oct 2020 09:18:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 22E5920445;
	Thu, 15 Oct 2020 09:18:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04CABC0052;
	Thu, 15 Oct 2020 09:18:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3C45C0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AD9F28835B
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:18:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lv+sP1JRXt26 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 09:18:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A233788359
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:18:30 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 04C502224A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602753508;
 bh=LcUjDS/UxFDzhKw9Qv4zxqtM0hewtDnElII8YgYlyfQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=cBNJ6mVo6CxYOLvtq59I4vSYni922TnxPNEG+VJMSbZ0E4qPvh6FrhZEfZrtCDyZJ
 D/7gFjqEpcf4ggWZBhegYDphrYNCyDaO+vrNJpt1ZmqQdrZpXw+Ojj2UBuMcpF9XmV
 /pbXjLSC39JPB3x4XxzIxyVUDsskyGYY7fq09PpA=
Received: by mail-ot1-f53.google.com with SMTP id e20so2241862otj.11
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 02:18:27 -0700 (PDT)
X-Gm-Message-State: AOAM531ScBTD9Itp+pvERoySaPZcmxrsy0hqjLzQFRm+STbngHnWa9T3
 faxMuon/CBRjbuI25Hm6LkZBwKpyFxZ5nHLga2o=
X-Google-Smtp-Source: ABdhPJxVK5ZG5Dzh8L6dNVEJ1qz4kLfzxYZdKoh8V+gGkE12YkKWyEtd7MRDVxEdTSv8kOFxzLNhDJAd5NhWC9YsMtI=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr2110017otq.77.1602753507055;
 Thu, 15 Oct 2020 02:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-4-nsaenzjulienne@suse.de>
 <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
 <CAMj1kXFnLEpNTZVq16YgBomkZwwdGsH89OSELsYeiee4P+GLPg@mail.gmail.com>
 <607e809796bc57ee649390824c4ab2bb767b00ba.camel@suse.de>
In-Reply-To: <607e809796bc57ee649390824c4ab2bb767b00ba.camel@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Oct 2020 11:18:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHwnfHZ9pU=AENmLZ7ZOeMjK04nMHv2N_Cv5Chmb3MNeg@mail.gmail.com>
Message-ID: <CAMj1kXHwnfHZ9pU=AENmLZ7ZOeMjK04nMHv2N_Cv5Chmb3MNeg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] of/address: Introduce of_dma_get_max_cpu_address()
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Jeremy Linton <jeremy.linton@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Thu, 15 Oct 2020 at 11:16, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Thu, 2020-10-15 at 08:56 +0200, Ard Biesheuvel wrote:
> > On Thu, 15 Oct 2020 at 00:03, Rob Herring <robh+dt@kernel.org> wrote:
> > > On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
> > > <nsaenzjulienne@suse.de> wrote:
> > > > Introduce of_dma_get_max_cpu_address(), which provides the highest CPU
> > > > physical address addressable by all DMA masters in the system. It's
> > > > specially useful for setting memory zones sizes at early boot time.
> > > >
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > >
> > > > ---
> > > >
> > > > Changes since v2:
> > > >  - Use PHYS_ADDR_MAX
> > > >  - return phys_dma_t
> > > >  - Rename function
> > > >  - Correct subject
> > > >  - Add support to start parsing from an arbitrary device node in order
> > > >    for the function to work with unit tests
> > > >
> > > >  drivers/of/address.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/of.h   |  7 +++++++
> > > >  2 files changed, 49 insertions(+)
> > > >
> > > > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > > > index eb9ab4f1e80b..b5a9695aaf82 100644
> > > > --- a/drivers/of/address.c
> > > > +++ b/drivers/of/address.c
> > > > @@ -1024,6 +1024,48 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
> > > >  }
> > > >  #endif /* CONFIG_HAS_DMA */
> > > >
> > > > +/**
> > > > + * of_dma_get_max_cpu_address - Gets highest CPU address suitable for DMA
> > > > + * @np: The node to start searching from or NULL to start from the root
> > > > + *
> > > > + * Gets the highest CPU physical address that is addressable by all DMA masters
> > > > + * in the system (or subtree when np is non-NULL). If no DMA constrained device
> > > > + * is found, it returns PHYS_ADDR_MAX.
> > > > + */
> > > > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> > > > +{
> > > > +       phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
> > >
> > > One issue with using phys_addr_t is it may be 32-bit even though the
> > > DT is 64-bit addresses. LPAE capable system with LPAE disabled. Maybe
> > > the truncation is fine here? Maybe not.
> > >
> >
> > PHYS_ADDR_MAX is the max addressable CPU address on the system, and so
> > it makes sense to use it for the return type, and for the preliminary
> > return value: this is actually what /prevents/ truncation, because we
> > will only overwrite max_cpu_addr if the new u64 value is lower.
> >
>
> Actually I now see how things might go south.
>
> > > > +       if (ranges && len) {
> > > > +               of_dma_range_parser_init(&parser, np);
> > > > +               for_each_of_range(&parser, &range)
> > > > +                       if (range.cpu_addr + range.size > cpu_end)
> > > > +                               cpu_end = range.cpu_addr + range.size;
>
> If cpu_end hits 0x1_00000000, it'll overflow to 0. This is possible on 32-bit
> systems (LPAE or not). And something similar might happen on LPAE disabled
> systems.
>
> I could add some extra logic, something like:
>
>         /* We overflowed */
>         if (cpu_end < range.cpu_addr)
>                 cpu_end = PHYS_ADDR_MAX;
>
> Which is not perfect but will cover most sensible cases.
>
> Or simply deal internally in u64s, and upon returning, check if "max_cpu_addr"
> falls higher than PHYS_ADDR_MAX.
>

Just use a u64 for cpu_end

> > > > +
> > > > +               if (max_cpu_addr > cpu_end)
> > > > +                       max_cpu_addr = cpu_end;

... then this comparison and assignment will work as expected.

> > > > +       }
> > > > +
> > > > +       for_each_available_child_of_node(np, child) {
> > > > +               subtree_max_addr = of_dma_get_max_cpu_address(child);
> > > > +               if (max_cpu_addr > subtree_max_addr)
> > > > +                       max_cpu_addr = subtree_max_addr;
> > > > +       }
> > > > +
> > > > +       return max_cpu_addr;
> > > > +}
>
> Regards,
> Nicolas
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
