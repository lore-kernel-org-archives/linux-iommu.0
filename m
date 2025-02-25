Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7725EFAB
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473701; cv=none; b=ARphqcP9UjcylASn7cipAlPK8x4N/l0GyQM5eFV3QcOYVviZ/m4eCw+vnuti8lEM6iriOPlIAZMDG5WmAG36UZV/QUTBO26YBrjaXMBCxWsKep0XJjY0Sa9HtrAkBkRQH20IrIJivbflIk5mVovvtQjC/uLOr7xNgtZGRubpIRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473701; c=relaxed/simple;
	bh=M4X/UO7NbADRFxPQ+fZQmKVZKt/OAc3TxsAE3eYn9Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NReDQ1SX9vhUmQpfK8R8rYQiOm8BiN2dw2JagCDOJuA+xWVa2uL2ZMjzFO8lNQjzPB3fsc6zQma80PYl5pcLTQVnBVomLGIrNoISlyZNuG2GiaeUqlr2JmiIMZRo9Y8iHiPbZXOEHN107hMwce0llxjkghbWbQFp8r8rtk1uSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgqYpLGz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgqYpLGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740473700; x=1772009700;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=M4X/UO7NbADRFxPQ+fZQmKVZKt/OAc3TxsAE3eYn9Ys=;
  b=WgqYpLGzDVg1AipmSL18RIPoBAK0V3/Gl7EdhE564FTQCchma8ck3tXd
   O1MEnZM2YEviVVgJafvqLTaekGF3E9yb5rGXE5mdpgAOPrfgJO2yhjhA5
   Pr4OYjejKQUjmROUx0z8ULHwOiHIHDqRTudslmThF5Ygf7EfCI4wB0/TC
   5fMt6WhSLVr29FRJtf18JFR4o2jbLWIir/3b9A16nTPVAf1D4TNObcluU
   ep0W3uRvX2EUyG6FAHLZE9fkeAiqWM0RgS4NMrnpXvEYh5KEnwXNkN2eK
   cX/SMMnkxKapttVDfcPN/K4Nn7Hqmxo8ZKY4/fp9kqATm/SijNBresI9h
   Q==;
X-CSE-ConnectionGUID: FrNMVTsbQbeb9WK+YLgZnQ==
X-CSE-MsgGUID: OPJwAA3NSSiAOiICT4MvDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45054599"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="45054599"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:55:00 -0800
X-CSE-ConnectionGUID: T6c6sCUZTAS1TUr7jdLnWQ==
X-CSE-MsgGUID: fodT0d9xRhCuJSz65ds8ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116124305"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.125.243.37]) ([10.125.243.37])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:54:56 -0800
Message-ID: <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
Date: Tue, 25 Feb 2025 16:54:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Baolu Lu <baolu.lu@linux.intel.com>, Yunhui Cui
 <cuiyunhui@bytedance.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/2/25 15:01, Baolu Lu 写道:
> On 2025/2/25 14:48, Yunhui Cui wrote:
>> We found that executing the command ./a.out &;reboot -f (where a.out 
>> is a
>> program that only executes a while(1) infinite loop) can 
>> probabilistically
>> cause the system to hang in the intel_iommu_shutdown() function, 
>> rendering
>> it unresponsive. Through analysis, we identified that the factors
>> contributing to this issue are as follows:
>>
>> 1. The reboot -f command does not prompt the kernel to notify the
>> application layer to perform cleanup actions, allowing the 
>> application to
>> continue running.
>>
>> 2. When the kernel reaches the intel_iommu_shutdown() function, only the
>> BSP (Bootstrap Processor) CPU is operational in the system.
>>
>> 3. During the execution of intel_iommu_shutdown(), the function 
>> down_write
>> (&dmar_global_lock) causes the process to sleep and be scheduled out.
>>
>> 4. At this point, though the processor's interrupt flag is not cleared,
>>   allowing interrupts to be accepted. However, only legacy devices 
>> and NMI
>> (Non-Maskable Interrupt) interrupts could come in, as other interrupts
>> routing have already been disabled. If no legacy or NMI interrupts occur
>> at this stage, the scheduler will not be able to run.
>>
>> 5. If the application got scheduled at this time is executing a 
>> while(1)-
>> type loop, it will be unable to be preempted, leading to an infinite 
>> loop
>> and causing the system to become unresponsive.
>>
>> To resolve this issue, the intel_iommu_shutdown() function should not
>> execute down_write(), which can potentially cause the process to be
>> scheduled out. Furthermore, since only the BSP is running during the 
>> later
>> stages of the reboot, there is no need for protection against parallel
>> access to the DMAR (DMA Remapping) unit. Therefore, the following lines
>> could be removed:
>
> Good summary! Thank you!
>
>>
>> down_write(&dmar_global_lock);
>> up_write(&dmar_global_lock);
>>
>> After testing, the issue has been resolved.
>>
>> Fixes: 6c3a44ed3c55 ("iommu/vt-d: Turn off translations at shutdown")
>> Co-developed-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index cc46098f875b..6d9f2e56ce88 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2871,16 +2871,12 @@ void intel_iommu_shutdown(void)
>>       if (no_iommu || dmar_disabled)
>>           return;
>>   -    down_write(&dmar_global_lock);
>> -
>>       /* Disable PMRs explicitly here. */
>>       for_each_iommu(iommu, drhd)
>
> Removing the locking for for_each_iommu() will trigger a suspicious RCU
> usage splat. You need to replace this helper with a raw
> list_for_each_entry() with some comments around it to explain why it is
> safe.
>
Oops,  RCU checking hids behind the for_each_iommu() macro.

How about

void intel_iommu_shutdown(void)

{

     struct dmar_drhd_unit *drhd;

     struct intel_iommu *iommu = NULL;

     if (no_iommu || dmar_disabled)

         return;


     /* Here only BSP is running, no RCU cocurrent lock checking needed */

     list_for_each_entry(drhd, &dmar_drhd_units, list) {

         iommu = drhd->iommu;

         /* Disable PMRs explicitly here. */

         iommu_disable_protect_mem_regions(iommu);

         iommu_disable_translation(iommu);

     }

}


Thanks,

Ethan

>> iommu_disable_protect_mem_regions(iommu);
>>         /* Make sure the IOMMUs are switched off */
>>       intel_disable_iommus();
>> -
>> -    up_write(&dmar_global_lock);
>>   }
>>     static struct intel_iommu *dev_to_intel_iommu(struct device *dev)
>
> Thanks,
> baolu

-- 
"firm, enduring, strong, and long-lived"

