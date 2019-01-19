From: Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Fail to boot Dom0 on Xen Arm64 after "dma-mapping: bypass indirect
	calls for dma-direct"
Date: Fri, 18 Jan 2019 16:43:59 -0800 (PST)
Message-ID: <alpine.DEB.2.10.1901181552090.18561@sstabellini-ThinkPad-X260>
References: <d3e4984f-f996-c38f-3cf1-c16450ef7a99@arm.com>
	<20190116181904.GA6228@infradead.org>
	<1855c743-becd-fd52-50b9-86398f6cb985@arm.com>
	<20190117141157.GA5184@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190117141157.GA5184-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Julien Grall <julien.grall-5wv7dgnIgG8@public.gmane.org>, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xen-devel <xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org>, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 17 Jan 2019, Christoph Hellwig wrote:
> On Thu, Jan 17, 2019 at 11:43:49AM +0000, Julien Grall wrote:
> > Looking at the change for arm64, you will always call dma-direct API. In
> > previous Linux version, xen-swiotlb will call dev->archdata.dev_dma_ops (a
> > copy of dev->dma_ops before setting Xen DMA ops) if not NULL. Does it mean
> > we expect dev->dma_ops to always be NULL and hence using dma-direct API?
> 
> The way I understood the code from inspecting it and sking the
> maintainers a few askings is that for DOM0 we always use xen-swiotlb
> as the actual dma_map_ops, but then use the functions in page-coherent.h
> only to deal with cache maintainance, so it should be safe.

Yes, what you wrote is correct, the stuff in
include/xen/arm/page-coherent.h is only to deal with cache maintenance,
specifically any cache maintenance operations that might be required by
map/unmap_page, dma_sync_single_for_cpu/device.

It looks like it is safe today to make the dma_direct calls directly,
especially considering that on arm64 it looks like the only other option
is iommu_dma_ops which has never been used with Xen so far (the IOMMU
has not been exposed to guests yet).

On arm32 we don't have this problem because dev->dma_ops is always !=
NULL with MMU enable (required on Xen), right?

So the patch looks fine, I only have an optional suggestion to add a
check on dma_ops being unset. I'll reply to the patch. 
