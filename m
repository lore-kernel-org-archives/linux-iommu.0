Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C48F62
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463819; cv=none; b=l8SpSkNcDI3juWhlDNDY8UkfX3gkM+5fvCtgbPO1nt1EyOEbT7bPq34tBTRgYlUG7Tblcbof5PZhpeZWrsdUfTCjUYxvimDBhEwl6iUx9VyzQYEuQLgExpbaZlPGLaztrzTkkv0FmUl/J4wcTsT/yXBWbBiJiGqjl3Sb4ECs/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463819; c=relaxed/simple;
	bh=nS1vioMmlFcL+wVN5+oD9svb1qqgpoWUq++JjBbAvNg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ThnP8stPJsZEiLcOuHIgPRMYzzLaaadzztdAjWAkVsUQpduq4vLVYYNh93wbWANSvHvNZYtqn+thAd3+TD2ag+7LRPMN9h+yoixKvHtBnQyuVAWmocNZSHI74LTw9lpszpAxHo87OAWRW01If59+6Fjkk+jUK4ef1RrCWU3Mbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzKlS9xV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzKlS9xV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717463818; x=1748999818;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nS1vioMmlFcL+wVN5+oD9svb1qqgpoWUq++JjBbAvNg=;
  b=ZzKlS9xVkKfhg1C99ImIe5RL04EjrDXPXaXY4RNoTXixPxKEK19ga8VV
   ChgDh42gi6KQtL2h7bYRfDYHhrIhlrAOy5D/vechsX0sk55jjlU99aEog
   3WFNx8H4ah1qrFUGBpFIduPKXM4+VhcxdBxuSf1LziqWxZA46KrvlM819
   clHu929TLx0tJ+kZvK1abC1YMnzhTmfI7uircapXStJmDvYP1LGw5s2Sz
   6wjt4T4Aq+vxlIzhCOy7/tUDFZM+WQd0l6fTWTEEDB2wr82nEUNinDSrl
   MaiacaNKavOZSDOo/YDB2e9jlPlncDCbIRLZCA+V9k6ZZJvoZLKDlINDq
   Q==;
X-CSE-ConnectionGUID: J2WRcc9nRpub1ki5adNT/A==
X-CSE-MsgGUID: QlARIia0Qd+NUzPjWMmUAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25382604"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25382604"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:16:58 -0700
X-CSE-ConnectionGUID: kRC8iBJbR2i0JqodLPwaQw==
X-CSE-MsgGUID: So2ZWZ+cTzSMU59ww0/KbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37044864"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jun 2024 18:16:57 -0700
Message-ID: <7440cd36-41e0-4705-a597-f2ce3f841a70@linux.intel.com>
Date: Tue, 4 Jun 2024 09:14:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
To: "Zhang, Tina" <tina.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20240517003728.251115-1-tina.zhang@intel.com>
 <20240517003728.251115-2-tina.zhang@intel.com>
 <2b390228-190c-4508-b98f-1811c54c9e5c@linux.intel.com>
 <MW5PR11MB588165376224FEA74A0426D989FF2@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <MW5PR11MB588165376224FEA74A0426D989FF2@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 3:37 PM, Zhang, Tina wrote:
>> -----Original Message-----
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Sunday, May 19, 2024 5:43 PM
>> To: Zhang, Tina<tina.zhang@intel.com>; Tian, Kevin<kevin.tian@intel.com>
>> Cc:baolu.lu@linux.intel.com;iommu@lists.linux.dev; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
>> invalidation commands
>>
>> On 5/17/24 8:37 AM, Tina Zhang wrote:
>>> Introduce a new parameter batch_desc to the QI based IOTLB/dev-IOTLB
>>> invalidation operations to support batching invalidation descriptors.
>>> This batch_desc is a pointer to the descriptor entry in a batch cmds
>>> buffer. If the batch_desc is NULL, it indicates that batch submission
>>> is not being used, and descriptors will be submitted individually.
>>>
>>> Also fix an issue reported by checkpatch about "unsigned mask":
>>>           "Prefer 'unsigned int' to bare use of 'unsigned'"
>>>
>>> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
>>> ---
>>>    drivers/iommu/intel/cache.c | 33 +++++++++++-------
>>>    drivers/iommu/intel/dmar.c  | 67 ++++++++++++++++++++-----------------
>>>    drivers/iommu/intel/iommu.c | 27 +++++++++------
>>>    drivers/iommu/intel/iommu.h | 21 ++++++++----
>>>    drivers/iommu/intel/pasid.c | 20 ++++++-----
>>>    5 files changed, 100 insertions(+), 68 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
>>> index e8418cdd8331..dcf5e0e6af17 100644
>>> --- a/drivers/iommu/intel/cache.c
>>> +++ b/drivers/iommu/intel/cache.c
>>> @@ -278,7 +278,7 @@ void cache_tag_flush_range(struct dmar_domain
>> *domain, unsigned long start,
>>>    		case CACHE_TAG_NESTING_IOTLB:
>>>    			if (domain->use_first_level) {
>>>    				qi_flush_piotlb(iommu, tag->domain_id,
>>> -						tag->pasid, addr, pages, ih);
>>> +						tag->pasid, addr, pages, ih,
>> NULL);
>>>    			} else {
>> I'd like to have all batched descriptors code inside this file to make it easier for
>> maintenance. Perhaps we can add the below infrastructure in the
>> dmar_domain structure together with the cache tag.
> Does it suggest we need to add a batch version of qi_flush_iotlb/qi_flush_dev_iotlb/qi_flush_piotlb/qi_flush_dev_iotlb_pasid() in the cache.c file? It doesn't sound like an easy to maintain those functions, does it?

Yes. I don't think it's that difficult as the helpers just compose a qi
descriptor and insert it in a local queue. This local queue will be
flushed after finishing iterating all cache tags, or there's no room for
more descriptors, or switches to a different iommu. Have I missed
anything?

> 
> In this patch, we reuse the current qi_flush_xxx() for both batching and non-batching processing, so that we don't need to duplicate the logic of qi_flush_xxx() in two places with one for batching processing and the other one for non-batching processing. What do you think?

I don't like to put different things in a single helper. They share some
code, for example, composing the descriptor's dw words. Others are just
different. You can move that code into a static inline if you would
like, but the batching and non-batching processing should be in
different helpers.

Best regards,
baolu
