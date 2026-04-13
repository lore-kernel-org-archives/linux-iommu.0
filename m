Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA42391E49;
	Mon, 13 Apr 2026 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776061426; cv=none; b=YYZ52Ig4VE4dKhrDjSdMpGIsHKyIFPVO1JmoSVQqmEGUjMcckbvWVK/UtektGUwYcrhriW6fqZWZ+JiJB/R4WaZm+CKaJpfOQO5Cc749N8hMPXws8/c9xu0nbc24vhQBU714e0bZzYZzR/McQ4epVr5nb0kg/guwJ5lCATE2bCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776061426; c=relaxed/simple;
	bh=S6ATimXqg5yeVevWhdnRGLX2JArucS8KTVTKX3M+VHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IFe4idibd60JQIPQX5kwDvuBPil3rswEJirQhGA1emOPlqWKrSDDjmmugfq9pTVc4DpnYaCuwkX/jXpoH+fCzNm00phYZXiA2fSn+I33BwzdFvnLcD+0bM8DAz3hoNXidz5QE5Q7rmzlCVQx0swr9XgjdM+uWr47EB8qdc+jVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT1XVANJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT1XVANJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E055BC116C6;
	Mon, 13 Apr 2026 06:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776061426;
	bh=S6ATimXqg5yeVevWhdnRGLX2JArucS8KTVTKX3M+VHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WT1XVANJm5ELlaBgRmLZzy4zlnNUlHXUkFlEwipZaUBgINvaX1llWf8OO6kFs3b2e
	 EFGmjs8ZLc1REnyY5wYSdv/4jXJ/hmN6/LKmaxCr1hmkGW8PJIMpuKNA0Wr9xoMD6C
	 HbKOKpcprUPhyydlt2kYCYj8VODg1wgnv5vZQf+/0JXWtPkmIHCjE+tf7KUtsAi+mV
	 guIbML8LDtOT2pIJ6c0As7TcF+EgKydqXC707LNVITrNDeUMyLm7TWze921AdY/gKp
	 mVmtvNZUytH7Cb/EnYyVCwmP+unYGNducSZMIaxMMQCxPTEq/q7sgIY+vfn2d2ypz1
	 FGjYHyaoUylZA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH v2 3/5] dma-mapping: Decrypt memory on remap
In-Reply-To: <20260330145043.1586623-4-smostafa@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-4-smostafa@google.com>
Date: Mon, 13 Apr 2026 11:53:39 +0530
Message-ID: <yq5a8qarbcpg.fsf@kernel.org>
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
> With memory decryption, don't allow highmem allocations, but that
> shouldn't be a problem on such modern systems.
>
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_di=
rect_alloc")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  kernel/dma/direct.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 1a402bb956d9..a4260689bcc8 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -203,6 +203,7 @@ static void *dma_direct_alloc_no_mapping(struct devic=
e *dev, size_t size,
>  void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
> +	bool allow_highmem =3D !force_dma_unencrypted(dev);
>  	bool remap =3D false, set_uncached =3D false;
>  	struct page *page;
>  	void *ret;
> @@ -251,7 +252,7 @@ void *dma_direct_alloc(struct device *dev, size_t siz=
e,
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>=20=20
>  	/* we always manually zero the memory once we are done */
> -	page =3D __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> +	page =3D __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_h=
ighmem);
>  	if (!page)
>  		return NULL;
>=20=20
> @@ -265,6 +266,9 @@ void *dma_direct_alloc(struct device *dev, size_t siz=
e,
>  		set_uncached =3D false;
>  	}
>=20=20
> +	if (dma_set_decrypted(dev, page_address(page), size))
> +		goto out_leak_pages;
> +
>  	if (remap) {
>  		pgprot_t prot =3D dma_pgprot(dev, PAGE_KERNEL, attrs);
>=20=20
> @@ -278,11 +282,9 @@ void *dma_direct_alloc(struct device *dev, size_t si=
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
> @@ -300,7 +302,6 @@ void *dma_direct_alloc(struct device *dev, size_t siz=
e,
>  out_encrypt_pages:
>  	if (dma_set_encrypted(dev, page_address(page), size))
>  		return NULL;
> -out_free_pages:
>  	__dma_direct_free_pages(dev, page, size);
>  	return NULL;
>  out_leak_pages:
> @@ -339,7 +340,12 @@ void dma_direct_free(struct device *dev, size_t size,
>  		return;
>=20=20
>  	if (is_vmalloc_addr(cpu_addr)) {
> +		void *vaddr =3D page_address(dma_direct_to_page(dev, dma_addr));
> +
>  		vunmap(cpu_addr);
> +
> +		if (dma_set_encrypted(dev, vaddr, size))
> +			return;


Right now, a remap is required under two conditions:

1. HighMem =E2=80=94 I assume we are avoiding this for devices that require=
 memory decryption.
2. The device is not DMA-coherent.

Can we assume that condition (2) will also not be supported alongside
memory encryption/decryption? That would allow us to simplify all of
this. We would then only need to carry the patch that disables HighMem
for devices requiring unencrypted DMA buffers.

I did post a patch along similar lines some time back. There is also the
challenge of presenting a vmap address as decrypted on ARM.
https://lore.kernel.org/all/20260102155037.2551524-1-aneesh.kumar@kernel.org


>  	} else {
>  		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
>  			arch_dma_clear_uncached(cpu_addr, size);
> --=20
> 2.53.0.1185.g05d4b7b318-goog
