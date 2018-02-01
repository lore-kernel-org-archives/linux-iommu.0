From: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: Preferred method to detect if a device is behind an enabled iommu.
Date: Thu, 1 Feb 2018 13:25:23 +0000
Message-ID: <20180201132523.00004cac@huawei.com>
References: <20180201101821.00006a16@huawei.com>
	<433fcde8-bcd6-9ab0-ffc5-baf0a6634379@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <433fcde8-bcd6-9ab0-ffc5-baf0a6634379-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 1 Feb 2018 12:49:24 +0000
Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> On 01/02/18 10:18, Jonathan Cameron wrote:
> > Hi All,
> > 
> > We have a crypto accelerator which needs to have a few different settings
> > depending on whether or not the SMMUv3 is enabled and translating addresses
> > or not.
> > 
> > https://marc.info/?l=linux-crypto-vger&m=151732626428206&w=2
> > 
> > 1) A quirk of the hardware revision means we need to turn some elements
> >     off if the iommu is enabled.
> > 2) The device has certain cache related settings that means it needs to know
> >     if it is dealing with VAs or PAs.
> > 
> > Current approach is to see if the iommu_group is set in struct device.
> > 
> > We could fine one instance of another driver doing this and copied that,
> > (drivers/dma/rcar-dmac.c)
> > but the precedence is weak enough that confirmation would be good.
> > So whilst it 'works' the question is whether it is safe in general
> > and whether there is a better way.  
> 
> The presence of a group alone is not sufficient, as it only tells you 
> that the device is associated with an IOMMU in some way (including VFIO 
> no-iommu mode where said IOMMU isn't even real).
> 
> To detect whether translation is active, I think the best way right now 
> would be to first call iommu_get_domain_for_dev() to see whether the 
> device is actually attached to a domain, then if so check the domain 
> type for the __IOMMU_DOMAIN_PAGING flag to confirm if it represents a 
> translation context rather than a bypass one.

Thanks - that works great.

> 
> It might be reasonable to propose wrapping that up in an IOMMU API (or 
> possibly DMA API, as appropriate) helper, as there are certainly other 
> drivers doing various degrees of this sort of thing for various reasons 
> (to the point where we currently have to accommodate rather nonsensical 
> iova_to_phys() calls on identity domains).

Sounds like a good plan but the fun question as ever is what to call it..

iommu_domain_can_map or iommu_domain_is_translating perhaps?

For now I'll just put the check in the driver so we can move forward
in parallel.

Thanks,

Jonathan
> 
> Robin.
