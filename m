Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22A4BB5DE
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639203; cv=none; b=gzsKd+twTPvKyHy1j14j8mjSu0e8XWlZEv0nTGD9nMRZMgFekNoS2Y3ioPCqKQZt5r4/gQlpSOde592VnOSceLj197mEMLC1LZ+qyFPoHTVs6PUNHxTZXdcyCf/VggPpZykAduUWsRTC8CGkxs2yu+moM+wLsBlTbRLlfb/ONm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639203; c=relaxed/simple;
	bh=Mk9Bdo8WeSWLdlY3kVy3c9IZmIBUDNXJJG5+iJ0Plv0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZOTc08/N1gE7LGjjeK1oIh1tP6BkxSxsEVW67P+fiZgb6hw+duCwxlKT+FRsqe2/ZSZFh362cfJBU5l7Q5OoB7Tf39zD6jvBQq1oXxiSd3f0KOWwTeLDPDOiYd2pt9uCU9a360OGKY9EQAaqMEAqgCTH7axGSBP5PHxnF+6HtA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjeEzBlI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjeEzBlI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789639198; x=1821175198;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Mk9Bdo8WeSWLdlY3kVy3c9IZmIBUDNXJJG5+iJ0Plv0=;
  b=JjeEzBlIKMJY+d1ufCsvjmBVjI4Vhtpaz48lKw/Wdg9uoA3mMjLbN0dv
   iLcaxkM5T9Tjhs4EgzutWlQR7luIm8mzGVLxSUI3YcBtc3qrQxrN2jDv/
   RPW0c/yVtHwHEAwaANVgkKZrQx23DqKfyMVFHQPE40HHET+AAmV6+cazc
   mvd4kGZVVxntP1QLvWG0VXbNZsIFKJZCmYvjLTBKCg1ZX108zSVWuVefm
   t3LwoqoFaQa5Cd+CyJjKb9D0rsbFug2BEo0aLup/ktyjsE6M50ftqkVdi
   Iinw781OfBB4LXC6OHgyJlOBEZ8Ro7AK6gaX0ViLNYe45G05RrvJ2UgG3
   w==;
X-CSE-ConnectionGUID: QqsDddWPRQ60g5CtzBHz2Q==
X-CSE-MsgGUID: OLMCqS0kSzytJZ9eP8cTtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90178593"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90178593"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:59:51 -0700
X-CSE-ConnectionGUID: eis/V58fQSOqK5wTKEJxLA==
X-CSE-MsgGUID: 2e/XBX4hQjiy2chgGcl9YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271063053"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.83])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:59:48 -0700
Message-ID: <9bfa7e89cb777f5e32fe82adb77615fef58f5d69.camel@linux.intel.com>
Subject: Re: [PATCH v6 2/7] drm/i915/gem: Count mapped pages in a folio
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>,  =?UTF-8?Q?Micha=C5=82?= Grzelak	
 <michal.grzelak@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>,  Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Thu, 17 Sep 2026 11:59:45 +0200
In-Reply-To: <20260902082525.1149367-3-krzysztof.karas@intel.com>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
	 <20260902082525.1149367-3-krzysztof.karas@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Krzysztof,

Since you are going to submit another version, here are still some comments
of mine for you to consider.

