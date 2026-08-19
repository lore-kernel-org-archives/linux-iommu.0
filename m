Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45FF3D0BE5
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140578; cv=none; b=KTjYKxKnLc9git7GSGzFMsIe1orbu8Wvmn74LFk96d8v4VURhxweCn07Xej6NCBtkKsm0QpHZUv23V6EQrwp6PYP1KhZRySDfEe2Q7b2lBCKPd2HJPp0MP/1JqDb5rJtR/Dfmm2X7TJ67y3zywMAWj6Q8pBPE+3JEAgl7V2TrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140578; c=relaxed/simple;
	bh=IkKA7mWu52pC2SQzuTT0FTPeWAENsNq24rgbAC+AE/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLxdEpyVyEzkzcxDliW9OrpViAz7rKgJppE8O29K6SLWKgHeZ/PdJ50BS/YwQuPjwLucc596bofImvZkico3C3QrUw1Qu2nB3DLvhCohfzfiiHmn7ideu69LK3y/gJDdxnii4s/A91tewdk/SklD2uT0jw4DpV148ZYcgFQN3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZGfP4LO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZGfP4LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D861F00A3A;
	Wed, 19 Aug 2026 11:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787140576;
	bh=Y9TFlC97/fU5+jsWSUYX/0b4tnqB948mdcrxZc+Z0N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jZGfP4LOjEgn/xAy8xqqbTtHf3OvevkPjSPvRwpOxQL4yNlXiX16JziQPRZ3ri78N
	 z8QmSHVTA9+sbqPnawJSgwo3wFIK9EWukI5LzffyKU+ctA/C5y5CPxKZqFd0sTyRnA
	 P1nQbILmsQWdudMyVt6o5CSH/TuXu0EKZIe8/j/oZe7Vk3CWBpFwksddF2BmqK7Cdi
	 04fR/A5yGkXuM7bn5n+/a8JRu7v5ZJlyZ10Wry3pT+0iBLK2eyK3B8mrDi7tmpWR+b
	 Gtmm3F/PuLqHRFVwo8sjeV5sLmDTdhGcYNJv6pu9bwpW6fSZV/GWbyFd50uzC4npnK
	 8HkeVNs3QDLUA==
Date: Wed, 19 Aug 2026 13:56:13 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v5 1/6] drm/i915/gem: Count mapped pages in a folio
Message-ID: <aoWMcLMNCl0cjcLx@zenone.zhora.eu>
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
 <20260817095648.2438192-2-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817095648.2438192-2-krzysztof.karas@intel.com>

Hi Krzysztof,

your patch looks good, but it needs to be polished a bit.

...

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index 06543ae60706..f338dc39fad1 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -68,10 +68,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>  			 unsigned int max_segment)
>  {
>  	unsigned int page_count; /* restricted by sg_alloc_table */
> -	unsigned long i;
> +	unsigned long next_pfn = 0; /* suppress gcc warning */
> +	unsigned long folio_start = 0;
> +	unsigned long folio_end = 0;

Can these go inside the for loop? Keep variables in the innermost
section needed.


Besides

> +	struct folio *folio = NULL;
>  	struct scatterlist *sg;
> -	unsigned long next_pfn = 0;	/* suppress gcc warning */
>  	gfp_t noreclaim;
> +	unsigned long i;

Please, don't reorder variables in this patch, it's out of the
scope.

>  	int ret;
>  
>  	if (overflows_type(size / PAGE_SIZE, page_count))
> @@ -85,6 +88,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>  	if (size > resource_size(&mr->region))
>  		return -ENOMEM;
>  
> +	if (max_segment < PAGE_SIZE)
> +		return -EINVAL;
> +

the max_segment validation is out of the scope.

>  	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
>  		return -ENOMEM;
>  
> @@ -101,7 +107,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>  	sg = st->sgl;
>  	st->nents = 0;
>  	for (i = 0; i < page_count; i++) {
> -		struct folio *folio;

Why are you moving this out of the for loop?

> +		unsigned long folio_page_index = 0;

This initialization is not necessary.

>  		unsigned long nr_pages;
>  		const unsigned int shrink[] = {
>  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,

...

> +				}
> +			} while (1);
> +
> +			folio_start = folio_pgoff(folio);
> +			folio_end = folio_start + folio_nr_pages(folio) - 1;
> +		}
> +
> +		folio_page_index = i - folio_start;
> +		if (WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))) {
> +			ret = -EINVAL;
> +			folio_put(folio);

I think shmem_sg_free_table() drops the folio reference already,
right?

> +			goto err_sg;
> +		}

Is this WARN_ON_ONCE() check really necessary?

>  
>  		nr_pages = min_array(((unsigned long[]) {
> -					folio_nr_pages(folio),
> +					folio_nr_pages(folio) - folio_page_index,
>  					page_count - i,
>  					max_segment / PAGE_SIZE,
>  				      }), 3);

...

> @@ -186,6 +216,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>  	i915_sg_trim(st);
>  
>  	return 0;
> +

Drop this change

What I want from this patch is a minimal change, without any
churn not belonging to the sole scope of the patch.

Thanks, Krzysztof,
Andi

>  err_sg:
>  	sg_mark_end(sg);
>  	if (sg != st->sgl) {
> -- 
> 2.34.1
> 
