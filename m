Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB530E826
	for <iommu@lists.linux.dev>; Sun,  8 Feb 2026 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770546195; cv=none; b=TflG49xeCM4y0Whqxc9dYIt5jCjsD3wi5Rxi2JKAGb1bgkmH+30M5cDFKVY3gK9xFfsj7eNFwunHWPW2s3ddYzRyVb6zs+6setR8RCfHFVmilzSetB+o5mZdxhIrJ2L8NvDn4BmoTF61a5p3vHfWqo+JvgzXElJqL1Ku4U9pt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770546195; c=relaxed/simple;
	bh=0D1fyVLMTNFI3om/qQTQO9E6rBMzf3AD+oEMaUkEe0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQkOS+2cKuGvtPyOubh8B78f10qJ3t0qyvfiuUxz3Yvwt0HPYFDrStGXh+T3sry6PvK4TrVfVFgqf6d6EFdtN+GtKZTVOnlE3O6pdfewUI118Qe3lH2a9sv1GLGYiyl/cRmM4z3Vbosasa292bGoGafguaKayk3yhqyX/uEJKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v9TVNJ92; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v9TVNJ92"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770546186; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/YTlgEjGl4DBqvWcfRLhvAaAK7kaMxDyhvdBvE+tsH0=;
	b=v9TVNJ92ZUSHR7PlscgeOkZoLVWVbLRXn97IO2JDjmY+0KF9fzOL/V9UerEQm+I9tQx2XyGPqwCut4c4Tr3OQj4jQHI6RLqykz5HUCSQtVKuMJTjwx6hXIOoZM39bHetPhAVJe0bT7ciSVUFvfs6l+tECcNU8/gPupLOw2qlwZA=
