Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1D81DC9B0
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042853; cv=none; b=GUNFiTehnuIwzyLfFiDLJlc8Ka0ZCZMHxm4krTEHGWZqsgKGAUWO0hMjQ7mrd6E+4WZpIkvWsNxxBLHy3T8bA37WSOdHxi5xU1mt9FQxDQJl7MT8FHZGGZZ+hGs1Sa8TUNGkob8Ij3ifXCDLu3DAtH0SbXWj3Dt0jI327H1O26U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042853; c=relaxed/simple;
	bh=3yap3ZzGTQYZ/vtwqCQHVg5FTg1hill/s2XBdCCadm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIHiQGs71c4zY4NraM/wYib/fcoeGEtLoJwvbFNifTJWTbhoeGvLLO61SxmDGhbx+RRjjDLU/47NP6d/4d1lwl0w+SkQj8Erx6Kiqqk4bfcv/w0M+ICnkO89D3j63wHqQvXaMYOM8LA4BTxrjgWz3FuYR7SnUd+pglT6RawBRCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGI0AVV9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGI0AVV9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fb0f619dso3027215ad.1
        for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746042851; x=1746647651; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8wD0px5HjnR5pxkOK8NrG7Fm/ol5rI8jfr96COPSAI=;
        b=FGI0AVV9GpXiUzzZGkfOcEL5JkuPKq0e713EIklYrGyl5TcyIBft3ie8/HeVQ11Qy8
         9zrsvLS+oSo2PVBQBRUGsKg+e/tyL7uuvc4PxhqvHByQHJyHDKpA0cGu+yfqx9B94fST
         j93E3UEFLde2H0WW3voeUQekqG/KklmTdxqIX0dYqoIuFJTZkyUOxCMxaUgkIBJWEhxJ
         9xZiBLQr1C1BOAynZlPESaODsY4SHDVZq4QilLSBIwczIYrSdwahpeARP/XE7MK4vw0m
         535/K/7kx8gGb3Prz1lTfi/Z4XSRYGaXZDOnjDupl8McvjSmN8CqD5zDfElwWwUoswMk
         H5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746042851; x=1746647651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8wD0px5HjnR5pxkOK8NrG7Fm/ol5rI8jfr96COPSAI=;
        b=IrbzHa/bdobMx2QiX1Av2jkNjOm4tS/ibSlNfqaOAZe8h8bvhcfDcb35oRBxKZTWm9
         UqfRlh8M56WiE49X766qiKlDPIuICEn+8V7TBpPKSgANa4iothtHzQwm8BBv8OkR+9rm
         xzhfgEtQl1Cqg84JnmlMP5vMlmg50lGQrkC9qQ0pFGYS9zSE8sSs6BJSEB5/S3MvARf1
         nRNY04MNQ3HfC9CDFifFnG9X8Gg7XxP2HBdRxRwKsJPwbvhZ+3GBGaam9/HXxo/3lIAu
         PBDljNAemkUqHq4o+oL0rfPhLUA/9iwsI/Jdiv//E2GsoapGEqHbmr27O1T47MTwmFHe
         ercQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyPS3zSWGG3uaqc+qBhU/WmPxkwxCTv0Oc1ffFIWqitcNW7Zq52X9B20k4NoCGuQBCFt375Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzscsL8gEyMFTmhO0mdWLXFwassFga8+8Vc6Uh3oMKFIHklSUK9
	QQVus1T37hsiLimJHIl4HjpnokZ70w9xFiup5yBj3mrSurgCbq65U59xuUGJBQ==
X-Gm-Gg: ASbGncsV9PqGHqOUcXdAKraEfctQJsG/VAACp0alCNsmn/+EGjPK/XRAIDrOVKf3bDX
	CVQe8qCQwvo+7qRkETDlCsNjF5L3f81mc0BJorGiAhQBHlDdaqs5eje4YPnLDmm2si+khPGWdt0
	VZJt3yJ7XJpysWPJltJh2ARix7SOtXfM9rAYKA8PVWKxVOGLWf0r4FhVw/tp92YLI3BuKHEBrGe
	IuiHdnOcm23nFHgQxffZZgS2jCSLRi3wwI495Ff/qKdpsqvWkLoS3JxHsmQxea5sTFhKwXbDxy8
	tGtTtwcLpHej6DZSvdz9sZ5ecqpkp2LBqCtqThUPjr1bvK2qs5o13doL1biuil0zVOG+hD0Jii2
	MHWGJPqZVIZaAbbwi
X-Google-Smtp-Source: AGHT+IGuD6kTALubXNZirfBTu3m5HhSSf+bNLb+HyRwsXYMZcmIJMtVfVYD/Pd6uFMOtp50fXulIWg==
X-Received: by 2002:a17:903:2287:b0:224:13a4:d62e with SMTP id d9443c01a7336-22df3590c0cmr73354905ad.35.1746042850758;
        Wed, 30 Apr 2025 12:54:10 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102d31sm126707425ad.198.2025.04.30.12.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:54:10 -0700 (PDT)
Date: Wed, 30 Apr 2025 12:54:06 -0700
From: William McVicker <willmcvicker@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdx: Fix driver_managed_dma check
Message-ID: <aBJ_3qI6WRXpJ3SL@google.com>
References: <20250425133929.646493-2-robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425133929.646493-2-robin.murphy@arm.com>

On 04/25/2025, Robin Murphy wrote:
> Since it's not currently safe to take device_lock() in the IOMMU probe
> path, that can race against really_probe() setting dev->driver before
> attempting to bind. The race itself isn't so bad, since we're only
> concerned with dereferencing dev->driver itself anyway, but sadly my
> attempt to implement the check with minimal churn leads to a kind of
> TOCTOU issue, where dev->driver becomes valid after to_cdx_driver(NULL)
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
>  drivers/cdx/cdx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 092306ca2541..8aa92a198b71 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -348,7 +348,7 @@ static void cdx_shutdown(struct device *dev)
>  
>  static int cdx_dma_configure(struct device *dev)
>  {
> -	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
> +	const struct device_driver *drv = READ_ONCE(dev->driver);
>  	struct cdx_device *cdx_dev = to_cdx_device(dev);
>  	struct cdx_controller *cdx = cdx_dev->cdx;
>  	u32 input_id = cdx_dev->req_id;
> @@ -360,8 +360,8 @@ static int cdx_dma_configure(struct device *dev)
>  		return ret;
>  	}
>  
> -	/* @cdx_drv may not be valid when we're called from the IOMMU layer */
> -	if (!ret && dev->driver && !cdx_drv->driver_managed_dma) {
> +	/* @drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && drv && !to_cdx_driver(drv)->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
