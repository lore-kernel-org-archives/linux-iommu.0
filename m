Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899371FA82F
	for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732711064; cv=none; b=DgFGv+OxTVD46xPtQTWADo5RBLvZB0SQHB+dXtuE28c8sG0DW2sGnRgNv28Wolm4LNxk/xudAa53CRxwlY5SQ49wiV6etdm8rKd1gLyynoKVfs04zVjLH7WPxotypwn/TnDlfT5elD7qJ/y8Ui/wjrHohrPqLFeCcLu8FyA2R9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732711064; c=relaxed/simple;
	bh=DWeHupjilyQqO2NEwkCtE2LQUfLLq5VTcNi7eejgv/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2dkFUYNE3vZTdxNUravjy87QdUmLnHIuXMMEbFs0mjShhJv6HqB8vejc1BY57w6sHN348lJ3nDd3jjlnuVPZB/DIPhq+o97knsg5h7ERS37pC3+SlrpIvL5BrKXnFNbDdAfSFui4ygbHHGqPUz/O6fAMGNbbjAkhLV544qLvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA5D2150C;
	Wed, 27 Nov 2024 04:38:10 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEE8B3F66E;
	Wed, 27 Nov 2024 04:37:39 -0800 (PST)
Message-ID: <ad917c62-0e19-4178-9fbc-a288117aa196@arm.com>
Date: Wed, 27 Nov 2024 12:37:38 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gaW9t?=
 =?UTF-8?Q?mu=3A_Downgrade_print_level_for_iommu_group_information?=
To: Pranjal Shrivastava <praan@google.com>, "Li,Rongqing"
 <lirongqing@baidu.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20241126072339.25714-1-lirongqing@baidu.com>
 <84cb9155-4793-45f9-bb67-6926e103dc84@arm.com>
 <e790f039210f4bd78a015a6fa439c607@baidu.com> <Z0bxg0P9AtSHW82A@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z0bxg0P9AtSHW82A@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2024 10:16 am, Pranjal Shrivastava wrote:
> On Tue, Nov 26, 2024 at 12:09:03PM +0000, Li,Rongqing wrote:
>>
>>> On 26/11/2024 7:23 am, Li RongQing wrote:
>>>> This per device log is becoming longer with more and more PCI devices
>>>> in system, which slows down the boot process due to the serializing
>>>> nature of printk().
>>>>
>>>> Downgrade dev_info() to dev_dbg() so it is still accessible for debug
>>>> purposes.
>>>
>>> Previously discussed 4 and a half years ago:
>>>
>>> https://lore.kernel.org/linux-iommu/20200302154426.GC6540@8bytes.org/
>>>
> 
> Hmm.. I'm wondering if ratelimiting might help here?
> We can define a rate_limit for the iommu subsystem that can be tuned
> accordingly to control verbosity. We can keep the rate_limit to a min.
> as we'd like and maintain it upstream and give users an option to tune
> it as per their requirement.

No, this is not an issue of rate, and we're not going to reinvent some 
obscure IOMMU-API-specific version of loglevel just for this. These are 
at "info" level for good reason, so anyone who only cares about warnings 
or errors can already filter their console output to suit.

Debug enough "my device stops working after I enable the IOMMU" issues 
by email using only dmesg logs, and you might start to appreciate how 
often it's a case of scrolling way way back from the apparent error to 
see that the device was added to a *different* group than expected, or 
crucially, seeing the conspicuous *absence* of any message, because the 
IOMMU driver didn't believe it was responsible for that device in the 
first place.

Thanks,
Robin.

>>> Also, given that the iommu_probe_device() path is inherently serialised anyway,
>>> if logging a message from there significantly slows down your boot process, how
>>> slow is your console device?
>>>
>>
>>
>> There are 482 in my machine, spends nearly about 3 seconds
>>
>> [   40.083614] DMAR: dmar1: Using Queued invalidation
>> [   40.089008] DMAR: dmar0: Using Queued invalidation
>> [   40.094402] DMAR: dmar19: Using Queued invalidation
>> [   40.100816] pci 0000:79:00.4: Adding to iommu group 0
>> [   40.106586] pci 0000:79:01.0: Adding to iommu group 1
>> [   40.112346] pci 0000:79:02.0: Adding to iommu group 2
>> [   40.118315] pci 0000:74:00.4: Adding to iommu group 3
>> [   40.124074] pci 0000:74:01.0: Adding to iommu group 4
>> [   40.129830] pci 0000:74:02.0: Adding to iommu group 5
> ------------------------------->8-----------------------------
> 			snip
> ------------------------------->8-----------------------------
>> [   43.140538] pci 0000:ff:1e.6: Adding to iommu group 482
>> [   43.146522] pci 0000:ff:1e.7: Adding to iommu group 482
>> [   43.153222] DMAR: Intel(R) Virtualization Technology for Directed I/O
>> [   43.160471] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>> [   43.167715] software IO TLB: mapped [mem 0x000000006123e000-0x000000006523e000] (64MB)
>> [   43.178633] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
>> [   43.187540] RAPL PMU: hw unit of domain package 2^-14 Joules
>> [   43.193906] RAPL PMU: hw unit of domain dram 2^-14 Joules
>> [   43.199984] RAPL PMU: hw unit of domain psys 2^-0 Joules
>>
> 
> Thanks,
> Praan
