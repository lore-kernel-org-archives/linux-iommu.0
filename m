Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B52AF19
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519910; cv=none; b=rWB5hLRp322G0P94f+5Up4VRK2j+30y8ydPVVoaJ2q5zV4HWCKnOI2kl16dp4EebN4grcglqbTBG0afHSqZLqWA+q+iziU1mmIB12ogZL9oMHYbQa5bpP3jsoMYqw72kngiXU9s3VwmA5NN7rcK590QIM1FYxqSyc8g01k3mjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519910; c=relaxed/simple;
	bh=/gbhEWGwhC/N9t3ZntrfKjb94teayzC5Ct4eUgtvJyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLTDZXmOWtczvl6bddGI9ArsvpQipI4bTk9+8hWV4ljEGQ0y5llEoy6dy7brTLAK/O9Y68I58XtwKUJb1GWs4RcYwzzVq8cfJW2P8lyI/U19E+Gq6qE9xULayscpK87zlTPD3V5GzBcq4JA+W81G6CM6Rx0QvSl+2QeDzy2Go/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=leubWtNB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="leubWtNB"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6a3652a732fso28580226d6.3
        for <iommu@lists.linux.dev>; Tue, 04 Jun 2024 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717519908; x=1718124708; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHa4rdBij7iNJpe66g86f477UY9nlCjL0qAGcR/g8E0=;
        b=leubWtNBNQSL5TThYIT4dSQKY82Dyp/OYIQE5AsbTfMwF38U2As4Chm9BRBhIEHhIg
         gegrluotov8LW9yokLPUsbwknSEr3pPbQOtq0M+PQPaW1R5I8oXGKFdzv2tvE4e4SEdb
         6kq4h47goAqxZ2IXFg4r9GSekx216NDaoL47mfKPLSJ4d3Toaibs6/YFp3E3JjoN/r6d
         0ftH+SGo+9nbDmjeFwkG7qfPEsn3mZ2zZm2HIZ4nBbBGKIgB6KJRJkWdDw5xS6iSobHq
         EMQxSbyzXsJz+ff4l3EeiymbmuMvehf7hCitFu/ZFpby86a19exphTPtcbHuo2nst9VM
         aZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519908; x=1718124708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHa4rdBij7iNJpe66g86f477UY9nlCjL0qAGcR/g8E0=;
        b=mONrOBgos5Ml0TJdtqyLz6q90uLqPen1hi/kbLbM8+UDDm+f0KPUX7EBjcNknSAiAg
         Ag39NIcm+Mxmfsu/IFUurEe/SnvQo3KL/xOvfQqk1IVtJGuMsYnpXnOjU8JFxMyl24qC
         bPeggEQ93shSl5ed7LomFclZyDrY+2jKdDE70DkuVzaOGN1hMSR41g0Q9uqYCae8DRsl
         G5X/K2n4GYx5VsO+/tYiNTbUfEhwTJeAtdpMdZjT6k+AZqzZy6RFO7oeNyPizOYvDiG8
         BbvkkJfdl9fab5cl5Shf+UwJLAK4X/zgPlN+0yPBx5E+JY2HMqR3PtbNw5f9o2kYFKon
         142A==
X-Forwarded-Encrypted: i=1; AJvYcCWbokFbl1YFboTqpvWuEpfRg+lQSKKvX21MNWCL+vqcRt2wM+coXxzoI0zdYAAgCGCOHW5Ov+K/w2znkPQciShdD1R4E7s=
X-Gm-Message-State: AOJu0Yxp3oMaDzeXx0RWBLgKmzMH30Em1fwAADNnnmbtxy3rzsy7FYgu
	L6YwvmAwBegK9yo+EmybLtSxVsVU72uyQxfBtqnDqeBz1GwdN6xIEnGoXlIc+kA=
X-Google-Smtp-Source: AGHT+IGwn1k8sp+tDvJPbmVwjnFqtNhVBCqRYzi+miJGltF4eG+Bl2fD0Av2bC2c9STAhnkW1l81RA==
X-Received: by 2002:a05:6214:3906:b0:6af:c6bc:bdc2 with SMTP id 6a1803df08f44-6afc6bcc442mr50551886d6.28.1717519908248;
        Tue, 04 Jun 2024 09:51:48 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6af3d644efbsm29212786d6.19.2024.06.04.09.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:51:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sEXNx-002u7o-KW;
	Tue, 04 Jun 2024 13:51:45 -0300
Date: Tue, 4 Jun 2024 13:51:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/22] iommufd: Use iommu_user_domain_alloc()
Message-ID: <20240604165145.GD21513@ziepe.ca>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604015134.164206-3-baolu.lu@linux.intel.com>

On Tue, Jun 04, 2024 at 09:51:14AM +0800, Lu Baolu wrote:
> Replace iommu_domain_alloc() with iommu_user_domain_alloc().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 33d142f8057d..ada05fccb36a 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -127,21 +127,11 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  	hwpt_paging->ioas = ioas;
>  	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
>  
> -	if (ops->domain_alloc_user) {
> -		hwpt->domain = ops->domain_alloc_user(idev->dev, flags, NULL,
> -						      user_data);
                                                     ^^^^^^^^^^^^

> -		if (IS_ERR(hwpt->domain)) {
> -			rc = PTR_ERR(hwpt->domain);
> -			hwpt->domain = NULL;
> -			goto out_abort;
> -		}
> -		hwpt->domain->owner = ops;
> -	} else {
> -		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
> -		if (!hwpt->domain) {
> -			rc = -ENOMEM;
> -			goto out_abort;
> -		}
> +	hwpt->domain = iommu_user_domain_alloc(idev->dev, flags);
> +	if (IS_ERR(hwpt->domain)) {

Where did the user_data go???

If you are going to wrapper the op function then all the args need to
be provided.

I'm not sure there is value in having vfio and vdpa call this
variation since they won't pass a user_data or flags?

Do you imagine there will ever be a difference between what
domain_alloc_user(dev, 0, NULL, NULL) returns from
domain_alloc_paging(dev) ?

That seems like questionable driver behavior to me.

Jason
