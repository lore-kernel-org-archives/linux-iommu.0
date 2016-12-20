From: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [RFC v4 00/16] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
	reserved regions
Date: Tue, 20 Dec 2016 04:45:57 +0000
Message-ID: <AM5PR0401MB254576C4F2C2DA54368144E39A900@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1481661034-3088-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1481661034-3088-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org" <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: "drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "punit.agrawal-5wv7dgnIgG8@public.gmane.org" <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

Tested this series on NXP ARMv8 platform.

Thanks
-Bharat

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Wednesday, December 14, 2016 2:00 AM
> To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; marc.zyngier-5wv7dgnIgG8@public.gmane.org;
> robin.murphy-5wv7dgnIgG8@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> will.deacon-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org;
> jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; punit.agrawal-5wv7dgnIgG8@public.gmane.org; Diana Madalina
> Craciun <diana.craciun-3arQi8VN3Tc@public.gmane.org>; gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
> Subject: [RFC v4 00/16] KVM PCIe/MSI passthrough on ARM/ARM64 and
> IOVA reserved regions
> 
> Following LPC discussions, we now report reserved regions through iommu-
> group sysfs reserved_regions attribute file.
> 
> Reserved regions are populated through the IOMMU get_resv_region
> callback (former get_dm_regions), now implemented by amd-iommu, intel-
> iommu and arm-smmu:
> - the amd-iommu reports device direct mapped regions.
> - the intel-iommu reports the [0xfee00000 - 0xfeefffff] MSI window
>   as an IOMMU_RESV_NOMAP reserved region.
> - the arm-smmu reports the MSI window (arbitrarily located at
>   0x8000000 and 1MB large).
> 
> Unsafe interrupt assignment is tested by enumerating all MSI irq domains
> and checking they support MSI remapping. This check is done in case we
> detect the iommu translates MSI (an IOMMU_RESV_MSI window exists).
> Otherwise the IRQ remapping capability is checked at IOMMU level.
> Obviously this is a defensive IRQ safety assessment.
> Assuming there are several MSI controllers in the system and at least one
> does not implement IRQ remapping, the assignment will be considered as
> unsafe (even if this controller is not acessible from the assigned devices).
> 
> The series integrates a not officially posted patch from Robin:
> "iommu/dma: Allow MSI-only cookies".
> 
> Best Regards
> 
> Eric
> 
> Git: complete series available at
> https://github.com/eauger/linux/tree/v4.9-reserved-v4
> 
> History:
> 
> RFCv3 -> RFCv4:
> - arm-smmu driver does not register PCI host bridge windows as
>   reserved regions anymore
> - Implement reserved region get/put callbacks also in arm-smmuv3
> - take the iommu_group lock on iommu_get_group_resv_regions
> - add a type field in iommu_resv_region instead of using prot
> - init the region list_head in iommu_alloc_resv_region, also
>   add type parameter
> - iommu_insert_resv_region manage overlaps and sort reserved
>   windows
> - address IRQ safety assessment by enumerating all the MSI irq
>   domains and checking the MSI_REMAP flag
> - update Documentation/ABI/testing/sysfs-kernel-iommu_groups
> - Did not add T-b since the code has significantly changed
> 
> RFCv2 -> RFCv3:
> - switch to an iommu-group sysfs API
> - use new dummy allocator provided by Robin
> - dummy allocator initialized by vfio-iommu-type1 after enumerating
>   the reserved regions
> - at the moment ARM MSI base address/size is left unchanged compared
>   to v2
> - we currently report reserved regions and not usable IOVA regions as
>   requested by Alex
> 
> RFC v1 -> v2:
> - fix intel_add_reserved_regions
> - add mutex lock/unlock in vfio_iommu_type1
> 
> 
> Eric Auger (16):
>   iommu/dma: Allow MSI-only cookies
>   iommu: Rename iommu_dm_regions into iommu_resv_regions
>   iommu: Add a new type field in iommu_resv_region
>   iommu: iommu_alloc_resv_region
>   iommu: Only map direct mapped regions
>   iommu: iommu_get_group_resv_regions
>   iommu: Implement reserved_regions iommu-group sysfs file
>   iommu/vt-d: Implement reserved region get/put callbacks
>   iommu/arm-smmu: Implement reserved region get/put callbacks
>   iommu/arm-smmu-v3: Implement reserved region get/put callbacks
>   irqdomain: Add IRQ_DOMAIN_FLAG_MSI_REMAP value
>   irqdomain: irq_domain_check_msi_remap
>   irqchip/gicv3-its: Sets IRQ_DOMAIN_FLAG_MSI_REMAP
>   vfio/type1: Allow transparent MSI IOVA allocation
>   vfio/type1: Check MSI remapping at irq domain level
>   iommu/arm-smmu: Do not advertise IOMMU_CAP_INTR_REMAP anymore
> 
>  .../ABI/testing/sysfs-kernel-iommu_groups          |   9 ++
>  drivers/iommu/amd_iommu.c                          |  21 +--
>  drivers/iommu/arm-smmu-v3.c                        |  30 +++-
>  drivers/iommu/arm-smmu.c                           |  30 +++-
>  drivers/iommu/dma-iommu.c                          | 116 +++++++++++++---
>  drivers/iommu/intel-iommu.c                        |  50 +++++--
>  drivers/iommu/iommu.c                              | 152 +++++++++++++++++++--
>  drivers/irqchip/irq-gic-v3-its.c                   |   1 +
>  drivers/vfio/vfio_iommu_type1.c                    |  37 ++++-
>  include/linux/dma-iommu.h                          |   7 +
>  include/linux/iommu.h                              |  46 +++++--
>  include/linux/irqdomain.h                          |   8 ++
>  kernel/irq/irqdomain.c                             |  24 ++++
>  13 files changed, 455 insertions(+), 76 deletions(-)
> 
> --
> 1.9.1
