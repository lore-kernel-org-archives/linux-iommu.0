Return-Path: <SRS0=K8mx=DR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D48C43467
	for <iommu@archiver.kernel.org>; Sat, 10 Oct 2020 12:39:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A462222E
	for <iommu@archiver.kernel.org>; Sat, 10 Oct 2020 12:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A462222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 771E88776A;
	Sat, 10 Oct 2020 12:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9YMIqYzjus7I; Sat, 10 Oct 2020 12:39:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B519987750;
	Sat, 10 Oct 2020 12:39:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D5C2C07FF;
	Sat, 10 Oct 2020 12:39:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61F64C0051
 for <iommu@lists.linux-foundation.org>; Sat, 10 Oct 2020 12:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 47F778776A
 for <iommu@lists.linux-foundation.org>; Sat, 10 Oct 2020 12:39:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T-FKcYXtmYp9 for <iommu@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 12:39:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5454D87750
 for <iommu@lists.linux-foundation.org>; Sat, 10 Oct 2020 12:39:00 +0000 (UTC)
Received: from gaia (unknown [95.149.105.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1DFA21655;
 Sat, 10 Oct 2020 12:38:57 +0000 (UTC)
Date: Sat, 10 Oct 2020 13:38:55 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
Message-ID: <20201010123854.GA27186@gaia>
References: <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de>
 <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
 <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
 <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
 <20201009152433.GA19953@e121166-lin.cambridge.arm.com>
 <CAMj1kXFuqw3qNRAB78OzvMws+t7=B6L8pASA36D2fxXobbvpUA@mail.gmail.com>
 <20201009171051.GL23638@gaia>
 <CAMj1kXEWeqGVr=QV7zQ+dXBK=t_Lh+W9q1+kLLdBw8=Pj798Ng@mail.gmail.com>
 <e62784bde26293c26fcc2fee50133dc445c084ab.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e62784bde26293c26fcc2fee50133dc445c084ab.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Linux Memory Management List <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Sat, Oct 10, 2020 at 12:53:19PM +0200, Nicolas Saenz Julienne wrote:
> On Sat, 2020-10-10 at 12:36 +0200, Ard Biesheuvel wrote:
> > On Fri, 9 Oct 2020 at 19:10, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Fri, Oct 09, 2020 at 06:23:06PM +0200, Ard Biesheuvel wrote:
> > > > On Fri, 9 Oct 2020 at 17:24, Lorenzo Pieralisi
> > > > <lorenzo.pieralisi@arm.com> wrote:
> > > > > We can move this check to IORT code and call it from arm64 if it
> > > > > can be made to work.
> > > > 
> > > > Finding the smallest value in the IORT, and assigning it to
> > > > zone_dma_bits if it is < 32 should be easy. But as I understand it,
> > > > having these separate DMA and DMA32 zones is what breaks kdump, no? So
> > > > how is this going to fix the underlying issue?
> > > 
> > > If zone_dma_bits is 32, ZONE_DMA32 disappears into ZONE_DMA (GFP_DMA32
> > > allocations fall back to ZONE_DMA).
> > > 
> > > kdump wants DMA-able memory and, without a 30-bit ZONE_DMA, that would
> > > be the bottom 32-bit. With the introduction of ZONE_DMA, this suddenly
> > > became 1GB. We could change kdump to allocate ZONE_DMA32 but this one
> > > may also be small as it lost 1GB to ZONE_DMA. However, the kdump kernel
> > > would need to be rebuilt without ZONE_DMA since it won't have any. IIRC
> > > (it's been a while since I looked), the kdump allocation couldn't span
> > > multiple zones.
> > > 
> > > In a separate thread, we try to fix kdump to use allocations above 4G as
> > > a fallback but this only fixes platforms with enough RAM (and maybe it's
> > > only those platforms that care about kdump).
> > > 
> > 
> > One thing that strikes me as odd is that we are applying the same
> > shifting logic to ZONE_DMA as we are applying to ZONE_DMA32, i.e., if
> > DRAM starts outside of the zone, it is shifted upwards.
> > 
> > On a typical ARM box, this gives me
> > 
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000080000000-0x00000000bfffffff]
> > [    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
> > [    0.000000]   Normal   [mem 0x0000000100000000-0x0000000fffffffff]
> > 
> > i.e., the 30-bit addressable range has bit 31 set, which is weird.
> 
> Yes I agree it's weird, and IMO plain useless. I sent a series this summer to
> address this[1], which ultimately triggered the discussion we're having right
> now.

I don't mind assuming that ZONE_DMA is always from pfn 0 (i.e. no
dma_offset for such constrained devices). But if ZONE_DMA32 is squeezed
out with ZONE_DMA extended to 4GB, it should allow non-zero upper 32
bits. IIRC we do have SoCs with RAM starting above 4GB.

However, your patch didn't completely solve the problem for non-RPi4
platforms as there's hardware with RAM starting at 0 that doesn't need
the 1GB ZONE_DMA. We may end up with a combination of the two
approaches.

> Although with with your latest patch and the DT counterpart, we should be OK.
> It would be weird for a HW description to define DMA constraints that are
> impossible to reach on that system.

I don't remember the difficulties with parsing a DT early for inferring
the ZONE_DMA requirements. Could we not check the dma-ranges property in
the soc node? I can see bcm2711.dtsi defines a 30-bit address range. We
are not interested in the absolute physical/bus addresses, just the
size to check whether it's smaller than 32-bit.

> > I wonder if it wouldn't be better (and less problematic in the general
> > case) to drop this logic for ZONE_DMA, and simply let it remain empty
> > unless there is really some memory there.
> 
> From my experience, you can't have empty ZONE_DMA when enabled. Empty
> ZONE_DMA32 is OK though. Although I'm sure it's something that can be changed.

Indeed, because we still have GFP_DMA around which can't fall back to
ZONE_DMA32 (well, unless CONFIG_ZONE_DMA is disabled).

-- 
Catalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
