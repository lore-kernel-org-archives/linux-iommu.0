From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
Date: Wed, 6 Feb 2019 15:28:28 +0000
Message-ID: <f59852aa-394c-3165-f7c0-fa6cdcea059f@arm.com>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-4-hch@lst.de>
 <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com> <20190201161638.GJ6532@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201161638.GJ6532@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 01/02/2019 16:16, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 03:24:45PM +0000, Robin Murphy wrote:
>> On 14/01/2019 09:41, Christoph Hellwig wrote:
>>> Directly iterating over the pages makes the code a bit simpler and
>>> prepares for the following changes.
>>
>> It also defeats the whole purpose of __iommu_dma_alloc_pages(), so I'm not
>> really buying the simplification angle - you've *seen* that code, right? ;)
> 
> How does it defeat the purpose of __iommu_dma_alloc_pages?

Because if iommu_map() only gets called at PAGE_SIZE granularity, then 
the IOMMU PTEs will be created at PAGE_SIZE (or smaller) granularity, so 
any effort to get higher-order allocations matching larger IOMMU block 
sizes is wasted, and we may as well have just done this:

	for (i = 0; i < count; i++) {
		struct page *page = alloc_page(gfp);
		...
		iommu_map(..., page_to_phys(page), PAGE_SIZE, ...);
	}

Really, it's a shame we have to split huge pages for the CPU remap, 
since in the common case the CPU MMU will have a matching block size, 
but IIRC there was something in vmap() or thereabouts that explicitly 
chokes on them.

Robin.
