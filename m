Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F78322B69;
	Wed, 14 Jan 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384059; cv=none; b=F3/dESSeGVO+biKzBT2m9dptvNeCJIIBIRU0AByGW3g91kZucsROu9tF4GiBZL6MsJrOtsIXVhDj2tVAkRqrEu7INUigwJHNe/bX7lq6EuqGncxMcdHJ00vIhxERES5/S3RJESH7//53XVcq8VCfjcBaHL2cSRUOZagPj9nZ3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384059; c=relaxed/simple;
	bh=aRlmNNFI1G80fHjr36r3pKS7bMyLXKWQwSCrTBwklTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JLrK7dEnVpQh7xLUjEMeUyEdZX/HIpBcxqZ3uxirY1MEeO8+ncMCiTfB4Lt4GupzltbVrJqMnOyLaZOS3ZC5xSr6eznSvxbg/qXlzKfUGx0ZS4p19eg7OsOepXD4bx5WgNnbXjjgB8nNrVAC29AWLR+FlT1NzhTiqGkqtCfV+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtepia5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtepia5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398B6C4CEF7;
	Wed, 14 Jan 2026 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768384058;
	bh=aRlmNNFI1G80fHjr36r3pKS7bMyLXKWQwSCrTBwklTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Vtepia5bRmrBGmz7PJX90xOqpf682xxoPI+ZykuInMnETZwe4QPdQ4A6J4NalTJJ0
	 iuVIe5tGKf0+VdnR/SJ8daPl4FEd6zcgpl7MscvFPaA5v8CPbXK4qghAnTMr1VACvt
	 CdwDmqrG5VBARzc//Eo7h72VxMRdtiCz3FIvkb3ZhYzzz6bwyFlrD36B6ypTf5QzJ9
	 MbdsaZ5BBd1XzPNP3lQs/Sl96B59ljXmHm33m0MO095zwirwq49XwwbqJuLzg8jDO3
	 q4DstIDuUKPP1L5Lms91m3CbWvga+lTemmzeof6WYs4hCKDilgM/76dyYmcBXHEA7V
	 MPeFlAcw0EEeg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2] dma-direct: set decrypted flag for remapped DMA
 allocations
In-Reply-To: <20260102155037.2551524-1-aneesh.kumar@kernel.org>
References: <20260102155037.2551524-1-aneesh.kumar@kernel.org>
Date: Wed, 14 Jan 2026 15:17:32 +0530
Message-ID: <yq5ao6mwcyq3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> Devices that are DMA non-coherent and require a remap were skipping
> dma_set_decrypted(), leaving DMA buffers encrypted even when the device
> requires unencrypted access. Move the call after the if (remap) branch
> so that both the direct and remapped allocation paths correctly mark the
> allocation as decrypted (or fail cleanly) before use.
>
> Architectures such as arm64 cannot mark vmap addresses as decrypted, and
> highmem pages necessarily require a vmap remap. As a result, such
> allocations cannot be safely used for unencrypted DMA. Therefore, when
> an unencrypted DMA buffer is requested, avoid allocating high PFNs from
> __dma_direct_alloc_pages().
>
> Other architectures (e.g. x86) do not have this limitation. However,
> rather than making this architecture-specific, apply the restriction
> only when the device requires unencrypted DMA access, for simplicity.
>

Considering that we don=E2=80=99t expect to use HighMem on systems that sup=
port
memory encryption or Confidential Compute, should we go ahead and merge
this change so that the behavior is technically correct? We can address
the separate question of whether DMA allocations should ever return
HighMem independently.


>
> Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_di=
rect_alloc")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ffa267020a1e..faf1e41afde8 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -204,6 +204,7 @@ void *dma_direct_alloc(struct device *dev, size_t siz=
e,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap =3D false, set_uncached =3D false;
> +	bool allow_highmem =3D true;
>  	struct page *page;
>  	void *ret;
>=20=20
> @@ -250,8 +251,18 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>  	    dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>=20=20
> +
> +	if (force_dma_unencrypted(dev))
> +		/*
> +		 * Unencrypted/shared DMA requires a linear-mapped buffer
> +		 * address to look up the PFN and set architecture-required PFN
> +		 * attributes. This is not possible with HighMem. Avoid HighMem
> +		 * allocation.
> +		 */
> +		allow_highmem =3D false;
> +
>  	/* we always manually zero the memory once we are done */
> -	page =3D __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> +	page =3D __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_h=
ighmem);
>  	if (!page)
>  		return NULL;
>=20=20
> @@ -282,7 +293,13 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>  			goto out_free_pages;
>  	} else {
>  		ret =3D page_address(page);
> -		if (dma_set_decrypted(dev, ret, size))
> +	}
> +
> +	if (force_dma_unencrypted(dev)) {
> +		void *lm_addr;
> +
> +		lm_addr =3D page_address(page);
> +		if (set_memory_decrypted((unsigned long)lm_addr, PFN_UP(size)))
>  			goto out_leak_pages;
>  	}
>=20=20
> @@ -344,8 +361,16 @@ void dma_direct_free(struct device *dev, size_t size,
>  	} else {
>  		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
>  			arch_dma_clear_uncached(cpu_addr, size);
> -		if (dma_set_encrypted(dev, cpu_addr, size))
> +	}
> +
> +	if (force_dma_unencrypted(dev)) {
> +		void *lm_addr;
> +
> +		lm_addr =3D phys_to_virt(dma_to_phys(dev, dma_addr));
> +		if (set_memory_encrypted((unsigned long)lm_addr, PFN_UP(size))) {
> +			pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n"=
);
>  			return;
> +		}
>  	}
>=20=20
>  	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
> --=20
> 2.43.0

-aneesh
