Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CE296BDA
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 02:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346547; cv=none; b=YbyCxD84H/bkjtVMjx6k6VPpJ6DPwAj6T+mh3BY3eMrA1mkYdAcw388NBzRqK2sqzwiAczdWhK8ElmirI1NndZf+gK5J8aih1cqOmvYJsrszmjTLcDSThGCCwq/inX19YQ+PcjwkEcu3I40QoyE2/Nro2651TGKYAHewdaVaXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346547; c=relaxed/simple;
	bh=yiSl2WFrsPJ6WkTi8vj2cQHDh/2j1YfyfpPz6+AdYzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g45VL3POEWlnnRujjH5Idju6JVoFG96GIB3o3EFimgQ9uz4wOZinyvou50CI26YHsEAzmSDajA3V+qFsTxcEv1sRHJMgvOCeBdzIrkZfyrvnUVyWNsWDfkaOdyKMfSWkWkMfYiiIveUWCP/4RdpynOwSQUgqOHAthbc1lfijLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFTs/q9V; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFTs/q9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770346547; x=1801882547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yiSl2WFrsPJ6WkTi8vj2cQHDh/2j1YfyfpPz6+AdYzo=;
  b=XFTs/q9VzOabl0X2ldjilVxd9lK1AHj9b1SmxMQnCZgw263yUd/Wy3VM
   HhpZg/MzPQzqFf7+Z2qOal0yIkCRFlIkYlE4MIF3ugqBrUykMrmRbwePT
   Yb4r8c2kuO0V7GphpZNRPv6YPK4O3cHpGV8iftDquLVUcV9UWzVA95uXc
   KaqkqV4EYAKFXvbUPKDaANMKHVIFBZlBMUv4JnDHixctaLdJSP5PgFAtq
   J3dcuwsZK6JVUltV+MLGOA7VEph+N7xdFtiNBq8uy9fdOaLH12nBZx4p+
   MvjaWA3JskqMhk2Hg4vvp31oyK/ht7kqKz0898uAnkHjgw2JN8MCbNqbI
   g==;
X-CSE-ConnectionGUID: 1U0E0M6/SHe5i2Ns1HrXCA==
X-CSE-MsgGUID: 45TBOd0BT2aeR1MIdevlsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="94202409"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="94202409"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 18:55:47 -0800
X-CSE-ConnectionGUID: DfroXyZpQYmoCv8MvQfibg==
X-CSE-MsgGUID: xhCFIq3USk60Lnm4zJsuXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="210794197"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 18:55:45 -0800
Message-ID: <f8e35741-6b4c-4e14-a0a5-2c3176840242@linux.intel.com>
Date: Fri, 6 Feb 2026 10:55:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: fix intel iommu iotlb sync hardlockup & retry
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 dwmw2@infradead.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: xunlei <xlpang@linux.alibaba.com>
References: <20260202020920.3557883-1-guanghuifeng@linux.alibaba.com>
 <086971f2-cec7-414d-8cc9-01836ef7259a@linux.intel.com>
 <ebd62398-342f-4b28-8c7e-ce0ec8dd8889@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ebd62398-342f-4b28-8c7e-ce0ec8dd8889@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/26 18:28, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/2/4 17:32, Baolu Lu 写道:
