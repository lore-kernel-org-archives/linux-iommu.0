Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F711C8FB5
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042800; cv=none; b=c1mGuMs25E+v/3m6s66sn5JzAc6IHjdfLSl9vrdrj38iOZ0hA351ZddVUAHTyDTKwX7Eydamh+K232R3UkfwYLwFoyYvIUjXk8Tt/lqL8Ca0aPaspT2aico9ytqEQmOPoDrALaZexlQcElXoviKRXNnFxmkcQbP3+BYVzjlFmgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042800; c=relaxed/simple;
	bh=BYVYLOb7g/trPsg04aimiZO3eX+8p1FII3bTfBVJKiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX+VXCRTH2EoZZ/aqUBSUat8G2gXFD8k8F4ekILEOTfjxcLcRm7YHz75+QNNXQGWUkkslJqM9nlMPr+h6LnIWRB0pohhA66knmFwqNlkgI8DUxN8194q/7wSOQqz/RwwBf+KEZV87qeBr5sx+pDgWCpXwBsKGAWMYPUeAWno3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3aaGkOL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3aaGkOL"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c33e4fdb8so2557205ad.2
        for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746042798; x=1746647598; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sS3+hirRuenFYIB7Pzrup/YFqLZ6iZUt0EDXHvDSPdw=;
        b=t3aaGkOLxSYPfcqMFjjDBg8JXSHt1S032U15UHRICuiI3IzAWZCoug67/6IEON4sGd
         gM2f8zzU/q+XjncUyhah9dJPn9DR3s20q/9T7JDCU2ghPu/IPUAzN0O5MfL0h6u8caym
         qR7upwZmZFJsRm4rnduhCgs/H+TbtfiAk/l9hhSpoGaSCpheBcf5QJ0/RQrksfRE8L6M
         aELelX3KUl4MlSb+P1wVCKT5znsGMPwMRN7pAp1oIKJzS96bv7MVP0/1FUymNLCL64Re
         V+6SuYuKNqLi8O+GZNh4/9KNkbEvEzSQKs63+sFzSZEkwWCBhiYazROK75XdubLqTc/h
         bVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746042798; x=1746647598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS3+hirRuenFYIB7Pzrup/YFqLZ6iZUt0EDXHvDSPdw=;
        b=KOY5pNA0jFJC6bT51gHgLgaZeZH9RTJgjiB5R9f7zB8G4xm+Rivg2RlSdeO9uv2paR
         mBf1Cii2KxBth456Ejq0G6y+C7mQmkEySacLxN/le0ReyMuwU9g3muQ5xHkgC5w9ZPHK
         XHM8npEdYL4/4/tei+Gy31JV/dgLoOzyOi9eHKR9JdpjAEjawxgim2bNmAt1u8ogWVq5
         jT5lBO7o8BGuPHpiAuh/cXR4BUZcxD/HOhbDoAzuIo60D2AXs/GHxeQUUh/NwsbS2bfR
         CUKKA792BgAnIi0b+iGtwdCEVxL25/pYFYYANrV03i57Qlkb7jEjWIdh04hWLwiDMPdq
         DQZw==
X-Forwarded-Encrypted: i=1; AJvYcCX2M3C3xJboS97dXcaK7LueQvwSlKB9JHOHLRSnI4+YiX6N1Bwr8S6DELTxR6KSUbAf5Aa1Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwjrPTpWMdYZeq92Bv3aOVu/sObnHWQpKdVlSUy68ATOmkSd/t
	GY0um19PriT7WOq4DClXVOYAEiIE7XeaYa4ylQwZPvweqmi22RqV/D1MfbprYw==
X-Gm-Gg: ASbGncsnXxWmYMdmkPUQfaZ6W6xKNWDpVbJV2yv09bqkcUl8MRbcAH8FYKz5GxFwJQ7
	r1sFq6RiH52si2av67VZAXivVKOdulCKTRWtmuBnJdIzgKr+W737gekwBcl3LnwtRDjFmarKgZg
	aglFKI9Bo03otIZy17RxC8UbLMoaRLaHoOERwtjVKFBGR3eUwpY/g+Dy0FDp57/CNsnlvApuE9/
	gqYrmecBTBJ1K40Aob4GU+vAjxkGYFR0JuUujaEwMSJB95oCnSbA3I80/JKn2gqSylEXLwTPWkp
	rDt9XbbC/qtW6r3OXXLNH6+H1jyLMvf76+ghG0Gu0XjQCSdxriEGbpjxSTgM6VvNyzw6X0FtFDR
	3IyQcmA==
X-Google-Smtp-Source: AGHT+IGcs0gQ+kH9gePUq2IzeHDztkv1kvHGzYIx5as0naNDy5hQJ3XvIttYTvlnG7jSfZ8vALUe5Q==
X-Received: by 2002:a17:903:3d0c:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-22df34ff95fmr71796595ad.25.1746042798140;
        Wed, 30 Apr 2025 12:53:18 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76d56sm126604585ad.4.2025.04.30.12.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:53:17 -0700 (PDT)
Date: Wed, 30 Apr 2025 12:53:13 -0700
From: William McVicker <willmcvicker@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, Russell King <linux@armlinux.org.uk>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] amba: Fix driver_managed_dma check
Message-ID: <aBJ_qfy9cP_m5fSw@google.com>
References: <20250425133929.646493-1-robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425133929.646493-1-robin.murphy@arm.com>

On 04/25/2025, Robin Murphy wrote:
> Since it's not currently safe to take device_lock() in the IOMMU probe
> path, that can race against really_probe() setting dev->driver before
> attempting to bind. The race itself isn't so bad, since we're only
> concerned with dereferencing dev->driver itself anyway, but sadly my
> attempt to implement the check with minimal churn leads to a kind of
> TOCTOU issue, where dev->driver becomes valid after to_amba_driver(NULL)
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
>  drivers/amba/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 71482d639a6d..84bc788663e6 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -353,7 +353,7 @@ static void amba_shutdown(struct device *dev)
>  
>  static int amba_dma_configure(struct device *dev)
>  {
> -	struct amba_driver *drv = to_amba_driver(dev->driver);
> +	const struct device_driver *drv = READ_ONCE(dev->driver);
>  	enum dev_dma_attr attr;
>  	int ret = 0;
>  
> @@ -365,7 +365,7 @@ static int amba_dma_configure(struct device *dev)
>  	}
>  
>  	/* @drv may not be valid when we're called from the IOMMU layer */
> -	if (!ret && dev->driver && !drv->driver_managed_dma) {
> +	if (!ret && drv && !to_amba_driver(drv)->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
