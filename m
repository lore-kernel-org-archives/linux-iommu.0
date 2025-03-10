Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E8A935
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574216; cv=none; b=VTILXTSZHyds+5eOj/09CVk8LvvB00QLTfIjkIGsbHtB48dlZx6ln20oA97StL5+emvj/W3PtC9FfAGMFxsHOlPnV7IN/b23d2aLk17ADXwT5IbqbGTMEjqptRTxT1u7rEVRZMMGS+1vn5eL41Z/KmwHtF7IIlTfmk2SpEPl0Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574216; c=relaxed/simple;
	bh=cdiX3h1BvqRWr2Z/qviPc8TG9q68mLEhMJAyJY6ZZwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewtrUawbnD36qH4MWvX4GMSI+xsfKNepv+RPtLEf3typygzkgUAtu2fyhrFSEaZYACpLPXaWXrZtIUJdroBdWqA4vvMDI0qO/1ebLd9oXCix4Wk0qD1HoHOArAEz01DdHWCOuBG544SruuWRvYIwHG4w0JvoNAJOqsV6s9zj7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJSks8Ir; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJSks8Ir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741574215; x=1773110215;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cdiX3h1BvqRWr2Z/qviPc8TG9q68mLEhMJAyJY6ZZwY=;
  b=GJSks8Ir5i8A6kkQOEAifVN9Ct1Bfkmsb7GgTj/7A24pZotgneon+Fwt
   R8DjpghVfS2Dl1hDPuE98XbuenG/DyhfDYdQLcHZ5FCynTeY/Fr8EaIMk
   82b1j/RW7hXOzQ2/lMktZJWcVI56+w0L5NJoQmUm6gWodUouJqyFLgUav
   XaZXsFdiwZ/JFHLUddGO1LeRt7jy6HmZaqU+hGPQh4UsM7TmQ8UKr3IJB
   dhU/OLw0mqE5KdUmePrXOPpMpEDJ0bHB48qcibAKqkWqWr3OcEouPVBOa
   DCKo7u7ReBhfp6T9l8AyFjgYrBGUcW8Xlfgt/+2xMzVj4jHNfW+v5sD2c
   g==;
X-CSE-ConnectionGUID: /nC2s7rlQIOiN1ZWJPkWSA==
X-CSE-MsgGUID: 1EOVVWXCR2C/U12gE1G63Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="46337297"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="46337297"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:36:55 -0700
X-CSE-ConnectionGUID: CsuFhw/VQI2OJ4dK/s+sGA==
X-CSE-MsgGUID: oQNSaZhoSF61LWjx5eoRzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119802310"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:36:53 -0700
Message-ID: <8e021997-3d79-4506-9905-e32631104a81@linux.intel.com>
Date: Mon, 10 Mar 2025 10:33:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/vt-d: fix system hang on reboot -f
To: Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>
References: <20250303062421.17929-1-cuiyunhui@bytedance.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250303062421.17929-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/25 14:24, Yunhui Cui wrote:
> We found that executing the command ./a.out &;reboot -f (where a.out is a
> program that only executes a while(1) infinite loop) can probabilistically
> cause the system to hang in the intel_iommu_shutdown() function, rendering
> it unresponsive. Through analysis, we identified that the factors
> contributing to this issue are as follows:
> 
> 1. The reboot -f command does not prompt the kernel to notify the
> application layer to perform cleanup actions, allowing the application to
> continue running.
> 
> 2. When the kernel reaches the intel_iommu_shutdown() function, only the
> BSP (Bootstrap Processor) CPU is operational in the system.
> 
> 3. During the execution of intel_iommu_shutdown(), the function down_write
> (&dmar_global_lock) causes the process to sleep and be scheduled out.
> 
> 4. At this point, though the processor's interrupt flag is not cleared,
>   allowing interrupts to be accepted. However, only legacy devices and NMI
> (Non-Maskable Interrupt) interrupts could come in, as other interrupts
> routing have already been disabled. If no legacy or NMI interrupts occur
> at this stage, the scheduler will not be able to run.
> 
> 5. If the application got scheduled at this time is executing a while(1)-
> type loop, it will be unable to be preempted, leading to an infinite loop
> and causing the system to become unresponsive.
> 
> To resolve this issue, the intel_iommu_shutdown() function should not
> execute down_write(), which can potentially cause the process to be
> scheduled out. Furthermore, since only the BSP is running during the later
> stages of the reboot, there is no need for protection against parallel
> access to the DMAR (DMA Remapping) unit. Therefore, the following lines
> could be removed:
> 
> down_write(&dmar_global_lock);
> up_write(&dmar_global_lock);
> 
> After testing, the issue has been resolved.
> 
> Fixes: 6c3a44ed3c55 ("iommu/vt-d: Turn off translations at shutdown")
> Co-developed-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
> Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
> Signed-off-by: Yunhui Cui<cuiyunhui@bytedance.com>
> ---
>   drivers/iommu/intel/iommu.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)

Queued this as a quick fix for iommu/vt-d branch. Should follow up to
consider the intel_iommu_shutdown() timing issue later.

Thanks,
baolu
