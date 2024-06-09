Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10A28F0
	for <iommu@lists.linux.dev>; Sun,  9 Jun 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918390; cv=none; b=R0jA6rZNFzyPyItqUH7QLbdM1J8MZDmiUlg4HUJGjNlZJsqDM4wrY1CeV9Pq+jojEtd1UGadIsxLEHre0joEeJjgLnB6546VNw+Lq/gmMwEJsnWjvraQUapPG0nNunjgTMz9XkEqo7iaWtkdhGEDMEer61+ZvYr4mYR99rT7Z44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918390; c=relaxed/simple;
	bh=6aFJQCU4PfS3rcXKKlQlz+ML8ImSC4rh3Wu5S/El4Fc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MUopQe6NP16m/goPU1H1uOIWI2wYjiuKeSY9e80Xtg7jZ9y15kiSOPdEPRoRf2N9HO7cT2ukoGK/bLZR/LGjThz6Ry+YuKR0Jf03+T1xkV4hJ3j7mwwYiQ3W9ICHw6wyoIb0qRBwmgxo4M3IbFC3WUFoMAKYSbRpCC169qkQoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbPZ96fn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbPZ96fn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717918389; x=1749454389;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6aFJQCU4PfS3rcXKKlQlz+ML8ImSC4rh3Wu5S/El4Fc=;
  b=hbPZ96fn2Wn4Nlkt3fgqIQfG4AhC/7djuC7biRQOock8K7gkRCh1aGB1
   qs4AVnrVLFD4ZWjYmj0h1QRNNUbmckg2w2L2GnPW2PGct7IvkjJKeglOr
   2vqBW0G6l5vasmo9ewnMPoe7XJ7FM60GT0VDzjNQAQ2JW2P0yuxXdoWzs
   hD1LBdKpQ0d1smVf+4Rip5ewuZ70/1k1qoPJ5M5pSeNoOmS/mbfD2afRl
   uNyb7ZneBF0TxKu8t1SHwFdBx5gQE33eNPthUtB4ErAdBjDSebxGT6vxf
   RDKYXTD9F0ll1q/OUsml00sMuyvzRltx3JrcTsPjpYrl/t3sm1fg6ergM
   A==;
X-CSE-ConnectionGUID: cPBL+h4xSeCOUYxg/4wg8w==
X-CSE-MsgGUID: eWt2wO3BQo6V5SKGkYW2Ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="32136878"
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="32136878"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 00:33:08 -0700
X-CSE-ConnectionGUID: OqQdNhqdTm2j4Rinc57ReA==
X-CSE-MsgGUID: 7lHAV04gRzmAkgMx9TKYcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="38678785"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 09 Jun 2024 00:33:07 -0700
Message-ID: <d0fcc26e-1e2f-4783-8a17-5f09c9729aa2@linux.intel.com>
Date: Sun, 9 Jun 2024 15:30:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: DMAR-IR: IRQ remapping was enabled on dmar6 but we are not in
 kdump mode
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <5517f76a-94ad-452c-bae6-34ecc0ec4831@molgen.mpg.de>
 <433452d0-589a-49c8-8044-dcc93d5be90a@linux.intel.com>
 <24bf9a11-6abd-4ccf-9ca1-3cf75c45d374@molgen.mpg.de>
 <42b53bff-4027-4cb6-a457-e26fd62895e5@linux.intel.com>
 <61ce93c7-e89c-4217-8095-dde9fb01763c@molgen.mpg.de>
 <7eb01b85-9233-4f21-865e-6d128f39fb46@linux.intel.com>
 <b12ae551-e7a4-435b-b7ff-368d6c1ae7a1@molgen.mpg.de>
 <754664f9-ac5b-406e-99bd-1b179ea8333b@molgen.mpg.de>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <754664f9-ac5b-406e-99bd-1b179ea8333b@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/8/24 7:07 PM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Am 15.05.24 um 08:02 schrieb Paul Menzel:
