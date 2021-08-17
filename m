Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB526C4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 01:37:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B18C60EAF
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 01:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B18C60EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36BFD40454;
	Tue, 17 Aug 2021 01:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXU3YNQrZWWy; Tue, 17 Aug 2021 01:37:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 47AA040434;
	Tue, 17 Aug 2021 01:37:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D490C001A;
	Tue, 17 Aug 2021 01:37:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C85DC000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 532AF400DF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EQWjpt7RVeJK for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 01:37:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0134340012
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:37:45 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D72760F36
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629164265;
 bh=lyEqQ7l1Yiyq6aw60bIoBStsCKDCHydWqeO/k8C6ocA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=O9F7swSYu7svCJQyNRlDcsBEikHRWfeS+ggbP7cvoYhC6Ltq3AZNiFh7qaGiOEPk6
 OJxblhulbKJYPFGt2F0GZkHIMt1dFD9G6wDSp0cemKHzGLMO24stXNiGSRFiEqKUMf
 f4O94mCejViD1KuASpxHztus7+mnMGoRBbJZhB8OsfIcYnAOqHBKkz+NkNXPkBmh+b
 zqkcEZzZD7rOxBOEXlBzFaGZxsbMytK+8es7tsItI0ziwdAXEwRE7Im4BMZZeewC3X
 l9/3J2Q8BVl7r+Az5NS79bI7V4XdUBrakAvQTCf/PNED2KKPJFRmgiXEgBN+U6RKpZ
 WCKJcXTQy9ulA==
Received: by mail-lf1-f54.google.com with SMTP id z2so38272367lft.1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 18:37:45 -0700 (PDT)
X-Gm-Message-State: AOAM532mCrT6Ol++kjFlChOqajVSB93qLcbnNybHLGmpQCtpaR2ezZ+2
 DheTpkrDmK3hQk0Z87iBm7MYYSPMtsUWKQVwcw8=
X-Google-Smtp-Source: ABdhPJzwjeTd12CIMnVCq48VJEcqCSSqf9a4FB/mjRjpz0oczdS+/2z6XqLkbYgRAwWKBkw3o8r1HeMMgeaurC77pvc=
X-Received: by 2002:a19:5002:: with SMTP id e2mr508720lfb.355.1629164263759;
 Mon, 16 Aug 2021 18:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com>
 <mhng-11e1ab27-21eb-4b20-9185-c256fcaaab99@palmerdabbelt-glaptop>
 <CAOnJCU+ip1ccc9CrREi3c+15ue4Grcq+ENbQ+z_gh3CH249aAg@mail.gmail.com>
In-Reply-To: <CAOnJCU+ip1ccc9CrREi3c+15ue4Grcq+ENbQ+z_gh3CH249aAg@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 17 Aug 2021 09:37:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSMtj05cduTZ6jEqDXtaG0QTY743MRQrv08B4cocZbXJQ@mail.gmail.com>
Message-ID: <CAJF2gTSMtj05cduTZ6jEqDXtaG0QTY743MRQrv08B4cocZbXJQ@mail.gmail.com>
Subject: Re: [RFC 0/5] Support non-coherent DMA on RISC-V using a global pool
To: Atish Patra <atishp@atishpatra.org>
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

1

