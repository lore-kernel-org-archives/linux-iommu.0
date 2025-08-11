Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A3202969
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921842; cv=none; b=Mb4mexZI9TpYw1k4Mz9vOZh/MtEPvbivJMbxUPGqcAeX/iFuGGGnPs2DjMpYt0A0Aux+KA7nUlp3DLymQPxfOJTczpauhXbF2+5tEW/f8gH2ItURmOVKAu0FjIJqubnJfYhrreRtAK0z6dNnPmhDbKH2TIXmEnHZ0pKNJu7UzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921842; c=relaxed/simple;
	bh=S1c3LYfs/+fpITKc7jTlB1Bw/VBNJEw9lp5ELrWtRSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b79fsRQl0VAt7SO8PtchkDgc/x5zz2T6JZhdjxDXq8OH1nBnBEZyM2uHjAvs038xYnRHxS5cgWiX2fhcRaUEecjBkyqcxQRomdtGIQwdDaS+Gcy1i1DcGMdFAuAwn51PhpHrXLGlGEiujooMjtpVGQPmaCw1Q9ujz5nu0dnD45E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79D1D1A32;
	Mon, 11 Aug 2025 07:17:12 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF84F3F738;
	Mon, 11 Aug 2025 07:17:18 -0700 (PDT)
Message-ID: <a9c31290-3e21-4fbd-bd72-d445701d15a9@arm.com>
Date: Mon, 11 Aug 2025 15:17:17 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/2] arm64: Add encrypt/decrypt support for vmalloc
 regions
To: Shanker Donthineni <sdonthineni@nvidia.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Steven Price <steven.price@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Vikram Sethi <vsethi@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>,
 Dev Jain <dev.jain@arm.com>, David Rientjes <rientjes@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250811005036.714274-1-sdonthineni@nvidia.com>
 <20250811005036.714274-3-sdonthineni@nvidia.com>
 <d8048adc-b19a-4d10-83e8-44b9a85c4d48@arm.com>
 <df91ac56-9240-4ee2-b154-a911c4053dc5@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <df91ac56-9240-4ee2-b154-a911c4053dc5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/08/2025 2:05 pm, Shanker Donthineni wrote:
> Hi Robin,
> 
> On 8/11/25 07:31, Robin Murphy wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2025-08-11 1:50 am, Shanker Donthineni wrote:
>>> On ARM64 systems with CCA (Confidential Compute Architecture) enabled,
>>> the kernel may need to change the encryption attributes of memory
>>> regions. The existing implementation of set_memory_encrypted() and
>>> set_memory_decrypted() assumes that the input address is part of the
>>> linear mapping region '__is_lm_address()', and fails with -EINVAL
>>> otherwise.
>>>
>>> This breaks use cases where the memory region resides in the vmalloc
>>> area, which is mapped in non-linear mapping region.
>>>
>>> This patch introduces a new helper, realm_set_memory(), which detects
>>> whether the given address is from a non-linear mapping. If so, it uses
>>> vmalloc_to_page() to resolve each page’s physical address and applies
>>> attribute changes one page at a time. For the linear address regions,
>>> it maintains the existing fast-path.
>>>
>>> This change ensures that encrypted/decrypted memory attribute updates
>>> correctly for all memory regions, including those allocated via vmap(),
>>> module allocations, or other vmalloc-backed paths.
>>>
>>> Call stack of Realm crash, QEMU hypervisor + NVME device (emulated):
>>>   ...
>>>   Freeing unused kernel memory: 6336K
>>>   Run /sbin/init as init process
>>>   Internal error: synchronous external abort: 0000000096000250 [#1]  SMP
>>>   Modules linked in:
>>>   CPU: 0 UID: 0 PID: 64 Comm: lsblk Not tainted 6.15.5 #2 PREEMPT(undef)
>>>   Hardware name: linux,dummy-virt (DT)
>>>   pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>>>   pc : __pi_memset_generic+0x16c/0x188
>>>   lr : dma_alloc_from_pool+0xd0/0x1b8
>>>   sp : ffff80008335b350
>>>   x29: ffff80008335b350 x28: ffff800083162000 x27: ffff80008335b3c0
>>>   x26: ffff80008144f000 x25: ffff8000801a27e8 x24: ffff800081e14000
>>>   x23: ffffc1ffc0000000 x22: 0000000000001000 x21: ffff800081458310
>>>   x20: 0000000042a40000 x19: ffff00000232fcc0 x18: 0000000000200000
>>>   x17: 00000000000120c0 x16: ffff0000795520c0 x15: 0000000000000000
>>>   x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>>   x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>>>   x8 : ffff800083162000 x7 : 0000000000000000 x6 : 000000000000003f
>>>   x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
>>>   x2 : 0000000000000fc0 x1 : 0000000000000000 x0 : ffff800083162000
>>>   Call trace:
>>>     __pi_memset_generic+0x16c/0x188 (P)
>>>     dma_direct_alloc_from_pool+0xc4/0x230
>>
>> But isn't that exactly the case that patch #1 is supposed to have fixed?
>>  From a quick scan of set_memory_decrypted() callers I don't see
>> anything obvious jumping out - can you clarify who you think needs this
>> for reasons other than papering over bugs in the DMA layer?
>>
> 
> Patch #1 fixes the passing of the correct mapped address (via 
> vmalloc/vmap),
> prevent this specific crash. However, Realm boot still fails because
> __set_memory_enc_dec() returns -EINVAL when the requested address is not
> part of the linear mapping. Both patches are required to fully resolve the
> issue. Patch #2 is to support shared (decrypted) pages in vmalloced 
> regions.

Right, sorry for perhaps being unclear - the half-formed idea I was 
heading towards is that if patch #1 doesn't actually make DMA pools work 
then I'm not necessarily sure it's the right fix as-is.

In fact, looking at the code again, I think it probably shouldn't be 
relying on set_memory at all in the remap case, but instead using 
pgprot_decrypted(), same as the regular non-pool path in dma_direct_alloc().

Thanks,
Robin.
