Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8B34B19F
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916705; cv=none; b=KNHquexuUh2+JrNBFd1rP6DLxyaeUWV49pgJVvBpZMZeQGUJLCMQL6wloRcMXdSqc89iK5BW3LI/49Gr4Ed9fW6uSvLawTtkvgMru9N7dvmaYTTr3zI23rL0kjbMNDgM+5ufrrAbYZh2CWZa4exe/2JB1qKtDGM45UvpQ2HjZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916705; c=relaxed/simple;
	bh=ZkSSLMO5sTW2e2Ggwl6O1EpW5lgoafxV6kp3/SwIcoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ8xBFlgqwHNQ6CG9+MxynC+R8A1Vk7QBD4/ZU3/WUkUVJZGdv1hw5gKUKZUdge16/MjSp9kWzl38WOZMTM5dUwClIPCqJg6wMf4y/ncMPKPfdnIErv0VT1VtEZAA/GzG60c+lYPI2zJ1kfIBUMhVgKy+XiIHpbrV0HzStKMIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6xyVSEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6xyVSEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9A51F000E9;
	Wed,  1 Jul 2026 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916703;
	bh=FCJc8Y4JmEOreL4L+vTlFLlPE/nMLhzyI1DM8YdqDxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B6xyVSErGQCC8QTMJYXKkOjLc7Mv9Rv2B6Ifr7ClnfKg36JsUPDYDajR/pLRNaXuJ
	 8DIyBokdUdMBU6UbRRrEdjbUWCytV2AxOQuI6NViO5B4xKkDxo7+9Qi0Iu4MCoqBH2
	 Nkew2CpAno/k2fyqTTt57p8FX+zsY0EWkxmv6+Gz5+BZOkiCytNHyIWS9xPtXj2CO6
	 pKKfgW0Fg4Yr+G9SlUm2vb5zyzayQ2C+Xb1OI4EjEKGu6z3hqR2aWEFDQZ7DopzOUW
	 bGTNsAD8D6mgksC/d2TZbjZG97hJH+jsP67CDPe6n7TARhzTc/YcrL9t6o5K9WNTsN
	 OL/pwav2TNtSg==
Date: Wed, 1 Jul 2026 16:38:11 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 1/3] drm/i915/gem: split shared memory allocation
 table logic
Message-ID: <akUibf3NyThHnXco@zenone.zhora.eu>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-2-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701104437.236979-2-krzysztof.karas@intel.com>

Hi Krzysztof,

On Wed, Jul 01, 2026 at 10:44:35AM +0000, Krzysztof Karas wrote:
> shmem_sg_alloc_table is a complex and hard to read function.
> Split its logic into smaller pieces to improve readability and
> reduce indentation. Change the main "for" loop into "while" to
> get rid of obscure iterator "i" and be more explicit in
> traversing scatterlist.

any chance we can split this cleanup into smaller pieces?

> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

...

> +static struct folio *shmem_shrink_get_folio(struct address_space *mapping,
> +					    unsigned long folio_index,
> +					    gfp_t gfp, unsigned int pages_left,
> +					    struct drm_i915_private *i915)
> +{
> +#define MAX_READS 2

This MAX_READS here is very ugly! Just use 2 and explain it in a
comment. In the 'if' below you can check out of "if (... || i)"
and still explain it in a comment.

> +	struct folio *folio;
> +	unsigned int i;
> +
> +	for (i = 0; i < MAX_READS; i++) {
> +		cond_resched();
> +		folio = shmem_read_folio_gfp(mapping, folio_index, gfp);
> +		if (!IS_ERR(folio) || i == MAX_READS - 1)
> +			return folio;
> +
> +		i915_gem_shrink(NULL, i915, 2 * pages_left, NULL,

/pages_left/page_count/

> +				I915_SHRINK_BOUND | I915_SHRINK_UNBOUND);
> +

...

> +	}
> +
> +	/* Should never happen */
> +	WARN_ON_ONCE(1);

no need.

Thanks,
Andi

> +	return ERR_PTR(-EINVAL);
> +}
