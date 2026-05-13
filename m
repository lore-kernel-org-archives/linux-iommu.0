Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBCE3D5671
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656720; cv=none; b=i9XuLE0tlb3MCm+2T05JDVA/O+i95vxge5wLSqDhxy9sNmL8B0/0k99zpHeCr1OEAtk6XtMnbAaNsHFaNpaBgxq/W9MdxZdj5tu8N+EW+tMJb+22jvuk5zcUryVEQbuGK4Mzu9HzB4w+hOaXLIeNO1yvLyD9JWRoLob8yj3SZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656720; c=relaxed/simple;
	bh=Q74nb8qKOTOSF9NKkRDYzNFp0wpByFW+gJjBCBJqJpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoGmkeGUWdYBGbO6Ks+8CK4SqjIdYgOdb1VuZrooLaoleP4VJc+Y2sfPUPTrhGnToMnk3ycEmNPrQeClgOpBJkYgbKfsj81ZUIERJrt/lvhmmWsrQNr5Eijzt5ciV/RC+tkVxxSM0mhLewylglNSwC3UrH5foXbrWuYzz6Yq49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJFkQioD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJFkQioD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778656719; x=1810192719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q74nb8qKOTOSF9NKkRDYzNFp0wpByFW+gJjBCBJqJpI=;
  b=CJFkQioD2N5a5REHagKJRWG+0bnx5E/1DNF/9Mdz4APBnVCRYCu1xiUG
   eMnNTzEnfRrHxtLyxxYrfc2fZWpKFBUC8Hk9SjelHW+b1e1cP/VQZli8P
   /djkTPIBUzeLPTR2o8ZS2Iwft5TdvfY7BVYpzyW+VswDBphxYCk5j/1jn
   joi5PMd4YUxPkE2z5SFGW1gjjLygcjfTizvMSdsTz/GF8s+Uu5lL7ku6b
   YYuI6rTe7VE02DnmIpK8cMz5xzytsqxtk83fMWhNEtqThe3bDuDJe1LVG
   FMvr9lHAScuuWJxVdFL4gVCn/b7ITAHeZFQS6l7wB2wJqIjggCemYBpcR
   w==;
X-CSE-ConnectionGUID: gbTYywHmQ76lsekvDoRYrw==
X-CSE-MsgGUID: sQZNE5W/RpOg3rPds6+oMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105036086"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="105036086"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:18:39 -0700
X-CSE-ConnectionGUID: DaHO4JUAQEiRJGy9Q00Q4Q==
X-CSE-MsgGUID: lk23AwN+RO+DMvJyABi1HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="237916339"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:18:35 -0700
Message-ID: <b3d4ea77-7feb-4349-81fe-cf3e1cb6a40c@linux.intel.com>
Date: Wed, 13 May 2026 15:18:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] iommufd: Move igroup allocation to a function
To: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
 David Matlack <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-4-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260511184116.3687392-4-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/26 02:41, Jacob Pan wrote:
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

This logic is not visible in the patch's diff. Perhaps anything I
overlooked?

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

kzalloc_obj() is replaced with kzalloc(). Can you please explain the
reason?

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

Otherwise this patch looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
