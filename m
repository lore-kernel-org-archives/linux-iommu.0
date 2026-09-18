Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656DD49D5BA;
	Fri, 18 Sep 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746606; cv=none; b=on/eAvFx9e2GkeqLbV3dr9gcl9cLygnYqb4JNp4T5TBuq6BvW3h7rdt/Yb6wlgvtyd4NoQS3zDIz1o6ciXntrrogERmXnmlgiMqXIHvCet8Muigxs2EdGeW491rYVeBTrhQzmnE8wpx9RC94hU+LB/cAF3A8eYjIwRPE9MXP4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746606; c=relaxed/simple;
	bh=NtTW+7R8syQSRECGj3UX4rZbRLNNdz3lSfU2efHFFpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F04HBAP2h5JAFPUxSQXKS1GHQuchX3jphMQ8Ekenf+I9oLk3zK0s7mSQS+wv0gAfC6dHFbr6hNnn7HXF7d2pSrtS4wrkwqrG62LJBrhpAPWKgTUkLCRlZGReI3M5Q8lPQCHTiz7uhTVTQuiEfggOi3GTOhso/jABegHFbOV+L18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqqodusm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqqodusm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEFA1F000FF;
	Fri, 18 Sep 2026 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746605;
	bh=tEW1QDQGaeEjP2/bEOYM+rrJce5dTl6rQHpum/y6Jk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TqqodusmO+65WNT2urqrQ8BbzgUt3GYNxJA4+0GCWtGyNavFx75B2DOVLHJM7QDhM
	 9QG8k5aWPz0WcWGYpmDi/UKNxwgo4wu5Nc9WunOpJpSA+Eee0Z9sV3fUa9dIPbugJp
	 PCusP9TLoLVGfI3vkqYb1jda4BzO3vwaw/+ntuDUauWgsqr2R8N6enTMD5RT5goVyQ
	 fwkc1+JQ1meZ6B1Jj934HOgZ8Ne0poG/1IXx2Lk8e39YzavLraR2/romfeXUY2WksU
	 GAsLrr3QnW5XjlCNtJ5O7sNthm+MA7JgYJiaAqGcf9UmlrGW88np5SWn6UKzE2xDmk
	 d8ra8JRu9/30Q==
Date: Fri, 18 Sep 2026 18:49:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 0/2] iommu/dma: Fix DMA_ATTR_MMIO swiotlb rejection
Message-ID: <20260918154959.GZ13683@unreal>
References: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
 <20260918123736.GW13683@unreal>
 <aq1GyO3vv8W6Adlr@shlinux89>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aq1GyO3vv8W6Adlr@shlinux89>

On Fri, Sep 18, 2026 at 10:12:24PM +0800, Peng Fan wrote:
> Hi Leon,
> 
> On Fri, Sep 18, 2026 at 03:37:36PM +0300, Leon Romanovsky wrote:
> >On Wed, Sep 16, 2026 at 11:23:32PM +0800, Peng Fan (OSS) wrote:
> >> Commit f9374de14c0e8 ("iommu/dma: implement DMA_ATTR_MMIO for
> >> iommu_dma_(un)map_phys()") and commit c288d657dd515 ("iommu/dma: implement
> >> DMA_ATTR_MMIO for dma_iova_link().") added DMA_ATTR_MMIO support to skip
> >> swiotlb bouncing and cache flushing for MMIO resources. However, both
> >> implementations placed the DMA_ATTR_MMIO check inside the swiotlb bounce block,
> >> causing non-page-aligned MMIO mappings to be rejected outright instead of
> >> skipping the bounce and proceeding to create the IOVA mapping.
> >> 
> >> This breaks dma_map_resource() for any non-page-aligned device register when
> >> behind an IOMMU: DMA controllers that map peripheral FIFO addresses
> >> (e.g. SPI controller TX/RX data registers) through an IOMMU for per-channel
> >> isolation.
> >> 
> >> Both patches move the DMA_ATTR_MMIO check before the swiotlb block so MMIO,
> >> resources skip the entire bounce path and fall through directly to the IOMMU
> >> mapping function.
> >
> >While I understand the rationale behind the first patch, why do we need the
> >second one? Do we want to allow unaligned addresses for the _link_ as well?
> >Current users don't need it.
> 
> My intention with the second patch was to make the DMA_ATTR_MMIO handling
> consistent with iommu_dma_map_phys(), since MMIO cannot be bounced by
> SWIOTLB in either case.
> 
> However, I don't have a dma_iova_link() user that requires an
> unaligned MMIO address, so no need to relax the existing restriction there.
>  
> I'll drop the second patch and keep this fix scoped to iommu_dma_map_phys()
> in v2. Does that sounds good to you?
> 
> BTW, does patch 1 look good to you?

Yes, for both questions.

Thanks

> 
> Thanks,
> Peng
> 
> >
> >Thanks
> >
> >> 
> >> Tested on NXP i.MX95 with ARM SMMUv3 where the fsl-edma DMA controller maps
> >> SPI peripheral FIFO registers (non-page-aligned) via dma_map_resource()
> >> through per-channel IOMMU domains. Only the iommu_dma_map_phys() path was
> >> exercised; the dma_iova_link() fix is by code inspection of the same pattern.
> >> 
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >> Peng Fan (2):
> >>       iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO in iommu_dma_map_phys
> >>       iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO in dma_iova_link()
> >> 
> >>  drivers/iommu/dma-iommu.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >> ---
> >> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
> >> change-id: 20260916-iommu-dma-fix-9f55af1beb46
> >> 
> >> Best regards,
> >> --  
> >> Peng Fan <peng.fan@nxp.com>
> >> 
> >> 
> >
> >
> 
