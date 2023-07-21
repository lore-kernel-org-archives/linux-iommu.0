Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EF1F946
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 16:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50604C433AB;
	Fri, 21 Jul 2023 16:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689956477;
	bh=F6bDusVIkRQdT8rB0VHM/lnIzxF5wE08IHrmwLpQ7MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTD3jlKtptAtk6QuH0xo18U0VQcO3QM9TYL31eLsx55Y2SPmfO2Q3K/ItMVxkpP+I
	 9tSOkmwq9BaGnku33mHrKEoTnK+04KNgIY6fKWfcKylbD31WjTewCEWIQCuOfEgBqa
	 kGV0zpJ2zRwkPhpVvV5U6iWp43s1TDdxgalVHjhjnK+x2MSQ+N1cGIpz4Op1PvXXKy
	 xEwz2DL3joPqIynPCAm/vetFKvqBicG6ArbHgkKwp1uCI/yYaf9uF6pvIsgJzrm2gQ
	 kwq25CTcNNzztL9Jv5Yw8FQZUlnQjwwhxiFjEwWpptX/V0m5m5cU+cHQBQzQ9RaE7a
	 zqDwaPICmeipA==
Received: (nullmailer pid 1341419 invoked by uid 1000);
	Fri, 21 Jul 2023 16:21:14 -0000
Date: Fri, 21 Jul 2023 10:21:14 -0600
From: Rob Herring <robh@kernel.org>
To: Binglei Wang <l3b2w1@gmail.com>
Cc: frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] cma: check for memory region overlapping
Message-ID: <20230721162114.GA1321524-robh@kernel.org>
References: <20230720160729.39324-1-l3b2w1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720160729.39324-1-l3b2w1@gmail.com>

On Fri, Jul 21, 2023 at 12:07:29AM +0800, Binglei Wang wrote:
> From: Binglei Wang <l3b2w1@gmail.com>
> 
> Cma memory region editted carelessly in dts may overlap
> with kernel code/data memory region which is reserved by memblock
> during the early phase of system memory initialization.

Is your goal for the kernel to function with this careless editing or 
warn enough to fix the DT?

What if other regions overlap with the kernel? Wouldn't we have the same 
problem? 

> 
> Without checking overlap and cma area setup done,
> this region will be released to buddy system later.
> 
> When memory usage under pressure, memory allocated from
> this region will collide with kernel code which is read-only.
> And the following writing to this region will trigger the panic
> of writing to read-only memory.
> 
> So when rmem_cma_setup returns EBUSY, do not phys-free this region
> to memblock or else we end up with free the kernel code memory
> to buddy system.
> 
> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> ---
>  drivers/of/of_reserved_mem.c | 3 ---
>  kernel/dma/contiguous.c      | 5 +++++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 7ec94cfcb..d62cc76ef 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -338,9 +338,6 @@ void __init fdt_init_reserved_mem(void)
>  					rmem->name);
>  				if (nomap)
>  					memblock_clear_nomap(rmem->base, rmem->size);
> -				else
> -					memblock_phys_free(rmem->base,
> -							   rmem->size);

I don't understand this change. Seems like perhaps someone would want 
the free here?

>  			} else {
>  				phys_addr_t end = rmem->base + rmem->size - 1;
>  				bool reusable =
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 6ea80ae42..a349f3e97 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>  		return -EBUSY;

Here we return EBUSY if we are using cmdline params. In that case, isn't 
freeing the DT CMA area the right thing to do?


>  	}
>  
> +	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
> +		pr_info("Reserved memory: overlap with exsiting one\n");
> +		return -EBUSY;
> +	}
> +
>  	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
>  	    of_get_flat_dt_prop(node, "no-map", NULL))
>  		return -EINVAL;
> -- 
> 2.34.1
> 
