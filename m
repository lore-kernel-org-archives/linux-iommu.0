Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C22248B3
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900464; cv=none; b=HQTsa9jwOErceyFVJ+3L1cmRwJ4QeecKWvSrpCMxNa7L71FH79/4ZiS4I8hhSw1lz1PjcIqQ/P93aFOoPXZOmlUUB/24QRg75uHyWYUdHmbYmn5Bds0EA6LxVc2HPSJUo7N9i3CkqYBKrWeGFg+s4XI7EBz/qQXVBG6bXNLbpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900464; c=relaxed/simple;
	bh=SivmnrAFIYwbeUndZBDy0z7NBvVuI7pZ/eqjqvAqOWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDG4xdZHKgySZadTkwNNUBp+m2RxagrFbXTtIg3+t/oK2gz3u6MC99m1HqqGJsLyndIMfG5cqHZoRI5e03FnnrBbk5aPMh0i8SBfUxusDfpCzKzxT3YptdSRpedz+zggRUA/ZY1VvHyXFFB3LvHMCPBKxyfu/c63joXQAkPNCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dU2aaGKJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dU2aaGKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773900463; x=1805436463;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SivmnrAFIYwbeUndZBDy0z7NBvVuI7pZ/eqjqvAqOWw=;
  b=dU2aaGKJY2F2HQVMDTqIdgwyr2i/NYUeCwZ+lEzuVh4JpKIx3HCQSMxd
   vZkrOK1KpjFuSaE9XeBBGZoj4UD1MRQeVcsoafj3/jNSjNyWbh7jxYTSN
   msX2DknDXbdH9YxsasZleNTKhunld3J7zaqcd2tuAsmH2rhUmxlllFKmN
   VZmeJWj7fT1xQ/9Cma/HI3cmIFa8mrpRkAhgsIkBB2mjnXlvFsmPZ461M
   yjQGFRvdOkb4POp3xPrhTJXC/8NhmPJVgBrAl57Z5xDbE7gnAnkuiu0Y/
   wrTHb40HsIIdLU807zSnkGOxXr8k1AuDVXw98VWCScDBtB10manArdxNS
   g==;
X-CSE-ConnectionGUID: zd52TFPoT5GEpX/Bdx8uRQ==
X-CSE-MsgGUID: TV3f7vGTS9Cy/9b7plS/7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="77574117"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="77574117"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 23:07:43 -0700
X-CSE-ConnectionGUID: Uj6G5AaISgulHqnC05raRg==
X-CSE-MsgGUID: 9uasM1JKT2uT77r1puqdOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="218806151"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 23:07:41 -0700
Message-ID: <ef328a7e-59a4-4a74-bc72-aa13951b38ff@linux.intel.com>
Date: Thu, 19 Mar 2026 14:06:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux error `[DMA Write NO_PASID] Request device [3c:00.0] fault
 addr 0x0 [fault reason 0x05] PTE Write access is not set`
To: Paul Menzel <pmenzel@molgen.mpg.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <88e33b0c-e89f-47a2-9125-d85693d4816f@molgen.mpg.de>
 <d38a2cda-4b29-43ec-ab08-b55c79714810@linux.intel.com>
 <311a59f3-10bb-4a43-b86d-2f1ef316a01c@molgen.mpg.de>
 <8665ed69-9364-4f8a-9238-6adf9b5590a0@linux.intel.com>
 <3a880676-861b-4447-9775-6197ae74ffd3@molgen.mpg.de>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3a880676-861b-4447-9775-6197ae74ffd3@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/26 20:55, Paul Menzel wrote:
> 
> Am 18.03.26 um 07:42 schrieb Baolu Lu:
>> On 3/16/26 22:54, Paul Menzel wrote:
>>>>> On the Intel Kaby Lake laptop Dell XPS 13 9360, Linux logs the 
>>>>> error below:
>>>>>
>>>>>      [17959.189315] ACPI: EC: event unblocked
>>>>>      [17959.197876] DMAR: DRHD: handling fault status reg 2
>>>>>      [17959.197882] DMAR: [DMA Write NO_PASID] Request device 
>>>>> [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is 
>>>>> not set
>>>>>      [17959.198366] DMAR: DRHD: handling fault status reg 2
>>>>>      [17959.198369] DMAR: [DMA Write NO_PASID] Request device 
>>>>> [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is 
>>>>> not set
>>>>>      [17959.198923] DMAR: DRHD: handling fault status reg 2
>>>>>      [17959.201477] nvme nvme0: 4/0/0 default/read/poll queues
>>>>>
>>>>> 3c:00.0 is the NVMe controller/device.
>>>>>
>>>>>      $ lspci -nn -s 3c:00.0
>>>>>      3c:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 
>>>>> NVMe Solid State Drive 512GB [1c5c:1284]
>>>>>
>>>>> This seems to happen only *sometimes* when resuming from ACPI S3.
>>>>>
>>>>> To my knowledge, this is *not* a new problem. Please find the log 
>>>>> messages attached. (Ignore the other DMAR error for now.)
>>>>
>>>> These IOMMU DMA faults are triggered when the NVMe controller attempts
>>>> DMA writes to system memory address 0x0. The IOMMU hardware blocked
>>>> these accesses because the system software has not granted the device
>>>> permission to write to this specific address. It's unlikely a bug or
>>>> problem in the iommu driver as far as I can see.
>>>
>>> I am seeing the same issue on a Dell XPS 15 7590 with Intel NVMe 
>>> controller:
>>>
>>>      $ lspci -nn -s 3d:00.0
>>>      3d:00.0 Non-Volatile memory controller [0108]: Intel Corporation 
>>> SSD DC P4101/Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)
>>>
>>> Logs from Debian’s Linux 6.19.8:
>>
>> Did you see this warning with the v6.18 kernel or earlier?
> 
> Yes, I did see it with earlier Linux versions. For the Dell XPS 13 9360 
> with SK hynix controller I found logs with Linux 6.16:
> 
>      Okt 14 08:10:02 abreu kernel: Linux version 6.16.11+deb14-amd64 
> (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-14 (Debian 
> 14.3.0-8) 14.3.0, GNU ld (GNU Binutils for Debian) 2.45) #1 SMP 
> PREEMPT_DYNAMIC Debian 6.16.11-1 (2025-10-07)
>      […]
>      Okt 15 21:02:49 abreu kernel: DMAR: DRHD: handling fault status reg 2
>      Okt 15 21:02:49 abreu kernel: DMAR: [DMA Write NO_PASID] Request 
> device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is 
> not set
>      Okt 15 21:02:49 abreu kernel: DMAR: DRHD: handling fault status reg 2
>      Okt 15 21:02:49 abreu kernel: DMAR: [DMA Write NO_PASID] Request 
> device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is 
> not set
>      Okt 15 21:02:49 abreu kernel: DMAR: DRHD: handling fault status reg 2
>      Okt 15 21:02:49 abreu kernel: nvme nvme0: 4/0/0 default/read/poll 
> queues

The error occurs when the NVMe controller attempts to access system
memory using IOVA 0. The iommu subsystem reserves IOVA 0 and treats it
as an invalid address; therefore, the Linux driver is unlikely to
program a device with IOVA 0 for DMA.

An exception is reserved memory used by firmware, where the regions are
identity-mapped by the iommu core during the probe process. There was a
recent fix addressing an issue with identity mapping at address 0:

https://lore.kernel.org/linux-iommu/20260227080638.208693-1-lkml@antheas.dev/

Could you please test if this patch helps? It has already been merged
into the iommu subsystem tree.

Thanks,
baolu
