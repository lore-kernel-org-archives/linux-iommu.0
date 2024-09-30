Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E90192B66
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714436; cv=none; b=HYIzXZIX+pflBlMOHF7izzAQk+yE0ziSZ49IBEyCyP129j0P1jzP3+yZcCkD9keRmcRlO5+lu5VDyVizsaAR7FlmRmHHr/FCEISYc6T+jLI9MG2sSZ+z/jw6DxlghX3O3T3LBw2tI3JUIt87Dc42SgHilX7j9rxLcZie3w6tgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714436; c=relaxed/simple;
	bh=dSBOhC0bjhbSESR9jo2CyhBJlSFuwF2AEg6p/4dVTQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWGYyBFHZzdq6l6f2qGclaHClXu89PHK5PMaZD/PfzVoxwp/rP3SpQz9Ov71ZXDqCYbu3Z2gIxm+vOdI2rEiRK0aDkTLJO7f1C1gb4kNB61qLVHKLj2u8a5lfZnlR3+oGQaerL1jq/bqNulUKr73QgTj78RSdVVXMQIRJU0ZxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wDfL59+m; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDfL59+m"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-208cf673b8dso46581665ad.3
        for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727714434; x=1728319234; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XrqJ8hHUJyic1Moj+zvtd8DxfNx+7yYXWpXKI0I8z7I=;
        b=wDfL59+mFRm+fUFajbgB65JkNwHFi75l+GvlN+NODQ8bZIP45ZlOFrfslNU7d7gvLd
         47+8H/CKPxWhZe1l/0QsbC0KxI5aMDgNPlJs4R6ZU6kFu5EQKwFUvOv7zkTAuwsQ3Whz
         bIoS+yMVvto3dxBPZv5JJXAMzqW4EAU+qm3YQEXjCIALRZqttK95H46T6JSaBRA1WE9x
         3p1qkjUo3ryQWq5hexcVPsOVnV0YRaP7RPseDxm9pdPnuECYqRX88HG1u9EHSFGvL8CQ
         souUHxxRXwKJIRBeLVlUyiur44vRT8xhq/EQC4hhzhlnVdGw4Q+MDZT7odr5AgblqB2W
         kPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714434; x=1728319234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrqJ8hHUJyic1Moj+zvtd8DxfNx+7yYXWpXKI0I8z7I=;
        b=CpAcjLxWCT9Y+wAl9z0Y39M4IMMKuDl9+1yjATmm+6Z+xxub7WpYg32qELZt3JB0V+
         A0y/W/ZYToj6oUT5SRWaWZ8MTrhJBJX3T2Z631nPoai+zKJb0IY63vWVAu2iuIQ2iwLZ
         G228NTWpCUJQbqy+/mh/GMiUJ3rK0Q0jmSTM8/XgVK3/UvSJIHhxfyaJHlsk6vfna3+V
         +qdIIp6ot8Fb1gWwYdIS1hBU+tE+s5EGCtmfk6UzEOyxog8vIFa4km/fNIN7jQUHkn5i
         ICaUAf2+m/kKc94ktE2LSTHrS9H7uB0BDc4WfwbJ8jSCTUtmRNN3ZsPCvlAAntD8jAF1
         xMvg==
X-Forwarded-Encrypted: i=1; AJvYcCUut7NCAlZVf0Bn1gtUWMFqGSzUga6A4/NHwKOXQd0KproqNrwu1PYu9OFouWkpF0EDC+iscw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpFq5NUKis+Sbk+NTds2UZ74k6Fx98OPdyHx4dCJnh/dCzZYoZ
	DIhij7ZvdkbYU71mJ1rvtmJ6pZslZS2DSzdyo6NpKitWSrtzSpiy6lmfz5oDJuk=
X-Google-Smtp-Source: AGHT+IHsTS8iXYCxVVG4r6awYj1PyZMeOcTmX8+hwB7h5vhx6IxPbluJrOvTMvtp8iHvvANjKW2aAA==
X-Received: by 2002:a17:902:c40a:b0:202:1bb6:1897 with SMTP id d9443c01a7336-20b367e4b7emr217898405ad.14.1727714434128;
        Mon, 30 Sep 2024 09:40:34 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6561:7ef:acea:822e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357e8sm56058175ad.187.2024.09.30.09.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:40:33 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:40:30 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	linux-remoteproc@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
Message-ID: <ZvrUfoTM6s/jv9Nv@p14s>
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812072811.9737-1-baolu.lu@linux.intel.com>

On Mon, Aug 12, 2024 at 03:28:11PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in rproc_enable_iommu() and is attached to
> rproc->dev.parent in the same function.
> 
> Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/20240610085555.88197-13-baolu.lu@linux.intel.com
> ---
>  drivers/remoteproc/remoteproc_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

I have applied this patch.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index f276956f2c5c..eb66f78ec8b7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -109,10 +109,10 @@ static int rproc_enable_iommu(struct rproc *rproc)
>  		return 0;
>  	}
>  
> -	domain = iommu_domain_alloc(dev->bus);
> -	if (!domain) {
> +	domain = iommu_paging_domain_alloc(dev);
> +	if (IS_ERR(domain)) {
>  		dev_err(dev, "can't alloc iommu domain\n");
> -		return -ENOMEM;
> +		return PTR_ERR(domain);
>  	}
>  
>  	iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
> -- 
> 2.34.1
> 
