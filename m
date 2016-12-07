From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC v3 09/10] iommu/arm-smmu: Implement reserved region get/put
	callbacks
Date: Wed, 7 Dec 2016 18:24:52 +0000
Message-ID: <5de00158-c82d-6b47-cf64-d4ba0183868d@arm.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
	<1479215363-2898-10-git-send-email-eric.auger@redhat.com>
	<02c0ce15-fa67-e65f-3a4e-f543cc9fd3b8@arm.com>
	<c11755b8-4fb3-3f2f-d0b2-e688a5f8a6b6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c11755b8-4fb3-3f2f-d0b2-e688a5f8a6b6-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/12/16 15:02, Auger Eric wrote:
> Hi Robin,
> On 06/12/2016 19:55, Robin Murphy wrote:
>> On 15/11/16 13:09, Eric Auger wrote:
>>> The get() populates the list with the PCI host bridge windows
>>> and the MSI IOVA range.
>>>
>>> At the moment an arbitray MSI IOVA window is set at 0x8000000
>>> of size 1MB. This will allow to report those info in iommu-group
>>> sysfs?
> 
> 
> First thank you for reviewing the series. This is definitively helpful!
>>>
>>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>
>>> ---
>>>
>>> RFC v2 -> v3:
>>> - use existing get/put_resv_regions
>>>
>>> RFC v1 -> v2:
>>> - use defines for MSI IOVA base and length
>>> ---
>>>  drivers/iommu/arm-smmu.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 52 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 8f72814..81f1a83 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -278,6 +278,9 @@ enum arm_smmu_s2cr_privcfg {
>>>  
>>>  #define FSYNR0_WNR			(1 << 4)
>>>  
>>> +#define MSI_IOVA_BASE			0x8000000
>>> +#define MSI_IOVA_LENGTH			0x100000
>>> +
>>>  static int force_stage;
>>>  module_param(force_stage, int, S_IRUGO);
>>>  MODULE_PARM_DESC(force_stage,
>>> @@ -1545,6 +1548,53 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>>>  	return iommu_fwspec_add_ids(dev, &fwid, 1);
>>>  }
>>>  
>>> +static void arm_smmu_get_resv_regions(struct device *dev,
>>> +				      struct list_head *head)
>>> +{
>>> +	struct iommu_resv_region *region;
>>> +	struct pci_host_bridge *bridge;
>>> +	struct resource_entry *window;
>>> +
>>> +	/* MSI region */
>>> +	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
>>> +					 IOMMU_RESV_MSI);
>>> +	if (!region)
>>> +		return;
>>> +
>>> +	list_add_tail(&region->list, head);
>>> +
>>> +	if (!dev_is_pci(dev))
>>> +		return;
>>> +
>>> +	bridge = pci_find_host_bridge(to_pci_dev(dev)->bus);
>>> +
>>> +	resource_list_for_each_entry(window, &bridge->windows) {
>>> +		phys_addr_t start;
>>> +		size_t length;
>>> +
>>> +		if (resource_type(window->res) != IORESOURCE_MEM &&
>>> +		    resource_type(window->res) != IORESOURCE_IO)
>>
>> As Joerg commented elsewhere, considering anything other than memory
>> resources isn't right (I appreciate you've merely copied my own mistake
>> here). We need some other way to handle root complexes where the CPU
>> MMIO views of PCI windows appear in PCI memory space - using the I/O
>> address of I/O resources only works by chance on Juno, and it still
>> doesn't account for config space. I suggest we just leave that out for
>> the time being to make life easier (does it even apply to anything other
>> than Juno?) and figure it out later.
> OK so I understand I should remove IORESOURCE_IO check.
>>
>>> +			continue;
>>> +
>>> +		start = window->res->start - window->offset;
>>> +		length = window->res->end - window->res->start + 1;
>>> +		region = iommu_alloc_resv_region(start, length,
>>> +						 IOMMU_RESV_NOMAP);
>>> +		if (!region)
>>> +			return;
>>> +		list_add_tail(&region->list, head);
>>> +	}
>>> +}
>>
>> Either way, there's nothing SMMU-specific about PCI windows. The fact
>> that we'd have to copy-paste all of this into the SMMUv3 driver
>> unchanged suggests it should go somewhere common (although I would be
>> inclined to leave the insertion of the fake MSI region to driver-private
>> wrappers). As I said before, the current iova_reserve_pci_windows()
>> simply wants splitting into appropriate public callbacks for
>> get_resv_regions and apply_resv_regions.
> Do you mean somewhere common in the arm-smmu subsystem (new file) or in
> another subsystem (pci?)
> 
> More generally the current implementation does not handle the case where
> any of those PCIe host bridge window collide with the MSI window. To me
> this is a flaw.
> 1) Either we take into account the PCIe windows and prevent any
> collision when allocating the MSI window.
> 2) or we do not care about PCIe host bridge windows at kernel level.

