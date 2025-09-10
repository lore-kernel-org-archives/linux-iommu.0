Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7EB315790;
	Wed, 10 Sep 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498907; cv=none; b=f/zVJ1c6yFYHKg2hrwDNECAiFaxn5/a6qld5TGSgGHuF260YhJVGYbJyWJHmrrovCUwOBPsd359x1y8N3sFNlS+Qq8UEQuS9MIuNgQuRsV39JCR6gwYf04Vy2ufaKWyyeqZGn79DF44fhcKCFbXrZxQVRpKs+GUiwSyhaDe2YIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498907; c=relaxed/simple;
	bh=MnqbWyDA2EOd2xFAHwBhdGG8jY7mWY+9asdBzyGANb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1Ywt9a7jJsdssRyTednzNOIRlWc7BQykJJEu5SkxOumb3LMEV4pDD7mU6DYyAIuYNUs2LK9b6M1TXucMtLz/bK3uoX5Ke2ftSCM+MXTwTaWP7iZlbYNuifyq2Kc4DlfJH3ktpICMmphQhYn47FSRml6PGeT002qUBa4mW8Y73E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFAC71756;
	Wed, 10 Sep 2025 03:08:16 -0700 (PDT)
Received: from [10.1.25.55] (e122027.cambridge.arm.com [10.1.25.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F11C3F66E;
	Wed, 10 Sep 2025 03:08:21 -0700 (PDT)
Message-ID: <ea4b657e-13fa-485e-9d3c-5b395ad3d8e2@arm.com>
Date: Wed, 10 Sep 2025 11:08:19 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
 tglx@linutronix.de, robin.murphy@arm.com, akpm@linux-foundation.org
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com> <yq5aikht1e0z.fsf@kernel.org>
 <aL7AoPKKKAR8285O@arm.com> <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>
 <20250908145845.GA699673@ziepe.ca>
 <d8687b08-6bb4-4645-8172-72936a51b0d8@arm.com> <aL8RdvuDbtbUDk2D@arm.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <aL8RdvuDbtbUDk2D@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2025 18:25, Catalin Marinas wrote:
> On Mon, Sep 08, 2025 at 04:39:13PM +0100, Steven Price wrote:
>> On 08/09/2025 15:58, Jason Gunthorpe wrote:
>>> If ARM has proper faulting then you don't have an issue mapping 64K
>>> into a userspace and just segfaulting the VMM if it does something
>>> wrong.
>>
>> ...the VMM can cause problems. If the VMM touches the memory itself then
>> things are simple - we can detect that the fault was from user space and
>> trigger a SIGBUS to kill of the VMM.
> 
> Similarly for uaccess.
> 
>> But the VMM can also attempt to pass the address into the kernel and
>> cause the kernel to do a get_user_pages() call (and this is something we
>> want to support for shared memory). The problem is if the kernel then
>> touches the parts of the page which are protected we get a fault with no
>> (easy) way to relate back to the VMM.
> 
> I assume the host has a mechanism to check that the memory has been
> marked as shared by the guest and the guest cannot claim it back as
> private while the host is accessing it (I should dig out the CCA spec).
> 
>> guest_memfd provided a nice way around this - a dedicated allocator
>> which doesn't allow mmap(). This meant we don't need to worry about user
>> space handing protected memory into the kernel. It's now getting
>> extended to support mmap() but only when shared, and there was a lot of
>> discussion about how to ensure that there are no mmap regions when
>> converting memory back to private.
> 
> That's indeed problematic and we don't have a simple way to check that
> a user VMM address won't fault when accessed via the linear map. The
> vma checks we get with mmap are (host) page size based.
> 
> Can we instead only allow mismatched (or smaller) granule sizes in the
> guest if the VMM doesn't use the mmap() interface? It's not like
> trapping TCR_EL1 but simply rejecting such unaligned memory slots since
> the host will need to check that the memory has indeed been shared. KVM
> can advertise higher granules only, though the guest can ignore them.
> 

Yes, mismatched granules sizes could be supported if we disallowed
mmap(). This is assuming the RMM supports the required size - which is
currently true, but the intention is to optimise the S2 in the future by
matching the host page size.

But I'm not sure how useful that would be. The VMMs of today don't
expect to have to perform read()/write() calls to access the guest's
memory, so any user space emulation would need to also be updated to
deal with this restriction.

But that seems like a lot of effort to support something that doesn't
seem to have a use case. Whereas there's an obvious use case for the
guest and VMM sharing one (or often more) pages of (mapped) memory. The
part that CCA makes this tricky is that we need to pick the VMM's page
size rather than the guest's.

Steve

