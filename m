From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 20:50:00 +0000
Message-ID: <20190130204954.GI17080@mellanox.com>
References: <20190129234752.GR3176@redhat.com>
	<655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
	<20190130041841.GB30598@mellanox.com>
	<bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
	<20190130185652.GB17080@mellanox.com>
	<20190130192234.GD5061@redhat.com>
	<20190130193759.GE17080@mellanox.com>
	<db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
	<20190130201114.GB17915@mellanox.com>
	<20190130204332.GF5061@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190130204332.GF5061-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <5026D2D732A5D3409D2B6B23F246B7D1-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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

On Wed, Jan 30, 2019 at 03:43:32PM -0500, Jerome Glisse wrote:
> On Wed, Jan 30, 2019 at 08:11:19PM +0000, Jason Gunthorpe wrote:
> > On Wed, Jan 30, 2019 at 01:00:02PM -0700, Logan Gunthorpe wrote:
> > 
> > > We never changed SGLs. We still use them to pass p2pdma pages, only we
> > > need to be a bit careful where we send the entire SGL. I see no reason
> > > why we can't continue to be careful once their in userspace if there's
> > > something in GUP to deny them.
> > > 
> > > It would be nice to have heterogeneous SGLs and it is something we
> > > should work toward but in practice they aren't really necessary at the
> > > moment.
> > 
> > RDMA generally cannot cope well with an API that requires homogeneous
> > SGLs.. User space can construct complex MRs (particularly with the
> > proposed SGL MR flow) and we must marshal that into a single SGL or
> > the drivers fall apart.
> > 
> > Jerome explained that GPU is worse, a single VMA may have a random mix
> > of CPU or device pages..
> > 
> > This is a pretty big blocker that would have to somehow be fixed.
> 
> Note that HMM takes care of that RDMA ODP with my ODP to HMM patch,
> so what you get for an ODP umem is just a list of dma address you
> can program your device to. The aim is to avoid the driver to care
> about that. The access policy when the UMEM object is created by
> userspace through verbs API should however ascertain that for mmap
> of device file it is only creating a UMEM that is fully covered by
> one and only one vma. GPU device driver will have one vma per logical
> GPU object. I expect other kind of device do that same so that they
> can match a vma to a unique object in their driver.

A one VMA rule is not really workable.

With ODP VMA boundaries can move around across the lifetime of the MR
and we have no obvious way to fail anything if userpace puts a VMA
boundary in the middle of an existing ODP MR address range.

I think the HMM mirror API really needs to deal with this for the
driver somehow.

Jason
