Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358D320B
	for <iommu@lists.linux.dev>; Wed, 15 May 2024 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715739348; cv=none; b=Xq/EP+ahZzO/TbddH8kSYR44E+eda1kRpMyZ1eSzBn7YlOdm3YUzqaF2LK+3KWavrpA/+GDCt/fhHXR7hmquq/Mlpk8XtH8KIVLElvnrMNUZKZt8wA2fkpIF8ZKGFBW12N9wmrZUwt8CZ8yC75P0mQ8qaXxXamrkkb3A9VGt6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715739348; c=relaxed/simple;
	bh=iJ76T7E8GXyXScgS5J1iu1FSfryWENvlHD6U1Mv0s3Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uHN1VMn/a8jGriiHGvDRUasHTdEfjNVcIHdBCTa+jL8GF3Ri7KF9M8x2YT0DImQYSy+0+lSjFhL0AeWIvsgVQQXXjrTMmMNlfImsAwykaQGQ+5OZGG7AQIYqGL+bOTULXs7zRLvDv6azeFI04gHiIrSsmqu62Mo+WWv+fPeFERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDdD92eL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDdD92eL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715739347; x=1747275347;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iJ76T7E8GXyXScgS5J1iu1FSfryWENvlHD6U1Mv0s3Y=;
  b=TDdD92eLlDD6KEO6bak8Kt1lDlucD3ytAOR+x9OeBZKiqgRn8Tet3F2z
   1lbpvo+05wsIY0pLW2PCGDXRAnCCyQ9kchOIy5ML911BiFdGs+2qbK1NV
   cX9MKJ9d/zulhyZcOiHFZZ8czx/QVfKL0mT87xUWfW8Hs7LtIPcdSwb4V
   nTsTcQk5XM873ybGxkNJzEeHr41Ed0+hVZ+UtYvD7euB/SOYaZjhxydFv
   +cg35sR2xcNZ3eoPA9uftbmg+8XTm+XFK9ZNcAZH/vElML8atioDsPgLB
   UloXACo2Y4ZRrmf0NmxDnlaZnh7YvwrUjttqi+jPg7PnSyYRb0+X99572
   w==;
X-CSE-ConnectionGUID: ibgIFiE0RQCapKesj2Iyqw==
X-CSE-MsgGUID: 1rN8a9goTliCJvT6A88t1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11615990"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="11615990"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 19:15:47 -0700
X-CSE-ConnectionGUID: 5HKdIpmGSzCYq4sgK0OtEg==
X-CSE-MsgGUID: E48uBUd/Sp+IebbarE2xuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="68350402"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 14 May 2024 19:15:44 -0700
Message-ID: <7eb01b85-9233-4f21-865e-6d128f39fb46@linux.intel.com>
Date: Wed, 15 May 2024 10:13:59 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <61ce93c7-e89c-4217-8095-dde9fb01763c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/24 3:46 AM, Paul Menzel wrote:
> Am 23.01.24 um 01:55 schrieb Baolu Lu:
>> On 2024/1/22 22:53, Paul Menzel wrote:
>>> Am 22.01.24 um 13:38 schrieb Baolu Lu:
>>>> On 2024/1/19 22:45, Paul Menzel wrote:
>>>>>
>>>>> On a Dell PowerEdge T640, Linux 5.9 and 6.6.12 warn about kdump:
>>>>>
>>>>>      [    2.728445] DMAR-IR: IRQ remapping was enabled on dmar6 but 
>>>>> we are not in kdump mode
>>>>>      [    2.736544] DMAR-IR: IRQ remapping was enabled on dmar5 but 
>>>>> we are not in kdump mode
>>>>>      [    2.744620] DMAR-IR: IRQ remapping was enabled on dmar4 but 
>>>>> we are not in kdump mode
>>>>>      [    2.752695] DMAR-IR: IRQ remapping was enabled on dmar3 but 
>>>>> we are not in kdump mode
>>>>>      [    2.760774] DMAR-IR: IRQ remapping was enabled on dmar2 but 
>>>>> we are not in kdump mode
>>>>>      [    2.768847] DMAR-IR: IRQ remapping was enabled on dmar1 but 
>>>>> we are not in kdump mode
>>>>>      [    2.776922] DMAR-IR: IRQ remapping was enabled on dmar0 but 
>>>>> we are not in kdump mode
>>>>>      [    2.784999] DMAR-IR: IRQ remapping was enabled on dmar7 but 
>>>>> we are not in kdump mode
>>>>>
>>>>> Looking through the logs, this only happens when using kexec to 
>>>>> restart the system.
>>>>
>>>> The code that warned this is,
>>>>
>>>>   599         if (ir_pre_enabled(iommu)) {
>>>>   600                 if (!is_kdump_kernel()) {
>>>>   601                         pr_warn("IRQ remapping was enabled on 
>>>> %s but we are not in kdump mode\n",
>>>>   602                                 iommu->name);
>>>>   603                         clear_ir_pre_enabled(iommu);
>>>>   604                         iommu_disable_irq_remapping(iommu);
>>>>   605                 }
>>>>
>>>> The VT-d interrupt remapping is enabled during boot, but this is not a
>>>> kdump kernel.
>>>>
>>>> Do you mind checking whether the disable interrupt remapping callback
>>>> was called during kexec reboot?
>>>>
>>>> 1121 struct irq_remap_ops intel_irq_remap_ops = {
>>>> 1122         .prepare                = intel_prepare_irq_remapping,
>>>> 1123         .enable                 = intel_enable_irq_remapping,
>>>> 1124         .disable                = disable_irq_remapping,
>>>> 1125         .reenable               = reenable_irq_remapping,
>>>> 1126         .enable_faulting        = enable_drhd_fault_handling,
>>>> 1127 };
>>>
>>> Is there a way to check this without rebuilding the Linux kernel?
>>
>> I am not sure, but you can check whether any messages are dumped in the
>> path of .disable callback? or try to use ftrace?
> 
> With
> 
> ```
> diff --git a/drivers/iommu/intel/irq_remapping.c 
> b/drivers/iommu/intel/irq_remapping.c
> index 712ebfc9870c6..146f19ae5b5f1 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1030,6 +1030,7 @@ static void disable_irq_remapping(void)
>       struct dmar_drhd_unit *drhd;
>       struct intel_iommu *iommu = NULL;
> 
> +    pr_warn("XXX: Called %s\n", __func__);
>       /*
>        * Disable Interrupt-remapping for all the DRHD's now.
>        */
> ```
> 
> I can’t see anything in the logs, so it does not seem to be called.
> 
> Can you reproduce the issue?

How did you reproduce this?

Best regards,
baolu
