Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257691EA84
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261390; cv=none; b=ri56TP4aIGXuoolVFE7SQug8HcXsrSXgs5GFxRxizAo6dg/SdWzlBYWCL+W5gcgNklF17VZzuCGk7N7j5fKznMGODq08kS4SJ36LtafTud+zo2nvBLBF4NxK1zsQtPyJMP+nGpzqr72XwO3Zooe/TqFq3S64yJg/a6qNpXtaWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261390; c=relaxed/simple;
	bh=+xgnsJdIrvkGtNG+c/m5IB9KROFlfbKpSKnQQvqbCkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awATOfe0REnXAkqrAk68VBxoD0MtL2dnhgEYbjGVGW7nW0xR/zqJtSJlTZSE40Yn40qtFWLBxbkvbFlZKn+WBQq85IOq8zpY2D1RZc7MBT3vG2OSdcP5zKZJT4nANl1UqVDDO31VebEMlmP5UZfM09y4dQoqSnS/zBSYymAMy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l6En22Wh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l6En22Wh"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460963d6233so12697971cf.2
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729261386; x=1729866186; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ykq/kLVRAWgSmDXmjptJTmVz123wTRXbkPQc4KlzRd8=;
        b=l6En22WhUnPOALQYzYwRJSHcg6AyG7uaD9WbV+SgE9AUhAaWNWVzmLyi14D6xqy/4z
         IPGljHJoZaBAvDJJLUGuQcYMTw0bbk1n1ockpovV52eaGZo8E3W+VmVdUQ9hcELG2i79
         oCpeqXWBMS876KLzUZSVDBbgCdRdp22l+bM6FQ1FmyEgKyBMXmPly7k8AWNkuuX8tXdn
         CvWYB96usvgLXiBktyFvreHB40oC8ThNBm0DkJ1IA6OqfLo+qIJHHUm3GLlKLlR7byVD
         3hYm+Id6DygHDqt9pmI7MStle73Qlu5e7XwmD6fINwZanQvn71P/+zB5/x+p8UaPsgyL
         tC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261386; x=1729866186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ykq/kLVRAWgSmDXmjptJTmVz123wTRXbkPQc4KlzRd8=;
        b=IpAvzl7UhPKtZw0hbShFWvpje9fmOc3gAXQhMHdEHbWPtpYb+II3slRkteAwDqQacj
         Zx6q4Wf/5qbMarANEX4DAthrg8j/jk7XKy87lXadJpGRAJpWw9MGxKuvM4UrfcKeJh6o
         xTrrc6jZFGRqKXj2Z0mijQCevNfQW1HotuGm0VTEC88eYpnP9iXCEbvPW7bB8JPFr4g9
         GHoP9cTO3WNoLxXWA44ju0JrSqSGOMNnmjc9FMcL/wJ/ah3O6Iw5ixaA15tg8CTObTK2
         aG2azXG/RKXVhirCsM34vvmP7eXMFkD7/eG3T9aUFK7eRgrgiKHTC6Q3PERMQfSD7RoZ
         AdgQ==
X-Gm-Message-State: AOJu0YxPgvf8innfOopqjXJaFtfgyplm4v4rIBau1Sg4mL99XGPC4qsT
	AA8JQP13ld/tZV5FuIWK9XNzA/XVzNDv/MfUNSqhrh7nyMn6kf4rMHESDed7mmQ=
X-Google-Smtp-Source: AGHT+IH45zETLBVBqNMB9pBdtrKbALI6CHuUd7Rzb/bBfMF8Aqa2hZAZ0CF+wNMVRhTrQn6G1HEq+w==
X-Received: by 2002:ac8:7fc8:0:b0:460:400c:c436 with SMTP id d75a77b69052e-460aee5ff9bmr32142421cf.56.1729261384460;
        Fri, 18 Oct 2024 07:23:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460ae9956cbsm7732181cf.47.2024.10.18.07.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:23:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1nsd-008CRR-Gw;
	Fri, 18 Oct 2024 11:23:03 -0300
Date: Fri, 18 Oct 2024 11:23:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 04/12] iommu/arm-smmu-v3: Enhance domain_alloc_user()
 to allocate PASID capable domain
Message-ID: <20241018142303.GH948948@ziepe.ca>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140137.6028-5-vasant.hegde@amd.com>

On Thu, Oct 17, 2024 at 02:01:29PM +0000, Vasant Hegde wrote:
> Core layer is modified to call domain_alloc_user() to allocate PASID
> capable domain. Enhance arm_smmu_domain_alloc_user() to allocate
> PASID capable domain based on the 'flags' parameter.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
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
>  	if (flags & ~PAGING_FLAGS)
>  		return ERR_PTR(-EOPNOTSUPP);

Swap the order, it needs to be after checking PAGING_FLAGS and add it
to PAGING_FLAGS so it is checked.

Still need to reject bad flags.

Jason
