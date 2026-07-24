Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885C2BE02C
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915370; cv=none; b=TkvB+epXuzjq0gNJGOH261fx08IB+yr5PYKEl6TaWY8mz9iAYKDFCJuE2sOmhfHBoEi6opPwJsAimShk3qziZrAO340ZVoBRo271fzeRsXoFs0B1UJ/kPcf9q5TWDvwUnC2jmsfGBr/NrK/bUYTNBU8ybgxz0pEFEwLXEpHYfSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915370; c=relaxed/simple;
	bh=vLcGVz2tdtFGGN4iYOW2oVtXgKv/RWuuJl9rYzsx0yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMByCOFgT0k+GCr7vit834CTrqVU6dRZMyerSdKxzVpow5EaTyk/JTA2vHoRXq3D43mnqFA2/hSEaM9SRKIrfGO+9Xndfc2gEzdAezrhmoYekPBVepiVOchpkQclRrGKTGLwpKnyvuQ4N6E2G+7P53j9mDGDgCQr4gIDFPkaC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxZlsH1P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxZlsH1P"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so4205e9.0
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784915367; x=1785520167; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UnE2PZuA4mlcF5l6Wvu31DrgU1W+yVTlxMHSfuz9j+8=;
        b=TxZlsH1PsQzDQkCJFNisZzEpsJvDtJn/svuzO7wjZSOlnAGPgQqj/BwSVJsSxU5Fd0
         +EEcw0LJxSFmaVPkFhPOF7f0nmEb8zaGiSYELuGhafMC2IbMO5cAJYKsjeQ19wQc7dvF
         ZXUMmSOP7dhuQsQ8xGCp+/Q70BvKb626tHbk6Fj48NqqkwNWdQxLkC1Uvil6i9lJZ/Dv
         cj/UNFuyokHmyJodDOjJOt218dSTwnArvpHePg68br6JQUhXjvDo2cLpKqIoWi7UWtIP
         axrEVK+RBzl+h5zz7aIw+L+NIDwnW1F2akrQquw+cxgDcLFzFquibQmua1lrSiedyUBC
         zelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915367; x=1785520167;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnE2PZuA4mlcF5l6Wvu31DrgU1W+yVTlxMHSfuz9j+8=;
        b=TBYMVjVQcrFFRfFJXG8Td7uLgS0iavGwFCVYs8OH0K+Xz0zKtfWoLYXJ1TSnk6dr0h
         YlIVTLYR4s3Cmg2eimZFBsVnkb0zt4Uw5yjOG1GKAEIV2NnYZEH6cBoKFU+DHSzgZTfn
         5a7gqvsUmk6BBvkC9bhB+gtsVdNaGMdu2oYnjGwoXFd6pxXSzEZIQJruDe84mhWYXn8b
         R+Ym/6CP6Ys3XHxCfleTxvLhTTj118WwFQhJ6XM7Ao98c6wHzE1kWuTZRDbQJi0UvZc9
         9O7ob1V7TuPfB0dnxDqfGRHt06z1ETQTRo0TcVRVEGVTEciERfbE2vpYURfofONWyvjG
         AAaA==
X-Gm-Message-State: AOJu0YxYDFfN3B/5HTavw8L0FC1RgDhOi+l1zPro5kqFvOeLyePdYQFI
	zYoTi9gvJ88kptr03wwkGYlijb40jwPvNJ5kpeyrnQ595eUCpDWg67xkaUbqNiIFeA==
X-Gm-Gg: AR+sD12nT9dc7bVUiyU/L+1MPrP/1PEhZmJYyw8lLPDu/KNdid1dYNJdLdBnUoVYnnD
	PeOG4azEVe1VRHH2YuZP3IVsVTd1ekMX3crFBRf2jw8R9y0ZCnXfu70xqjfiq5yqxLKBjAOJyKZ
	5E8hh33tUjmHL1X6R/y/d4CwuaRol/Qj1aamXq3Nft5chbpFQ9oFCF5um6VtZjwveMFBfAreHew
	oLvee6G4n5SZW0uVX5CngKnRj+h57ixvtppFpHjCnfIkGzxrC3EmV0bShZVEHnq9wFiMH1Qn2Gz
	Y+CMzDPzfA2PVUpX4TOdo0sY9nO/qo9lKJZdrqWr0gJlULL1KN64IA/vIs/azDtJz7NONMPPKi3
	SeqUctW6h+fFgbLsYHW+QI1nC5Q0We7Po4/5GYFlsMMyMibDfZN+m4NhAd1T3xEpSPt5w9gkgu0
	OxfZ98HhxdKmmkUJkVF5ozTnC1JFrg9bzNuF/4Y6xGnqzXVkRG
X-Received: by 2002:a05:600c:4583:b0:493:aca0:32e2 with SMTP id 5b1f17b1804b1-496b4cf6c36mr98295e9.4.1784915366398;
        Fri, 24 Jul 2026 10:49:26 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee1d31sm1129795e9.5.2026.07.24.10.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:49:25 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:49:21 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH 1/7] iommupt: Remove the sanity check for
 pt_num_items_lg2() at the top level
Message-ID: <amOloT9ExCVjYxyf@google.com>
References: <0-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>
 <1-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>

On Mon, Jul 06, 2026 at 01:29:07PM -0300, Jason Gunthorpe wrote:
> This was ill conceived, the existing formats work OK because they
> happen to support pt_num_items_lg2() at the top level. However the
> documentation is clear that is not permitted because ARMv8 has
> concatenated top levels and we do not want to calculate an exact
> pt_num_items_lg2() for the top level special case.
> 
> The logic to compute the number of items of the top level is shown in
> pt_top_memsize_lg2() which is:
> 
> 	num_items_lg2 = common->max_vasz_lg2 - pt_table_item_lg2sz(&pts);
> 
> Which is pointless to try and sanity check.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> index c2752151c80af1..f1320c7e88dbbb 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -1207,20 +1207,6 @@ static int pt_init_common(struct pt_common *common)
>  		     PT_FORCE_ENABLED_FEATURES))
>  		return -EOPNOTSUPP;
>  
> -	/*
> -	 * Check if the top level of the page table is too small to hold the
> -	 * specified maxvasz.
> -	 */
> -	if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP) &&
> -	    top_range.top_level != PT_MAX_TOP_LEVEL) {
> -		struct pt_state pts = { .range = &top_range,
> -					.level = top_range.top_level };
> -
> -		if (common->max_vasz_lg2 >
> -		    pt_num_items_lg2(&pts) + pt_table_item_lg2sz(&pts))
> -			return -EOPNOTSUPP;
> -	}
> -
>  	if (common->max_oasz_lg2 == 0)
>  		common->max_oasz_lg2 = pt_max_oa_lg2(common);
>  	else
> -- 
> 2.43.0
> 
