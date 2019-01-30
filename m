From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 21:56:07 +0000
Message-ID: <20190130215600.GM17080@mellanox.com>
References: <20190130041841.GB30598@mellanox.com>
	<bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
	<20190130185652.GB17080@mellanox.com>
	<20190130192234.GD5061@redhat.com>
	<20190130193759.GE17080@mellanox.com>
	<db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
	<20190130201114.GB17915@mellanox.com>
	<20190130204332.GF5061@redhat.com>
	<20190130204954.GI17080@mellanox.com>
	<20190130214525.GG5061@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190130214525.GG5061-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <C7D277F6F0DABE4DB953023632447B07-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "Rafael J . Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 04:45:25PM -0500, Jerome Glisse wrote:
> On Wed, Jan 30, 2019 at 08:50:00PM +0000, Jason Gunthorpe wrote:
> > On Wed, Jan 30, 2019 at 03:43:32PM -0500, Jerome Glisse wrote:
> > > On Wed, Jan 30, 2019 at 08:11:19PM +0000, Jason Gunthorpe wrote:
> > > > On Wed, Jan 30, 2019 at 01:00:02PM -0700, Logan Gunthorpe wrote:
> > > > 
> > > > > We never changed SGLs. We still use them to pass p2pdma pages, only we
> > > > > need to be a bit careful where we send the entire SGL. I see no reason
> > > > > why we can't continue to be careful once their in userspace if there's
> > > > > something in GUP to deny them.
> > > > > 
> > > > > It would be nice to have heterogeneous SGLs and it is something we
> > > > > should work toward but in practice they aren't really necessary at the
> > > > > moment.
> > > > 
> > > > RDMA generally cannot cope well with an API that requires homogeneous
> > > > SGLs.. User space can construct complex MRs (particularly with the
> > > > proposed SGL MR flow) and we must marshal that into a single SGL or
> > > > the drivers fall apart.
> > > > 
> > > > Jerome explained that GPU is worse, a single VMA may have a random mix
> > > > of CPU or device pages..
> > > > 
> > > > This is a pretty big blocker that would have to somehow be fixed.
> > > 
> > > Note that HMM takes care of that RDMA ODP with my ODP to HMM patch,
> > > so what you get for an ODP umem is just a list of dma address you
> > > can program your device to. The aim is to avoid the driver to care
> > > about that. The access policy when the UMEM object is created by
> > > userspace through verbs API should however ascertain that for mmap
> > > of device file it is only creating a UMEM that is fully covered by
> > > one and only one vma. GPU device driver will have one vma per logical
> > > GPU object. I expect other kind of device do that same so that they
> > > can match a vma to a unique object in their driver.
> > 
> > A one VMA rule is not really workable.
> > 
> > With ODP VMA boundaries can move around across the lifetime of the MR
> > and we have no obvious way to fail anything if userpace puts a VMA
> > boundary in the middle of an existing ODP MR address range.
> 
> This is true only for vma that are not mmap of a device file. This is
> what i was trying to get accross. An mmap of a file is never merge
> so it can only get split/butcher by munmap/mremap but when that happen
> you also need to reflect the virtual address space change to the
> device ie any access to a now invalid range must trigger error.

Why is it invalid? The address range still has valid process memory?

What is the problem in the HMM mirror that it needs this restriction?

There is also the situation where we create an ODP MR that spans 0 ->
U64_MAX in the process address space. In this case there are lots of
different VMAs it covers and we expect it to fully track all changes
to all VMAs.

So we have to spin up dedicated umem_odps that carefully span single
VMAs, and somehow track changes to VMA ?

mlx5 odp does some of this already.. But yikes, this needs some pretty
careful testing in all these situations.

> > I think the HMM mirror API really needs to deal with this for the
> > driver somehow.
> 
> Yes the HMM does deal with this for you, you do not have to worry about
> it. Sorry if that was not clear. I just wanted to stress that vma that
> are mmap of a file do not behave like other vma hence when you create
> the UMEM you can check for those if you feel the need.

What properties do we get from HMM mirror? Will it tell us when to
create more umems to cover VMA seams or will it just cause undesired
no-mapped failures in some cases?

Jason
