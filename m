Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E7C6369E
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 17:45:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28D2246DE
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 17:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28D2246DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5C619273CF;
	Thu, 19 Nov 2020 17:45:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZDLd3894gWs; Thu, 19 Nov 2020 17:45:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B382D20479;
	Thu, 19 Nov 2020 17:45:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8617AC163C;
	Thu, 19 Nov 2020 17:45:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87E80C0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 17:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 768A186A57
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 17:45:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3SwfXE0G2iaM for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 17:45:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7511086962
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 17:45:37 +0000 (UTC)
Received: from gaia (unknown [2.26.170.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23DC921D7A;
 Thu, 19 Nov 2020 17:45:33 +0000 (UTC)
Date: Thu, 19 Nov 2020 17:45:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
Message-ID: <20201119174530.GH4376@gaia>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
 <20201103173159.27570-2-nsaenzjulienne@suse.de>
 <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
 <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
 <X6rZRvWyigCJxAVW@trantor>
 <b5336064145a30aadcfdb8920226a8c63f692695.camel@suse.de>
 <20201113112901.GA3212@gaia>
 <ba343af12fc60bce36837cc090a39c9e42457788.camel@suse.de>
 <20201119171048.GD4376@gaia>
 <d232c68aa73e5c71524e3c9ef52386047af84386.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d232c68aa73e5c71524e3c9ef52386047af84386.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Chen Zhou <chenzhou10@huawei.com>,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 ardb@kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 James Morse <james.morse@arm.com>, linux-rpi-kernel@lists.infradead.org,
 guohanjun@huawei.com, will@kernel.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Nov 19, 2020 at 06:25:29PM +0100, Nicolas Saenz Julienne wrote:
> On Thu, 2020-11-19 at 17:10 +0000, Catalin Marinas wrote:
> > On Thu, Nov 19, 2020 at 03:09:58PM +0100, Nicolas Saenz Julienne wrote:
> > > On Fri, 2020-11-13 at 11:29 +0000, Catalin Marinas wrote:
> > > [...]
> > > > > > > Let me stress that knowing the DMA constraints in the system before reserving
> > > > > > > crashkernel's regions is necessary if we ever want it to work seamlessly on all
> > > > > > > platforms. Be it small stuff like the Raspberry Pi or huge servers with TB of
> > > > > > > memory.
> > > > > > 
> > > > > > Indeed. So we have 3 options (so far):
> > > > > > 
> > > > > > 1. Allow the crashkernel reservation to go into the linear map but set
> > > > > >    it to invalid once allocated.
> > > > > > 
> > > > > > 2. Parse the flattened DT (not sure what we do with ACPI) before
> > > > > >    creating the linear map. We may have to rely on some SoC ID here
> > > > > >    instead of actual DMA ranges.
> > > > > > 
> > > > > > 3. Assume the smallest ZONE_DMA possible on arm64 (1GB) for crashkernel
> > > > > >    reservations and not rely on arm64_dma_phys_limit in
> > > > > >    reserve_crashkernel().
> > > > > > 
> > > > > > I think (2) we tried hard to avoid. Option (3) brings us back to the
> > > > > > issues we had on large crashkernel reservations regressing on some
> > > > > > platforms (though it's been a while since, they mostly went quiet ;)).
> > > > > > However, with Chen's crashkernel patches we end up with two
> > > > > > reservations, one in the low DMA zone and one higher, potentially above
> > > > > > 4GB. Having a fixed 1GB limit wouldn't be any worse for crashkernel
> > > > > > reservations than what we have now.
> > > > > > 
> > > > > > If (1) works, I'd go for it (James knows this part better than me),
> > > > > > otherwise we can go for (3).
> > > > > 
> > > > > Overall, I'd prefer (1) as well, and I'd be happy to have a got at it. If not
> > > > > I'll append (3) in this series.
> > > > 
> > > > I think for 1 we could also remove the additional KEXEC_CORE checks,
> > > > something like below, untested:
> > > > 
> > > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > > index 3e5a6913acc8..27ab609c1c0c 100644
> > > > --- a/arch/arm64/mm/mmu.c
> > > > +++ b/arch/arm64/mm/mmu.c
> > > > @@ -477,7 +477,8 @@ static void __init map_mem(pgd_t *pgdp)
> > > >  	int flags = 0;
> > > >  	u64 i;
> > > >  
> > > > -	if (rodata_full || debug_pagealloc_enabled())
> > > > +	if (rodata_full || debug_pagealloc_enabled() ||
> > > > +	    IS_ENABLED(CONFIG_KEXEC_CORE))
> > > >  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> > > >  
> > > >  	/*
> > > > @@ -487,11 +488,6 @@ static void __init map_mem(pgd_t *pgdp)
> > > >  	 * the following for-loop
> > > >  	 */
> > > >  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> > > > -#ifdef CONFIG_KEXEC_CORE
> > > > -	if (crashk_res.end)
> > > > -		memblock_mark_nomap(crashk_res.start,
> > > > -				    resource_size(&crashk_res));
> > > > -#endif
> > > >  
> > > >  	/* map all the memory banks */
> > > >  	for_each_mem_range(i, &start, &end) {
> > > > @@ -518,21 +514,6 @@ static void __init map_mem(pgd_t *pgdp)
> > > >  	__map_memblock(pgdp, kernel_start, kernel_end,
> > > >  		       PAGE_KERNEL, NO_CONT_MAPPINGS);
> > > >  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> > > > -
> > > > -#ifdef CONFIG_KEXEC_CORE
> > > > -	/*
> > > > -	 * Use page-level mappings here so that we can shrink the region
> > > > -	 * in page granularity and put back unused memory to buddy system
> > > > -	 * through /sys/kernel/kexec_crash_size interface.
> > > > -	 */
> > > > -	if (crashk_res.end) {
> > > > -		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
> > > > -			       PAGE_KERNEL,
> > > > -			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> > > > -		memblock_clear_nomap(crashk_res.start,
> > > > -				     resource_size(&crashk_res));
> > > > -	}
> > > > -#endif
> > > >  }
> > > >  
> > > >  void mark_rodata_ro(void)
> > > 
> > > So as far as I'm concerned this is good enough for me. I took the time to
> > > properly test crashkernel on RPi4 using the series, this patch, and another
> > > small fix to properly update /proc/iomem.
> > > 
> > > I'll send v7 soon, but before, James (or anyone for that matter) any obvious
> > > push-back to Catalin's solution?
> > 
> > I talked to James earlier and he was suggesting that we check the
> > command line for any crashkernel reservations and only disable block
> > mappings in that case, see the diff below on top of the one I already
> > sent (still testing it).
> 
> That's even better :)
> 
> > If you don't have any other changes for v7, I'm happy to pick v6 up on
> > top of the no-block-mapping fix.
> 
> Yes I've got a small change in patch #1, the crashkernel reservation has to be
> performed before request_standart_resouces() is called, which is OK, since
> we're all setup by then, I moved the crashkernel reservation at the end of
> bootmem_init(). I attached the patch. If it's easier for you I'll send v7.

Please send a v7, otherwise b4 gets confused.

Thanks.

-- 
Catalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
