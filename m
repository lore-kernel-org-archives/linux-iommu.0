Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6626125;
	Thu,  8 May 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717710; cv=none; b=cvwgKOpq+fXV+chCh6ijid3ky+N85GvDvvrt5Os2VjNIZHidF5AcB6S5bkLDuUgAoR++85eGExpLsFmLA/SbhMVu3/+tfGC6n5Rom8skR3CRR1UcJ904poOgxNZbNg70SQP7Bd3WgCW9lwUulc7wSZd0Fb0xEquR64dkPvjzywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717710; c=relaxed/simple;
	bh=q/TDJBwEVbrcelLCE627ULHjq3znl/iiudThmhNqqoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf8w33i0iQCB92sciVDwCWRz7rQ0XDAV7YQ9uAdjtva/bBZua2Nz+UdpbCy/z54cWyIycAOhQ+Y+OcPrGpb+yXgkscm7zTMmpv7DRh+NGOjV02A0fSzERjron1O6MBUt5FJjHLUp5Tw+ocm+i8g9wuojkSNyNULTR18OAbcU3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F907C4CEE7;
	Thu,  8 May 2025 15:21:47 +0000 (UTC)
Date: Thu, 8 May 2025 16:21:45 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: John Ernberg <john.ernberg@actia.se>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH 1/2] xen: swiotlb: Use swiotlb bouncing if kmalloc
 allocation demands it
Message-ID: <aBzMCWmTMzLNuvmJ@arm.com>
References: <20250502114043.1968976-1-john.ernberg@actia.se>
 <20250502114043.1968976-2-john.ernberg@actia.se>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502114043.1968976-2-john.ernberg@actia.se>

On Fri, May 02, 2025 at 11:40:55AM +0000, John Ernberg wrote:
> Xen swiotlb support was missed when the patch set starting with
> 4ab5f8ec7d71 ("mm/slab: decouple ARCH_KMALLOC_MINALIGN from
> ARCH_DMA_MINALIGN") was merged.
> 
> When running Xen on iMX8QXP, a SoC without IOMMU, the effect was that USB
> transfers ended up corrupted when there was more than one URB inflight at
> the same time.
> 
> Add a call to dma_kmalloc_needs_bounce() to make sure that allocations too
> small for DMA get bounced via swiotlb.
> 
> Closes: https://lore.kernel.org/linux-usb/ab2776f0-b838-4cf6-a12a-c208eb6aad59@actia.se/
> Fixes: 4ab5f8ec7d71 ("mm/slab: decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN")
> Cc: stable@kernel.org # v6.5+
> Signed-off-by: John Ernberg <john.ernberg@actia.se>
> 
> ---
> 
> It's impossible to pick an exact fixes tag since this driver was missed
> in the flagged patch set. I picked one I felt gave a decent enough picture
> for someone coming across this later.

All the above patches went in at the same time in 6.5, so it probably
doesn't matter. In theory, you could add:

Fixes: 370645f41e6e ("dma-mapping: force bouncing if the kmalloc() size is not cache-line-aligned")
Cc: <stable@vger.kernel.org> # 6.5.x

as that's when dma_kmalloc_needs_bounce() was added (a few commits after
the "decouple ARCH_KMALLOC_MINALIGN..." one). However, actual problems
started to appear with commit 9382bc44b5f5 ("arm64: allow kmalloc()
caches aligned to the smaller cache_line_size()") which makes
ARCH_KMALLOC_MINALIGN equal 8 on arm64.

> ---
>  drivers/xen/swiotlb-xen.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 1f65795cf5d7..ef56a2500ed6 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -217,6 +217,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	 * buffering it.
>  	 */
>  	if (dma_capable(dev, dev_addr, size, true) &&
> +	    !dma_kmalloc_needs_bounce(dev, size, dir) &&
>  	    !range_straddles_page_boundary(phys, size) &&
>  		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
>  		!is_swiotlb_force_bounce(dev))

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
