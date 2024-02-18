Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B1F5667
	for <iommu@lists.linux.dev>; Sun, 18 Feb 2024 04:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708230188; cv=none; b=SJVfs0JbBjqzQWwJOS04nvbGP8vBc0R2zDNTQcMeZWbZ/VIiEtMSgSr0WduPGMgRqTWwVhZePFC/aEaGXwjnHlTj981Mdtssp8SCmaJJrHiWadPuj80ZgbhTD0NHM1BKvgMs0PP0yXAQX9XpIS+LHhoMvGZ2/A3McG7T/kXgRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708230188; c=relaxed/simple;
	bh=m/zDbOZHINOQqbUYOBUJpcOJN2RTLiWenKUMEw8YWUA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bkkm8OV1JSd6qce/BNjd+c1CRoyP+u+gnwqxNMztNglLvvLyLyxNoUzQ3LzuoKHdaGTyXHLNDOOA+UqYQptAj/yeXrlkmMzZGBFe/Ci8aDoeh77LTEBBPd+szVWXakFt0lCelLRDtJhcsawB+SBrwYjo0Zsi/bokua6qAqskldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyEmal1W; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyEmal1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708230186; x=1739766186;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m/zDbOZHINOQqbUYOBUJpcOJN2RTLiWenKUMEw8YWUA=;
  b=UyEmal1Wcmsq3Z1wUCT811vH09K+BLA02kVDCfog4B9KIDyyRwpwL7cc
   LJDAQQnvjPc73vuET1fKyCF0kyNKa9s7vZ4rz7GHuFpy4UsegFZlMpBKs
   CIZrTCzqicmrz+Pz63e/lrnHl3dEKafzioL4QojYy1b+vAwwCnkiWFBB4
   cP3AeN1jGcQTVzWKMwz6cXbJC6B+M/DFEtD++xd5vyJznS7OKAXFcXy2I
   8gs4wkDP7oTAh+xStdt36DCm6gQq/i22O1qs/Ntr5w7RWYGIJ7WQIAoFn
   /p9GH0pI+DzNqNS/jJm8eKPXLJtxwR7Ur+T0vd5mIM6Uq9nVTzQrwEWjd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2468821"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="2468821"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 20:23:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="8863508"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.212]) ([10.254.209.212])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 20:23:02 -0800
Message-ID: <83010db4-d8f7-4ddd-a0dd-9d839ed32232@linux.intel.com>
Date: Sun, 18 Feb 2024 12:22:59 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Huang Jiaqing <jiaqing.huang@intel.com>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Use rbtree to track iommu probed devices
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-2-baolu.lu@linux.intel.com>
 <20240215174708.GC1299735@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240215174708.GC1299735@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/16 1:47, Jason Gunthorpe wrote:
> On Thu, Feb 15, 2024 at 03:22:48PM +0800, Lu Baolu wrote:
>> Use a red-black tree(rbtree) to track devices probed by the driver's
>> probe_device callback. These devices need to be looked up quickly by
>> a source ID when the hardware reports a fault, either recoverable or
>> unrecoverable.
>>
>> Fault reporting paths are critical. Searching a list in this scenario
>> is inefficient, with an algorithm complexity of O(n). An rbtree is a
>> self-balancing binary search tree, offering an average search time
>> complexity of O(log(n)). This significant performance improvement
>> makes rbtrees a better choice.
>>
>> Furthermore, rbtrees are implemented on a per-iommu basis, eliminating
>> the need for global searches and further enhancing efficiency in
>> critical fault paths. The rbtree is protected by a spin lock with
>> interrupts disabled to ensure thread-safe access even within interrupt
>> contexts.
>>
>> Co-developed-by: Huang Jiaqing<jiaqing.huang@intel.com>
>> Signed-off-by: Huang Jiaqing<jiaqing.huang@intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h |  7 +++++
>>   drivers/iommu/intel/dmar.c  |  3 +-
>>   drivers/iommu/intel/iommu.c | 62 +++++++++++++++++++++++++++++++++++--
>>   3 files changed, 69 insertions(+), 3 deletions(-)
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> 
>> +static int device_rbtree_insert(struct intel_iommu *iommu,
>> +				struct device_domain_info *info)
>> +{
>> +	struct rb_node *curr;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
>> +	curr = rb_find_add(&info->node, &iommu->device_rbtree, device_rid_cmp);
>> +	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
>> +	if (curr)
>> +		dev_warn(info->dev, "device already in rbtree\n");
> I would suggest
> 
> WARN_ON(curr);
> 
> Something has gone really wonky at this point, right?

Yes. This is not expected, and it is worth a WARN_ON().

Best regards,
baolu
