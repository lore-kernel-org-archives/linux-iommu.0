From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 3/5] iommu/of: Add msi address regions reservation
 helper
Date: Thu, 5 Oct 2017 12:57:19 +0100
Message-ID: <20171005115719.GC11088@arm.com>
References: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
 <20170927133241.21036-4-shameerali.kolothum.thodi@huawei.com>
 <f3146f49-6004-7a15-866b-653e3ea54856@arm.com>
 <20171004135007.GA12327@red-moon>
 <5c80f292-dc5d-a1c6-d7a0-df2a84cc77d1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5c80f292-dc5d-a1c6-d7a0-df2a84cc77d1-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, sudeep.holla-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 05, 2017 at 12:07:26PM +0100, Robin Murphy wrote:
> On 04/10/17 14:50, Lorenzo Pieralisi wrote:
> > On Wed, Oct 04, 2017 at 12:22:04PM +0100, Marc Zyngier wrote:
> >> On 27/09/17 14:32, Shameer Kolothum wrote:
> >>> From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> >>>
> >>> On some platforms msi-controller address regions have to be excluded
> >>> from normal IOVA allocation in that they are detected and decoded in
> >>> a HW specific way by system components and so they cannot be considered
> >>> normal IOVA address space.
> >>>
> >>> Add a helper function that retrieves msi address regions through device
> >>> tree msi mapping, so that these regions will not be translated by IOMMU
> >>> and will be excluded from IOVA allocations.
> >>>
> >>> Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> >>> [Shameer: Modified msi-parent retrieval logic]
> >>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> >>> ---
> >>>  drivers/iommu/of_iommu.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>>  include/linux/of_iommu.h | 10 +++++
> >>>  2 files changed, 105 insertions(+)
> >>>
> >>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> >>> index e60e3db..ffd7fb7 100644
> >>> --- a/drivers/iommu/of_iommu.c
> >>> +++ b/drivers/iommu/of_iommu.c
> >>> @@ -21,6 +21,7 @@
> >>>  #include <linux/iommu.h>
> >>>  #include <linux/limits.h>
> >>>  #include <linux/of.h>
> >>> +#include <linux/of_address.h>
> >>>  #include <linux/of_iommu.h>
> >>>  #include <linux/of_pci.h>
> >>>  #include <linux/slab.h>
> >>> @@ -138,6 +139,14 @@ static int of_iommu_xlate(struct device *dev,
> >>>  	return ops->of_xlate(dev, iommu_spec);
> >>>  }
> >>>  
> >>> +static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> >>> +{
> >>> +	u32 *rid = data;
> >>> +
> >>> +	*rid = alias;
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  struct of_pci_iommu_alias_info {
> >>>  	struct device *dev;
> >>>  	struct device_node *np;
> >>> @@ -163,6 +172,73 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
> >>>  	return info->np == pdev->bus->dev.of_node;
> >>>  }
> >>>  
> >>> +static int of_iommu_alloc_resv_region(struct device_node *np,
> >>> +				      struct list_head *head)
> >>> +{
> >>> +	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> >>> +	struct iommu_resv_region *region;
> >>> +	struct resource res;
> >>> +	int err;
> >>> +
> >>> +	err = of_address_to_resource(np, 0, &res);
> >>
> >> What is the rational for registering the first region only? Surely you
> >> can have more than one region in an MSI controller (yes, your particular
> >> case is the ITS which has only one, but we're trying to do something
> >> generic here).
> >>
> >> Another issue I have with this code is that it inserts all of the ITS
> >> MMIO in the RESV_MSI range. As long as we don't generate any page tables
> >> for this, we're fine. But if we ever change this, we'll end-up with the
> >> ITS programming interface being exposed to a device, which wouldn't be
> >> acceptable.
> >>
> >> Why can't we have some generic property instead, that would describe the
> >> actual ranges that cannot be translated? That way, no random insertion
> >> of a random range, and relatively future proof.
> 
> Indeed. Furthermore, IORT has the advantage of being limited to a few
> distinct device types and SBSA-compliant system topologies, so the
> ITS-chasing is reasonable there (modulo only reserving GITS_TRANSLATER).
> The scope of DT covers more embedded things as well like PCI host
> controllers with internal MSI doorbells, and potentially even
> direct-mapped memory regions for things like bootloader framebuffers to
> prevent display glitches - a generic address/size/flags description of a
> region could work for just about everything.
> 
> > IORT code has the same issue (ie it reserves all ITS regions) and I do
> > not know where a property can be added to describe those ranges (IORT
> > specs ? I'd rather not) in ACPI other than the IORT tables entries
> > themselves.
> > 
> >> I'm not sure where to declare it (PCIe node? IOMMU node?), but it'd feel
> >> like a much nicer and simpler solution to this problem.
> > 
> > It could be but if we throw ACPI into the picture we have to knock
> > together Hisilicon specific namespace bindings to handle this and
> > quickly.
> 
> As above I'm happy with the ITS-specific solution for ACPI given the
> limits of IORT. What I had in mind for DT was something tied in with the
> generic IOMMU bindings. Something like this is probably easiest to
> handle, but does rather spread the information around:
> 
> 
>   pci {
>   	...
>   	iommu-map = <0 0 &iommu1 0x10000>;
>   	iommu-reserved-ranges = <0x12340000 0x1000 IOMMU_MSI>,
>   				<0x34560000 0x1000 IOMMU_MSI>;
>   };
> 
>   display {
>   	...
>   	iommus = <&iommu1 0x20000>;
>   	/* simplefb region */
>   	iommu-reserved-ranges = <0x80080000 0x80000 IOMMU_DIRECT>,
>   };
> 
> 
> Alternatively, something inspired by reserved-memory might perhaps be
> conceptually neater, at the risk of being more complicated:
> 
> 
>   iommu1: iommu@acbd0000 {
>   	...
>   	#iommu-cells = <1>;
> 
>   	iommu-reserved-ranges {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> 
> 		its0_resv: msi@12340000 {
>   			compatible = "iommu-msi-region";
>   			reg = <0x12340000 0x1000>;
>   		};
> 
> 		its1_resv: msi@34560000 {
>   			compatible = "iommu-msi-region";
>   			reg = <0x34560000 0x1000>;
>   		};
> 
> 		fb_resv: direct@12340000 {
>   			compatible = "iommu-direct-region";
>   			reg = <0x80080000 0x80000>;
>   		};
>   	};
>   };

I like the locality of this, but is it definitely flexible enough? Do we
need to deal with systems where the reserved regions are specific to the
master (i.e. TBU) as opposed to the entire SMMU block?

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
