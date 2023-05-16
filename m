Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC7D107A5
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 18:24:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5321D1FB;
	Tue, 16 May 2023 11:25:09 -0700 (PDT)
Received: from [10.57.83.102] (unknown [10.57.83.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4CC13F793;
	Tue, 16 May 2023 11:24:23 -0700 (PDT)
Message-ID: <e8157615-abd3-9072-6245-50add0eeb284@arm.com>
Date: Tue, 16 May 2023 19:24:20 +0100
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
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <1-v1-8fb05192ea02+e5-fsl_rm_groups_jgg@nvidia.com>
 <33b25946-8970-6711-41a5-8b07ccff77c3@arm.com> <ZGOqnWBspvDynyJ4@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZGOqnWBspvDynyJ4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-05-16 17:09, Jason Gunthorpe wrote:
> On Tue, May 16, 2023 at 04:00:47PM +0100, Robin Murphy wrote:
>> On 2023-05-16 01:27, Jason Gunthorpe wrote:
>>> This API is expected to be used only by POWER and VFIO no-iommu that
>>> manually manage the group lifecycle. It should not be called under
>>> ops->device_group().
>>>
>>> This is already buggy as is since the core code does not expect a probed
>>> driver to loose it's iommu_group without also releasing the device.
>>>
>>> FSL seems to be trying to block the platform_device that represents the
>>> pci_controller, eg the thing passed to fsl_add_bridge(), from having an
>>> iommu_group.
>>>
>>> Instead of creating an iommu_group that we don't want and then later
>>> removing it, just don't create it at all in the first place.
>>>
>>> For the 'pci_endpt_partitioning' case every PCI device already gets its
>>> own iommu_group through the standard code, so it is unclear why having a
>>> dedicated group for the controller could be problematic.
>>>
>>> For the other case, the controller group was being used to bizarrely
>>> de-duplicate the group in it's hose. Instead just directly create a group
>>> for the hose the first time we encounter it. The code already searches the
>>> entire hose to find any iommu_group. Again, it is unclear why having the
>>> pci_controller inside the same iommu_group as the PCI devices would be
>>> harmful.
>>
>> It's harmful in that case because it prevents VFIO from working at all -
>> even now that VFIO no longer rejects cross-bus groups on principle, the
>> fsl-pci driver being bound to the platform device would then deny VFIO from
>> taking ownership.
> 
> I think that was true before..
> 
> Today we block out VFIO based on iommu_device_use_default_domain()
> which is called prior to probe. That function is a NOP if the iommu
> group hasn't already been setup.
> 
> Thus the platform_device probed by fsl_pci_probe() does not block VFIO
> any more, even if it is in the same group.

My reading of the current code is that it must absolutely be relying on 
fsl_pamu_init() having run before fsl_pci_init() (they're both at 
arch_initcall level, implying an icky fragile link-order dependency), 
such that the platform device group is already assigned by the time the 
PCI host driver binds and starts adding PCI devices, so for *their* 
iommu_probe, get_pci_device_group() can then hoick that group over into 
PCI-land to start propagating it around.

Thus if all we did was remove the dodgy iommu_group_remove_device() 
calls, I believe use_default_domain *would* start getting in the way...

> But, more broadly, we exclude things like PCI bridges from the VFIO
> check by using driver_managed_dma:
> 
> index b7232c46b24481..6daf620b63a4d5 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -1353,6 +1353,7 @@ static struct platform_driver fsl_pci_driver = {
>                  .of_match_table = pci_ids,
>          },
>          .probe = fsl_pci_probe,
> +       .driver_managed_dma = true,
>   };
>   
>   static int __init fsl_pci_init(void)
> 
> Even though it is a NOP in this case because of ordering, it still
> would be good for documentation purposes.

...however I think you're on to something here - if with this we can 
safely guarantee to negate any ownership problem as well, then flipping 
it all around to *always* rely on the platform device's group might be 
neatest of all. It's redundant in the pci_endpt_partitioning case, but I 
don't see how that would really hurt other than slightly changing group 
numbering to the annoyance of users with dodgy hard-coded scripts who 
mistakenly assumed group IDs were stable. Crucially, all of the other 
crap can go away and leave us with simply:

	if (pci_endpt_partitioning)
		return pci_device_group(&pdev->dev);
	else
		return iommu_group_get(pci_ctl->parent);

Thanks,
Robin.
