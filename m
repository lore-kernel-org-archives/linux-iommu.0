Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8942A97
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744858235; cv=none; b=gToa++xu+jHUyuTAzzXnnP70G7mRC9rLzmKpPJyOCgN9W6WEel5ASYbqSZO6qa+YdZ0O/NBqwOrp2Urt/jl9xoqokI7v9uUuEFI387K/ark7vqJOduAlrHrDxHJWbpQ3qKb/ruYhqCCz3HBk812idOB6Tk6N3xh0Pk2qulfld30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744858235; c=relaxed/simple;
	bh=eUYT3dpebgx2Vo1FupbAiZMiDngB2nyBleDr/EMzWtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJrCKF1JmQfYFdeqVZNFAqq/UsqL6KAYOgzkZnx5Bix+RUrtoz3MgBGKNGQR2Ngc3A+MFcUkRGqpOYcUuln+uiOrofJTOIIxqKYIde5RLdA0HF8xU5u6HSi1oeJ5/68jL4MxTqWn7RLfsHLsmeoZER4LkGIMkjfJqr4jQVhEXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APOFH1mX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APOFH1mX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744858234; x=1776394234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eUYT3dpebgx2Vo1FupbAiZMiDngB2nyBleDr/EMzWtY=;
  b=APOFH1mXleCNn7SlbN19fPEEieq4U6B4l2YU/2AZNtxdUueYjTLrd+ZF
   +H5I36y+TjpNVvX0/OQ/1b3o90PrGhwvKmBX4FDgO6xhZ48PTO2bh0zh5
   081NmtS7CtOK2BOSs8TtymzptEVxgND1VbGN0+pN5DWbJCjihTvsVjduv
   sZhGMjrn3rtMHPhEVHI0waHsNYwoZc0UbBH2AJWv7MN7yEGoaXHg02Hdl
   dnJ5+NbL8zyXRYPlEyycnOLhh7Z/Rvc0PCH5KgA3O3sI1mTgtS4fJC5bc
   Y79EaP/DaXXVd4MbxdqKSRxIzT66yCiU0XApD+7r2UthMc28s1RGCKXIk
   g==;
X-CSE-ConnectionGUID: jhDlOXYRRpyVahf4UcNDwA==
X-CSE-MsgGUID: /bTshl4yQ3+fA22ppFAPUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="63966264"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="63966264"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:50:34 -0700
X-CSE-ConnectionGUID: O4OaXdwwQCyMWGJ/4a5kOg==
X-CSE-MsgGUID: gHkg0ZW/R5WheBCX3AGC6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130634454"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:50:32 -0700
Message-ID: <ee1d26c2-4e14-42f2-8dc0-d57a49490c9e@linux.intel.com>
Date: Thu, 17 Apr 2025 10:46:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Revert ATS timing change to fix boot
 failure
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250416073608.1799578-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F6889D36DD7238E3BBB28CBC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F6889D36DD7238E3BBB28CBC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/25 10:23, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 16, 2025 3:36 PM
>>
>> Commit <5518f239aff1> ("iommu/vt-d: Move scalable mode ATS enablement
>> to
>> probe path") changed the PCI ATS enablement logic to run earlier,
>> specifically before the default domain attachment.
>>
>> On some client platforms, this change resulted in boot failures, causing
>> the kernel to panic with the following message and call trace:
>>
>>   Kernel panic - not syncing: DMAR hardware is malfunctioning
>>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #175
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x6f/0xb0
>>    dump_stack+0x10/0x16
>>    panic+0x10a/0x2b7
>>    iommu_enable_translation.cold+0xc/0xc
>>    intel_iommu_init+0xe39/0xec0
>>    ? trace_hardirqs_on+0x1e/0xd0
>>    ? __pfx_pci_iommu_init+0x10/0x10
>>    pci_iommu_init+0xd/0x40
>>    do_one_initcall+0x5b/0x390
>>    kernel_init_freeable+0x26d/0x2b0
>>    ? __pfx_kernel_init+0x10/0x10
>>    kernel_init+0x15/0x120
>>    ret_from_fork+0x35/0x60
>>    ? __pfx_kernel_init+0x10/0x10
>>    ret_from_fork_asm+0x1a/0x30
>>   RIP: 1f0f:0x0
>>   Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>>   RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_RAX:
>>        1f0f2e6600000000
>>   RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX:
>>        2e66000000000084
>>   RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI:
>>        00841f0f2e660000
>>   RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09:
>>        000000841f0f2e66
>>   R10: 0000000000841f0f R11: 2e66000000000084 R12:
>>        000000841f0f2e66
>>   R13: 0000000000841f0f R14: 2e66000000000084 R15:
>>        1f0f2e6600000000
>>    </TASK>
>>   ---[ end Kernel panic - not syncing: DMAR hardware is malfunctioning ]---
>>
>> Fix this by reverting the timing change for ATS enablement introduced by
>> the offending commit and restoring the previous behavior.
>>
> 
> it's unclear how this timing is related to the dumped stack. Is there
> more detail how they are related?
> 

I'm not sure, but I'm trying to find a machine and get more information.
Anyway, let's revert the change and remove the boot regression first.

Thanks,
baolu
