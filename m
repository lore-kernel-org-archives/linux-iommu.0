From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH RFC/RFT 2/5] dma-remap: Run alloc_pages() on failure
Date: Tue, 26 Mar 2019 15:53:22 -0700
Message-ID: <20190326225321.GA6796@Asurada-Nvidia>
References: <20190326224959.9656-1-nicoleotsuka@gmail.com>
 <20190326224959.9656-3-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326224959.9656-3-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, robin.murphy@arm.com
Cc: vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, tony@atomide.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 26, 2019 at 03:49:56PM -0700, Nicolin Chen wrote:
> @@ -116,7 +116,7 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
>  	if (dev_get_cma_area(NULL))
>  		page = dma_alloc_from_contiguous(NULL, nr_pages,
>  						 pool_size_order, false);
> -	else
> +	if (!page)
>  		page = alloc_pages(gfp, pool_size_order);

Just realized a missing change in this patch, will send v2.
Please ignore this version.
