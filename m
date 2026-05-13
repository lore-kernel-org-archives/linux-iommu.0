Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFCC3A48CA
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657867; cv=none; b=qccwo3WVSPqwijeOHRltoyDrkNJVIuZQVsqWoS+8I1FYwgumeKwcfr4g0O6EWBtz4fAx3oE0ofujcwVk4mE3uNfi/KRIfj0Wb6Ea/Kgy3Jz3z+MnCGWvAyF85TzoKfcxCNm0XYD3/Y2Tin7X7m4UeoXxNFG091NdN6FQgSP2L8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657867; c=relaxed/simple;
	bh=2ChN41yO0qWGwO0DNylNsZeJkrmU84HHedkt95eVYJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMVyXNo6uYKbr5oMEw8s+PDwPlCZ0Cj+uL125G035uW1HaD0dK0MjGom6Kfs/WqC9gY/2BqB0DoORRWLbU0rwlxaukUqjg9p2K4A3284fm3R9sTxSiQKhRMB/j46xGIsXT+qQen05b/yJtuAAKgDV4e8GctX15N1sbsyOGDIZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXFrWwOu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXFrWwOu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778657862; x=1810193862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2ChN41yO0qWGwO0DNylNsZeJkrmU84HHedkt95eVYJ0=;
  b=UXFrWwOu0ln8QheiwkjODhhInhskdWiChhZGO00ELcLsoTRYV3v5WxNw
   vhREDfGIB9sJYLq2U4BtAXedmrQN4XIUsAqIJLe8fSnebR/JpqeIFynZF
   JyU8PuZ58JQTWAhNMiDgDPyWXuEaquAdbkKUdeT60ZcsqpRrLYb2ra5Mi
   JX+7RXy00Fgoycl+XkG2yWaBBwnV8bjyfhOTuXRcQyycJxTO2Q+G32NF3
   28T8ai9kDng5SK4T/K0Qq4ynDjNUWfTmj/QXHVCKELKJNi31D/RX1NgLB
   JVoZPGhFt/968iDjazirSnxD/+HpHFRtjy7I7HdDQvEZdAsESY5CyxxD5
   A==;
X-CSE-ConnectionGUID: depqsF/GRJazShqpPzChUA==
X-CSE-MsgGUID: hyemgLT4T26RdUTPW4z1Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="82145694"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="82145694"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:37:41 -0700
X-CSE-ConnectionGUID: sKCQBi3hRq6W78qhJAuccQ==
X-CSE-MsgGUID: 4F5+1q5SQUaLGUrC84dsLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="234943792"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:37:38 -0700
Message-ID: <9f1aa339-6ee5-4ec2-a3f9-b52961afad37@linux.intel.com>
Date: Wed, 13 May 2026 15:37:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] iommufd: Allow binding to a noiommu device
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
 <20260511184116.3687392-5-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260511184116.3687392-5-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/26 02:41, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Allow iommufd to bind devices without an IOMMU (noiommu mode) by creating
> a dummy IOMMU group for such devices and skipping hwpt operations.
> 
> This enables noiommu devices to operate through the same iommufd API as IOMMU-
> capable devices.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v5:
>     - simplify logic and rename iommufd_device_is_noiommu (Kevin, Yi)
>     - use a helper iommufd_bind_noiommu instead of open coding (Kevin)
>     - move IOMMU cap check under iommufd_bind_iommu() (Yi)
>     - reword comments for partial init (Yi)
>     - misc minor clean up
> v4:
>     - Update the description of the module parameter (Alex)
> v3:
>     - Consolidate into fewer patches
> ---
>   drivers/iommu/iommufd/device.c | 148 ++++++++++++++++++++++++---------
>   1 file changed, 109 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index d03076fcf3c2..4d75720432cc 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -23,6 +23,16 @@ struct iommufd_attach {
>   	struct xarray device_array;
>   };
>   
> +/*
> + * A noiommu device has no IOMMU driver attached regardless of whether it
> + * enters via the cdev path (no iommu_group) or the group path (fake
> + * noiommu iommu_group). In both cases dev->iommu is NULL.
> + */
> +static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
> +{
> +	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && !idev->dev->iommu;

How about using device_iommu_mapped()? As I understand it, this is the
standard way to determine whether a device is protected by an IOMMU.

> +}
> +
>   static void iommufd_group_release(struct kref *kref)
>   {
>   	struct iommufd_group *igroup =
> @@ -30,9 +40,11 @@ static void iommufd_group_release(struct kref *kref)
>   
>   	WARN_ON(!xa_empty(&igroup->pasid_attach));
>   
> -	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
> -		   NULL, GFP_KERNEL);
> -	iommu_group_put(igroup->group);
> +	if (igroup->group) {
> +		xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group),
> +			   igroup, NULL, GFP_KERNEL);
> +		iommu_group_put(igroup->group);
> +	}
>   	mutex_destroy(&igroup->lock);
>   	kfree(igroup);
>   }
> @@ -204,32 +216,19 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   	struct iommufd_device *idev =
>   		container_of(obj, struct iommufd_device, obj);
>   
> -	iommu_device_release_dma_owner(idev->dev);
> +	if (!idev->igroup)
> +		return;

I don't quite follow this logic. Is this check being added specifically
for the new noiommu mode? Since the noiommu mode introduces the
convention that "igroup->group == NULL" implies noiommu, there should be
no cases where idev->igroup itself is NULL.

> +	if (!iommufd_device_is_noiommu(idev))
> +		iommu_device_release_dma_owner(idev->dev);
>   	iommufd_put_group(idev->igroup);
>   	if (!iommufd_selftest_is_mock_dev(idev->dev))
>   		iommufd_ctx_put(idev->ictx);
>   }
>   
> -/**
> - * iommufd_device_bind - Bind a physical device to an iommu fd
> - * @ictx: iommufd file descriptor
> - * @dev: Pointer to a physical device struct
> - * @id: Output ID number to return to userspace for this device
> - *
> - * A successful bind establishes an ownership over the device and returns
> - * struct iommufd_device pointer, otherwise returns error pointer.
> - *
> - * A driver using this API must set driver_managed_dma and must not touch
> - * the device until this routine succeeds and establishes ownership.
> - *
> - * Binding a PCI device places the entire RID under iommufd control.
> - *
> - * The caller must undo this with iommufd_device_unbind()
> - */
> -struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +static int iommufd_bind_iommu(struct iommufd_device *idev)
>   {
> -	struct iommufd_device *idev;
> +	struct iommufd_ctx *ictx = idev->ictx;
> +	struct device *dev = idev->dev;
>   	struct iommufd_group *igroup;
>   	int rc;
>  

Thanks,
baolu
