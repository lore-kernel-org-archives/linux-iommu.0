From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 5/9] dma-mapping: support highmem in the generic remap
	allocator
Date: Tue, 4 Dec 2018 15:23:04 +0100
Message-ID: <20181204142304.GC2618@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
	<20181105121931.13481-6-hch@lst.de>
	<CGME20181130190639epcas3p2c9a23f5788b7f8eea26ce8d305b5e6f7@epcas3p2.samsung.com>
	<449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
	<e1567e0d-4724-fb6b-cc22-3a723eec5e0f@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e1567e0d-4724-fb6b-cc22-3a723eec5e0f-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>, Laura Abbott <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 04, 2018 at 09:38:02AM +0100, Marek Szyprowski wrote:
> Hi All,
> 
> On 2018-11-30 20:05, Robin Murphy wrote:
> > On 05/11/2018 12:19, Christoph Hellwig wrote:
> >> By using __dma_direct_alloc_pages we can deal entirely with struct page
> >> instead of having to derive a kernel virtual address.
> >
> > Simple enough :)
> >
> > Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> 
> This patch has landed linux-next yesterday and I've noticed that it
> breaks operation of many drivers. The change looked simple, but a stupid
> bug managed to slip into the code. After a short investigation I've
> noticed that __dma_direct_alloc_pages() doesn't set dma_handle and zero
> allocated memory, while dma_direct_alloc_pages() did. The other
> difference is the lack of set_memory_decrypted() handling.
> 
> Following patch fixes the issue, but maybe it would be better to fix it
> in kernel/dma/direct.c:

Thanks for spotting this Marek.  Can you send the patch below with a
signoff and a changelog so that I can queue it up?
