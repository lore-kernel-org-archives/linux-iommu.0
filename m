Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B7312832;
	Wed,  1 Jul 2026 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932912; cv=none; b=QDVBVX9dg30OeSZfyvDxydOagho6CwGAs9MZ3l3HnZsCF6zsSJuzCnww0SC2tCOTDbV89rhmUbinBAs6nowGRWQyLztaorYHrrSaO0tzfLAirwdSh53wraLHBb9JgH0q++/knq1rrX7GoEmGA1KWhLAz/6iB5BJ+G+8BY9Tt0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932912; c=relaxed/simple;
	bh=l7PjmlV5EpEanoZuzDlc0PCd09kcAfRVBJJdxOCR1xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtAEdMmJ+dH/ehCZbY/bHjEAr2R9m3k0swWKn8ojfjbJE2zJA2Nul0/wRuJOCoq2A1Iy+940Si0IeMV72oEFSfEOJRJC24srkQX95BmpTEvd25dsrROKz86wVVFAeXzE6GUs3eL25MJnBrrAwLl86OCNIzPphHjSNpiJqhxCr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6E57KNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6E57KNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664321F000E9;
	Wed,  1 Jul 2026 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782932910;
	bh=dc1CeQBFIQHAXxM7F2Ou5lNeVfNns5g9XW5K3IZINE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F6E57KNJu7JApeNLPEsZ6rMCddbnLRsoPxqFkae/X7+ldXKYTOLSGLCDjKyyNwhQ3
	 k0F+iVYlJZTpzXQrpq+GsuCuuh+2PdKnYce3iYc0iUq/esoNAW5sey4noSQ254jvYZ
	 rPoH/CLLGJ4w8Yfsen7w22G++rfxw+6XgeRJyE3dMuwdYe2pG/Rv+AnqOS5E3dYTwd
	 jPvuNjWZGxUODlNjs/1JbmtVXWprF2xuRN7ykrKSO4TTUTS/6gwhqzMqqKxQuumD6n
	 j4+jakvSuAYOJLfeUmHhsSwCqmB+6l1OkAikHB9E6dk7IW42pQh5/IjjK30ZXDq0gL
	 HxkMe9d6loJWA==
Date: Wed, 1 Jul 2026 22:08:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Honglei Huang <honghuan@amd.com>, joro@8bytes.org, will@kernel.org,
	m.szyprowski@samsung.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ray.Huang@amd.com
Subject: Re: [PATCH] iommu/dma: free the entire IOVA reservation in
 dma_iova_destroy()
Message-ID: <20260701190823.GC65299@unreal>
References: <20260701092033.422867-1-honghuan@amd.com>
 <820112f0-4361-496f-ba84-557746c75601@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820112f0-4361-496f-ba84-557746c75601@arm.com>

On Wed, Jul 01, 2026 at 01:36:00PM +0100, Robin Murphy wrote:
> On 01/07/2026 10:20 am, Honglei Huang wrote:
> > dma_iova_try_alloc() reserves IOVA for the whole requested size and
> > records it in state->__size, but callers may subsequently link only a
> > part of that reservation, for example the drm_gpusvm mixed range case,
> > where a device page range is linked incrementally.
> > 
> > The doc for dma_iova_destroy() is:
> > 
> >    "Unlink the IOVA range up to @mapped_len and free the entire IOVA
> >     space."
> > 
> > However __iommu_dma_iova_unlink() computed the amount of IOVA to free
> > from @mapped_len rather than from the full reservation. When the
> > reservation is larger than the linked length, the tail
> > [mapped_len, reserved size] is never returned to the allocator and
> > is leaked, contrary to the documented contract.
> 
> That's not what really happens in practice though - note that free_iova()
> doesn't even take a size, only a pfn with which to look up the corresponding
> rbtree entry. At worst, for sizes small enough for the rcaches, a larger
> IOVA may be put in a cache for a smaller size, which although wasteful, is
> otherwise pretty much benign.
> 
> This isn't to say that the allocator behaviour might not eventually change
> in future, but for now I can only assume that dma_iova_destroy() doing this
> is intentional, because I pointed it out at least 3 times over the course of
> the original review from RFC to eventual merge, and Leon made a point of
> refusing to do anything about it :/

I found only one sentence that was somewhat unclear in this
context. Are you referring to it?
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
https://lore.kernel.org/all/?q=dma_iova_destroy+robin+romanovsky
https://lore.kernel.org/all/ad2312e0-10d5-467a-be5e-75e80805b311@arm.com/
> +	if (free_iova)
> +		iommu_dma_free_iova(cookie, addr, size, &iotlb_gather);

Case in point, can you spot the bug here if dma_iova_destroy() is used
as intended? At least it's the relatively benign direction of this bug,
not the really fun pagetable corruption one.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Regarding the fix, I think it is the correct one. I intended to free
all space previously allocated by iommu_dma_alloc_iova(), not just
"mapped_len", as I wrote at the end.

Thanks
