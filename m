From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
	erratum 161010801
Date: Tue, 5 Sep 2017 12:07:59 +0100
Message-ID: <9a999fd4-3ade-f7a4-56d7-68ed731ff646@huawei.com>
References: <20170809100715.870516-1-shameerali.kolothum.thodi@huawei.com>
	<20170809100715.870516-4-shameerali.kolothum.thodi@huawei.com>
	<20170810172723.GD9980@arm.com>
	<47b8bf19-abad-3503-2e1c-b9d1304a157e@huawei.com>
	<20170904170928.GB20601@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170904170928.GB20601@red-moon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

>>
>> Hi Will, Lorenzo, Robin,
>>
>> I have created the patch to add DT support for this erratum.
>> However, currently I have only added support for pci-based devices.
>> I'm a bit stumped on how to add platform device support, or if we
>> should also add support at all. And I would rather ask before
>> sending the patches.
>>
>> The specific issue is that I know of no platform device with an ITS
>> msi-parent which we would want reserve, i.e. do not translate msi.
>> And, if there were, how to do it.
>>
>> The only platform devices I know off with msi ITS parents are SMMUv3
>> and mbigen. For mbigen, the msi are not translated. Actually, as I
>> see under IORT solution, for mbigen we don't reserve the hw msi
>> region as the SMMUv3 does not have an ID mapping. And we have no
>> equivalent ID mapping property for DT SMMUv3, so cannot create an
>> equivalent check.
>>
>> So here is how the DT iommu get reserved region function with only
>> pci device support looks:
>>
>> /**
>>  * of_iommu_its_get_resv_regions - Reserved region driver helper
>>  * @dev: Device from iommu_get_resv_regions()
>>  * @list: Reserved region list from iommu_get_resv_regions()
>>  *
>>  * Returns: Number of reserved regions on success(0 if no associated ITS),
>>  *          appropriate error value otherwise.
>>  */
>> int of_iommu_its_get_resv_regions(struct device *dev, struct
>> list_head *head)
>> {
>>     struct device_node *of_node = NULL;
>>     struct device *parent_dev;
>>     const __be32 *msi_map;
>>     int num_mappings, i, err, len, resv = 0;
>>
>>     /* walk up to find the parent with a msi-map property */
>>     for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
>>         if (!parent_dev->of_node)
>>             continue;
>>
>>         /*
>>          * Current logic to reserve ITS regions for only PCI root
>>          * complex.
>>          */
>>         msi_map = of_get_property(parent_dev->of_node, "msi-map", &len);
>>         if (msi_map) {
>>             of_node = parent_dev->of_node;
>>             break;
>>         }
>>     }
>>
>>     if (!of_node)
>>         return 0;
>>
>>     num_mappings = of_count_phandle_with_args(of_node, "msi-map",
>> NULL) / 4;
>>
>>     for (i = 0; i < num_mappings; i++) {
>>         int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>>         struct iommu_resv_region *region;
>>         struct device_node *msi_node;
>>         struct resource resource;
>>         u32 phandle;
>>
>>         phandle = be32_to_cpup(msi_map + 1);
>>         msi_node = of_find_node_by_phandle(phandle);
>>         if (!msi_node)
>>             return -ENODEV;
>>
>>         /*
>>          * There may be different types of msi-controller, so check
>>          * for ITS.
>>          */
>>         if (!of_device_is_compatible(msi_node, "arm,gic-v3-its")) {
>>             of_node_put(msi_node);
>>             continue;
>>         }
>>
>>         err = of_address_to_resource(msi_node, 0, &resource);
>>
>>         of_node_put(msi_node);
>>         if (err)
>>             return err;
>>
>>         region = iommu_alloc_resv_region(resource.start, SZ_128K, prot,
>>                          IOMMU_RESV_MSI);
>>         if (region) {
>>             list_add_tail(&region->list, head);
>>             resv++;
>>         }
>>     }
>>
>>     return (resv == num_mappings) ? resv : -ENODEV;
>> }
>>
>> Any feedback is appreciated.
>
> Hi John,
>
> I appreciate it is not trivial to make the code generic, part of the
> snippet above can be shared between ACPI/IORT and OF, the only sticking
> point is probably the "compatible" string that has to be parameterized
> since having this code in generic IOMMU layer is a bit horrible to
> have it ITS specific (and it is a problem that was existing already
> in the original patch with the hardcoded ITS node type or function
> name).

Hi Lorenzo,

Agreed, checking the ITS compatible string in IOMMU code is not nice. 
However the function is just trying to replicate our ACPI version, which 
calls IORT code directly, and this is ITS specific. Anyway, we can make 
it generic.

>
> To sum it up the hook:
>
> - has to be called from SMMU driver in a firmware agnostic way

ok

> - somehow it has to ascertain which interrupt controller "compatible"
>   (which in IORT is a node type) to match against so the hook has to
>   take an id of sorts

OK

I will mention 2 more points after discussion on OF solution with Shameer:
- for platform device, we can add suppport by checking for the devices 
msi-parent property
- for both pci and platform device, we should check device rid for 
msi-controller also, like IORT solution

BTW, even though merge window is open, we would like to send some 
solution to the lists this week, so any outstanding topics can 
potentially be discussed at LPC next week. Let me know if you're unhappy 
about this.

All the best,
John


>
> I need to go back and have a look at the original patch to see how
> we can accommodate both OF/ACPI - certainly the region reservations
> code can and should be shared.
>
> Lorenzo
>
> .
>
