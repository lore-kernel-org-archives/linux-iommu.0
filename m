Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0901CCEF6
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547824; cv=none; b=vA4YE0lSPNHEhVyuvqTcKPKUckaPlwI/bgTot0uHz89mGUwBxxfsYG1y9SSP3AE+RJZDAz6LJDwrAQokm/r16eIxeESFQagRD2MjRJgBAQqrY6CInqPR7BwBtAtxtUCZ2IgaZgNQk5A8OxFj0FhGS/i+KLAmu6EcR4i/TpMBiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547824; c=relaxed/simple;
	bh=QFrp+5PlX8fb74FPEYnlkQMIRuRijYaZ8+Lp/KK8PC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzTipSgA4vmzyh43P9O6NTgAhztEdbmjN65M4PUXKZRb0JX8MpLqEgilJPwe1gdNOK7OEg/JTHdeNf+D+/U+J4pvVUhizPAI4qY5L6xOJSJuDaSuKflQuaSoIUXUWXNJyjxq9kvpQ9vDnjTcUSFzzle6YN2U8gjKFxQE0MzmXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBOuvqzV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBOuvqzV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731547821; x=1763083821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QFrp+5PlX8fb74FPEYnlkQMIRuRijYaZ8+Lp/KK8PC8=;
  b=KBOuvqzV7RAgKJtzoEbm+7A8qmSQlVS13GCV7GGLBfgMHY1Dc/3IlM9Y
   hx/G8rHq1597Q1dCg1rf8TOLUBt6Kc4YBPm6gBYMPnuLrzTGsl5KcgBdh
   W6P4EFxf0f9GFoIytLtqpM6R7HgxRfybVg4yt2JrX1XAXHTrYG4bOgRIf
   KqbMjvxkmG/yfI/4lH11xZmAQQcNcSEwsWgmaVmJWfMBAP176rEXke31V
   sp+uH8gw8b2RoVDTb4dKPMYlgFg3Mqq1d4g27mC+ACE3XPhs27HOHBLoW
   S/nnvi/UEuET4UYfpCEL4AwfYrsHnL3Uj23lN8ehWx5Ml6Iqu4BV3WdoM
   Q==;
X-CSE-ConnectionGUID: wJ5dkLdrSRinKxgLaydO+w==
X-CSE-MsgGUID: L2b02QurQjWSzd3peyP+sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="56858137"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="56858137"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 17:30:21 -0800
X-CSE-ConnectionGUID: yjeNN5GHTsyCanJ3XGCbuQ==
X-CSE-MsgGUID: 3mlL5furToK4S12b5lBMOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88029214"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 17:30:19 -0800
Message-ID: <dceea752-db07-4455-9efd-9d82371a57ae@linux.intel.com>
Date: Thu, 14 Nov 2024 09:29:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATH v5 2/3] iommu/vt-d: debugfs: Create/remove debugfs file per
 {device, pasid}
To: Kees Bakker <kees@ijzerbout.nl>, Jingqi Liu <Jingqi.liu@intel.com>,
 iommu@lists.linux.dev, Tian Kevin <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org
References: <20231013135811.73953-1-Jingqi.liu@intel.com>
 <20231013135811.73953-3-Jingqi.liu@intel.com>
 <2590cecf-e1f9-4af9-8fbb-9b49f5e335c0@ijzerbout.nl>
 <16b3fdb5-6f7b-4728-873c-4047ea69aef5@linux.intel.com>
 <e17818c2-8856-47d1-95fe-036b6a4849d6@ijzerbout.nl>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e17818c2-8856-47d1-95fe-036b6a4849d6@ijzerbout.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/14/24 04:35, Kees Bakker wrote:
