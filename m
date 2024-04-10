Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6911C0DD9
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736154; cv=none; b=RrzgDaO+AIlSaxuDIjFr/uckyCxu9fnbm+K6Qouq+i/iDRDLQzMN9Z1pYSdEKiYALBM6gpDYStOW5wNjx9ieGmT9noNlG+aUAE7WaGPFlf+GVP9UobGh91bjxo4N9mg6m7ky+E2MhopImVqvWuw2EgBKfzKn5guF+jJrJkZUBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736154; c=relaxed/simple;
	bh=ns5iFXaPS2mOe7i63bnwPeaQB9a+vK/75Dv/SXu4kPo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oiH3Nucbxr13og/9ejMmk7OnI1/p/M2+5rZ71lGQanIBMc+F6qymZscnkQKKFZ6C8DZbZdDzmLK3LEvIYIHrOjtZDEr7e5irbf6SU67FpfxgvO2c20TnPSrLZWbQbUfb6ZDUDGLEEkhh8R6g54uTJ1+AktW5FUEhjkvqkhuuIzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSExtxRg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSExtxRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712736153; x=1744272153;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ns5iFXaPS2mOe7i63bnwPeaQB9a+vK/75Dv/SXu4kPo=;
  b=hSExtxRgLzKZxJFnywSUTnSxtSPPz7K9ty0DLLye0+uijG1Yo3/33p6N
   ni42G+mPEf8BkQCPvumPUrsf2KXZe9djbtf+lKSq9NqDNlrat7pG00ESz
   J4d/j/mcTPk8XELV2dCqJrBkFws/Hy79BVEvyjfr+E5Z71MhrHIVfrOKS
   j1OYPpjjuKcNHkoITyxyyMt1ff7yactwweM7RB6aXAZ5nkKWnmlWudYEQ
   e4LxHD7ICtwL03Rmq5by5oy+x3YuMemcEi4ZYpSvOlEb+epfMg40tSlZ6
   APJvF8uR9wlYgEYCBIvgP1j0zPmTo5R/zqURlpFKxPgzl1Xulw7bGgflo
   w==;
X-CSE-ConnectionGUID: AhkDqFV0RHuB0csTx2nIhQ==
X-CSE-MsgGUID: bnMB53jZQkqGO5DlTryQZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33488835"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33488835"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:02:29 -0700
X-CSE-ConnectionGUID: YatJKCZ1SROZ0ZlY2uIrig==
X-CSE-MsgGUID: b4Gf+aVbTmeChF1ZQ+xihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20365966"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:02:27 -0700
Message-ID: <0231631b-44ca-45ee-adf9-0a5c8852cc27@linux.intel.com>
Date: Wed, 10 Apr 2024 16:02:24 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7e78917f-f84c-4e98-a612-73b8013ae367@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/10 14:30, Yi Liu wrote:
> On 2024/4/10 13:58, Lu Baolu wrote:
>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>> implementation caches not-present or erroneous translation-structure
>> entries except the first-stage translation. The caching mode is
>> irrelevant to the device TLB , therefore there is no need to check
>> it before a device TLB invalidation operation.
>>
>> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
>> mode check before device TLB invalidation will cause device TLB
>> invalidation always issued if IOMMU is not running in caching mode.
>> This is wrong and causes unnecessary performance overhead.
> 
> I don't think the original code is wrong. As I replied before, if CM==0,
> the iommu_flush_iotlb_psi() is only called in unmap path, in which the
> @map is false. [1] The reason to make the change is to make the logic
> simpler. 🙂

Oh, I see. There is a magic

         if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
                 iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);

in __mapping_notify_one().

So if it's caching mode, then

  - iommu_flush_iotlb_psi() will be called with @map=1 from
    __mapping_notify_one(), "!cap_caching_mode(iommu->cap) || !map" is
    not true, and device TLB is not invalidated.
  - iommu_flush_iotlb_psi() will also be called with @map=0 from
    intel_iommu_tlb_sync(), device TLB is issued there.

That's the expected behavior for caching mode.

If it's not the caching mode, then

  - iommu_flush_iotlb_psi() will be called with @map=0 from
    intel_iommu_tlb_sync(), device TLB is issued there.

That's also the expected behavior.

So the existing code is correct but obscure and difficult to understand,
right? If so, we should make this patch as a cleanup rather than a fix.

Best regards,
baolu
