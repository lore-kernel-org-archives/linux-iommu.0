From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/10] arm64: use the generic swiotlb_dma_ops
Date: Fri, 26 Oct 2018 14:44:55 +0200
Message-ID: <20181026124455.GA28571@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-11-hch@lst.de> <738dfd71-f78b-1d73-712c-73a4b6d4141c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <738dfd71-f78b-1d73-712c-73a4b6d4141c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 22, 2018 at 06:52:51PM +0100, Robin Murphy wrote:
>> scatterlist *sgl,
>> -				  int nelems, enum dma_data_direction dir,
>> -				  unsigned long attrs)
>> +long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
>
> I realise I'm spotting this a bit late, but does this interface really need 
> somewhat-atypical signed PFNs?

It has been a while since I wrote this code, and I can't remember the
reason for it except that I'm pretty sure I copy and pasted it from
existing code somewhere.

Switching it to unsigned long should be fine, and patches are welcome.

>> +static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
>> +				      struct page *page, size_t size)
>
> If __iommu_get_sgtable() is now the only user, I'd say just inline these 
> remnants there (or let that case call dma_common_sgtable() if that's what 
> swiotlb_dma_ops are now relying on). Either way the "__swiotlb" is now a 
> complete misnomer.

It is.  But we hopefully kill both the only user and this helper in
the 4.21 merge window when moving the iommu dma api wrappers to common
code.
