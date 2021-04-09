Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E678C43460
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 19:38:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51105610F7
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 19:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51105610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E6E6404FB;
	Fri,  9 Apr 2021 19:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9UWdKuKI6Yq; Fri,  9 Apr 2021 19:38:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA0B540503;
	Fri,  9 Apr 2021 19:38:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 856F7C000C;
	Fri,  9 Apr 2021 19:38:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF0C0C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 19:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD5D4401C9
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 19:38:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TKo_eE4CgdmG for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 19:38:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26AA840118
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 19:38:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B81606115B
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 19:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617997112;
 bh=AqqKRuGB+aYlSpd2XHtxaxortNgbyhw4JfrwsQxNLN4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CXwi9Dy+zfc80o7ZkIWXRhs9/ZKsvO31vSVYQYVnq6OvP5VeIuRcuhRudglZoQrQQ
 XI7tsH+VIwCw4CT/GnM0ZR5PZ3WRQlV38xh0JeEDw9VHzjDIvP+9nHId9Ptt3/kCzR
 FVppS1H7u4g5ES4XvCWAkfAIZq5W0YPmRb5at5f2GEFA6Jmd5EEwa+qZFj1DXJRmmw
 sbbUjDjd4yuWNHTnUXnSPTG3vvDp+NXA0HsQ/WZdOgBfMQ/LOtOFCivjxmL0lIb2J7
 w874TcijUzFj4URMPQq49VLnSCESPe5wYkuv2LFIrfTqsGYl4mp3Xw41AQDRyHnMFr
 3ALhcqp8DJlkQ==
Received: by mail-oi1-f171.google.com with SMTP id c16so6917518oib.3
 for <iommu@lists.linux-foundation.org>; Fri, 09 Apr 2021 12:38:32 -0700 (PDT)
X-Gm-Message-State: AOAM533UAtNny3p0m+FG+zA7w7ttSAR4tylJ9fXG1xAe4ogjFfUTUfux
 kj9NSJ/UAt6uflT8oTi/5Ock+OxG37RCqBUOINQ=
X-Google-Smtp-Source: ABdhPJwPRkeRcHq2LQ4abuG/9/wDbgW0Bv24YoYSOQZ4hFRrWtMj03Zbtndge10mz92YsjqjXfAUKkMC/mJSZ/pM/cI=
X-Received: by 2002:a05:6808:3d3:: with SMTP id
 o19mr1577825oie.4.1617997112043; 
 Fri, 09 Apr 2021 12:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-2-sven@svenpeter.dev>
 <20210407104425.GB15173@willie-the-truck>
 <e0d9af36-fc6c-4470-a87c-61b9161bdf8f@www.fastmail.com>
In-Reply-To: <e0d9af36-fc6c-4470-a87c-61b9161bdf8f@www.fastmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 9 Apr 2021 21:38:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a11O7JVDv+4rfky13C1pZFD7eE_B_54zRN8UQVpBrQJcA@mail.gmail.com>
Message-ID: <CAK8P3a11O7JVDv+4rfky13C1pZFD7eE_B_54zRN8UQVpBrQJcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iommu: io-pgtable: add DART pagetable format
To: Sven Peter <sven@svenpeter.dev>
Cc: DTML <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stan Skowronek <stan@corellium.com>
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

On Fri, Apr 9, 2021 at 6:56 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Wed, Apr 7, 2021, at 12:44, Will Deacon wrote:
> > On Sun, Mar 28, 2021 at 09:40:07AM +0200, Sven Peter wrote:
> >
> > > +   cfg->pgsize_bitmap &= SZ_16K;
> > > +   if (!cfg->pgsize_bitmap)
> > > +           return NULL;
> >
> > This is worrying (and again, I don't think this belongs here). How is this
> > thing supposed to work if the CPU is using 4k pages?
>
> This SoC is just full of fun surprises!
> I didn't even think about that case since I've always been using 16k pages so far.
>
> I've checked again and wasn't able to find any way to configure the pagesize
> of the IOMMU. There seem to be variants of this IP in older iPhones which
> support a 4k pagesize but to the best of my knowledge this is hard wired
> and not configurable in software.
>
> When booting with 4k pages I hit the BUG_ON in iova.c that ensures that the
> iommu pagesize has to be <= the cpu page size.
>
> I see two options here and I'm not sure I like either of them:
>
> 1) Just don't support 4k CPU pages together with IOMMU translations and only
>    allow full bypass mode there.
>    This would however mean that PCIe (i.e. ethernet, usb ports on the Mac
>    mini) and possibly Thunderbolt support would not be possible since these
>    devices don't seem to like iommu bypass mode at all.

It should be possible to do a fake bypass mode by just programming a
static page table for as much address space as you can, and then
use swiotlb to address any memory beyond that. This won't perform
well because it requires bounce buffers for any high memory, but it
can be a last resort if a dart instance cannot do normal bypass mode.

> 2) I've had a brief discussion on IRC with Arnd about this [1] and he pointed
>    out that the dma_map_sg API doesn't make any guarantees about the returned
>    iovas and that it might be possible to make this work at least for devices
>    that go through the normal DMA API.
>
>    I've then replaced the page size check with a WARN_ON in iova.c just to see
>    what happens. At least normal devices that go through the DMA API seem to
>    work with my configuration. iommu_dma_alloc took the iommu_dma_alloc_remap
>    path which was called with the cpu page size but then used
>    domain->pgsize_bitmap to increase that to 16k. So this kinda works out, but
>    there are other functions in dma-iommu.c that I believe rely on the fact that
>    the iommu can map single cpu pages. This feels very fragile right now and
>    would probably require some rather invasive changes.

The other second-to-last resort here would be to duplicate the code from
the dma-iommu code and implement the dma-mapping API directly on
top of the dart hardware instead of the iommu layer. This would probably
be much faster than the swiotlb on top of a bypass or a linear map,
but it's a really awful abstraction that would require adding special cases
into a lot of generic code.

>    Any driver that tries to use the iommu API directly could be trouble
>    as well if they make similar assumptions.

I think pretty much all drivers using the iommu API directly already
depends on having a matching page size.  I don't see any way to use
e.g. PCI device assignment using vfio, or a GPU driver with per-process
contexts when the iotlb page size is larger than the CPU's.

>    Is this something you would even want to support in the iommu subsytem
>    and is it even possible to do this in a sane way?

I don't know how hard it is to do adjust the dma-iommu implementation
to allow this, but as long as we can work out the DT binding to support
both normal dma-iommu mode with 16KB pages and some kind of
passthrough mode (emulated or not) with 4KB pages, it can be left
as a possible optimization for later.

        Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
