Return-Path: <SRS0=a71q=DT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E6C43467
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 14:24:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E41B2076C
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 14:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0rXs3HhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E41B2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E44B286C5A;
	Mon, 12 Oct 2020 14:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7XhxRuOyEVxR; Mon, 12 Oct 2020 14:24:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 439C886A3F;
	Mon, 12 Oct 2020 14:24:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B8F0C07FF;
	Mon, 12 Oct 2020 14:24:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB189C0051
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 14:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B9D2F86A3F
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 14:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8CluY2MtrgNF for <iommu@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 14:24:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 36E8086C52
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 14:24:00 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F32A320878
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 14:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602512639;
 bh=mkV3zHZdLWkkkiotMkWaHSfgaeAhT3IEqlhrwfXJLpw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0rXs3HhXixR1Sr37VrUEPvUFG1NCTuJpfMTLxVMP92+0rAz5djPDI+ROp0ZyKO0xl
 3S9JxTOG3bQA1KMy3Ynj60I3PBNyAG4ehU+u927VFzGinJ7Eofns7pBdP7py3rMWyl
 A/Cfj22OgdukPF1xOzZyrZAF81y+S2lUL/io4i7w=
Received: by mail-ot1-f50.google.com with SMTP id t15so16032387otk.0
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 07:23:58 -0700 (PDT)
X-Gm-Message-State: AOAM533oxK+aQNl/wPq1+Of2SpHt6u316POPzytOczMG2dEccch/LETK
 Ib43xAfQRskEVFHrHJhcTevhjyQjnrAU23N/7uU=
X-Google-Smtp-Source: ABdhPJxdPTaQgCziNQnn1xG1IdFeKsHKlCipNToXN2Mp8aZ6g8wZ+Ii9TOczjjBJ/F+8iATwtdtq/fW0RpyMunMLK3M=
X-Received: by 2002:a9d:6c92:: with SMTP id c18mr9080953otr.108.1602512638334; 
 Mon, 12 Oct 2020 07:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
 <20201010151235.20585-2-nsaenzjulienne@suse.de> <20201012113748.GE9844@gaia>
In-Reply-To: <20201012113748.GE9844@gaia>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 12 Oct 2020 16:23:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFUH7gv-dPVNM8xa5SBHhSndCQu4QFy5os2vAkaO_yecg@mail.gmail.com>
Message-ID: <CAMj1kXFUH7gv-dPVNM8xa5SBHhSndCQu4QFy5os2vAkaO_yecg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: mm: Move zone_dma_bits initialization into
 zone_sizes_init()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-rpi-kernel@lists.infradead.org
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

On Mon, 12 Oct 2020 at 13:37, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Sat, Oct 10, 2020 at 05:12:31PM +0200, Nicolas Saenz Julienne wrote:
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index f6902a2b4ea6..0eca5865dcb1 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -196,14 +196,16 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> >       unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> >
> >  #ifdef CONFIG_ZONE_DMA
> > +     zone_dma_bits = ARM64_ZONE_DMA_BITS;
> > +
> >       if (IS_ENABLED(CONFIG_ACPI)) {
> >               extern unsigned int acpi_iort_get_zone_dma_size(void);
> >
> >               zone_dma_bits = min(zone_dma_bits,
> >                                   acpi_iort_get_zone_dma_size());
> > -             arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> >       }
> >
> > +     arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> >       max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
> >  #endif
> >  #ifdef CONFIG_ZONE_DMA32
> > @@ -394,11 +396,6 @@ void __init arm64_memblock_init(void)
> >
> >       early_init_fdt_scan_reserved_mem();
> >
> > -     if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> > -             zone_dma_bits = ARM64_ZONE_DMA_BITS;
> > -             arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
> > -     }
>
> arm64_dma_phys_limit is used by memblock_alloc_low() (via
> ARCH_LOW_ADDRESS_LIMIT). I think it's too late to leave its
> initialisation to zone_sizes_init().
>

The only generic caller of memblock_alloc_low() is swiotlb_init(),
which is called much later. So at that point, we definitely need
ARCH_LOW_ADDRESS_LIMIT to be set correctly, but that means doing it in
zone_sizes_init() is early enough.

So the only problematic reference seems to be crashkernel_reserve() afaict.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
