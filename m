From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v12 0/8] KVM PCIe/MSI passthrough on ARM/ARM64: kernel
 part 3/3: vfio changes
Date: Sun, 7 Aug 2016 16:08:02 +0200
Message-ID: <c0b84785-9160-f58e-a1b7-ea1b0c511cc9@redhat.com>
References: <1470159012-7110-1-git-send-email-eric.auger@redhat.com>
 <HE1PR04MB13217B0A44D140CC54901EDCFF180@HE1PR04MB1321.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <HE1PR04MB13217B0A44D140CC54901EDCFF180@HE1PR04MB1321.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Diana Madalina Craciun <diana.craciun@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "drjones@redhat.com" <drjones@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Manish.Jaggi@caviumnetworks.com" <Manish.Jaggi@caviumnetworks.com>, "p.fedin@samsung.com" <p.fedin@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "pranav.sawargaonkar@gmail.com" <pranav.sawargaonkar@gmail.com>, "dennis.chen@arm.com" <dennis.chen@arm.com>, "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>, "yehuday@marvell.com" <yehuday@marvell.com>
List-Id: iommu@lists.linux-foundation.org

Hi Diana,

On 05/08/2016 16:46, Diana Madalina Craciun wrote:
> Hi Eric,
> 
> I have tested these patches in a VFIO PCI scenario (using the ITS
> emulation) on a NXP LS2080 board. It worked fine with one e1000 card
> assigned to the guest. However, when I tried to assign two cards to the
> guest I got a crash. I narrowed down the problem to this code:
> 
> drivers/vfio/vfio_iommu_type1.c, vfio_iommu_type1_attach_group function
> 
>    /*
>      * Try to match an existing compatible domain.  We don't want to
>      * preclude an IOMMU driver supporting multiple bus_types and being
>      * able to include different bus_types in the same IOMMU domain, so
>      * we test whether the domains use the same iommu_ops rather than
>      * testing if they're on the same bus_type.
>      */
>     list_for_each_entry(d, &iommu->domain_list, next) {
>         if (d->domain->ops == domain->domain->ops &&
>             d->prot == domain->prot) {
>             iommu_detach_group(domain->domain, iommu_group);
>             if (!iommu_attach_group(d->domain, iommu_group)) {
>                 list_add(&group->next, &d->group_list);
>                 iommu_domain_free(domain->domain);
>                 kfree(domain);
>                 mutex_unlock(&iommu->lock);
>                 return 0;
>             }
> 
>             ret = iommu_attach_group(domain->domain, iommu_group);
>             if (ret)
>                 goto out_domain;
>         }
>     }
> 
> The iommu_domain_free function eventually calls iommu_put_dma_cookie
> which calls put_iova_domain. This function (put_iova_domain) tries to
> acquire some spinlocks which were not yet initialized. They will be
> initialized later when the first DMA mapping will be performed. Because
> the spinlock was not yet initialized, it crashes when attempting to
> acquire it.
> 
> With the following fix I was able to successfully assign two cards to
> the guest:
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index ba764a0..b43e34f 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -457,6 +457,9 @@ void put_iova_domain(struct iova_domain *iovad)
>         struct rb_node *node;
>         unsigned long flags;
>  
> +       if (!iovad->start_pfn)
> +               return;
> +
>         free_iova_rcaches(iovad);
>         spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>         node = rb_first(&iovad->rbroot);
> 
> However, I am not sure if this is the right fix.

Thanks for testing. Sorry for the time you spent narrowing the above
issue. The problem is known and fixed by Robin's patch sent on iommu
list. The patch can be found on my branch - similar fix as the one you
did ;-) -:

iommu/dma: Don't put uninitialised IOVA domains

Thanks!

