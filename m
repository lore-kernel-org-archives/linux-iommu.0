Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14F223D2AB
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765769733; cv=none; b=pWqkpUuZczBubjw+YlGsYL/y1F6uyAQgmpfIpFBT5IB0Pc+tbEOcDYn4neaaCdTfyM+UfDUHWs5tb9ratXKhSQQmnfymRLxNvOFOqgk9aBde1hSWSkk+InhyCCqXaWzeyGE5VuoqSz/qoUZoYX09PboAhiavOs/GgKS5QMvabjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765769733; c=relaxed/simple;
	bh=k0d0WY5WB86HA23RXY6Mrnj8g+i5RzNN7D6VuIy886k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcXfa5//TaVNGGf0gic0Fv8qzavuuXFeCNsUAeOL0PzpPDIzPuAaVGVU+BPlQ40jp8INoZCqpz5Q9k8UWc1OWPUseElHWIyK7fL8R031A6VpPtZ3BeuNeucikOtrh4bvJcSHkPrQk1Nh2ybqUTUCJgFcqQOLJq/6JMicBYkMla8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bxy92Rfa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bxy92Rfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765769732; x=1797305732;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k0d0WY5WB86HA23RXY6Mrnj8g+i5RzNN7D6VuIy886k=;
  b=Bxy92RfapGOQ/vBgU5b01sQ16baNSMd5vtPkaR2ZkV6MXhOsfTpVYr08
   p5Fgw6raMXzUelwaK4e2HB7T4hVKkpl3U+79UblJ3QxU3l3BXRSbpUGXm
   D1yZp60MdcQnKNqk+MQUgybEAl11CuHXG1ofewEVT80dMVkvxngiGe2pn
   Mo0G3LGvjSQYInp7AM16AhkpolCAdk4cGijfJLzZ5pkKqEaHmHtw2hkH9
   LzVB2Mzgga09p2Fb7gqflQiYQmKisXTwplXrgfOPaom0lBVil+g6LHXrk
   DDkTuLgUMABMyTTEhKgK1EeXW7UYzukj8w6B2wfdoX4QAyH3dviYpyxnI
   g==;
X-CSE-ConnectionGUID: cvN44XT1Q1yCDWKMkwL7QA==
X-CSE-MsgGUID: PKtVtMefTCWagwXMxFtaJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="70247988"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="70247988"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 19:35:31 -0800
X-CSE-ConnectionGUID: Ov4Ez70WS2iVEsI0s1KPLg==
X-CSE-MsgGUID: xGKqUxKKQH+p43hn9drWLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="201797741"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 19:35:27 -0800
Message-ID: <7186caa3-13c0-4629-a07f-162c00138ad9@linux.intel.com>
Date: Mon, 15 Dec 2025 11:30:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
 rdunlap@infradead.org
References: <20251211125928.3258905-1-smostafa@google.com>
 <20251211125928.3258905-3-smostafa@google.com>
 <20e015d7-cb54-4a2a-bf62-a828e10e3126@linux.intel.com>
 <aTxiefxT08hbUPsd@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aTxiefxT08hbUPsd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/13/25 02:44, Mostafa Saleh wrote:
