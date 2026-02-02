Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303C3563D4;
	Mon,  2 Feb 2026 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052407; cv=none; b=F71nrmZolFRfPViQevCAR0hlr2l2ym/jIjPGkgWbvuqT3at3Bl7LUANRHW8oO369V7WW1J2RJDCf42xzKC08S40NMGt9RUqrP3FJAbGXk8SJrwUeQTY11zH6FlVNmTjJOrxJOgqf6kuUg9ISP0c8yQK+uNip1AmwdCtRqKfiJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052407; c=relaxed/simple;
	bh=PnTeSEz/9pjprKiZcct6cCdCrR2nu+Q2US70gjU2hzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx9dkerPk0J3Bvf98CTGq/EXVfRCDIOmwRP/8JZYgf1yAFLfkWI029+NRuoOwyJPq9XcbAxdBFOKgVXyhjvB5x0WqMFp6KGZAS3+wXndX0RcU+unGKMBxpXDG0Fy7Knzpg1+e5RuuxOU4/D67tfVPnZnP1hCgvfoY9x3i66kuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efyVT4Mm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efyVT4Mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0331EC116C6;
	Mon,  2 Feb 2026 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770052406;
	bh=PnTeSEz/9pjprKiZcct6cCdCrR2nu+Q2US70gjU2hzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efyVT4MmoBoIf9WD108SCrIdqsSzieOnfwoWnz9AkYkccIfV9kRfDX6XRrXJJDc4t
	 Wewq/KwtZT9e7qlbh8DhLNDkjnpl1w9gd25yaIKGA3hHlZ2uE1aqgO61E8dF5lsahA
	 tU1CqY/UCbcCkm1D4mziGz5DMwAOMslDzFJYFCcZ8OX7QhqquhGD8S7k3UIBwQrC+o
	 CiOGI1Ur+L3pCmCw4J8Qr8hVMNGPt/ZjveCIL0v1CRGZYd1QiVPvfTym1Gi9TYIR1f
	 QL7u7T6u+hSHt26jPsMvc7pjztrUxXAtGl2WZ1XQHezG2yDL8uTjpV77q+2w0iLoVI
	 VHzSaufqcPAtQ==
Date: Mon, 2 Feb 2026 10:13:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYDbNC1z81D3lZ2r@kbusch-mbp>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>

On Mon, Feb 02, 2026 at 03:16:50PM +0000, Robin Murphy wrote:
> On 2026-02-02 2:35 pm, Christoph Hellwig wrote:
> > On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
> > > Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
> > > when SWIOTLB bounce buffering becomes active during runtime.
> > > 
> > > The issue occurs when SWIOTLB activation changes the device's DMA
> > > mapping requirements at runtime,
> > > 
> > > creating a mismatch between
> > > iod->dma_vecs allocation and access logic.
> > > 
> > > The problem manifests when:
> > > 1. Device initially operates with dma_skip_sync=true
> > >     (coherent DMA assumed)
> > > 2. First SWIOTLB mapping occurs due to DMA address limitations,
> > >     memory encryption, or IOMMU bounce buffering requirements
> > > 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
> > >     dma_skip_sync=false
> > > 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
> > >     iod->dma_vecs
> > 
> > I think this patch just papers over the bug.  If dma_need_unmap
> > can't be trusted before the dma_map_* call, we've not saved
> > the unmap information and the unmap won't work properly.
> 
> The dma_need_unmap() kerneldoc says:
> 
> "This function must be called after all mappings that might
>  need to be unmapped have been performed."
> 
> Trying to infer anything from it beforehand is definitely a bug in the
> caller.

Well that doesn't really make sense. No matter how many mappings the
driver has done, there will always be more. ?
