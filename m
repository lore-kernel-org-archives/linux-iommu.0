Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7ED1DE884
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578517; cv=none; b=mDRBOpqXvLwkj2S4ZJUd7160ZtYbuRl6wFw1dLBDigtNHMnqfRZLqi9+q7GGyjAT1q/fQPniLfVnFWwjVN0D0EiztnGmxmmPJ/oC8hCZzrD9/SWf18aQLdPJ6PYdMBtRMQtj3B5R25o9Xlb715vd5Tmo9LFRgEd5p+H1A2Jcad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578517; c=relaxed/simple;
	bh=6a7oTXoGa1Vv/kmCJiy3OTPAruimc2FfYwezsCVHiw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMivyzBHrn2YBD7znoOcabCzOIc0azKg4Ty5MU/pgc4onJRVf5tnE0X8ciGzaNyqBJOR9nsbXS6BKyumLx6Nd16rAIsKJGpY2xN8ecnFY2sbQZPB0LIyATcJKey6uTfuStVxIIjEG4GSKBMA7VTZZPZFSKrO70+RVeyoGFXeu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55DD6106F;
	Fri, 21 Mar 2025 10:35:21 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 996143F63F;
	Fri, 21 Mar 2025 10:35:12 -0700 (PDT)
Message-ID: <63806834-a0a1-41e0-9cca-60087b460f78@arm.com>
Date: Fri, 21 Mar 2025 17:35:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System Sleep
 ops
To: Pranjal Shrivastava <praan@google.com>,
 Mostafa Saleh <smostafa@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
 Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
References: <20250319004254.2547950-1-praan@google.com>
 <20250319115730.GC10600@ziepe.ca>
 <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com> <Z9yV8KsdXnZg1Ppo@google.com>
 <Z911UT59UnDzRymF@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z911UT59UnDzRymF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/03/2025 2:18 pm, Pranjal Shrivastava wrote:
> On Thu, Mar 20, 2025 at 10:25:52PM +0000, Mostafa Saleh wrote:
>> On Wed, Mar 19, 2025 at 04:07:57PM +0000, Robin Murphy wrote:
>>> On 19/03/2025 11:57 am, Jason Gunthorpe wrote:
>>>> On Wed, Mar 19, 2025 at 12:42:49AM +0000, Pranjal Shrivastava wrote:
>>>>
>>>>> 3. Invoking runtime_pm_get/put
>>>>> Given that most of the configuration done by arm-smmu-v3 is stored in
>>>>> memory, the initial idea is to focus on areas where the driver accesses
>>>>> the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.
>>>>
>>>> This seems weird, if the SMMU is suspended doesn't it also fail DMA
>>>> transactions? Why would ops like flush even be called if the HW is
>>>> disabled?
>>>
>>> Because once the device has finished its operation, its driver is free to
>>> call rpm_put() before calling dma_unmap(), so by the time that gets as far
>>> as TLB maintenance, the SMMU may already be asleep as well if that device
>>> was the only thing keeping it awake.
>>>
>>> For direct IOMMU API users, pagetable update may be even more asynchronous
>>> from device activity, e.g. a GPU buffer might only be unmapped once
>>> userspace closes the last file handle referencing it, long after the GPU
>>> itself has moved on to other things.
>>>
>>>> flush is performance path stuff, so it doesn't seem great to be adding
>>>> extra calls there.
>>>
>>> That much is true - this really wants to be using pm_runtime_get_if_in_use()
>>> nearly everywhere such that at most it's just juggling refcounts. There's no
>>> point waking the SMMU up just to issue a CFGI or TLBI, if the act of doing
>>> so is inherently going to do a full arm_smmu_reset() and thus invalidate
>>> everything anyway.
>>
>> AFAICT, there is no guarantees that caches are clean on system resume,
>> but as we do invalidate everything that should be fine, but I am not sure

That was the point - we're definitely going to do a full software 
invalidation *because* we can't make any assumptions about the hardware 
state, i.e. it may come back full of valid-looking nonsense.

> I mean we do set GBPA.Abort = 1 right before suspending, I'd want to
> assume that doing so would ensure that TLB hits don't occur anymore. Let
> me dig into the spec to see if I can find something regarding TLB
> behavior when GBPA.Abort = 1

GBPA doesn't matter here, it's about the CR0.SMMUEN=0 behaviour (see 
6.3.9.6). That says "Incoming transactions [...] do not undergo 
translation," so although TLB entries are allowed to remain present, 
they must not be *used* - i.e. SMMUEN is not permitted to be cached in a 
TLB.

>> how that works with distributed SMMUs where the TBU can still be powered
>> with some TLBs that can be invalid?
>>
> 
> Hmm.. do you mean some situation like:
> 
>   |-----------------------|    |-------------------|
>   | |-------|   |-------| |    |-------------------|
>   | | Dev X |   | Dev Y | |    |                   |
>   | | (TBU) |   |_______| |    |       SMMUv3      |
>   | |-------|             |    |  (TCU -> TBU_X)   |
>   |     Power_Domain A    |    |  Power_Domain B   |
>   |-----------------------|    |-------------------|
> 
> Now if Dev Y isn't an SMMU client and Dev X drops the ref_count,
> Power_Domain A would still remain ON whereas SMMUv3 might assume all
> it's clients are down and try to suspend (power off Power_Domain B)
> while the TLBs withing TBU_X are still powered up?
> 
> To avoid such a case maybe we should invalidate everything during
> suspend? I still believe that when CR0.SMMUEN=0, it should broadcast
> something to all it's TBUs asking them to invalidate all TLBs otherwise
> this is a miss in the arch (unlikely for Arm) as TLB hits should never
> occur if the SMMU is disabled. I guess I need to go through the SMMUv3
> spec (or maybe the MMU-700 TRM) for confirming this..

I don't think this is allowed to be an issue in practice since TBUs are 
not architecturally visible. Certainly in terms of Arm's 
implementations, for a TBU to be powered off or externally clock gated 
it would have to do a full DTI disconnect (otherwise it would hang 
CMD_SYNC), and DTI requires that it must subsequently come back clean:

"The TBU must invalidate its caches before entering CONNECTED state."

Thanks,
Robin.