Eric
> 
> Thanks,
> 
> Diana
> 
> 
> On 08/02/2016 08:30 PM, Eric Auger wrote:
>> This series allows the user-space to register a reserved IOVA domain.
>> This completes the kernel integration of the whole functionality on top
>> of the 2 previous parts (v11).
>>
>> We reuse the VFIO DMA MAP ioctl with a new flag to bridge to the
>> msi-iommu API. The need for provisioning such MSI IOVA range is reported
>> through capability chain, using VFIO_IOMMU_TYPE1_INFO_CAP_MSI_GEOMETRY.
>>
>> vfio_iommu_type1 checks if the MSI mapping is safe when attaching the
>> vfio group to the container (allow_unsafe_interrupts modality). This is
>> done in a very coarse way, looking at all the registered doorbells and
>> returning assignment is safe wrt IRQ if all the doorbells are safe.
>>
>> More details & context can be found at:
>> http://www.linaro.org/blog/core-dump/kvm-pciemsi-passthrough-armarm64/
>>
>> Best Regards
>>
>> Eric
>>
>> Testing:
>> - functional on ARM64 AMD Overdrive HW (single GICv2m frame) with
>>   Intel I350T2 (SR-IOV capable, igb/igbvf) and Intel 82574L (e1000e)
>> - functional on Cavium ThunderX (ARM GICv3 ITS) with Intel 82574L (e1000e)
>>
>> References:
>> [1] [RFC 0/2] VFIO: Add virtual MSI doorbell support
>>     (https://lkml.org/lkml/2015/7/24/135)
>> [2] [RFC PATCH 0/6] vfio: Add interface to map MSI pages
>>     (https://lists.cs.columbia.edu/pipermail/kvmarm/2015-September/016607.html)
>> [3] [PATCH v2 0/3] Introduce MSI hardware mapping for VFIO
>>     (http://permalink.gmane.org/gmane.comp.emulators.kvm.arm.devel/3858)
>>
>> Git: complete series available at
>> https://github.com/eauger/linux/tree/v4.7-rc7-passthrough-v12
>> previous: https://github.com/eauger/linux/tree/v4.7-rc7-passthrough-v11
>>
>> the above branch includes a temporary patch to work around a ThunderX pci
>> bus reset crash (which I think unrelated to this series):
>> "vfio: pci: HACK! workaround thunderx pci_try_reset_bus crash"
>> Do not take this one for other platforms.
>>
>> History:
>> v11 -> v12:
>> - no functional change. Only adapt to renamings done in PART II
>>
>> v10 -> v11:
>> no change to this series, just incremented for consistency
>>
>> v9 -> v10:
>> Took into account Alex' comments:
>> - split "vfio/type1: vfio_find_dma accepting a type argument" into 2 patches
>> - properly implement replay of MSI DMA slots (by setting the aperture on the
>>   new domain); fixes the assignment of several devices
>> - rework user api for vfio_iommu_type1_info capability chains (cap_offset
>>   at the end of the struct and fix padding issues)
>> - VFIO_IOVA_RESERVED renamed into VFIO_IOVA_MSI_RESERVED
>> - explicit dma->type setting to VFIO_IOVA_USER
>>
>> v8 -> v9:
>> - report MSI geometry through capability chain (last patch only);
>>   with the current limitation that an arbitrary number of 16 page
>>   requirement is reported. To be improved later on.
>>
>>
>> v7 -> v8:
>> - use renamed msi-iommu API
>> - VFIO only responsible for setting the IOVA aperture
>> - use new DOMAIN_ATTR_MSI_GEOMETRY iommu domain attribute
>>
>> v6 -> v7:
>> - vfio_find_dma now accepts a dma_type argument.
>> - should have recovered the capability to unmap the whole user IOVA range
>> - remove computation of nb IOVA pages -> will post a separate RFC for that
>>   while respinning the QEMU part
>>
>> RFC v5 -> patch v6:
>> - split to ease the review process
>>
>> RFC v4 -> RFC v5:
>> - take into account Thomas' comments on MSI related patches
>>   - split "msi: IOMMU map the doorbell address when needed"
>>   - increase readability and add comments
>>   - fix style issues
>>  - split "iommu: Add DOMAIN_ATTR_MSI_MAPPING attribute"
>>  - platform ITS now advertises IOMMU_CAP_INTR_REMAP
>>  - fix compilation issue with CONFIG_IOMMU API unset
>>  - arm-smmu-v3 now advertises DOMAIN_ATTR_MSI_MAPPING
>>
>> RFC v3 -> v4:
>> - Move doorbell mapping/unmapping in msi.c
>> - fix ref count issue on set_affinity: in case of a change in the address
>>   the previous address is decremented
>> - doorbell map/unmap now is done on msi composition. Should allow the use
>>   case for platform MSI controllers
>> - create dma-reserved-iommu.h/c exposing/implementing a new API dedicated
>>   to reserved IOVA management (looking like dma-iommu glue)
>> - series reordering to ease the review:
>>   - first part is related to IOMMU
>>   - second related to MSI sub-system
>>   - third related to VFIO (except arm-smmu IOMMU_CAP_INTR_REMAP removal)
>> - expose the number of requested IOVA pages through VFIO_IOMMU_GET_INFO
>>   [this partially addresses Marc's comments on iommu_get/put_single_reserved
>>    size/alignment problematic - which I did not ignore - but I don't know
>>    how much I can do at the moment]
>>
>> RFC v2 -> RFC v3:
>> - should fix wrong handling of some CONFIG combinations:
>>   CONFIG_IOVA, CONFIG_IOMMU_API, CONFIG_PCI_MSI_IRQ_DOMAIN
>> - fix MSI_FLAG_IRQ_REMAPPING setting in GICv3 ITS (although not tested)
>>
>> PATCH v1 -> RFC v2:
>> - reverted to RFC since it looks more reasonable ;-) the code is split
>>   between VFIO, IOMMU, MSI controller and I am not sure I did the right
>>   choices. Also API need to be further discussed.
>> - iova API usage in arm-smmu.c.
>> - MSI controller natively programs the MSI addr with either the PA or IOVA.
>>   This is not done anymore in vfio-pci driver as suggested by Alex.
>> - check irq remapping capability of the group
>>
>> RFC v1 [2] -> PATCH v1:
>> - use the existing dma map/unmap ioctl interface with a flag to register a
>>   reserved IOVA range. Use the legacy Rb to store this special vfio_dma.
>> - a single reserved IOVA contiguous region now is allowed
>> - use of an RB tree indexed by PA to store allocated reserved slots
>> - use of a vfio_domain iova_domain to manage iova allocation within the
>>   window provided by the userspace
>> - vfio alloc_map/unmap_free take a vfio_group handle
>> - vfio_group handle is cached in vfio_pci_device
>> - add ref counting to bindings
>> - user modality enabled at the end of the series
>>
>>
>> Eric Auger (8):
>>   vfio: introduce a vfio_dma type field
>>   vfio/type1: vfio_find_dma accepting a type argument
>>   vfio/type1: implement recursive vfio_find_dma_from_node
>>   vfio/type1: handle unmap/unpin and replay for VFIO_IOVA_RESERVED slots
>>   vfio: allow reserved msi iova registration
>>   vfio/type1: check doorbell safety
>>   iommu/arm-smmu: do not advertise IOMMU_CAP_INTR_REMAP
>>   vfio/type1: return MSI geometry through VFIO_IOMMU_GET_INFO capability
>>     chains
>>
>>  drivers/iommu/arm-smmu-v3.c     |   3 +-
>>  drivers/iommu/arm-smmu.c        |   3 +-
>>  drivers/vfio/vfio_iommu_type1.c | 246 +++++++++++++++++++++++++++++++++++++---
>>  include/uapi/linux/vfio.h       |  42 ++++++-
>>  4 files changed, 276 insertions(+), 18 deletions(-)
>>
> 
