Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A713DD536
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245128; cv=none; b=kJiMK79qXqX3kJGdkLoKXm91Cu+/7h6o2yQ0EMrNGpTnVaYKvjPU/EIF5hS47BLoA/GULISkNg8SP7oguPB8qz/AfL8xOuegDu3L1IOdfueSHhZhQaKaQIAIHlFN7bcY10QLW0jVK+ToAcmAP6pM8iNkQ0KLVvpZWM8rV+NqXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245128; c=relaxed/simple;
	bh=TiKhoCoPO98zTUsSoH6ycKjpKEeWG8GNabh01/32pHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/FRSDTVueq3n/hrx7MX0Xh6S4pO7WrJMe49NmO13r+54glMYNbdGkWqHtrUnxMCxFFACg1HuL/oSz7xgIMB25VMlCCiYJgmMgx6M9hsCz/UPGZ4oJYZAyLUTMF+4wyentQocsEzkT358MmLyR93OT/sU7rF8rzJqXY5rZjorHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r+j5yaDt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r+j5yaDt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC4E41BCA;
	Fri,  8 May 2026 05:58:40 -0700 (PDT)
Received: from [10.57.63.248] (unknown [10.57.63.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971823FAF5;
	Fri,  8 May 2026 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778245126; bh=TiKhoCoPO98zTUsSoH6ycKjpKEeWG8GNabh01/32pHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r+j5yaDta12HPpsNHgUBKXv/cU1pyVuYEeBcBBLD8ZsUbfqX55hHELTeSACRS3x4w
	 dVOsfrYDsd9bOj9kG3y13BMTLvuyttjkD5nPjMC4/QOVGogIrmxIYhItUzcrEV9Aa1
	 FurFNj/Vc7jflNbtIOrQAhOP/DQDuwXQSy4qqyXs=
Message-ID: <59d05fdb-bb61-4d92-8df3-45aa3f9f7bee@arm.com>
Date: Fri, 8 May 2026 13:58:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dma-contiguous: setup default numa cma area if not
 configured explicitly
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Feng Tang <feng.tang@linux.alibaba.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Liam.Howlett@oracle.com, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
References: <20260428060550.7167-1-feng.tang@linux.alibaba.com>
 <6dd52f8b-7092-4d02-ba24-f8b55409b7b6@kernel.org>
 <afBxtIdWqv8pD8YE@U-2FWC9VHC-2323.local>
 <f900172c-341a-4956-b7b7-b297418be913@kernel.org>
 <aftiQuHOA0t2lfyP@U-2FWC9VHC-2323.local>
 <a5660e22-b1f9-4dcb-a190-f3dc5253c570@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <a5660e22-b1f9-4dcb-a190-f3dc5253c570@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-08 12:46 pm, David Hildenbrand (Arm) wrote:
> On 5/6/26 17:46, Feng Tang wrote:
>> On Fri, May 01, 2026 at 08:51:39PM +0200, David Hildenbrand (Arm) wrote:
>>> On 4/28/26 10:37, Feng Tang wrote:
>>>> Hi David,
>>>
>>> Hi!
>>>
>>> [...]
>>>
>>>>
>>>> Right for default kernel configs.
>>>>
>>>> In kernel/dma/Kconfig:
>>>>
>>>> config CMA_SIZE_MBYTES
>>>> 	int "Size in Mega Bytes"
>>>> 	depends on !CMA_SIZE_SEL_PERCENTAGE
>>>> 	default 0 if X86
>>>> 	default 16
>>>>
>>>> config CMA_SIZE_PERCENTAGE
>>>> 	int "Percentage of total memory"
>>>> 	depends on !CMA_SIZE_SEL_MBYTES
>>>> 	default 0 if X86
>>>> 	default 10
>>>>
>>>>
>>>> Yes. I thought about that, and didn't have good solution, and used this
>>>> given it's on a multi-numa-node machine, which may not be too bad
>>>> regarding memory usage.
>>>
>>> It sounds wrong given the existing config options.
>>
>> Yes, it is confusing.
>>
>>>>
>>>> Robin did concern about the memory usage for embedded/small devices in
>>>> v2 review, and we change to v3 to not affect them.
>>>>
>>>>
>>>> I agree :)
>>>>
>>>>   
>>>> This sounds good to me, if no objection from others. Maybe default 64MB
>>>> or more. One good part is, all these setup is under protection of
>>>> CONFIG_DMA_NUMA_CMA.
>>>
>>> I cannot do the heavy thinking here because -EBUSY, but maybe you want a config
>>> option similar to CMA_SIZE_MBYTES/CMA_SIZE_PERCENTAGE that either controls that
>>> these sizes will be split over NUMA nodes, or another one, that sets the default
>>> for pernuma.
>>
>> Maybe a CMA_NUMA_SIZE_MBYTES?
> 
> Maybe, I'm hoping some CMA DMA people have the capacity to provide input.

But really that _is_ pretty much the idea here - we're effecting a 
kernel-level default "pernuma" value, which just happens to also be 
CMA_SIZE_*. But in the process we also need to tweak the "pernuma" 
behaviour itself to work as a default, since quietly forcing the current 
opt-in behaviour on single node systems could only hurt them - multiple 
default CMA areas on the same node offers no performance benefit, while 
reducing non-movable allocation capacity which could well be detrimental.

Indeed I am rather assuming that actual NUMA systems should have enough 
memory that this isn't a big deal, but I don't believe that's 
particularly unreasonable. End users should still be able to override 
with "numa_cma=0:0" if they don't want it, the only potential gap is if 
distros want to ship kernels with DMA_NUMA_CMA enabled for command-line 
opt-in but _without_ this new default behaviour. For that we could 
perhaps add something like:

config CMA_SIZE_PERNUMA
	bool "Default CMA area per NUMA node"
	depends on DMA_NUMA_CMA
	default y
	help
	  On systems with more than one NUMA node, the selected CMA
	  area size will be also allocated on each additional node,
	  so that most devices may have benefit from better DMA
	  locality without an explicit command-line opt-in.

Thanks,
Robin.

> 
>>   
>>> [...]
>>>
>>>>
>>>> My thought was 'struct cma' already have 'nid' member, and when CONFIG_NUMA=y,
>>>> it may be useful to save the 'nid' info instead of NUMA_NO_NODE for the default
>>>> cma area (cmdline like cma=XXG@YYG could make it on different node)
>>>
>>> Ah, yeah. It's a bit nasty that we have to handle the default area like that.
>>>
>>> Another sign that we probably shouldn't deal with the default area :)
>>
>> Yep, in v2 I didn't touch the default area, while Robin had a concern
>> that the v2 approach will bindly add an extra per-numa cma area for
>> the node which already has the default area, which will hurt those
>> small/embedded devices which has limited number of memory. Adding
>> the nid check is trying to keep the behavior of one node device
>> unchanged.
>>
>>>>
>>>>
>>>> Per my understanding, it won't. There is a cma_validate_zones() to prevent it
>>>> from crossing zones.
>>>
>>> It's a bit confusing, because it ignores other nids.
>>
>> I might have missed your point. Do you mean one cma are could have
>> multiple ranges?
> 
> I don't know, it's confusing :)
> 

