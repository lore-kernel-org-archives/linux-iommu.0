Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F06C4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 03:29:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F0160F4B
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 03:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46F0160F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBBF981024;
	Tue, 17 Aug 2021 03:29:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i6IXBC4e42Rq; Tue, 17 Aug 2021 03:29:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9E1B580E6D;
	Tue, 17 Aug 2021 03:29:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37B6AC001A;
	Tue, 17 Aug 2021 03:29:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60D93C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 03:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BF78400DF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 03:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=atishpatra.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gLWZRflNfNaX for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 03:28:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F228400BF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 03:28:55 +0000 (UTC)
Received: by mail-yb1-xb2f.google.com with SMTP id g26so9379121ybe.0
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 20:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tzdzktn6eJFw4s49wHe5WL1ljzPbWd0BSnO2ChJenyg=;
 b=iRigEkOU/lq2H7+3rXhuYnpJrvUTCZEtP+sT9oh7jzX60yWEA71GljsuFR2qdsTxk4
 1D4Xgi/8lzLK3hT/eODEXv/fg27FhlfLLMBQv4c+Le/u+cRKoE+XNCuUFzAPVOZ3Cu5A
 5mALnvxWLki1/8rU9dGV2+5xRSfzrb20HkgH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tzdzktn6eJFw4s49wHe5WL1ljzPbWd0BSnO2ChJenyg=;
 b=c1WEN6J1j4o2gZ53q0HxuhFglfqu2wOsArGk63BGvvfagt31MD/ODTEVZIFjGBzaFY
 wn1hQOakxa/E8DUpO7tJOztc46902PkusbMocl0iwCVOe3yr3I6DPKq2wEWZ+qlHYn8o
 ODLA6sH4S0BAL7ml7Z3ztIpw7wj7l72WZ/pevnD98ZXFxfAFA4kyvYaVQ9X3kqO+3cBM
 djUOJc0NNxe03kvU+DdGTMvKoiQ5Is+OHJ3qU528tmM7Hp7Gw2ZygcOByIo/qkrzG7vO
 3AIoe6XyF+kJynmcrpcDQHbLLIEluJMwVjPNlUxB6zcnD4YPqel5uHQCvm5C1UdLObea
 nRAA==
X-Gm-Message-State: AOAM533oJ373eD5FyVE7yRgvRWw3POKdYBextkrbvhk5Q+0uCmW7OJJh
 Esi9QCw7csTTc8pcBZ1CAbENGGmhhWMHd19ayFhC
X-Google-Smtp-Source: ABdhPJxY/kyjIoitYQP7LbNOYUmWUtLe5137taPE2EVRs8WcUZFYmzjCLuRjV3W07whRbk3VUEXR56mjqhO8zaWABGs=
X-Received: by 2002:a25:3bcb:: with SMTP id i194mr1729383yba.442.1629170934402; 
 Mon, 16 Aug 2021 20:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com>
 <mhng-11e1ab27-21eb-4b20-9185-c256fcaaab99@palmerdabbelt-glaptop>
 <CAOnJCU+ip1ccc9CrREi3c+15ue4Grcq+ENbQ+z_gh3CH249aAg@mail.gmail.com>
 <CAJF2gTSMtj05cduTZ6jEqDXtaG0QTY743MRQrv08B4cocZbXJQ@mail.gmail.com>
