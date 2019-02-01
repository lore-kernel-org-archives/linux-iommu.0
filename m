From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swiotlb: Return error from swiotlb_init_with_tbl()
Date: Fri, 1 Feb 2019 09:12:08 +0100
Message-ID: <20190201081208.GB15512@lst.de>
References: <20190131162424.10477-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131162424.10477-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 05:24:24PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The only reason why swiotlb_init_with_tbl() can fail is an
> allocation failure in the memblock_alloc() function. But
> this function just calls panic() in case it can't fulfill
> the request and never returns an error, therefore
> swiotlb_init_with_tbl() also never actually returns an
> error.

Please use up all 72 characters per line available in the commit log
format.

> -	io_tlb_list = memblock_alloc(
> +	io_tlb_list = memblock_alloc_nopanic(
>  				PAGE_ALIGN(io_tlb_nslabs * sizeof(int)),
>  				PAGE_SIZE);

Mike just killed the _nopanic versions and made the normal ones not
panic.