> 
>> Am 15.05.24 um 04:13 schrieb Baolu Lu:
>>> On 5/15/24 3:46 AM, Paul Menzel wrote:
>>>> Am 23.01.24 um 01:55 schrieb Baolu Lu:
>>>>> On 2024/1/22 22:53, Paul Menzel wrote:
>>>>>> Am 22.01.24 um 13:38 schrieb Baolu Lu:
>>>>>>> On 2024/1/19 22:45, Paul Menzel wrote:
>>>>>>>>
>>>>>>>> On a Dell PowerEdge T640, Linux 5.9 and 6.6.12 warn about kdump:
>>>>>>>>
>>>>>>>>      [    2.728445] DMAR-IR: IRQ remapping was enabled on dmar6 
>>>>>>>> but we are not in kdump mode
>>>>>>>>      [    2.736544] DMAR-IR: IRQ remapping was enabled on dmar5 
>>>>>>>> but we are not in kdump mode
>>>>>>>>      [    2.744620] DMAR-IR: IRQ remapping was enabled on dmar4 
>>>>>>>> but we are not in kdump mode
>>>>>>>>      [    2.752695] DMAR-IR: IRQ remapping was enabled on dmar3 
>>>>>>>> but we are not in kdump mode
>>>>>>>>      [    2.760774] DMAR-IR: IRQ remapping was enabled on dmar2 
>>>>>>>> but we are not in kdump mode
>>>>>>>>      [    2.768847] DMAR-IR: IRQ remapping was enabled on dmar1 
>>>>>>>> but we are not in kdump mode
>>>>>>>>      [    2.776922] DMAR-IR: IRQ remapping was enabled on dmar0 
>>>>>>>> but we are not in kdump mode
>>>>>>>>      [    2.784999] DMAR-IR: IRQ remapping was enabled on dmar7 
>>>>>>>> but we are not in kdump mode
>>>>>>>>
>>>>>>>> Looking through the logs, this only happens when using kexec to 
>>>>>>>> restart the system.
>>>>>>>
>>>>>>> The code that warned this is,
>>>>>>>
>>>>>>>   599         if (ir_pre_enabled(iommu)) {
>>>>>>>   600                 if (!is_kdump_kernel()) {
>>>>>>>   601                         pr_warn("IRQ remapping was enabled 
>>>>>>> on %s but we are not in kdump mode\n",
>>>>>>>   602                                 iommu->name);
>>>>>>>   603                         clear_ir_pre_enabled(iommu);
>>>>>>>   604                         iommu_disable_irq_remapping(iommu);
>>>>>>>   605                 }
>>>>>>>
>>>>>>> The VT-d interrupt remapping is enabled during boot, but this is 
>>>>>>> not a
>>>>>>> kdump kernel.
>>>>>>>
>>>>>>> Do you mind checking whether the disable interrupt remapping 
>>>>>>> callback
>>>>>>> was called during kexec reboot?
>>>>>>>
>>>>>>> 1121 struct irq_remap_ops intel_irq_remap_ops = {
>>>>>>> 1122         .prepare                = intel_prepare_irq_remapping,
>>>>>>> 1123         .enable                 = intel_enable_irq_remapping,
>>>>>>> 1124         .disable                = disable_irq_remapping,
>>>>>>> 1125         .reenable               = reenable_irq_remapping,
>>>>>>> 1126         .enable_faulting        = enable_drhd_fault_handling,
>>>>>>> 1127 };
>>>>>>
>>>>>> Is there a way to check this without rebuilding the Linux kernel?
>>>>>
>>>>> I am not sure, but you can check whether any messages are dumped in 
>>>>> the
>>>>> path of .disable callback? or try to use ftrace?
>>>>
>>>> With
>>>>
>>>> ```
>>>> diff --git a/drivers/iommu/intel/irq_remapping.c 
>>>> b/drivers/iommu/intel/irq_remapping.c
>>>> index 712ebfc9870c6..146f19ae5b5f1 100644
>>>> --- a/drivers/iommu/intel/irq_remapping.c
>>>> +++ b/drivers/iommu/intel/irq_remapping.c
>>>> @@ -1030,6 +1030,7 @@ static void disable_irq_remapping(void)
>>>>       struct dmar_drhd_unit *drhd;
>>>>       struct intel_iommu *iommu = NULL;
>>>>
>>>> +     pr_warn("XXX: Called %s\n", __func__);
>>>>       /*
>>>>        * Disable Interrupt-remapping for all the DRHD's now.
>>>>        */
>>>> ```
>>>>
>>>> I can’t see anything in the logs, so it does not seem to be called.
>>>>
>>>> Can you reproduce the issue?
>>>
>>> How did you reproduce this?
>>
>> On a “server” (with Intel Xeon?), in my case Dell PowerEdge T640 and 
>> Dell PowerEdge R930 (Intel E7-8891 v3), run
>>
>>      kexec /boot/bzImage --initrd=/boot/grub/initramfs.igz 
>> --reuse-cmdline
> 
> Were you able to fit some cycles into reproducing/analyzing this issue?

Yeah! I can reproduce this issue with my local development machine. But
I haven't had time to analyze it yet. Perhaps we can remove this
message, or make sure the .disable callback should be called?

Best regards,
baolu
