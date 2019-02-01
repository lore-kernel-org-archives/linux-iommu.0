From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
Date: Fri, 1 Feb 2019 17:16:38 +0100
Message-ID: <20190201161638.GJ6532@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-4-hch@lst.de> <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 03:24:45PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> Directly iterating over the pages makes the code a bit simpler and
>> prepares for the following changes.
>
> It also defeats the whole purpose of __iommu_dma_alloc_pages(), so I'm not 
> really buying the simplification angle - you've *seen* that code, right? ;)

How does it defeat the purpose of __iommu_dma_alloc_pages?
