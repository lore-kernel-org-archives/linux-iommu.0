From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 14/14] drivers: acpi: iort: introduce
 iort_iommu_configure
Date: Tue, 13 Sep 2016 16:18:01 +0800
Message-ID: <54744f49-f1f5-be5e-313e-e38e51c0004e@linaro.org>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
 <20160909142343.13314-15-lorenzo.pieralisi@arm.com>
 <57647b7518907dd9bd682e5e5a55ca80@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <57647b7518907dd9bd682e5e5a55ca80@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Nate Watterson <nwatters@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, tn@semihalf.com
Cc: iommu@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>, Eric Auger <eric.auger@redhat.com>, Sinan Kaya <okaya@codeaurora.org>, Prem Mallappa <prem.mallappa@broadcom.com>, Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Nate,

On 2016/9/13 16:14, Nate Watterson wrote:
> On 2016-09-09 10:23, Lorenzo Pieralisi wrote:
>> DT based systems have a generic kernel API to configure IOMMUs
>> for devices (ie of_iommu_configure()).
>>
>> On ARM based ACPI systems, the of_iommu_configure() equivalent can
>> be implemented atop ACPI IORT kernel API, with the corresponding
>> functions to map device identifiers to IOMMUs and retrieve the
>> corresponding IOMMU operations necessary for DMA operations set-up.
>>
>> By relying on the iommu_fwspec generic kernel infrastructure,
>> implement the IORT based IOMMU configuration for ARM ACPI systems
>> and hook it up in the ACPI kernel layer that implements DMA
>> configuration for a device.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Hanjun Guo <hanjun.guo@linaro.org>
>> Cc: Tomasz Nowicki <tn@semihalf.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> ---
>>  drivers/acpi/arm64/iort.c | 96
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/acpi/scan.c       |  7 +++-
>>  include/linux/acpi_iort.h |  6 +++
>>  3 files changed, 108 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 7c68eb4..55a4ae9 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -19,6 +19,7 @@
>>  #define pr_fmt(fmt)    "ACPI: IORT: " fmt
>>
>>  #include <linux/acpi_iort.h>
>> +#include <linux/iommu-fwspec.h>
>>  #include <linux/kernel.h>
>>  #include <linux/list.h>
>>  #include <linux/pci.h>
>> @@ -27,6 +28,8 @@
>>
>>  #define IORT_TYPE_MASK(type)    (1 << (type))
>>  #define IORT_MSI_TYPE        (1 << ACPI_IORT_NODE_ITS_GROUP)
>> +#define IORT_IOMMU_TYPE        ((1 << ACPI_IORT_NODE_SMMU) |    \
>> +                (1 << ACPI_IORT_NODE_SMMU_V3))
>>
>>  struct iort_its_msi_chip {
>>      struct list_head    list;
>> @@ -467,6 +470,99 @@ struct irq_domain *iort_get_device_domain(struct
>> device *dev, u32 req_id)
>>      return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
>>  }
>>
>> +static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>> +{
>> +    u32 *rid = data;
>> +
>> +    *rid = alias;
>> +    return 0;
>> +}
>> +
>> +static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
>> +                   struct fwnode_handle *fwnode)
>> +{
>> +    int ret = iommu_fwspec_init(dev, fwnode);
>> +
>> +    if (!ret)
>> +        ret = iommu_fwspec_add_ids(dev, &streamid, 1);
>> +
>> +    return ret;
>> +}
>> +
>> +static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
>> +                    struct acpi_iort_node *node,
>> +                    u32 streamid)
>> +{
>> +    struct fwnode_handle *iort_fwnode = NULL;
>> +    int ret;
>> +
>> +    if (node) {
>> +        iort_fwnode = iort_get_fwnode(node);
>> +        if (!iort_fwnode)
>> +            return NULL;
>> +
>> +        ret = arm_smmu_iort_xlate(dev, streamid,
>> +                      iort_fwnode);
>> +        if (!ret)
>> +            return fwspec_iommu_get_ops(iort_fwnode);
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +/**
>> + * iort_iommu_configure - Set-up IOMMU configuration for a device.
>> + *
>> + * @dev: device to configure
>> + *
>> + * Returns: iommu_ops pointer on configuration success
>> + *          NULL on configuration failure
>> + */
>> +const struct iommu_ops *iort_iommu_configure(struct device *dev)
>> +{
>> +    struct acpi_iort_node *node, *parent;
>> +    const struct iommu_ops *ops = NULL;
>> +    u32 streamid = 0;
>> +
>> +    if (dev_is_pci(dev)) {
>> +        struct pci_bus *bus = to_pci_dev(dev)->bus;
>> +        u32 rid;
>> +
>> +        pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
>> +                       &rid);
>> +
>> +        node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>> +                      iort_match_node_callback, &bus->dev);
>> +        if (!node)
>> +            return NULL;
>> +
>> +        parent = iort_node_map_rid(node, rid, &streamid,
>> +                       IORT_IOMMU_TYPE);
>> +
>> +        ops = iort_iommu_xlate(dev, parent, streamid);
>> +
>> +    } else {
>> +        int i = 0;
>> +
>> +        node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>> +                      iort_match_node_callback, dev);
>> +        if (!node)
>> +            return NULL;
>> +
>
> Nothing wrong with your code here, but wanted to warn you that there
> appears to be a bug in iort_match_node_callback() for NAMED_COMPONENTS.
>
> iort_match_node_callback() {
>     acpi_status status = AE_NOT_FOUND;
>     ...
>     case ACPI_IORT_NODE_NAMED_COMPONENT: {
>         ...
>         status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buf);
>         if (ACPI_FAILURE(status)) {
>             dev_warn(dev, "Can't get device full path name\n");
>             break;
>         }
>
>         ncomp = (struct acpi_iort_named_component *)node->node_data;
>         if (!strcmp(ncomp->device_name, buf.pointer))
>             status = AE_OK;
>
>         acpi_os_free(buf.pointer);
>         break;
>     }
>     ...
>     return status;
> }
>
> Notice how if strcmp() fails, status remains set to the status of the call
> to acpi_get_name() which must have been OK since we would have broken out
> of the switch statement otherwise. This is causing all manner of platform
> devices not even described in the IORT to get hooked up using the IDs of
> the first properly iommu-attached NAMED_COMPONENT device found in the IORT.

As I said in previous email, please use the new version of IORT patch
set :)

Thanks
Hanjun
