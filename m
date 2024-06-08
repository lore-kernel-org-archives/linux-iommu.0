Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805914F139
	for <iommu@lists.linux.dev>; Sat,  8 Jun 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717844876; cv=none; b=q6oNwmqzaWzk1IX7zhGTLRb6lKcZTFrb2iylVRsaKlEqdyznAcHnCf7n6kfOF8/6Xb1iK/tTFEFnxRRQr3rSsVgVGSE4/i2fYZPm46BPbBcFqia7pduxntZdfveu53jnUo98yeKVARlBTeVNyAaGVEOtYTr88blBOi87ffFoulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717844876; c=relaxed/simple;
	bh=0rWGcTa2MEDd7Q9eaT+yNU0ZCfGIK2XvrtCzfvdDr8k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mQ/T0CppmTImi4nZzN9DfwmDcTZ8VFgb09ZJG/eEpe6sxRfaiZ2U8ul2n0zl4uX2Cjax06s7HNkCPOchNVS/Y23xKJ3goRYG0zcZ4YF001LAbhUsdooGkFCXSbPmdItASelFN8NWo7yAtXGwIZNly7fGskbbouHJFWpsgkNfp40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af290.dynamic.kabel-deutschland.de [95.90.242.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 12E6161E5FE01;
	Sat,  8 Jun 2024 13:07:16 +0200 (CEST)
Message-ID: <754664f9-ac5b-406e-99bd-1b179ea8333b@molgen.mpg.de>
Date: Sat, 8 Jun 2024 13:07:15 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DMAR-IR: IRQ remapping was enabled on dmar6 but we are not in
 kdump mode
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <5517f76a-94ad-452c-bae6-34ecc0ec4831@molgen.mpg.de>
 <433452d0-589a-49c8-8044-dcc93d5be90a@linux.intel.com>
 <24bf9a11-6abd-4ccf-9ca1-3cf75c45d374@molgen.mpg.de>
 <42b53bff-4027-4cb6-a457-e26fd62895e5@linux.intel.com>
 <61ce93c7-e89c-4217-8095-dde9fb01763c@molgen.mpg.de>
 <7eb01b85-9233-4f21-865e-6d128f39fb46@linux.intel.com>
 <b12ae551-e7a4-435b-b7ff-368d6c1ae7a1@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <b12ae551-e7a4-435b-b7ff-368d6c1ae7a1@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Am 15.05.24 um 08:02 schrieb Paul Menzel:

> Am 15.05.24 um 04:13 schrieb Baolu Lu:
>> On 5/15/24 3:46 AM, Paul Menzel wrote:
>>> Am 23.01.24 um 01:55 schrieb Baolu Lu:
>>>> On 2024/1/22 22:53, Paul Menzel wrote:
>>>>> Am 22.01.24 um 13:38 schrieb Baolu Lu:
>>>>>> On 2024/1/19 22:45, Paul Menzel wrote:
>>>>>>>
>>>>>>> On a Dell PowerEdge T640, Linux 5.9 and 6.6.12 warn about kdump:
>>>>>>>
>>>>>>>      [    2.728445] DMAR-IR: IRQ remapping was enabled on dmar6 but we are not in kdump mode
>>>>>>>      [    2.736544] DMAR-IR: IRQ remapping was enabled on dmar5 but we are not in kdump mode
>>>>>>>      [    2.744620] DMAR-IR: IRQ remapping was enabled on dmar4 but we are not in kdump mode
>>>>>>>      [    2.752695] DMAR-IR: IRQ remapping was enabled on dmar3 but we are not in kdump mode
>>>>>>>      [    2.760774] DMAR-IR: IRQ remapping was enabled on dmar2 but we are not in kdump mode
>>>>>>>      [    2.768847] DMAR-IR: IRQ remapping was enabled on dmar1 but we are not in kdump mode
>>>>>>>      [    2.776922] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
>>>>>>>      [    2.784999] DMAR-IR: IRQ remapping was enabled on dmar7 but we are not in kdump mode
>>>>>>>
>>>>>>> Looking through the logs, this only happens when using kexec to 
>>>>>>> restart the system.
>>>>>>
>>>>>> The code that warned this is,
>>>>>>
>>>>>>   599         if (ir_pre_enabled(iommu)) {
>>>>>>   600                 if (!is_kdump_kernel()) {
>>>>>>   601                         pr_warn("IRQ remapping was enabled on %s but we are not in kdump mode\n",
>>>>>>   602                                 iommu->name);
>>>>>>   603                         clear_ir_pre_enabled(iommu);
>>>>>>   604                         iommu_disable_irq_remapping(iommu);
>>>>>>   605                 }
>>>>>>
>>>>>> The VT-d interrupt remapping is enabled during boot, but this is not a
>>>>>> kdump kernel.
>>>>>>
>>>>>> Do you mind checking whether the disable interrupt remapping callback
>>>>>> was called during kexec reboot?
>>>>>>
>>>>>> 1121 struct irq_remap_ops intel_irq_remap_ops = {
>>>>>> 1122         .prepare                = intel_prepare_irq_remapping,
>>>>>> 1123         .enable                 = intel_enable_irq_remapping,
>>>>>> 1124         .disable                = disable_irq_remapping,
>>>>>> 1125         .reenable               = reenable_irq_remapping,
>>>>>> 1126         .enable_faulting        = enable_drhd_fault_handling,
>>>>>> 1127 };
>>>>>
>>>>> Is there a way to check this without rebuilding the Linux kernel?
>>>>
>>>> I am not sure, but you can check whether any messages are dumped in the
>>>> path of .disable callback? or try to use ftrace?
>>>
>>> With
>>>
>>> ```
>>> diff --git a/drivers/iommu/intel/irq_remapping.c 
>>> b/drivers/iommu/intel/irq_remapping.c
>>> index 712ebfc9870c6..146f19ae5b5f1 100644
>>> --- a/drivers/iommu/intel/irq_remapping.c
>>> +++ b/drivers/iommu/intel/irq_remapping.c
>>> @@ -1030,6 +1030,7 @@ static void disable_irq_remapping(void)
>>>       struct dmar_drhd_unit *drhd;
>>>       struct intel_iommu *iommu = NULL;
>>>
>>> +     pr_warn("XXX: Called %s\n", __func__);
>>>       /*
>>>        * Disable Interrupt-remapping for all the DRHD's now.
>>>        */
>>> ```
>>>
>>> I can’t see anything in the logs, so it does not seem to be called.
>>>
>>> Can you reproduce the issue?
>>
>> How did you reproduce this?
> 
> On a “server” (with Intel Xeon?), in my case Dell PowerEdge T640 and 
> Dell PowerEdge R930 (Intel E7-8891 v3), run
> 
>      kexec /boot/bzImage --initrd=/boot/grub/initramfs.igz --reuse-cmdline

Were you able to fit some cycles into reproducing/analyzing this issue?


Kind regards,

Paul