Received: from 30.170.50.139(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WyklY25_1770546175 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 08 Feb 2026 18:23:05 +0800
Message-ID: <f152400d-cda1-47e3-8722-5b72855f0a96@linux.alibaba.com>
Date: Sun, 8 Feb 2026 18:22:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: fix intel iommu iotlb sync hardlockup & retry
To: Baolu Lu <baolu.lu@linux.intel.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: xunlei <xlpang@linux.alibaba.com>
References: <20260202020920.3557883-1-guanghuifeng@linux.alibaba.com>
 <086971f2-cec7-414d-8cc9-01836ef7259a@linux.intel.com>
 <ebd62398-342f-4b28-8c7e-ce0ec8dd8889@linux.alibaba.com>
 <f8e35741-6b4c-4e14-a0a5-2c3176840242@linux.intel.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <f8e35741-6b4c-4e14-a0a5-2c3176840242@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/2/6 10:55, Baolu Lu 写道:
> On 2/5/26 18:28, guanghuifeng@linux.alibaba.com wrote:
>>
>> 在 2026/2/4 17:32, Baolu Lu 写道:
>>> On 2/2/2026 10:09 AM, Guanghui Feng wrote:
>>>> Device-TLB Invalidation Response Time-out (ITE) handling was added in
>>>> commit: 6ba6c3a4cacfd68bf970e3e04e2ff0d66fa0f695.
>>>>
>>>> When an ITE occurs, iommu will sets the ITE (Invalidation Time-out
>>>> Error) field in the Fault Status Register. No new descriptors are
>>>> fetched from the Invalidation Queue until software clears the ITE 
>>>> field
>>>> in the Fault Status Register. Tail pointer Register updates by 
>>>> software
>>>> while the ITE field is Set does not cause descriptor fetches by
>>>> hardware. At the time ITE field is Set, hardware aborts any
>>>> inv_wait_dsc commands pending in hardware and does not increment
>>>> the Invalidation Queue Head register. When software clears the
>>>> ITE field in the Fault Status Register, hardware fetches
>>>> descriptor pointed by the Invalidation Queue Head register.
>>>>
>>>> But in the qi_check_fault process, it is implemented by default
>>>> according to the 2009 commit: 
>>>> 6ba6c3a4cacfd68bf970e3e04e2ff0d66fa0f695,
>>>> that is, only one struct qi_desc is submitted at a time. A qi_desc 
>>>> request is
>>>> immediately followed by a wait_desc/QI_IWD_TYPE for
>>>> synchronization. Therefore, the IOMMU driver implementation
>>>> considers invalid queue entries at odd positions to be
>>>> wait_desc. After ITE is set, hardware aborts any pending
>>>> inv_wait_dsc commands in hardware. Therefore, qi_check_fault
>>>> iterates through odd-position as wait_desc entries and sets
>>>> desc_status to QI_ABORT. However, the current implementation
>>>> allows multiple struct qi_desc to be submitted simultaneously,
>>>> followed by one wait_desc, so it's no longer guaranteed that
>>>> odd-position entries will be wait_desc. When the number of submitted
>>>> struct qi_desc is even, wait_desc's desc_status will not be set to 
>>>> QI_ABORT,
>>>> qi_check_fault will return 0, and qi_submit_sync will then
>>>> execute in an infinite loop and cause a hard lockup when
>>>> interrupts are disabled and the PCIe device does not respond to
>>>> Device-TLB Invalidation requests.
>>>
>>> Yes. This appears a real software bug.
>>>
>>>>
>>>> Additionally, if the device remains online and an IOMMU ITE
>>>> occurs, simply returning -EAGAIN is sufficient. When processing
>>>> the -EAGAIN result, qi_submit_sync will automatically reclaim
>>>> all submitted struct qi_desc and resubmit the requests.
>>>>
>>>> Through this modification:
>>>> 1. Correctly triggers the resubmission of struct qi_desc when
>>>> an ITE occurs.
>>>> 2. Prevents the IOMMU driver from disabling interrupts and
>>>> executing in an infinite loop within qi_submit_sync when an
>>>> ITE occurs, avoiding hardlockup.
>>>
>>> But I think this fix changes the behavior of the driver.
>>>
>>> Previously, when an ITE error was detected, it cleared the ITE so that
>>> hardware could keep going, aborted all wait-descriptors that were being
>>> handled by hardware, and returned -EAGAIN if its own wait-descriptor 
>>> was
>>> impacted.
>>>
>>> This patch changes the behavior; it returns -EAGAIN directly 
>>> whenever it
>>> detects an ITE error, regardless of whether its wait-desc is impacted.
>>> In the single-threaded case, it works as expected, but race condition
>>> might occur when qi_submit_sync() is called in multiple threads at the
>>> same time.
>>>
>>>>
>>>> Signed-off-by: Guanghui Feng<guanghuifeng@linux.alibaba.com>
>>>> ---
>>>>   drivers/iommu/intel/dmar.c | 18 +++---------------
>>>>   1 file changed, 3 insertions(+), 15 deletions(-)
>>>
>>> Have you tried to fix it by dropping the "odd position" assumption? For
>>> example, removing "head |= 1" and decrementing by 1 instead of 2 in the
>>> loop?
>>>
>>>      do {
>>>              if (qi->desc_status[head] == QI_IN_USE)
>>>                      qi->desc_status[head] = QI_ABORT;
>>>              head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>>      } while (head != tail);
>>>
>>> Thanks,
>>> baolu
>>
>> Thank you for your reply.
>>
>> There are a few points that need clarification:
>> The descriptors between head and tail are requests that have not been 
>> fetched and executed.
>>
>>
>> Regarding the requests before the head:
>> Method 1: Does the IOMMU update the head address register immediately 
>> after fetching the descriptor?
>> Method 2: Or does the IOMMU update the head register only after 
>> fetching and executing the request?
>>
>> The current Intel IOMMU VT-d specification does not describe this 
>> behavior in detail.
>> Does the IOMMU currently use Method 1?
>>
>> Therefore, after an ITE timeout, it's necessary to resend the 
>> requests before the head index
>
> An obvious race that I can think of is something like this:
>
> Thread A placed a dev-tlb-inv-desc in the invalidation queue. After
> that, thread B placed an iotlb-inv-desc in the queue. Now the requests
> in the queue look like this:
>
>     dev-tlb-inv-desc for A
>     iotlb-inv-desc for B
>
> Then a device TLB invalidation timeout error happens and triggers the
> ITE bit to be set in the fault register. Thread B sees this in its
> qi_check_fault(), clears the ITE bit, and returns -EAGAIN. Then thread A
> will loop infinitely waiting for DONE in its wait-desc.
>
> The qi_submit_sync() logic has been there for years. Changing its
> behavior without enough validation on real hardware will cause
> unexpected issues. The better approach I would suggest is to fix the
> outdated logic.
>
> Thanks,
> baolu

Thank you for your reply.

 From the IOMMU VT-d documentation, it is known that the IOTLB maintenance
process has sequential dependencies, for example, a context IOTLB flush must
precede a PASID IOTLB flush. To ensure the execution order:


Method 1: Requests in the invalid queue are executed sequentially, 
requiring
only that the software submission order is valid. The IOMMU updates the
head pointer only after completing a request.


Method 2: Requests in the invalid queue are executed in parallel and out 
of order.
The software ensures the execution order of multiple requests by adding 
wait_desc entries.

If the Intel IOMMU uses Method 1, and only updates the head pointer upon 
completion
of a request (even if a timeout occurs during the execution process 
after fetching the request),
then after an ITE timeout, clearing the ITE status in any context will 
trigger the IOMMU to re-fetch
and execute the request, without requiring resubmission of the 
descriptor request.

Therefore, could you please help me to confirm the current behavior 
pattern of the Intel IOMMU execution process?

Thanks

