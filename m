Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339E84508F8
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137515; cv=none; b=PXJSOx9y5VH6hA2ocvirrcIm5hE7X5n4liV8oAh2BVjVN7fdNq6jjyE2vaGlQXut0gdZ5Do4ctVH1XoXw+q5rHHAfAsRJ0Fr9+sT+Fal3BbfoL0Yy3nttcmEjIb4Bif0erkORhRxEft1mhD13j1ssMSFKrRaBIClIwZaqKjvW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137515; c=relaxed/simple;
	bh=eeC0Oy450ThvtldVu7hsdDDTtsDrV1G7Io1D0bRWiaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsRCoJYUcyLeqfHDe8zf2H4IWOu7/+/UJOw66Lsk5KeafBnuG5O7K9/82L5op/cIYTLTEqYsk3znj9D1Kjyp+BjVAME06cxGTjcFHkP2VPwrD0YNCcY/I1AHr9NW6Sn16KgeylTsr9YKr4xUNPGkKNLHe0/QCFLxfuWhJM5P9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=j6XlR9E7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j6XlR9E7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F14D1477;
	Wed, 15 Jul 2026 10:45:08 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 082EA3F905;
	Wed, 15 Jul 2026 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784137512; bh=eeC0Oy450ThvtldVu7hsdDDTtsDrV1G7Io1D0bRWiaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j6XlR9E7+wabRwgqSqgyqMPSBUX37OU5Tw1RX+1jC4gX3sHe7TBofS6iO2vKr4w7X
	 bAwt8DLiiej7yQPNCnADLT8u4092zBXlPyEXXZV+RCkKjv3+8cbS4+D2qcfyFjRGqA
	 /3bh/TYMWJoRcNDK9Js6UyZr3mTZjVJQDVTu7FTQ=
Message-ID: <d20d258d-d970-4ef1-bbb6-cdc83fc20c9d@arm.com>
Date: Wed, 15 Jul 2026 18:45:09 +0100
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
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260715125039.GA50536@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2026 1:50 pm, Jason Gunthorpe wrote:
> On Wed, Jul 15, 2026 at 01:14:18PM +0100, Robin Murphy wrote:
> 
>> Conversely though, I really wouldn't want to have to maintain arm-smmu
>> supporting two completely different pagetable APIs simultaneously either :/
> 
> Does arm-smmu era HW even support CONT?

Yes, it goes all the way back to ARMv7 LPAE, predating even SMMUv1, and 
certainly at least Arm's implementations (MMU-400/401/500) can all make 
meaningful use of it.

> AFAICR the biggest issue with arm-smmu was it using IO_PGTABLE_ARMV7S
> as well. I think it would be fine to implement all the unique LPAE
> features it needs in iommupt, I did most of them already.
> 
> I do have an ARMV7S implementation for iommupt, but I did not solve
> the sub page problem. So while it is functionally working it is not
> usable since it wastes so much memory. That's a tricky problem to
> solve since the algorithms depend on the gather->freelist.
> 
> I didn't spend any time trying to do anything about this as I was not
> intending to touch arm-smmu

Indeed between the irregular table sizes (before you even get to the 
Mediatek shenanigans...), and the awkward GFP_DMA limitations and/or 
reality that many of the systems using it really don't have memory to 
waste, I'd have considered v7s pretty much terminally incompatible with 
iommu_pages and the abstraction that iommupt is trying to be... :/

Thanks,
Robin.
