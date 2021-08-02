Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DCDC4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 18:22:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13D060F4B
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 18:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F13D060F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B181A403F7;
	Mon,  2 Aug 2021 18:22:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lr7rwAu-bdJv; Mon,  2 Aug 2021 18:22:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2795C4020D;
	Mon,  2 Aug 2021 18:22:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AA26C001A;
	Mon,  2 Aug 2021 18:22:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17CC2C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 18:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC7DA40270
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 18:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IssYNgLRXjJV for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 18:22:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BEB84020D
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 18:22:54 +0000 (UTC)
Received: by mail-yb1-xb29.google.com with SMTP id s48so6858760ybi.7
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WpAP0boYKgMSl+EEAfMqGAcS1DBVrnYXR6p3McRuuF8=;
 b=KlMxq4MfUxuE4wxvHzy/b64JIYB/khWpUguGIPzgKEmNeHHmr5FP9tLSQwLDHvPx0w
 +x0/5c2lijkljpgCsjjcQDt4QDKuZuv5UY3N4tLODMVHOqjtqHyJqJqMoKjhwD+8gYsw
 f5f6DaG0rlmzwPVYqNg3BSwoYkx90Nnb5bHKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WpAP0boYKgMSl+EEAfMqGAcS1DBVrnYXR6p3McRuuF8=;
 b=erys2XZTsO/HHmfBtkWtCavWRL9Ia4X9cn8s2782TpMR5UFpoLdb81D6TuKjnz6XQf
 qFkJZqcIpmtYTfnAnjU4KRU5kOfXuz0/yekem6f3VUVjfeALCrM9p1Z1sIgmlKy3E/5u
 KStknOu2RwTf4uBiUcHQLVdCOR1sEc2AFIT4zEq96v10LEqj6MakMVkZOeNM99xBj2/6
 xjybgksd+AejvId/E4w8cpWOrEP36lah2CIW/Hm89s0+8c3DaqmLDcJbH97bykG9D5eN
 Zfai22V7osa2s15loOxsKdlyCCvTKhbebN06bYhnpnrI8JvtvX4hT1KzQOiqG1Y2USCP
 cIHQ==
X-Gm-Message-State: AOAM530C+2sE9Ua/3gEGRske4K3eiUnYFcNB5lsN8htayS5GpWI7d+Gn
 HjngUMDVPaMciN8aAUrWl2sPRvLuT14+kFAGpME5
X-Google-Smtp-Source: ABdhPJynNZIyUvDVGGyRh+IbdUlssdg8o1eWgR0yeR8vNlVh2L5U96YBAQGX7dRj9k0KPeGehWEsCQ07LvSHzf9+hAY=
X-Received: by 2002:a25:84c7:: with SMTP id x7mr21646394ybm.447.1627928573559; 
 Mon, 02 Aug 2021 11:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com>
 <20210723214031.3251801-4-atish.patra@wdc.com>
 <20210726070030.GB9035@lst.de>
 <CAOnJCU+qRznBTn9Mt6t_DE6UUz6_LuaBBuOmnURS2Yh3pmpjvg@mail.gmail.com>
 <20210727085244.GA20609@lst.de>
In-Reply-To: <20210727085244.GA20609@lst.de>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 2 Aug 2021 11:22:42 -0700
Message-ID: <CAOnJCUJgCHOR5nifNVjkQawKniGf81Zvsh226brdAPuLNkXAdQ@mail.gmail.com>
Subject: Re: [RFC 3/5] dma-mapping: Enable global non-coherent pool support
 for RISC-V
To: Christoph Hellwig <hch@lst.de>
Cc: devicetree <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@linux.alibaba.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
 Atish Patra <atish.patra@wdc.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Tobias Klauser <tklauser@distanz.ch>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>
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

On Tue, Jul 27, 2021 at 1:52 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jul 26, 2021 at 03:47:54PM -0700, Atish Patra wrote:
> > arch_dma_set_uncached works as well in this case. However, mips,
> > niops2 & xtensa uses a
> > fixed (via config) value for the offset. Similar approach can't be
> > used here because the platform specific
> > offset value has to be determined at runtime so that a single kernel
> > image can boot on all platforms.
>
> Nothing in the interface requires a fixed offset.  And using the offset
> has one enormous advantage in that there is no need to declare a
> statically sized pool - allocations are fully dynamic.  And any kind of
> fixed pool tends to cause huge problems.
>
> > 1. a new DT property so that arch specific code is aware of the
> > non-cacheable window offset.
>
> Yes.
>
> > individual device if a per-device non-cacheable
> >    window support is required in future. As of now, the beagleV memory
>
> If you require a per-device noncachable area you can use the per-device
> coherent pools.  But why would you want that?
>
> > region lies in 0x10_0000_00000 - x17_FFFF_FFFF
> >    which is mapped to start of DRAM 0x80000000. All of the
> > non-coherent devices can do 32bit DMA only.
>
> Adjust ZONE_DMA32 so that it takes the uncached offset into account.
>
> > > > -     mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
> > > > +     if (phys_addr == device_addr)
> > > > +             mem = dma_init_coherent_memory(phys_addr, device_addr, size, true);
> > > > +     else
> > > > +             mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
> > >
> > > Nak.  The phys_addr != device_addr support is goign away.  This needs
> >
> > ok.
> >
> > > to be filled in using dma-ranges property hanging of the struct device.
> >
> > struct device is only accessible in rmem_dma_device_init. I couldn't
> > find a proper way to access it during
> > dma_reserved_default_memory setup under global pool.
> >
> > Does that mean we should use a per-device memory pool instead of a
> > global non-coherent pool ?
>
> Indeed, that would be a problem in this case.  But if we can just
> use the uncached offset directly I think everything will be much
> simpler.

Yes. I was planning to change this to use an uncached offset.
However, the planned mass production for beaglev starlight sbc is
cancelled now [1].
As there is no other board that requires an uncached offset, I don't
think there is no usecase
for adding uncached offset support for RISC-V right now. I will
revisit(hopefully we don't have to)
this in case any platform implements uncached window support in future.

[1] https://www.cnx-software.com/2021/07/31/beaglev-starlight-sbc-wont-be-mass-manufactured-redesigned-beaglev-risc-v-sbc-expected-in-q1-2022/
-- 
Regards,
Atish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
