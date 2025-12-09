Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C3221F24;
	Tue,  9 Dec 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765311448; cv=none; b=eLjYsxwIf2gOm24HAkKOB78yWMn311SzHy1WlCJYUDiEUQinztEfBy1XiBPJcdWThGTNLYLgcwRX+plW3sr6WKoNnSKyS1Kw0fXLHpKvp/WVMokaWP5snaUhOG3icBNmaYaIrQUTYpmJ1VV5+FRp+XtzQmkGLOt0qIzxM50D994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765311448; c=relaxed/simple;
	bh=WaUkBQ4r806vyiBGKBACPoJXtG1aq44WJUp8ANciYac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhoLm4dGpVKVBbUNUH51LynUhyt2otDes1xdC6aINt9yoglXfd30EUuHCwUXDNKbdhW7dYiES/MvXu1p7N5fnUUfddfU1P0OxunMkur/AezT+DygI4kz7GBJgg2XnF4C9M2rqw8xGb8mpP0kcmXFaPBa+uY7uoIcwev/97LhiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qrt9O9Gq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qrt9O9Gq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31427C4CEF5;
	Tue,  9 Dec 2025 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765311447;
	bh=WaUkBQ4r806vyiBGKBACPoJXtG1aq44WJUp8ANciYac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qrt9O9GqjfTKzm00Hh0OsM3usbi57/q7ndBFnw8Zo0q4lsP4he+NLmeT0sj5EJ1ox
	 FTTtMlYI4tzQsAYHFsJczTkw2iUf6/WUqtD73kQQZiaifkYcalc3LLAKnsIse2P9aG
	 qfK4GWhyg2bRuUxrfxBrnbAATZ5l2YXuJxioPw+dx7ft/7e4KwA65LSAuwEWikuMRt
	 SuLaJWWqZEStsgWiJp+g9Zuf40FW8MX6Pf2w2Ii3/lkGJMPovJOMfCdsX5pGUUGa35
	 CxHFypwCxjnYQk+07iVbrBaACB77MOPhPSFgvlULD0/TpINOcPGxilmlVK+lZ+vALu
	 kEe1KmBREwvMQ==
Date: Tue, 9 Dec 2025 14:17:25 -0600
From: Rob Herring <robh@kernel.org>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
	bjorn.andersson@oss.qualcomm.com, bod@kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org,
	charan.kalla@oss.qualcomm.com, prakash.gupta@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] of: Respect #{iommu,msi}-cells in maps
Message-ID: <20251209201725.GB1015230-robh@kernel.org>
References: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
 <20251204095530.8627-4-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204095530.8627-4-vijayanand.jitta@oss.qualcomm.com>

