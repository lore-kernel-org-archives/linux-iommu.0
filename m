From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 1/2] acpi:iort: Add an IORT helper function to reserve
 HW ITS address regions for IOMMU drivers
Date: Thu, 27 Jul 2017 12:13:21 +0100
Message-ID: <989fec76-45e7-d744-3411-78ec2764cb7d@arm.com>
References: <20170725111732.41792-1-shameerali.kolothum.thodi@huawei.com>
 <20170725111732.41792-2-shameerali.kolothum.thodi@huawei.com>
 <20170725171100.GA1663@red-moon>
 <b7512f89-4fe7-940e-0fa9-9274d8b1e935@arm.com>
 <20170726095208.GA2468@red-moon>
 <5FC3163CFD30C246ABAA99954A238FA8383C0268@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8383C0268@FRAEML521-MBX.china.huawei.com>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, John Garry <john.garry@huawei.com>, "will.deacon@arm.com" <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: iommu@lists.linux-foundation.org

On 27/07/17 10:13, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
>> Sent: Wednesday, July 26, 2017 10:52 AM
>> To: Robin Murphy
>> Cc: Shameerali Kolothum Thodi; marc.zyngier@arm.com;
>> sudeep.holla@arm.com; will.deacon@arm.com; hanjun.guo@linaro.org;
>> Gabriele Paoloni; John Garry; iommu@lists.linux-foundation.org; linux-arm-
>> kernel@lists.infradead.org; linux-acpi@vger.kernel.org; devel@acpica.org;
>> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
>> Subject: Re: [PATCH v4 1/2] acpi:iort: Add an IORT helper function to reserve
>> HW ITS address regions for IOMMU drivers
>>
>> On Tue, Jul 25, 2017 at 06:32:40PM +0100, Robin Murphy wrote:
>>> On 25/07/17 18:11, Lorenzo Pieralisi wrote:
>>>> On Tue, Jul 25, 2017 at 12:17:31PM +0100, Shameer Kolothum wrote:
>>>>> The helper function retrieves ITS address regions through IORT
>>>>> device <-> ITS mappings and reserves it so that these regions
>>>>> will not be translated by IOMMU and will be excluded from IOVA
>>>>> allocations. IOMMU drivers can use this to implement their
>>>>> .get_resv_regions callback.
>>>>>
>>>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>>>> ---
>>>>>  drivers/acpi/arm64/iort.c        | 91
>> ++++++++++++++++++++++++++++++++++++++--
>>>>>  drivers/irqchip/irq-gic-v3-its.c |  3 +-
>>>>>  include/linux/acpi_iort.h        |  8 +++-
>>>>>  3 files changed, 97 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>>> index a3215ee..e28f30c 100644
>>>>> --- a/drivers/acpi/arm64/iort.c
>>>>> +++ b/drivers/acpi/arm64/iort.c
>>>>> @@ -39,6 +39,7 @@
>>>>>  struct iort_its_msi_chip {
>>>>>  	struct list_head	list;
>>>>>  	struct fwnode_handle	*fw_node;
>>>>> +	phys_addr_t		base_addr;
>>>>>  	u32			translation_id;
>>>>>  };
>>>>>
>>>>> @@ -136,14 +137,16 @@ typedef acpi_status
>> (*iort_find_node_callback)
>>>>>  static DEFINE_SPINLOCK(iort_msi_chip_lock);
>>>>>
>>>>>  /**
>>>>> - * iort_register_domain_token() - register domain token and related
>> ITS ID
>>>>> - * to the list from where we can get it back later on.
>>>>> + * iort_register_domain_token() - register domain token along with
>> related
>>>>> + * ITS ID and base address to the list from where we can get it back
>> later on.
>>>>>   * @trans_id: ITS ID.
>>>>> + * @base: ITS base address.
>>>>>   * @fw_node: Domain token.
>>>>>   *
>>>>>   * Returns: 0 on success, -ENOMEM if no memory when allocating list
>> element
>>>>>   */
>>>>> -int iort_register_domain_token(int trans_id, struct fwnode_handle
>> *fw_node)
>>>>> +int iort_register_domain_token(int trans_id, phys_addr_t base,
>>>>> +			       struct fwnode_handle *fw_node)
>>>>>  {
>>>>>  	struct iort_its_msi_chip *its_msi_chip;
>>>>>
>>>>> @@ -153,6 +156,7 @@ int iort_register_domain_token(int trans_id,
>> struct fwnode_handle *fw_node)
>>>>>
>>>>>  	its_msi_chip->fw_node = fw_node;
>>>>>  	its_msi_chip->translation_id = trans_id;
>>>>> +	its_msi_chip->base_addr = base;
>>>>>
>>>>>  	spin_lock(&iort_msi_chip_lock);
>>>>>  	list_add(&its_msi_chip->list, &iort_msi_chip_list);
>>>>> @@ -481,6 +485,24 @@ int iort_pmsi_get_dev_id(struct device *dev,
>> u32 *dev_id)
>>>>>  	return -ENODEV;
>>>>>  }
>>>>>
>>>>> +static int iort_find_its_base(u32 its_id, phys_addr_t *base)
>>>>
>>>> You have to tag it as __maybe_unused for the !IOMMU_API case.
>>>>
>>>>> +{
>>>>> +	struct iort_its_msi_chip *its_msi_chip;
>>>>> +	bool match = false;
>>>>> +
>>>>> +	spin_lock(&iort_msi_chip_lock);
>>>>> +	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
>>>>> +		if (its_msi_chip->translation_id == its_id) {
>>>>> +			*base = its_msi_chip->base_addr;
>>>>> +			match = true;
>>>>> +			break;
>>>>> +		}
>>>>> +	}
>>>>> +	spin_unlock(&iort_msi_chip_lock);
>>>>> +
>>>>> +	return match ? 0 : -ENODEV;
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * iort_dev_find_its_id() - Find the ITS identifier for a device
>>>>>   * @dev: The device.
>>>>> @@ -639,6 +661,67 @@ int iort_add_device_replay(const struct
>> iommu_ops *ops, struct device *dev)
>>>>>
>>>>>  	return err;
>>>>>  }
>>>>> +
>>>>> +/**
>>>>> + * iort_iommu_its_get_resv_regions - Reserved region driver helper
>>>>> + * @dev: Device from iommu_get_resv_regions()
>>>>> + * @list: Reserved region list from iommu_get_resv_regions()
>>>>> + *
>>>>> + * Returns: Number of reserved regions on success(0 if no associated
>> ITS),
>>>>> + *          appropriate error value otherwise.
>>>>> + *
>>>>> + * IOMMU drivers can use this to implement their .get_resv_regions
>> callback
>>>>> + * for reserving the HW ITS address regions.
>>>>
>>>> Stale comment.
>>>>
>>>>> + */
>>>>> +int iort_iommu_its_get_resv_regions(struct device *dev, struct
>> list_head *head)
>>>>> +{
>>>>> +	int i;
>>>>> +	struct acpi_iort_its_group *its;
>>>>> +	struct acpi_iort_node *node, *its_node = NULL;
>>>>> +	int resv = 0;
>>>>
>>>> Nit: int i, resv = 0;
>>>>
>>>> I can make these changes but I suspect this series will go via IOMMU
>>>> tree, let me know how you want to handle it.
>>>>
>>>> Lorenzo
>>>>
>>>>> +	node = iort_find_dev_node(dev);
>>>>> +	if (!node)
>>>>> +		return -ENODEV;
>>>>> +
>>>
>>> I'd suggest we also want a comment here to clarify that we're currently
>>> assuming straightforward topologies where all mappings for a given root
>>> complex/named component target the same ITS group. Otherwise we're
>> going
>>> to need somewhat more logic to iterate the its_node processing over
>>> every mapping (or every alias in the PCI case), but avoid creating
>>> duplicate entries.
>>
>> You have a point and we have time to update the code. Short of reserving
>> all ITS regions for every device that maps to one at least, we could (even
>> pre-compute instead of looking it up on the fly) create a list of ITS
>> identifiers a given IORT node may map to and use that to reserve the
>> regions.
> 
> I am trying to understand the use case scenario discussed here. Apologies
> if it is a dumb query. 
> 
> My understanding is that, it is possible to have a PCI  RC iort node mapped to
> multiple ITS group nodes.  That is perfectly fine and given a dev input RID we 
> can identify the ITS group the device points to using - iort_node_map_id().
> 
> But the above discussion seems to suggest that there might be situations where
> we have to go through all the mapped ITS groups and identify all the ITSs associated
> with the RC.  Clearly I am missing something.

I was mostly thinking of a situation like this:

+----Node 0-----+  +----Node 1-----+
|  [CPU 0..n]   |  |  [CPU n+1..]  |
| [ITS group 0] |  | [ITS group 1] |
+---------------+  +---------------+
        ^                  ^
         \_______  _______/
                 \/
            +--Node 2--+
            |  [SMMU]  |
            |     ^    |
            |     |    |
            | [Device] |
            +----------+

where the (named component) device has IDs for both ITS groups (to help
optimise affining, or allow physically hotplugging CPU nodes, or
whatever - I'm hypothesising here ;)).  A generic IORT function isn't in
a position to decide *which* ITS region the device may be targeting at
any given time, so can only correctly describe both.

I'm perfectly happy not to even try to support such crazy configurations
until they actually exist, if ever; I'd just prefer to document whatever
assumptions we do make, so that we don't have to remember or re-derive
them when looking at the code in future.

Robin.
