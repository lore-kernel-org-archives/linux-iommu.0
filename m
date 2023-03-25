Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10261843
	for <iommu@lists.linux.dev>; Sat, 25 Mar 2023 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679734161; x=1711270161;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7aQXTTzueKz4/LOrOT32vlGTw133AUd3lzycbtcUIsM=;
  b=aQjvkCm8yKfWqeWEyya3454oEF6izyl9GWuextXfPTylmpT2r3egrq4f
   AGbaVPSzIVBY/3Oi5bSwxKLi8nkaS/cvHCzgTIZS2xaT3tTYraQDUrzCk
   Fvbo7OsxNxV4g0TTPhm4DQ2F59HPvBB/vobMdbz9OJERMSaGTd+8s6TSd
   L3ZenA6D8Vj1GlDoGpnuhCT6YXnxBJNgsgHWM5yqcSRnmygT+r29rUFRJ
   W3rkjVGrWE+H59A3wESoGMVmlRCbSe+XTs5YbRpHJ0ZxLAK4xeCuRRL46
   a2srjAEqg8CgyFNw7Ofc1SSxmE0W2HQrLnDhWpxWW4gQ0QzBHjEzzezK7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="319604353"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="319604353"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 01:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="747440379"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="747440379"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2023 01:49:19 -0700
Message-ID: <da219415-d899-51da-6479-c13ae3616a12@linux.intel.com>
Date: Sat, 25 Mar 2023 16:49:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: lockdep splat with intel iommu
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <Y1qOqBXgll9qa7Hm@nvidia.com> <ZB4PqK6p64xuNxRn@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZB4PqK6p64xuNxRn@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/23 5:01 AM, Jason Gunthorpe wrote:
> On Thu, Oct 27, 2022 at 10:59:04AM -0300, Jason Gunthorpe wrote:
>> I'm seeing this at every boot, on v6.1-rc2
>>
>> I've just realized it means lockdep is turned off for the actual
>> testing I want to do. Very annoying
>>
>> Lu, is there a solution yet? I saw some patches for a different
>> lockdep splat but not this one.
>>
>> [    0.604492] ======================================================
>> [    0.604838] WARNING: possible circular locking dependency detected
>> [    0.605221] 6.1.0-rc2+ #24 Not tainted
>> [    0.605432] ------------------------------------------------------
>> [    0.605734] swapper/0/1 is trying to acquire lock:
>> [    0.605985] ffff8880069ab8a0 (&md->mutex){+.+.}-{3:3}, at: msi_get_virq+0x99/0x150
>> [    0.606281]
>> [    0.606281] but task is already holding lock:
>> [    0.606281] ffffffff82676890 (cpu_hotplug_lock){++++}-{0:0}, at: init_vqs+0x6db/0x940
>> [    0.606281]
>> [    0.606281] which lock already depends on the new lock.
> 
> Lu, did you ever figure this out? It still happens.
> 
> It is because dmar_global_lock is held while calling
> iommu_device_register() and also held during
> intel_irq_remapping_alloc()
> 
> iommu_device_register() eventually obtains the cpu_hotplug_lock to
> setup the DMA API
> 
> intel_irq_remapping_alloc() is called by drivers under the
> cpu_hotplug_lock to setup their interrupts
> 
> To fix it you cannot use the same lock in both places

I have a patch posted here.

https://lore.kernel.org/r/20230314051836.23817-1-baolu.lu@linux.intel.com

It may also fix this warning?

Best regards,
baolu
