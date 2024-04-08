Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45A524A6
	for <iommu@lists.linux.dev>; Mon,  8 Apr 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562192; cv=none; b=d+HePcu19oHX+WKESa9lg8Zyy13omHjlenHJwrnyEayro8HCg3uvKn4GoXThBfVpuY7OiY/BJDRc5/qX0KJmci4S9xx3AAs++dGlvwAZoBojSpi3vK+ImhOfBN1A01oNEzFE5cCJGBE+puj27bLWXK88mE28/vSUO3bLxZMNbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562192; c=relaxed/simple;
	bh=K5WJ2W39hUxbbbMrk1S6G3tlaQWOrb0wWioYQgx/+rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flIK/C7GiOWor3ZpkRROKyNTe1maaeoR5ztq92LrA7bBsINyN6wKxCkcegccPcZ+q4gsWek62DInl+sJBr01/RvqOXHwHl+qmJXu5HpjB2dWpu//dk6+ic2Mva1Xw0QL8FouFDLJhNCx6JEzgh3S1MRjS3OJoW3i+9XUNjpg8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0geMGJe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0geMGJe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712562191; x=1744098191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K5WJ2W39hUxbbbMrk1S6G3tlaQWOrb0wWioYQgx/+rI=;
  b=I0geMGJecpQgpzPJD9d066htkluR29asBPEfTMri5elrjZgfqO20jGY6
   cSNPqrHBF7fSw6cVDtNiu1Suq6cq5Kt2obMu9auDJ7Wbfi8l8h/ZK+dBT
   fD36C/KN6P+6CkyH9Hu085QsL+UK891V8DuFxrvAywiIaPYr4Ln0adYac
   FWWxMChDWLmZlPO5jmkEyIHcy1hONkd1HLL4NbByyddVgDBjVoePUOIvB
   Ki4vr/ks/XGDPUotwimhpjdj2rNYAxlUNxSeezvJ9g/CoJq6rQr7Nod4L
   rKFvRWHPZDHGE+PEhYMPsZZbyetZv3JH67tehXrC9YEEb9eUgodKZPTxE
   Q==;
X-CSE-ConnectionGUID: S/0RrHfpSCuYRxsaMCYoiw==
X-CSE-MsgGUID: QXSmxBp6Q02AXDw+18EE+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="18397845"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="18397845"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:43:11 -0700
X-CSE-ConnectionGUID: NmKFEepXRrenryLgOnl8Vg==
X-CSE-MsgGUID: p3CWK1mwStGplzcEbbhlzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="20362104"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:43:07 -0700
Message-ID: <435ea410-6c48-4b0c-9bd3-fa8d85c24668@linux.intel.com>
Date: Mon, 8 Apr 2024 15:43:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
 <20240407144232.190355-2-baolu.lu@linux.intel.com>
 <d2440682-b5f7-47dd-af0b-6eadd3af6220@linux.intel.com>
 <cf0804fe-5d2c-490c-b28f-b23cb3db4b84@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <cf0804fe-5d2c-490c-b28f-b23cb3db4b84@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/2024 3:23 PM, Baolu Lu wrote:
> On 2024/4/8 15:21, Ethan Zhao wrote:
>> On 4/7/2024 10:42 PM, Lu Baolu wrote:
>>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>>> implementation caches not-present or erroneous translation-structure
>>> entries except the first-stage translation. The caching mode is
>>> unrelated to the device TLB , therefore there is no need to check
>>> it before a device TLB invalidation operation.
>>>
>>> Before the scalable mode is introduced, caching mode is treated as
>>> an indication that the driver is running in a VM guest. This is just
>>> a software contract as shadow page table is the only way to implement
>>> a virtual IOMMU. But the VT-d spec doesn't state this anywhere. After
>>> the scalable mode is introduced, this doesn't stand for anymore, as
>>> caching mode is not relevant for the first-stage translation. A virtual
>>> IOMMU implementation is free to support first-stage translation only
>>> with caching mode cleared.
>>>
>>> Remove the caching mode check before device TLB invalidation to ensure
>>> compatibility with the scalable mode use cases.
>>>
>>> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode 
>>> by default")
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/iommu.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 493b6a600394..681789b1258d 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -1501,7 +1501,7 @@ static void iommu_flush_iotlb_psi(struct 
>>> intel_iommu *iommu,
>>>       else
>>>           __iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>>> -    if (!cap_caching_mode(iommu->cap) && !map)
>>> +    if (!map)
>>
>> My understanding, we don't need patch[1/2] at all, and customer is 
>> just asking
>> about the CM & tlb flushing, it is great to have this commit [2/2].
>
> Actually they fix different problems.

Yup, progress view.

Thanks,
Ethan

>
> Best regards,
> baolu
