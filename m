From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC/RFT PATCH 1/2] dma-contiguous: Simplify
 dma_*_from_contiguous() function calls
Date: Tue, 30 Apr 2019 17:18:33 +0200
Message-ID: <20190430151833.GB25447@lst.de>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com> <20190430015521.27734-2-nicoleotsuka@gmail.com> <20190430105640.GA20021@lst.de> <0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Nicolin Chen <nicoleotsuka@gmail.com>, m.szyprowski@samsung.com, vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com, akpm@linux-foundation.org, sfr@canb.auug.org.au, treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com, wsa+renesas@sang-engineering.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 30, 2019 at 01:37:54PM +0100, Robin Murphy wrote:
> On 30/04/2019 11:56, Christoph Hellwig wrote:
>> So while I really, really like this cleanup it turns out it isn't
>> actually safe for arm :(  arm remaps the CMA allocation in place
>> instead of using a new mapping, which can be done because they don't
>> share PMDs with the kernel.
>>
>> So we'll probably need a __dma_alloc_from_contiguous version with
>> an additional bool fallback argument - everyone but arms uses
>> dma_alloc_from_contiguous as in your patch, just arm will get the
>> non-fallback one.
>
> Or we even just implement dma_{alloc,free}_contiguous() as a wrapper around 
> the existing APIs so that users can be thoroughly checked and converted 
> one-by-one.

Yeah.  Actually given all the contention I wonder if the easiest solution
for now is to just open code the cma_alloc/cma_free calls in dma-direct
and dma-iommu, with the hopes that everyone is going to migrate to those
implementations in the mid-term anyway and dma_alloc_from_contiguous /
dma_release_from_contiguous just go away..
