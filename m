Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454E3A452E
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341972; cv=none; b=IMUKsrncBr41rgRjpgT/rY26ySHj0bMAqB8wEmMjIFEJY4m0/J0g0ZbKaEKaxNJPBb82yS9Yg6+de1sfrc5KEfs3yEsx29naOKOxE9LLL5fcZsDrbc3wgM2g6h/BHxuECqQyedIFJ7ebYx3sDOnOCVUPLR7txSFFdIuAH0Ap/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341972; c=relaxed/simple;
	bh=RNFcj8p4rfxZ5TQh5zmhAbH49h/ztzhjJPZI9q3ZKRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0XMck8WqXnSaEJuCjS4Rx32UcqCQIGJX+XO+wbGBNMTuNV0Tvlcp3jtvmUdwoQ+k65sw2LWANhTIJWe1Vg6gju6qxx25+vXNQ0z4bYvF0UYW4ihpEbIK9eoRbydVudM79gjID5wnYBuTKAqcKIyWPuvVpSRHH3rKDcKiuqtH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=km8jCKND; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="km8jCKND"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3f822163so17795ad.0
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773341971; x=1773946771; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ5QcrI8geh7d6absK8WvXfu7trgVMmlccvVoh70ilQ=;
        b=km8jCKNDBUDOq5iAFO/PXf0PnEeEEODBAlwmo/BF6Fah/Frf/s3uxbNCAu4M4MB1Ty
         eTpOWkYgPysdn68HDhANKaFXheNXlfX2L4eZDFGSWJhp5+JF+CZALZLoFlZuKshDKH8P
         yif7GEHLjkWyVqgWGdTPK8xOrSiX6k31nqXCpy9WlsdIBdrxXvIwD/9bHcWaGChvr2Vd
         L8xVD9EEqkld1Y1iBu44dk8+rgqHa00sut9ErZkRpaP8hO+RzbiT+QWW/Gze++JVDVPc
         lEFrUxP1Tb1MDeasbjSMXieXxT/L38uOO8qrOXVrWy+6leHeEvRYNu4xL9qIUOxsCIHr
         oxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773341971; x=1773946771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ5QcrI8geh7d6absK8WvXfu7trgVMmlccvVoh70ilQ=;
        b=wezmBbBnYgWd613dyznYNuIse+yIAL8K5oOhMmmczACjzPlhAODEiPTLTHy1a05Nzt
         Dy3rHmgWXnJrpjWPxOPP8NvpVvEKfuPnAYDt723YLf63MuSVdxqrenVou2FDRrdIWpKU
         DI60XVCm6a7XXXE/5nLckZlyqPvaVHzwOWqor/lzu8SOndJut5ZkdYzyDBi5dkMfgjFs
         JV/RjPN5eoL9Ja0tBKMhw7I2x3MqY9FnUuFFPV++jL1KyOjQ31jlQeXkcifJgFcgKgyn
         RrkGbPofXT3XapB4s969Kj5BN3TpctVi5cLjR3WrLzUPqOkviuuiShOUhvQBc2mVRKSv
         vVUg==
X-Forwarded-Encrypted: i=1; AJvYcCWUPPTTANwjVKJjNb07Jxdsl9WDcubn18+rrgMDKCy/mNIOJlC0X7Q9MugBTm/pellg7iVdEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2AsxqzjuCQLARyFNWvvOrgkNsMhI6Ks52ADPYnhEOesec7Ai6
	vU4tADTcu3arWlQ6czNxFAWwvH9a+fePrVGuGXkmTJLqms7WX6XcxQE7/R84452xxw==
X-Gm-Gg: ATEYQzz4jecTIjbnsvqC13PGsCRTap2CWTV2hfTgT9R7dAggOcLGZC0jWVnWQGRVyDA
	ptpLPBXxZ5C1jlrZFHPNx9eJinB8lm7LSdBMTMSVt/UjjAc+/jDXhNadvU38HETUAcJb68nZeXM
	TYjj4yt2FsSzO/RtTYegTPZ2k71PifDgUN82WypHm4WPPL1S9H/FxxUVa3QxQaDQpGyenGDv2P2
	7lW0MJc6xZ8Eyk8mnQlbfQ4N5Igj+KxG16OzCPCSg/kUP6dwOzO5UX9N5VOrhnPgRj0cc1hk8Xn
	PIOnuD28VUJUg2EHKkNleq41rcC9sAkoJK7rFVkc0Uwv3Xn4TqNO/6JYTFlqiPM4oztyXb7VCQX
	6iplTVBXICfbA2GwEBDxzJ0LF1SQwi8cA859ie032RvmqTSGHbZQ9HlLmG8VA/cST9xQHR2iKap
	a96xnQJHS0nQKcoamCgFaPtHDdPulq8IXI8X3VJDyv6iQfFg3IB5bMMPPuPQ==
X-Received: by 2002:a17:902:db0b:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2aecb83b96emr407445ad.19.1773341969932;
        Thu, 12 Mar 2026 11:59:29 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae361326sm60888155ad.70.2026.03.12.11.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:59:29 -0700 (PDT)
Date: Thu, 12 Mar 2026 18:59:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest: Fix page leaks in
 mock_viommu_{init,destroy}
Message-ID: <abMNDNle3AbZKGOO@google.com>
References: <20260312164040.457293-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312164040.457293-3-thorsten.blum@linux.dev>

On Thu, Mar 12, 2026 at 05:40:42PM +0100, Thorsten Blum wrote:
> mock_viommu_init() allocates two pages using __get_free_pages(..., 1),
> but its error path and mock_viommu_destroy() only release the first page
> using free_page(), leaking the second page. Use free_pages() with the
> matching order instead to avoid any page leaks.
> 
> Fixes: 80478a2b450e ("iommufd/selftest: Add coverage for the new mmap interface")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks for the fix. We indeed allocate two pages but free only the first
one. I guess we missed that earlier.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> ---
>  drivers/iommu/iommufd/selftest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 7823142097d4..83e2215e7800 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -636,7 +636,7 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
>  	if (mock_viommu->mmap_offset)
>  		iommufd_viommu_destroy_mmap(&mock_viommu->core,
>  					    mock_viommu->mmap_offset);
> -	free_page((unsigned long)mock_viommu->page);
> +	free_pages((unsigned long)mock_viommu->page, 1);
>  	mutex_destroy(&mock_viommu->queue_mutex);
>  
>  	/* iommufd core frees mock_viommu and viommu */
> @@ -870,7 +870,7 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
>  	iommufd_viommu_destroy_mmap(&mock_viommu->core,
>  				    mock_viommu->mmap_offset);
>  err_free_page:
> -	free_page((unsigned long)mock_viommu->page);
> +	free_pages((unsigned long)mock_viommu->page, 1);
>  	return rc;
>  }
>  
