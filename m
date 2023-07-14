Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F710F4
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 03:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689305306; x=1720841306;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nVIcB82tLh0UA0mJc4/Rq+bVR36taDChNwOAP4F0acA=;
  b=UxmedvMJVluoYuvDdLnE/xDKSbJJiJgdHZbA7IDSJBgEX06QfuxwzkcS
   O9WD8uXlDCrKiqw5TNrPKW3gV6HmHkKLanwLMaSOcOzKhWMpvR/tKw+rE
   7U24ZZqJsPml7BlvUgEhqTea85Rlk4iVn9HATD3qooMtYwGp4uIJ2ldLc
   KQk9oSZZoo68dxF2mrQvgDCMRFof6uvbPQi+D2nlqhIp8eNwIj3QKScm1
   8j/78yZ8GUw9a4v1SB6OAQsERRmfjNXCTK72t5RephuEmlLiQtS5dI80F
   9xJPAYccvmZZq7uNKxv/zBnAW16qYVSjHdwloCFKmI/qq3pMQDTBn1rlE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429144071"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="429144071"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722230755"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="722230755"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.49]) ([10.252.191.49])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:28:19 -0700
Message-ID: <9875863a-eba5-c8fa-a39b-7d3300e3b5ca@linux.intel.com>
Date: Fri, 14 Jul 2023 11:28:14 +0800
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
Content-Language: en-US
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52761F5CDE22E5C3C10E7E728C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/13 15:49, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Thursday, July 13, 2023 12:34 AM
>>
>> -	/* Domain type specific cleanup: */
>>   	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>> -	if (domain) {
>> -		switch (domain->type) {
>> -		case IOMMU_DOMAIN_SVA:
>> -			intel_svm_remove_dev_pasid(dev, pasid);
>> -			break;
>> -		default:
>> -			/* should never reach here */
>> -			WARN_ON(1);
>> -			break;
>> -		}
>> +	if (!domain)
>> +		goto out_tear_down;
> 
> WARN_ON()

Why?

My understanding is that remve_device_pasid could be call in any context
including no domain attached.

> 
>>   		 * large and has to be physically contiguous. So it's
>>   		 * hard to be as defensive as we might like.
>>   		 */
>> -		intel_pasid_tear_down_entry(iommu, dev, svm->pasid,
>> false);
>> -		intel_svm_drain_prq(dev, svm->pasid);
> 
> after removing the 2 lines the comment above becomes stale.

Yes.

> 
>> -static void intel_svm_drain_prq(struct device *dev, u32 pasid)
>> +void intel_drain_pasid_prq(struct device *dev, u32 pasid)
>>   {
>>   	struct device_domain_info *info;
>>   	struct dmar_domain *domain;
> 
> later we should move generic prq handling logic out of svm.c into
> a new prq.c

Yes.

Best regards,
baolu
