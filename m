From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 19:59:05 +0000
Message-ID: <20190130195900.GG17080@mellanox.com>
References: <20190129205749.GN3176@redhat.com>
	<2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
	<20190129215028.GQ3176@redhat.com>
	<deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
	<20190129234752.GR3176@redhat.com>
	<655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
	<20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
	<20190130190651.GC17080@mellanox.com>
	<840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <840256f8-0714-5d7d-e5f5-c96aec5c2c05-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Content-ID: <178449172A1D534BBB231D50EE6C616B-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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

On Wed, Jan 30, 2019 at 12:45:46PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-30 12:06 p.m., Jason Gunthorpe wrote:
> >> Way less problems than not having struct page for doing anything
> >> non-trivial.  If you map the BAR to userspace with remap_pfn_range
> >> and friends the mapping is indeed very simple.  But any operation
> >> that expects a page structure, which is at least everything using
> >> get_user_pages won't work.
> > 
> > GUP doesn't work anyhow today, and won't work with BAR struct pages in
> > the forseeable future (Logan has sent attempts on this before).
> 
> I don't recall ever attempting that... But patching GUP for special
> pages or VMAS; or working around by not calling it in some cases seems
> like the thing that's going to need to be done one way or another.

Remember, the long discussion we had about how to get the IOMEM
annotation into SGL? That is a necessary pre-condition to doing
anything with GUP in DMA using drivers as GUP -> SGL -> DMA map is
pretty much the standard flow.
 
> > Jerome made the HMM mirror API use this flow, so afer his patch to
> > switch the ODP MR to use HMM, and to switch GPU drivers, it will work
> > for those cases. Which is more than the zero cases than we have today
> > :)
> 
> But we're getting the same bait and switch here... If you are using HMM
> you are using struct pages, but we're told we need this special VMA hack
> for cases that don't use HMM and thus don't have struct pages...

Well, I don't know much about HMM, but the HMM mirror API looks like a
version of MMU notifiers that offloads a bunch of dreck to the HMM
code core instead of drivers. The RDMA code got hundreds of lines
shorter by using it.

Some of that dreck is obtaining a DMA address for the user VMAs,
including using multiple paths to get them. A driver using HMM mirror
doesn't seem to call GUP at all, HMM mirror handles that, along with
various special cases, including calling out to these new VMA ops.

I don't really know how mirror relates to other parts of HMM, like the
bits that use struct pages. Maybe it also knows about more special
cases created by other parts of HMM?

So, I see Jerome solving the GUP problem by replacing GUP entirely
using an API that is more suited to what these sorts of drivers
actually need.

Jason
