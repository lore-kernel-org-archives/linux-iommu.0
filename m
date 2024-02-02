Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38550146900
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888193; cv=none; b=EjJz8wleHCQXRgQoosy8H5VuzoqkIjZYVKBr8mdmPPIQ0Gm3iskAW3J7rkt+nqylkdcVbQxdISuDZzdquLQaP+ses1uMppl6ymeC5muvcEu+W2oEo9fMPJRCrM7nuLnM05gln7/yrSoWSQ3C5lMRDfOQmgP3q9be6mo+Sx6a3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888193; c=relaxed/simple;
	bh=Fg0vF/DKGnFKdPAxtNJWEsCiIanMISLov5rth1azicY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuYh+gwsS1Ha1N1QnLZN0QB8vKfwa69qxzTomvFE1nX2W7Ehv0xEsP/VEHid6A5JXEzf1JUoELErDCeF6UtV1U6JZz753LUX54Xa1KYVLx691T06elvZddh9twHdC42RdjMMS6Z9LPRfq4A/15nYgKT9udr7JoENTnHHfZ5G0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gUV4K+nf; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gUV4K+nf"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78405c9a152so147578585a.1
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 07:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706888185; x=1707492985; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRSa4TT8HVH8576bDhqIPmdbLRM9nyjGP0P+K9geus8=;
        b=gUV4K+nfLi4hF5jkcme6NqI9tAGM/0NFMQpgERB1/tfGikTSHeXsTkzW5X4mefnuot
         iQU4LsB2JKtAfkY/wsmDMw6smenCuDNdUDqn0MrHygVXy+AvfZTGf8OlaBRvcBKxQlIb
         SGOvjF0VqJOv2kw6RxDjnSqVvdQQljHSEDUKtnMxQvhBEJjn9TBmHocyg9hL2enXzcOJ
         4VXEDOw4xHzNVYxCrAJywtuw80sLOtLdZ+B1VEYy2TAlJ1wovfIigsE4xu3J9+aUeF03
         mk4BGxSq7GACDD7l3yd1i0pFOrGed4PjS89UJwl9ji0wtCZD7GUDY0gFJGI+M+jTatjD
         j/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888185; x=1707492985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRSa4TT8HVH8576bDhqIPmdbLRM9nyjGP0P+K9geus8=;
        b=aOpbMahvp/iHdSeVFeThVB1F9wwh04nrLfhLdp6XIAZhJJqBKp2XCVQqZm4VlE7fl3
         kKh4ImIrOabFmbjKxuWwZukEvM9t2zTOdVXVcYKfruuNAfne66BRSdVnnTNZtNko3nJt
         ZiF+JQahkTeBvPVPmQ6yj48bAzfxT8lFXK9xtR9bTNJAdcUrem3eSxuWgOyYZ00/SJsm
         463XiYb2G+y/ILF6bUL2ViUC1jtr7Qz0ogh83a7wCKIwjPp+EalYe6KVPJH0u3rYnko1
         OgiHkNLmrPV3bE8VbjdPILvL6hTAdxZ/4m3NbTo36FgHFB57Mh91JWByPXx3Z3tFXqhK
         5zNA==
X-Gm-Message-State: AOJu0YzLh+nV9gIVVACPwh0t7WaN/ariQzOmOS1bOKjnNaoSSAscx31Y
	ft0GvJG0NAhrVt9wPvrU3d3YIvxbN5+GibdE8a/Y1jNgEhsKG8bPyl4nm2Rlt9ljpREvtH0/WES
	r
X-Google-Smtp-Source: AGHT+IHgoLTjDGqcVBJHeDO/+4xepghxs6zy3yXbqAEo9+eksg5MPspO+NnPRp35JWUiTkmwcplNIA==
X-Received: by 2002:a05:620a:1447:b0:785:43d7:cd0d with SMTP id i7-20020a05620a144700b0078543d7cd0dmr5503107qkl.27.1706888185060;
        Fri, 02 Feb 2024 07:36:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUFwKseQX4Qsq/U7oliva32huh0WpnlP9H2RmmN32JeZGOlrWJLaJZWLc9ppObbDwYDQV4sN7pUUZMCsO8tSFXSQJmcRGn+0ufquLHbJD1n5fzINj6sjjJv3dkjJOrN1QEsZiBVWFkYzeqnXqMwOqEHyIymkSi3B0oCOc5x9B6RE9X0hh8jrCLAS/PANjfoSo/rRgMRJGBcFJUCufODDCXB9jPLvby/TOw6PDi/PiXXaNWf6dsKiH+LDw3kiKrGVwerK4/DkUHol9QZWPHWp5Omyx0ca2rOvsUYk+OUWtuGlc7B0eOG3a6RzgWhdK8dYHm0gscYJwdfLAiXXgZ7SzzLyziu3DsqSb/YsxwTsJLPwdREaYfhXn96czeFqnVrIVcsWxSSIWpVfPCraGXpvS0VTC8bFw6Xzg4VBcDrwgor7MFt03tk
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id vu21-20020a05620a561500b0078552f53b85sm724769qkn.86.2024.02.02.07.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:36:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVvaZ-00AwH2-RL;
	Fri, 02 Feb 2024 11:36:23 -0400
Date: Fri, 2 Feb 2024 11:36:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 15/16] iommu: Make iopf_group_response() return void
Message-ID: <20240202153623.GA50608@ziepe.ca>
References: <20240122054308.23901-1-baolu.lu@linux.intel.com>
 <20240122054308.23901-16-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122054308.23901-16-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 01:43:07PM +0800, Lu Baolu wrote:
> The iopf_group_response() should return void, as nothing can do anything
> with the failure. This implies that ops->page_response() must also return
> void; this is consistent with what the drivers do. The failure paths,
> which are all integrity validations of the fault, should be WARN_ON'd,
> not return codes.
> 
> If the iommu core fails to enqueue the fault, it should respond the fault
> directly by calling ops->page_response() instead of returning an error
> number and relying on the iommu drivers to do so. Consolidate the error
> fault handling code in the core.
> 
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h                       |  14 +--
>  drivers/iommu/intel/iommu.h                 |   4 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  50 +++-----
>  drivers/iommu/intel/svm.c                   |  18 +--
>  drivers/iommu/io-pgfault.c                  | 132 +++++++++++---------
>  5 files changed, 99 insertions(+), 119 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

>  
> +static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
> +					   struct iopf_fault *evt,
> +					   struct iopf_group *abort_group)
> +{
> +	struct iopf_fault *iopf, *next;
> +	struct iopf_group *group;
> +
> +	group = kzalloc(sizeof(*group), GFP_KERNEL);
> +	if (!group) {
> +		/*
> +		 * We always need to construct the group as we need it to abort
> +		 * the request at the driver if it cfan't be handled.
                                                  ^^^^^^ can't


Jason