In-Reply-To: <CAJF2gTSMtj05cduTZ6jEqDXtaG0QTY743MRQrv08B4cocZbXJQ@mail.gmail.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 16 Aug 2021 20:28:43 -0700
Message-ID: <CAOnJCUKPitLD1g1LocTw8H+G7hg04-=Dd3biHGgDPMwer2cFpw@mail.gmail.com>
Subject: Re: [RFC 0/5] Support non-coherent DMA on RISC-V using a global pool
To: Guo Ren <guoren@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@linux.alibaba.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Atish Patra <Atish.Patra@wdc.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Tobias Klauser <tklauser@distanz.ch>, Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Aug 16, 2021 at 6:37 PM Guo Ren <guoren@kernel.org> wrote:
>
> 1
>
> On Thu, Jul 29, 2021 at 2:19 PM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Wed, Jul 28, 2021 at 9:30 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >
> > > On Fri, 23 Jul 2021 14:40:26 PDT (-0700), Atish Patra wrote:
> > > > RISC-V privilege specification doesn't define an IOMMU or any method modify
> > > > PMA attributes or PTE entries to allow non-coherent mappings yet. In
> > > > the beginning, this approach was adopted assuming that most of the RISC-V
> > > > platforms would support full cache-coherent IO. Here is excerpt from the
> > > > priv spec section 3.6.5
> > > >
> > > > "In RISC-V platforms, the use of hardware-incoherent regions is discouraged
> > > > due to software complexity, performance, and energy impacts."
> > > >
> > > > While some of the RISC-V platforms adhere to the above suggestion, not all
> > > > platforms can afford to build to fully cache-coherent I/O devices. To
> > > > address DMA for non-coherent I/O devices, we need to mark a region of memory
> > > > as non-cacheable. Some of the platforms rely on a fixed region of uncached
> > > > memory that is remapped to the system memory while some other modify
> > > > the PTE entries to achieve that.
> > > >
> > > > The patch3 solves the issue for the fist use case by using a global
> > > > pool of memory that is reserved for DMA. The device access the reserved area
> > > > of the region while corresponding CPU address will be from uncached region
> > > > As the uncached region is remapped to the beginning of the system ram, both
> > > > CPU and device get the same view.
> > > >
> > > > To facilitate streaming DMA APIs, patch 1 introduces a set of generic
> > > > cache operations. Any platform can use the generic ops to provide platform
> > > > specific cache management operations. Once the standard RISC-V CMO extension
> > > > is available, it will also use these generic ops.
> > > >
> > > > To address the second use case, Page Based Memory Attribute (PBMT) extension
> > > > is proposed. Once the extension is in good shape, we can leverage that
> > > > using CONFIG_DIRECT_REMAP. Currently, it is selected via a compile time config
> > > > option. We will probably need another arch specific hooks to know if the
> > > > platform supports direct remap at runtime. For RISC-V, it will check the
> > > > presence of PBMT extension while other arch function will simply return true
> > >
> > > IIUC this is another extension that's not yet frozen or implemented in
> > > hardware?  Is this one compatible with what's in the c906, or is it
> > > doing things its own way?
> >
> > Hi Palmer,
> > This series doesn't implement the PBMT extension which is still in discussion.
> > It simply reuse the existing non-coherent dma mapping support in
> > upstream kernel and enable
> > it for RISC-V. The current version uses a non-coherent global pool. I
> > will update it to use arch_set_uncached
> > as per Christoph's suggestion. It solves the non-coherent DMA problem
> > for beagleV and not c906.
> >
> > I briefly mentioned the PBMT extension just to provide an idea how the
> > RISC-V Linux kernel
> > can support both unached window and PBMT extension. PBMT extension is
> > planned to be frozen
> > by the end of this year and none of the hardware has implemented it.
> >
> > The implementation in c906 is a non-standard one and will not be
> > supported by the default PBMT
> > extension implementation.
> The default PBMT & c908 PBMT are similar, only BIT definitions are
> different. I propose to support default PBMT first and give the back
> door to modify the PBMT definition during boot.
> The "protection_map[] = (__P000, __P001 ..__S000, __S001)" in
> mm/mmap.c has been modified by arch/mips, arm, sparc, x86, so I think
> it's proper solution direction.
>
> The reset problem is how to passing custom PBMT at the very early boot
> stage. Now I'm trying to use the DTS parsing instead of boot param hdr
> which Anup objected to.
>

IIRC, c906 has a compatible mode that has the compliant PTE bit modifications.
Can you use that mode in the Allwinner D1 board to boot Linux ? I am
not sure if you have any fallback method for non-coherent DMA
if custom DMA_COHERENT bits are not enabled through enhanced mode ?

> ref: https://lore.kernel.org/linux-riscv/1623693067-53886-1-git-send-email-guoren@kernel.org/
>
> Any comments are welcome.
>
> >
> >
> > >
> > > > if DIRECT_REMAP is enabled. This is required as arious different config
> > > > (DIRECT_REMAP, GLOBAL_POOL) will be enabled in the defconfig so that a
> > > > unified kernel image can boot on all RISC-V platforms.
> > > >
> > > > This patch series depends on Christoph's global pool support series[1].
> > > > Tested on Qemu, HiFive unleashed and beagleV. This series is also available
> > > > at [2].
> > > > This series also solves the non-coherent DMA support on beagleV but requires
> > > > additional beagleV specific patches[3] which will be upstreamed soon.
> > > >
> > > >
> > > > [1] https://lists.linuxfoundation.org/pipermail/iommu/2021-July/057266.html
> > > > [2] https://github.com/atishp04/linux/tree/riscv_nc_global_pool
> > > > [3] https://github.com/atishp04/linux/tree/wip_beaglev_dma_nc_global
> > > >
> > > > Atish Patra (5):
> > > > RISC-V: Implement arch_sync_dma* functions
> > > > of: Move of_dma_get_range to of_address.h
> > > > dma-mapping: Enable global non-coherent pool support for RISC-V
> > > > dma-direct: Allocate dma pages directly if global pool allocation
> > > > fails
> > > > RISC-V: Support a new config option for non-coherent DMA
> > > >
> > > > arch/riscv/Kconfig                       |  8 +++
> > > > arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
> > > > arch/riscv/mm/Makefile                   |  1 +
> > > > arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
> > > > drivers/of/of_private.h                  | 10 ----
> > > > include/linux/of_address.h               | 12 +++++
> > > > kernel/dma/coherent.c                    | 49 +++++++++++++++---
> > > > kernel/dma/direct.c                      |  7 ++-
> > > > 8 files changed, 152 insertions(+), 20 deletions(-)
> > > > create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
> > > > create mode 100644 arch/riscv/mm/dma-noncoherent.c
> > >
> > > Can you guys please make up your minds about how this is going to be
> > > supported at the ISA level?  I get a different answer every day here:
> > > sometimes it's that these systems are not compliant, sometimes that
> > > Linux is the compliance suite, sometimes that we're doing an ISA
> > > extension, and sometimes that we're doing the SBI stuff.
> > >
> >
> > I am not sure whom you have talked to. I would be happy to set up a
> > meeting so that everybody is on
> > the same page if you are getting different answers every time.
> >
> > > I don't really care all that much about what the decision is, but it's
> > > impossible to move forward without some semblance of a plan.
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Regards,
Atish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
