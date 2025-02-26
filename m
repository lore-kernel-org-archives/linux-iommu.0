Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9707137E
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547327; cv=none; b=o4ag43P4YOAN1UMc+JX5zh6aWDp5nFFt9WEQloO9KRUCJQNX1i/WvzE+c0jWg9X6Q3pF63zgXfoUaaBI4fKw2pdM/G3oYg8jRrG8nbARfnw8tWY/dOq2/r39bqlSzaFddjX45uo9YTg6EJJnoy6CIegFlcUgeeeXFHqeDw0lHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547327; c=relaxed/simple;
	bh=iJStU4rLkR6zEaP5AH/aQL1uRUaH0G/Hw3uBBoYwypk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1Ccna8DdSyyJ65UJPGKadWwwGxr3ughKdC1otiOKUU93kTO4ysfY5SsH2PcIEdTY85fi+B2CexcxwN11c4HuR6XweO4HCCxAxrSDOsQd8Il5cnkL6Siu40kJ0K3vmopeb/mC3c7jq83eQGI2mthJrqjG8LHYqzMmxIgmI5FmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiLORtKS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiLORtKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740547326; x=1772083326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iJStU4rLkR6zEaP5AH/aQL1uRUaH0G/Hw3uBBoYwypk=;
  b=RiLORtKSFjwcRUTmiferd3WVOgZBkkU+FGWMHfDKAPk+7x2nga4xUEbH
   PTCucaFlJhfsA9vYRXf6574gOP9Ee/4hsD1CFB6vk+c++zhAWop4+bnhC
   ZSenVs6oNCTuJTbZUvzvOFNA8BTg/G++RagJYllXmv67y/m0QL5kd5Gzr
   R8S2j/cgwtevQHQs90ac3XCPN+TS+i1BnxUXK4zVAGJKwTjavSm7o5gQv
   fwA31bt8sdzYFJypRCUTydZeMDBY5W/8WFnZzgyEBZ/WLFWtPUOgJJo/J
   SeFOPHBwFyWouXEngfoI7cmyRYfhWxJGLILaev+es+1CHKjmaAxK6HTGx
   w==;
X-CSE-ConnectionGUID: /Xi88Ff7S9W9u1D8MiB3Xw==
X-CSE-MsgGUID: yti3NSgfS2mbOpu2kMn2VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41632631"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41632631"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:22:05 -0800
X-CSE-ConnectionGUID: S5C9QX9jRemvsEfdyiZBAQ==
X-CSE-MsgGUID: CaH8f0PJQUqTHEDsSUdlvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="117089295"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:21:59 -0800
Message-ID: <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
Date: Wed, 26 Feb 2025 13:18:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 11:50, Ethan Zhao wrote:
>>>>>
>> If the schedular doesn't run how did we get from 4 -> 5?
>>
>> Maybe the issue is the shutdown handler here is running in the wrong
>> time and it should not be running after the scheduler has been shut
>> down.
>>
>> I don't think removing the lock is a great idea without more
>> explanation.
> 
> Seems it is not so simple job to explain why there is no race window 
> between
> this iommu_shutdown() and following dmar_global_lock holders.
> 
> 1. PCIe hotplug dmar_pci_bus_notifier()
> 
> 2. mm_core_init detect_intel_iommu()
> 
> 3. late_initcall dmar_free_unused_resources()
> 
> 4. acpi attach dmar_device_hotplug()
> 
> 5. pci_iommu_init intel_iommu_init() init_dmars()
> 
> 6. rootfs_initcall ir_dev_scope_init()
> 
> though here is the last stage of reboot. then how about we turn back to v1
> 
> Just repalce with own_write() with down_write_trylock().

I don't think trylock is a reasonable solution. intel_iommu_shutdown()
should not become a no-op simply because it cannot acquire a lock
immediately.

The lock here is to protect the drhd (representation of iommu hardware)
list. It needs protection because this driver supports iommu hot-add and
remove, which is triggered by an ACPI event for I/O board hotplug.
Provided the system does not respond to those events when this function
is called, it's fine to remove the lock.

Thanks,
baolu
