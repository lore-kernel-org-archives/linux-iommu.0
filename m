Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794770427;
	b=K+MvwBMi4zZBWyc7PJsEj5BvM7jZhGJ8RP45k7FWSiiOiQMzD225gwbm9bK8lADI067H
	 SWbcsDk0i8hxj7dJmYr4sAXQw7RRDOwzMVVdW3YwLITfe1lAJZ/zbtu9jwPXGBzEMmyxF
	 tekdWDOYoT3wmv+TCnR7gGm7slM/FKsqXwnY92ssxvdnvsvDQge1mbNZbsMFPY2ShSSjv
	 LUvavCBOKSQBUAqlyJOVzsS851Mm5MdELoQAf5dc12OVzLJmgkhCFlDRSJvhtf+WI7GT5
	 opbDAqANsAPipzfapneiihcNgeMY8yA4C2im/MN0y/OyQ/1lsceE/fBAMvgRuLqLsJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770427;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fLaQUPcYKxXkir2twg3fsW7g9Gg8lBOZ22Z32cylxH0=;
	b=XqPQYNQwW5ujlNjS2GQGwL/zp3KvvvpktpWgYp90h7PiqlF5JeIjcviyta3CW4d/AGIF
	 m428aUS4eUHkB5JnCzEFdPpciEWh+iNly5Awz8lftvDslPYkdxQJABnDTL7C4xzbb0sMm
	 i9ak7oLL8vwj81IFaN7knkxyDGlt08hDjVBolDb80MEyExxSV9Ya/6aQCs35EGYrCw9sH
	 vsz9v3CO87bThzEgS5/m3c3OEif1E13RrtzkZuALtGXOciQzHypmMdBZmAxsaA32OAJo0
	 IHc6lcb7raA06N/eTvuPLI8XgfJwJGa+EhDXfokXeWw8eBFllgUawZ9mn+W7bKFqpog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhLu85Ua;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E5606A32C;
	Sun, 15 Nov 2026 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhLu85Ua
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC921F000C4;
	Sun, 15 Nov 2026 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794770427;
	bh=fLaQUPcYKxXkir2twg3fsW7g9Gg8lBOZ22Z32cylxH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XhLu85Ua2c6WZLlLlAlu41R/VyenJMuIzs9+HeEnHjow/dZUNr5fsUxv33MVe0xR9
	 NiqKgGZojOd6z653AmlAbwBWSNz0Y/J4dsO9oqMstKyh/UAzeOwqo1F24tatjYGczh
	 Q0qBu2kvlSa0F8oIVuhxCAoOMhwI/hK6jFz/WnzR0a+3Y8LmbXpxRwMM+kxXmZY1iq
	 25w3eguzUz3kcvSwQsQNl1CFRImzluQwZPqKEdduaE+/HXoeSbYwThL2YZMJLNU1I0
	 E3zvrbGwhP652mJ1OL7CToELmOQZpBOaxBkQTr+i8KiSeA8Qj626ksqR9/Ha+aLwjb
	 //TVlKyt3smmQ==
Date: Sun, 15 Nov 2026 21:20:16 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
	m.szyprowski@samsung.com, jenswi@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mark.rutland@arm.com,
	robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com,
	sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org,
	thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] arm64: Add support for MEMBLOCK_PTEMAP
Message-ID: <avoF8IbOxVJ9Uh8Y@kernel.org>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-3-vdonnefort@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111110738.872947-3-vdonnefort@google.com>

On Wed, Nov 11, 2026 at 11:07:32AM +0000, Vincent Donnefort wrote:
> With the MEMBLOCK_PTEMAP flag, force a PTE-level mapping. This also

I'd expand this to "Force a PTE-level mapping for memblock regions with
MEMBLOCK_PTEMAP flag set".

> disables contiguous PTEs to make sure any page from the memblock can be

                                     and memblock region here ^

> safely unmapped from the linear map.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  arch/arm64/mm/mmu.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 140520b351e2..a4cafafa1d82 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1184,9 +1184,8 @@ static void __init map_mem(void)
>  	phys_addr_t init_begin = __pa_symbol(__init_begin);
>  	phys_addr_t init_end = __pa_symbol(__init_end);
>  	phys_addr_t kernel_end = __pa_symbol(__bss_stop);
> -	phys_addr_t start, end;
>  	int flags = NO_EXEC_MAPPINGS;
> -	u64 i;
> +	struct memblock_region *r;
>  
>  	/*
>  	 * Setting hierarchical PXNTable attributes on table entries covering
> @@ -1226,9 +1225,14 @@ static void __init map_mem(void)
>  		       flags);
>  
>  	/* map all the memory banks */
> -	for_each_mem_range(i, &start, &end) {
> +	for_each_mem_region(r) {
> +		phys_addr_t start, end;
> +		int rflags = flags;
> +
> +		if (memblock_is_nomap(r))
> +			continue;
>  		/*
> -		 * for_each_mem_range may return sub-page-aligned boundaries
> +		 * for_each_mem_region may return sub-page-aligned boundaries
>  		 * after memblock_mark_nomap() splits regions at byte precision.
>  		 * __create_pgd_mapping_locked aligns phys down to PAGE_MASK,
>  		 * which could accidentally map no-map memory on the boundary.
> @@ -1237,17 +1241,21 @@ static void __init map_mem(void)
>  		 * regions. The cost is at most one page of unmapped gap at
>  		 * each boundary.
>  		 */
> -		start = PAGE_ALIGN(start);
> -		end = end & PAGE_MASK;
> +		start = PAGE_ALIGN(r->base);
> +		end = (r->base + r->size) & PAGE_MASK;

Nit: as we anyway change the assignment to end, PAGE_ALIGN_DOWN() is
slightly more explicit.

>  		if (start >= end)
>  			continue;
> +
> +		if (memblock_is_ptemap(r))
> +			rflags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> +
>  		/*
>  		 * The linear map must allow allocation tags reading/writing
>  		 * if MTE is present. Otherwise, it has the same attributes as
>  		 * PAGE_KERNEL.
>  		 */
>  		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
> -			       flags);
> +			       rflags);
>  	}
>  }
>  
> -- 
> 2.56.0.542.g3ef89b7020-goog
> 

-- 
Sincerely yours,
Mike.