Even more generally, the MSI window also needs to avoid any other
IOMMU-specific reserved regions as well - fortunately I don't think
there's any current intersection between platforms with RMRR-type
reservations and platforms which require MSI mapping - so I think we've
got enough freedom for the moment, but it's certainly an argument in
favour of ultimately expressing PCI windows through the same mechanism
to keep everything in the same place. The other big advantage of
reserved regions is that they will automatically apply to DMA domains as
well.

> If 1) we are back to the original issue of where do we put the MSI
> window. Obviously at a place which might not be QEMU friendly anymore.
> What allocation policy shall we use?
> 
> Second option - sorry I may look stubborn - which I definitively prefer
> and which was also advocated by Alex, we handle PCI host bridge windows
> at user level. MSI window is reported through the iommu group sysfs.
> PCIe host bridge windows can be enumerated through /proc/iomem. Both x86
> iommu and arm smmu would report an MSI reserved window. ARM MSI window
> would become a de facto reserved window for guests.

So from the ABI perspective, the sysfs iommu_group/*/reserved_regions
represents a minimum set of regions (MSI, RMRR, etc.) which definitely
*must* be reserved, but offers no guarantee that there aren't also other
regions not represented there. That seems reasonable to start with, and
still leaves us free to expand the scope of reserved regions in future
without breaking anything.

> Thoughts?

I like the second option too - "grep PCI /proc/iomem" already catches
more than enumerating the resources does (i.e. ECAM space) - and neither
does it preclude growing the more extensive version on top over time.

For the sake of moving forward, I'd be happy with just dropping the PCI
stuff from here, and leaving the SMMU drivers exposing the single
hard-coded MSI region directly (to be fair, it'd hardly be the first
function which is identical between the two). We can take a look into
making iommu-dma implement PCI windows as nomap resv_regions properly as
an orthogonal thing (for the sake of DMA domains), after which we should
be in a position to drop the hard-coding and start placing the MSI
window dynamically where appropriate.

Robin.

>>> +static void arm_smmu_put_resv_regions(struct device *dev,
>>> +				      struct list_head *head)
>>> +{
>>> +	struct iommu_resv_region *entry, *next;
>>> +
>>> +	list_for_each_entry_safe(entry, next, head, list)
>>> +		kfree(entry);
>>> +}
>>> +
>>>  static struct iommu_ops arm_smmu_ops = {
>>>  	.capable		= arm_smmu_capable,
>>>  	.domain_alloc		= arm_smmu_domain_alloc,
>>> @@ -1560,6 +1610,8 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>>>  	.domain_get_attr	= arm_smmu_domain_get_attr,
>>>  	.domain_set_attr	= arm_smmu_domain_set_attr,
>>>  	.of_xlate		= arm_smmu_of_xlate,
>>> +	.get_resv_regions	= arm_smmu_get_resv_regions,
>>> +	.put_resv_regions	= arm_smmu_put_resv_regions,
>>>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>>>  };
>>>  
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
