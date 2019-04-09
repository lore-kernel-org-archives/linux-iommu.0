From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 09/21] dma-iommu: refactor iommu_dma_get_sgtable
Date: Tue, 9 Apr 2019 19:26:52 +0200
Message-ID: <20190409172652.GF14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-10-hch@lst.de> <a42133a5-c88b-76c7-80fa-671cfbdd9759@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a42133a5-c88b-76c7-80fa-671cfbdd9759@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2019 at 04:49:30PM +0100, Robin Murphy wrote:
>> *cpu_addr,
>> +		size_t size)
>> +{
>> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +	struct vm_struct *area = find_vm_area(cpu_addr);
>> +
>> +	if (WARN_ON(!area || !area->pages))
>> +		return -ENXIO;
>> +	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
>> +			GFP_KERNEL);
>> +}
>> +
>
> Is this complex enough to deserve being broken out? Really I'd prefer to 
> keep get_sgtable() as small and consolidated as possible so that it's that 
> much easier to delete in future :)

Well, it is logically separate, and this keeps it tidy.  But I agree
with the long term goal of killing off this awkward API that should
never have been added.

>
> I guess there is a certain symmetry with mmap(), so if that's the angle 
> you're dead set on, could we at least keep this guy down where 
> __iommu_dma_get_sgtable_page() was?

It is up there so that we can reduce the number of ifdef blocks for
dma remapping later on.
