Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE71D0940
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879076; cv=none; b=OspfaylEkzJc3kxN2Ik43HLZCwbaxT3E3K7g8s8u0ef656W2U2dKcML9XnYygI76G+U9PhenUgNKKLq3yq3j0D0l1dujdTmyImkOcsGmlrtVNIjWom5LTNwOm+dR6utb4fp3bsb5ms2dvBWK2pBlyXj8VJZnPJRbLK02CwGkd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879076; c=relaxed/simple;
	bh=ZZghFIm4yfzKjbKzPDNIRQ0UjbjVFq7I3x7wnoFu6PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfRxjd/ZMoUiPAwXtELT9C/+ThzMyc4weipdmfJ+HdJtqmgqAdD9cQiNQ2szor80oI/oHQPtm3d6gk/hfpCn9fNq17psdi9Fd+2TxbdjhD/nYUBPhuURPolMQEqVGDUedLK49XPnXXxzZtlS1IN+rTUBDxvjdU6tMIrUOD2FqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=glc+qVNP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="glc+qVNP"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-457ce5fda1aso58472491cf.1
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727879073; x=1728483873; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lwfjmj8R7y2jFVjRhWVoBWp71nLlUSWq2nh2r07cGz4=;
        b=glc+qVNPi5ZCZc11qc0vCtUN0R3Bcf4Ph6XJRqeKcuitKAZ/cRM71sJ3/TFd6Cq62q
         a5ykO48PfB0o+bNTnwNM5sUTl3u2VDmATBbIgT0sUjkldKZt94rII9LcIQ/RbA4FsLWO
         qT3YCBX+Qt+/TMku5v0N3NvCvXyQx4FFcBkJi0LnYWdh+yntAzLhiS2qJMB6hBNLQYsN
         oNCz812Cd4c2+6x93DmDVOYRpLfPp6desELr+47NdqKzCgO7MceifiukB6FlZHAHuF3U
         JqaCkyMmA/Dgk4fAtdNwDyVR6KidEoa7jPx/jFMDiYW/WggMij9NR3ws+fuhC32EqkoW
         eIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879073; x=1728483873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lwfjmj8R7y2jFVjRhWVoBWp71nLlUSWq2nh2r07cGz4=;
        b=n9u52scoKKX/74YD7sGbfg4h0V1JGXX6zjNKp+tUzid2/XevQuitEgpCflNYMxD7MV
         8KolPRCTYCizxwD0OlLJMFFm+ZriCse6pfpvnvHGrPCmCwaXEjWHvuuPXJwav3/IUtCQ
         SqjR7YtL2ZviFoI6L5KQCikGsT+8UmHE0t7O1N109b2qc2T588k53CiplajLc3OXDkVm
         c21YPrAppDtG8o/LCPSfFQQqfGJE0Z7734Xvv7Kda4Zd7kH9QRYHfVe+lpW21WnMmFPA
         bxFuM5ftK3YUKQl1gIdlVEq+7WtnTf2njC0hY98UQdqhq/PJ6u1DloxEa17as0oynzoe
         5G3w==
X-Gm-Message-State: AOJu0YzaNBlaCORqkLOBSDS8LfgFvyYrVfifgLl3AsvxQJcA8QvbZ3Xz
	GW7dIUqoY1Z3lab5OspZWPpW+byb1WQ5JEPoUPl4DUk67GS9+u3R/EQmikpIHYE=
X-Google-Smtp-Source: AGHT+IEqqchHUO2uwERkMxmYrIiA+HZOHayCnOQP7HVW7NFe0RNlWJ2InZtE2+5PmgLCjYfwapRMew==
X-Received: by 2002:a05:622a:1914:b0:456:7fb5:1bdb with SMTP id d75a77b69052e-45d802c6566mr53845061cf.0.1727879072954;
        Wed, 02 Oct 2024 07:24:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f28e799sm56488071cf.17.2024.10.02.07.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:24:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw0HH-009ZYQ-5u;
	Wed, 02 Oct 2024 11:24:31 -0300
Date: Wed, 2 Oct 2024 11:24:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org,
	Baolu Lu <baolu.lu@linux.intel.com>, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 0/8] iommu: Domain allocation enhancements
Message-ID: <20241002142431.GH1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>

On Wed, Oct 02, 2024 at 11:00:32AM +0530, Vasant Hegde wrote:

> Looking into SMM3 driver it looks like some changes required. Does something
> like below works?
> 
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 737c5b882355..4d4af11c5fda 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3088,6 +3088,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  	struct arm_smmu_domain *smmu_domain;
>  	int ret;
> 
> +	if (flags & IOMMU_HWPT_ALLOC_PASID)
> +		return arm_smmu_domain_alloc_paging(dev);
> +

Yes, I think that is good enough for now.

Thanks,
Jason