On Thu, Jul 29, 2021 at 2:19 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Jul 28, 2021 at 9:30 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Fri, 23 Jul 2021 14:40:26 PDT (-0700), Atish Patra wrote:
> > > RISC-V privilege specification doesn't define an IOMMU or any method modify
> > > PMA attributes or PTE entries to allow non-coherent mappings yet. In
> > > the beginning, this approach was adopted assuming that most of the RISC-V
> > > platforms would support full cache-coherent IO. Here is excerpt from the
> > > priv spec section 3.6.5
> > >
> > > "In RISC-V platforms, the use of hardware-incoherent regions is discouraged
> > > due to software complexity, performance, and energy impacts."
> > >
> > > While some of the RISC-V platforms adhere to the above suggestion, not all
> > > platforms can afford to build to fully cache-coherent I/O devices. To
> > > address DMA for non-coherent I/O devices, we need to mark a region of memory
> > > as non-cacheable. Some of the platforms rely on a fixed region of uncached
> > > memory that is remapped to the system memory while some other modify
> > > the PTE entries to achieve that.
> > >
> > > The patch3 solves the issue for the fist use case by using a global
> > > pool of memory that is reserved for DMA. The device access the reserved area
> > > of the region while corresponding CPU address will be from uncached region
> > > As the uncached region is remapped to the beginning of the system ram, both
> > > CPU and device get the same view.
> > >
> > > To facilitate streaming DMA APIs, patch 1 introduces a set of generic
> > > cache operations. Any platform can use the generic ops to provide platform
> > > specific cache management operations. Once the standard RISC-V CMO extension
> > > is available, it will also use these generic ops.
> > >
> > > To address the second use case, Page Based Memory Attribute (PBMT) extension
> > > is proposed. Once the extension is in good shape, we can leverage that
> > > using CONFIG_DIRECT_REMAP. Currently, it is selected via a compile time config
> > > option. We will probably need another arch specific hooks to know if the
> > > platform supports direct remap at runtime. For RISC-V, it will check the
> > > presence of PBMT extension while other arch function will simply return true
> >
> > IIUC this is another extension that's not yet frozen or implemented in
> > hardware?  Is this one compatible with what's in the c906, or is it
> > doing things its own way?
>
> Hi Palmer,
> This series doesn't implement the PBMT extension which is still in discussion.
> It simply reuse the existing non-coherent dma mapping support in
> upstream kernel and enable
> it for RISC-V. The current version uses a non-coherent global pool. I
> will update it to use arch_set_uncached
> as per Christoph's suggestion. It solves the non-coherent DMA problem
> for beagleV and not c906.
>
> I briefly mentioned the PBMT extension just to provide an idea how the
> RISC-V Linux kernel
> can support both unached window and PBMT extension. PBMT extension is
> planned to be frozen
> by the end of this year and none of the hardware has implemented it.
>
> The implementation in c906 is a non-standard one and will not be
> supported by the default PBMT
> extension implementation.
The default PBMT & c908 PBMT are similar, only BIT definitions are
different. I propose to support default PBMT first and give the back
door to modify the PBMT definition during boot.
The "protection_map[] = (__P000, __P001 ..__S000, __S001)" in
mm/mmap.c has been modified by arch/mips, arm, sparc, x86, so I think
it's proper solution direction.

The reset problem is how to passing custom PBMT at the very early boot
stage. Now I'm trying to use the DTS parsing instead of boot param hdr
which Anup objected to.

ref: https://lore.kernel.org/linux-riscv/1623693067-53886-1-git-send-email-guoren@kernel.org/

Any comments are welcome.

>
>
> >
> > > if DIRECT_REMAP is enabled. This is required as arious different config
> > > (DIRECT_REMAP, GLOBAL_POOL) will be enabled in the defconfig so that a
> > > unified kernel image can boot on all RISC-V platforms.
> > >
> > > This patch series depends on Christoph's global pool support series[1].
> > > Tested on Qemu, HiFive unleashed and beagleV. This series is also available
> > > at [2].
> > > This series also solves the non-coherent DMA support on beagleV but requires
> > > additional beagleV specific patches[3] which will be upstreamed soon.
> > >
> > >
> > > [1] https://lists.linuxfoundation.org/pipermail/iommu/2021-July/057266.html
> > > [2] https://github.com/atishp04/linux/tree/riscv_nc_global_pool
> > > [3] https://github.com/atishp04/linux/tree/wip_beaglev_dma_nc_global
> > >
> > > Atish Patra (5):
> > > RISC-V: Implement arch_sync_dma* functions
> > > of: Move of_dma_get_range to of_address.h
> > > dma-mapping: Enable global non-coherent pool support for RISC-V
> > > dma-direct: Allocate dma pages directly if global pool allocation
> > > fails
> > > RISC-V: Support a new config option for non-coherent DMA
> > >
> > > arch/riscv/Kconfig                       |  8 +++
> > > arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
> > > arch/riscv/mm/Makefile                   |  1 +
> > > arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
> > > drivers/of/of_private.h                  | 10 ----
> > > include/linux/of_address.h               | 12 +++++
> > > kernel/dma/coherent.c                    | 49 +++++++++++++++---
> > > kernel/dma/direct.c                      |  7 ++-
> > > 8 files changed, 152 insertions(+), 20 deletions(-)
> > > create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
> > > create mode 100644 arch/riscv/mm/dma-noncoherent.c
> >
> > Can you guys please make up your minds about how this is going to be
> > supported at the ISA level?  I get a different answer every day here:
> > sometimes it's that these systems are not compliant, sometimes that
> > Linux is the compliance suite, sometimes that we're doing an ISA
> > extension, and sometimes that we're doing the SBI stuff.
> >
>
> I am not sure whom you have talked to. I would be happy to set up a
> meeting so that everybody is on
> the same page if you are getting different answers every time.
>
> > I don't really care all that much about what the decision is, but it's
> > impossible to move forward without some semblance of a plan.
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
