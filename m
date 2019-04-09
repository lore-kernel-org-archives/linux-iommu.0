From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 07/21] dma-iommu: move the arm64 wrappers to common code
Date: Tue, 9 Apr 2019 18:33:30 +0100
Message-ID: <eace43d1-417e-c96d-0c13-160973fce077@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-8-hch@lst.de>
 <67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
 <20190409172309.GD14679@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409172309.GD14679@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 09/04/2019 18:23, Christoph Hellwig wrote:
> On Tue, Apr 09, 2019 at 04:07:02PM +0100, Robin Murphy wrote:
>>> -static inline int iommu_dma_init(void)
>>> +static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>>> +		u64 size, const struct iommu_ops *ops)
>>>    {
>>> -	return 0;
>>>    }
>>
>> I don't think it makes sense to have a stub for that - AFAICS it should
>> only ever be called form arch code with an inherent "select IOMMU_DMA"
>> (much like the stuff which isn't stubbed currently).
>>
>> Otherwise, I'm about 97% sure the rest of the move looks OK - thanks for
>> splitting things up.
> 
> arm64 only selects IOMMU_DMA if IOMMU_SUPPORT is selected, which can
> be disabled.  So to keep some (unusual) arm64 configs compiling we'll need
> the stub..

Urgh, right, it worked out before because arm64 stubbed its own caller 
of iommu_dma_init_domain() internally... Oh well - I guess there's no 
nicer alternative, and we have always treated arch_setup_dma_ops() that way.

Robin.
