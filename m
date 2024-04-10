Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988D15920E
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745490; cv=none; b=gpl2nB2GsG6OiJ9ApUrXSaShUOSHO/AnG9xVocZdrB5SMZS2bU12dxe/KIblUD6plHfLV8dJzddybB+nGsX5R7AObFfKwzmDSmOyX0rVDaGgbFRWh6LRJ9V+/ljqrLQCdaPjgiZWHy4peaSovEmKP6lusBexcWCx7RPON0otcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745490; c=relaxed/simple;
	bh=mBpMkwijDdLKp6zgkHLkxY2Lt4gRI+DEFEErvrmmbQ4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y2uYskLlEr/rxWdTS6SFAJ+xsGVc00wrF/TCKKE/44lvF5VZuJXEWWKoY9bTBRxAAnikR7hMxkHVKekFTCHrkvKnFWU+IrjFp3pr35CtFKcnZ1wUW4VLKzyQopSRDHZUjOV3R2uPzUrrlJkNrF2H3MvZ/YvOdZCOsrmdJwKjeSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pg4maN/N; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pg4maN/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712745489; x=1744281489;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mBpMkwijDdLKp6zgkHLkxY2Lt4gRI+DEFEErvrmmbQ4=;
  b=Pg4maN/NUSVl//bRwgJg31Z0MIGYlRrKdLY0vd92G9MV8s9D+F6Mw5IR
   Xbe6MJQAV+7fEnIHGAM7en3e0Y7YVHT8vLEW/2AgjcJp0fxpkm6CzpLlm
   WBbq1np9fQD+oClYcJH8VKQ0icD/HptvqpJF70a4iTcivct7bMOdpMnfG
   yHw7Ozdwth9HdFFKm/f25lqzFfPd1gEYDe274iIq2T7tM3TEOaNIeFh7M
   Z0K5+LXKBUoGFV9YC6+MiTW6tog7Qi9LzpqTZqohXPvYaCDInXGj01Dz6
   OIAXEcTaruGTg3Js5pxXLraxKjbOS0QKJd73x6kXarCbOlxNelNq6ggks
   g==;
X-CSE-ConnectionGUID: ltoy9F7JRZ+qlnv7nIgsaA==
X-CSE-MsgGUID: cPJkhjBYSxSusM/noUF2Hw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33505951"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33505951"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:38:08 -0700
X-CSE-ConnectionGUID: ByMdd/tAQwq+2COY48b6SA==
X-CSE-MsgGUID: hYre0rH7R42ONS8FG65ZkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25204498"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:38:05 -0700
Message-ID: <776ef2f1-747d-46f0-94be-747c6fca8ce0@linux.intel.com>
Date: Wed, 10 Apr 2024 18:38:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev
References: <20240410055823.264501-1-baolu.lu@linux.intel.com>
 <7e78917f-f84c-4e98-a612-73b8013ae367@intel.com>
 <0231631b-44ca-45ee-adf9-0a5c8852cc27@linux.intel.com>
 <be0b254d-d6c0-4a94-8234-936f40538bbc@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <be0b254d-d6c0-4a94-8234-936f40538bbc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/10 17:14, Yi Liu wrote:
> 
> 
> On 2024/4/10 16:02, Baolu Lu wrote:
>> On 2024/4/10 14:30, Yi Liu wrote:
>>> On 2024/4/10 13:58, Lu Baolu wrote:
>>>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>>>> implementation caches not-present or erroneous translation-structure
>>>> entries except the first-stage translation. The caching mode is
>>>> irrelevant to the device TLB , therefore there is no need to check
>>>> it before a device TLB invalidation operation.
>>>>
>>>> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
>>>> mode check before device TLB invalidation will cause device TLB
>>>> invalidation always issued if IOMMU is not running in caching mode.
>>>> This is wrong and causes unnecessary performance overhead.
>>>
>>> I don't think the original code is wrong. As I replied before, if CM==0,
>>> the iommu_flush_iotlb_psi() is only called in unmap path, in which the
>>> @map is false. [1] The reason to make the change is to make the logic
>>> simpler. 🙂
>>
>> Oh, I see. There is a magic
>>
>>          if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
>>                  iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
>>
>> in __mapping_notify_one().
>>
>> So if it's caching mode, then
>>
>>   - iommu_flush_iotlb_psi() will be called with @map=1 from
>>     __mapping_notify_one(), "!cap_caching_mode(iommu->cap) || !map" is
>>     not true, and device TLB is not invalidated.
>>   - iommu_flush_iotlb_psi() will also be called with @map=0 from
>>     intel_iommu_tlb_sync(), device TLB is issued there.
>>
>> That's the expected behavior for caching mode.
>>
>> If it's not the caching mode, then
>>
>>   - iommu_flush_iotlb_psi() will be called with @map=0 from
>>     intel_iommu_tlb_sync(), device TLB is issued there.
>>
>> That's also the expected behavior.
>>
>> So the existing code is correct but obscure and difficult to understand,
>> right? If so, we should make this patch as a cleanup rather than a fix.
> 
> aha, yes. As the below table, iommu_flush_iotlb_psi() does flush device TLB
> as expected. But there is a NA case. When CM==0, it should not be possible
> to call iommu_flush_iotlb_psi() with @map==1 as cache invalidation is not
> required when CM==0. So the existing code logic is really confusing,
> checking @map is enough and clearer. Since the old code works, so perhaps
> no fix tag is needed. :)
> 
> +----+------+-----------+------------+
> |  \       |            |            |
> |   \ @map |            |            |
> | CM \     |      0     |     1      |
> |     \    |            |            |
> +------+---+------------+------------+
> |          |            |            |
> |     0    |      Y     |     NA     |
> +----------+------------+------------+
> |          |            |            |
> |     1    |      Y     |     N      |
> +----------+------------+------------+
> 
> Y means flush dev-TLB please
> N means no need to flush dev-TLB
> NA means not applied

Yes. We have the same understanding now. :-)

> 
> BTW. I think it is better to have the below change in a separate patch.
> The below change does fix a improper dev-TLB flushing behavior. Also
> how about Kevin's concern in the end of [1]. I didn't see your respond
> about it.

I had an offline discussion with him and I included the conclusion in
the commit message of this patch.

Best regards,
baolu
