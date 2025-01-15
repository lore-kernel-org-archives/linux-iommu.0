Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDCD86350
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736969004; cv=none; b=YyjNRvL4V6TWIRsLujD0cfksqNQggoNlenTD712RDy5m0cMVB0nlnjyLzqZaJNDcLXg84NpUMt+mhQg/Tx4+Bx3wQCy8DYPrH+MX8GHm00zN04bWj2wz2gFjCbHMtqfnYu/erMQPTg/TnfMbRgARyVLeclVBKpWaGq82KnUPnA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736969004; c=relaxed/simple;
	bh=Z7FzG7euO3hIbdQNFj1nHxIy2rlVNwpenA4ZfXjYvE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFTh2w6m7XiCsrr5fSxlHZNvNLx+2/8crOqX0pLqdLNAnp7pLSmJZi/Vg86HlYEflUi234IQ/Ga9Vd9lTgQJ3mZickz9PTOjmIaBdSbnrf35bk14e//b1olbTfsFBR8vJYT40M2TYBlCRpD26ZqnaXIoQL9p+N6rHr4PbK+evwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0tuPbm5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0tuPbm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1069C4CED1;
	Wed, 15 Jan 2025 19:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736969003;
	bh=Z7FzG7euO3hIbdQNFj1nHxIy2rlVNwpenA4ZfXjYvE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0tuPbm50mrx79+1WCgTJFjB4tvHBp6kK98SGuoE725UqlsXLN/Bcfd2FbKCVe5fH
	 CpBgOgonMq2I981OT8FICRZAqs4GNTeQg/y+sRrA3NNRtu2AmRtej5t+HSAzMJbtsd
	 DEzYGvpOzzRFy8vnUtnJnv27aDd7kZ+PR5mi6e5xkZ9p/QBEtYteDh//ZZEc/s8ebf
	 2wQG9Zn782xszP80tMV+gX3ej8iA4Dp8EYU+58qHAuC3+CzB0Qktxv2ofw2Mq1YeUH
	 jQz/VkzuQZf+kakMskF7bmhjyqIwpOuKlfMof87d+8ricl6I9wS3VFlMebHviSGeF0
	 N/RoUeouBZwPg==
Date: Wed, 15 Jan 2025 21:23:19 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: hejiean@foxmail.com, jroedel@suse.de, mhklinux@outlook.com,
	petr@tesarici.cz, pasha.tatashin@soleen.com, nicolinc@nvidia.com,
	Christoph Hellwig <hch@lst.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] iommu-dma: Fix Oops on zero-sized DMA memory allocation
Message-ID: <20250115192319.GQ3146852@unreal>
References: <tencent_999F11E711AD93EA6AB3B8A7B32D1FE9AD0A@qq.com>
 <20250115123923.GN3146852@unreal>
 <c8a8fdf8-5de2-40ad-9da4-bb7a63ee8ea9@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a8fdf8-5de2-40ad-9da4-bb7a63ee8ea9@arm.com>

On Wed, Jan 15, 2025 at 02:32:07PM +0000, Robin Murphy wrote:
> [ BTW I apparently never received the original mail and don't see it on the
> list either... ]
> 
> On 2025-01-15 12:39 pm, Leon Romanovsky wrote:
> > On Wed, Jan 15, 2025 at 08:21:03PM +0800, hejiean@foxmail.com wrote:
> > > From: Jiean He <hejiean@foxmail.com>
> > > 
> > > In the `iommu_dma_ops.alloc` and `iommu_dma_ops.alloc_noncontiguous`
> > > interfaces, the `size` parameter is user-provided. When `size` is 0,
> > > an Oops occurs in `__iommu_dma_alloc_noncontiguous`, which is called
> > > by both interfaces.
> > > 
> > > The root cause lies in the fact that `__iommu_dma_alloc_noncontiguous`
> > > calls `kvcalloc`, The `count` parameter of `kvcalloc` is controlled by
> > > the user-provided `size`, and when `size` is 0, `count` is also 0.
> > > `__iommu_dma_alloc_noncontiguous` uses `if (!pages)` to check the
> > > return value of `kvcalloc`, but it returns `ZERO_SIZE_PTR` instead of
> > > `NULL` while `count==0`. This leads to a kernel Oops when `pages` is
> > > dereferenced in subsequent operations,as the following trace:
> > > 
> > > kernel NULL pointer dereference at virtual address 0000000000000010.
> > > Call trace:
> > > sg_alloc_append_table_from_pages+0x208/0x430
> 
> So... what you're saying is that there's a bug in
> sg_alloc_append_table_from_pages() where it can dereference more of "pages"
> than "n_pages" says is valid?
> 
> Of course that's not to say that's the *only* issue that this scenario could
> or would run into - indeed many allocation paths in various DMA API
> implementations depend on get_order(size), and the kerneldoc explicitly
> states that get_order(0) is undefined. So if you really think it's worth
> formally accommodating zero-sized DMA API requests, rather than leaving them
> as a nonsensical thing that drivers should obviously not do in the first
> place, then iommu-dma is still not the logically appropriate place to do
> that.

I got his dump stack now and it is a bug in his testing module where he
is getting size from users and passing to DMA API as is.

Thanks

> 
> Thanks,
> Robin.
> 
> > > sg_alloc_table_from_pages_segment+0x3c/0xa0
> > > __iommu_dma_alloc_noncontiguous.constprop.0+0x130/0x278
> > 
> > Who is this user?
> > grep sg_alloc_append_table_from_pages shows only 4 users:
> > drivers/infiniband/core/umem.c
> > drivers/vfio/pci/mlx5/cmd.c
> > drivers/vfio/pci/virtio/migrate.c
> > lib/scatterlist.c
> > 
> > First 3 users have constant size and it is not 0.
> > The latter is used in wrapper sg_alloc_table_from_pages_segment(), which
> > is used by DRM and that layer already was supposed to catch nr_pages == 0.
> > 
> > Thanks
> > 
> > > 
> > > This commit addresses the issue by adding a check for the `size`
> > > parameter in `__iommu_dma_alloc_noncontiguous`. If 0 is passed as `size`,
> > > a warning is reported and `NULL` is returned. This approach clearly
> > > indicates that the user-provided size might be illegal, helping users
> > > adjust their programs. In contrast, using `ZERO_OR_NULL_PTR` to check the
> > > return value of `kmalloc` (used by `kvcalloc` internally) does not
> > > distinguish between insufficient memory and a zero-sized memory request.
> > > 
> > > Fixes: 0db2e5d18f76 ("iommu: Implement common IOMMU ops for DMA mapping")
> > > 
> > > Signed-off-by: Jiean He <hejiean@foxmail.com>
> > > ---
> > >   drivers/iommu/dma-iommu.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > index 2a9fa0c8cc00..3c9c905e7a8f 100644
> > > --- a/drivers/iommu/dma-iommu.c
> > > +++ b/drivers/iommu/dma-iommu.c
> > > @@ -956,6 +956,11 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
> > >   	    iommu_deferred_attach(dev, domain))
> > >   		return NULL;
> > > +	if (unlikely(size == 0)) {
> > > +		dev_err(dev, "DMA alloc Zero-Sized memory is unsupported\n");
> > > +		return NULL;
> > > +	}
> > > +
> > >   	min_size = alloc_sizes & -alloc_sizes;
> > >   	if (min_size < PAGE_SIZE) {
> > >   		min_size = PAGE_SIZE;
> > > -- 
> > > 2.40.0.windows.1
> > > 
> 
