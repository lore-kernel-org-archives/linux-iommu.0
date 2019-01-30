From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 15:52:13 -0700
Message-ID: <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
References: <20190129215028.GQ3176@redhat.com>
	<deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
	<20190129234752.GR3176@redhat.com>
	<655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
	<20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
	<20190130190651.GC17080@mellanox.com>
	<840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
	<20190130195900.GG17080@mellanox.com>
	<35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
	<20190130215019.GL17080@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190130215019.GL17080-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "Rafael J . Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2019-01-30 2:50 p.m., Jason Gunthorpe wrote:
> On Wed, Jan 30, 2019 at 02:01:35PM -0700, Logan Gunthorpe wrote:
> 
>> And I feel the GUP->SGL->DMA flow should still be what we are aiming
>> for. Even if we need a special GUP for special pages, and a special DMA
>> map; and the SGL still has to be homogenous....
> 
> *shrug* so what if the special GUP called a VMA op instead of
> traversing the VMA PTEs today? Why does it really matter? It could
> easily change to a struct page flow tomorrow..

Well it's so that it's composable. We want the SGL->DMA side to work for
APIs from kernel space and not have to run a completely different flow
for kernel drivers than from userspace memory.

For GUP to do a special VMA traversal it would now need to return
something besides struct pages which means no SGL and it means a
completely different DMA mapping call.
> Would you feel better if this also came along with a:
> 
>   struct dma_sg_table *sgl_dma_map_user(struct device *dma_device, 
>              void __user *prt, size_t len)

That seems like a nice API. But certainly the implementation would need
to use existing dma_map or pci_p2pdma_map calls, or whatever as part of
it...

,
> flow which returns a *DMA MAPPED* sgl that does not have struct page
> pointers as another interface?
> 
> We can certainly call an API like this from RDMA for non-ODP MRs.
> 
> Eliminating the page pointers also eliminates the __iomem
> problem. However this sgl object is not copyable or accessible from
> the CPU, so the caller must be sure it doesn't need CPU access when
> using this API. 

We actually stopped caring about the __iomem problem. We are working
under the assumption that pages returned by devm_memremap_pages() can be
accessed as normal RAM and does not need the __iomem designation. The
main problem now is that code paths need to know to use pci_p2pdma_map
or not. And in theory this could be pushed into regular dma_map
implementations but we'd have to get it into all of them which is a pain.

Logan
