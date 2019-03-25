From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 RFC/RFT] dma-contiguous: Get normal pages for
 single-page allocations
Date: Mon, 25 Mar 2019 11:50:23 -0700
Message-ID: <20190325185022.GA24188@Asurada-Nvidia>
References: <20190305183202.16216-1-nicoleotsuka@gmail.com>
 <20190319144301.GG59586@arrakis.emea.arm.com>
 <20190321233248.GA6941@Asurada-Nvidia>
 <20190322105712.GB13384@arrakis.emea.arm.com>
 <20190322200925.GA22219@Asurada-Nvidia>
 <20190325121436.hwmzgqkaggxvnfqx@mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190325121436.hwmzgqkaggxvnfqx@mbp>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com, will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org, jonathanh@nvidia.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 25, 2019 at 12:14:37PM +0000, Catalin Marinas wrote:

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index fcdb23e8d2fc..8955ba6f52fc 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -111,8 +111,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>  again:
>  	/* CMA can be used only in the context which permits sleeping */
>  	if (gfpflags_allow_blocking(gfp)) {
> -		page = dma_alloc_from_contiguous(dev, count, page_order,
> -						 gfp & __GFP_NOWARN);
> +		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);

Oh...yea...It should have this part. I messed up with some
thing else so couldn't get it. Thanks for the reply.

I will go for the previous change by returning NULL in the
dma_alloc_from_contiguous() so the no_warm parameter would
not be touched.
