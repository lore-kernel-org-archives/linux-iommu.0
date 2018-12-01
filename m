From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
Date: Sat, 1 Dec 2018 18:03:25 +0100
Message-ID: <20181201170325.GD20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-5-hch@lst.de> <5526bc61-57a3-54ff-60c6-e9963230af22@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5526bc61-57a3-54ff-60c6-e9963230af22@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 30, 2018 at 07:05:23PM +0000, Robin Murphy wrote:
> It's a bit yuck that we now end up with arch_* hooks being a mix of arch 
> code and not-actually-arch-code, but I guess there's some hope of coming 
> back and streamlining things in future once all the big moves are done.

Yes, I hope we can use some form of common code here for most
architectures eventually.  But that will some time.

> I can't really be bothered to nitpick the typos above and the slight 
> inconsistencies in some of the cosmetic code changes, but one worthwhile 
> thing stands out...

I'm usually fine picking up nitpicks.  For now I'll apply the series
with the pointed out fixups, but if you want to send the fixups
I'd be glad.

>> +	val = gen_pool_alloc(atomic_pool, size);
>> +	if (val) {
>> +		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
>> +
>> +		*ret_page = phys_to_page(phys);
>
> Looks like phys_to_page() isn't particularly portable, so we probably want 
> an explicit pfn_to_page(__phys_to_pfn(phys)) here. Otherwise, the 
> fundamental refactoring looks OK.

Ok, I'll updated it.
