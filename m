Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C420722A7E4;
	Mon,  8 Sep 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339247; cv=none; b=pNyJwt599u75HLiqea1SqW3mHh1ryvtSXKNzsvVKN6tYuKa4WMLzUg/jt72qUW4Z/EvZBFLL31dSq+Bnbl3WgRbiDet9DIFyBy1jZbUldFSHMc4+anesCJNAWwFTm9b7RlgsSMnc3QrStGv+Jeie7uYZGmhiVzr2PHOuVlPtXCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339247; c=relaxed/simple;
	bh=at18kgT/BeIp9qGsKxERWyzMfX1nvcNt1wBgQmAuGr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ot5QHKj6OpkuhWl1oLSno/u5okjabCT2v9aqYYtv/eKujrfmqXzxtUbbv/lEjg6MpWUyGsjWS19U+IEGYHgVHLph4M8rjBxrQJNDqu7HWOP7aOpbvP/o2nj2QXwttqtetZTtGNQ5aXpJvB3h1RkKL062RCHCMaro3YJOIt9HDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA8F61692;
	Mon,  8 Sep 2025 06:47:16 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 259FB3F63F;
	Mon,  8 Sep 2025 06:47:23 -0700 (PDT)
Message-ID: <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>
Date: Mon, 8 Sep 2025 14:47:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
To: Catalin Marinas <catalin.marinas@arm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
 tglx@linutronix.de, robin.murphy@arm.com, akpm@linux-foundation.org,
 jgg@ziepe.ca, steven.price@arm.com
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com> <yq5aikht1e0z.fsf@kernel.org>
 <aL7AoPKKKAR8285O@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <aL7AoPKKKAR8285O@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2025 12:40, Catalin Marinas wrote:
> On Mon, Sep 08, 2025 at 03:07:00PM +0530, Aneesh Kumar K.V wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>>> On Fri, Sep 05, 2025 at 11:24:41AM +0530, Aneesh Kumar K.V (Arm) wrote:
>>>> When running with private memory guests, the guest kernel must allocate
>>>> memory with specific constraints when sharing it with the hypervisor.
>>>>
>>>> These shared memory buffers are also accessed by the host kernel, which
>>>> means they must be aligned to the host kernel's page size.
>>>
>>> So this is the case where the guest page size is smaller than the host
>>> one. Just trying to understand what would go wrong if we don't do
>>> anything here. Let's say the guest uses 4K pages and the host a 64K
>>> pages. Within a 64K range, only a 4K is shared/decrypted. If the host
>>> does not explicitly access the other 60K around the shared 4K, can
>>> anything still go wrong? Is the hardware ok with speculative loads from
>>> non-shared ranges?
>>
>> With features like guest_memfd, the goal is to explicitly prevent the
>> host from mapping private memory, rather than relying on the host to
>> avoid accessing those regions.
> 
> Yes, if all the memory is private. At some point the guest will start
> sharing memory with the host. In theory, the host could map more than it
> was given access to as long as it doesn't touch the area around the
> shared range. Not ideal and it may not match the current guest_memfd API

The kernel may be taught not to touch the area, but it is tricky when
the shared page gets mapped into the usespace and what it does with it.

> but I'd like to understand all the options we have.
> 
>> As per Arm ARM:
>> RVJLXG: Accesses are checked against the GPC configuration for the
>> physical granule being accessed, regardless of the stage 1 and stage 2
>> translation configuration.
> 
> OK, so this rule doesn't say anything about the granule size at stage 1
> or stage 2. The check is purely done based on the PGS field
> configuration. The need for the host granule size to match PGS is just a
> software construct.
> 
>> For example, if GPCCR_EL3.PGS is configured to a smaller granule size
>> than the configured stage 1 and stage 2 translation granule size,
>> accesses are checked at the GPCCR_EL3.PGS granule size.
> 
> I assume GPCCR_EL3.PGS is pre-configured on the system as 4K and part of
> the RMM spec.

True. The GPC Page Size is going to be 4K. At present the RMM S2 page
size is fixed to 4K. Please note that the future RMM versions may allow
the Host to change the S2 for Realm (Globally) to something other than
4K. (e.g., a 64K host could change it to 64K S2), which allows the host
to manage the Realm S2 better (and efficient).

Irrespective of that, the patch is trying to deal with Host pagesize
(which affects sharing) vs the Realm alignment for sharing pages.

Suzuki



Suzuki



