Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881E1547C1
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258454; cv=none; b=j3iobeu0wX99GVMBUuoQDVSh6AE3HAC05Kkmdqf10Po0x1QCNDU3HdsK5xjn3tmve5GVjlcTYAQ+0CNNONtGGWrRWnuhJdBkyDhpEkyx5WK62HnlD9CuE3fNMqjrNy4m29f4qycy8guZjjrGWavBrtBUddgfzgKFSMBGCIixfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258454; c=relaxed/simple;
	bh=ORHJFmQhOn6XaJcKY3kF0iElztaHzLKc89Z3oO5mWjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOUfDTwSuxP/UY+MNo42G8MnT32/1grY4/Or2UlP6g635JGF/tQq6pFGA+ZekuuvyT6hV4xsM5QY41K4xr5ZKCS273kazK1O0hkyc4Lpokt7iN+m5a3ZmY6g6cIxTBFK/8lcF/3NL84D3m3VgnwyqXfFCZq9UmmfNvzdz2pIcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XJy9BtaP; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XJy9BtaP"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c159150ff4so4438026d6.2
        for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724258451; x=1724863251; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1ir+KJIKhobFNfXmWk0wVnW/NPRFleTZWOXFJUYcQk=;
        b=XJy9BtaPlBbz2fNJSRF5KAytSHj7aI4XIdVvpQkWAAxQhfiKrrYMgmjQv84Rr6PFPl
         uxQzhHSHFVIlvnXNYX1oZMxlzXSuDA/W05DSA/PFP+XX0UUV3W5GLgNehbENkljlEhSU
         WucfQhIJjii8d4ldlQYL0R/sZhj1dKS4mCZxMHdYfySxcbTFva2HjERL799LVEFBBaqr
         VL0MCzSiQs4HaFGkDUrhugrrgHpx176+Qu2YZSolUa+o09OTRPuACVySCbUtiDLT1AnS
         TglNNSVso0S2mUXfFHhbus9ReSZDzhOWiX/QAcT7vNC5IZoAVTvljoJzVXse8KU8GVR3
         LVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258451; x=1724863251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1ir+KJIKhobFNfXmWk0wVnW/NPRFleTZWOXFJUYcQk=;
        b=AFo7OIhb8MiBbhnX5SXCzRS+qIliyblJWz455AWiHXXo1hFAyGsuhQRWF59ttyFO0e
         lGWYuziZlFbI8dlSQJG8T9X0iK/0Pn46zHThRSjnLvmDww+6blW6qbukqSt+ITHVuUL/
         xDaPGl/kKcoIgL0USiMfkdVlZZDFwbnMloQhBLv/jo/iVqQT8acmdyq1OkwEd1MgtyZH
         4a3pe/dMom6yWL58uS8V1dm2y/9T9mPo0B0JaZipWH2Dxim2GKNHhTbzhPI2xf0gRxgA
         bvFbbPp1HQ7vKCr320A7ZJOB5P//AtjYlDbhbgWvy2GvAr0krSzpMYovCmCwv5N2OCj1
         Jp5Q==
X-Gm-Message-State: AOJu0YyWrK2PuU/GYTGplOEVrXerIir9eJlnLJxYys9bEc9pcTTZJg+3
	5Kfwsflzxr9GtUjrxG3jmgnT4jXxMrJ3tJ0OJghj660oFZNMuKY+ePBwv6WmdqM=
X-Google-Smtp-Source: AGHT+IEYAd4Ahh6bYYFdaZdvzahFIde4Hsd9DhVdKo1SLAdkp/jeuJRBE7kZOGWrn0NpfDMyqm2iMw==
X-Received: by 2002:a05:6214:3a85:b0:6b5:40d:c2d9 with SMTP id 6a1803df08f44-6c155d88ca0mr39742076d6.19.1724258450837;
        Wed, 21 Aug 2024 09:40:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5cc0sm62357846d6.101.2024.08.21.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:40:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sgoO9-00BYwz-QU;
	Wed, 21 Aug 2024 13:40:49 -0300
Date: Wed, 21 Aug 2024 13:40:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 2/5] iommu/amd: Separate page table setup from domain
 allocation
Message-ID: <20240821164049.GA3468552@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821133554.7405-3-vasant.hegde@amd.com>

On Wed, Aug 21, 2024 at 01:35:51PM +0000, Vasant Hegde wrote:
> Currently protection_domain_alloc() allocates domain and also sets up
> page table. Page table setup is required for PAGING domain only. Domain
> type like SVA doesn't need page table. Hence move page table setup code
> to separate function.
> 
> Also SVA domain allocation path does not call pdomain_setup_pgtable().
> Hence removed IOMMU_DOMAIN_SVA type check.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 46 ++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b19e8c0f48fa..33930e08bd4c 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2302,29 +2302,38 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
>  
>  struct protection_domain *protection_domain_alloc(unsigned int type)
>  {
> -	struct io_pgtable_ops *pgtbl_ops;
>  	struct protection_domain *domain;
> -	int pgtable;
> -	int ret;
>  
>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>  	if (!domain)
>  		return NULL;
>  
>  	domain->id = domain_id_alloc();
> -	if (!domain->id)
> -		goto out_err;
> +	if (!domain->id) {
> +		kfree(domain);
> +		return NULL;
> +	}
>  
>  	spin_lock_init(&domain->lock);
>  	INIT_LIST_HEAD(&domain->dev_list);
>  	INIT_LIST_HEAD(&domain->dev_data_list);
>  	domain->nid = NUMA_NO_NODE;
>  
> +	domain->domain.type = type;

In the end drivers won't be touching type at all because none of the
ops provide type. When the static identity domain is added this should
be removed.

It looks not too bad to do a basic static identity domain, it would be
good to put it as patch 2 and then remove type here and in later
patches.

> @@ -2402,12 +2407,17 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
>  	if (!domain)
>  		return ERR_PTR(-ENOMEM);
>  
> +	ret = pdom_setup_pgtable(domain, type);
> +	if (ret) {
> +		protection_domain_free(domain);
> +		return ERR_PTR(ret);
> +	}
> +
>  	domain->domain.geometry.aperture_start = 0;
>  	domain->domain.geometry.aperture_end   = dma_max_address();
>  	domain->domain.geometry.force_aperture = true;
>  
>  	if (iommu) {
> -		domain->domain.type = type;
>  		domain->domain.pgsize_bitmap = iommu->iommu.ops->pgsize_bitmap;
>  		domain->domain.ops = iommu->iommu.ops->default_domain_ops;

This existing code is wrong anyhow, type and ops are set by the core,
and pgsize_bitmap is being taken from the wrong value.. I am about to
send a series fixing some of that.

Jason
