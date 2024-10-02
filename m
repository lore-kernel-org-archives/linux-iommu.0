Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E6130A47
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897630; cv=none; b=cuOmOt7jzS9tun9tOit1UCg3WAH6bty8MlHESESOhAIiJ4YkpHaTLKIEPOcJ1fJplHODvINp/7RmCJtwIFsPAVUPPG3c/ZrQKkkwmu9k+48DaueclFw73IIiOUZtGi9vbYwg6cIt5a3NeBC+L2QhnXbrIAfl+goumgYpDFhM6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897630; c=relaxed/simple;
	bh=yEnBPEoOPoPLZBsPtgT3LUlQujXIzH9xefvyP0AG7TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPqF0t1Ptcc+aXnDucpkYku4lr9nhMlU1TGMFJfX/6r30106y3RqGgo42v6aPb+Ecnz01j0PU5IWYpoTnJUopSuZjyoznsb8Tx7fy74NN5ocW9TFegH4NyY6eFYZbsz36yFybhFYNluSC3t4kd3knekkmYf8zwjGge/pHSKjRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mupP50gG; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mupP50gG"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9ae0e116cso15675385a.1
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727897627; x=1728502427; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnW/DLA2i6A4Ts0vtfqNmiK9mVk4FJXQk/7i3MsWVew=;
        b=mupP50gG7ixptXHFAIZOVCw7AxOA/FVTiAqKe02GolXX9Gmt11D2eknkuZ+3eaAg0E
         /uNTnrvvB7ZnEYc4TjcRWRfSFfQjdL1WVucOv8jD1HDV10Y535fxloUSb3nixbKdEMki
         FBhXQniNM+tnySrHzlvDrJ+GlOVeek0y6n6ktrCxNnO4hjx160eQEb4P1cPxaMUGkOeg
         4HVWXOGsNrb5FPttsm+qLk/GC2s07ZI4D1F7ftk4d0XpWC5wOVDzO5/I0u45W9Xt1tuT
         ODcwa3agAEPVTJgpn/3Q1T2o7Lyxkf4YPtyG/NXB31BarkB57PGbmKuQgZt7lezZLRiS
         jQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727897627; x=1728502427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnW/DLA2i6A4Ts0vtfqNmiK9mVk4FJXQk/7i3MsWVew=;
        b=TBmdYwpsBOo1Lezdk/1YXx30wYvAozTr+Ay7hy7GiNCz4lf315Xll8Me0zOhrOH5/m
         hmKmufYv7oSu7uXT3DeXez9JQWgOKcBloPEjcreT1k6FVHCDKmTYj9YJ7Km0miL86aQ+
         WtuTBQDvA5kmFDvAiODS+8rKq/mnihJaHcRZ7K1JZq3Cx6KqblEGQyZUEVpjbZHvJYkz
         QbTd/r81eftrSX06xXiijt/a3oVFbbCjPmlXtf1tqwgLctY91uBeFUMLP4VmMKnVKU0D
         LqiMm11/CDuBWSdz4qehBmYP7ojRUussaOFVEc50oDxBUb795O3jD13Q97Cqc2SAgYXd
         7+hA==
X-Gm-Message-State: AOJu0YxSIt48HSTHuQbKV8k1iLniWdRqaBTbDajiWU6IUdoDjZMSYzQu
	UFaNYIL1RGplLpINl2JGDaqLqJGvr13BAdpm3H2+NorhMYCYUz93NpPMyrVUyLM=
X-Google-Smtp-Source: AGHT+IG1v6D5hzNFN3uldmNVxhI5HEgiJS0TnB5egfoZgaD/9X7ZQRN+4NxqH0jf/piIq0+khJaYMg==
X-Received: by 2002:a05:620a:1917:b0:7ac:a077:6a3d with SMTP id af79cd13be357-7ae626b38ccmr583705385a.10.1727897627401;
        Wed, 02 Oct 2024 12:33:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782b926sm649708285a.87.2024.10.02.12.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:33:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw56X-00ADYU-U9;
	Wed, 02 Oct 2024 16:33:45 -0300
Date: Wed, 2 Oct 2024 16:33:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 7/8] iommu/amd: Add iommu_ops->domain_alloc_paging
 support
Message-ID: <20241002193345.GR1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911101911.6269-8-vasant.hegde@amd.com>

On Wed, Sep 11, 2024 at 10:19:10AM +0000, Vasant Hegde wrote:
> Add support to allocate paging domain. Note that core will call
> domain_alloc_user() to allocate PASID capable domain. Hence its not
> checking device capability and allocates page table based on
> amd_iommu_pgtable.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 1c9e539f15a7..e6b4460c485d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2395,6 +2395,16 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
>  	return domain;
>  }
>  
> +/*
> + * Allocate domain with default (amd_iommu_pgtable) page table type. Core will
> + * call domain_alloc_user() interface to allocate PASID capable domain.
> + */
> +static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
> +				     dev, 0, amd_iommu_pgtable);
> +}

I think you should avoid this. The _user one (aka extended) should
handle everthing. It doesn't really make sense anyhow, as the legacy
VFIO path is going to take this branch as it will have 0 flags.

Can we just get rid of amd_iommu_pgtable ? The logic to do feature
negotiation with HW support needs to be embedded inside
amd_iommu_domain_alloc_user() anyhow

And the two kernel command line options seem totally useless now that
we select the page table format correctly automatically. As you've
explained the v1 format is always better.

Maybe the kernel command line options should be revised to force ONLY
v2 format and ONLY v1 format, but that still wouldn't need this
function. But also maybe they should just be removed.

Jason
