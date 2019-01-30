From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 12:48:33 -0700
Message-ID: <3793c115-2451-1479-29a9-04bed2831e4b@deltatee.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
	<20190129174728.6430-4-jglisse@redhat.com>
	<ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
	<20190129191120.GE3176@redhat.com>
	<20190129193250.GK10108@mellanox.com>
	<99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
	<20190129205827.GM10108@mellanox.com> <20190130080208.GC29665@lst.de>
	<20190130174424.GA17080@mellanox.com>
	<bcbdfae6-cfc6-c34f-4ff2-7bb9a08f38af@deltatee.com>
	<20190130191946.GD17080@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190130191946.GD17080-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
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



On 2019-01-30 12:19 p.m., Jason Gunthorpe wrote:
> On Wed, Jan 30, 2019 at 11:13:11AM -0700, Logan Gunthorpe wrote:
>>
>>
>> On 2019-01-30 10:44 a.m., Jason Gunthorpe wrote:
>>> I don't see why a special case with a VMA is really that different.
>>
>> Well one *really* big difference is the VMA changes necessarily expose
>> specialized new functionality to userspace which has to be supported
>> forever and may be difficult to change. 
> 
> The only user change here is that more things will succeed when
> creating RDMA MRs (and vice versa to GPU). I don't think this
> restricts the kernel implementation at all, unless we intend to
> remove P2P entirely..

Well for MRs I'd expect you are using struct pages to track the memory
some how.... VMAs that aren't backed by pages and use this special
interface must therefore be creating new special interfaces that can
call p2p_[un]map...

I'd much rather see special cases around struct page so we can find ways
to generalize it in the future than create special cases tied to random
userspace interfaces.

Logan
