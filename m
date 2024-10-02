Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF31D0DCE
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897004; cv=none; b=lsF0PSwalbxfHjhmgzG1OJ7GNDbbzdHYSDS55yriC1OWO35BcdVit+L37OqD9kKM4brQlC4oX7uNEa255gti21An71Kp6PskbL24KR87XGpfkQV/T10bt152X/7Xv+uZhF2O3c3KRLb8+U5qYHuxqUyVocF7hu6DxBfbxuyteU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897004; c=relaxed/simple;
	bh=wieAkKHXz5kmch/bMkZbPErLsTWAF/iOCaXRH3TieDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXeyQdTzgFdcZaZxSm6Vzc6gQVh7JUL5V0b2sESw80XZjDfrTWwKi1C1WWK0ksRU87ylnVygAz8+u+2CxMitszLpb/IcwgANnLLD/yt2X5BMomVcWpqCGEbFLzgP0Z/xPKRKes+AqidXP0/OMCUf9tzSTFUTBAk0YbT6kduiS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S/1vjq9S; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S/1vjq9S"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-457ce5fda1aso807771cf.1
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727897001; x=1728501801; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezeNyccyU+XqhKx7R1xmsjaB8A6yiiwVf3MRfzffbm0=;
        b=S/1vjq9SfeM6uinFaGxZtZtZkSmryL0g9PbGqZ75hUi+ChLkz+95nPgxuoDaNz2Qsy
         mwR2cu/pLPjaVTIGj+mOnPPlcNc+M+IkAF79KWP+OlBbA5ApQw4/uhb5nS2AVxUlWGEU
         OvyS8b3tFDAfqY/uacVziTRR17tOa3HZBgxA8P4Bd4T7o4GNu9Nc1H41OihICezbnMls
         mplJ9C22/iCLeP1G3r1Xm3ajM9y9rEC6hzmToL38hULRRdLjEhlczuik+hDmeM/u8FLi
         27IEaHA+GTiCp4OPIP03EjgAoexwuT/a3feRjyE1+kc1TnNqoZ94bcHBZfTRs0HGXCYy
         cxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727897001; x=1728501801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezeNyccyU+XqhKx7R1xmsjaB8A6yiiwVf3MRfzffbm0=;
        b=lMpaHz0gSCML9r1jS5Bt3sDV/s3bGkjcbf1xRHVzmRD+g/T6AM9KA/Man+rHvMYzXU
         HqR3IsTEm46TSxDYcoQRnxyHa2Ohf/Q+QlORToPk4XocfC049XsmZoU9ImpOwL+kGUpY
         AVXmi3P4xIunDot9VCNLfVXf2DJYxWub35Hlqj3UUKKzSfI9jm3RG5Taxdg8EelAQKhE
         SB9xWNzGPAINur8uqsCEsDOtuFvRd2icO16B5NMiR8E4du+17QRSXoGVGJ4LzBnTWX7Q
         wBPs10RBin0DTWr/9BWNZj7WDZ57hSA0Yj7MIzhavTzdMOoALIAyykhhgVH/tz+uSsiG
         YFRA==
X-Gm-Message-State: AOJu0YwebL+epFYyhvVyoeIPh4unyxBYQGbNwkvhxp1bKnBQNZL+O95l
	C9/A7AjfVvsSF/iKXAgw6EmMLDWCzY9qLstZMKfZjGQuAhAgr6qqA+7XvC/ndb4=
X-Google-Smtp-Source: AGHT+IGE21N8TG3fex0Wp5gJf+7T6/bOpGdAwmJSH4FIsbMYEmfwtrpJu3TRpSxamSkYPV+eSYfOqA==
X-Received: by 2002:ac8:7d82:0:b0:458:534f:fa06 with SMTP id d75a77b69052e-45d8055bc24mr68128451cf.50.1727897001467;
        Wed, 02 Oct 2024 12:23:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2f5e89sm59568101cf.55.2024.10.02.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:23:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw4wS-00ACeE-Gf;
	Wed, 02 Oct 2024 16:23:20 -0300
Date: Wed, 2 Oct 2024 16:23:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
Message-ID: <20241002192320.GP1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911101911.6269-4-vasant.hegde@amd.com>

On Wed, Sep 11, 2024 at 10:19:06AM +0000, Vasant Hegde wrote:
> +static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
> +						       unsigned int type,
> +						       unsigned int flags)
>  {
>  	const struct iommu_ops *ops;
>  	struct iommu_domain *domain;
> @@ -2059,9 +2067,24 @@ struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
>  	if (!domain)
>  		return ERR_PTR(-ENOMEM);
>  
> -	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
> +	iommu_domain_init(domain, type, ops);
>  	return domain;
>  }
> +
> +/**
> + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
> + * @dev: device for which the domain is allocated
> + * @flags: Bitmap of iommufd_hwpt_alloc_flags
> + *
> + * Allocate a paging domain which will be managed by a kernel driver. Return
> + * allocated domain if successful, or a ERR pointer for failure.
> + */
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> +						     unsigned int flags)
> +{
> +	return __iommu_paging_domain_alloc_flags(dev,
> +					 IOMMU_DOMAIN_UNMANAGED, flags);

Can we get rid of the type parameter here? Like this:

       if (req_type & __IOMMU_DOMAIN_PAGING) {
               dom =  __iommu_paging_domain_alloc_flags(dev,
                               dev->iommu->max_pasids ?
			       IOMMU_HWPT_ALLOC_PASID : 0);
		if (IS_ERR(dom))
		   return dom;
		dom->type = req_type;
       }

Maybe at the end of the series, I guess you want AMD to not have a
bisection issue?

I think this looks OK otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
