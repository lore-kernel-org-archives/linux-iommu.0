From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/19] dma-mapping: add a Kconfig symbol to indicated
 arch_dma_prep_coherent presence
Date: Fri, 1 Feb 2019 17:12:02 +0100
Message-ID: <20190201161202.GH6532@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-2-hch@lst.de> <b3883403-f9b5-34ec-ff5d-9f2ddc9bf8e6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b3883403-f9b5-34ec-ff5d-9f2ddc9bf8e6@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 02:22:46PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> Add a Kconfig symbol that indicates an architecture provides a
>> arch_dma_prep_coherent implementation, and provide a stub otherwise.
>>
>> This will allow the generic dma-iommu code to it while still allowing
>> to be built for cache coherent architectures.
>
> I've been pondering this for a while now, and I still can't really come up 
> with a case where arch_dma_prep_coherent() would need to behave differently 
> from arch_sync_dma_for_device(..., DMA_BIDIRECTIONAL). I wonder if we could 
> just save ourselves this little bit of complexity by using that instead...

A lot of architectures do really weird stuff in the dma sync routines.
So my plan would be to consolidate a lot more logic in there first,
and then maybe as a next step we could look into using
arch_sync_dma_for_device eventually.
