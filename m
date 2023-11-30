Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E813AC8
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVGtWnK9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701324598; x=1732860598;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=od25jifz4eVRuBZX5AfB3lIKHX+oCAQS49YG9v4v83A=;
  b=RVGtWnK9814m7yt9ohUCa69m/zytbToX3NI/lGsvOQA57Xi36+p3sExV
   KkTW4m0MhFAIZAXwMfoR94sVWl7O1Tdpp79ob5Eu14xiTkxcQOkz9fZIF
   TxSxHVEXk9+TiWV2YJFdU8ELl+1WcuF+Xe41g3hieCI2DOGiVv6bIFQf2
   oLW86u8st+CYWGpqROsYn3g9TGXolk7AzSz3Y0WbkyeIF3atPal7NT9a/
   hApz9HxLLCrhSocGu+ZL77k95rj2jolQQlp3MYAZzuHehzhDS3d1LXvtp
   Omz+YpXqenotbAL2+4wTiJ7z8lY3gb4bM4DSgbTEj4onLDzUr7XUCJAKa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="154301"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="154301"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 22:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="913087219"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="913087219"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.155]) ([10.249.171.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 22:09:54 -0800
Message-ID: <1af87099-ad52-4b34-a87c-f12925903a15@linux.intel.com>
Date: Thu, 30 Nov 2023 14:09:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/vt-d: Add support for static identity domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20231120112944.142741-1-baolu.lu@linux.intel.com>
 <20231120112944.142741-5-baolu.lu@linux.intel.com>
 <20231129202615.GN1312390@ziepe.ca> <20231129202851.GG436702@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231129202851.GG436702@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/30 4:28, Jason Gunthorpe wrote:
> On Wed, Nov 29, 2023 at 04:26:15PM -0400, Jason Gunthorpe wrote:
>> On Mon, Nov 20, 2023 at 07:29:43PM +0800, Lu Baolu wrote:
>>
>>> @@ -2311,6 +2316,13 @@ static int device_def_domain_type(struct device *dev)
>>>   			return IOMMU_DOMAIN_IDENTITY;
>>>   	}
>>>   
>>> +	/*
>>> +	 * Hardware does not support the passthrough translation mode.
>>> +	 * Always use a dynamaic mapping domain.
>>> +	 */
>>> +	if (!ecap_pass_through(iommu->ecap))
>>> +		return IOMMU_DOMAIN_DMA;
>>> +
>> Doesn't this return from def_domain_type completely prevent using an
>> identity domain?
>>
>> I thought the point of this was to allow the identity domain but have
>> it be translating?
> I suppose the answer is the next patch deletes that stuff.
> 
> I would probably have structured this in the other order, first add
> this hunk and say that old HW is being de-supported. Remove all the
> now-dead code creating the 1:1 page table, then refactor the remainder
> to create the global static.

Okay, that would be more readable.

Best regards,
baolu
