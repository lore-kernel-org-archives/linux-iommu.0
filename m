Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAFC2AD2C
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729486704; cv=none; b=MCl4Lisk+rc5xfwNK3+q7s7m0epriN3Zs9WSsGK0Gpvf35Od52L+RT1+tJNHqErhsmZsQ6EGs2heax0X5OFtpmI8HVZ8d2ccq/03c2sqZDQUDX4tlyb6TrhTQImNGdOMms2qrF/gZtafoPEHnsZ6oaGLZAZA0JQiBkO8jVPtEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729486704; c=relaxed/simple;
	bh=Q8+VuOTqnxgBnS24Qtoft3ibbhKHEW+35qaNDFy4byw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EeyWjaklGWeiA9eblolwMGZhyWaKPO3JOkHPXR9OjASzf8S+sZ8PPUmZlgDqMGI7wqhvf2WkrgOVffV5QOBZMGdZMKJU7j3ja5Ncr7bM0mOd/naikV/pmXlqLhcXSN9Jx0YPpLsBuyuKYkZyCjX0gcS5FFhCYkmjLoI3gdCUgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTlD9lHN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTlD9lHN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729486702; x=1761022702;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q8+VuOTqnxgBnS24Qtoft3ibbhKHEW+35qaNDFy4byw=;
  b=UTlD9lHNjy1QImStLo1jIrCjXsT2zowgnflmaT81eAF64ApigdFMmSrt
   sHnLF1tbTNOBRdoKxpPj6bKFtegkTVCEJ5yff5EV2Er72ZsW7vLkQ5xq3
   n/3Gw7hj1/yUWIwGrdE56ZCEe66yeOLS9GyPOnAf5owFhn/GCzu7IZCsy
   MtkzFlC59zUDZdp/Fc7/USioFcZZH07Jy4ehH8d3HiZfUs8UpSLAif7Wc
   7eSbk6pbc2+cCqxKK0q4P9F3d/DxmsNRZe5D83/iOaR2npCDFg8Oa4HxP
   uw64li8dHBlrS0XqJd0TCG4mxPlXhQy9DpGyYJ3ZKsF6q7TRGAigiYP+N
   A==;
X-CSE-ConnectionGUID: 3qR1rNAwQEW1MsTDP7qAFg==
X-CSE-MsgGUID: hg7TxwvOQwq91A4WjnIzfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="40342446"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="40342446"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 21:58:19 -0700
X-CSE-ConnectionGUID: dWKnzrk3TSemB22JBsKawQ==
X-CSE-MsgGUID: OOISnCVFSieRIaLYNrBN1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="79425588"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 21:58:17 -0700
Message-ID: <00f9feac-44f6-4a4f-8073-255ebf7b7398@linux.intel.com>
Date: Mon, 21 Oct 2024 12:58:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Vasant Hegde <vasant.hegde@amd.com>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 06/10] iommu/amd: Reduce domain lock scope in attach
 device path
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-7-vasant.hegde@amd.com>
 <20241017133244.GP4020792@ziepe.ca>
 <4b0f1d5d-778d-4161-92e4-8e2ad1c211e9@linux.intel.com>
 <20241018115417.GD948948@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241018115417.GD948948@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/18 19:54, Jason Gunthorpe wrote:
> On Fri, Oct 18, 2024 at 10:38:05AM +0800, Baolu Lu wrote:
>> On 2024/10/17 21:32, Jason Gunthorpe wrote:
>>> On Wed, Oct 16, 2024 at 05:34:57AM +0000, Vasant Hegde wrote:
>>>> Currently attach device path takes protection domain lock followed by
>>>> dev_data lock. Most of the operations in this function is specific to
>>>> device data except pdom_attach_iommu() where it updates protection
>>>> domain structure. Hence reduce the scope of protection domain lock.
>>>>
>>>> Note that this changes the locking order. Now it takes device lock
>>>> before taking domain lock (group->mutex -> dev_data->lock ->
>>>> pdom->lock). dev_data->lock is used only in device attachment path.
>>>> So changing order is fine. It will not create any issue.
>>>>
>>>> Finally move numa node assignment to pdom_attach_iommu().
>>> numa node assignment should only be done during domain
>>> allocation. This is important because the domain can be mapped prior
>>> to being attached and without the right nid table levels will be mis
>>> allocated.
>> Sorry for off the topic, just a question about the domain numa ID.
>>
>> When a domain is about to be attached to a device on a different numa
>> node, what should the iommu driver do? Should it:
>>
>> - Ignore the difference (probably log an informational message);
> I would say silently ignore it..
> 
> The only case that probably does this is VFIO, and VFIO is probably
> doing it deliberately to save memory.
> 
>> - Return -EINVAL to force the upper layer to allocate a different domain
>>    for the device?
> This seems extreme..
> 
> I think if qemu or something wants to optimize this we need to return
> numa information in the get_infos to let it make the right decisions
> about domain allocation without being forced into anything.

Yea, thanks! This aligns with what we have in the intel driver.

Thanks,
baolu
