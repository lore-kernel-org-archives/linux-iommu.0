From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] swiotlb: Return error from swiotlb_init_with_tbl()
Date: Fri, 1 Feb 2019 17:50:29 +0100
Message-ID: <20190201165029.GU32526@8bytes.org>
References: <20190131162424.10477-1-joro@8bytes.org>
 <20190201081208.GB15512@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201081208.GB15512@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 09:12:08AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 31, 2019 at 05:24:24PM +0100, Joerg Roedel wrote:
> > -	io_tlb_list = memblock_alloc(
> > +	io_tlb_list = memblock_alloc_nopanic(
> >  				PAGE_ALIGN(io_tlb_nslabs * sizeof(int)),
> >  				PAGE_SIZE);
> 
> Mike just killed the _nopanic versions and made the normal ones not
> panic.

This sounds like a change to break quite a couple of places in the
kernel. But okay, it just makes this hunk obsolete.


	Joerg
