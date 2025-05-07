Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DBB1ACEC8;
	Wed,  7 May 2025 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746659359; cv=none; b=gvExzpBVbw4xRTrAKdwR9tx0sK98x9AItAOpCPUGPKMR5Ub6fbET2ToxQuA7jujXdL2GpCgf3saPuQUtUYH0Y8z9ZP5NvWZh77Qk5KybJAYTj0UVmRVK3ldZK62GKEGsKeZY5wOtdcjD5AcnfOuFKJvpkD91OrJgTDZi80fwass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746659359; c=relaxed/simple;
	bh=if38SdnC0AJjNobF5sj+Z+diQFRQsDZaQWTmcM3J0z0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R36SoJwxghaJNxV9TCRsXK/cFUiD46/d5p4S9YVlDASq3QXM8ifAfW/P0cBaWPmvxtkwCfAhrtue+IVzWTmwXaL0KTy7/W4zmKIAmmcLVwC9uXp0NUYmLWJAhU6R2uUKI4FzxaV2cY4YcK9GXIPC6remPbRPOPH7N5DlCIKgRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVUT35wF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVUT35wF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4150CC4CEE2;
	Wed,  7 May 2025 23:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746659358;
	bh=if38SdnC0AJjNobF5sj+Z+diQFRQsDZaQWTmcM3J0z0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bVUT35wFQvPLtu0LytwChJj8OCMGL50uKSUkAw/N299dum2gMqiUCpyl5S06wAMwP
	 LCEdm1qGVJNMvc0xia9kjE1XilBbXfDOpHCsU+MT0fvQXnKV30xtuGljLYyec6KmdU
	 oULJXb2Q7uBOQcET4vHAELvnYz0czULBYVtQ6q33A3B4HtESvwX2yIvtSGq/aN99sv
	 nupLajSjMLfm3Xb5VyTkcRwbKAkT+w97QNGWS/Nsk9lDPzNTbaXKMCQbpExRU3KOvb
	 aFIvTIa68tC4XysVp57S5ddzdoZm1eOBI+/yvxN/Snhy0o+j9u8OrcZTJ8DARIVDKk
	 8PdOrgh3+9ShA==
Date: Wed, 7 May 2025 16:09:15 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: John Ernberg <john.ernberg@actia.se>
cc: Stefano Stabellini <sstabellini@kernel.org>, 
    Juergen Gross <jgross@suse.com>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
    "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "imx@lists.linux.dev" <imx@lists.linux.dev>, 
    Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] xen: swiotlb: Implement map_resource callback
