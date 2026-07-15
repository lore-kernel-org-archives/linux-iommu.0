Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E7D481FD8
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129523; cv=none; b=lQKGPHQDd8d4/EbRPz3VgOAVw7+f4+NF1RDA26KSsRxy/K9RJ6HHh288XMvTlIV0uZmqdLmqzhEmXEN8D2z4TxRUbnZM5Q8Db3AQCHv8xkfN0y/yrq2eIBP5uWGuqdld3rbjM6IBu/BxnWKrb3PFOLk0EBmjuR2yOmo5G+oYnDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129523; c=relaxed/simple;
	bh=uxQEkKsEB6KSJIG6TBd6vt/3+84+YhOXzaye/UwOWro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6hXlg7f2LdbB4oIvKuccbK6DHVlbV/1xnMW1+ZVcM4ab19jto3KpZ9GBQsUPsX2ta27g2vySzIbAYT9y1xYy60Tzu/XQtr5OmUuoJSEN2ANGdzu4RcypKAiuzPHv7LeZC1nR1OxT+WmV9DlSbtVXK47xpM9Lx6lGVQRpHrnpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfM7l3ZX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfM7l3ZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784129522; x=1815665522;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uxQEkKsEB6KSJIG6TBd6vt/3+84+YhOXzaye/UwOWro=;
  b=DfM7l3ZXyU4WwQn260RuOwJoIXzWiLWOr78rNz2GOG4sNiJ+HdQUTf2H
   7i/MqxJ2/LTQ4uf36Y9NUq3LGzyFyjZ0qLoxNLlzSpYhpdUk5Ay+KR+SH
   feQhqcoYBmsnWin8pOe2Zq+jow+CxzU/qVFxacr/tMeL/8CXstFQvRfxB
   H/gp/Gug1PTO/SgWGz+oLc3C4lec/O85LRouOTpL3KRaG8NG0w5PrFk4P
   p5enxPUoiuGdWI+0K793AYCCROBQnpnU6cl0WBlY/MZ5+Jlt5Zu1ENNeu
   bRCQjapiv/Mq2DXCtl/yft+MdhgvXFvDBif8j96UMkcYOe/OvE5KxfFHG
   Q==;
X-CSE-ConnectionGUID: o2QcgTQCQwavxmPafInW5g==
X-CSE-MsgGUID: Skef1u9OQVKqDySjrdyheg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="72302456"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="72302456"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:32:01 -0700
X-CSE-ConnectionGUID: wsw9T3L/Tl+JD1YnkJxouw==
X-CSE-MsgGUID: lGR3oExsSFK796u7rEBHJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="252817349"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.25])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:31:58 -0700
Message-ID: <8979872eac4f9eabb499f074b66583013f6f524c.camel@linux.intel.com>
Subject: Re: [PATCH v3 4/5] drm/i915/gem: Read and shrink memory in a
 separate function
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>,  Jason Gunthorpe	 <jgg@ziepe.ca>,
 =?UTF-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,  Sebastian
 Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Wed, 15 Jul 2026 17:31:56 +0200
In-Reply-To: <20260713095812.1014365-5-krzysztof.karas@intel.com>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
	 <20260713095812.1014365-5-krzysztof.karas@intel.com>
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

