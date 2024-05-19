Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18F12E4D
	for <iommu@lists.linux.dev>; Sun, 19 May 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716113767; cv=none; b=XjJ2yNuxgseA49vbxqPAJGLSxNSaugcF9wZJxcOzuVC3PepKsgIYwHoR1FUGr1oG8524+lEBlAYBrF+jmqnYj4YdF8dIP1JqRyGoiLHdNSTSUA6MMTdIpCho3BPiZxsmUM9C4FYtvlawfO3AWKT9FFtgpa7Y/vqFibwoXNNxpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716113767; c=relaxed/simple;
	bh=VKnSetxDAoXP/ZBCUBNfgL1hEJz3ci3eugGSDxO0V6w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d9BQK+7gDSsGZEScwMhh/rsM1uzwevesqdnf2rPwkJWXgJXx4Fc0KtLFgvhzwyLHp0MCafnjEAdPZDKsR+99G0BrQx/mPr6ikDBumOF3VSb5Ex915BuZAutNueeG0RLCwbAYjmFZ0sUSWRQ4D3/+yv7FIuToLlz7CooujaWThyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAt3YfQ5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAt3YfQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716113766; x=1747649766;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VKnSetxDAoXP/ZBCUBNfgL1hEJz3ci3eugGSDxO0V6w=;
  b=dAt3YfQ5SKHmq33vXgKwvEUbfSZGlHthJA7P0c/088YXuthLFPiRjcnZ
   tzrXNAOyAUW8AYLgQKQJG0UDqPGYkzmhB2Eddn6c4X9nxngEqq8GTnq/L
   HVMe5aQRIwg3jld/e4PQ5pbGw4mqeguHFBOKfw8RWWcpvCoGNl88qovG5
   g0Q4iN3DXhJ3YiNbpAsbL2EFIIz/5QVVfSD3hwy9fGHv/tgYMdJAmJx3j
   Aq0FHBw+WJ7qWN1HYrffheJfcxdo+BAHYYiKPahjRj8UtSb5P4XdZr/U6
   0dk/WbgTlM+Opl+hjMhIiH41PqdyeannSTPo3cU7eG97qdDiyQjZD5uPC
   w==;
X-CSE-ConnectionGUID: ah7zMIDyRf2WLhJwfDwMyQ==
X-CSE-MsgGUID: H5JCB9UfSeWmJAXbY96lUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="23392649"
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="23392649"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 03:16:06 -0700
X-CSE-ConnectionGUID: zahNnwR3SQawlWRiO68LUg==
X-CSE-MsgGUID: xqV9xgJ0QVCRuviYWR/4iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="32257604"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 19 May 2024 03:16:02 -0700
Message-ID: <604d8d9c-6b9d-4cd3-91e7-79923b044472@linux.intel.com>
Date: Sun, 19 May 2024 18:14:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/9] iommu: Replace sva_iommu with iommu_attach_handle
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527615219EEF0EF3EACCF38D8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527615219EEF0EF3EACCF38D8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 3:21 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>>
>>   #else
>> -static inline struct iommu_sva *
>> +static inline struct iommu_attach_handle *
>>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>>   {
>> -	return NULL;
>> +	return ERR_PTR(-ENODEV);
>>   }
>>
> 
> this should be a separate fix.

Yes. It could be a fix.

> 
> existing drivers (idxd and uacce) only check IS_ERR() on the return
> value. A Null pointer may lead to an error reported at a later point.

Though I don't think it could cause any real problem because this
interface should always be called after the sva enabling one.

Best regards,
baolu
