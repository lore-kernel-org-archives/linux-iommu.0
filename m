From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 22:51:55 +0000
Message-ID: <20190130225148.GC25486@mellanox.com>
References: <20190130193759.GE17080@mellanox.com>
	<db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
	<20190130201114.GB17915@mellanox.com>
	<20190130204332.GF5061@redhat.com>
	<20190130204954.GI17080@mellanox.com>
	<20190130214525.GG5061@redhat.com>
	<20190130215600.GM17080@mellanox.com>
	<20190130223027.GH5061@redhat.com>
	<20190130223258.GB25486@mellanox.com>
	<20190130224705.GI5061@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190130224705.GI5061-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <35A69DD96A70BF4186715D7C3E6F4417-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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

On Wed, Jan 30, 2019 at 05:47:05PM -0500, Jerome Glisse wrote:
> On Wed, Jan 30, 2019 at 10:33:04PM +0000, Jason Gunthorpe wrote:
> > On Wed, Jan 30, 2019 at 05:30:27PM -0500, Jerome Glisse wrote:
> > 
> > > > What is the problem in the HMM mirror that it needs this restriction?
> > > 
> > > No restriction at all here. I think i just wasn't understood.
> > 
> > Are you are talking about from the exporting side - where the thing
> > creating the VMA can really only put one distinct object into it?
> 
> The message i was trying to get accross is that HMM mirror will
> always succeed for everything* except for special vma ie mmap of
> device file. For those it can only succeed if a p2p_map() call
> succeed.
> 
> So any user of HMM mirror might to know why the mirroring fail ie
> was it because something exceptional is happening ? Or is it because
> i was trying to map a special vma which can be forbiden.
> 
> Hence why i assume that you might want to know about such p2p_map
> failure at the time you create the umem odp object as it might be
> some failure you might want to report differently and handle
> differently. If you do not care about differentiating OOM or
> exceptional failure from p2p_map failure than you have nothing to
> worry about you will get the same error from HMM for both.

I think my hope here was that we could have some kind of 'trial'
interface where very eary users can call
'hmm_mirror_is_maybe_supported(dev, user_ptr, len)' and get a failure
indication.

We probably wouldn't call this on the full address space though

Beyond that it is just inevitable there can be problems faulting if
the memory map is messed with after MR is created.

And here again, I don't want to worry about any particular VMA
boundaries..

Jason
