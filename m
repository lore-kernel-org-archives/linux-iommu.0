Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51272333742
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047155; cv=none; b=ZcB8lS+879IlAx9RcQB8U1wwVkLXgw8oPB/AsjB+YCqjKVSF4tjAd+IimY+jnV5Ki7zQaGmB+oAq1p7OgCD4TIxcj6Fp5uIJ3ji4Uv4SezWqV/os85K4doWS1GoB5cZoDMaSRsJc8NRtUWaOUnipHpECiwUavTmSfgeduJfYTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047155; c=relaxed/simple;
	bh=ihkESXXFhGEMGxotWCa/rtAXS2eUXkMN05EckVch9Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiPhx3lSXb+L6CCxQDQq/TL7xuGOOet7Zj5firu7n4u9JC31QQbw5/LZdiPoMWyA/UQUNtipte7p1u/vm4jdFh7obu+BHCN6CwIrz+YyyNZ9swJjyL7CvrQu4KbfF85IRg2IgPi+H61RPW/4O4H1HtOV4B4r/6Ejx8WgXEc9YbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0D941063;
	Tue, 21 Oct 2025 04:45:44 -0700 (PDT)
Received: from [10.57.37.65] (unknown [10.57.37.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D2C3F63F;
	Tue, 21 Oct 2025 04:45:50 -0700 (PDT)
Message-ID: <336c5a8a-ac2c-4e4c-b2f9-a0bc056aa498@arm.com>
Date: Tue, 21 Oct 2025 12:45:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
 Zhang Yu <zhangyu1@linux.microsoft.com>,
 Jean Philippe-Brucker <jean-philippe@linaro.org>,
 Alexander Grest <Alexander.Grest@microsoft.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
 <aPIhMGnzHiBkIEam@google.com> <20251017135145.GL3901471@nvidia.com>
 <20251017095031.00000b84@linux.microsoft.com>
 <20251020120240.GI316284@nvidia.com>
 <20251020115710.0000258b@linux.microsoft.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251020115710.0000258b@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-20 7:57 pm, Jacob Pan wrote:
> On Mon, 20 Oct 2025 09:02:40 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
>> On Fri, Oct 17, 2025 at 09:50:31AM -0700, Jacob Pan wrote:
>>> On Fri, 17 Oct 2025 10:51:45 -0300
>>> Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>    
>>>> On Fri, Oct 17, 2025 at 10:57:52AM +0000, Mostafa Saleh wrote:
>>>>> On Wed, Sep 24, 2025 at 10:54:36AM -0700, Jacob Pan wrote:
>>>>>> Hi Will et al,
>>>>>>
>>>>>> These two patches are derived from testing SMMU driver with
>>>>>> smaller CMDQ sizes where we see soft lockups.
>>>>>>
>>>>>> This happens on HyperV emulated SMMU v3 as well as baremetal
>>>>>> ARM servers with artificially reduced queue size and
>>>>>> microbenchmark to stress test concurrency.
>>>>>
>>>>> Is it possible to share what are the artificial sizes and does
>>>>> the HW/emulation support range invalidation (IRD3.RIL)?
>>>>>
>>>>> I'd expect it would be really hard to overwhelm the command
>>>>> queue, unless the HW doesn't support range invalidation and/or
>>>>> the queue entries are close to the number of CPUs.
>>>>
>>>> At least on Jacob's system there is no RIL and there are 72/144
>>>> CPU cores potentially banging on this.
>>>>
>>>> I think it is combination of lots of required invalidation
>>>> commands, low queue depth and slow retirement of commands that
>>>> make it easier to create a queue full condition.
>>>>
>>>> Without RIL one SVA invalidation may take out the entire small
>>>> queue, for example.
>>> Right, no range invalidation and queue depth is 256 in this case.
>>
>> I think Robin is asking you to justify why the queue depth is 256 when
>> ARM is recommending much larger depths specifically to fix issues like
>> this?
> The smaller queue depth is chosen for CMD_SYNC latency reasons. But I
> don't know the implementation details of HyperV and host SMMU driver.

TBH that sounds highly dubious. The only way I could imagine CMDQ size 
bearing any relation to CMD_SYNC at all is if a hypervisor is emulating 
a stage 1 vCMDQ in such a naive and lazy manner that a) performance is 
already off the table, and b) it has a good chance of being broken anyway.

For the hardware to actually process, say, 1023 invalidations followed 
by a sync takes as long as it takes, based on how busy the SMMU is. The 
only difference in issuing that sequence of commands on a 256-entry 
queue vs. a 1024-entry queue is that in the latter case, software does 
not have to sit waiting for the first 768 to actually be consumed before 
it can finish the submission and potentially get on with something else 
until the sync completes. Yes, one could claim that technically the time 
between *issuing* the CMD_SYNC and its completion is then lower, but 
only because that extra time has now been wasted in a polling loop 
waiting for CMDQ space instead - it's a meaningless distinction overall.

> IMHO, queue size is orthogonal to what this patch is trying to
> address, which is a specific locking problem and improve efficiency.
> e.g. eliminated cmpxchg
> -	do {
> -		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
> -	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
> +	atomic_cond_read_relaxed(&cmdq->lock, VAL > 0);
> 
> Even on BM with restricted queue size, this patch reduces latency of
> concurrent madvise(MADV_DONTNEED) from multiple CPUs (I tested 32 CPUs,
> cutting 50% latency unmap 1GB buffer in 2MB chucks per CPU).
My point is that a 50% improvement on nonsense is likely still nonsense. 
With only 256 entries, every single one of those 2MB unmaps needs to 
fill the entire CMDQ more than twice over. 32 CPUs all jostling to issue 
about 34x as many commands as the queue can hold *each* is a ridiculous 
level of contention. If a hypervisor is advertising an SMMU_IDR1.CMDQS 
value that is absurdly tiny for the size of the VM then that represents 
such an obvious bottleneck that it's hardly mainline Linux's 
responsibility to maintain code to help "debug" it. As for "BM with 
restricted queue size", like I said, just don't do that.

What is the difference on an un-hacked bare-metal system with a 
normally-sized queue? Is it even measurable? That's what's actually 
interesting. Furthermore, what exactly does that measurement even mean? 
If we're still issuing the same number of commands I struggle to believe 
we could lose 50% of the *overall* time just bouncing a cacheline 
between shared and exclusive state - is this actually just the *maximum* 
per-CPU latency going down, at the cost of the minimum latency 
correspondingly increasing just as much (if not comparatively more) due 
to better fairness? And if so, how important is that really? I can 
imagine there are equally cases where other callers might prefer a lower 
minimum/mean latency at the price of some longer outliers.

Note I'm not saying I'm necessarily against making these changes, just 
that I'm against making them without a believable justification that it 
is actually beneficial to mainline users.

Thanks,
Robin.
