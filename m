From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 RFC/RFT] dma-contiguous: Get normal pages for
 single-page allocations
Date: Fri, 22 Mar 2019 13:09:26 -0700
Message-ID: <20190322200925.GA22219@Asurada-Nvidia>
References: <20190305183202.16216-1-nicoleotsuka@gmail.com>
 <20190319144301.GG59586@arrakis.emea.arm.com>
 <20190321233248.GA6941@Asurada-Nvidia>
 <20190322105712.GB13384@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322105712.GB13384@arrakis.emea.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com, will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org, jonathanh@nvidia.com
List-Id: iommu@lists.linux-foundation.org

Hi Catalin,

On Fri, Mar 22, 2019 at 10:57:13AM +0000, Catalin Marinas wrote:
> > > Do you have any numbers to back this up? You don't seem to address
> > > dma_direct_alloc() either but, as I said above, it's not trivial since
> > > some platforms expect certain physical range for DMA allocations.
> > 
> > What's the dma_direct_alloc() here about? Mind elaborating?
> 
> I just did a grep for dma_alloc_from_contiguous() in the 5.1-rc1 kernel
> and came up with __dma_direct_alloc_pages(). Should your patch cover
> this as well?

I don't get the meaning of "cover this" here. What missing part
do you refer to?
