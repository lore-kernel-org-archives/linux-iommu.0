Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8F218821
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 03:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740541852; cv=none; b=C+Lu0R0NtMGsT3pvNt5ltfmJFmSTAAcYHsZ6q8hgoavTihhGWAIqYK7AbCuhBeFrVcaoAMwD4ZyfelZXK8h2ZtzDnhBLHWwPHo/T0dH83P95h3klAzVp8VchtZgRuS+PAow88OrdUpxCIa5mXW03CgTVedaKEYSS9qGwXihyYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740541852; c=relaxed/simple;
	bh=GIKSrcAdARWGtqwXcvhyMAAyoUO1Ab9BSrALrgWmSXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExnZm6GxW3ZqUJacpHj2w1rYciVgk5QzrkXt7MdnhwSgGAuAo6rKVk4Sjye+xKCacmG5nCOGv0GsYrD2JtSvGxQfqrwc1PGt/DQKvm8HfLOfrg8nay2aaADLsV7r2OVT9rXqxoZM0phKpyLeo3iZTzoB2+op58dxUiZBVbtr3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsn53geV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsn53geV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740541851; x=1772077851;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GIKSrcAdARWGtqwXcvhyMAAyoUO1Ab9BSrALrgWmSXs=;
  b=dsn53geVIbPBkPkw79xyFarURoRtsrGsiIq23KeZMMj0+BvJKm/24Rg4
   gOPK0xTb9YP8R91ay6ltqinWCq5ny7C9SU9EN9IwCoTcZ0MlPIcjWJHgi
   UYzpF1dj7n91khUogCZQWUGnaBLD2grVteoI6Hk1mMia21FuOoT4PtCPc
   6KSEa0UqJHa/OvkuO9yDJ3RXOBc0YMzROzn/QK7OqfgyQ9/onS/zHhBGp
   RqfEGSt1WkL+StdUQM8Zt9eoxXVwIQ2FXHyFYT82lrUdHDIJZn3pFGG9p
   D/9Az1T59FMDszre54qum6slu3oHFY3R6Nf0xpH4Dl6LzR0SEeRRRi+4C
   w==;
X-CSE-ConnectionGUID: JYU2P+meQSGh8VQRpW8ePQ==
X-CSE-MsgGUID: jRHStEEdTiOTAkUZFmGLbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52795777"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52795777"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 19:50:50 -0800
X-CSE-ConnectionGUID: zIgZAE2rTNKTn75tBkZ9xw==
X-CSE-MsgGUID: n0Od5gPkRL6JE5HxqOUpWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121683447"
Received: from unknown (HELO [10.238.129.135]) ([10.238.129.135])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 19:50:48 -0800
Message-ID: <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
Date: Wed, 26 Feb 2025 11:50:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Yunhui Cui
 <cuiyunhui@bytedance.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <20250225142610.GB545008@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/25 22:26, Jason Gunthorpe 写道:
> On Tue, Feb 25, 2025 at 04:54:54PM +0800, Ethan Zhao wrote:
>>> On 2025/2/25 14:48, Yunhui Cui wrote:
>>>> We found that executing the command ./a.out &;reboot -f (where a.out
>>>> is a
>>>> program that only executes a while(1) infinite loop) can
>>>> probabilistically
>>>> cause the system to hang in the intel_iommu_shutdown() function,
>>>> rendering
>>>> it unresponsive. Through analysis, we identified that the factors
>>>> contributing to this issue are as follows:
>>>>
>>>> 1. The reboot -f command does not prompt the kernel to notify the
>>>> application layer to perform cleanup actions, allowing the
>>>> application to
>>>> continue running.
>>>>
>>>> 2. When the kernel reaches the intel_iommu_shutdown() function, only the
>>>> BSP (Bootstrap Processor) CPU is operational in the system.
>>>>
>>>> 3. During the execution of intel_iommu_shutdown(), the function
>>>> down_write
>>>> (&dmar_global_lock) causes the process to sleep and be scheduled out.
> Why does this happen? If the kernel has shutdown other CPUs then what
> thread is holding the other side of this lock and why?
>
>>>> 4. At this point, though the processor's interrupt flag is not cleared,
>>>>    allowing interrupts to be accepted. However, only legacy devices
>>>> and NMI
>>>> (Non-Maskable Interrupt) interrupts could come in, as other interrupts
>>>> routing have already been disabled. If no legacy or NMI interrupts occur
>>>> at this stage, the scheduler will not be able to run.
>>>> 5. If the application got scheduled at this time is executing a
>>>> while(1)-
>>>> type loop, it will be unable to be preempted, leading to an infinite
>>>> loop
>>>> and causing the system to become unresponsive.
> If the schedular doesn't run how did we get from 4 -> 5?
>
> Maybe the issue is the shutdown handler here is running in the wrong
> time and it should not be running after the scheduler has been shut
> down.
>
> I don't think removing the lock is a great idea without more
> explanation.

Seems it is not so simple job to explain why there is no race window between
this iommu_shutdown() and following dmar_global_lock holders.

1. PCIe hotplug dmar_pci_bus_notifier()

2. mm_core_init detect_intel_iommu()

3. late_initcall dmar_free_unused_resources()

4. acpi attach dmar_device_hotplug()

5. pci_iommu_init intel_iommu_init() init_dmars()

6. rootfs_initcall ir_dev_scope_init()

though here is the last stage of reboot. then how about we turn back to v1

Just repalce with own_write() with down_write_trylock().

Thanks,

Ethan


>
> Jason

-- 
"firm, enduring, strong, and long-lived"

