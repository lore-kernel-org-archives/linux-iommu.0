Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C8F39FE8
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496134; cv=none; b=QiRocBhr1nbQXnRQClTS26EpspTOPzzTk2MEvqyMrS7Q/uN5e5TMfL6tS1KtgL3xSFiFcEy57Jbi/sm5qLUSeHUhc4Guo7g9uRSoV5o5/0VdDNO1zGiWMXgx+M12KHbcYcw7gR78WQmTzxw+oGS/u9KJN0C2WgwtWjIDfARtyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496134; c=relaxed/simple;
	bh=SDe3bR6/TlqWOlbdFv3L2ztVWoTT66bjZktzp3aZjLc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dXHvSxsxexlXenfLzgozNdlumI9xuJLcct3QlZa0muAreigwThP26zoUW/2sthgFphOqln8BHc8boJx3NxHHwB8JUlI4Gi58DPdaewApPxZACSJh5Zz8dR4lJOUrHsajhH41MWuI1S2y+xkO2Bkiw8Fs3T0uURMOhYn6nNCpuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEdRWadz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEdRWadz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708496132; x=1740032132;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SDe3bR6/TlqWOlbdFv3L2ztVWoTT66bjZktzp3aZjLc=;
  b=eEdRWadzw475LBti7czcmaiKybbsrKesdK4kw6dBvTGMlwWkDkwbq7Pr
   V5VEgeGR02vIcOr3rJ5TxCz5Ce4uf/rVySFnG868rxETNBoU8bmjnTHLH
   PPyMr7gKnSQLs67uzIDAdX49HTaoT9hvI5qn50XG850Jv9VNlb27xl7CM
   S164Px7opyZD85mHcL1I0s4Ck+p46VsmZbIwfHCjlYN0xSoX+QELI6KbW
   IIAFrplaalyipIiXDCYJJSRg97dF9J340UPf9zAA33jUx77GxJJC1hcr+
   ZLHbI+EIrVd/VnBjeEj2FDyHCq7lNN5PO2qmhD8AzhLIMB7YwDNyeLi11
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20177497"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="20177497"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:15:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5391553"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.203]) ([10.249.171.203])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:15:27 -0800
Message-ID: <5f23b7b7-c76f-4076-b12d-909ddddd7905@linux.intel.com>
Date: Wed, 21 Feb 2024 14:15:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] iommufd: IOPF-capable hw page table
 attach/detach/replace
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-7-baolu.lu@linux.intel.com>
 <CGME20240220135755eucas1p24e882cb5a735caed4bbfedb22a811442@eucas1p2.samsung.com>
 <20240220135752.vksznb4rdj73ln6c@joelS2.panther.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240220135752.vksznb4rdj73ln6c@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/20 21:57, Joel Granados wrote:
>> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
>> index e752d1c49dde..a4a49f3cd4c2 100644
>> --- a/drivers/iommu/iommufd/fault.c
>> +++ b/drivers/iommu/iommufd/fault.c
>> @@ -267,3 +267,125 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
>>   
>>   	return 0;
>>   }
>> +
>> +static void release_attach_cookie(struct iopf_attach_cookie *cookie)
>> +{
>> +	struct iommufd_hw_pagetable *hwpt = cookie->domain->fault_data;
> There is a possibility here of cookie->domain being NULL. When you call
> release_attach_cookie from iommufd_fault_domain_attach_dev if
> idev->iopf_enabled is false. In this case, you have not set the domain
> yet.

Yes. Good catch!

> 
>> +	struct iommufd_device *idev = cookie->private;
>> +
>> +	refcount_dec(&idev->obj.users);
>> +	refcount_dec(&hwpt->obj.users);
> You should decrease this ref count only if the cookie actually had a
> domain.
> 
> This function could be something like this:
> 
> 	static void release_attach_cookie(struct iopf_attach_cookie *cookie)
> 	{
> 		struct iommufd_hw_pagetable *hwpt;
> 		struct iommufd_device *idev = cookie->private;
> 
> 		refcount_dec(&idev->obj.users);
> 		if (cookie->domain) {
> 			hwpt = cookie->domain->fault_data;
> 			refcount_dec(&hwpt->obj.users);
> 		}
> 		kfree(cookie);
> 	}

Yeah, fixed.

>> +	kfree(cookie);
>> +}
>> +
>> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>> +{
>> +	int ret;
>> +
>> +	if (idev->iopf_enabled)
>> +		return 0;
>> +
>> +	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
>> +	if (ret)
>> +		return ret;
>> +
>> +	idev->iopf_enabled = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
>> +{
>> +	if (!idev->iopf_enabled)
>> +		return;
>> +
>> +	iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
>> +	idev->iopf_enabled = false;
>> +}
>> +
>> +int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
>> +				    struct iommufd_device *idev)
>> +{
>> +	struct iopf_attach_cookie *cookie;
>> +	int ret;
>> +
>> +	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
>> +	if (!cookie)
>> +		return -ENOMEM;
>> +
>> +	refcount_inc(&hwpt->obj.users);
>> +	refcount_inc(&idev->obj.users);
>> +	cookie->release = release_attach_cookie;
>> +	cookie->private = idev;
>> +
>> +	if (!idev->iopf_enabled) {
>> +		ret = iommufd_fault_iopf_enable(idev);
>> +		if (ret)
>> +			goto out_put_cookie;
> You have not set domain here and release_attach_cookie will try to
> access a null address.

Fixed as above.

Best regards,
baolu
