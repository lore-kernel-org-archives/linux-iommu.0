Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF11A6825
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429669; cv=none; b=TfqjVukkfh7LeFqzbVfVW+vCGGk/lb63lKWggVrJPkDztQ7J9CIICZ8sGWSRJ3/J7OfIxdvdDC9UF0/tq0ee4AOwFPYR9INLIbDCN54FYcM5wAY+N1tw0Mw7PXx0x+D2KBnYVPrk0nXxZ/ZLrdPENnx014RNq+2QkholLUspq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429669; c=relaxed/simple;
	bh=C+fQAK78vh42D0+3zrcP8ofL6wgnDgmB5Aiv9yoILVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knUWKHEzc7OcS1eFIa0561GvHM3mtnkw//+5PPRBDzYC8yfGQAMzTY6HYrA+RiEXMQ5i2Abl7vSeQ26Hgkmh7qy3N8yaA+NfB7ZS5Kd3LfBhyFU0KrS9ESKYSi0jeSZuX1ksSiNe17BR6KeshP+PRUUuXcNL8Wb/lGflBJb1yl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxFq+R8l; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxFq+R8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779429667; x=1810965667;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C+fQAK78vh42D0+3zrcP8ofL6wgnDgmB5Aiv9yoILVs=;
  b=IxFq+R8lqUro0usF8vFvhjZwdkVtGDTDe/O1Zr817w+A9nniqvv/90DJ
   3P3HOAGP42Oh8+0p/Pvi6KWbTlCfiHzu7Nq0e7K8gvWZAAZOu7CyLqqj0
   zWc8RjmMjFIHY2pPcJ0F9Q3SkL0ObtAx9HEyB427C/yz79qj0Cvk1B6hT
   uZUlU0WoXr2RvyJyJIiZubA7B+wRG9VDz30CuPojHvqhhmt4A4h2FJ2Ty
   N2Gb9efUDP/Uchiq3TAL6E5rA8ciiHLUG54j+mqt1+7FDsZyjkl6/xoTb
   1EbXoGmQTdtYBuLTEE3Rkla3tabxAj0yLSGqH+3jXKsvqQ9fOdUcp+bla
   g==;
X-CSE-ConnectionGUID: NfM/Oam3Q8StbF+9fS6kAQ==
X-CSE-MsgGUID: K4BWAGSWSV2qmJqLMbvnSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="83973223"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="83973223"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:01:06 -0700
X-CSE-ConnectionGUID: RrqZfG94TR+DQ2AfE9jg+A==
X-CSE-MsgGUID: rl4EJfF/TYqjQq4egtnVDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="237775076"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:01:02 -0700
Message-ID: <b9839ca2-f6d8-42d4-ba27-def82fde5dc4@linux.intel.com>
Date: Fri, 22 May 2026 14:00:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] iommufd: Move igroup allocation to a function
To: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
 David Matlack <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
 <20260521221155.1375144-3-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260521221155.1375144-3-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/26 06:11, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> So it can be reused in the next patch which allows binding to noiommu
> device.
> 
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v5:
>     - Add NULL group to the error handling path of
>       iommufd_group_setup_msi()
> v3:
>     - New patch
> ---
>   drivers/iommu/iommufd/device.c | 43 +++++++++++++++++++++-------------
>   1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 170a7005f0bc..d03076fcf3c2 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -56,6 +56,30 @@ static bool iommufd_group_try_get(struct iommufd_group *igroup,
>   	return kref_get_unless_zero(&igroup->ref);
>   }
>   
> +static struct iommufd_group *iommufd_alloc_group(struct iommufd_ctx *ictx,
> +						 struct iommu_group *group)
> +{
> +	struct iommufd_group *new_igroup;
> +
> +	new_igroup = kzalloc(sizeof(*new_igroup), GFP_KERNEL);

nit: I am still wondering why kzalloc_obj() was replaced with kzalloc()
here. Is it a rebase issue or something that was left out of the commit
message?

Otherwise, I am fine with it,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

> +	if (!new_igroup)
> +		return ERR_PTR(-ENOMEM);
> +
> +	kref_init(&new_igroup->ref);
> +	mutex_init(&new_igroup->lock);
> +	xa_init(&new_igroup->pasid_attach);
> +	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
> +	/* group reference moves into new_igroup */
> +	new_igroup->group = group;
> +
> +	/*
> +	 * The ictx is not additionally refcounted here because all objects using
> +	 * an igroup must put it before their destroy completes.
> +	 */
> +	new_igroup->ictx = ictx;
> +	return new_igroup;
> +}
> +
>   /*
>    * iommufd needs to store some more data for each iommu_group, we keep a
>    * parallel xarray indexed by iommu_group id to hold this instead of putting it
> @@ -87,25 +111,12 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
>   	}
>   	xa_unlock(&ictx->groups);
>   
> -	new_igroup = kzalloc_obj(*new_igroup);
> -	if (!new_igroup) {
> +	new_igroup = iommufd_alloc_group(ictx, group);
> +	if (IS_ERR(new_igroup)) {
>   		iommu_group_put(group);
> -		return ERR_PTR(-ENOMEM);
> +		return new_igroup;
>   	}
>   
> -	kref_init(&new_igroup->ref);
> -	mutex_init(&new_igroup->lock);
> -	xa_init(&new_igroup->pasid_attach);
> -	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
> -	/* group reference moves into new_igroup */
> -	new_igroup->group = group;
> -
> -	/*
> -	 * The ictx is not additionally refcounted here becase all objects using
> -	 * an igroup must put it before their destroy completes.
> -	 */
> -	new_igroup->ictx = ictx;
> -
>   	/*
>   	 * We dropped the lock so igroup is invalid. NULL is a safe and likely
>   	 * value to assume for the xa_cmpxchg algorithm.

