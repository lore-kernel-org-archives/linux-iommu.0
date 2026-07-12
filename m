Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761A82866
	for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783852057; cv=none; b=DX/uGnfi5GKzs6+O9N/ZzYSmQs+UmMm2Pim0fcUuKt2vMDihhFtIObKdZnocmnM4gZD8dA2zMX2m9IQ8NKx2bEKADMMe27IhAG0NOyeqCcUaJUAXWL5JADNzs9LyLLhoU/F0DCsySK036N7HOFWfGTdTK8fd6uI25MO+Jmm7qmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783852057; c=relaxed/simple;
	bh=hjLD9OWiHVt6eGOSrKnlIgu1cKxUytBKV9yupDiE70o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lCl2Y0fYNDtN6fDI7p+o6S/i3jTTPsOBAi8ktrRbN75io2Ptt+D/8E21KR2j2GVQU1hf2No8iav7pYye7EU5/2iIzt160DOFQ8/SFMtV2akRcEJ/QlZtKs0iy/aU7AuAmdFx4Q8S6Yy3mhn2A2Nb/mAghWXmUbJXzrGSzEmqKdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ib33k71U; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ib33k71U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783852054; x=1815388054;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hjLD9OWiHVt6eGOSrKnlIgu1cKxUytBKV9yupDiE70o=;
  b=ib33k71UXoHTN4uAqLj53qyrUMguPdHYvn50tMUTEg9xMbtGPC+OYMOG
   DyxRCPkXIjznFlz0UBaN6UcVjwDz1I51xf653hrYyNkuih0m4o/9zVYE7
   TKvfEs1Od+YPj9CKPx6KvTTPWUE8uGSO4k731KXub8fUAlyb5y2evxCA2
   x+GKiRjqYwS+D6+OdPY0e0ExZsY0fEUYI5JTViHBNt7d57TAuft8WJW2X
   wWw2qdWIbBbOEgp5IUlbLQ0S2saupQiRIfbKv5Pbtnxj9Y8g4AmoXaLQs
   Xdxn7bD/ysHsw5bBTBUgYpwmAmKSWEVok1viWJMFKi1c3wRRWtek5vhIK
   Q==;
X-CSE-ConnectionGUID: 4t/dQySfTnm4Xz1isTu2lQ==
X-CSE-MsgGUID: DXzhirp+SnuRWAlLnKMTWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88315369"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88315369"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 03:27:33 -0700
X-CSE-ConnectionGUID: mzaqQYd+TvOXjvXHZVS0JQ==
X-CSE-MsgGUID: 2p17sXeqQsqN9hIySbNjww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="285377141"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 03:27:30 -0700
Message-ID: <a398dd84-8c2a-445f-869c-e1b18b6f4dfa@linux.intel.com>
Date: Sun, 12 Jul 2026 18:27:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 12/18] iommu/vt-d: Handle reattach of the restored
 domain
To: Samiullah Khawaja <skhawaja@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-13-skhawaja@google.com>
 <01f53c50-f585-49a0-b7a2-fdf002049aea@linux.intel.com>
 <ajnGMjFxhNCbW0To@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ajnGMjFxhNCbW0To@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/2026 8:26 AM, Samiullah Khawaja wrote:
> On Mon, Jun 22, 2026 at 01:44:06PM +0800, Baolu Lu wrote:
>> On 6/15/26 07:37, Samiullah Khawaja wrote:
>>> Reattach the restored domain to the preserved device using restored
>>> domain ID. While reattaching do not setup the context and PASID entries
>>> as those are preserved during liveupdate.
>>>
>>> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>> ---
>>>  drivers/iommu/intel/iommu.c      |  46 ++++++++++---
>>>  drivers/iommu/intel/iommu.h      |  17 +++++
>>>  drivers/iommu/intel/liveupdate.c | 111 +++++++++++++++++++++++++++++++
>>>  3 files changed, 163 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index cd40e274482b..91b67ccba011 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -1311,10 +1311,16 @@ static int dmar_domain_attach_device(struct 
>>> dmar_domain *domain,
>>>  {
>>>      struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>      struct intel_iommu *iommu = info->iommu;
>>> +    struct iommu_device_ser *device_ser;
>>>      unsigned long flags;
>>>      int ret;
>>> -    ret = domain_attach_iommu(domain, iommu);
>>> +    device_ser = dev_iommu_restored_state(dev);
>>> +    if (!device_ser)
>>> +        ret = domain_attach_iommu(domain, iommu);
>>> +    else
>>> +        ret = intel_iommu_domain_reattach_iommu(domain,
>>> +                            iommu, device_ser);
>>>      if (ret)
>>>          return ret;
>>> @@ -1327,16 +1333,20 @@ static int dmar_domain_attach_device(struct 
>>> dmar_domain *domain,
>>>      if (dev_is_real_dma_subdevice(dev))
>>>          return 0;
>>> -    if (!sm_supported(iommu))
>>> -        ret = domain_context_mapping(domain, dev);
>>> -    else if (intel_domain_is_fs_paging(domain))
>>> -        ret = domain_setup_first_level(iommu, domain, dev,
>>> -                           IOMMU_NO_PASID, NULL);
>>> -    else if (intel_domain_is_ss_paging(domain))
>>> -        ret = domain_setup_second_level(iommu, domain, dev,
>>> -                        IOMMU_NO_PASID, NULL);
>>> -    else if (WARN_ON(true))
>>> -        ret = -EINVAL;
>>> +    if (!device_ser) {
>>> +        if (!sm_supported(iommu))
>>> +            ret = domain_context_mapping(domain, dev);
>>> +        else if (intel_domain_is_fs_paging(domain))
>>> +            ret = domain_setup_first_level(iommu, domain, dev,
>>> +                               IOMMU_NO_PASID, NULL);
>>> +        else if (intel_domain_is_ss_paging(domain))
>>> +            ret = domain_setup_second_level(iommu, domain, dev,
>>> +                            IOMMU_NO_PASID, NULL);
>>> +        else if (WARN_ON(true))
>>> +            ret = -EINVAL;
>>> +    } else if (!sm_supported(iommu)) {
>>> +        iommu_enable_pci_ats(info);
>>> +    }
>>
>> Instead of merging domain restoration into the attach_dev path, how
>> about adding a new callback to restore a preserved domain for a device?
> 
> Even with a new callback, the driver still just fetches the restored
> state and takes a different path. I am guessing we can just do the
> following inside the driver to keep it clean:
> 
> static int intel_iommu_attach_device(struct iommu_domain *domain,
>                                      struct device *dev,
>                                          struct iommu_domain *old)
> {
>      struct iommu_device_ser *device_ser = dev_iommu_restored_state(dev);
> 
>      if (device_ser)
>          return _intel_iommu_restore_dev(domain, dev, device_ser);
> 
>      return _intel_iommu_attach_device(domain, dev, old);
> }
> 
> This keeps the separation you want without touching the generic ops.
> WDYT?
> 
> With the new callback, this check is just moved into the core inside
> __iommu_attach_device(). I am concerned that later down the road when we
> add PASID support, we will add restore_dev_pasid().

Okay, that also works for me.

Thanks,
baolu
