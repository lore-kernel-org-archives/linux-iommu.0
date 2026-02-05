Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876A38F935
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287309; cv=none; b=egLQ2xx0oT2zFsN2FnBkFmY0ZgU/0M/KPKNR6GnXCZWRwVkZI9Nqd92MW/5H+RNJGY/5ej5r3e3uz/3ie3lBIIWb584nAGBKFr8qrWRVeo7dtCLMGRRNUjRfcqWYuFarkvqkvL1MTxbMVbtavLS5Qtff1cnznhBeKNTgJ3jDdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287309; c=relaxed/simple;
	bh=MrEAYhPwtkyE3yRoYGgP/bW1CuJMLWwK77fg8PR0s4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qx6+fSb8vWUkowdoEFIv6GRIW0EIuyDiqYfYgOxKYFQjfOtw4iJGaqMMgHD0Or0S3DrHTSK9pnoLalzFpy54I7KW2nI/2vI2bpOcRtEqpuJ7SLogKYQU8pFj9+yKf80dCfZEoMkWEk5pp4bBQnssAjXlGTfluap/OXZ19DCAXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f1B6LWZL; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f1B6LWZL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770287305; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qRkTvaDUr4bAQDyvXLvSyjpEwWKU8L5+9/GNNbCGlAU=;
	b=f1B6LWZLd9TVGUdRXH2nmfzhFVOMFbbP4HjxnR6oEpL47WWTb9m/GQ4udeL6nz4XvZi16k9kS5EvAoChjtvfP1Hcz8pmy+R4e0N4HP2PZvJQJ7GZRqWY01dq+Wkxq40x1rDL8CttwIyCou7aBNj4KIIVq7pZNVhxG6Z4P9yMTL0=
Received: from 30.221.133.75(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WyakmZ7_1770287291 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Feb 2026 18:28:24 +0800
Message-ID: <ebd62398-342f-4b28-8c7e-ce0ec8dd8889@linux.alibaba.com>
Date: Thu, 5 Feb 2026 18:28:13 +0800
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
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <086971f2-cec7-414d-8cc9-01836ef7259a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/2/4 17:32, Baolu Lu 写道:
> On 2/2/2026 10:09 AM, Guanghui Feng wrote:
>> Device-TLB Invalidation Response Time-out (ITE) handling was added in
>> commit: 6ba6c3a4cacfd68bf970e3e04e2ff0d66fa0f695.
>>
>> When an ITE occurs, iommu will sets the ITE (Invalidation Time-out
>> Error) field in the Fault Status Register. No new descriptors are
>> fetched from the Invalidation Queue until software clears the ITE field
>> in the Fault Status Register. Tail pointer Register updates by software
>> while the ITE field is Set does not cause descriptor fetches by
>> hardware. At the time ITE field is Set, hardware aborts any
>> inv_wait_dsc commands pending in hardware and does not increment
>> the Invalidation Queue Head register. When software clears the
>> ITE field in the Fault Status Register, hardware fetches
>> descriptor pointed by the Invalidation Queue Head register.
>>
>> But in the qi_check_fault process, it is implemented by default
>> according to the 2009 commit: 6ba6c3a4cacfd68bf970e3e04e2ff0d66fa0f695,
>> that is, only one struct qi_desc is submitted at a time. A qi_desc 
>> request is
>> immediately followed by a wait_desc/QI_IWD_TYPE for
>> synchronization. Therefore, the IOMMU driver implementation
>> considers invalid queue entries at odd positions to be
>> wait_desc. After ITE is set, hardware aborts any pending
>> inv_wait_dsc commands in hardware. Therefore, qi_check_fault
>> iterates through odd-position as wait_desc entries and sets
>> desc_status to QI_ABORT. However, the current implementation
>> allows multiple struct qi_desc to be submitted simultaneously,
>> followed by one wait_desc, so it's no longer guaranteed that
>> odd-position entries will be wait_desc. When the number of submitted
>> struct qi_desc is even, wait_desc's desc_status will not be set to 
>> QI_ABORT,
>> qi_check_fault will return 0, and qi_submit_sync will then
>> execute in an infinite loop and cause a hard lockup when
>> interrupts are disabled and the PCIe device does not respond to
>> Device-TLB Invalidation requests.
>
> Yes. This appears a real software bug.
>
>>
>> Additionally, if the device remains online and an IOMMU ITE
>> occurs, simply returning -EAGAIN is sufficient. When processing
>> the -EAGAIN result, qi_submit_sync will automatically reclaim
>> all submitted struct qi_desc and resubmit the requests.
>>
>> Through this modification:
>> 1. Correctly triggers the resubmission of struct qi_desc when
>> an ITE occurs.
>> 2. Prevents the IOMMU driver from disabling interrupts and
>> executing in an infinite loop within qi_submit_sync when an
>> ITE occurs, avoiding hardlockup.
>
> But I think this fix changes the behavior of the driver.
>
> Previously, when an ITE error was detected, it cleared the ITE so that
> hardware could keep going, aborted all wait-descriptors that were being
> handled by hardware, and returned -EAGAIN if its own wait-descriptor was
> impacted.
>
> This patch changes the behavior; it returns -EAGAIN directly whenever it
> detects an ITE error, regardless of whether its wait-desc is impacted.
> In the single-threaded case, it works as expected, but race condition
> might occur when qi_submit_sync() is called in multiple threads at the
> same time.
>
>>
>> Signed-off-by: Guanghui Feng<guanghuifeng@linux.alibaba.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 18 +++---------------
>>   1 file changed, 3 insertions(+), 15 deletions(-)
>
> Have you tried to fix it by dropping the "odd position" assumption? For
> example, removing "head |= 1" and decrementing by 1 instead of 2 in the
> loop?
>
>      do {
>              if (qi->desc_status[head] == QI_IN_USE)
>                      qi->desc_status[head] = QI_ABORT;
>              head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>      } while (head != tail);
>
> Thanks,
> baolu

Thank you for your reply.

There are a few points that need clarification:
The descriptors between head and tail are requests that have not been 
fetched and executed.


Regarding the requests before the head:
Method 1: Does the IOMMU update the head address register immediately 
after fetching the descriptor?
Method 2: Or does the IOMMU update the head register only after fetching 
and executing the request?

The current Intel IOMMU VT-d specification does not describe this 
behavior in detail.
Does the IOMMU currently use Method 1?

Therefore, after an ITE timeout, it's necessary to resend the requests 
before the head index


