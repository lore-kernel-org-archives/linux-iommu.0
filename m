From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 3/5] iommu/of: Add msi address regions reservation
 helper
Date: Wed, 4 Oct 2017 14:50:07 +0100
Message-ID: <20171004135007.GA12327@red-moon>
References: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
 <20170927133241.21036-4-shameerali.kolothum.thodi@huawei.com>
 <f3146f49-6004-7a15-866b-653e3ea54856@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f3146f49-6004-7a15-866b-653e3ea54856-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, sudeep.holla-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 04, 2017 at 12:22:04PM +0100, Marc Zyngier wrote:
> On 27/09/17 14:32, Shameer Kolothum wrote:
> > From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > 
> > On some platforms msi-controller address regions have to be excluded
> > from normal IOVA allocation in that they are detected and decoded in
> > a HW specific way by system components and so they cannot be considered
> > normal IOVA address space.
> > 
> > Add a helper function that retrieves msi address regions through device
> > tree msi mapping, so that these regions will not be translated by IOMMU
> > and will be excluded from IOVA allocations.
> > 
> > Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > [Shameer: Modified msi-parent retrieval logic]
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/of_iommu.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/of_iommu.h | 10 +++++
> >  2 files changed, 105 insertions(+)
> > 
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index e60e3db..ffd7fb7 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/limits.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_iommu.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/slab.h>
> > @@ -138,6 +139,14 @@ static int of_iommu_xlate(struct device *dev,
> >  	return ops->of_xlate(dev, iommu_spec);
> >  }
> >  
> > +static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> > +{
> > +	u32 *rid = data;
> > +
> > +	*rid = alias;
> > +	return 0;
> > +}
> > +
> >  struct of_pci_iommu_alias_info {
> >  	struct device *dev;
> >  	struct device_node *np;
> > @@ -163,6 +172,73 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
> >  	return info->np == pdev->bus->dev.of_node;
> >  }
> >  
> > +static int of_iommu_alloc_resv_region(struct device_node *np,
> > +				      struct list_head *head)
> > +{
> > +	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > +	struct iommu_resv_region *region;
> > +	struct resource res;
> > +	int err;
> > +
> > +	err = of_address_to_resource(np, 0, &res);
> 
> What is the rational for registering the first region only? Surely you
> can have more than one region in an MSI controller (yes, your particular
> case is the ITS which has only one, but we're trying to do something
> generic here).
> 
> Another issue I have with this code is that it inserts all of the ITS
> MMIO in the RESV_MSI range. As long as we don't generate any page tables
> for this, we're fine. But if we ever change this, we'll end-up with the
> ITS programming interface being exposed to a device, which wouldn't be
> acceptable.
> 
> Why can't we have some generic property instead, that would describe the
> actual ranges that cannot be translated? That way, no random insertion
> of a random range, and relatively future proof.

IORT code has the same issue (ie it reserves all ITS regions) and I do
not know where a property can be added to describe those ranges (IORT
specs ? I'd rather not) in ACPI other than the IORT tables entries
themselves.

> I'm not sure where to declare it (PCIe node? IOMMU node?), but it'd feel
> like a much nicer and simpler solution to this problem.

It could be but if we throw ACPI into the picture we have to knock
together Hisilicon specific namespace bindings to handle this and
quickly.

Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