On Thu, Dec 04, 2025 at 03:25:30PM +0530, Vijayanand Jitta wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> So far our parsing of {iommu,msi}-map properites has always blindly
> asusmed that the output specifiers will always have exactly 1 cell.
> This typically does happen to be the case, but is not actually enforced
> (and the PCI msi-map binding even explicitly states support for 0 or 1
> cells) - as a result we've now ended up with dodgy DTs out in the field
> which depend on this behaviour to map a 1-cell specifier for a 2-cell
> provider, despite that being bogus per the bindings themselves.
> 
> Since there is some potential use in being able to map at least single
> input IDs to multi-cell output specifiers (and properly support 0-cell
> outputs as well), add support for properly parsing and using the target
> nodes' #cells values, albeit with the unfortunate complication of still
> having to work around expectations of the old behaviour too.
> 
> Since there are multi-cell output specifiers, the callers of of_map_id()
> may need to get the exact cell output value for further processing.
> Added support for that part --charan
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>  drivers/iommu/of_iommu.c |   3 +-
>  drivers/of/base.c        | 107 ++++++++++++++++++++++++++++++---------
>  include/linux/of.h       |  17 ++++---
>  3 files changed, 94 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index eac62bc441c5..48759cf1d900 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -45,10 +45,11 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
>  				     struct device *dev,
>  				     const u32 *id)
>  {
> -	struct of_phandle_args iommu_spec = { .args_count = 1 };
> +	struct of_phandle_args iommu_spec = {};
>  	struct of_map_id_arg arg = {
>  		.target = &iommu_spec.np,
>  		.id_out = iommu_spec.args,
> +		.map_cells = &iommu_spec.args_count,
>  	};
>  	int err;
>  
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index b8f78a9e6a09..68a7d6ddba66 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2045,11 +2045,30 @@ int of_find_last_cache_level(unsigned int cpu)
>  	return cache_level;
>  }
>  
> +/*
> + * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
> + * specifying only 1 cell. Fortunately they all consist of length == 1
> + * entries with the same target, so check for that pattern.

Can you show what a bad entry looks like here.

> + */
> +static bool of_check_bad_map(const __be32 *map, int len)
> +{
> +	__be32 phandle = map[1];
> +
> +	if (len % 4)
> +		return false;
> +	for (int i = 0; i < len; i += 4) {
> +		if (map[i + 1] != phandle || map[i + 3] != cpu_to_be32(1))

Why does the IOMMU arg cell have to be 1? The description said 'same 
target', but it is just all have an IOMMU cell value of 1?

> +			return false;
> +	}
> +	return true;
> +}
> +
>  /**
>   * of_map_id - Translate an ID through a downstream mapping.
>   * @np: root complex device node.
>   * @id: device ID to map.
>   * @map_name: property name of the map to use.
> + * @cells_name: property name of target specifier cells.
>   * @map_mask_name: optional property name of the mask to use.
>   * @arg: contains the optional params, @target which is a pointer
>   *	to the target device node and id_out which is a pointer
> @@ -2065,18 +2084,19 @@ int of_find_last_cache_level(unsigned int cpu)
>   *
>   * Return: 0 on success or a standard error code on failure.
>   */
> -int of_map_id(const struct device_node *np, u32 id,
> -	       const char *map_name, const char *map_mask_name,
> -	       struct of_map_id_arg *arg)
> +int of_map_id(const struct device_node *np, u32 id, const char *map_name,
> +	      const char *cells_name, const char *map_mask_name,
> +	      struct of_map_id_arg *arg)
>  {
>  	u32 map_mask, masked_id;
> -	int map_len;
> +	int map_bytes, map_len, offset = 0;
> +	bool bad_map = false;
>  	const __be32 *map = NULL;
>  
>  	if (!np || !map_name || !arg || (!arg->target && !arg->id_out))
>  		return -EINVAL;
>  
> -	map = of_get_property(np, map_name, &map_len);
> +	map = of_get_property(np, map_name, &map_bytes);
>  	if (!map) {
>  		if (arg->target)
>  			return -ENODEV;
> @@ -2085,11 +2105,9 @@ int of_map_id(const struct device_node *np, u32 id,
>  		return 0;
>  	}
>  
> -	if (!map_len || map_len % (4 * sizeof(*map))) {
> -		pr_err("%pOF: Error: Bad %s length: %d\n", np,
> -			map_name, map_len);
> -		return -EINVAL;
> -	}
> +	if (map_bytes % sizeof(*map))
> +		goto err_map_len;
> +	map_len = map_bytes / sizeof(*map);
>  
>  	/* The default is to select all bits. */
>  	map_mask = 0xffffffff;
> @@ -2102,27 +2120,62 @@ int of_map_id(const struct device_node *np, u32 id,
>  		of_property_read_u32(np, map_mask_name, &map_mask);
>  
>  	masked_id = map_mask & id;
> -	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
> +	while (offset < map_len) {
>  		struct device_node *phandle_node;
> -		u32 id_base = be32_to_cpup(map + 0);
> -		u32 phandle = be32_to_cpup(map + 1);
> -		u32 out_base = be32_to_cpup(map + 2);
> -		u32 id_len = be32_to_cpup(map + 3);
> +		u32 id_base, phandle, cells, id_len, id_off;
> +		const __be32 *out_base;
> +
> +		if (map_len - offset < 2)
> +			goto err_map_len;
>  
> +		id_base = be32_to_cpup(map + offset);
>  		if (id_base & ~map_mask) {
> -			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
> -				np, map_name, map_name,
> +			pr_err("%pOF: Invalid %s translation - %s (0x%x) ignores id-base (0x%x)\n",
> +				np, map_name, map_mask_name,
>  				map_mask, id_base);
>  			return -EFAULT;
>  		}
>  
> -		if (masked_id < id_base || masked_id >= id_base + id_len)
> -			continue;
> -
> +		phandle = be32_to_cpup(map + offset + 1);
>  		phandle_node = of_find_node_by_phandle(phandle);
>  		if (!phandle_node)
>  			return -ENODEV;
>  
> +		if (!bad_map && of_property_read_u32(phandle_node, cells_name, &cells)) {
> +			pr_err("%pOF: missing %s property\n", phandle_node, cells_name);
> +			return -EINVAL;
> +		}
> +
> +		if (map_len - offset < 3 + cells)
> +			goto err_map_len;
> +
> +		if (offset == 0 && cells == 2) {
> +			bad_map = of_check_bad_map(map, map_len);
> +			if (bad_map) {
> +				pr_warn_once("%pOF: %s mismatches target %s, assuming extra cell of 0\n",
> +				np, map_name, cells_name);
> +				cells = 1;
> +			}
> +		}
> +
> +		out_base = map + offset + 2;
> +		offset += 3 + cells;
> +
> +		id_len = be32_to_cpup(map + offset - 1);
> +		if (id_len > 1 && cells > 1) {
> +			/*
> +			 * With 1 output cell we reasonably assume its value
> +			 * has a linear relationship to the input; with more,
> +			 * we'd need help from the provider to know what to do.
> +			 */
> +			pr_err("%pOF: Unsupported %s - cannot handle %d-ID range with %d-cell output specifier\n",
> +				np, map_name, id_len, cells);
> +			return -EINVAL;
> +		}
> +		id_off = masked_id - id_base;
> +		if (masked_id < id_base || id_off >= id_len)
> +			continue;
> +
>  		if (arg->target) {
>  			if (*arg->target)
>  				of_node_put(phandle_node);
> @@ -2133,12 +2186,14 @@ int of_map_id(const struct device_node *np, u32 id,
>  				continue;
>  		}
>  
> -		if (arg->id_out)
> -			*arg->id_out = masked_id - id_base + out_base;
> +		for (int i = 0; arg->id_out && i < cells; i++)
> +			arg->id_out[i] = id_off + be32_to_cpu(out_base[i]);
>  
> +		if (arg->map_cells)
> +			*arg->map_cells = cells;
>  		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
> -			np, map_name, map_mask, id_base, out_base,
> -			id_len, id, masked_id - id_base + out_base);
> +			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
> +			id_len, id, id_off + be32_to_cpup(out_base));
>  		return 0;
>  	}
>  
> @@ -2149,5 +2204,9 @@ int of_map_id(const struct device_node *np, u32 id,
>  	if (arg->id_out)
>  		*arg->id_out = id;
>  	return 0;
> +
> +err_map_len:
> +	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
> +	return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(of_map_id);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 21bdce2b37ca..1981509c7918 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -29,6 +29,7 @@ struct device_node;
>  struct of_map_id_arg {
>  	struct device_node **target;
>  	u32 *id_out;
> +	u32 *map_cells;
>  };
>  
>  struct property {
> @@ -462,9 +463,9 @@ const char *of_prop_next_string(const struct property *prop, const char *cur);
>  
>  bool of_console_check(const struct device_node *dn, char *name, int index);
>  
> -int of_map_id(const struct device_node *np, u32 id,
> -	       const char *map_name, const char *map_mask_name,
> -	       struct of_map_id_arg *arg);
> +int of_map_id(const struct device_node *np, u32 id, const char *map_name,
> +	      const char *cells_name, const char *map_mask_name,
> +	      struct of_map_id_arg *arg);
>  
>  phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
>  
> @@ -911,9 +912,9 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
>  {
>  }
>  
> -static inline int of_map_id(const struct device_node *np, u32 id,
> -			     const char *map_name, const char *map_mask_name,
> -			     struct of_map_id_arg *arg)
> +static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
> +			    const char *cells_name, const char *map_mask_name,
> +			    struct of_map_id_arg *arg);
>  {
>  	return -EINVAL;
>  }
> @@ -1444,7 +1445,7 @@ static inline int of_property_read_s32(const struct device_node *np,
>  static inline int of_map_iommu_id(const struct device_node *np, u32 id,
>  				  struct of_map_id_arg *arg)
>  {
> -	return of_map_id(np, id, "iommu-map", "iommu-map-mask", arg);
> +	return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask", arg);
>  }
>  
>  static inline int of_map_msi_id(const struct device_node *np, u32 id,
> @@ -1455,7 +1456,7 @@ static inline int of_map_msi_id(const struct device_node *np, u32 id,
>  		.id_out = id_out,
>  	};
>  
> -	return of_map_id(np, id, "msi-map", "msi-map-mask", &arg);
> +	return of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask", &arg);

There are cases of no #msi-cells and we default to 0 cells in that case. 
Do you maintain that?

Rob
