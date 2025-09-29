Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA13054C8
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148762; cv=none; b=HMsmEgsToq1IGW0Pq54NNxnsmXhkjCRRz8PdxiNd0wej9owPpGnxV1UXKoWRzOxN4M7MpBvKmvftEDj3+DPEAC2bcvZAkImGa5xn5E8sobjovKZzeAp9KgegFYn0SBmfiaTiHvO73CvsMZhyUQJDDjQ5JUskDh9x0c5WPXPPSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148762; c=relaxed/simple;
	bh=IPfBHgXBIWGkmCbENeVsi96BJ7N4st3OLtzOumLhCzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he1nGBVr8GwmAspWUuBrEqmWHY2Fe8t7nGBkTN/HZIsV4LK87KjPs/fvLSALyyd3wmuW9FswOB+Gb30kBeM0lpQm+6s4NyyZovJY7UTmQAgBNyM9stH74J4yUyNK1gybZNhf9p2o8AQKHqsaoua37kAUKsUg3ITL7WUDe9Ql6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UThZ7CSz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UThZ7CSz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3f213b59so122685e9.0
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 05:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759148758; x=1759753558; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rX8QNnM/VfgNSl8joey8ya0plk5QpjGP/jUnyfo2ncE=;
        b=UThZ7CSzBh/WS2CFvkdTtv7exFRUjclYKRW8DDfNFVteP2NhsbTWfpf1Suu5a5Y5vk
         8GOk4ltSuyVjtdOpftQCoOo0kCSaN65NTKtrX2cN0JIrT+cnzVYdQgEfj0TBcXyzUo7J
         /KsjVP8lAB7vMPF3l+uQOtazxtqE+uRn1I7vwv4L2Hzv5tWQ5CaOukJo1t06OZZLFAor
         jmLoGasW+2fQ6CQ8EmBR6HIwqGziZROMKgL995UlQKl7vHnqRf+QYE90n91+SrKlo+R/
         /9Yu21aNw5GEFQvg1sGhbOuUuDz1l9z7BBkpQcNL7dm5F3qYUFUjKrDCuITI/kqHHEuG
         jVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759148758; x=1759753558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX8QNnM/VfgNSl8joey8ya0plk5QpjGP/jUnyfo2ncE=;
        b=Mn0ztgmdSe1uoDJXk28rOPk1TvHXjRe9yF6uKq5PsKikQKSxfg+hmxegrQa8iT3iFk
         B2c6nq+/g8IZCmcp8h7fdX8A6V5b9qVv8c/XE79uJlF81NrwVgJqzD6UYzn1PYTw5OCF
         k0b02kB2MyUakb1bmT/l42QtKtjBOuTCeCM+EfiD1IRlaVtw397/PIgzoMUDjKavTGHH
         fJooaqHdXkrytcB5UUHCasC8CwUDU51qPkV1GaWjMA+h1F5PLJd8hwBVV5WutvjnfOGm
         xxWS2KhiTnPwnjJMMJ25RaxJd0l8b+xVaJYgEf3DQRzaNGY+/g0kSCL/CTHyd3Zxr+SD
         OGJA==
X-Gm-Message-State: AOJu0Yz+HHM5Z6HO8HQBcAM7065zdVuJ22vIW4bsxkLHNcHsFPmHwyIb
	a/UUEJT8xPMbWDPGt0A6Jt4YStVxr+bFlVkXpnm0SSk4L3UY3tUUbSMs02pYCnPLxg==
X-Gm-Gg: ASbGnctBcKDpNcYVHDnK4Q00dojdiqa+LLf3bMAgXo5hL+8pULFFqtAiSmBIvmhEDSj
	O4yOnk7I6B198zt0XqIOYZ1/Mjsey+OW71O1VcH4TLtxDvIhllVtPnbKEMgKr0sOqNblaAj+VI1
	5EQhnNQtetG2c2YwtO1sXNzkMvdIyZ9ZSVagD4eL2JAIPM2cU1hwL6dTDSkP9wFN+pVdl1revRy
	u2ZDFZraj7KECxskiiK0k+hmaj6pof82801pAvHoTb4H+BPk/Kt68Gs9Tmxv5IPFpwOaWjz89Mb
	fR60ZkHjARY1Iqfc8VwlUXHulxdzNWhwO6KV7ktQgr3tCKUXTKIVuFUKeBybE7sZ8VIV1582Zpl
	7Nh6zo9wdlj6nQPGMzCv+fFi+lP6srszoWYQ8hTdMU3+yqqnz2WlQ5gGr6Hm87P2qtz5w9BrA6O
	ScjBftE8atWYvC
X-Google-Smtp-Source: AGHT+IHglrqxMx9eJ6fNXPXFkzLGw3noYR5M/ZCP/DdPP9T4uHc8AX5l/UCkLJ7NIRLr0sQHonn2ig==
X-Received: by 2002:a05:600c:8594:b0:45f:2db6:5202 with SMTP id 5b1f17b1804b1-46e5758ffc1mr335055e9.3.1759148757558;
        Mon, 29 Sep 2025 05:25:57 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc6cf3835sm18265146f8f.46.2025.09.29.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:25:57 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:25:53 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <aNp60ak6OASbPd_J@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927223953.936562-2-danielmentz@google.com>

On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> Implement .iotlb_sync_map callback based on the new callback in the
> io-pgtable code.
> 
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2a8b46b948f0..0ffcc6c8e4bf 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2541,6 +2541,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  	pgtbl_cfg = (struct io_pgtable_cfg) {
>  		.pgsize_bitmap	= smmu->pgsize_bitmap,
>  		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
> +		.defer_sync_pte	= true,
>  		.tlb		= &arm_smmu_flush_ops,
>  		.iommu_dev	= smmu->dev,
>  	};
> @@ -3366,6 +3367,18 @@ static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  	return ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, gfp, mapped);
>  }
>  
> +static int arm_smmu_iotlb_sync_map(struct iommu_domain *domain,
> +				    unsigned long iova, size_t size)
> +{
> +	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> +
> +	if (!ops || !ops->iotlb_sync_map)
> +		return 0;
> +
> +	ops->iotlb_sync_map(ops, iova, size);
> +	return 0;

Shouldn't that be
	return ops->iotlb_sync_map(ops, iova, size);

As now we ignore the return from the ops and mask it to 0.

Thanks,
Mostafa

> +}
> +
>  static size_t arm_smmu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
>  				   size_t pgsize, size_t pgcount,
>  				   struct iommu_iotlb_gather *gather)
> @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
>  		.map_pages		= arm_smmu_map_pages,
>  		.unmap_pages		= arm_smmu_unmap_pages,
>  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
>  		.iotlb_sync		= arm_smmu_iotlb_sync,
>  		.iova_to_phys		= arm_smmu_iova_to_phys,
>  		.free			= arm_smmu_domain_free_paging,
> -- 
> 2.51.0.570.gb178f27e6d-goog
> 
