Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884A9393DEA
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712301; cv=none; b=O2y2M55NKtvlnvlZNuiTZ+o61borHy8sBGV9JcK5dYY7zxlazUD67P+Os9UDFvb3WnoSCTFa5kFtC5CyexmeoKnQh0pbcmqGjz3TGLETjpSyLeKOsWVMvMjw3UIhDHlCu6qd3xFVfxbA0MUvYOQwuBN4gpWD8/uCK6kxDYZm3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712301; c=relaxed/simple;
	bh=13hr9xatF+ZnmWbskP/EU5KOi9+BFoqN/Iy6R4XMmDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bh05U6Ewz/vYAqBdVwuE05Rzmju36Qz/pgt2mdS829qd5N5XG1yPodR4gOtxBVeEG+QwO9tXcCRlnJztI9GwNKZi+RQjkh3OA9JNCwQ1fMlak4mJwIg0Ug7mHU+TdhUSqa8b+2SLfFWFPvGAGISy6eIcCV3jrn+ZQtxfOMspXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA9851596;
	Fri, 17 Oct 2025 07:44:49 -0700 (PDT)
Received: from [10.1.35.25] (010265703453.cambridge.arm.com [10.1.35.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 514293F59E;
	Fri, 17 Oct 2025 07:44:56 -0700 (PDT)
Message-ID: <ab4d0c39-c6cb-4242-8e4c-479a684fb14d@arm.com>
Date: Fri, 17 Oct 2025 15:44:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
To: Jason Gunthorpe <jgg@nvidia.com>, Mostafa Saleh <smostafa@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
 Zhang Yu <zhangyu1@linux.microsoft.com>,
 Jean Philippe-Brucker <jean-philippe@linaro.org>,
 Alexander Grest <Alexander.Grest@microsoft.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
 <aPIhMGnzHiBkIEam@google.com> <20251017135145.GL3901471@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251017135145.GL3901471@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-17 2:51 pm, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 10:57:52AM +0000, Mostafa Saleh wrote:
>> On Wed, Sep 24, 2025 at 10:54:36AM -0700, Jacob Pan wrote:
>>> Hi Will et al,
>>>
>>> These two patches are derived from testing SMMU driver with smaller CMDQ
>>> sizes where we see soft lockups.
>>>
>>> This happens on HyperV emulated SMMU v3 as well as baremetal ARM servers
>>> with artificially reduced queue size and microbenchmark to stress test
>>> concurrency.
>>
>> Is it possible to share what are the artificial sizes and does the HW/emulation
>> support range invalidation (IRD3.RIL)?
>>
>> I'd expect it would be really hard to overwhelm the command queue, unless the
>> HW doesn't support range invalidation and/or the queue entries are close to
>> the number of CPUs.
> 
> At least on Jacob's system there is no RIL and there are 72/144 CPU
> cores potentially banging on this.
> 
> I think it is combination of lots of required invalidation commands,
> low queue depth and slow retirement of commands that make it easier to
> create a queue full condition.
> 
> Without RIL one SVA invalidation may take out the entire small queue,
> for example.

Indeed once real hardware first started to arrive, we found that even 
just 4 NVMe queues doing ~8MB DMA unmaps with a modestly-clocked MMU-600 
were capable of keeping a 256-entry CMDQ full enough to occasionally hit 
this timeout with the original spinlock. Which is precisely why, as well 
as introducing the new lock-free algorithm, we also stopped limiting the 
CMDQ to 4KB 6 years ago.

Yes, if the queue is contrived to only be big enough to hold 3 or fewer 
commands per CPU, one can expect catastrophic levels of contention even 
with RIL. However since that requires going out of the way to hack the 
driver (and/or hypervisor emulation) to force a clearly unrealistic 
behaviour, I would say the best solution to that particular problem is 
"stop doing that".

If significant contention is visible in real-world workloads, that would 
be more of a concern of interest.

Thanks,
Robin.
