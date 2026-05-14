Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D631327A
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741486; cv=none; b=IkpmdSx7WxH+ub+SyIr6ek9TsET/U5TAciU3QvSaA9MixoteYMSkqczHcp7s1AyYX6TbWVFMS+qwwQcGrGtdmdOYrzlGD+tsX9HSmvv9WEKDq1k/EG3og4kzh5thwtNOrYuuhVfFIs1Z89Pw1U2fdzo2RO3a4j7l9eOAIvD31yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741486; c=relaxed/simple;
	bh=7Ug8XdNHslpaRmetTy4+Gn9igrW5k/TzBklI0olIGjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsiB5rFDx8l9aA25u6WoCxVa9vbFegOFliRv8o7T6uW/b1vgu59jmjyfzqGDNl8A157wvq9I5d1phOTicWTOK7JtfeB2JPCpDAbwPx9lhHqHHSQ90KAjwUYx+RWQZ2z2UibFgpylJS4SGJXx44pxyOhkVf3KPUPYtd+qLSa/4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvzOm0w6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvzOm0w6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778741486; x=1810277486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Ug8XdNHslpaRmetTy4+Gn9igrW5k/TzBklI0olIGjk=;
  b=SvzOm0w63crUL/7ENbhpfDwP90vAiiyAcgB0NtIIx+kEGw0tNktcNoh5
   RKdCOMIgK4QwB8591eRl7aeVSqwvh0DZmpkGSN8PkD4252nOfy3yKqwOf
   5rv8yfw59ZTzUDSXOUuYzVAps52vZg2p37G8OppOnKpO//qp3l6giUhTv
   ulfPOgWlghceJsAcJyEI4I7D8WguTBWBtoO+9Lkd8F4y4PUOjQRnM6Zjk
   I7zzRr8gJslofRyf+PFjT1v8PvXEnLeSI0gYeyDd3WIV13fpZ9GY8/6cY
   yyAzlK6Tsl+LSYm+jn1u2/dg+aCPxKdETHK7NfiHFogiYKHsCkgC0sP6C
   g==;
X-CSE-ConnectionGUID: JSAnb7p/TdyhsxcscuvLKA==
X-CSE-MsgGUID: 9f5DCHQNRfu0w45MU4nccA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79391736"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="79391736"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 23:51:25 -0700
X-CSE-ConnectionGUID: y0dZ/LN9R2yUqiV3rNxGtA==
X-CSE-MsgGUID: IfViw1GcQQKsYJIlPzL5PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="234029778"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 23:51:21 -0700
Message-ID: <c15c4d4d-89a8-4ad9-86e2-e1adb3ff8b54@linux.intel.com>
Date: Thu, 14 May 2026 14:51:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] iommufd: Allow binding to a noiommu device
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
 David Matlack <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 skhawaja@google.com, pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-5-jacob.pan@linux.microsoft.com>
 <9f1aa339-6ee5-4ec2-a3f9-b52961afad37@linux.intel.com>
 <20260513150800.000027e5@linux.microsoft.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260513150800.000027e5@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/26 06:08, Jacob Pan wrote:
>>> +}
>>> +
>>>    static void iommufd_group_release(struct kref *kref)
>>>    {
>>>    	struct iommufd_group *igroup =
>>> @@ -30,9 +40,11 @@ static void iommufd_group_release(struct kref
>>> *kref)
>>>    	WARN_ON(!xa_empty(&igroup->pasid_attach));
>>>    
>>> -	xa_cmpxchg(&igroup->ictx->groups,
>>> iommu_group_id(igroup->group), igroup,
>>> -		   NULL, GFP_KERNEL);
>>> -	iommu_group_put(igroup->group);
>>> +	if (igroup->group) {
>>> +		xa_cmpxchg(&igroup->ictx->groups,
>>> iommu_group_id(igroup->group),
>>> +			   igroup, NULL, GFP_KERNEL);
>>> +		iommu_group_put(igroup->group);
>>> +	}
>>>    	mutex_destroy(&igroup->lock);
>>>    	kfree(igroup);
>>>    }
>>> @@ -204,32 +216,19 @@ void iommufd_device_destroy(struct
>>> iommufd_object *obj) struct iommufd_device *idev =
>>>    		container_of(obj, struct iommufd_device, obj);
>>>    
>>> -	iommu_device_release_dma_owner(idev->dev);
>>> +	if (!idev->igroup)
>>> +		return;
>> I don't quite follow this logic. Is this check being added
>> specifically for the new noiommu mode? Since the noiommu mode
>> introduces the convention that "igroup->group == NULL" implies
>> noiommu, there should be no cases where idev->igroup itself is NULL.
>>
> idev->igroup can be null on error path only, not limited to noiommu. It
> is the partially initialized idev case.
> /*
>   * iommufd_device_destroy() handles partially initialized idev,
>   * so iommufd_object_abort_and_destroy() is safe to call here.
>   */
> 
> How about add this comment?
>   /* igroup is NULL when destroy called during bind error cleanup */

If it's not limited to noiommu, why not making it in a separated patch?

Thanks,
baolu
