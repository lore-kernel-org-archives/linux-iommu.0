From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 13:00:02 -0700
Message-ID: <db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
References: <20190129205749.GN3176@redhat.com>
	<2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
	<20190129215028.GQ3176@redhat.com>
	<deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
	<20190129234752.GR3176@redhat.com>
	<655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
	<20190130041841.GB30598@mellanox.com>
	<bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
	<20190130185652.GB17080@mellanox.com>
	<20190130192234.GD5061@redhat.com>
	<20190130193759.GE17080@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190130193759.GE17080-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
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
To: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "Rafael J . Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2019-01-30 12:38 p.m., Jason Gunthorpe wrote:
> On Wed, Jan 30, 2019 at 02:22:34PM -0500, Jerome Glisse wrote:
> 
>> For GPU it would not work, GPU might want to use main memory (because
>> it is running out of BAR space) it is a lot easier if the p2p_map
>> callback calls the right dma map function (for page or io) rather than
>> having to define some format that would pass down the information.
> 
> This is already sort of built into the sgl, you are supposed to use
> is_pci_p2pdma_page() and pci_p2pdma_map_sg() and somehow it is supposed
> to work out - but I think this is also fairly incomplete.


> ie the current APIs seem to assume the SGL is homogeneous :(

We never changed SGLs. We still use them to pass p2pdma pages, only we
need to be a bit careful where we send the entire SGL. I see no reason
why we can't continue to be careful once their in userspace if there's
something in GUP to deny them.

It would be nice to have heterogeneous SGLs and it is something we
should work toward but in practice they aren't really necessary at the
moment.

>>> Worry about optimizing away the struct page overhead later?
>>
>> Struct page do not fit well for GPU as the BAR address can be reprogram
>> to point to any page inside the device memory (think 256M BAR versus
>> 16GB device memory).
> 
> The struct page only points to the BAR - it is not related to the
> actual GPU memory in any way. The struct page is just an alternative
> way to specify the physical address of the BAR page.

That doesn't even necessarily need to be the case. For HMM, I
understand, struct pages may not point to any accessible memory and the
memory that backs it (or not) may change over the life time of it. So
they don't have to be strictly tied to BARs addresses. p2pdma pages are
strictly tied to BAR addresses though.

Logan
