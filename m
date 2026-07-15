Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1740EBA9
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128907; cv=none; b=ls4XBQgjawBYJVGkVO0TVat0K4mCxlKChoCjCEZrxMUW2erKSMmZMjVa3xijs9bRUUx0A+dirCDasLD4jMneho/7tI3yarJ0JR3fCmCR/SPjKxfwmDVhVbeAt3VMbtdZErCeB/iLh7UQIx34/4z/JEOMdeLWt4j5ogllY8iRx60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128907; c=relaxed/simple;
	bh=ncXiZ3N9K4okkZV4BfOO7md4Q74b8pPvsDI3ButiQK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=asOifh2Uu9gUTaA9n0UjmFH2qUeKkeweGyFxu6hJUGJ2TmdIWTLe+AKjFmcjPlVDnR68ngZLmonIv2P/B6TBOYN3YT7yHin7W653cMoClqAL9zxcP7kMM+oSMkFCpDekow9OgAhRzRNS0D5BcMJyvw3qKy/v0RhT5x/0DjWbIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHLSeOKO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHLSeOKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784128905; x=1815664905;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ncXiZ3N9K4okkZV4BfOO7md4Q74b8pPvsDI3ButiQK4=;
  b=HHLSeOKOSiQIuI/H3l+xe0YNk6L8NiUYFZUyAeMBhI9z9uE+dkh48rnj
   +OqHBDE6NjEzUipA4R7YHPDyojQPR5XugngrU0rgWw3mwAFjkcc5tOmu4
   LCduZBomcSZf/vRo3s+cZcRoGqZoijexAbryN/SMsI2eYjRaHWJ7UPwaE
   vh52ZNRn5gNuT6Pr8ADZD6QkPpJtBvjKIL3ic5eb95e++3vpgqTmMeQj1
   S07E8Oa8GwaUdGWp6Ivpd3uYC05xmGd1OsK2UnMorxfQKyQxV1AiXi1xG
   XCM0IzHaOrYF5v9/9UwBiSPDPP02BeARFSdvpPyNS5aHJGzmjphrWOMC8
   Q==;
X-CSE-ConnectionGUID: achEZ3oaQAW1u0fuzr9kkQ==
X-CSE-MsgGUID: f3qdMoSERMu9fGG48qaKBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95417315"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="95417315"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:21:45 -0700
X-CSE-ConnectionGUID: NQzVcubgSRSHdDd4Hvddvg==
X-CSE-MsgGUID: IE/0a5nAQXSME1yrKfofWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="294420716"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:21:43 -0700
Message-ID: <ceb6e88a73eb99700b0af3e19e3d5c4941341752.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/5] drm/i915/gem: Pull out size validation into a
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
Date: Wed, 15 Jul 2026 17:21:39 +0200
In-Reply-To: <20260713095812.1014365-4-krzysztof.karas@intel.com>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
	 <20260713095812.1014365-4-krzysztof.karas@intel.com>
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

On Mon, 2026-07-13 at 09:58 +0000, Krzysztof Karas wrote:
> shmem_sg_alloc_table is a very large and hard to read function,
> so reduce the number of operations it is responsible for by
> placing "size" validation in a new helper.
>=20
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v3:
>  * Split refactoring and put it after the fix in shmem folio
>   counting suggested by Andi.
>=20
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 29 ++++++++++++++++-------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 0011d76f5b8c..4a61b012fb6f 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -62,6 +62,22 @@ void shmem_sg_free_table(struct sg_table *st, struct a=
ddress_space *mapping,
>  	sg_free_table(st);
>  }
> =20
> +static int validate_size(size_t size, unsigned int page_count,
> +			 struct intel_memory_region *mr)
> +{
> +	if (overflows_type(size / PAGE_SIZE, page_count))
> +		return -E2BIG;
> +
> +	/*
> +	 * If there's no chance of allocating enough pages for the whole
> +	 * object, bail early.
> +	 */
> +	if (size > resource_size(&mr->region))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table =
*st,
>  			 size_t size, struct intel_memory_region *mr,
>  			 struct address_space *mapping,
> @@ -77,16 +93,11 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  	unsigned long i;
>  	int ret;
> =20
> -	if (overflows_type(size / PAGE_SIZE, page_count))
> -		return -E2BIG;
> -
>  	page_count =3D size / PAGE_SIZE;

Verifying if page_count can accommodate a result before assigning that
result to=C2=A0it looked more correctly to me.  Since overflows_type() does=
n't
look at the variable's value, only its type, I think you could postpone=C2=
=A0
page_count=C2=A0initialization and pass its pointer to your helper to prese=
rve=C2=A0
that=C2=A0more=C2=A0reasonable order of operations.

Thanks,
Janusz

> -	/*
> -	 * If there's no chance of allocating enough pages for the whole
> -	 * object, bail early.
> -	 */
> -	if (size > resource_size(&mr->region))
> -		return -ENOMEM;
> +
> +	ret =3D validate_size(size, page_count, mr);
> +	if (ret < 0)
> +		return ret;
> =20
>  	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
>  		return -ENOMEM;
