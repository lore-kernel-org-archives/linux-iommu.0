Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49918622
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745754; cv=none; b=LP0EtOH4ssqsfyi16Led6bUW4zxPRET4CU2T1lL7xk6X8DbaxuFSwIP3m+wPWeVao6ARFJoO3wPqEgvymXNgTcSj+0gjYYP6kr4bMjwNx+Izwk+I1oizr8v4m4D6HVJdWEoewqvlduIB5Bk0L6aSiEuHbIV2hM7mZtRrYXL/QB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745754; c=relaxed/simple;
	bh=sjTQvh/cpYp7XCSiXeacDUa+JlAJUAoH3X25cWDzDO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW+dbEFhPr6iS15vXAKxx+304Ttca/2bt94qA+xFih6Df3upsCW9bqjji8vsBST6sFgBvB9R9dCBwU9/DIKuYqa7/+i1wj1xCq1QMGGOeOodcZlKyZ2iNEaxgdqk6khIzdysfpk4580p7epxjj3cNBlmn8VR5AkhL9DQ6siGOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E22821063
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 10:43:00 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3BA53F528
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 10:42:30 -0800 (PST)
Date: Mon, 4 Nov 2024 18:42:28 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org, patches@lists.linux.dev,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] iommu: Add a kdoc to iommu_unmap()
Message-ID: <ZykVlIae4uXDX07s@e110455-lin.cambridge.arm.com>
References: <0-v2-fd55d00a60b2+c69-arm_no_split_jgg@nvidia.com>
 <3-v2-fd55d00a60b2+c69-arm_no_split_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3-v2-fd55d00a60b2+c69-arm_no_split_jgg@nvidia.com>

On Mon, Nov 04, 2024 at 01:41:31PM -0400, Jason Gunthorpe wrote:
> Describe the most conservative version of the driver implementations.
> All drivers should support this.
> 
> Many drivers support extending the range if a large page is hit, but
> let's not make that officially approved API. The main point is to
> document explicitly that split is not supported.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 83c8e617a2c588..d3cf7cc69c797c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2586,6 +2586,20 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>  	return unmapped;
>  }
>  
> +/**
> + * iommu_unmap() - Remove mappings from a range of IOVA
> + * @domain: Domain to manipulate
> + * @iova: IO virtual address to start
> + * @len: Length of the range starting from @iova
> + *
> + * iommu_unmap() will remove a translation created by iommu_map(). It cannot
> + * subdivide a mapping created by iommu_map(), so it should be called with IOVA
> + * ranges that match what was passed to iommu_map(). The range can aggregate
> + * contiguous iommu_map() calls so long as no individual range is split.
> + *
> + * Returns: Number of bytes of IOVA unmapped. iova + res will be the point
> + * unmapping stopped.

I guess 'res' is the return value here. Not my default name for the variable,
worth replacing it with "return value" ?

Regardless of the acceptance of this nit:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> + */
>  size_t iommu_unmap(struct iommu_domain *domain,
>  		   unsigned long iova, size_t size)
>  {
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
