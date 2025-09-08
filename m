Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7233188713;
	Mon,  8 Sep 2025 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322728; cv=none; b=IVslYtoIMTsNMpJxPT8t5G1rAB6AQLWN4eVRZJb0x31h8rvtE3J88z3srVLhhXq9UbdGHAlk+GDNauXj/87NDqMT9cILjXygkpgl8w4fcOe91iptLx1Zrcul4stquEzsNP8HyCYjLZfx3lQzQg05XxDjVTquE+GOs4IYfobh5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322728; c=relaxed/simple;
	bh=WPsIIr54AtFpNsHhvHwN8M76Ll6H9I9m6ujJcV8B+hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXUYJ60SakP+zI1x2Vz5AfWFaMokPU9JIIWi1PmE9kU7nB81TnlraBmWuOgp9uXdyPPz/WNbhGQBSMbhUg6diwGMetNpL9p244bKCjzDPy5HewBT0knAgy/lRs0QyB5iLMSG6Qmfm8CUsb+LdBMcdkjOEdH11mhNH24JMwi/+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B204A1692;
	Mon,  8 Sep 2025 02:11:56 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30D7B3F63F;
	Mon,  8 Sep 2025 02:12:02 -0700 (PDT)
Message-ID: <0a09268b-3112-43b9-b622-b847b3949bd7@arm.com>
Date: Mon, 8 Sep 2025 10:12:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
To: Jason Gunthorpe <jgg@ziepe.ca>, Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
 tglx@linutronix.de, robin.murphy@arm.com, akpm@linux-foundation.org,
 steven.price@arm.com, david@redhat.com, Fuad Tabba <tabba@google.com>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com> <20250905162258.GA483339@ziepe.ca>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250905162258.GA483339@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 05/09/2025 17:22, Jason Gunthorpe wrote:
> On Fri, Sep 05, 2025 at 02:13:34PM +0100, Catalin Marinas wrote:
>> Hi Aneesh,
>>
>> On Fri, Sep 05, 2025 at 11:24:41AM +0530, Aneesh Kumar K.V (Arm) wrote:
>>> When running with private memory guests, the guest kernel must allocate
>>> memory with specific constraints when sharing it with the hypervisor.
>>>
>>> These shared memory buffers are also accessed by the host kernel, which
>>> means they must be aligned to the host kernel's page size.
>>
>> So this is the case where the guest page size is smaller than the host
>> one. Just trying to understand what would go wrong if we don't do

Correct.

>> anything here. Let's say the guest uses 4K pages and the host a 64K
>> pages. Within a 64K range, only a 4K is shared/decrypted. If the host
>> does not explicitly access the other 60K around the shared 4K, can

There are two cases here:

a) Guest memfd as it exists today, with shared pages coming from a 
different pool
b) Guest memfd with mmap support, where shared pages are from the 
guest_memfd.

In either case, guest_memfd tracks the page attributes at PAGE_SIZE
level (64K in this case). Sub-page level tracking is going to make it
complicated. Even with that in place,

with (a), we cannot "punch holes" in the private vs shared pools, to
maintain the sharing, as they are again in PAGE_SIZE. May be we can
relax this for guest_memfd.

with (b) coming in, mapping the shared pages into VMM (e.g., for virtio)
will map the entire 64K page into the userspace (with private and shared
bits) and thus opens up the security loophole of VMM bringing down the
Host with "protected memory" for other operations.

We did bring this up in one of the earlier guest_memfd upstream calls,
and the recommendation was to fix this in the Guest, aligning the
operations to the Host page size [0].

e.g., pKVM guests simply fail the boot if the Guest page size is not
aligned to the Host.

>> anything still go wrong? Is the hardware ok with speculative loads from
>> non-shared ranges?

> 
> +1 I'm also confused by this description.
> 
> I thought the issue here was in the RMM. The GPT or S2 min granule
> could be > 4k and in this case an unaligned set_memory_decrypted()
> from the guest would have to fail inside the RMM as impossible to
> execute?


> 
> Though I'm a little unclear on when and why the S2 needs to be
> manipulated. Can't the S2 fully map both the protected and unprotected
> IPA space and rely on the GPT for protection?

As mentioned above, the problem lies with the "Host" unable to satisfy
an unaligned request. If we can make that work with the Host, RMM
doesn't need to worry about it.


> 
> I do remember having a discussion that set_memory_decrypted() has
> nothing to do with the VM's S1 granule size, and it is a mistake to
> have linked these together. The VM needs to understand what
> granularity the RMM will support set_memory_decrypted() for and follow
> that.

Granularity is determined by the Host (not RMM).

> 
> I don't recall there is also an issue on the hypervisor? I thought GPT
> faults on ARM were going to work well, ie we could cleanly segfault
> the VMM process if it touches any protected memory that may have been
> mapped into it, and speculation was safe?

The issue is with the VMM passing this around back to the Kernel and
causing a GPT in the Kernel.


Suzuki


[0] 
https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?pli=1&tab=t.0


> 
>>> @@ -213,16 +213,20 @@ static gfp_t gfp_flags_quirk;
>>>   static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>>>   					 unsigned int order)
>>>   {
>>> +	long new_order;
>>>   	struct page *page;
>>>   	int ret = 0;
>>>   
>>> -	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
>>> +	/* align things to hypervisor page size */
>>> +	new_order = get_order(ALIGN((PAGE_SIZE << order), arch_shared_mem_alignment()));
>>> +
>>> +	page = alloc_pages_node(node, gfp | gfp_flags_quirk, new_order);
>>>   
>>>   	if (!page)
>>>   		return NULL;
>>>   
>>>   	ret = set_memory_decrypted((unsigned long)page_address(page),
>>> -				   1 << order);
>>> +				   1 << new_order);
>>
>> At some point this could move to the DMA API.
> 
> I don't think we should be open coding these patterns.
> 
> Esepcially given the above, it makes no sense to 'alloc page' and then
> 'decrypt page' on ARM CCA. decryption is not really a OS page level
> operation. I suggest coming with some series to clean these up into a
> more sensible API.
> 
> Everything wanting decrypted memory should be going through some more
> general API that has some opportunity to use pools.
> 
> DMA API may be one choice, but I know we will need more options in
> RDMA land :|
> 
> Jason

