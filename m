Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E432746B
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261450; cv=none; b=s9cCYOIC8crOF8V/6rXOR8N6I4RIJg0GaTA7vVjZ+knoncF5d1ktU42qC/kGmAqUTFIFJ+6zWbf34loz3vb5JpB2DnFbKY7eyPHplEK3r1xPhwCRnk7HcU6GfYoKsTgPBe5IiQMchjIcyFdnRlNmG3uWH0N2nHNrN0p+7hjVkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261450; c=relaxed/simple;
	bh=Y3Xk2AFg5KB0+6ooVhMdHIRUWT7dnZQ8YUWLwZLi07g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr2e9SwcF+0SVODuKaw0TUT4WI/DjI5n0G7fh9Qt9rapsBDziI6UGlJ+kzVMSMOtVyD0pD1Wvq5rIUT69V4xTnYvFuUvzN3f00O9ZSnd1dl8durPRWxN5HVzY17d6ftYgxRBes3OdmrDi24Jag+67+FvS3Agc/9H/EXPBvLP8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mmLQtTAa; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mmLQtTAa"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso26237256d6.1
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729261448; x=1729866248; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pH930ONvQS3wtHeH5Lfs0QymIDtF8UOTDValaYm94J4=;
        b=mmLQtTAaY+r1BI4MnUFnXfHOU2+lQqGog/ZHJvgdwnkZa4iIVmnMYARi+717HDoOg1
         sXgcFoROlXWKO/8jH6fXsd84dHPWXowhADjQP2K7USiLSXAl24MN33rbq2MOzvnDmOMY
         EwehGgx/1JU8q+FmQpL/cWTdgcP8v71OoClHeRa8Up9GobUmppp+X+oakKP5stmf8CAj
         P6O36tsAj+ftaiWT02+sY661lIbMxCeX6Ym2ESATI4eRnKaThSZEK3Tz3eoMTP3OXU7c
         M/ItuMhdlS4SBMFivfKJiBmqkM9sRPbBj10rnXG8HfuLVDX8IMREqsdZw3/7dVvOr5Fn
         wE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261448; x=1729866248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH930ONvQS3wtHeH5Lfs0QymIDtF8UOTDValaYm94J4=;
        b=d2sc5RrlyJOLJE+HlGkOmis8/x88+Pp5aX8t/VHDnAauCCgYQgS4dt1m1EZTZk4VqN
         TLOeGAzQSRIdbcDVjTWxwa99Mzv57KLzJS5WeyBrHG/nXq9o1oNIkYw0ESCz2/5kyExT
         AtTrN6dCUC4tJoAzqi7keB6KToWsOu9k6lmMfHitw4A31wjDg3ZSXivxXOF4BBhPlIQf
         6avpI3g317QrQ0pDafPbod1Fze2iYm5o1DFwleSXtGBm46gvtTbWEKmTYtoROdFC3Zn6
         1BGbubZGFj3xc91MBWD+060fE9w8y1cr1IApqGDwkb8LV/py1FS6MSNuOcD691DbkQdA
         YP7Q==
X-Gm-Message-State: AOJu0Yz9ZeZMo598xDvdRTZZ5XbmvwnkNs4Z2CiM7FqI9ofdnfDT+Oat
	Qbhn63ODVZdYzFrV+TrKjR3xWE52+dz4bX6A6UC58ADS6ZZvUlZXXeEri9NDyIs=
X-Google-Smtp-Source: AGHT+IHA0DOy7MABhW9m3J+ItltIEdLwjES1dFpiRnHNcxVStMsMGUPPQhx9mUHZW3C4P1BSnlXnNQ==
X-Received: by 2002:a05:6214:1bc9:b0:6cb:5bde:d78 with SMTP id 6a1803df08f44-6cc3781c3b6mr114444256d6.3.1729261448150;
        Fri, 18 Oct 2024 07:24:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460b818e356sm1834351cf.69.2024.10.18.07.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:24:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1ntf-008Cig-8F;
	Fri, 18 Oct 2024 11:24:07 -0300
Date: Fri, 18 Oct 2024 11:24:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 06/12] iommu/amd: Move V2 page table support check to
 early_amd_iommu_init()
Message-ID: <20241018142407.GJ948948@ziepe.ca>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140137.6028-7-vasant.hegde@amd.com>

On Thu, Oct 17, 2024 at 02:01:31PM +0000, Vasant Hegde wrote:
> amd_iommu_pgtable validation has to be done before calling
> iommu_snp_enable(). It can be done immediately after reading IOMMU
> features. Hence move this check to early_amd_iommu_init().
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
