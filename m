Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BAC3FA5F0
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203186; cv=none; b=lKSakWTWRY6M2a18cBm78b5wd0AXK6EfpXyd1AB8qRCRQP5yo85c7TadtDMuNi+AxJjnYCozfozxTHiRkm7qdSQIGA0+5/vj0lGTneYPSnc+Q2R0VbvmpGQKrNgYjeiIUxfNy5M7xhFCZlTVSK9mT1rpv5zAdmimqhbQSlHR5XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203186; c=relaxed/simple;
	bh=CWyPb+R0+N4Z/Vgs9/kGkVD+YdhxfJbynRCEFK6cF/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cu1n1/0KDiwALXvtxBPn8/HMPxzrl/GZNqhE70QGgbm4Ulkp9ezdl7d0lL83R47YSHMW7kvraOKOZramw4Tsz3HNgCXrPG3sa+kCdVz4hOWexJ+BS5S4YGzZoW+YQEfBmAn8U9GEwmR7FnTD8mLIxv2UXfnj7LIj+gcTLz/wY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=b+npfWF0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="b+npfWF0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B0641476;
	Thu, 16 Jul 2026 04:59:38 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA1DB3F905;
	Thu, 16 Jul 2026 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784203182; bh=CWyPb+R0+N4Z/Vgs9/kGkVD+YdhxfJbynRCEFK6cF/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b+npfWF0cfwHFNmNPVct1qEf8bMDflTEDKtn/6W+8HEmGJEQFI2AB7iHaQl1AuZ3f
	 aiFRBinnnhNQ3KY6tEKkSjcZbXMyJ/Jwa79wtrNwVm7NexbCKYlwF+1uXXYGHvaZ3m
	 uogedz+vvjuCpxLSCy1zzsNDYFUg6xuzKgx99j6s=
Message-ID: <787fa0d3-c1d4-442e-beaa-91a03238f511@arm.com>
Date: Thu, 16 Jul 2026 12:59:40 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>,
 Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com>
 <20260703161228.GA1948451@nvidia.com>
 <b7224dff-7e51-49cb-8421-14d090492dfc@oss.qualcomm.com>
 <20260715113913.GA3775915@nvidia.com> <ald3CuddY6I7gml1@willie-the-truck>
 <2ce09e84-c57f-4087-9dda-07245fadfc02@arm.com>
 <20260715125039.GA50536@nvidia.com>
 <d20d258d-d970-4ef1-bbb6-cdc83fc20c9d@arm.com>
 <20260715180949.GD3775915@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260715180949.GD3775915@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2026 7:09 pm, Jason Gunthorpe wrote:
> On Wed, Jul 15, 2026 at 06:45:09PM +0100, Robin Murphy wrote:
> 
>>> AFAICR the biggest issue with arm-smmu was it using IO_PGTABLE_ARMV7S
>>> as well. I think it would be fine to implement all the unique LPAE
>>> features it needs in iommupt, I did most of them already.
>>>
>>> I do have an ARMV7S implementation for iommupt, but I did not solve
>>> the sub page problem. So while it is functionally working it is not
>>> usable since it wastes so much memory. That's a tricky problem to
>>> solve since the algorithms depend on the gather->freelist.
>>>
>>> I didn't spend any time trying to do anything about this as I was not
>>> intending to touch arm-smmu
>>
>> Indeed between the irregular table sizes (before you even get to the
>> Mediatek shenanigans...), and the awkward GFP_DMA limitations and/or reality
>> that many of the systems using it really don't have memory to waste, I'd
>> have considered v7s pretty much terminally incompatible with iommu_pages and
>> the abstraction that iommupt is trying to be... :/
> 
> At least Matthew has talked about having a sub page allocator with
> meta data, maybe with the memdesc support someday. Even today we could
> have iommu-pages allocate a companion struct pointed to from struct
> page that was sized 4x so it could be used for the freelist.
> 
> There are some other options for alterantive algorithms that could
> work without requiring the free list. I had some thoughts about placing
> the free list inside the data itself as a non-present entry.
> 
> It is not insolvable, I'm just not sure it is worth doing vs leaving
> arm-smmu to keep using iopgtable from ARMv7.

Yeah, if you did want to keep bashing at it, then ultimately there are 
at least a couple more short-descriptor inspired implementations in 
exynos and omap too, however at this point I don't see the cost:benefit 
ratio looking at all favourable...

> Otherwise to have arm-smmu use iommupt you'd end up with two
> iommu_domains specialized to 32 and 64 bit page tables, with their own
> ops and a shared invalidation like how the tlbi struct is providing
> for smmuv3.
> 
> It is not outrageously bad, but it certainly is a chunk of work.
> 
> If the goal is arm-smmu support of CONT then maybe there is some merit
> in doing iopgtable as a one off feature. But there have been many
> attempts so far to add CONT and they all had troubles, I had the
> impression is is not so easy..

I think now that partial unmaps are firmly ruled out and we already have 
the multi-page map/unmap design it should be pretty minor. I'm also more 
than happy to stop there, have dirty tracking, splitting/merging and all 
the fancy new IOMMUFD stuff require iommupt, and keep io-pgtable 
strictly for the GPUs and "media" IOMMUs that only need to keep 
providing map/unmap/iova_to_phys for iommu-dma or equivalent usage. By 
now I'd also say we can reasonably park arm-smmu in the latter category 
- while technically it could try to support stuff like nesting and 
vIOMMU (at least on MMU-500), the hardware is in embedded platforms 
which either don't care at all, or at worst where virtualisation is 
Xen's problem not ours. As far as I'm aware even the NXP Layerscape 
platforms are happy with the status quo of just basic VFIO type 1 for DPDK.

Thanks,
Robin.
