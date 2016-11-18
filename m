From: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
	reserved regions
Date: Fri, 18 Nov 2016 05:34:37 +0000
Message-ID: <HE1PR0401MB2556607F41972B84F8A48E869AB00@HE1PR0401MB2556.eurprd04.prod.outlook.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1479215363-2898-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: "drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "punit.agrawal-5wv7dgnIgG8@public.gmane.org" <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

Have you sent out QEMU side patches based on this new approach? In case I missed please point me the patches? 

Thanks
-Bharat

> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Eric Auger
> Sent: Tuesday, November 15, 2016 6:39 PM
> To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; marc.zyngier-5wv7dgnIgG8@public.gmane.org;
> robin.murphy-5wv7dgnIgG8@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> will.deacon-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org;
> jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; punit.agrawal-5wv7dgnIgG8@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> Subject: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and
> IOVA reserved regions
> 
> Following LPC discussions, we now report reserved regions through iommu-
> group sysfs reserved_regions attribute file.
> 
> Reserved regions are populated through the IOMMU get_resv_region
> callback (former get_dm_regions), now implemented by amd-iommu, intel-
> iommu and arm-smmu.
> 
> The intel-iommu reports the [FEE0_0000h - FEF0_000h] MSI window as an
> IOMMU_RESV_NOMAP reserved region.
> 
> arm-smmu reports the MSI window (arbitrarily located at 0x8000000 and 1MB
> large) and the PCI host bridge windows.
> 
> The series integrates a not officially posted patch from Robin:
> "iommu/dma: Allow MSI-only cookies".
> 
> This series currently does not address IRQ safety assessment.
> 
> Best Regards
> 
> Eric
> 
> Git: complete series available at
> https://github.com/eauger/linux/tree/v4.9-rc5-reserved-rfc-v3
> 
> History:
> RFC v2 -> v3:
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
> Eric Auger (10):
>   iommu/dma: Allow MSI-only cookies
>   iommu: Rename iommu_dm_regions into iommu_resv_regions
>   iommu: Add new reserved IOMMU attributes
>   iommu: iommu_alloc_resv_region
>   iommu: Do not map reserved regions
>   iommu: iommu_get_group_resv_regions
>   iommu: Implement reserved_regions iommu-group sysfs file
>   iommu/vt-d: Implement reserved region get/put callbacks
>   iommu/arm-smmu: Implement reserved region get/put callbacks
>   vfio/type1: Get MSI cookie
> 
>  drivers/iommu/amd_iommu.c       |  20 +++---
>  drivers/iommu/arm-smmu.c        |  52 +++++++++++++++
>  drivers/iommu/dma-iommu.c       | 116 ++++++++++++++++++++++++++----
> ---
>  drivers/iommu/intel-iommu.c     |  50 ++++++++++----
>  drivers/iommu/iommu.c           | 141
> ++++++++++++++++++++++++++++++++++++----
>  drivers/vfio/vfio_iommu_type1.c |  26 ++++++++
>  include/linux/dma-iommu.h       |   7 ++
>  include/linux/iommu.h           |  49 ++++++++++----
>  8 files changed, 391 insertions(+), 70 deletions(-)
> 
> --
> 1.9.1
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
