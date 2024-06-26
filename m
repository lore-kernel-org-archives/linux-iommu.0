Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FF185E52;
	Wed, 26 Jun 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414264; cv=none; b=idEUqSwafOXFuF2ai6s6dfB22iFwSBvZEV4VwHRsEuQXx/aQz4J+LV7RjMVzrn5nmcuxG7K54c5H/LrGGp7yxoHVwknr0dCA2nWj27UFCZWrZM4wXEU/JlrB14uuFj+WI7uO9rD7GoLSksv16IihicJa830jwLUm3QP1r/4jqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414264; c=relaxed/simple;
	bh=LvSjkiMtpfF+JoR7xWPevIfICzed4j3soaPcrthxPJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANfpTY8mJk5c51b6jAC93Hs5VI2UvnjcRFxEtJ6mPMiKaZP6wg9yHuYbLbVPlcSactb/a5O2xTqFZFYjq5kRHcOyZEPK5Vb1GHyG0ItTX+mETU+3OC1mglt6bkfuMg+hVmBz7JisauEdZ+eqqsEP+u4PXNjWVfLjceg0rEzASbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAvEfs+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAvEfs+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6D1C2BD10;
	Wed, 26 Jun 2024 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414264;
	bh=LvSjkiMtpfF+JoR7xWPevIfICzed4j3soaPcrthxPJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAvEfs+R8vToV4fGpUki2wtbg5kBVoLFrVZh15RJvRjs0XHv0NX1QXjYRE0PyhRGV
	 5frEpP7UXI1j35Cm/fjmi0EfY8itKiHVvMi5uWao4eibXg24+ClJIpdx1b8F0q/Xrv
	 sCnNoOxQUJvcvpX6WZwaKveGz5l+TynaBMXgiauYrAm+g4QWEVWdbksyW19B/TROdM
	 tD85klHfANxVNRdiwv5YMcS+g7FKS67VrCYNPsDXuW1FqZt58CZdJB5yWYlpMNJDSt
	 KRBMAoFpNQb8AvHNbvTIvEzQHw7CyDRT5uenKZi83/iFbEK5awnp7ydP2ltPFN8VZp
	 xTVenNqCkw21A==
Date: Wed, 26 Jun 2024 08:04:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: robh@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
	conor@kernel.org, devicetree@vger.kernel.org, hch@lst.de,
	iommu@lists.linux.dev, kernel@quicinc.com,
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
	oe-kbuild-all@lists.linux.dev, robin.murphy@arm.com,
	saravanak@google.com, will@kernel.org
Subject: Re: [PATCH v2] of: reserved_mem: Restructure code to call reserved
 mem init functions earlier
Message-ID: <20240626150421.GA3664@fedora-macbook-air-m2>
References: <202406181626.126X1Nbz-lkp@intel.com>
 <20240620001027.2326275-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620001027.2326275-1-quic_obabatun@quicinc.com>