> On Fri, Dec 12, 2025 at 10:33:20AM +0800, Baolu Lu wrote:
>> On 12/11/25 20:59, Mostafa Saleh wrote:
>>> Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
>>> - iommu_debug_init: Enable the debug mode if configured by the user.
>>> - iommu_debug_map: Track iommu pages mapped, using physical address.
>>> - iommu_debug_unmap_begin: Track start of iommu unmap operation, with
>>>     IOVA and size.
>>> - iommu_debug_unmap_end: Track the end of unmap operation, passing the
>>>     actual unmapped size versus the tracked one at unmap_begin.
>>>
>>> We have to do the unmap_begin/end as once pages are unmapped we lose
>>> the information of the physical address.
>>> This is racy, but the API is racy by construction as it uses refcounts
>>> and doesn't attempt to lock/synchronize with the IOMMU API as that will
>>> be costly, meaning that possibility of false negative exists.
>>>
>>> Signed-off-by: Mostafa Saleh<smostafa@google.com>
>>> ---
>>>    drivers/iommu/iommu-debug-pagealloc.c | 28 +++++++++++++
>>>    drivers/iommu/iommu-priv.h            | 58 +++++++++++++++++++++++++++
>>>    drivers/iommu/iommu.c                 | 11 ++++-
>>>    include/linux/iommu-debug-pagealloc.h |  1 +
>>>    4 files changed, 96 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
>>> index 4022e9af7f27..1d343421da98 100644
>>> --- a/drivers/iommu/iommu-debug-pagealloc.c
>>> +++ b/drivers/iommu/iommu-debug-pagealloc.c
>>> @@ -5,11 +5,15 @@
>>>     * IOMMU API debug page alloc sanitizer
>>>     */
>>>    #include <linux/atomic.h>
>>> +#include <linux/iommu.h>
>>>    #include <linux/iommu-debug-pagealloc.h>
>>>    #include <linux/kernel.h>
>>>    #include <linux/page_ext.h>
>>> +#include "iommu-priv.h"
>>> +
>>>    static bool needed;
>>> +DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
>>>    struct iommu_debug_metadata {
>>>    	atomic_t ref;
>>> @@ -25,6 +29,30 @@ struct page_ext_operations page_iommu_debug_ops = {
>>>    	.need = need_iommu_debug,
>>>    };
>>> +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
>>> +{
>>> +}
>>> +
>>> +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
>>> +			       unsigned long iova, size_t size)
>>> +{
>>> +}
>>> +
>>> +void __iommu_debug_unmap_end(struct iommu_domain *domain,
>>> +			     unsigned long iova, size_t size,
>>> +			     size_t unmapped)
>>> +{
>>> +}
>>> +
>>> +void iommu_debug_init(void)
>>> +{
>>> +	if (!needed)
>>> +		return;
>>> +
>>> +	pr_info("iommu: Debugging page allocations, expect overhead or disable iommu.debug_pagealloc");
>>> +	static_branch_enable(&iommu_debug_initialized);
>>> +}
>>> +
>>>    static int __init iommu_debug_pagealloc(char *str)
>>>    {
>>>    	return kstrtobool(str, &needed);
>>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>>> index c95394cd03a7..aaffad5854fc 100644
>>> --- a/drivers/iommu/iommu-priv.h
>>> +++ b/drivers/iommu/iommu-priv.h
>>> @@ -5,6 +5,7 @@
>>>    #define __LINUX_IOMMU_PRIV_H
>>>    #include <linux/iommu.h>
>>> +#include <linux/iommu-debug-pagealloc.h>
>>>    #include <linux/msi.h>
>>>    static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>>> @@ -65,4 +66,61 @@ static inline int iommufd_sw_msi(struct iommu_domain *domain,
>>>    int iommu_replace_device_pasid(struct iommu_domain *domain,
>>>    			       struct device *dev, ioasid_t pasid,
>>>    			       struct iommu_attach_handle *handle);
>>> +
>>> +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
>>> +
>>> +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
>>> +		       size_t size);
>>> +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
>>> +			       unsigned long iova, size_t size);
>>> +void __iommu_debug_unmap_end(struct iommu_domain *domain,
>>> +			     unsigned long iova, size_t size, size_t unmapped);
>>> +
>>> +static inline void iommu_debug_map(struct iommu_domain *domain,
>>> +				   phys_addr_t phys, size_t size)
>>> +{
>>> +	if (static_branch_unlikely(&iommu_debug_initialized))
>>> +		__iommu_debug_map(domain, phys, size);
>>> +}
>>> +
>>> +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
>>> +					   unsigned long iova, size_t size)
>>> +{
>>> +	if (static_branch_unlikely(&iommu_debug_initialized))
>>> +		__iommu_debug_unmap_begin(domain, iova, size);
>>> +}
>>> +
>>> +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
>>> +					 unsigned long iova, size_t size,
>>> +					 size_t unmapped)
>>> +{
>>> +	if (static_branch_unlikely(&iommu_debug_initialized))
>>> +		__iommu_debug_unmap_end(domain, iova, size, unmapped);
>>> +}
>> I am wondering whether it would be better if we move iommu_debug_map()
>> to iommu-debug-pagealloc.c,
>>
>> void iommu_debug_map(struct iommu_domain *domain,
>> 		     phys_addr_t phys, size_t size)
>> {
>> 	if (static_branch_likely(&iommu_debug_initialized))
>> 		__iommu_debug_map(domain, phys, size);
>> }
>>
>> (Does it make sense to use static_branch_likely() here? Normally, people
>>   who enable CONFIG_IOMMU_DEBUG_PAGEALLOC would want to use this
>>   debugging feature. Or not?)
>>
>> So that ...
> This actually was the v1 implementation [1], but Jörg suggested to move
> it to a header file as a function call would have an overhead if this
> feautre is disabled.
> 
> I believe the priority would be to keep the performance overhead minimal
> with CONFIG_IOMMU_DEBUG_PAGEALLOC and the commandline disabled, so people
> can run with the config in production and only enable the commandline
> it to debug problems, without having overhead on the typical case.

Okay, fair enough.

Thanks,
baolu