> Op 13-11-2024 om 03:13 schreef Baolu Lu:
>> On 11/13/24 05:22, Kees Bakker wrote:
>>> Op 13-10-2023 om 15:58 schreef Jingqi Liu:
>>>> Add a debugfs directory per pair of {device, pasid} if the mappings of
>>>> its page table are created and destroyed by the iommu_map/unmap()
>>>> interfaces. i.e. /sys/kernel/debug/iommu/intel/<device source id>/ 
>>>> <pasid>.
>>>> Create a debugfs file in the directory for users to dump the page
>>>> table corresponding to {device, pasid}. e.g.
>>>> /sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct.
>>>> For the default domain without pasid, it creates a debugfs file in the
>>>> debugfs device directory for users to dump its page table. e.g.
>>>> /sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct.
>>>>
>>>> When setting a domain to a PASID of device, create a debugfs file in
>>>> the pasid debugfs directory for users to dump the page table of the
>>>> specified pasid. Remove the debugfs device directory of the device
>>>> when releasing a device. e.g.
>>>> /sys/kernel/debug/iommu/intel/0000:00:01.0
>>>>
>>>> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
>>>> ---
>>>>   drivers/iommu/intel/debugfs.c | 53 ++++++++++++++++++++++++++++++ 
>>>> +----
>>>>   drivers/iommu/intel/iommu.c   |  7 +++++
>>>>   drivers/iommu/intel/iommu.h   | 14 +++++++++
>>>>   3 files changed, 69 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/ 
>>>> debugfs.c
>>>> [...]
>>>> +/* Remove the device pasid debugfs directory. */
>>>> +void intel_iommu_debugfs_remove_dev_pasid(struct dev_pasid_info 
>>>> *dev_pasid)
>>>> +{
>>>> +    debugfs_remove_recursive(dev_pasid->debugfs_dentry);
>>>> +}
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> [...]
>>>> @@ -4710,6 +4713,7 @@ static void 
>>>> intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>>>       spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>>>       domain_detach_iommu(dmar_domain, iommu);
>>>> +    intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>>>       kfree(dev_pasid);
>>>>   out_tear_down:
>>>>       intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>>>>
>>>
>>> So, a call to intel_iommu_debugfs_remove_dev_pasid() was added.
>>> There is a potential problem that dev_pasid can be NULL.
>>> The diff doesn't show the whole context so let me give that here.
>>> Today that piece of the code looks like this
>>>
>>>          list_for_each_entry(curr, &dmar_domain->dev_pasids, 
>>> link_domain) {
>>>                  if (curr->dev == dev && curr->pasid == pasid) {
>>>                          list_del(&curr->link_domain);
>>>                          dev_pasid = curr;
>>>                          break;
>>>                  }
>>>          }
>>>          WARN_ON_ONCE(!dev_pasid);
>>>          spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>>
>>>          cache_tag_unassign_domain(dmar_domain, dev, pasid);
>>>          domain_detach_iommu(dmar_domain, iommu);
>>>          intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>>          kfree(dev_pasid);
>>>
>>> The for_each loop can exit without finding an entry.
>>> The WARN_ON_ONCE also suggests that there can be a NULL.
>>> After that the new function is called (see above) and it will
>>> dereference the NULL pointer.
>>>
>>> Can you have a closer look?
>>
>> It's already a kernel bug if dev_pasid is NULL when it reaches here. If
>> that happens, we should fix the bug, not avoid using the NULL pointer.
> 
> How about moving the WARN_ON_ONCE down a bit and use its return value?
> Like so
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 527f6f89d8a1..204873976ef3 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4096,13 +4096,14 @@ void domain_remove_dev_pasid(struct iommu_domain 
> *domain,
>                          break;
>                  }
>          }
> -       WARN_ON_ONCE(!dev_pasid);
>          spin_unlock_irqrestore(&dmar_domain->lock, flags);
> 
>          cache_tag_unassign_domain(dmar_domain, dev, pasid);
>          domain_detach_iommu(dmar_domain, iommu);
> -       intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
> -       kfree(dev_pasid);
> +       if (!WARN_ON_ONCE(!dev_pasid)) {
> +               intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
> +               kfree(dev_pasid);
> +       }
>   }
> 
>   static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t 
> pasid,
> 
> 
> Would you accept a patch like that? Or do you want to change it yourself?

Yes. That looks better. Please post a patch. Thanks!

--
baolu