>> On 2/2/2026 10:09 AM, Guanghui Feng wrote:
>>> Device-TLB Invalidation Response Time-out (ITE) handling was added in
>>> commit: 6ba6c3a4cacfd68bf970e3e04e2ff0d66fa0f695.
>>>
>>> When an ITE occurs, iommu will sets the ITE (Invalidation Time-out
>>> Error) field in the Fault Status Register. No new descriptors are
>>> fetched from the Invalidation Queue until software clears the ITE field
>>> in the Fault Status Register. Tail pointer Register updates by software
>>> while the ITE field is Set does not cause descriptor fetches by
>>> hardware. At the time ITE field is Set, hardware aborts any
>>> inv_wait_dsc commands pending in hardware and does not increment
>>> the Invalidation Queue Head register. When software clears the
>>> ITE field in the Fault Status Register, hardware fetches
>>> descriptor pointed by the Invalidation Queue Head register.
>>>
>>> But in the qi_check_fault process, it is implemented by default
>>> according to the 2009 commit: 6ba6c3a4cacfd68bf970e3e04e2ff0d66fa0f695,
>>> that is, only one struct qi_desc is submitted at a time. A qi_desc 
>>> request is
>>> immediately followed by a wait_desc/QI_IWD_TYPE for
>>> synchronization. Therefore, the IOMMU driver implementation
>>> considers invalid queue entries at odd positions to be
>>> wait_desc. After ITE is set, hardware aborts any pending
>>> inv_wait_dsc commands in hardware. Therefore, qi_check_fault
>>> iterates through odd-position as wait_desc entries and sets
>>> desc_status to QI_ABORT. However, the current implementation
>>> allows multiple struct qi_desc to be submitted simultaneously,
>>> followed by one wait_desc, so it's no longer guaranteed that
>>> odd-position entries will be wait_desc. When the number of submitted
>>> struct qi_desc is even, wait_desc's desc_status will not be set to 
>>> QI_ABORT,
>>> qi_check_fault will return 0, and qi_submit_sync will then
>>> execute in an infinite loop and cause a hard lockup when
>>> interrupts are disabled and the PCIe device does not respond to
>>> Device-TLB Invalidation requests.
>>
>> Yes. This appears a real software bug.
>>
>>>
>>> Additionally, if the device remains online and an IOMMU ITE
>>> occurs, simply returning -EAGAIN is sufficient. When processing
>>> the -EAGAIN result, qi_submit_sync will automatically reclaim
>>> all submitted struct qi_desc and resubmit the requests.
>>>
>>> Through this modification:
>>> 1. Correctly triggers the resubmission of struct qi_desc when
>>> an ITE occurs.
>>> 2. Prevents the IOMMU driver from disabling interrupts and
>>> executing in an infinite loop within qi_submit_sync when an
>>> ITE occurs, avoiding hardlockup.
>>
>> But I think this fix changes the behavior of the driver.
>>
>> Previously, when an ITE error was detected, it cleared the ITE so that
>> hardware could keep going, aborted all wait-descriptors that were being
>> handled by hardware, and returned -EAGAIN if its own wait-descriptor was
>> impacted.
>>
>> This patch changes the behavior; it returns -EAGAIN directly whenever it
>> detects an ITE error, regardless of whether its wait-desc is impacted.
>> In the single-threaded case, it works as expected, but race condition
>> might occur when qi_submit_sync() is called in multiple threads at the
>> same time.
>>
>>>
>>> Signed-off-by: Guanghui Feng<guanghuifeng@linux.alibaba.com>
>>> ---
>>>   drivers/iommu/intel/dmar.c | 18 +++---------------
>>>   1 file changed, 3 insertions(+), 15 deletions(-)
>>
>> Have you tried to fix it by dropping the "odd position" assumption? For
>> example, removing "head |= 1" and decrementing by 1 instead of 2 in the
>> loop?
>>
>>      do {
>>              if (qi->desc_status[head] == QI_IN_USE)
>>                      qi->desc_status[head] = QI_ABORT;
>>              head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>      } while (head != tail);
>>
>> Thanks,
>> baolu
> 
> Thank you for your reply.
> 
> There are a few points that need clarification:
> The descriptors between head and tail are requests that have not been 
> fetched and executed.
> 
> 
> Regarding the requests before the head:
> Method 1: Does the IOMMU update the head address register immediately 
> after fetching the descriptor?
> Method 2: Or does the IOMMU update the head register only after fetching 
> and executing the request?
> 
> The current Intel IOMMU VT-d specification does not describe this 
> behavior in detail.
> Does the IOMMU currently use Method 1?
> 
> Therefore, after an ITE timeout, it's necessary to resend the requests 
> before the head index

An obvious race that I can think of is something like this:

Thread A placed a dev-tlb-inv-desc in the invalidation queue. After
that, thread B placed an iotlb-inv-desc in the queue. Now the requests
in the queue look like this:

     dev-tlb-inv-desc for A
     iotlb-inv-desc for B

Then a device TLB invalidation timeout error happens and triggers the
ITE bit to be set in the fault register. Thread B sees this in its
qi_check_fault(), clears the ITE bit, and returns -EAGAIN. Then thread A
will loop infinitely waiting for DONE in its wait-desc.

The qi_submit_sync() logic has been there for years. Changing its
behavior without enough validation on real hardware will cause
unexpected issues. The better approach I would suggest is to fix the
outdated logic.

Thanks,
baolu
