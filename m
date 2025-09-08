Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286DC30E82C;
	Mon,  8 Sep 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345961; cv=none; b=tZZ4x9wzCnMB0TTw71mHvk4DQr5A8oCi9/RvoJ+BWBVuzS6bS1Y+913OyEI9V+FxmCI5Nw8+2LZZKJ+jLUqdjKlG+mseUMApzbkTPOgXKY4SMpNJ0aVoiEweB5+4naHCT00QqpVxEPYjGrDxcUJuPPZRgb3TbKv5HyAGyUnstBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345961; c=relaxed/simple;
	bh=bvWnm6tCvu/P7UfI+nK4JBO8Ce1IIlTtasDqStaO1SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8wV0bPJtfyogi+Q8eI9vutIag0fx+d00m8EHCwQkZvGgAH1XYa8VFi9g0q/uD0QtNAutshdlKzyq8HLjbG5S83K1gPGjPljUWFeV+WYr17Q5iBINHinEMBVu6fma+MY50GHMrfR5qe/l/Zd+B7ks0ifVgjkwIBtO1q+VJ/a7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4DA21692;
	Mon,  8 Sep 2025 08:39:09 -0700 (PDT)
Received: from [10.57.3.191] (unknown [10.57.3.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BEEF3F63F;
	Mon,  8 Sep 2025 08:39:15 -0700 (PDT)
Message-ID: <d8687b08-6bb4-4645-8172-72936a51b0d8@arm.com>
Date: Mon, 8 Sep 2025 16:39:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
To: Jason Gunthorpe <jgg@ziepe.ca>, Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev, will@kernel.org,
 maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
 akpm@linux-foundation.org
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com> <yq5aikht1e0z.fsf@kernel.org>
 <aL7AoPKKKAR8285O@arm.com> <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>
 <20250908145845.GA699673@ziepe.ca>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250908145845.GA699673@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2025 15:58, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 02:47:21PM +0100, Suzuki K Poulose wrote:
>> On 08/09/2025 12:40, Catalin Marinas wrote:
>>> On Mon, Sep 08, 2025 at 03:07:00PM +0530, Aneesh Kumar K.V wrote:
>>>> Catalin Marinas <catalin.marinas@arm.com> writes:
>>>>> On Fri, Sep 05, 2025 at 11:24:41AM +0530, Aneesh Kumar K.V (Arm) wrote:
>>>>>> When running with private memory guests, the guest kernel must allocate
>>>>>> memory with specific constraints when sharing it with the hypervisor.
>>>>>>
>>>>>> These shared memory buffers are also accessed by the host kernel, which
>>>>>> means they must be aligned to the host kernel's page size.
>>>>>
>>>>> So this is the case where the guest page size is smaller than the host
>>>>> one. Just trying to understand what would go wrong if we don't do
>>>>> anything here. Let's say the guest uses 4K pages and the host a 64K
>>>>> pages. Within a 64K range, only a 4K is shared/decrypted. If the host
>>>>> does not explicitly access the other 60K around the shared 4K, can
>>>>> anything still go wrong? Is the hardware ok with speculative loads from
>>>>> non-shared ranges?
>>>>
>>>> With features like guest_memfd, the goal is to explicitly prevent the
>>>> host from mapping private memory, rather than relying on the host to
>>>> avoid accessing those regions.
>>>
>>> Yes, if all the memory is private. At some point the guest will start
>>> sharing memory with the host. In theory, the host could map more than it
>>> was given access to as long as it doesn't touch the area around the
>>> shared range. Not ideal and it may not match the current guest_memfd API
>>
>> The kernel may be taught not to touch the area, but it is tricky when
>> the shared page gets mapped into the usespace and what it does with it.
> 
> But what happes?
> 
> The entire reason we have this nasty hyper-restrictive memfd private
> memory is beacuse Intel takes a machine check if anything does it
> wrong, and that is fatal and can't be handled.
> 
> Is ARM like that? I thought ARM had good faults on GPT violation that
> could be handled in the same way as a normal page fault?

Arm does indeed trigger a 'good fault' in these situations, but...

> If ARM has proper faulting then you don't have an issue mapping 64K
> into a userspace and just segfaulting the VMM if it does something
> wrong.

...the VMM can cause problems. If the VMM touches the memory itself then
things are simple - we can detect that the fault was from user space and
trigger a SIGBUS to kill of the VMM.

But the VMM can also attempt to pass the address into the kernel and
cause the kernel to do a get_user_pages() call (and this is something we
want to support for shared memory). The problem is if the kernel then
touches the parts of the page which are protected we get a fault with no
(easy) way to relate back to the VMM.

guest_memfd provided a nice way around this - a dedicated allocator
which doesn't allow mmap(). This meant we don't need to worry about user
space handing protected memory into the kernel. It's now getting
extended to support mmap() but only when shared, and there was a lot of
discussion about how to ensure that there are no mmap regions when
converting memory back to private.

> If not, then sure you need all this unmapping stuff like Intel does :\

We don't strictly need it, but given the complexity of handling a GPT
violation caused by the kernel, and since the infrastructure is needed
for Intel, it's made sense to largely follow the same path.

>> True. The GPC Page Size is going to be 4K. At present the RMM S2 page
>> size is fixed to 4K.
> 
> A 4k S2 is a pointless thing to do if the VMM is only going to approve
> 64k shared/private transitions :(

Indeed. The intention is that longer term the RMM would use the same S2
page size as the host's page size. But we'd like to support
(confidential) guests running with 4k page size under a 64k host/S2.

Short-term the RMM can use a smaller page size with everything still
working, but that's obviously not as efficient.

Steve

