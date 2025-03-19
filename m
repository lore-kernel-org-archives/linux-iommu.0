Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F2A1D61A5
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400484; cv=none; b=dx8cGl9vXlm3S+PZ/4iB6Ff448nrp4TFqGjqtASqxlvwvxIXBUpBKrtJg8lG79uotxsnbYSwlWw/Fw9dBzfHzeZlj6RmxW9QVrAryRyqQPbnQxqro8sMF6CcDbbewLff4IQP1VweSFd26zo/zlv3Bqohqvwhg+rPip+xwH2/UkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400484; c=relaxed/simple;
	bh=CcRaP6OKnEccibIfLfY42CClpTOAVXc8/KIO94eiy14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpB67Uw34/Q6QcWnXwACcYHy4NpUWRW7e4kB9yC0SyTIKH2Nf0sSzzdrNGx1IH5AkPDaZ+4PSnzRaT2iNUV3C+QzHQj7vGiu+FTabtj0pKrE5EWOWLQ1aV4edhWC49wIifttutMNvNFoKmS/hkZHysAAWKE4eg/8aT2X6zaZWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E23D113E;
	Wed, 19 Mar 2025 09:08:08 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4063F694;
	Wed, 19 Mar 2025 09:07:58 -0700 (PDT)
Message-ID: <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>
Date: Wed, 19 Mar 2025 16:07:57 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System Sleep
 ops
To: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
 Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
References: <20250319004254.2547950-1-praan@google.com>
 <20250319115730.GC10600@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250319115730.GC10600@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2025 11:57 am, Jason Gunthorpe wrote:
> On Wed, Mar 19, 2025 at 12:42:49AM +0000, Pranjal Shrivastava wrote:
> 
>> 3. Invoking runtime_pm_get/put
>> Given that most of the configuration done by arm-smmu-v3 is stored in
>> memory, the initial idea is to focus on areas where the driver accesses
>> the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.
> 
> This seems weird, if the SMMU is suspended doesn't it also fail DMA
> transactions? Why would ops like flush even be called if the HW is
> disabled?

Because once the device has finished its operation, its driver is free 
to call rpm_put() before calling dma_unmap(), so by the time that gets 
as far as TLB maintenance, the SMMU may already be asleep as well if 
that device was the only thing keeping it awake.

For direct IOMMU API users, pagetable update may be even more 
asynchronous from device activity, e.g. a GPU buffer might only be 
unmapped once userspace closes the last file handle referencing it, long 
after the GPU itself has moved on to other things.

> flush is performance path stuff, so it doesn't seem great to be adding
> extra calls there.

That much is true - this really wants to be using 
pm_runtime_get_if_in_use() nearly everywhere such that at most it's just 
juggling refcounts. There's no point waking the SMMU up just to issue a 
CFGI or TLBI, if the act of doing so is inherently going to do a full 
arm_smmu_reset() and thus invalidate everything anyway.

>> Instead of wrapping every exposed op with an rpm_get/put, the idea is to
>> follow through till a logical common point (lowest common ancestor in
>> the call hierarchies) and wrap those with the rpm_get/put calls.
> 
> Should the iommu core be doing this instead of hidden in drivers? It
> seems like there might be better information there about when we
> expect the IOMMU to be powered up and working and when it is OK to
> have it shutdown?

On the contrary, I would say it's very much driver-level knowledge as to 
which operations need the hardware accessible or not, and trying to do 
it at the core level would inevitably end up very pessimistic and 
inefficient, or at best just horribly complex.

> And maybe in this direction we can do things like remove the
> translation before doing a suspend so that flush ops are not a
> problem.

Case in point: that would be a load of extra work to do, make 
suspend/resume even slower, and even then for no benefit, since 
map_pages/umnmap_pages can still be called on the unattached domain 
(especially a default DMA domain), wherein drivers may still end up 
trying to touch their hardware for various reasons in ways invisible to 
the core API. Easy example: consider a driver calling 
dma_alloc_coherent() to prepare a buffer *before* it wakes up its client 
device (which would then also wake up the SMMU via the device link), and 
deep within that call, arm_lpae_init_pte() ends up calling back into 
arm_smmu_tlb_inv_walk() because it's laying down a block mapping where 
an old empty table PTE happens to be...

Thanks,
Robin.
