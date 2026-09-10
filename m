Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B9348C50
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079249; cv=none; b=lHs0l5855hvykef8taktfQTH8noIXB3Js+wTvKJiR+GG0q56ufqu2w/JoFWqZRM5wlPtgS7pE4reVKCfpljzOnt3EYmNA7zs57TvI6fHvmoeYyGEO/10PZcO2ZxM20FyvOGhZ258EkdZlvAdYpS7mD50EZBXlMC5O+lwB6vNLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079249; c=relaxed/simple;
	bh=XcPIp+RzYjQYYEUH6MStHqN8Xf30N+wAbOh61ZDSCiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAtyB74qQNdB4xnh6QDBwY5nX1B2BukP4psGdvekt7E7bLg6Uim0+smbPr5aciT6mpTIoslDZPlksvtHMqjntGsINJGy8jX4JJ3z/JIXNSJST7yd8JN9E1NDn5mVRWP4Ic/Yr6LPWvvadxbrIiPbdOBTnR52kCU3GVBQyfnDSTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUiq862I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUiq862I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BB41F000FF;
	Thu, 10 Sep 2026 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789079248;
	bh=EJZ6yLX5sNuZIqDn9O98VTW8BCQq3c8v5/T+ZMMdv9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TUiq862IMpD5600ZATeWVp+S3zDjHrMp/bG3g5cuG6RXDgymU/6ZNiXWmymSpHoTM
	 4cN/GwFg2g4+tad91NkNi0jxK4XLlYdeTxwT6yWs87JAjsISSDQbR8Qfob1FYuT5Q5
	 gJDeEzH2UP/1SfZ6XofEUVw604A/fECLjgwahxpz5FkTPk2TsLml2N6qU3OLejHVpc
	 k5ZqRmwnhmKoOz+KTMj3pQD/ikSlPGa0ifapEIdmCeEn7yixAJYIv6dPo+ajMqNoEs
	 a+Kah6/ec3eCXHfJfSnHA44HlqD/HzcJ3NTmpZz9kaM7CXxqDYlOZMWII84yjcFi6g
	 iB4gpD20NHRSg==
Date: Fri, 11 Sep 2026 00:27:24 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 5/7] drm/i915/gem: Pull out size validation into a
 separate function
Message-ID: <aqMuklEmVVvg6yk_@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-6-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-6-krzysztof.karas@intel.com>

Hi Krzysztof,

...

> -	if (overflows_type(size / PAGE_SIZE, page_count))
> -		return -E2BIG;
> -
> -	page_count = size / PAGE_SIZE;
> -	/*
> -	 * If there's no chance of allocating enough pages for the whole
> -	 * object, bail early.
> -	 */
> -	if (size > resource_size(&mr->region))
> -		return -ENOMEM;
> +	ret = validate_set_page_count(size, &page_count, mr);
> +	if (ret < 0)

this can be "if (ret)". Otherwise:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

> +		return ret;
