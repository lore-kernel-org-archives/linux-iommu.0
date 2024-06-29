Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA008475
	for <iommu@lists.linux.dev>; Sat, 29 Jun 2024 03:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719633512; cv=none; b=ubbsrOHBE2GyWvIPzr9NSpp2VEnMlpIik+6Yz8zLYClc+r52PIY9lXo0V9CPZP+cd3sayZpGrXogg/BIz3YPzDDrmvY4qMqIw3Ie3mIcjF5YdRDQTAUvX4CqdkD8wXxRLzYrWotFCkSQSiFToYKN0SkAW/M3wwCF9D63e2zqR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719633512; c=relaxed/simple;
	bh=KAM2m2vrRAt/9MTW/snw1O4VivECpPi3UISTEE8FRps=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c9NWwM1p1lCAg6HyBahPHGpZE3hXIODUjRtye2/KevQkhWHUM2+crtemo1qfGPpJ0o4hXO8WWKsiLvgLPhgVEZh4IHjBt5DCJtRPjfulrFxpNrwOJ4XH7scgCJ4LIJX7W0jM4e+FVYGqN271DgE5Ydi0cVNCYCoh81thW/cH56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CR8ShcwT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CR8ShcwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719633510; x=1751169510;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KAM2m2vrRAt/9MTW/snw1O4VivECpPi3UISTEE8FRps=;
  b=CR8ShcwTJ64CEWm3NOI2KQ37RSRTVSwwFTvxPwuGFHl7BY7coNF0Fgli
   5ASRXtutaZQsLNTK8+WlV7A8/OGR4FFs0vByymJPPvEhhSlAu6Xm1WriN
   zsQsxuqc0KGPCdl/Aq5IWOhq51xeorsa9hPp6okmisvPe29ngC1lPCCD5
   JqdqCg4VnJUx7Ns1cUSVyEydnVqaEZ7zTklyLByiMkziF6wpKI7G3QFoZ
   8dmLuR9kZRXMQWCsE6UDEGKx+7mhF1zlMdbN9Igz6xi6B6zFtZMMtzdDt
   3kuuFqwHhezZePcD9XiavRuqQjoYa6jGvti/uRp9f0uotqnWNIBJSQ9+C
   A==;
X-CSE-ConnectionGUID: 9U+DShuUQ/CgfWBys9n0Aw==
X-CSE-MsgGUID: CPyCjHLCSqeUVqfrnlu3/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="42247198"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="42247198"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 20:58:06 -0700
X-CSE-ConnectionGUID: o/L9obIOSLqrGV1okJ2tdw==
X-CSE-MsgGUID: yu2LNLFdQwGzf1VGpU5Dfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="45004877"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 20:58:03 -0700
Message-ID: <4bda68fb-0aa4-4160-8e8a-7024938ea525@linux.intel.com>
Date: Sat, 29 Jun 2024 11:58:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/10] iommu: Extend domain attach group with handle
 support
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-5-baolu.lu@linux.intel.com>
 <Zn8luxc+RLBOIIX0@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Zn8luxc+RLBOIIX0@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/29 5:06, Jason Gunthorpe wrote:
> On Sun, Jun 16, 2024 at 02:11:49PM +0800, Lu Baolu wrote:
> 
>> +int iommu_replace_group_handle(struct iommu_group *group,
>> +			       struct iommu_domain *new_domain,
>> +			       struct iommu_attach_handle *handle)
>> +{
>> +	struct iommu_domain *old_domain = group->domain;
>> +	void *curr;
>> +	int ret;
>> +
>> +	if (!new_domain)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&group->mutex);
>> +	ret = __iommu_group_set_domain(group, new_domain);
>> +	if (ret)
>> +		goto err_unlock;
>> +	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
>> +	if (handle) {
>> +		curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
>> +		if (xa_err(curr)) {
>> +			ret = xa_err(curr);
>> +			goto err_restore;
> But this error unwind doesn't work because the xa_erase() already
> happened and there may have been a handle there that we don't put
> back.

Yes, you are right.

> 
> Something like this - store to a reserved entry cannot fail:

This code looks good to me. Thanks!

Best regards,
baolu
