Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863591A9F82;
	Mon, 24 Nov 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004843; cv=none; b=cuEzaNyJydFvZ0OUCXVGLaKsL5QSGhzq0t8REG4Lz+zOuspr+MHTIpTVrnO0ZYVEEQtehdZGcIdwXaOlmk4yh/BnWbC+5fND90uazspAQDkk3nUt33zDfM0L2bJoOjW+1lTyVWRk0LiTIGIN8oGYpsY5TiOAVx/ptR5JRwcuBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004843; c=relaxed/simple;
	bh=KVmBQwO3HcCJjGK0uYYI6q8u5QGhw0qN4OMWm25Nifs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzwrrVSb1Png87UGzz+H9RzbCDfVD4vzKMImdNOj1v+4NoYDAJIHwGiod9EXWVnETSk7NyGTno3Gqp96YT05XeVG/dIm9ZWztss5V+K/2oBbKPrYT3Opkxcge92Vdyn3nGnshtJHfMWtycxlHOwpxYEcVJmCrhJWN+O2UwKDQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpLc9xJ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpLc9xJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97300C4CEF1;
	Mon, 24 Nov 2025 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764004843;
	bh=KVmBQwO3HcCJjGK0uYYI6q8u5QGhw0qN4OMWm25Nifs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpLc9xJ6EAYSHmz3Au8ki/YJpmTrUr6cABVn2jxjV2FLnx+7hZokEucvgo+XuBUBD
	 rEaSAQJuXnxD/s83ifUcvfq3Ps3G19uNDGq6/Jpm/WpIHvNWtXrYbLNkvIV9ppek3N
	 4jvpnN3Bww/vSGjq0r6VZNi3pfJjSoV/9WQw0zN9qiteHocYO/dxs3VGccYHGYOcz8
	 ZrqZF4Vq/AAHAPyEVYGC/s3TdodxMmfR9km1xMZPdD3/BrndeIyfwSXLBMfApH/G4G
	 Hwu4KGjh1YtpOW+OK7jaWFKfOOUJALyH6tKxeXvp0nz4ADZL1PjjhWh6jU9Cg9zcFy
	 AIzfWrjGTJKow==
Date: Mon, 24 Nov 2025 19:20:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/dma: add missing support for DMA_ATTR_MMIO for
 dma_iova_unlink()
Message-ID: <20251124172038.GD12483@unreal>
References: <CGME20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951@eucas1p2.samsung.com>
 <20251124170955.3884351-1-m.szyprowski@samsung.com>
 <0b214028-299b-46aa-8d98-0f789153c612@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b214028-299b-46aa-8d98-0f789153c612@arm.com>

On Mon, Nov 24, 2025 at 05:15:48PM +0000, Robin Murphy wrote:
> On 2025-11-24 5:09 pm, Marek Szyprowski wrote:
> > Commit c288d657dd51 added support for DMA_ATTR_MMIO attribute in the
> > dma_iova_link() code path, but missed that the CPU cache is being also
> > touched in the dma_iova_unlink() path. Fix this.
> > 
> > Fixes: c288d657dd51 ("iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().")
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index e52d19d2e833..c92088855450 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -2008,7 +2008,7 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
> >   			end - addr, iovad->granule - iova_start_pad);
> >   		if (!dev_is_dma_coherent(dev) &&
> > -		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> > +		    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
> >   			arch_sync_dma_for_cpu(phys, len, dir);
> >   		swiotlb_tbl_unmap_single(dev, phys, len, dir, attrs);
> > @@ -2032,7 +2032,8 @@ static void __iommu_dma_iova_unlink(struct device *dev,
> >   	size_t unmapped;
> >   	if ((state->__size & DMA_IOVA_USE_SWIOTLB) ||
> > -	    (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))
> > +	    (!dev_is_dma_coherent(dev) &&
> > +	     !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))))
> 
> This isn't needed, since there's no way an MMIO mapping could have used
> SWIOTLB.

This "if" is taken even for non-SWIOTLB path, because of "||" operator
in line above.

Thanks

> 
> Thanks,
> Robin.
> 
> >   		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
> >   	iommu_iotlb_gather_init(&iotlb_gather);
> 
