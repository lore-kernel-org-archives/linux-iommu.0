Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C802798F3
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042986; cv=none; b=d1C5DiOORJ7mQaSbOflnFtx+kJBZyUdo9A1YkQuGAbDc/KnPIa2uxbYSH7I3VS36aLbsVdiXgGnluQS6wBq+K+8c3mjchu4AbyJogMeq5fxQOvM3z/JU5ir+0G0ay8ky/jH30qvUNBC+dE/atMSAStp+Zh5mUmFbyn0A3sul9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042986; c=relaxed/simple;
	bh=8DYO87tL4uz15oxFGRFzhq4FVDsfxOJqXVc91boKovk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG7S29cC65Xscs8LuQS3SRMGlmJFZqhkq3vN/fKAjqlTK8jhyNI2C8jTnHtTwMEChBc3uAecHMpr4QfIDLboawt3zUFC9v1S09r0asVa5Q77da1PqCxAn1HeTxHZDwu9LJ1evBvQdPM/86mScquWKaD4cfeAQIKQc0qTNVbbDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFLo8d6B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFLo8d6B"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22d95f0dda4so4039925ad.2
        for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746042983; x=1746647783; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fl3ZSe7H35q1B+EOiZUwtSQdGXkhze1P/MPuzRRU2ao=;
        b=fFLo8d6BUutRiM7Swgm7iXzIa1DxiH60K0PQPYMz+PPwbgSPx5xdYox84YxVVo+b6j
         wRKwuep4+0RUidmOf1kQAJ+jEfYfMdHLodOdNdcJeUhg/hNLaLduoTkmnNk3NILdCz7u
         Px/uLf1G3I6WgK487ozelX7dp2VuHj15qq3GgB1zgGP1I618EgNOoIUufTjF71jx3uR2
         lGvjxGMeUtOxX9IcaKHrFgYvExSyyK4ujeMeYCh25r88ToqswzCwOHO3rvvLsdb0OxfP
         oXO6RQ1smot2EEoKS2w43POd4J16H7mgRxSz9MesHYb2RZ7Mx3It34+CCHZUEN/EvD/E
         mI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746042983; x=1746647783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl3ZSe7H35q1B+EOiZUwtSQdGXkhze1P/MPuzRRU2ao=;
        b=EYFfrLpxMZ3S65rh6eYmkdSZnuwkrzsc/ZEFkPXvdhPnvJ7auPCqnCvo+qplXxEUqN
         RnTHYPNpQsGLJWToFROk3OJOjxeHNInIG7KrJ1flxbO6szNFRJZv90I/H4bIF3vxu+DB
         SFqmfH37QbLyQUPbG7RViyj/KYehwTh/GhIEQeGDvI6QGbDIq/W2FDcOnZDY1267jPH7
         HAtPYZFJ+Mi4EJyj7egxxzTMaNbMsixBe7qjKTP4buSYVAeynU/sEHL2rl9L+g1uVBtA
         fsYlH5S87I7L4fNbEQCAy9C4laHvRZ+vmtx8JvH46j+pa9MViEWXdEg8GgQ2kpy+W1/o
         wWkw==
X-Forwarded-Encrypted: i=1; AJvYcCWodPvbtt990uCnVsd7Ok7IJ8eKlnqm9K9kFwuf2g7CNjDyhVi5QWQcUAhuay1wzXp4kHddig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYoTekFgzPdS1IJIX2zmaFkTzv8sQLBpQuCLWczl6ckf4CNzwc
	xKs4LdK2Ik5E8a2UPRNSad3BptHl64owO5YHUgERdRNfsveEPxhGrY3CrBsmTQ==
X-Gm-Gg: ASbGnct8baBI24YzvchJeLH6CbK61MxkSOaZfbNCghBmSNB22Go0oG2TlzwpTvVhJBW
	lw2rt8BYCvVl7OTWohtHVBXqDUxX4QDILqgbDab/6CmJTIYbAwpRGDA3vhDBIYvZBLKBWGnYzAV
	p+QxfyKjvw8bkG3myxjQpmgbWieDhQ6Z+Rp3OC/9tvRCYLOIiUjpCdy5lq0hsPWLsCeI/2WSW7E
	lmr3/hIMDPpIqVHw/qqgke0d7iKdbCM6G15nNiV7K6Y2LqCDCqfnaP1CCG5etYSWIfD6xeKKdul
	Mth1Zd/oQJumgSM7TjKUBCPP7kKMDv0XgqT1iZRf7hfMnaRyb8ZU+PZJ/4MJVKcuB3LnMpXh7RK
	+yFqwrg==
X-Google-Smtp-Source: AGHT+IEfvBtw6ZDkXGIV92ANTqElq200z1gKvtBKSpmArntOiAskzPFgnv57q18obGXP2jeZOb7RVA==
X-Received: by 2002:a17:902:f785:b0:223:6744:bfb9 with SMTP id d9443c01a7336-22e041084e8mr4719445ad.41.1746042983190;
        Wed, 30 Apr 2025 12:56:23 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbb1a0sm126748995ad.58.2025.04.30.12.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:56:22 -0700 (PDT)
Date: Wed, 30 Apr 2025 12:56:18 -0700
From: William McVicker <willmcvicker@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] bus: fsl_mc: Fix driver_managed_dma check
Message-ID: <aBKAYnP0u9ZlK12y@google.com>
References: <20250425133929.646493-3-robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425133929.646493-3-robin.murphy@arm.com>

On 04/25/2025, Robin Murphy wrote:
> Since it's not currently safe to take device_lock() in the IOMMU probe
> path, that can race against really_probe() setting dev->driver before
> attempting to bind. The race itself isn't so bad, since we're only
> concerned with dereferencing dev->driver itself anyway, but sadly my
> attempt to implement the check with minimal churn leads to a kind of
> TOCTOU issue, where dev->driver becomes valid after to_fsl_mc_driver(NULL)
> is already computed, and thus the check fails to work as intended.
> 
> Will and I both hit this with the platform bus, but the pattern here is
> the same, so fix it for correctness too.

Thanks!

Reviewed-by: Will McVicker <willmcvicker@google.com>

> 
> Reported-by: Will McVicker <willmcvicker@google.com>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index a8be8cf246fb..67031136ef66 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -139,9 +139,9 @@ static int fsl_mc_bus_uevent(const struct device *dev, struct kobj_uevent_env *e
>  
>  static int fsl_mc_dma_configure(struct device *dev)
>  {
> +	const struct device_driver *drv = READ_ONCE(dev->driver);
>  	struct device *dma_dev = dev;
>  	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> -	struct fsl_mc_driver *mc_drv = to_fsl_mc_driver(dev->driver);
>  	u32 input_id = mc_dev->icid;
>  	int ret;
>  
> @@ -153,8 +153,8 @@ static int fsl_mc_dma_configure(struct device *dev)
>  	else
>  		ret = acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
>  
> -	/* @mc_drv may not be valid when we're called from the IOMMU layer */
> -	if (!ret && dev->driver && !mc_drv->driver_managed_dma) {
> +	/* @drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && drv && !to_fsl_mc_driver(drv)->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
