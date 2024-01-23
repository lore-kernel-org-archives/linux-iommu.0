Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C012AAE9
	for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971333; cv=none; b=kuH36VCkvaqS+P9s7OA+nzd2U0B+p7/rIsj3P14AGcopKDzBiqOMz4gwvweWKt/+G5MYw3uou9qkzZVrNXDhFnEybW0jeqH/bvOCuscAEppfhQOLvT8qJ0YSrusaTUiD/DjDQWvjbbQH55W+diyijbkVK1fCE0zde5ggU/RT8wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971333; c=relaxed/simple;
	bh=4qawhNGO6wKxMSuceG7kbjXMOkTOZFYEvmKvx8RGwqI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KJhPCwE6Jl2jLw1UV2a9uTX4FestzEFdPVBtL10R6AexMGxygGZ65GwVVafeVB5DUf1nAxtC1zLSkmwPceSQX6UOMx3kZ0L3cBCuMfi0BWjFEMm1pfVcBJzPECpPqPvXQRmlfrKbSQC9MKInPvd+4FLPvqCnIj5JJVkkJgJMBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TY8M2Mvp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TY8M2Mvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705971332; x=1737507332;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4qawhNGO6wKxMSuceG7kbjXMOkTOZFYEvmKvx8RGwqI=;
  b=TY8M2MvpSz9snQBS7YODyHah04bLksfgBu/aRpO1VSBCII5CJX3ima3l
   TZMWKq/+mE2q6xRcY4PjWiLuI+OtcEFJ3PGcuyMFRuBgBBq309B4PaMgY
   A0eqdbft/TjaHHGwoIfJ04CccbMKILVM0izFYiVp0rFb8R7esCAaYVIAF
   XGh6AmD9Kl443OZYjyOVAv+5KdQW6rEWb3N0Jmurv74StORloBbOuN64Y
   oDCl3wZBxDU7ceKx0oOTu1m3Y0U+J25ykFSjv2k9/hOOhEnfR0e0mg4cS
   DlgJR5siygnlFoKDXrlFWDP5k9o3hHbaYwVXFy0Sd2cZrvKpAZEoUepSL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8739559"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="8739559"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 16:55:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="20157410"
Received: from guoxuanl-mobl.ccr.corp.intel.com (HELO [10.254.212.246]) ([10.254.212.246])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 16:55:30 -0800
Message-ID: <42b53bff-4027-4cb6-a457-e26fd62895e5@linux.intel.com>
Date: Tue, 23 Jan 2024 08:55:28 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <24bf9a11-6abd-4ccf-9ca1-3cf75c45d374@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/22 22:53, Paul Menzel wrote:
> Am 22.01.24 um 13:38 schrieb Baolu Lu:
>> On 2024/1/19 22:45, Paul Menzel wrote:
>>>
>>> On a Dell PowerEdge T640, Linux 5.9 and 6.6.12 warn about kdump:
>>>
>>>      [    2.728445] DMAR-IR: IRQ remapping was enabled on dmar6 but 
>>> we are not in kdump mode
>>>      [    2.736544] DMAR-IR: IRQ remapping was enabled on dmar5 but 
>>> we are not in kdump mode
>>>      [    2.744620] DMAR-IR: IRQ remapping was enabled on dmar4 but 
>>> we are not in kdump mode
>>>      [    2.752695] DMAR-IR: IRQ remapping was enabled on dmar3 but 
>>> we are not in kdump mode
>>>      [    2.760774] DMAR-IR: IRQ remapping was enabled on dmar2 but 
>>> we are not in kdump mode
>>>      [    2.768847] DMAR-IR: IRQ remapping was enabled on dmar1 but 
>>> we are not in kdump mode
>>>      [    2.776922] DMAR-IR: IRQ remapping was enabled on dmar0 but 
>>> we are not in kdump mode
>>>      [    2.784999] DMAR-IR: IRQ remapping was enabled on dmar7 but 
>>> we are not in kdump mode
>>>
>>> Looking through the logs, this only happens when using kexec to 
>>> restart the system.
>>
>> The code that warned this is,
>>
>>   599         if (ir_pre_enabled(iommu)) {
>>   600                 if (!is_kdump_kernel()) {
>>   601                         pr_warn("IRQ remapping was enabled on %s 
>> but we are not in kdump mode\n",
>>   602                                 iommu->name);
>>   603                         clear_ir_pre_enabled(iommu);
>>   604                         iommu_disable_irq_remapping(iommu);
>>   605                 }
>>
>> The VT-d interrupt remapping is enabled during boot, but this is not a
>> kdump kernel.
>>
>> Do you mind checking whether the disable interrupt remapping callback
>> was called during kexec reboot?
>>
>> 1121 struct irq_remap_ops intel_irq_remap_ops = {
>> 1122         .prepare                = intel_prepare_irq_remapping,
>> 1123         .enable                 = intel_enable_irq_remapping,
>> 1124         .disable                = disable_irq_remapping,
>> 1125         .reenable               = reenable_irq_remapping,
>> 1126         .enable_faulting        = enable_drhd_fault_handling,
>> 1127 };
> 
> Is there a way to check this without rebuilding the Linux kernel?

I am not sure, but you can check whether any messages are dumped in the
path of .disable callback? or try to use ftrace?

Best regards,
baolu
