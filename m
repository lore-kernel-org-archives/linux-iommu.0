Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95C3D9036
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956865; cv=none; b=G8e4qk1sCuwzGEbo7rsATXU6BpTyviosXnM7FAg9hSvVvPK6cI3xzRhgpNAW6buAIbBeyDNfRJY3S9SY4z95EzkqF9MmI1lfHTPDMu+P/kIAqdKBOm4tDX9I+2yx8vegcbjWfDQ4JWldL4NSfPxLw5neLV/kdQYEMSR9qzYH/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956865; c=relaxed/simple;
	bh=esJx51qRprTC2Gt8FXc5Gtsfu1LuPFI+bLll54Tc7cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pt+rTWoMJAhY/QOgl1j/SSoNtlW1JGdmNXCtCpCOf4ourDQiV6MBLAVKbO8F9561Sz+ePdw14dbCrNF+FP8alVAeLvWDpA+rFK+AGHMEDjoywVP6d/sIoAd7wcyB5HVtMJ30Q8GpBzzWEqRA9t/M3VOGa15CsDiD9kzR9CV4p/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=md8RoVD1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="md8RoVD1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B327495B;
	Tue, 31 Mar 2026 04:34:17 -0700 (PDT)
Received: from [10.57.17.66] (unknown [10.57.17.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D77703F641;
	Tue, 31 Mar 2026 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774956863; bh=esJx51qRprTC2Gt8FXc5Gtsfu1LuPFI+bLll54Tc7cM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=md8RoVD1idc/o4By5wf/7v3Pxkn0TXswa5YtkPcXu7z6EnPQaJOAU94wJ9PeqhUfx
	 mjC6/0fFma74WyA6yOTnHNW7/yVy/nFYRGT5o07XaQqSq+DlhfiyfEr3iQQjz+53vu
	 1vM3uJSDtVfBfEu4hRI+NVoHoV3KR8MXTao2qZb4=
Message-ID: <acfded81-f04e-4be0-af98-6ed43b8409ec@arm.com>
Date: Tue, 31 Mar 2026 12:34:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
Content-Language: en-GB
To: Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
 maz@kernel.org, catalin.marinas@arm.com, jiri@resnulli.us,
 aneesh.kumar@kernel.org
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-2-smostafa@google.com>
 <20260330150654.GA809900@ziepe.ca> <acrgYotBExJhEJkK@google.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <acrgYotBExJhEJkK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/03/2026 21:43, Mostafa Saleh wrote:
> On Mon, Mar 30, 2026 at 12:06:54PM -0300, Jason Gunthorpe wrote:
>> On Mon, Mar 30, 2026 at 02:50:39PM +0000, Mostafa Saleh wrote:
>>> In case a device have a restricted DMA pool, it will be decrypted
>>> by default.
>>>
>>> However, in the path of dma_direct_alloc() memory can be allocated
>>> from this pool using, __dma_direct_alloc_pages() =>
>>> dma_direct_alloc_swiotlb()
>>>
>>> After that from the same function, it will attempt to decrypt it
>>> using dma_set_decrypted() if force_dma_unencrypted().
>>>
>>> Which results in the memory being decrypted twice.
>>>
>>> It's not clear how the does realm world/hypervisors deal with that,
>>> for example:
>>> - CCA: Clear a bit in the page table and call realm IPA_STATE_SET.
>>> - TDX: Issue a hypercall.
>>> - pKVM: Which doesn't implement force_dma_unencrypted() at the moment,
>>>    uses a share hypercall.
>>>
>>> Change that to only encrypt/decrypt memory that are not allocated
>>> from the restricted dma pools.
>>>
>>> Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
>>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>>> ---
>>>   kernel/dma/direct.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 8f43a930716d..27d804f0473f 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -79,7 +79,7 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>>>   
>>>   static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
>>>   {
>>> -	if (!force_dma_unencrypted(dev))
>>> +	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
>>>   		return 0;
>>
>> This seems really obtuse, I would expect the decryption state of the
>> memory to be known by the caller. If dma_direct_alloc_swiotlb() can
>> return decrypted or encrypted memory it needs to return a flag saying
>> that. It shouldn't be deduced by checking dev flags in random places
>> like this.
> 
> At the moment restricted dma is always decrypted, also it’s per device
> so we don’t have to check this per allocation.

Doesn't the initial state depend on platform ? For CCA, the Realm must
decide how it wants to use a given region, which for the restricted DMA 
pool, it can be made decrypted. Could the VM OS decide to make this
decrypted at boot ?

Suzuki


> I can change the signature for __dma_direct_alloc_pages() to make it
> return an extra flag but that feels more complicated as it changes
> dma_direct_alloc_swiotlb() , swiotlb_alloc() with its callers.
> 
> I can investigate this approach further.
> 
> Thanks,
> Mostafa
> 
>>
>> Double decryption is certainly a bug, I do not expect that to work.
>>
>> Jason

