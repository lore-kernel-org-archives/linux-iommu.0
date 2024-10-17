Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811701DDC02
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171969; cv=none; b=ZSIA+xU0VJcwPZFu4ov/z9pa81EwoaqgURVrh7F8Uw11FIIaDlJj5fymQJw3lFtiA4C79rW8MWUpml1Av70CMnwCguK0Vy/nQDBWdimCsTNfBWKojxDdMShV1+q3IDsVJaYXz46xeYQ39V7Z8CmRnOHtahN1H8FQ2QoOU5cJhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171969; c=relaxed/simple;
	bh=Y83TL2NovtB2a29bSArArlkuBWnSake//yhiMFF7y80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3rMa/FZTR6HlIrH3BYTD0fc4TFF8jj9iLoKIXgo9YSc3yQHIfvvacX+RMN0oGH7zI5m4iBrv1FZAhFIyb7oPzoWFDUvifydHQ0IC2m/UdUPHbu+Mo/1v9bYqi4k0qqWqI1hZxDqbdS2UTS3pgWvQvBuLnXaXw3o1/eKARBB+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RtSYlavK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RtSYlavK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbceb48613so5740416d6.2
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729171965; x=1729776765; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1U68weOv1qjG2W3zP85mBAoECfL1/mMxJsbmSAitQns=;
        b=RtSYlavKGvTNIjRJrbEiE/C0o3zw3G9CLcn0syB9Ntz0l55t+YtZ3PXesocEVMCI6m
         YUax/cZyxNiP45UvTu5HnPnK3jdC8ucOEgroGE7XbJMMhylwi+ksN2KlpLZi4Uwut8GQ
         h8HjuTlPeewnKizFUfRsGxcPPdXiLwY97PYwyVN583QPUy7YW3pDQVB5mQvqcZxEo0ZZ
         kCgCdsGlj6s3z9V+gbslvIFZesF+d8PGfuiP03Wj07Mf+c+DcXG61/cUVdf7tTjTn7LH
         A0MoZlxuc2FhNIn4Tsc93iUIblopj5w/CjOChG2eLQDRP9FLM8c447cIBM0P5iDapfi5
         A4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171965; x=1729776765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U68weOv1qjG2W3zP85mBAoECfL1/mMxJsbmSAitQns=;
        b=dQ3ai9mJ3Ab4pOcala8hp5+jVYlBICV23acVMaE+zk1YKDo0kBxytCTOyPT3cch21l
         fFkuh5GMks+jsyVIQ9s6bBByWHzmF/o3GyOMLMQdepC6G+C0YrK0zFB7oT2ANJtsHAED
         LAkEOTnO6dHFN7EGWR1HW/so0+RAtklcFU1yspQdVNw47cU2YsBrtWsv5Bb4j2RRXlnC
         FbspmN03DfWuS5Zey5YfP603PfWNwMhkvl3d7SrAT+MzrB2G/uTKIa59IJgquInHsnC1
         cMdiLxAz0skUt6a8tqwaH0Tw2mz4yvP1x1WIrscDJodBpJ6Z4V0hMKTaiF/wY+tGpc1K
         /iOw==
X-Gm-Message-State: AOJu0YxPsoW9j2pT+g4sjYloAiR510z0LMangMNxKWEUBzPOUNzq3+1P
	VoOVnjOEY4BBoxzHe+7D+GqUImtYewz/9E9mayIy5HeGytZg1Xa3ZK5blM+wVz4=
X-Google-Smtp-Source: AGHT+IGrtvpzUY9VOjOnzen8R3WO2zQ1wC1Y2gUDJXMB2YFayvj9xRn8oGyrxupfHg1mKWzC/5s17Q==
X-Received: by 2002:a05:6214:3c9e:b0:6cc:ff:e695 with SMTP id 6a1803df08f44-6cc00ffe70amr221656346d6.52.1729171965422;
        Thu, 17 Oct 2024 06:32:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290f98esm28434076d6.9.2024.10.17.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:32:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1QcO-003xjq-JI;
	Thu, 17 Oct 2024 10:32:44 -0300
Date: Thu, 17 Oct 2024 10:32:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 06/10] iommu/amd: Reduce domain lock scope in attach
 device path
Message-ID: <20241017133244.GP4020792@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016053501.97497-7-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 05:34:57AM +0000, Vasant Hegde wrote:
> Currently attach device path takes protection domain lock followed by
> dev_data lock. Most of the operations in this function is specific to
> device data except pdom_attach_iommu() where it updates protection
> domain structure. Hence reduce the scope of protection domain lock.
> 
> Note that this changes the locking order. Now it takes device lock
> before taking domain lock (group->mutex -> dev_data->lock ->
> pdom->lock). dev_data->lock is used only in device attachment path.
> So changing order is fine. It will not create any issue.
> 
> Finally move numa node assignment to pdom_attach_iommu().

numa node assignment should only be done during domain
allocation. This is important because the domain can be mapped prior
to being attached and without the right nid table levels will be mis
allocated.

However, that needs your other series, so let's just leave this as an
future direction note..

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index d74d3b65c939..a738d2d7f0c4 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2016,16 +2016,23 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
>  			     struct protection_domain *pdom)
>  {
>  	struct pdom_iommu_info *pdom_iommu_info, *curr;
> +	struct io_pgtable_cfg *cfg = &pdom->iop.pgtbl.cfg;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&pdom->lock, flags);
>  
>  	pdom_iommu_info = xa_load(&pdom->iommu_array, iommu->index);

It would probably make sense to use the xa_lock to protect the xa
instead of overloading the pdom->lock. Then you don't get forced into
using GFP_ATOMIC here. That could be a future direction.

Anyhow, it is already a big improvement to narrow the scope of this
lock quite a bit

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
