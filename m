Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67788488
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4v1ewGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699931871; x=1731467871;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jwo/jHiMXyVUADYct4D+5LfJifoti2Yg0Flyy8wZEW0=;
  b=n4v1ewGb7Dw9lzEUSbo3j+Bejtablc1HGxCavj/zKo8kNuq3/9wXNtIB
   fzPvab2OtimlXbHufwtUVlbCPlYWI+XS4nzRwASRt/Z/QKkBSEu90oAnG
   GDLlFaETxu6VHvX0hXxl/UfXXTw11sEcUPKC5NWbDIEnPIUGQbQbKRtYM
   C8tUomOyvYK1FzIqMctxeaXeuDL/rJoB3WCsFOxYQj+pWZfiwsCtHcIlk
   z0XRW5fWm9YpLssUAoykCdwSftPXXZPiUj1S7qVYYPlwxbCk+AJOm+KfQ
   Tj3uRM7fAdhQpoLjunJTPTbBH0PTTt6O/phypAvopW2XGvQbahI40XbUQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389424493"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="389424493"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 19:17:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="758018670"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="758018670"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2023 19:17:48 -0800
Message-ID: <1a07a265-f834-4834-b9cb-5c7016ee9142@linux.intel.com>
Date: Tue, 14 Nov 2023 11:13:37 +0800
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
Subject: Re: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52764263BE04AAFAC0907A8D8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764263BE04AAFAC0907A8D8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/23 11:14 AM, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, November 14, 2023 9:11 AM
>>
>> The latest VT-d spec indicates that when remapping hardware is disabled
>> (TES=0 in Global Status Register), upstream ATS Invalidation Completion
>> requests are treated as UR (Unsupported Request).
>>
>> Consequently, the spec recommends in section 4.3 Handling of Device-TLB
>> Invalidations that software refrain from submitting any Device-TLB
>> invalidation requests when address remapping hardware is disabled.
>>
>> Verify address remapping hardware is enabled prior to submitting Device-
>> TLB invalidation requests.
>>
>> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
>> default")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index a3414afe11b0..23cb80d62a9a 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1522,6 +1522,15 @@ void qi_flush_dev_iotlb(struct intel_iommu
>> *iommu, u16 sid, u16 pfsid,
>>   {
>>   	struct qi_desc desc;
>>
>> +	/*
>> +	 * VT-d spec, section 4.3:
>> +	 *
>> +	 * Software is recommended to not submit any Device-TLB
>> invalidation
>> +	 * requests while address remapping hardware is disabled.
>> +	 */
>> +	if (!(iommu->gcmd & DMA_GCMD_TE))
>> +		return;
>> +
> Is it a valid case to see such request when the iommu is disabled?
> If not then let's add a WARN.

There might be valid cases. The VT-d translation is turned on after all
devices get probed.

Best regards,
baolu
