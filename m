From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Date: Tue, 23 Apr 2019 16:52:36 +0200
Message-ID: <20190423145236.GA22253@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-13-hch@lst.de> <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de> <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com> <20190418163512.GA25347@lst.de> <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com> <20190419082348.GA22299@lst.de> <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 23, 2019 at 11:01:44AM +0100, Robin Murphy wrote:
> On 19/04/2019 09:23, Christoph Hellwig wrote:
>> On Thu, Apr 18, 2019 at 07:15:00PM +0100, Robin Murphy wrote:
>>> Still, I've worked in the vm_map_pages() stuff pending in MM and given them
>>> the same treatment to finish the picture. Both x86_64_defconfig and
>>> i386_defconfig do indeed compile and link fine as I expected, so I really
>>> would like to understand the concern around #ifdefs better.
>>
>> This looks generally fine to me.  One thing I'd like to do is to
>> generally make use of the fact that __iommu_dma_get_pages returns NULL
>> for the force contigous case as that cleans up a few things.  Also
>> for the !DMA_REMAP case we need to try the page allocator when
>> dma_alloc_from_contiguous does not return a page.  What do you thing
>> of the following incremental diff?  If that is fine with you I can
>> fold that in and add back in the remaining patches from my series
>> not obsoleted by your patches and resend.
>
> Wouldn't this suffice? Since we also use alloc_pages() in the coherent 
> atomic case, the free path should already be able to deal with it.

Yepp, that is about what I've done in v3, except that I've also folded
that coherent atomic case in a way very similar to dma-direct.
