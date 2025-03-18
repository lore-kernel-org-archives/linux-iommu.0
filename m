Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152420C482
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303981; cv=none; b=AHGmGEmn6xhLhU0hzePBlMM7/tFXvGDxU9rsrz3mnPjG2FR/gpi8YLBIwsPSdNhYLPa5xVW9F7rtATEjzEauiCylLHCoigSR5EU6cl7PxEjwrVyzNPtNH52td7Qb7Sv4KCcW6jVSWxjw9lYD3oYaKvEzjkPyOcd+y/jzU586/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303981; c=relaxed/simple;
	bh=mAuH0S02yMCdtPuWVY9sxG79ge2AvLgJkSor1CmebnM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SPY3mk4wupjjp12AFQOHcFoLNmJY4wEgQ4xS36JXNVsJ0BTT25YjmxJvsTOto1famcMYqcjex3qDBKRvd1R60kwPnT/NfeK85CNrA5mIw1whUi6G/4Q+ZmQ0WX4gvfWGUkRMHJAC8q0JBYJ0Ur+LTAz+J8Kozw0s9D+sjlrz3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9Xs37Oa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9Xs37Oa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742303977; x=1773839977;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mAuH0S02yMCdtPuWVY9sxG79ge2AvLgJkSor1CmebnM=;
  b=d9Xs37OagSOcgReoJCPpIkkD0eexfOwfzY4VX9L30l6JYAhPQpJlvPOH
   pJeIfbVIMQi0ZIiG/aoD3958qHqW7HcmwkPy3JirNX/jqAvLi0tozEcZU
   042B2FdWQHAABU7GJJN4TfzK013Jk0ckTP3nuXIIMbs+ShoTwKpR8/X2+
   H7wQSQx+egAp5Ump4RuLaKpAbc5NmJJrUvC4KcuVjidqmSJhjY2rESKrG
   uxdM2aRtm7oE6eq+jI+z6UKVbPP/NemmBEqDG+6KZTkTof6M8OjJKWqvv
   7jr7F190Kv4lkRF32Bfk2nfK/JxVn57yxlxyCJintCMpEava//q2apbz1
   w==;
X-CSE-ConnectionGUID: +gi7l1+MSlm6hurxx1KBzw==
X-CSE-MsgGUID: 048zU5wbTwKq8Ljpf/yKXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43360026"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43360026"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:19:36 -0700
X-CSE-ConnectionGUID: IaVQRtKCR725LYbzUUHy/Q==
X-CSE-MsgGUID: hNvzQEnoQ9Kjh9n2yZoyTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="122232135"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.41]) ([10.124.241.41])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:19:32 -0700
Message-ID: <b5cfd488-645e-4448-9544-35cb677772d0@linux.intel.com>
Date: Tue, 18 Mar 2025 21:19:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/8] iommu/vt-d: Put iopf enablement in domain attach
 path
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <20250313051953.4064532-4-baolu.lu@linux.intel.com>
 <010af39d-6158-4aa8-90ad-0084d5767e2d@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <010af39d-6158-4aa8-90ad-0084d5767e2d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/2025 5:58 PM, Yi Liu wrote:
> On 2025/3/13 13:19, Lu Baolu wrote:
>> Update iopf enablement in the driver to use the new method, similar to
>> the arm-smmu-v3 driver. Enable iopf support when any domain with an
>> iopf_handler is attached, and disable it when the domain is removed.
>>
>> Place all the logic for controlling the PRI and iopf queue in the domain
>> set/remove/replace paths. Keep track of the number of domains set to the
>> device and PASIDs that require iopf. When the first domain requiring iopf
>> is attached, add the device to the iopf queue and enable PRI. When the
>> last domain is removed, remove it from the iopf queue and disable PRI.
> 
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> 
> a nit. It appears to me the PRI cap and IOMMU PRI enable bit is set in the
> probe_device() now after the below patch. This commit now is more dealing
> with iopf_refcount and adding the device to the iopf queue.
> 
> https://lore.kernel.org/linux-iommu/20250228092631.3425464-6- 
> baolu.lu@linux.intel.com/

Yes. With the device not adding to the iommu iopf queue, the IOMMU core
will respond to the device with IOMMU_PAGE_RESP_INVALID.

Thanks,
baolu
