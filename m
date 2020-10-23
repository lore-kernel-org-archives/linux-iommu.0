Return-Path: <SRS0=xWGd=D6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED732C4363A
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 17:38:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5C721582
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 17:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5C721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C9AEC87689;
	Fri, 23 Oct 2020 17:38:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGaDwlY36W3S; Fri, 23 Oct 2020 17:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B28387671;
	Fri, 23 Oct 2020 17:38:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 483DBC088B;
	Fri, 23 Oct 2020 17:38:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82042C0051
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 17:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6871787674
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 17:38:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gT3HsiVK545 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 17:38:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 08F3B87669
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 17:38:17 +0000 (UTC)
Received: from gaia (unknown [95.145.162.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 26A7721527;
 Fri, 23 Oct 2020 17:38:13 +0000 (UTC)
Date: Fri, 23 Oct 2020 18:38:11 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v4 5/7] arm64: mm: Set ZONE_DMA size based on
 devicetree's dma-ranges
Message-ID: <20201023173810.GH25736@gaia>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
 <20201021123437.21538-6-nsaenzjulienne@suse.de>
 <20201022180632.GI1229@gaia>
 <a6ab535a70958b1f79b45583eef8ba7f7172f9ce.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6ab535a70958b1f79b45583eef8ba7f7172f9ce.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, ardb@kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
 robin.murphy@arm.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 23, 2020 at 05:27:49PM +0200, Nicolas Saenz Julienne wrote:
> On Thu, 2020-10-22 at 19:06 +0100, Catalin Marinas wrote:
> > On Wed, Oct 21, 2020 at 02:34:35PM +0200, Nicolas Saenz Julienne wrote:
> > > @@ -188,9 +186,11 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> > >  static void __init zone_sizes_init(unsigned long min, unsigned long max)
> > >  {
> > >  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> > > +	unsigned int __maybe_unused dt_zone_dma_bits;
> > >  
> > >  #ifdef CONFIG_ZONE_DMA
> > > -	zone_dma_bits = ARM64_ZONE_DMA_BITS;
> > > +	dt_zone_dma_bits = ilog2(of_dma_get_max_cpu_address(NULL));
> > > +	zone_dma_bits = min(32U, dt_zone_dma_bits);
> > 
> > A thought: can we remove the min here and expand ZONE_DMA to whatever
> > dt_zone_dma_bits says? More on this below.
> 
> On most platforms we'd get PHYS_ADDR_MAX, or something bigger than the actual
> amount of RAM. Which would ultimately create a system wide ZONE_DMA. At first
> sight, I don't see it breaking dma-direct in any way.
> 
> On the other hand, there is a big amount of MMIO devices out there that can
> only handle 32-bit addressing. Be it PCI cards or actual IP cores. To make
> things worse, this limitation is often expressed in the driver, not FW (with
> dma_set_mask() and friends). If those devices aren't behind an IOMMU we have be
> able to provide at least 32-bit addressable memory. See this comment from
> dma_direct_supported():
> 
> /*
>  * Because 32-bit DMA masks are so common we expect every architecture
>  * to be able to satisfy them - either by not supporting more physical
>  * memory, or by providing a ZONE_DMA32.  If neither is the case, the
>  * architecture needs to use an IOMMU instead of the direct mapping.
>  */
> 
> I think, for the common case, we're stuck with at least one zone spanning the
> 32-bit address space.

You are right, I guess it makes sense to keep a 32-bit zone as not all
devices would be described as such.

> > >  	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> > >  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
> > >  #endif
> > 
> > I was talking earlier to Ard and Robin on the ZONE_DMA32 history and the
> > need for max_zone_phys(). This was rather theoretical, the Seattle
> > platform has all RAM starting above 4GB and that led to an empty
> > ZONE_DMA32 originally. The max_zone_phys() hack was meant to lift
> > ZONE_DMA32 into the bottom of the RAM, on the assumption that such
> > 32-bit devices would have a DMA offset hardwired. We are not aware of
> > any such case on arm64 systems and even on Seattle, IIUC 32-bit devices
> > only work if they are behind an SMMU (so no hardwired offset).
> > 
> > In hindsight, it would have made more sense on platforms with RAM above
> > 4GB to expand ZONE_DMA32 to cover the whole memory (so empty
> > ZONE_NORMAL). Something like:
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index a53c1e0fb017..7d5e3dd85617 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -187,8 +187,12 @@ static void __init reserve_elfcorehdr(void)
> >   */
> >  static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> >  {
> > -	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, zone_bits);
> > -	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
> > +	phys_addr_t zone_mask = 1ULL << zone_bits;
> > +
> > +	if (!(memblock_start_of_DRAM() & zone_mask))
> > +		zone_mask = PHYS_ADDR_MAX;
> > +
> > +	return min(zone_mask, memblock_end_of_DRAM());
> >  }
> >  
> >  static void __init zone_sizes_init(unsigned long min, unsigned long max)
> > 
> > I don't think this makes any difference for ZONE_DMA unless a
> > broken DT or IORT reports the max CPU address below the start of DRAM.
> > 
> > There's a minor issue if of_dma_get_max_cpu_address() matches
> > memblock_end_of_DRAM() but they are not a power of 2. We'd be left with
> > a bit of RAM at the end in ZONE_NORMAL due to ilog2 truncation.
> 
> I agree it makes no sense to create more than one zone when the beginning of
> RAM is located above the 32-bit address space. I'm all for disregarding the
> possibility of hardwired offsets. As a bonus, as we already discussed some time
> ago, this is something that never played well with current dma-direct code[1].
> 
> [1] https://lkml.org/lkml/2020/9/8/377

Maybe this one is still worth fixing, at least for consistency. But it's
not urgent.

My diff above has a side-effect that if dt_zone_dma_bits is below the
start of DRAM, ZONE_DMA gets expanded to PHYS_ADDR_MAX. If this was
32-bit, that's fine but if it was, say, 30-bit because of some firmware
misdescription with RAM starting at 2GB, we end up with no ZONE_DMA32. I
think max_zone_phys() could cap this at 32, as a safety mechanism:

static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
{
	phys_addr_t zone_mask = (1ULL << zone_bits) - 1;
	phys_addr_t phys_start = memblock_start_of_DRAM();

	if (!(phys_start & U32_MAX))
		zone_mask = PHYS_ADDR_MAX;
	else if (!(phys_start & zone_mask))
		zone_mask = U32_MAX;

	return min(zone_mask + 1, memblock_end_of_DRAM());
}

Assuming I got the shifting right, arm64_dma_phys_limit becomes:

 	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits, 32);

-- 
Catalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
