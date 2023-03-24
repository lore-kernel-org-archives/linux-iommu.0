Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC12F2D
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679647831; x=1711183831;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DCiN3ZdhQ9Gk5WRDAOIr0yBvgeA5s48pgR7GgQdQ8nE=;
  b=SfcfkG/WJfaBhw7pcKlyYAXs4NsHPTFzuUT1trDhm96MTTMtuTVw4YA8
   cObpyfCXI80b1BJ7iXH39HYxTnA1YR6HmR1XnuwhnMFOex5SDuI5XNSrx
   0ta0895dwGWzL++n3t+cUbwyR/ioyty2khvtZDbIjGuAKtYshcLIF/moH
   dXpIy8xjdxb7ec4POX8KCDabtqavg8we4s8nM5T7SNLW22v4mUlzenxPQ
   2ZiWLziMDj9EbZ120hUfdXLH0MokQa3eoeavLXt75ieuIhOR8buso0mYi
   mYREqA41u8NTMlE4Rh+lSErrGEmPCDh99pFQ0DVzY5AqMZ29DCwIbdXSZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="426001584"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="426001584"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 01:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682612064"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682612064"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.177]) ([10.254.215.177])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 01:50:24 -0700
Message-ID: <62b2ee87-642c-d951-3c5e-9d6f035b5717@linux.intel.com>
Date: Fri, 24 Mar 2023 16:50:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Srinivasan, Raghunathan" <raghunathan.srinivasan@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Allow zero SAGAW if second-stage not
 supported
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20230318024824.124542-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52768EB838F5E7219BE058F08C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768EB838F5E7219BE058F08C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/24 12:49, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Saturday, March 18, 2023 10:48 AM
>>
>> The VT-d spec states (section 11.4.2) that hardware implementations
>> reporting second-stage translation support (SSTS) field as Clear also
>> report the SAGAW field as 0. Reflect this in the sanity check of
>> alloc_iommu().
>>
>> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
>> default")
>> Suggested-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 6acfe879589c..23828d189c2a 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1071,7 +1071,8 @@ static int alloc_iommu(struct dmar_drhd_unit
>> *drhd)
>>   	}
>>
>>   	err = -EINVAL;
>> -	if (cap_sagaw(iommu->cap) == 0) {
>> +	if (!cap_sagaw(iommu->cap) &&
>> +	    (!ecap_smts(iommu->ecap) || ecap_slts(iommu->ecap))) {
>>   		pr_info("%s: No supported address widths. Not attempting
>> DMA translation.\n",
>>   			iommu->name);
>>   		drhd->ignored = 1;
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> btw I wonder whether it's cleaner to record separate agaw values for
> stage1/stage2 instead of picking a minimal set from both in
> __iommu_calculate_sagaw().

That's better. The agaw could be picked according to which stage the
domain is used for translation.

Best regards,
baolu
