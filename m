Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A561D2566CB
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198234; cv=none; b=uIKKhKwlhKYQT16BzD0b2d8WSnPCSzJ3rof0t7Bl9rQWl+ssAMoDc5YQAb1hau0Y1LPBp2MQEOldDXPoBytNIx/KHbc0HLc0C7Xv2qdvAHf9HEix/xLdTBJ8llBiNvgjb/c7ez+CSZMBmeJuwhsBBc+HyCH0s536MW7CTQmLM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198234; c=relaxed/simple;
	bh=3VCEOF0ilPu9rCi4P4IJkdiN8fg/6VKi9mPpwDC4U0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+ZgF51/fcHfGDgbXsn9fTsH2XhdiSXAnVJINCahw+s09f7jY0EmxDIXe9WkhUkeIEgdOyiYo8t2pgXld8LMcd2PEPseVxswLO5Xm/JgNthQ5finO9p25JEjcCW616M8SFloGAzPbA81yXbip/B/Gf+1M9qIFTt148Moq9XNtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B2B41595;
	Wed,  9 Apr 2025 04:30:32 -0700 (PDT)
Received: from [10.57.72.20] (unknown [10.57.72.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D0EA3F694;
	Wed,  9 Apr 2025 04:30:30 -0700 (PDT)
Message-ID: <74c07104-d072-4d2f-9b79-d9a1c3f2bc54@arm.com>
Date: Wed, 9 Apr 2025 12:30:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: fix crash in report_iommu_fault()
To: Jason Gunthorpe <jgg@ziepe.ca>, Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20250408213342.285955-1-pchelkin@ispras.ru>
 <20250408213828.GC1727154@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250408213828.GC1727154@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-08 10:38 pm, Jason Gunthorpe wrote:
> On Wed, Apr 09, 2025 at 12:33:41AM +0300, Fedor Pchelkin wrote:
>> The following crash is observed while handling an IOMMU fault with a
>> recent kernel:
>>
>> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>> BUG: unable to handle page fault for address: ffff8c708299f700
>> PGD 19ee01067 P4D 19ee01067 PUD 101c10063 PMD 80000001028001e3
>> Oops: Oops: 0011 [#1] SMP NOPTI
>> CPU: 4 UID: 0 PID: 139 Comm: irq/25-AMD-Vi Not tainted 6.15.0-rc1+ #20 PREEMPT(lazy)
>> Hardware name: LENOVO 21D0/LNVNB161216, BIOS J6CN50WW 09/27/2024
>> RIP: 0010:0xffff8c708299f700
>> Call Trace:
>>   <TASK>
>>   ? report_iommu_fault+0x78/0xd3
>>   ? amd_iommu_report_page_fault+0x91/0x150
>>   ? amd_iommu_int_thread+0x77/0x180
>>   ? __pfx_irq_thread_fn+0x10/0x10
>>   ? irq_thread_fn+0x23/0x60
>>   ? irq_thread+0xf9/0x1e0
>>   ? __pfx_irq_thread_dtor+0x10/0x10
>>   ? __pfx_irq_thread+0x10/0x10
>>   ? kthread+0xfc/0x240
>>   ? __pfx_kthread+0x10/0x10
>>   ? ret_from_fork+0x34/0x50
>>   ? __pfx_kthread+0x10/0x10
>>   ? ret_from_fork_asm+0x1a/0x30
>>   </TASK>
>>
>> report_iommu_fault() checks for an installed handler comparing the
>> corresponding field to NULL. It can (and could before) be called for a
>> domain with a different cookie type - IOMMU_COOKIE_DMA_IOVA, specifically.
>> Cookie is represented as a union so we may end up with a garbage value
>> treated there if this happens for a domain with another cookie type.
>>
>> Formerly there were two exclusive cookie types in the union.
>> IOMMU_DOMAIN_SVA has a dedicated iommu_report_device_fault().
>>
>> Call the fault handler only if the passed domain has a required cookie
>> type.
>>
>> Found by Linux Verification Center (linuxtesting.org).
>>
>> Fixes: 6aa63a4ec947 ("iommu: Sort out domain user data")
>> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
>> ---
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> This should go to rc
> 
>>> iommu-dma itself isn't ever going to use a fault
>>> handler because it expects the DMA API to be used correctly and thus no
>>> faults to occur.
>>
>> My first thought about this is that iommu-dma is not interested in
>> installing a fault handler ever, okay. But why does it suppose that no
>> faults would occur? It is a matter of "chance", firmware bugs, abovesaid
>> DMA API abusing, etc... isn't it?
> 
> Yes, it should not happen, this driver is clearly buggy.

Right, it's not that we assume no faults can occur at all, just that any 
faults are *unexpected* since they represent some device or driver doing 
something wrong in any number of ways, thus there is nothing a fault 
handler could reasonably do except print "a fault happened!", which 
every IOMMU driver is going to do anyway, therefore there is no need to 
support fault handlers on DMA domains.

But indeed it is now erroneous to be dereferencing domain->handler 
without checking that it is in fact a handler, sorry I missed that.

Thanks,
Robin.
