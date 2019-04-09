From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/21] arm64/iommu: improve mmap bounds checking
Date: Tue, 9 Apr 2019 16:12:51 +0100
Message-ID: <45672f18-c741-601d-6bb2-92f50b77e981@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-3-hch@lst.de>
 <3629087c-a8cb-d66e-840b-cfee125bdf4c@arm.com> <20190407065923.GA9086@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190407065923.GA9086@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 07/04/2019 07:59, Christoph Hellwig wrote:
> On Fri, Apr 05, 2019 at 06:30:52PM +0100, Robin Murphy wrote:
>> On 27/03/2019 08:04, Christoph Hellwig wrote:
>>> The nr_pages checks should be done for all mmap requests, not just those
>>> using remap_pfn_range.
>>
>> Hmm, the logic in iommu_dma_mmap() inherently returns an error for the "off
>>> = nr_pages" case already. It's also supposed to be robust against the
>> "vma_pages(vma) > nr_pages - off" condition, although by making the partial
>> mapping and treating it as a success, rather than doing nothing and
>> returning an error. What's the exact motivation here?
> 
> Have one error check at the front of the function that is identical
> to the mmap checks in the other dma_map_ops instances so that:
> 
>   a) we get the same error behavior for partial requests everywhere
>   b) we can lift these checks into common code in the next round.
> 

Fair enough, but in that case why isn't the dma_mmap_from_coherent() 
path also covered?

Robin.
