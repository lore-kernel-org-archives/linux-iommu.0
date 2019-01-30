From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 14:01:35 -0700
Message-ID: <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
References: <20190129205749.GN3176@redhat.com>
	<2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
	<20190129215028.GQ3176@redhat.com>
	<deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
	<20190129234752.GR3176@redhat.com>
	<655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
	<20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
	<20190130190651.GC17080@mellanox.com>
	<840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
	<20190130195900.GG17080@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190130195900.GG17080-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
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



On 2019-01-30 12:59 p.m., Jason Gunthorpe wrote:
> On Wed, Jan 30, 2019 at 12:45:46PM -0700, Logan Gunthorpe wrote:
>>
>>
>> On 2019-01-30 12:06 p.m., Jason Gunthorpe wrote:
>>>> Way less problems than not having struct page for doing anything
>>>> non-trivial.  If you map the BAR to userspace with remap_pfn_range
>>>> and friends the mapping is indeed very simple.  But any operation
>>>> that expects a page structure, which is at least everything using
>>>> get_user_pages won't work.
>>>
>>> GUP doesn't work anyhow today, and won't work with BAR struct pages in
>>> the forseeable future (Logan has sent attempts on this before).
>>
>> I don't recall ever attempting that... But patching GUP for special
>> pages or VMAS; or working around by not calling it in some cases seems
>> like the thing that's going to need to be done one way or another.
> 
> Remember, the long discussion we had about how to get the IOMEM
> annotation into SGL? That is a necessary pre-condition to doing
> anything with GUP in DMA using drivers as GUP -> SGL -> DMA map is
> pretty much the standard flow.

Yes, but that was unrelated to GUP even if that might have been the
eventual direction.

And I feel the GUP->SGL->DMA flow should still be what we are aiming
for. Even if we need a special GUP for special pages, and a special DMA
map; and the SGL still has to be homogenous....

> So, I see Jerome solving the GUP problem by replacing GUP entirely
> using an API that is more suited to what these sorts of drivers
> actually need.

Yes, this is what I'm expecting and what I want. Not bypassing the whole
thing by doing special things with VMAs.

Logan
