Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9369839ACC
	for <iommu@lists.linux.dev>; Sun, 16 Mar 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742092618; cv=none; b=JuNjpxZdyM2efOZxHgeKGqnGYPhSdPmK7EFow2kcI3a0OfbucjSaUrj4itVYAqlmClABbRQ7U24EpWonPEPfB3tEHXPqrhanrvQn8wezWRM5aJ+4KteySh2LOe09gJUudgYXU02HruBBb+Ao2y3eAT6pMjizCTZyjrs4SpDGh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742092618; c=relaxed/simple;
	bh=otsR9NvXZuAsfzL0AifKh/SLKbS6GcELgn6XttISFJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzcFbAaPDzy2HG7zUdVbiuhRq9DKXODZFUE8nZvf1LZQwMetMQPMDY/WjqzFPhhVA3rErUoHjIvsX5JrBVyDdV1HC30s/fpeMOx5i2jPbyvu6QNKbjDVnIKegCAqCpHbPPDAiE0gQIKK9F6ujeuC2XQTJV5o+wSR+b1jILBFov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhvNm9cn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhvNm9cn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742092616; x=1773628616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=otsR9NvXZuAsfzL0AifKh/SLKbS6GcELgn6XttISFJU=;
  b=LhvNm9cnPX3aElQheNUuOxfoJJwEG3PVidkqstl54Yl+2iMK+kOkEGC/
   unx0WCKOiNkIn9OsvJgksQfgsq6YLfbLolTjO+7hR+nMVH95swrElOIAH
   zKXbBx09hEL0lKA1V4wLG2HxzZzcF7TMgvTjjn8Ixv2TkOzLAqmFQxISy
   tI7QxzOUpUHkTneibOUySMwdeEJQ3ylc+7t1rMvHswzr7dEg8n+rXb7Lv
   zVVhrsmP1f72OkNgfBVgDxcH8Npcvs1C1GepixJ+WGwdEB/pcJBZ1N4FO
   sBVWJFHQtKEMHQBwfhEPKcjzKQxok7JsWrASHQC45rlCUfch5IV1fznTp
   g==;
X-CSE-ConnectionGUID: EPIHpCd8R7agrJlgvWFhbQ==
X-CSE-MsgGUID: rWikstKMSwagF0XxYiksRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11374"; a="53875897"
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="53875897"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 19:36:56 -0700
X-CSE-ConnectionGUID: zClBcTayTFKC/YOGbpMhEw==
X-CSE-MsgGUID: H4rZ3c0/So6Ff86aXBYRfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="122561626"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 19:36:52 -0700
Message-ID: <5e6d65b6-4f9a-4d23-925c-75be7c4bd561@linux.intel.com>
Date: Sun, 16 Mar 2025 10:33:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression on drm-tip
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <SJ1PR11MB612953431F94F18C954C4A9CB9D32@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <4951eb3c-aa2b-46cf-87bd-37b09447748d@linux.intel.com>
 <SJ1PR11MB6129AAF87542D06B7A23C0FCB9D22@SJ1PR11MB6129.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <SJ1PR11MB6129AAF87542D06B7A23C0FCB9D22@SJ1PR11MB6129.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/14/25 17:04, Borah, Chaitanya Kumar wrote:
> 
> 
>> -----Original Message-----
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, March 13, 2025 7:53 PM
>> To: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
>> Cc: baolu.lu@linux.intel.com; intel-gfx@lists.freedesktop.org; intel-
>> xe@lists.freedesktop.org; iommu@lists.linux.dev
>> Subject: Re: Regression on drm-tip
>>
>> On 2025/3/13 16:51, Borah, Chaitanya Kumar wrote:
>>> Hello Lu,
>>>
>>> Hope you are doing well. I am Chaitanya from the linux graphics team in
>> Intel.
>>>
>>> This mail is regarding a regression we are seeing in our CI runs[1] on drm-tip
>> repository.
>>>
>>> ``````````````````````````````````````````````````````````````````````
>>> ``````````` <4>[    2.856622] WARNING: possible circular locking
>>> dependency detected <4>[    2.856631]
>>> 6.14.0-rc5-CI_DRM_16217-gc55ef90b69d3+ #1 Tainted: G          I <4>[
>>> 2.856642] ------------------------------------------------------
>>> <4>[    2.856650] swapper/0/1 is trying to acquire lock:
>>> <4>[    2.856657] ffffffff8360ecc8
>>> (iommu_probe_device_lock){+.+.}-{3:3}, at:
>>> iommu_probe_device+0x1d/0x70 <4>[    2.856679]
>>>                     but task is already holding lock:
>>> <4>[    2.856686] ffff888102ab6fa8
>>> (&device->physical_node_lock){+.+.}-{3:3}, at:
>>> intel_iommu_init+0xea1/0x1220
>>> ``````````````````````````````````````````````````````````````````````
>>> ```````````
>>> Details log can be found in [2].
>>>
>>> After bisecting the tree, the following patch [3] seems to be the
>>> first "bad" commit
>>>
>>> ``````````````````````````````````````````````````````````````````````
>>> ```````````````````````````````````
>>> commit b150654f74bf0df8e6a7936d5ec51400d9ec06d8
>>> Author: Lu Baolumailto:baolu.lu@linux.intel.com
>>> Date:   Fri Feb 28 18:27:26 2025 +0800
>>>
>>>       iommu/vt-d: Fix suspicious RCU usage
>>>
>>> ``````````````````````````````````````````````````````````````````````
>>> ```````````````````````````````````
>>>
>>> We also verified that if we revert the patch the issue is not seen.
>>>
>>> Could you please check why the patch causes this regression and provide a
>> fix if necessary?
>>
>> Can you please take a quick test to check if the following fix works?
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c index
>> e540092d664d..06debeaec643 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -2051,8 +2051,13 @@ int enable_drhd_fault_handling(unsigned int cpu)
>>                   if (iommu->irq || iommu->node != cpu_to_node(cpu))
>>                           continue;
>>
>> +               /*
>> +                * Call dmar_alloc_hwirq() with dmar_global_lock held,
>> +                * could cause possible lock race condition.
>> +                */
>> +               up_read(&dmar_global_lock);
>>                   ret = dmar_set_interrupt(iommu);
>> -
>> +               down_read(&dmar_global_lock);
>>                   if (ret) {
>>                           pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
>>                                  (unsigned long long)drhd->reg_base_addr, ret);
>>
>> Thanks,
>> baolu
> 
> We still see the issue with this change.

I am attempting to reproduce this issue with my MTL machine. I pulled
the test branch from:

https://anongit.freedesktop.org/git/drm-tip.git

and built the test kernel image using the configuration file from:

https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_16217/kconfig.txt

But I did not observe the lockdep splat mentioned above after booting.

Is there anything I might have missed?

Thanks,
baolu
