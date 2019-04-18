From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Date: Thu, 18 Apr 2019 19:15:00 +0100
Message-ID: <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-13-hch@lst.de>
 <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de>
 <20190417063358.GA24139@lst.de>
 <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
 <20190418163512.GA25347@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418163512.GA25347@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 18/04/2019 17:35, Christoph Hellwig wrote:
> On Thu, Apr 18, 2019 at 04:06:56PM +0100, Robin Murphy wrote:
>> OK, I'm still looking at mmap and get_sgtable, but for now I've pushed out
>> a partial branch that consolidates alloc and free in a way which makes
>> sense to me:
>>
>>    git://linux-arm.org/linux-rm  dma/rework
>>
>> Please let me know what you think.
> 
>  From a very high level POV this looks ok, but sometimes a bit to
> convoluted to me.  The major issue why I went with the version I posted
> is that I can cleanly ifdef out the remap code in just a few sections.
> In this version it is spread out a lot more, and the use of IS_ENABLED
> means that we'd need a lot more stubs for functionality that won't
> ever be called but needs to be compilable.

OK, for some reason I'd convinced myself that mmap and get_sgtable would 
need changes to properly handle the new non-remapped CMA case - not sure 
how I reached that conclusion. On inspection they do appear to be broken 
for the non-coherent atomic case, but AFAICS that's been so forever...

Still, I've worked in the vm_map_pages() stuff pending in MM and given 
them the same treatment to finish the picture. Both x86_64_defconfig and 
i386_defconfig do indeed compile and link fine as I expected, so I 
really would like to understand the concern around #ifdefs better.

Robin.
