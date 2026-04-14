Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D233B52EB;
	Tue, 14 Apr 2026 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159084; cv=none; b=Z+AGJ567c6D9CVp3LF2Xy1bzvBfdaKrtpSSWsGFFg7K/j6LYDAcOPRPxUxc7WgLboP7jPlplwKFGOB0oSbRhA0kGwuvWWNmcIOpw7i2n+SFvdVhxazcjoZ0/8tjNgqISZZJciOh8PIm47XvUSJl03SKSePmGBNPykhA6NEjHghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159084; c=relaxed/simple;
	bh=S5kCVM9mkH4CZXqZjMXOKYWBhfMWrO8FugQMskKXogQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LgIkm3l5am7RHD6ujy8UmHOkrYtk2MywhXQ6JHhIojyiw0DX8F5WQOBBtsU9+a9gec/Gd3z4usJo7BGINztIrHJRxr4jL2YkxwxY7sQj1CG/VHckHiMGVuOJXQ2jS1f0iab0vtnY263DgnnBtEDmXEwQ7CgzYBpT9VC0EAvRRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RejhiGtB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RejhiGtB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3E4C19425;
	Tue, 14 Apr 2026 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776159083;
	bh=S5kCVM9mkH4CZXqZjMXOKYWBhfMWrO8FugQMskKXogQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RejhiGtBj0kZvA1Vp/f9F2DPaxxwMEEVK7jglF+fMjQli3C3nOMODk3F74W940onv
	 OS4osacqO/psvTXEFayvPPwaNyUnpQfLI7qdhalRo59qPKHolU8WIVs0+ihkpoJbxF
	 9OXYeMttMpq60RnwCG2IafEqkdpQwQoACN6zEtN+rUboy1mU2+l8oZCXy870rqHZMY
	 mkSzXIsQ4+k49Tvv3Mk3EiSdfgvQ8qni/3r2a/Ei1Cc28tzF0FtyxCH84IR3ybqQo6
	 Ykdg1H35XPTiyRPngTTjG4q01Ve0/1PT9qjLZRmkqbt8X7NNGNl5ikSM0s7bmUEARa
	 V29FS1I68MQaw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH v3 3/5] dma-mapping: Decrypt memory on remap
In-Reply-To: <20260408194750.2280873-4-smostafa@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-4-smostafa@google.com>
Date: Tue, 14 Apr 2026 15:01:15 +0530
Message-ID: <yq5atstdanx8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> In case memory needs to be remapped on systems with
> force_dma_unencrypted(), where this memory is not allocated
> from a restricted-dma pool, this was currently ignored, while only
> setting the decrypted pgprot in the remapped alias.
>
> The memory still needs to be decrypted in that case.
>

For ARM CCA, we cannot mark a vmap address as decrypted. I don=E2=80=99t ex=
pect
non-coherent DMA devices to be used in an ARM CCA configuration, but we
may need a way to document this in the code.

>
> With memory decryption, don't allow highmem allocations, but that
> shouldn't be a problem on such modern systems.
>
> Also, move force_dma_unencrypted() outside of dma_set_* to make it
> clear to be able to use more generic logic to decided memory
> state.
>
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_di=
rect_alloc")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  kernel/dma/direct.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ce74f213ec40..de63e0449700 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -79,8 +79,6 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t ph=
ys, size_t size)
>=20=20
>  static int dma_set_decrypted(struct device *dev, void *vaddr, size_t siz=
e)
>  {
> -	if (!force_dma_unencrypted(dev))
> -		return 0;
>  	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
>  }
>=20=20
> @@ -88,8 +86,6 @@ static int dma_set_encrypted(struct device *dev, void *=
vaddr, size_t size)
>  {
>  	int ret;
>=20=20
> -	if (!force_dma_unencrypted(dev))
> -		return 0;
>  	ret =3D set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
>  	if (ret)
>  		pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
> @@ -206,7 +202,7 @@ static void *dma_direct_alloc_no_mapping(struct devic=
e *dev, size_t size,
>  void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
> -	bool remap =3D false, set_uncached =3D false, encrypt =3D false;
> +	bool remap =3D false, set_uncached =3D false, decrypt =3D force_dma_une=
ncrypted(dev);
>  	struct page *page;
>  	void *ret;
>=20=20
> @@ -215,7 +211,7 @@ void *dma_direct_alloc(struct device *dev, size_t siz=
e,
>  		gfp |=3D __GFP_NOWARN;
>=20=20
>  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
> +	    !decrypt && !is_swiotlb_for_alloc(dev))
>  		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>=20=20
>  	if (!dev_is_dma_coherent(dev)) {
> @@ -249,12 +245,15 @@ void *dma_direct_alloc(struct device *dev, size_t s=
ize,
>  	 * Remapping or decrypting memory may block, allocate the memory from
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
> -	if ((remap || force_dma_unencrypted(dev)) &&
> +	if ((remap || decrypt) &&
>  	    dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>=20=20
> -	/* we always manually zero the memory once we are done */
> -	page =3D __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> +	/*
> +	 * we always manually zero the memory once we are done, and only allow
> +	 * high mem if pages doesn't need decryption.
> +	 */
> +	page =3D __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, !decryp=
t);
>  	if (!page)
>  		return NULL;
>=20=20
> @@ -268,10 +267,12 @@ void *dma_direct_alloc(struct device *dev, size_t s=
ize,
>  		set_uncached =3D false;
>  	}
>=20=20
> +	if (decrypt && dma_set_decrypted(dev, page_address(page), size))
> +		goto out_leak_pages;
>  	if (remap) {
>  		pgprot_t prot =3D dma_pgprot(dev, PAGE_KERNEL, attrs);
>=20=20
> -		if (force_dma_unencrypted(dev))
> +		if (decrypt)
>  			prot =3D pgprot_decrypted(prot);
>=20=20
>  		/* remove any dirty cache lines on the kernel alias */
> @@ -281,11 +282,9 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>  		ret =3D dma_common_contiguous_remap(page, size, prot,
>  				__builtin_return_address(0));
>  		if (!ret)
> -			goto out_free_pages;
> +			goto out_encrypt_pages;
>  	} else {
>  		ret =3D page_address(page);
> -		if (dma_set_decrypted(dev, ret, size))
> -			goto out_leak_pages;
>  	}
>=20=20
>  	memset(ret, 0, size);
> @@ -301,9 +300,7 @@ void *dma_direct_alloc(struct device *dev, size_t siz=
e,
>  	return ret;
>=20=20
>  out_encrypt_pages:
> -	encrypt =3D true;
> -out_free_pages:
> -	__dma_direct_free_pages(dev, page, size, encrypt);
> +	__dma_direct_free_pages(dev, page, size, decrypt);
>  	return NULL;
>  out_leak_pages:
>  	return NULL;
> @@ -366,7 +363,7 @@ struct page *dma_direct_alloc_pages(struct device *de=
v, size_t size,
>  		return NULL;
>=20=20
>  	ret =3D page_address(page);
> -	if (dma_set_decrypted(dev, ret, size))
> +	if (force_dma_unencrypted(dev) && dma_set_decrypted(dev, ret, size))
>  		goto out_leak_pages;
>  	memset(ret, 0, size);
>  	*dma_handle =3D phys_to_dma_direct(dev, page_to_phys(page));
> --=20
> 2.53.0.1213.gd9a14994de-goog
