Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2992621ABAF
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323664; cv=none; b=WZ9zgkPt3uDlIVGg/MsRAYxQ2kw6J3+IMoHVYN2vqAKQ7AUdbYPW/QoY9YjWF4RiIVfN/37CaKxNOurOrAvsvr3s1b1yiqziSoq0VOdPnGxk+uSQSWDN5jYrGyYvCFxw0wuzznJ6RwJ7E7pzntGbPX636pwKGw3an6AReDVIRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323664; c=relaxed/simple;
	bh=goQJz0UJh/6Sh171K+KpkjRry2TvwWwiPIRsA3hjc+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEOjU9P/7ArvuusnE3lWhD9qeYUkheIBfoKFnSn3UeTO4wEO63eBy/pYIi0Bya3ya5EYXRzM5hPyg66wmen2vmFXMRJq8aLVrfkA+t2CpvndjQgQYxqwydAkPnBs6pf/LnL1kccB3ZYAKzbqDRou1dtN6Fo4DCsl70Tm4gBT3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB2D14BF;
	Thu, 15 May 2025 08:40:50 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 743EC3F63F;
	Thu, 15 May 2025 08:41:01 -0700 (PDT)
Message-ID: <1f5f010a-c11e-452a-aff0-8829d1a3239a@arm.com>
Date: Thu, 15 May 2025 16:40:59 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/io-pgtable-arm: Support contiguous bit in
 translation tables
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Mostafa Saleh <smostafa@google.com>,
 Pranjal Shrivastava <praan@google.com>
References: <20250430231924.1481493-1-danielmentz@google.com>
 <20250506154014.GM2260621@ziepe.ca> <20250515143600.GB12165@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250515143600.GB12165@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/05/2025 3:36 pm, Will Deacon wrote:
> [+Robin]
> 
> On Tue, May 06, 2025 at 12:40:14PM -0300, Jason Gunthorpe wrote:
>> On Wed, Apr 30, 2025 at 11:19:24PM +0000, Daniel Mentz wrote:
>>> The contiguous bit in translation table entries can be used as a hint to
>>> SMMU that a group of adjacent translation table entries have consistent
>>> attributes and point to a contiguous and properly aligned output address
>>> range. This enables SMMU to predict the properties of the remaining
>>> translation table entries in the same group without accessing them. It
>>> also allows an SMMU implementation to make more efficient use of its TLB
>>> by using a single TLB entry to cover all translation table entries in
>>> the same group.
>>>
>>> In the case of 4KB granule size, there are 16 translation table entries
>>> in one group.
>>>
>>> This change sets the contiguous bit for such groups of entries that are
>>> completely covered by a single call to map_pages. As it stands, the code
>>> wouldn't set the contiguous bit if a group of adjacent descriptors is
>>> completed by separate calls to map_pages.
>>
>> Nor should it
>>
>> This seems like a pretty hacky implementation, it doesn't set the
>> pgsize bitmap to indicate support and it doesn't have a safety check
>> on unmap to protect against partial unmap of a huge page.
>>
>> Wouldn't it be better to use the pgsize bit map and rely on the core
>> code to tell a contig page size is being used and then it can
>> trivially set the PTE bit without having to do all this extra work?
> 
> That sounds like it would be quite a bit cleaner and I think it aligns
> with the "Large page" support in io-pgtable-arm-v7s.c which is doing
> something extremely similar.

Indeed, much like we advertise contiguous sizes for hugetlb on the CPU, 
having them in the pgsize_bitmap gives a clue to IOMMU API users that 
there is some potential benefit in trying to align to these sizes where 
appropriate (e.g. __iommu_dma_alloc_pages()).

Secondly, there also needs to be a straightforward way for drivers to 
opt out of (or perhaps explicitly in to) this - IIRC there are some SMMU 
errata which have so far not mattered due to Linux not using the 
contiguous bit, for which the least painful workaround is probably for 
affected hardware to just continue not using the contiguous bit.

Thanks,
Robin.
