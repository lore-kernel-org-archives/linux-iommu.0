From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: IOMMU breakage on arm64
Date: Wed, 7 Nov 2018 09:42:26 +0100
Message-ID: <CAMuHMdWTe+B8=a5yz+VjJU9G+mss7+61U3jT7i_WgMCYD7ppCw@mail.gmail.com>
References: <git-mailbomb-linux-master-b4ebe6063204da58e48600b810a97c29ae9e5d12@kernel.org>
 <CAMuHMdUosqWTn5yDjGMWrLpWEyZfxtGWYfqmenYVqE8g7HEt7Q@mail.gmail.com> <44b77976-0efe-02d0-3c4e-4e54f91c4fe7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <44b77976-0efe-02d0-3c4e-4e54f91c4fe7@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Tue, Nov 6, 2018 at 9:20 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2018-11-06 7:44 pm, Geert Uytterhoeven wrote:
> > On Tue, Oct 23, 2018 at 1:40 AM Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org> wrote:
> >> Commit:     b4ebe6063204da58e48600b810a97c29ae9e5d12
> >> Parent:     7d21ee4c719f00896767ce19c4c01a56374c2ced
> >> Refname:    refs/heads/master
> >> Web:        https://git.kernel.org/torvalds/c/b4ebe6063204da58e48600b810a97c29ae9e5d12
> >> Author:     Christoph Hellwig <hch@lst.de>
> >> AuthorDate: Thu Sep 20 14:04:08 2018 +0200
> >> Committer:  Christoph Hellwig <hch@lst.de>
> >> CommitDate: Mon Oct 1 07:28:03 2018 -0700
> >>
> >>      dma-direct: implement complete bus_dma_mask handling
> >>
> >>      Instead of rejecting devices with a too small bus_dma_mask we can handle
> >>      by taking the bus dma_mask into account for allocations and bounce
> >>      buffering decisions.
> >>
> >>      Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > I  have bisected the following crash to the above commit:
>
> I think that commit mostly just changes the presentation of my
> underlying cockup - see here for what should fix it:
> https://patchwork.kernel.org/patch/10670177/

Thanks, that fixed the issue.

> I have a feeling we've ironed out crash-on-early-domain-free bugs in the
> SMMU drivers already - arm-smmu certainly has an early return in
> arm_smmu_destroy_domain_context() which should behave exactly like your
> diff below, while I think arm-smmu-v3 gets away with it by virtue of
> smmu_domain->cfg being unset, but I'll double-check that when I'm fresh
> tomorrow (Jean-Philippe reported SMMUv3 hitting the DMA thing to me
> internally, but didn't mention any crash).

OK, I'll send a proper patch for the ipmmu-vmsa driver.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
