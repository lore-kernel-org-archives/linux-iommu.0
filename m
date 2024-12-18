Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1897199E8B
	for <iommu@lists.linux.dev>; Wed, 18 Dec 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512776; cv=none; b=qU4U3h6NCfTOONxKvmhEXTZ1CSOLxGyPSGwbtqLqJP2P8vjUlN3a4YI1pOHVpC2lOFZeAX5vTua+BGN7E964RDSUPJoB6azkFg38Za3+S2XVJ3srxKJcQKd6FcXhIkITMmKcMId7v43zAxDe9GF0ouQ7PjkArPAOZjKBtey1o0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512776; c=relaxed/simple;
	bh=K2Qj+JGPc+zK8e7H46v03C8dcSSWB4jxuRPnBR2h+Iw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LThS/3BfB57CGIHrsOy0RA61b98h0dckqb9Rqkrwkv/Wl0LZohhS671j3rAr81jDk1NJ3hggLU87A4FPsuykou4mZkVqQpOVWTghWBS+8NTgsdZ/Y3L+XB8VXi1tnP3cXaVRpeEvdTgz/1pEc3E+ll3phYlk8ZPXrY0m1+/dKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SySUena4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SySUena4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734512774; x=1766048774;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K2Qj+JGPc+zK8e7H46v03C8dcSSWB4jxuRPnBR2h+Iw=;
  b=SySUena4D2jOCtqNeuHkvxgifFd0kIywx4/Aaq5EmY7aRb7JTqPwTNQz
   JhxlWRdYTQs912WERnGR6P1IPw3cKMc0RKnSdc2r11nlrpBRyQczROpCB
   EovJuEref87Op3LgrUE/VAIX8D+sW73I2l5VZXC137q/QuN+ha+1EXH0w
   7UKGtdkAWvRQKbOxxx6s53Q9tFBq5WaSPcEo5VbSPjpZYj5qUmZ1isfiq
   lSCU4NYl/M3HalBVizjaf/+JiCi7hJIrXTpoM2guo/7iYTuRiTo/IVOFb
   681vW7ykS158IwCtdbV1X9gqfNpKJY0SNnTI3DboprrPRobEDPkQMR/v2
   Q==;
X-CSE-ConnectionGUID: 9twB/4UES6yeT68eTjHj/w==
X-CSE-MsgGUID: uyRhs1FORNSvgVTHrkF8tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34262768"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="34262768"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:06:13 -0800
X-CSE-ConnectionGUID: k10MXdRoR1qe1tto74fWHA==
X-CSE-MsgGUID: CKXufMmlT2mjDaA/bOS2SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97648532"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.34]) ([10.124.241.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:06:10 -0800
Message-ID: <494d6b30-acde-4538-8f0f-e669812c3a00@linux.intel.com>
Date: Wed, 18 Dec 2024 17:06:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Link cache tags of same iommu unit together
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20241216033809.170366-1-zhenzhong.duan@intel.com>
 <897738ba-5c1f-4d42-bf10-402d59e3f430@linux.intel.com>
 <SJ0PR11MB6744DB1AE24115FD44B390B492052@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <SJ0PR11MB6744DB1AE24115FD44B390B492052@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/12/18 13:22, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Subject: Re: [PATCH] iommu/vt-d: Link cache tags of same iommu unit together
>>
>> On 12/16/24 11:38, Zhenzhong Duan wrote:
>>> Cache tag invalidation requests for a domain are accumulated until a
>>> different iommu unit is found when traversing the cache_tags linked list.
>>> But cache tags of same iommu unit can be distributed in the linked list,
>>> this make batched flush less efficient. E.g., one device backed by iommu0
>>> is attached to a domain in between two devices attaching backed by iommu1.
>>>
>>> Group cache tags together for same iommu unit in cache_tag_assign() to
>>> maximize the performance of batched flush.
>>>
>>> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@intel.com>
>>> ---
>>>    drivers/iommu/intel/cache.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
>>> index e5b89f728ad3..726052a841e0 100644
>>> --- a/drivers/iommu/intel/cache.c
>>> +++ b/drivers/iommu/intel/cache.c
>>> @@ -48,6 +48,8 @@ static int cache_tag_assign(struct dmar_domain *domain,
>> u16 did,
>>>    	struct intel_iommu *iommu = info->iommu;
>>>    	struct cache_tag *tag, *temp;
>>>    	unsigned long flags;
>>> +	struct cache_tag *temp2 = list_entry(&domain->cache_tags,
>>> +					     struct cache_tag, node);
>> Is this valid for a list head?
> Yes, it's not valid for list head but it's intentional, just want to
> avoid unnecessary temp2 check. If I don't do that way, patch will be:
> 
> --- a/drivers/iommu/intel/cache.c
> +++ b/drivers/iommu/intel/cache.c
> @@ -48,6 +48,7 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
>          struct intel_iommu *iommu = info->iommu;
>          struct cache_tag *tag, *temp;
>          unsigned long flags;
> +       struct cache_tag *temp2 = NULL;
> 
>          tag = kzalloc(sizeof(*tag), GFP_KERNEL);
>          if (!tag)
> @@ -73,8 +74,18 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
>                          trace_cache_tag_assign(temp);
>                          return 0;
>                  }
> +               if (temp->iommu == iommu)
> +                       temp2 = temp;
>          }
> -       list_add_tail(&tag->node, &domain->cache_tags);
> +       /*
> +        * Link cache tags of same iommu unit together, so consponding
> +        * flush ops can be batched for iommu unit.
> +        */
> +       if (temp2)
> +               list_add(&tag->node, &temp2->node);
> +       else
> +               list_add_tail((&tag->node, &domain->cache_tags);
> +
>          spin_unlock_irqrestore(&domain->cache_lock, flags);
>          trace_cache_tag_assign(tag);

Perhaps we can make it like this?

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 09694cca8752..cf0cca94d165 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -47,6 +47,7 @@ static int cache_tag_assign(struct dmar_domain 
*domain, u16 did,
         struct device_domain_info *info = dev_iommu_priv_get(dev);
         struct intel_iommu *iommu = info->iommu;
         struct cache_tag *tag, *temp;
+       struct list_head *prev;
         unsigned long flags;

         tag = kzalloc(sizeof(*tag), GFP_KERNEL);
@@ -65,6 +66,7 @@ static int cache_tag_assign(struct dmar_domain 
*domain, u16 did,
                 tag->dev = iommu->iommu.dev;

         spin_lock_irqsave(&domain->cache_lock, flags);
+       prev = &domain->cache_tags;
         list_for_each_entry(temp, &domain->cache_tags, node) {
                 if (cache_tage_match(temp, did, iommu, dev, pasid, type)) {
                         temp->users++;
@@ -73,8 +75,15 @@ static int cache_tag_assign(struct dmar_domain 
*domain, u16 did,
                         trace_cache_tag_assign(temp);
                         return 0;
                 }
+               if (temp->iommu == iommu)
+                       prev = &temp->node;
         }
-       list_add_tail(&tag->node, &domain->cache_tags);
+       /*
+        * Link cache tags of same iommu unit together, so consponding
+        * flush ops can be batched for iommu unit.
+        */
+       list_add(&tag->node, prev);
+
         spin_unlock_irqrestore(&domain->cache_lock, flags);
         trace_cache_tag_assign(tag);

Thanks,
baolu