On Wed, Jun 19, 2024 at 05:10:27PM -0700, Oreoluwa Babatunde wrote:
> After all the reserved memory regions have been added to the
> reserved_mem array, a region specific initialization function is called
> on each of reserved memory regions in a loop to initialize them.
> 
> With recent changes made to allow the reserved_mem array be dynamically
> allocated, the cma reserved memory regions are not initialized until
> after the page tables are setup. This causes the warning seen in the
> dump stack below:
> 
> 	WARNING: CPU: 0 PID: 1 at mm/memory.c:2789 __apply_to_page_range+0x360/0x380
> 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc1-00007-ga46cccb0ee2d #1
> 	Hardware name: Generic DT based system
> 	Call trace:
> 	unwind_backtrace from show_stack+0x18/0x1c
> 	show_stack from dump_stack_lvl+0x54/0x68
> 	dump_stack_lvl from __warn+0x74/0x114
> 	__warn from warn_slowpath_fmt+0x13c/0x1c0
> 	warn_slowpath_fmt from __apply_to_page_range+0x360/0x380
> 	__apply_to_page_range from apply_to_page_range+0x24/0x2c
> 	apply_to_page_range from __alloc_from_contiguous+0xc4/0x158
> 	__alloc_from_contiguous from cma_allocator_alloc+0x3c/0x44
> 	cma_allocator_alloc from arch_dma_alloc+0x128/0x2b4
> 	arch_dma_alloc from dma_alloc_attrs+0x90/0x150
> 	dma_alloc_attrs from drm_gem_dma_create+0xa4/0x13c
> 	drm_gem_dma_create from drm_gem_dma_create_with_handle+0x24/0xac
> 	drm_gem_dma_create_with_handle from drm_gem_dma_dumb_create+0x44/0x50
> 	drm_gem_dma_dumb_create from drm_client_framebuffer_create+0x9c/0x164
> 	drm_client_framebuffer_create from drm_fbdev_dma_helper_fb_probe+0x84/0x23c
> 	drm_fbdev_dma_helper_fb_probe from __drm_fb_helper_initial_config_and_unlock+0x2e4/0x4f8
> 	__drm_fb_helper_initial_config_and_unlock from drm_fbdev_dma_client_hotplug+0x74/0xb8
> 	drm_fbdev_dma_client_hotplug from drm_client_register+0x5c/0x98
> 	drm_client_register from aspeed_gfx_probe+0x278/0x3c0
> 	aspeed_gfx_probe from platform_probe+0x60/0xb8
> 	platform_probe from really_probe+0xd4/0x3b4
> 	really_probe from __driver_probe_device+0x90/0x1dc
> 	__driver_probe_device from driver_probe_device+0x38/0xd0
> 	driver_probe_device from __driver_attach+0x118/0x1dc
> 	__driver_attach from bus_for_each_dev+0x84/0xd4
> 	bus_for_each_dev from bus_add_driver+0xec/0x1f0
> 	bus_add_driver from driver_register+0x84/0x11c
> 	driver_register from do_one_initcall+0x84/0x1c8
> 	do_one_initcall from kernel_init_freeable+0x1a4/0x230
> 	kernel_init_freeable from kernel_init+0x1c/0x138
> 	kernel_init from ret_from_fork+0x14/0x28
> 	Exception stack(0x9f015fb0 to 0x9f015ff8)
> 	5fa0:                                     00000000 00000000 00000000 00000000
> 	5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 	5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 	---[ end trace 0000000000000000 ]---
> 	aspeed_gfx 1e6e6000.display: [drm] fb0: aspeed-gfx-drmd frame buffer device
> 
> Hence, restructure the code to initialize the regions as soon as each
> of them are added to the reserved_mem array.
> 
> Fixes: a46cccb0ee2d ("of: reserved_mem: Restruture how the reserved memory regions are processed")
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>