On Wed, 2026-09-02 at 08:25 +0000, Krzysztof Karas wrote:
> Before addition of commit 029ae067431a
> ("drm/i915: Fix potential overflow of shmem scatterlist length")
> and after folios were introduced complete folios were always
> allocated, possibly overloading the scatterlist capacity which
> was never truly limited to PAGE_SIZE when requested via
> max_segment. The above commit addressed scatterlist overloading,
> but unintentionally disabled PAGE_SIZE as a valid max_segment
> value and failed to take care of remaining pages from folios
> above max_segment boundary.
> This created a state, where multitude of scatterlists were used
> for the same folio, but never counting enough of its pages to
> jump to the next folio.
>=20
> Furthermore, current do-while loop goes over the same folio
> multiple times, increasing the refcount each time, and breaks
> get/put symmetry: many shmem_read_folio_gfp() gets and only one
> put in i915_gem_object_put_pages_shmem() per folio.
>=20
> Track how many pages have already been counted in a folio and
> use that number as an offset on consecutive allocations from the
> same folio to ensure it is fully covered before reading next
> folio.
>=20
> Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterli=
st length")
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
> Assisted-by: GitHub Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v6:
>  * moved max_segment check into its own patch;
>  * moved comment about gcc warnings above block of
>    initializations;
>  * removed
>    WARN_ON_ONCE(folio_page_index >=3D folio_nr_pages(folio))
>    block (Andi);
>  * restored original condition (folio_pfn(folio) !=3D next_pfn)
>    (Janusz);
>  * dropped folio_page_index and folio initializations;
>  * expanded the commit message to contain information about
>    previously unexplained folio reference leaks;
>  * ran final checks with Claude Opus and added a tag.
>=20
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 112 +++++++++++++---------
>  1 file changed, 67 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 4b5ce9a2f74f..8e5f2a7d5f6b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -70,7 +70,11 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915=
, struct sg_table *st,
>  	unsigned int page_count; /* restricted by sg_alloc_table */
>  	unsigned long i;
>  	struct scatterlist *sg;
> -	unsigned long next_pfn =3D 0;	/* suppress gcc warning */
> +	/* suppress gcc warnings */
> +	unsigned long next_pfn =3D 0;
> +	unsigned long folio_start =3D 0;
> +	unsigned long folio_end =3D 0;
> +	struct folio *folio;
>  	gfp_t noreclaim;
>  	int ret;
> =20
> @@ -104,7 +108,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  	sg =3D st->sgl;
>  	st->nents =3D 0;
>  	for (i =3D 0; i < page_count; i++) {
> -		struct folio *folio;
> +		unsigned long folio_page_index;
>  		unsigned long nr_pages;
>  		const unsigned int shrink[] =3D {
>  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
> @@ -112,51 +116,58 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  		}, *s =3D shrink;
>  		gfp_t gfp =3D noreclaim;
> =20
> -		do {
> -			cond_resched();
> -			folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> -			if (!IS_ERR(folio))
> -				break;
> +		/* Grab the next folio if we exhausted the current one. */
> +		if (!i || i > folio_end) {
> +			do {
> +				cond_resched();
> +				folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> +				if (!IS_ERR(folio))
> +					break;
> =20
> -			if (!*s) {
> -				ret =3D PTR_ERR(folio);
> -				goto err_sg;
> -			}
> +				if (!*s) {
> +					ret =3D PTR_ERR(folio);
> +					goto err_sg;
> +				}
> =20
> -			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> -
> -			/*
> -			 * We've tried hard to allocate the memory by reaping
> -			 * our own buffer, now let the real VM do its job and
> -			 * go down in flames if truly OOM.
> -			 *
> -			 * However, since graphics tend to be disposable,
> -			 * defer the oom here by reporting the ENOMEM back
> -			 * to userspace.
> -			 */
> -			if (!*s) {
> -				/* reclaim and warn, but no oom */
> -				gfp =3D mapping_gfp_mask(mapping);
> +				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> =20
>  				/*
> -				 * Our bo are always dirty and so we require
> -				 * kswapd to reclaim our pages (direct reclaim
> -				 * does not effectively begin pageout of our
> -				 * buffers on its own). However, direct reclaim
> -				 * only waits for kswapd when under allocation
> -				 * congestion. So as a result __GFP_RECLAIM is
> -				 * unreliable and fails to actually reclaim our
> -				 * dirty pages -- unless you try over and over
> -				 * again with !__GFP_NORETRY. However, we still
> -				 * want to fail this allocation rather than
> -				 * trigger the out-of-memory killer and for
> -				 * this we want __GFP_RETRY_MAYFAIL.
> -				 */
> -				gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> -			}
> -		} while (1);
> -
> -		nr_pages =3D min3(folio_nr_pages(folio),
> +				* We've tried hard to allocate the memory by reaping
> +				* our own buffer, now let the real VM do its job and
> +				* go down in flames if truly OOM.
> +				*
> +				* However, since graphics tend to be disposable,
> +				* defer the oom here by reporting the ENOMEM back
> +				* to userspace.
> +				*/
> +				if (!*s) {
> +					/* reclaim and warn, but no oom */
> +					gfp =3D mapping_gfp_mask(mapping);
> +
> +					/*
> +					 * Our bo are always dirty and so we require
> +					 * kswapd to reclaim our pages (direct reclaim
> +					 * does not effectively begin pageout of our
> +					 * buffers on its own). However, direct reclaim
> +					 * only waits for kswapd when under allocation
> +					 * congestion. So as a result __GFP_RECLAIM is
> +					 * unreliable and fails to actually reclaim our
> +					 * dirty pages -- unless you try over and over
> +					 * again with !__GFP_NORETRY. However, we still
> +					 * want to fail this allocation rather than
> +					 * trigger the out-of-memory killer and for
> +					 * this we want __GFP_RETRY_MAYFAIL.
> +					 */
> +					gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +				}
> +			} while (1);
> +
> +			folio_start =3D folio_pgoff(folio);
> +			folio_end =3D folio_start + folio_nr_pages(folio) - 1;
> +		}
> +
> +		folio_page_index =3D i - folio_start;

While your point about the need to address more than one reference to a
folio unnecessarily being held was valid, I'm still not sure if what you
propose is the most simple way to resolve it.  For me, checking if next_pfn
is still inside the current folio range and omitting shmem_read_folio_gfp()
if true would be a good enough way to avoid re-getting it.

Moreover, I haven't heard from you about my idea of reusing that already
maintained next_pfn for calculation of folio_page_index, then still
simplifying the code changes that way.  Can you see any cons?

Thanks,
Janusz


> +		nr_pages =3D min3(folio_nr_pages(folio) - folio_page_index,
>  				page_count - i, max_segment / PAGE_SIZE);
> =20
>  		if (!i ||
> @@ -166,13 +177,24 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  				sg =3D sg_next(sg);
> =20
>  			st->nents++;
> -			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
> +			sg_set_page(sg, folio_page(folio, folio_page_index),
> +				    nr_pages * PAGE_SIZE, 0);
>  		} else {
> +			/*
> +			 * If our prediction about folio placement is true and
> +			 * scatterlist still has space left for more pages,
> +			 * then we land here.
> +			 */
>  			nr_pages =3D min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
> =20
>  			sg->length +=3D nr_pages * PAGE_SIZE;
>  		}
> -		next_pfn =3D folio_pfn(folio) + nr_pages;
> +
> +		/*
> +		 * We assume folios are placed one after the other in memory
> +		 * and predict where the next folio begins.
> +		 */
> +		next_pfn =3D folio_pfn(folio) + folio_page_index + nr_pages;
>  		i +=3D nr_pages - 1;
> =20
>  		/* Check that the i965g/gm workaround works. */
