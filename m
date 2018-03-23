From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v5 7/7] iommu/dma: Move PCI window region reservation
	back into dma specific path.
Date: Fri, 23 Mar 2018 08:57:25 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838679A60@FRAEML521-MBX.china.huawei.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
	<20180315163509.17740-8-shameerali.kolothum.thodi@huawei.com>
	<20180322102148.29afce09@w520.home>
	<3b481ba6-ffdd-fef1-12dc-f5eac8b589d5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3b481ba6-ffdd-fef1-12dc-f5eac8b589d5-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "xuwei (O)" <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, March 22, 2018 5:22 PM
> To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Cc: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; John Garry
> <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; xuwei (O) <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; Joerg Roedel
> <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Subject: Re: [PATCH v5 7/7] iommu/dma: Move PCI window region reservation
> back into dma specific path.
> 
> On 22/03/18 16:21, Alex Williamson wrote:
> > On Thu, 15 Mar 2018 16:35:09 +0000
> > Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
> >
> >> This pretty much reverts commit 273df9635385 ("iommu/dma: Make PCI
> >> window reservation generic")  by moving the PCI window region
> >> reservation back into the dma specific path so that these regions
> >> doesn't get exposed via the IOMMU API interface. With this change,
> >> the vfio interface will report only iommu specific reserved regions
> >> to the user space.
> >>
> >> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> >> Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> >> ---
> >
> > As currently ordered, we expose the iova list to the user in 5/7 with
> > the PCI window reservations still intact.  Isn't that a bisection
> > problem?  This patch should come before the iova list is expose to the
> > user.  This is otherwise independent, so I can pop it up in the stack on
> > commit, but I'd need an ack from Joerg and Robin to take it via my
> > tree.  Thanks,
> 
> If it counts, the changes look right, so:
> 
> Acked-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Thanks Robin.
 
> but it does look like there's a hard dependency on Joerg's core branch
> where Shameer's ITS workaround patches are currently queued. Otherwise,
> though, I don't think there's anything else due to be touching iommu-dma
> just yet.

True, I have mentioned this dependency[1] in the cover letter.

Thanks,
Shameer

1. https://kernel.googlesource.com/pub/scm/linux/kernel/git/joro/iommu/+log/core


> Robin.
> 
> >
> > Alex
> >
> >>   drivers/iommu/dma-iommu.c | 54 ++++++++++++++++++++++-----------------
> --------
> >>   1 file changed, 25 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> >> index f05f3cf..ddcbbdb 100644
> >> --- a/drivers/iommu/dma-iommu.c
> >> +++ b/drivers/iommu/dma-iommu.c
> >> @@ -167,40 +167,16 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
> >>    * @list: Reserved region list from iommu_get_resv_regions()
> >>    *
> >>    * IOMMU drivers can use this to implement their .get_resv_regions
> callback
> >> - * for general non-IOMMU-specific reservations. Currently, this covers host
> >> - * bridge windows for PCI devices and GICv3 ITS region reservation on ACPI
> >> - * based ARM platforms that may require HW MSI reservation.
> >> + * for general non-IOMMU-specific reservations. Currently, this covers
> GICv3
> >> + * ITS region reservation on ACPI based ARM platforms that may require
> HW MSI
> >> + * reservation.
> >>    */
> >>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head
> *list)
> >>   {
> >> -	struct pci_host_bridge *bridge;
> >> -	struct resource_entry *window;
> >> -
> >> -	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
> >> -		iort_iommu_msi_get_resv_regions(dev, list) < 0)
> >> -		return;
> >> -
> >> -	if (!dev_is_pci(dev))
> >> -		return;
> >> -
> >> -	bridge = pci_find_host_bridge(to_pci_dev(dev)->bus);
> >> -	resource_list_for_each_entry(window, &bridge->windows) {
> >> -		struct iommu_resv_region *region;
> >> -		phys_addr_t start;
> >> -		size_t length;
> >> -
> >> -		if (resource_type(window->res) != IORESOURCE_MEM)
> >> -			continue;
> >>
> >> -		start = window->res->start - window->offset;
> >> -		length = window->res->end - window->res->start + 1;
> >> -		region = iommu_alloc_resv_region(start, length, 0,
> >> -				IOMMU_RESV_RESERVED);
> >> -		if (!region)
> >> -			return;
> >> +	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode))
> >> +		iort_iommu_msi_get_resv_regions(dev, list);
> >>
> >> -		list_add_tail(&region->list, list);
> >> -	}
> >>   }
> >>   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> >>
> >> @@ -229,6 +205,23 @@ static int cookie_init_hw_msi_region(struct
> iommu_dma_cookie *cookie,
> >>   	return 0;
> >>   }
> >>
> >> +static void iova_reserve_pci_windows(struct pci_dev *dev,
> >> +		struct iova_domain *iovad)
> >> +{
> >> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> >> +	struct resource_entry *window;
> >> +	unsigned long lo, hi;
> >> +
> >> +	resource_list_for_each_entry(window, &bridge->windows) {
> >> +		if (resource_type(window->res) != IORESOURCE_MEM)
> >> +			continue;
> >> +
> >> +		lo = iova_pfn(iovad, window->res->start - window->offset);
> >> +		hi = iova_pfn(iovad, window->res->end - window->offset);
> >> +		reserve_iova(iovad, lo, hi);
> >> +	}
> >> +}
> >> +
> >>   static int iova_reserve_iommu_regions(struct device *dev,
> >>   		struct iommu_domain *domain)
> >>   {
> >> @@ -238,6 +231,9 @@ static int iova_reserve_iommu_regions(struct device
> *dev,
> >>   	LIST_HEAD(resv_regions);
> >>   	int ret = 0;
> >>
> >> +	if (dev_is_pci(dev))
> >> +		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
> >> +
> >>   	iommu_get_resv_regions(dev, &resv_regions);
> >>   	list_for_each_entry(region, &resv_regions, list) {
> >>   		unsigned long lo, hi;
> >
