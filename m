Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B457182D0
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 15:00:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 189061FB;
	Tue, 16 May 2023 08:01:36 -0700 (PDT)
Received: from [10.57.83.102] (unknown [10.57.83.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B9193F7BD;
	Tue, 16 May 2023 08:00:50 -0700 (PDT)
Message-ID: <33b25946-8970-6711-41a5-8b07ccff77c3@arm.com>
Date: Tue, 16 May 2023 16:00:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] iommu/fsl: Do not use iommu_group_remove_device()
 under ops->device_group()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <1-v1-8fb05192ea02+e5-fsl_rm_groups_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1-v1-8fb05192ea02+e5-fsl_rm_groups_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-05-16 01:27, Jason Gunthorpe wrote:
> This API is expected to be used only by POWER and VFIO no-iommu that
> manually manage the group lifecycle. It should not be called under
> ops->device_group().
> 
> This is already buggy as is since the core code does not expect a probed
> driver to loose it's iommu_group without also releasing the device.
> 
> FSL seems to be trying to block the platform_device that represents the
> pci_controller, eg the thing passed to fsl_add_bridge(), from having an
> iommu_group.
> 
> Instead of creating an iommu_group that we don't want and then later
> removing it, just don't create it at all in the first place.
> 
> For the 'pci_endpt_partitioning' case every PCI device already gets its
> own iommu_group through the standard code, so it is unclear why having a
> dedicated group for the controller could be problematic.
> 
> For the other case, the controller group was being used to bizarrely
> de-duplicate the group in it's hose. Instead just directly create a group
> for the hose the first time we encounter it. The code already searches the
> entire hose to find any iommu_group. Again, it is unclear why having the
> pci_controller inside the same iommu_group as the PCI devices would be
> harmful.

It's harmful in that case because it prevents VFIO from working at all - 
even now that VFIO no longer rejects cross-bus groups on principle, the 
fsl-pci driver being bound to the platform device would then deny VFIO 
from taking ownership.

> In any case, this is a cleaner way to not enable iommu support for the
> platform_device.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/fsl_pamu_domain.c | 42 ++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index bce37229709965..bf045f58cd50ae 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -11,6 +11,7 @@
>   
>   #include <linux/platform_device.h>
>   #include <sysdev/fsl_pci.h>
> +#include <linux/pci.h>
>   
>   /*
>    * Global spinlock that needs to be held while
> @@ -379,7 +380,21 @@ static struct iommu_group *get_shared_pci_device_group(struct pci_dev *pdev)
>   		bus = bus->parent;
>   	}
>   
> -	return NULL;
> +	return iommu_group_alloc();
> +}
> +
> +static int __is_pci_controller_parent(struct device *dev, void *data)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_controller *pci_ctl = pci_bus_to_host(pdev->bus);
> +
> +	return dev == pci_ctl->parent;

If I'm not mistaken, this is testing every *PCI* device to see any of 
them are their own host bridge's platform parent...

> +}
> +
> +static bool is_pci_controller_parent(struct device *dev)
> +{
> +	return bus_for_each_dev(&pci_bus_type, NULL, NULL,
> +				__is_pci_controller_parent);

for_each_pci_dev() might be easier to handle, however for what I think 
this is ultimately trying to do, device_find_child() would seem even better.

>   }
>   
>   static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
> @@ -393,30 +408,12 @@ static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
>   	/* We can partition PCIe devices so assign device group to the device */
>   	if (pci_endpt_partitioning) {
>   		group = pci_device_group(&pdev->dev);
> -
> -		/*
> -		 * PCIe controller is not a paritionable entity
> -		 * free the controller device iommu_group.
> -		 */
> -		if (pci_ctl->parent->iommu_group)
> -			iommu_group_remove_device(pci_ctl->parent);
>   	} else {
>   		/*
>   		 * All devices connected to the controller will share the
> -		 * PCI controllers device group. If this is the first
> -		 * device to be probed for the pci controller, copy the
> -		 * device group information from the PCI controller device
> -		 * node and remove the PCI controller iommu group.
> -		 * For subsequent devices, the iommu group information can
> -		 * be obtained from sibling devices (i.e. from the bus_devices
> -		 * link list).
> +		 * same device group.
>   		 */
> -		if (pci_ctl->parent->iommu_group) {
> -			group = get_device_iommu_group(pci_ctl->parent);
> -			iommu_group_remove_device(pci_ctl->parent);
> -		} else {
> -			group = get_shared_pci_device_group(pdev);
> -		}
> +		group = get_shared_pci_device_group(pdev);

It would be nice if we could still associate the "PCI group" directly 
with the pci_controller some other way, and avoid all the 
slightly-confusing bus walks altogether, but I don't see a sufficiently 
clean way to achieve that :(

Thanks,
Robin.

>   	}
>   
>   	if (!group)
> @@ -436,7 +433,8 @@ static struct iommu_group *fsl_pamu_device_group(struct device *dev)
>   	 */
>   	if (dev_is_pci(dev))
>   		group = get_pci_device_group(to_pci_dev(dev));
> -	else if (of_get_property(dev->of_node, "fsl,liodn", &len))
> +	else if (of_get_property(dev->of_node, "fsl,liodn", &len) &&
> +		 !is_pci_controller_parent(dev))
>   		group = get_device_iommu_group(dev);
>   
>   	return group;
