From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 9/9] csky: use the generic remapping dma alloc
 implementation
Date: Fri, 9 Nov 2018 08:51:58 +0100
Message-ID: <20181109075158.GB27489@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-10-hch@lst.de> <20181106070140.GA6232@guoren-Inspiron-7460>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181106070140.GA6232@guoren-Inspiron-7460>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 06, 2018 at 03:01:41PM +0800, Guo Ren wrote:
> > +	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
> >  }
> >  postcore_initcall(atomic_pool_init);
> Seems also could remove atomic_pool_init from csky, why not put them in
> common?

The code basically moved to common code, but the architecture needs
to pick the gfp mask (GFP_DMA32 on arm vs GFP_KERNEL on csky for example)
and the pgprot it needs for uncached remappings.

> Reviewed-by: Guo Ren <ren_guo@c-sky.com>
> 
> Compile is OK, qemu boot OK. Functions are the same and just move to common.

Thanks for your review!
