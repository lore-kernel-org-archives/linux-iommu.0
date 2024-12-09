Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79834A02
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733713621; cv=none; b=acF9XCc7I30D9KTUkM3BlcO7JldU1Yfj4V7qidIDlb4kuDM9ka89W/nV++Au1Ne+tC81mbHzi+bvvUqit8sCjoVlAmkpAYJeppUs9Um2eIBYWMjNQYFG9aCCLjwFefZxyGfumXIhX60P0nL9MPMSwScVtcHNc3gmEozweDHOz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733713621; c=relaxed/simple;
	bh=9mChrCym/4+flBnFbJHTIod20eemaolFXc9PV3JDHAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnaRZAgZA8pWVy3+3V2rOM6vluxHH/R9/5FAHRzwpS3eiD54Zc6+JT6gAM56A74vqM2X6NDbWDJF+XfWOzXKv1auOCmIHNc/akzWy0vguqchuSQZkw0juo+mk2tpQmgoyzGYrrR5Dl8PALvX9NZK7tAteQBd/9/tQ4xBQJ9BgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiYwaMaU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiYwaMaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733713621; x=1765249621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9mChrCym/4+flBnFbJHTIod20eemaolFXc9PV3JDHAc=;
  b=WiYwaMaUCw2vnyXe553Ip6Z1tkl2na0APrUyGPSSZ0zlDb/AgWts8l57
   zG4Gw4GQ+VWsmx1tL+b9lmSAsL9nGhY/6kqkdpFiVO+3+qIBIE0V4gHP7
   1jFUynZAlN5hxNzgEjp2/HCsm1XRxZOGdqQgRl2eyBQ+8kndEfgxTqili
   BKH5g3ICNvsOj/dVy0z0FCGZqZkz3nlCPWX6NSFhBkUlewkDN+1bj0UT9
   UMSaMjuD4vsSFzTeIZ1/7vUB4mQ1Zb5yiYWs3Hs/Rem5yWSM9Hfz2jlxR
   aSUDkTMZDwf1atkvfah+avFcJj9jAxNZPP+MHGTWKAC8hWMUy5vHEnmb7
   Q==;
X-CSE-ConnectionGUID: VYvnNl56RLyrPGceyXLSug==
X-CSE-MsgGUID: KQnDrvnkRVCEKArOzKB8mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34055548"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34055548"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 19:06:59 -0800
X-CSE-ConnectionGUID: 2GyBujngRLC6HEnlGaRBrQ==
X-CSE-MsgGUID: GSw289C8R0G7Z1T8GaUMLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95140315"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 19:06:56 -0800
Message-ID: <1f660d3c-04f7-4d16-beac-74412a5cf6d2@linux.intel.com>
Date: Mon, 9 Dec 2024 11:05:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix qi_batch NULL pointer with nested parent
 domain
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com
Cc: chao.p.peng@linux.intel.com, iommu@lists.linux.dev
References: <20241207120304.5710-1-yi.l.liu@intel.com>
 <ce413d97-ec46-4cd9-932a-af804cd531cf@linux.intel.com>
 <b25901cf-6483-4434-804e-62bda4385796@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b25901cf-6483-4434-804e-62bda4385796@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/9/24 11:07, Yi Liu wrote:
>> Perhaps add a helper to handle the domain->qi_batch allocation? And then
>> call it in the necessary paths? Something like this:
>>
>> --- a/drivers/iommu/intel/cache.c
>> +++ b/drivers/iommu/intel/cache.c
>> @@ -105,12 +105,35 @@ static void cache_tag_unassign(struct 
>> dmar_domain *domain, u16 did,
>>       spin_unlock_irqrestore(&domain->cache_lock, flags);
>>   }
>>
>> +/* domain->qi_batch will be freed in iommu_free_domain() path. */
>> +static int domain_qi_batch_alloc(struct dmar_domain *domain)
>> +{
>> +    unsigned long flags;
>> +    int ret = 0;
>> +
>> +    spin_lock_irqsave(&domain->cache_lock, flags);
> 
> I'm wondering if there is any difference using the domain->lock v.s. using
> the domain->cache_lock. The RID attach path acquires/releases the
> domain->lock first, and then the domain->cache_lock. While the PASID path
> does the reverse order. Although neither of the two paths hold the locks
> for a long duration (no A-B-B-A locking issue), it still means when a
> domain is shared between RID and PASID path, the domain->qi_batch check is
> not in the same phase of the two paths.

You are right. domain->lock is the right one.

> 
>> +    if (domain->qi_batch)
>> +        goto out_unlock;
>> +
>> +    domain->qi_batch = kzalloc(sizeof(*domain->qi_batch), GFP_ATOMIC);
>> +    if (!domain->qi_batch)
>> +        ret = -ENOMEM;
>> +out_unlock:
>> +    spin_unlock_irqrestore(&domain->cache_lock, flags);
>> +
>> +    return ret;
>> +}
>> +
>>   static int __cache_tag_assign_domain(struct dmar_domain *domain, u16 
>> did,
>>                        struct device *dev, ioasid_t pasid)
>>   {
>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>       int ret;
>>
>> +    ret = domain_qi_batch_alloc(domain);
>> +    if (ret)
>> +        return ret;
>> +
> 
> also need to call it in __cache_tag_assign_parent_domain(). BTW. Is the
> domain->qi_batch required if there is no ATS?

Yes.

Thanks,
baolu
