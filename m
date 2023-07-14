Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EF16AA4
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 05:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689313648; x=1720849648;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M2Op5B60rK/IAOYu+Mr1yoo/u96NcZpWns/Z2ATpcG8=;
  b=mJTEwyMqa5Fj1+on2U0CGcwip6sAtUyM3C1JO+pXiQmNREQuEW+bVrJd
   atejlXqE176JUc7ZDxktKYfslYojU5iHNvJ4PWNoURcsBL9NOxRP1L+oR
   L1pxPfMIiovDJH+mjD2noEUG2i3ShFs1V79eG2FdSduGIh06yoh2u0zSy
   V6LMl+TExos0uGkjtntCEdOmcWXUfZTA06/s5ykIm+qk/Ck+WMPLGVJhW
   lWztG4RHo3AhI5/w9pnpu35eFELqCkPf9xzC55ohaHM2qc2xh4iUT3eT/
   H9C9MPA0kK4l1QuG9fdBToDudWIpBPTKImZ4g28gLONdKSvpJC9QY+i0z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429162340"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="429162340"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 22:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787720793"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="787720793"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.116]) ([10.252.187.116])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 22:47:21 -0700
Message-ID: <29fa2860-cbf2-04c8-4d16-138668ffea25@linux.intel.com>
Date: Fri, 14 Jul 2023 13:47:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Will Deacon <will@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v10 5/7] iommu/vt-d: Make prq draining code generic
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-6-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52761F5CDE22E5C3C10E7E728C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9875863a-eba5-c8fa-a39b-7d3300e3b5ca@linux.intel.com>
 <BN9PR11MB52763423F2A18E927065C8EA8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763423F2A18E927065C8EA8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/14 11:49, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, July 14, 2023 11:28 AM
>>
>> On 2023/7/13 15:49, Tian, Kevin wrote:
>>>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>> Sent: Thursday, July 13, 2023 12:34 AM
>>>>
>>>> -	/* Domain type specific cleanup: */
>>>>    	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>>>> -	if (domain) {
>>>> -		switch (domain->type) {
>>>> -		case IOMMU_DOMAIN_SVA:
>>>> -			intel_svm_remove_dev_pasid(dev, pasid);
>>>> -			break;
>>>> -		default:
>>>> -			/* should never reach here */
>>>> -			WARN_ON(1);
>>>> -			break;
>>>> -		}
>>>> +	if (!domain)
>>>> +		goto out_tear_down;
>>>
>>> WARN_ON()
>>
>> Why?
>>
>> My understanding is that remve_device_pasid could be call in any context
>> including no domain attached.
>>
> 
> oh I'm not aware of that. Can you elaborate the usage which uses a pasid
> w/o domain? pasid needs to point to a page table. Presumably every
> page table should be wrapped by a iommu domain...

A case I can think of is error rewinding. A domain is being attached to
multiple pasids. When one of them is failed, remove_device_pasid should
be called on all pasids so that they are parked at a determinant state.

On the other hand, I don't want the remove_device_pasid to be the
counterpart of attach_dev_pasid. remove_device_pasid simply denotes:

- The pasid will be parked in blocking state;
- If any domain that has been attached to this pasid, stop reference to
   it any more. Otherwise, there might be use-after-free issues.

Hence, remove_device_pasid should never fail.

Best regards,
baolu
