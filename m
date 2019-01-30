From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 21:50:25 +0000
Message-ID: <20190130215019.GL17080@mellanox.com>
References: <20190129215028.GQ3176@redhat.com>
	<deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
	<20190129234752.GR3176@redhat.com>
	<655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
	<20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
	<20190130190651.GC17080@mellanox.com>
	<840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
	<20190130195900.GG17080@mellanox.com>
	<35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <35bad6d5-c06b-f2a3-08e6-2ed0197c8691-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Content-ID: <22458AAABB3536449FE7EBE58980F139-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "Rafael J . Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 02:01:35PM -0700, Logan Gunthorpe wrote:

> And I feel the GUP->SGL->DMA flow should still be what we are aiming
> for. Even if we need a special GUP for special pages, and a special DMA
> map; and the SGL still has to be homogenous....

*shrug* so what if the special GUP called a VMA op instead of
traversing the VMA PTEs today? Why does it really matter? It could
easily change to a struct page flow tomorrow..

> > So, I see Jerome solving the GUP problem by replacing GUP entirely
> > using an API that is more suited to what these sorts of drivers
> > actually need.
> 
> Yes, this is what I'm expecting and what I want. Not bypassing the whole
> thing by doing special things with VMAs.

IMHO struct page is a big pain for this application, and if we can
build flows that don't actually need it then we shouldn't require it
just because the old flows needed it.

HMM mirror is a new flow that doesn't need struct page.

Would you feel better if this also came along with a:

  struct dma_sg_table *sgl_dma_map_user(struct device *dma_device, 
             void __user *prt, size_t len)

flow which returns a *DMA MAPPED* sgl that does not have struct page
pointers as another interface?

We can certainly call an API like this from RDMA for non-ODP MRs.

Eliminating the page pointers also eliminates the __iomem
problem. However this sgl object is not copyable or accessible from
the CPU, so the caller must be sure it doesn't need CPU access when
using this API. 

For RDMA I'd include some flag in the struct ib_device if the driver
requires CPU accessible SGLs and call the right API. Maybe the block
layer could do the same trick for O_DIRECT?

This would also directly solve the P2P problem with hfi1/qib/rxe, as
I'd likely also say that pci_p2pdma_map_sg() returns the same DMA only
sgl thing.

Jason
