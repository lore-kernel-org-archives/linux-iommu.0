Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B60D468036
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877201; cv=none; b=Ykgp+/somEmcNyxOWgbBPqbGb1luN6/zkNfgR++I8sWdzKqMHyED7wuGEfJX64rYKi2Wao/dQtXezVgykERW39UtrE/qbfRDa9LjXf0OcnqHW8h0bh5OozYxLrbK/JORLOqY3G5Dd7d2O2MAVyTVPVlRdIUzuLWyIEwICqG0YOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877201; c=relaxed/simple;
	bh=/fdTvZqnSGCixCqn294d7b+lvtXZKPYD5uzlkzXDBnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj3d7GksrZHF7YMeSiL4bTVA5Cwlc38zIwr6XKXbOz3h04wAXtZARuF3nsKpIg+Fs3bF48THuRnXZ2jcGAdO7dz7w2l12hNXUBkDc5/sIgsivcWeiPQFtXrR064hUjyNcWupSkGvmSjCG7UOfMuxgw3NM6vXmGJ7t6kVa69Pfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFDF6497;
	Thu,  8 Jan 2026 04:59:51 -0800 (PST)
Received: from [10.57.47.193] (unknown [10.57.47.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C9B93F6A8;
	Thu,  8 Jan 2026 04:59:57 -0800 (PST)
Message-ID: <1ada44db-63a9-43ac-81da-0bdd4e7b7363@arm.com>
Date: Thu, 8 Jan 2026 12:59:55 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-direct: Skip cache prep for HighMem coherent
 allocations
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20260102155118.2551804-1-aneesh.kumar@kernel.org>
 <CGME20260108105031eucas1p2a3e8d0308ae6a5d43b5250ca8b14ecb9@eucas1p2.samsung.com>
 <9cbe49ae-6612-491d-8ac6-6a99a08d73e2@arm.com>
 <9f28b833-5813-4e5d-b705-eed9a2a31863@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <9f28b833-5813-4e5d-b705-eed9a2a31863@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-08 12:41 pm, Marek Szyprowski wrote:
> On 08.01.2026 11:50, Robin Murphy wrote:
>> On 2026-01-02 3:51 pm, Aneesh Kumar K.V (Arm) wrote:
>>> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
>>> cache lines from the kernel linear alias before creating a coherent
>>> remapping.
>>>
>>> HighMem pages have no kernel alias mapping, so there are no alias cache
>>> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>>
>> This is assuming that caches are always cleaned when unmapping
>> highmem, and no still-mapped highmem pages are dirty - how is that
>> guaranteed? The fact that they're not in the linear map doesn't mean
>> they don't necessarily have kernel aliases in either vmalloc
>> pagetables or caches.
> 
> 
> Right, so it is better to keep this unconditional
> arch_dma_prep_coherent() call. I will drop it from dma-mapping-fixes then.

Yeah, I think the confusing thing here is that there are architectures 
with CONFIG_HIGHMEM that don't actually check for and handle it in their 
arch_dma_prep_coherent() as they seemingly should, however I'm not sure 
off-hand whether they also support/use highmem CMA in the manner that 
could end up being an issue in practice (the lack of any reports of 
crashes or DMA corruption over the last however many years suggests not...)

Thanks,
Robin.
