Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD201FDA
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897480; cv=none; b=HHdG19ZGaw1lPLBbBEdLTkzynuc3xHf0/LIRBsCVVDCE+OYwP3Z1ARkoSWEIQbkpkFnORpPBrGG52HRbTrvS42i/VvMg4YR4gTdpMOQZtsbNJA/4IrkY7Fr0yJgn0Q9twlobxwyfRnKBUd+59E/n8zFZ98kAhTZzX35eMl8JmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897480; c=relaxed/simple;
	bh=9D4eoaPetM3SMEI84k7IILxcW+WbVo6EGGOXPKQPOIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQFJB1rdGJiKjtOYwY8Vw51jDZwiS4OZGoKBTQ7TUjlAn15bF21d1U3K4pEQMvNwFE7rFSy0ulTTd3e6QFoKLQWRse6QRKKELkS3kUQhg7eZ770oahQVi5Xto5uEMDq6qWOUihocUW/Ps4KItxM+A2OGIcdP0AGjKZixTbl91tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pPqOZ2wI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pPqOZ2wI"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9b049251eso13747085a.2
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727897477; x=1728502277; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bFJE61W1yuLptTlsQgW8eKXVALnzTshmdGjGMKdyyQ=;
        b=pPqOZ2wI5324f8Kg8T15paagYBJgKy8TxXzyWS1uxRK7mj9XtxaDd9bT51F1NtbZ3R
         wSOgVl2jbhwZMS925P1Ya5PZMBRijnuy28m727/Tl2oFUnZm7upd9eod6QmlvfTiDF50
         lvUymsQTS70YJuYxbab/GxxonX/F0esMy/Oe6a+i15ExvCD2WPjUABQobz0QE4BnaYA+
         rllg4PpVVpn2+N/TUdglVOgM3ahXffRYtMsX2VtPIAoWaL2SfZoJNcXmZZB51OhE0ozP
         BRcIR2CB6OGIi+BXtSsi8fcMSEPMSF2qWVCtLleIOpEZZzrbCq2PCZm5cYIMo7A3hq+q
         6f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727897477; x=1728502277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bFJE61W1yuLptTlsQgW8eKXVALnzTshmdGjGMKdyyQ=;
        b=ONxAiAt1lB+pJnmEyyIm7iPulx/iGSbEr+B0+jSfPUb37VrSxE+gpc/JZE7bgPQa9Y
         RrVT+FgTEQ+Z6DtexzAqc1xfzxcanDS+o6P9CO6T6AN3g4RrBe7zsXgnS+4U9Rv4vjCx
         RHm1L8of6zLs+wucdWIlG+ni/LpHWg1a2vPt0G5QNDWqmDKYWildFFwc1mtfXy5DMctB
         qqbCqbCbj99SBFaYnUJvdVN7F46T5dNASe+bMCOa4v3NNLe060UlCBJYwDSkevrPwmVn
         fDQOvmhqbxcwlAGu9b4oMKE/gdM5mCAqoerImDAAQSi5nkmsm0b6R9/B3mx6re7Ty1vq
         VvNA==
X-Gm-Message-State: AOJu0YzVvy5wrtZP+dvfmtiIF94YezBHMM/6gXyq8RGVTgTxtj3NwhYK
	Nitdb5dr7JAM+su1D659j9PPNEfIHyrKGuNMFPkM1C+WLNidEoso5xupPFqKePQ=
X-Google-Smtp-Source: AGHT+IGj3uS/LqIw3g/ClUEKxeCNez10XladOBsGPwXKwq6T4rjw0E8JjUAA7M3hilHRry2K+mcQVw==
X-Received: by 2002:a05:620a:24ce:b0:7a2:bb:31d3 with SMTP id af79cd13be357-7ae626c7adbmr656051485a.22.1727897477449;
        Wed, 02 Oct 2024 12:31:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377d5105sm647047285a.30.2024.10.02.12.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:31:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw548-00ADLg-Gu;
	Wed, 02 Oct 2024 16:31:16 -0300
Date: Wed, 2 Oct 2024 16:31:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to
 allocate PASID capable domain
Message-ID: <20241002193116.GA2428925@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911101911.6269-7-vasant.hegde@amd.com>

On Wed, Sep 11, 2024 at 10:19:09AM +0000, Vasant Hegde wrote:
> Allocate domain with v2 page table if IOMMU_HWPT_ALLOC_PASID flag is
> passed to ops->domain_alloc_user().
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index cfeb3202ceee..1c9e539f15a7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2401,12 +2401,23 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>  			    const struct iommu_user_data *user_data)
>  
>  {
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
> +	int pgtable = AMD_IOMMU_V1;
>  
>  	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> -	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
> +	/* Allocate v2 page table if IOMMU and device supports PASID. */
> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> +		if (!amd_iommu_pasid_supported() ||
> +		    !pdev_pasid_supported(dev_data))

The test to disable v2 support uses:

	if (!check_feature(FEATURE_GIOSUP) ||
	    !check_feature(FEATURE_GT)) {

But this doesn't check FEATURE_GIOSUP, just GT? Is it OK?

Jason