On Mon, 2026-07-13 at 09:58 +0000, Krzysztof Karas wrote:
> Continue unloading shmem_sg_alloc_table by placing reading
> folios and shrink call into a new helper.
> Make the loop a bit more reader-friendly by removing iteration
> over a structure and replacing it with a do-while loop.
>=20
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v3:
>  * Split refactoring and put it after the fix in shmem folio
>   counting suggested by Andi.
>  * Use do-while loop suggested by Robin.=20
>=20
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 102 ++++++++++++----------
>  1 file changed, 55 insertions(+), 47 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 4a61b012fb6f..7c8de8fe0a22 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -78,6 +78,55 @@ static int validate_size(size_t size, unsigned int pag=
e_count,
>  	return 0;
>  }
> =20
> +static struct folio *shmem_shrink_get_folio(struct address_space *mappin=
g,
> +					    unsigned long folio_index,
> +					    gfp_t gfp, unsigned int page_count,
> +					    struct drm_i915_private *i915)
> +{
> +	struct folio *folio =3D NULL;
> +	unsigned int retries =3D 2;
> +
> +	do {
> +		cond_resched();
> +		folio =3D shmem_read_folio_gfp(mapping, folio_index, gfp);
> +		if (IS_ERR(folio)) {

Going again through then unused shrinking and modification of gfp doesn't=
=C2=A0
make sense, I believe.  Could be avoided based on retries value as an=C2=A0
additional condition.

Thanks,
Janusz


> +			i915_gem_shrink(NULL, i915, 2 * page_count, NULL,
> +					I915_SHRINK_BOUND | I915_SHRINK_UNBOUND);
> +
> +			/*
> +			 * We've tried hard to allocate the memory by reaping
> +			 * our own buffer, now let the real VM do its job and
> +			 * go down in flames if truly OOM.
> +			 *
> +			 * However, since graphics tend to be disposable,
> +			 * defer the oom here by reporting the ENOMEM back
> +			 * to userspace.
> +			 *
> +			 * Reclaim and warn, but no oom.
> +			 */
> +			gfp =3D mapping_gfp_mask(mapping);
> +
> +			/*
> +			 * Our bo are always dirty and so we require
> +			 * kswapd to reclaim our pages (direct reclaim
> +			 * does not effectively begin pageout of our
> +			 * buffers on its own). However, direct reclaim
> +			 * only waits for kswapd when under allocation
> +			 * congestion. So as a result __GFP_RECLAIM is
> +			 * unreliable and fails to actually reclaim our
> +			 * dirty pages -- unless you try over and over
> +			 * again with !__GFP_NORETRY. However, we still
> +			 * want to fail this allocation rather than
> +			 * trigger the out-of-memory killer and for
> +			 * this we want __GFP_RETRY_MAYFAIL.
> +			 */
> +			gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +		}
> +	} while (IS_ERR(folio) && --retries);
> +
> +	return folio;
> +}
> +
>  int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table =
*st,
>  			 size_t size, struct intel_memory_region *mr,
>  			 struct address_space *mapping,
> @@ -117,57 +166,16 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  	for (i =3D 0; i < page_count; i++) {
>  		unsigned long folio_page_index =3D 0;
>  		unsigned long nr_pages;
> -		const unsigned int shrink[] =3D {
> -			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
> -			0,
> -		}, *s =3D shrink;
>  		gfp_t gfp =3D noreclaim;
> =20
>  		/* Grab the next folio if we exhausted the current one. */
>  		if (!i || i > folio_end) {
> -			do {
> -				cond_resched();
> -				folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> -				if (!IS_ERR(folio))
> -					break;
> -
> -				if (!*s) {
> -					ret =3D PTR_ERR(folio);
> -					goto err_sg;
> -				}
> -
> -				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> -
> -				/*
> -				* We've tried hard to allocate the memory by reaping
> -				* our own buffer, now let the real VM do its job and
> -				* go down in flames if truly OOM.
> -				*
> -				* However, since graphics tend to be disposable,
> -				* defer the oom here by reporting the ENOMEM back
> -				* to userspace.
> -				*/
> -				if (!*s) {
> -					/* reclaim and warn, but no oom */
> -					gfp =3D mapping_gfp_mask(mapping);
> -
> -					/*
> -					 * Our bo are always dirty and so we require
> -					 * kswapd to reclaim our pages (direct reclaim
> -					 * does not effectively begin pageout of our
> -					 * buffers on its own). However, direct reclaim
> -					 * only waits for kswapd when under allocation
> -					 * congestion. So as a result __GFP_RECLAIM is
> -					 * unreliable and fails to actually reclaim our
> -					 * dirty pages -- unless you try over and over
> -					 * again with !__GFP_NORETRY. However, we still
> -					 * want to fail this allocation rather than
> -					 * trigger the out-of-memory killer and for
> -					 * this we want __GFP_RETRY_MAYFAIL.
> -					 */
> -					gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> -				}
> -			} while (1);
> +			folio =3D shmem_shrink_get_folio(mapping, i, gfp,
> +						       page_count, i915);
> +			if (IS_ERR(folio)) {
> +				ret =3D PTR_ERR(folio);
> +				goto err_sg;
> +			}
> =20
>  			folio_start =3D folio_pgoff(folio);
>  			folio_end =3D folio_start + folio_nr_pages(folio) - 1;
