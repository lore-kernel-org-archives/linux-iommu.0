From: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 14:22:34 -0500
Message-ID: <20190130192234.GD5061@redhat.com>
References: <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
	<20190129205749.GN3176@redhat.com>
	<2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
	<20190129215028.GQ3176@redhat.com>
	<deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
	<20190129234752.GR3176@redhat.com>
	<655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
	<20190130041841.GB30598@mellanox.com>
	<bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
	<20190130185652.GB17080@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190130185652.GB17080-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "Rafael J . Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 06:56:59PM +0000, Jason Gunthorpe wrote:
> On Wed, Jan 30, 2019 at 10:17:27AM -0700, Logan Gunthorpe wrote:
> > =

> > =

> > On 2019-01-29 9:18 p.m., Jason Gunthorpe wrote:
> > > Every attempt to give BAR memory to struct page has run into major
> > > trouble, IMHO, so I like that this approach avoids that.
> > > =

> > > And if you don't have struct page then the only kernel object left to
> > > hang meta data off is the VMA itself.
> > > =

> > > It seems very similar to the existing P2P work between in-kernel
> > > consumers, just that VMA is now mediating a general user space driven
> > > discovery process instead of being hard wired into a driver.
> > =

> > But the kernel now has P2P bars backed by struct pages and it works
> > well. =

> =

> I don't think it works that well..
> =

> We ended up with a 'sgl' that is not really a sgl, and doesn't work
> with many of the common SGL patterns. sg_copy_buffer doesn't work,
> dma_map, doesn't work, sg_page doesn't work quite right, etc.
> =

> Only nvme and rdma got the special hacks to make them understand these
> p2p-sgls, and I'm still not convinced some of the RDMA drivers that
> want access to CPU addresses from the SGL (rxe, usnic, hfi, qib) don't
> break in this scenario.
> =

> Since the SGLs become broken, it pretty much means there is no path to
> make GUP work generically, we have to go through and make everything
> safe to use with p2p-sgls before allowing GUP. Which, frankly, sounds
> impossible with all the competing objections.
> =

> But GPU seems to have a problem unrelated to this - what Jerome wants
> is to have two faulting domains for VMA's - visible-to-cpu and
> visible-to-dma. The new op is essentially faulting the pages into the
> visible-to-dma category and leaving them invisible-to-cpu.
> =

> So that duality would still have to exists, and I think p2p_map/unmap
> is a much simpler implementation than trying to create some kind of
> special PTE in the VMA..
> =

> At least for RDMA, struct page or not doesn't really matter. =

> =

> We can make struct pages for the BAR the same way NVMe does.  GPU is
> probably the same, just with more mememory at stake?  =

> =

> And maybe this should be the first implementation. The p2p_map VMA
> operation should return a SGL and the caller should do the existing
> pci_p2pdma_map_sg() flow.. =


For GPU it would not work, GPU might want to use main memory (because
it is running out of BAR space) it is a lot easier if the p2p_map
callback calls the right dma map function (for page or io) rather than
having to define some format that would pass down the information.

> =

> Worry about optimizing away the struct page overhead later?

Struct page do not fit well for GPU as the BAR address can be reprogram
to point to any page inside the device memory (think 256M BAR versus
16GB device memory). Forcing struct page on GPU driver would require
major surgery to the GPU driver inner working and there is no benefit
to have from the struct page. So it is hard to justify this.

Cheers,
J=E9r=F4me