This resolves the warning that I see and I see no other warnings
introduced in any of my virtual boot tests.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> v2:
> - Fix kernel-doc for of_init_reserved_mem_node() in response to the
>   below warning from v1:
>   https://lore.kernel.org/all/202406181626.126X1Nbz-lkp@intel.com/
> 
> v1:
>   https://lore.kernel.org/all/20240617193357.3929092-1-quic_obabatun@quicinc.com/
> 
>  drivers/of/fdt.c             |  2 +-
>  drivers/of/of_private.h      |  2 +-
>  drivers/of/of_reserved_mem.c | 83 +++++++++++++++++++++---------------
>  3 files changed, 50 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 9cde2abd2fc0..ea2dff0478c7 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1239,7 +1239,7 @@ void __init unflatten_device_tree(void)
>  	unittest_unflatten_overlay_base();
>  
>  	/* initialize the reserved memory regions */
> -	of_init_reserved_mem();
> +	of_scan_reserved_mem_reg_nodes();
>  }
>  
>  /**
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 01b33c4b1e9f..7412aed903df 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -181,7 +181,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
>  #endif
>  
>  int fdt_scan_reserved_mem(void);
> -void of_init_reserved_mem(void);
> +void of_scan_reserved_mem_reg_nodes(void);
>  
>  bool of_fdt_device_is_available(const void *blob, unsigned long node);
>  
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index eb54490a0a11..b31001728866 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -97,6 +97,8 @@ static void __init alloc_reserved_mem_array(void)
>  	reserved_mem = new_array;
>  }
>  
> +static void __init of_init_reserved_mem_node(struct reserved_mem *rmem);
> +
>  /*
>   * of_reserved_mem_save_node() - save fdt node for second pass initialization
>   */
> @@ -115,6 +117,12 @@ static void __init of_reserved_mem_save_node(struct device_node *node, const cha
>  	rmem->base = base;
>  	rmem->size = size;
>  
> +	/*
> +	 * Run the region specific initialization function for the rmem
> +	 * node.
> +	 */
> +	of_init_reserved_mem_node(rmem);
> +
>  	reserved_mem_count++;
>  	return;
>  }
> @@ -201,6 +209,8 @@ static int __init __fdt_reserved_mem_check_root(unsigned long node)
>  	return 0;
>  }
>  
> +static void __init __rmem_check_for_overlap(void);
> +
>  /**
>   * of_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
>   * reserved memory regions.
> @@ -211,7 +221,7 @@ static int __init __fdt_reserved_mem_check_root(unsigned long node)
>   * size are all stored in the reserved_mem array by calling the
>   * of_reserved_mem_save_node() function.
>   */
> -static void __init of_scan_reserved_mem_reg_nodes(void)
> +void __init of_scan_reserved_mem_reg_nodes(void)
>  {
>  	struct device_node *node, *child;
>  	phys_addr_t base, size;
> @@ -222,6 +232,13 @@ static void __init of_scan_reserved_mem_reg_nodes(void)
>  		return;
>  	}
>  
> +	/*
> +	 * Before moving forward, allocate the exact size needed for the
> +	 * reserved_mem array and copy all previously saved contents
> +	 * into the new array if successful.
> +	 */
> +	alloc_reserved_mem_array();
> +
>  	for_each_child_of_node(node, child) {
>  		int ret = 0;
>  		const char *uname;
> @@ -246,6 +263,8 @@ static void __init of_scan_reserved_mem_reg_nodes(void)
>  		if (size)
>  			of_reserved_mem_save_node(child, uname, base, size);
>  	}
> +	/* check for overlapping reserved regions */
> +	__rmem_check_for_overlap();
>  }
>  
>  static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
> @@ -526,44 +545,38 @@ static void __init __rmem_check_for_overlap(void)
>  }
>  
>  /**
> - * of_init_reserved_mem() - allocate and init all saved reserved memory regions
> + * of_init_reserved_mem_node() - Initialize a saved reserved memory region.
> + * @rmem: reserved_mem object of the memory region to be initialized.
> + *
> + * This function is used to call the region specific initialization
> + * function on the rmem object passed as an argument. The rmem object
> + * will contain the base address, size, node name, and device_node of
> + * the reserved memory region to be initialized.
>   */
> -void __init of_init_reserved_mem(void)
> +static void __init of_init_reserved_mem_node(struct reserved_mem *rmem)
>  {
> -	int i;
> -
> -	alloc_reserved_mem_array();
> -
> -	of_scan_reserved_mem_reg_nodes();
> +	int err;
> +	bool nomap;
> +	struct device_node *node = rmem->dev_node;
>  
> -	/* check for overlapping reserved regions */
> -	__rmem_check_for_overlap();
> +	nomap = of_property_present(node, "no-map");
>  
> -	for (i = 0; i < reserved_mem_count; i++) {
> -		struct reserved_mem *rmem = &reserved_mem[i];
> -		struct device_node *node = rmem->dev_node;
> -		int err = 0;
> -		bool nomap;
> -
> -		nomap = of_property_present(node, "no-map");
> -
> -		err = __reserved_mem_init_node(rmem);
> -		if (err != 0 && err != -ENOENT) {
> -			pr_info("node %s compatible matching fail\n", rmem->name);
> -			if (nomap)
> -				memblock_clear_nomap(rmem->base, rmem->size);
> -			else
> -				memblock_phys_free(rmem->base, rmem->size);
> -		} else {
> -			phys_addr_t end = rmem->base + rmem->size - 1;
> -			bool reusable = of_property_present(node, "reusable");
> -
> -			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
> -				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
> -				nomap ? "nomap" : "map",
> -				reusable ? "reusable" : "non-reusable",
> -				rmem->name ? rmem->name : "unknown");
> -		}
> +	err = __reserved_mem_init_node(rmem);
> +	if (err != 0 && err != -ENOENT) {
> +		pr_info("node %s compatible matching fail\n", rmem->name);
> +		if (nomap)
> +			memblock_clear_nomap(rmem->base, rmem->size);
> +		else
> +			memblock_phys_free(rmem->base, rmem->size);
> +	} else {
> +		phys_addr_t end = rmem->base + rmem->size - 1;
> +		bool reusable = of_property_present(node, "reusable");
> +
> +		pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
> +			&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
> +			nomap ? "nomap" : "map",
> +			reusable ? "reusable" : "non-reusable",
> +			rmem->name ? rmem->name : "unknown");
>  	}
>  }
>  
> -- 
> 2.34.1
> 