In-Reply-To: <75266eb7-66a4-4477-ae8a-cbd1ebbee8db@actia.se>
Message-ID: <alpine.DEB.2.22.394.2505071602570.3879245@ubuntu-linux-20-04-desktop>
References: <20250502114043.1968976-1-john.ernberg@actia.se> <20250502114043.1968976-3-john.ernberg@actia.se> <alpine.DEB.2.22.394.2505021007460.3879245@ubuntu-linux-20-04-desktop> <75266eb7-66a4-4477-ae8a-cbd1ebbee8db@actia.se>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 May 2025, John Ernberg wrote:
> Hi Stefano,
> 
> On 5/2/25 7:20 PM, Stefano Stabellini wrote:
> > +Christoph
> > 
> > On Fri, 2 May 2025, John Ernberg wrote:
> >> Needed by the eDMA v3 DMA engine found in iommu-less SoCs such as iMX8QXP
> >> to be able to perform DMA operations as a Xen Hardware Domain, which needs
> >> to be able to do DMA in MMIO space.
> 
> Self-note: The above part of the commit message is a disaster and should 
> read something like.
> 
> Needed by SoCs without an iommu (such as the iMX8QXP and it's eDMA v3 
> engine) that need to be able to perform DMA operations in MMIO space.
> 
> >>
> >> The callback implementation is basically the same as the one for direct
> >> mapping of resources, except this also takes into account Xen page
> >> mappings.
> >>
> >> There is nothing to do for unmap, just like with direct, so the unmap
> >> callback is not needed.
> >>
> >> Signed-off-by: John Ernberg <john.ernberg@actia.se>
> >>
> >> ---
> >>
> >> I originally exported dma_direct_map_resource() and used that which
> >> appeared to work, but it felt like not checking Xen page mappings wasn't
> >> fully correct and I went with this. But if dma_direct_map_resource() is
> >> the correct approach here then I can submit that isntead.
> >> ---
> >>   drivers/xen/swiotlb-xen.c | 15 +++++++++++++++
> >>   1 file changed, 15 insertions(+)
> >>
> >> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> >> index ef56a2500ed6..0f02fdd9128d 100644
> >> --- a/drivers/xen/swiotlb-xen.c
> >> +++ b/drivers/xen/swiotlb-xen.c
> >> @@ -285,6 +285,20 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> >>                                           attrs, pool);
> >>   }
> >>
> >> +static dma_addr_t xen_swiotlb_map_resource(struct device *dev, phys_addr_t phys,
> >> +                                        size_t size, enum dma_data_direction dir,
> >> +                                        unsigned long attrs)
> >> +{
> >> +     dma_addr_t dev_addr = xen_phys_to_dma(dev, phys);
> > 
> > Yes, we need the xen_phys_to_dma call here. This is one of the reasons I
> > don't think we can use dma_direct_map_resource() to implement
> > map_resource
> > 
> > 
> >> +     BUG_ON(dir == DMA_NONE);
> >> +
> >> +     if (!dma_capable(dev, dev_addr, size, false))
> >> +             return DMA_MAPPING_ERROR;
> > 
> > But here you also need to check that phys+size doesn't cross a page
> > boundary. You need to call range_straddles_page_boundary, like we do at
> > the beginning of xen_swiotlb_map_page.
> > 
> > If it is possible to cross a page boundary, then we need to basically to
> > do the same thing here as we do in xen_swiotlb_map_page where we check
> > for:
> > 
> >          if (dma_capable(dev, dev_addr, size, true) &&
> >              !range_straddles_page_boundary(phys, size) &&
> >                  !xen_arch_need_swiotlb(dev, phys, dev_addr) &&
> >                  !is_swiotlb_force_bounce(dev))
> >                  goto done;
> > 
> > if all is well, we go with the native path, otherwise we bounce on
> > swiotlb-xen.
> > 
> 
> I'll preface this with that it's my first deep dive in DMA, so the 
> following may entirely be me being stupid:
> 
> I'm not sure a straddles page boundary path makes sense.
> 
> This mapping is not for a RAM backed address. In the eDMA case for the 
> iMX8QXP the `phys` coming in here is the address of a register.

Ok, this information is important :-)

I am not certain whether the map_resource interface can only be called
for MMIO addresses or if it can also be called for RAM-backed addresses
with a size > PAGE_SIZE. In the latter case, we could run into the issue
I was describing.


> I cannot see how a swiotlb bounce would fix anything if you end up
> straddling a page boundary. At most I can see a WARN_ON with a
> DMA_MAPPING_ERROR return if such a check would yield true.
> 
> Let's say you want to do a DEV_TO_MEM and a check decides you need to 
> bounce it you'd bounce an RX register address. I cannot see how that DMA 
> would ever end up doing the expected thing.
> 
> The eDMA engine will manage the RX/TX registers for an IP block and move 
> the data between them and RAM, where the RAM memory is mapped separately 
> by dma_map_page (and family). And these can be swiotlb bounced via the 
> map page callback with no problem.

OK thanks for the explanation. Like I wrote above, if we are guaranteed
that map_resource cannot be called for RAM-backed addresses or size is
less than PAGE_SIZE, then your patch is good as-is. If there are no such
guarantees, then we'll have to think a bit more about it.
