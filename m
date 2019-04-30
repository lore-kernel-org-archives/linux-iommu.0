From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC/RFT PATCH 1/2] dma-contiguous: Simplify
 dma_*_from_contiguous() function calls
Date: Tue, 30 Apr 2019 13:37:54 +0100
Message-ID: <0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com>
 <20190430015521.27734-2-nicoleotsuka@gmail.com>
 <20190430105640.GA20021@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430105640.GA20021@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: m.szyprowski@samsung.com, vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com, akpm@linux-foundation.org, sfr@canb.auug.org.au, treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com, wsa+renesas@sang-engineering.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 30/04/2019 11:56, Christoph Hellwig wrote:
> So while I really, really like this cleanup it turns out it isn't
> actually safe for arm :(  arm remaps the CMA allocation in place
> instead of using a new mapping, which can be done because they don't
> share PMDs with the kernel.
> 
> So we'll probably need a __dma_alloc_from_contiguous version with
> an additional bool fallback argument - everyone but arms uses
> dma_alloc_from_contiguous as in your patch, just arm will get the
> non-fallback one.

Or we even just implement dma_{alloc,free}_contiguous() as a wrapper 
around the existing APIs so that users can be thoroughly checked and 
converted one-by-one.

Robin.
