From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
Subject: Re: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
 reserved regions
Date: Wed, 30 Nov 2016 16:22:40 +0530
Message-ID: <CAFpQJXVqStQwRkm9F=e+8UFxWsddcwgB=AyfnZXSSaOw3eyBUA@mail.gmail.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <6c9012fd-070b-6218-48e7-69b37f2559dd@redhat.com> <CAFpQJXWp5BfsxU5nkWm7hrq5wp6=b-6iYVHjBQYhmkWN_kSSzg@mail.gmail.com>
 <3d0ddb50-6e63-3fe2-55c0-ce49579905c9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <3d0ddb50-6e63-3fe2-55c0-ce49579905c9@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, christoffer.dall@linaro.org, Marc Zyngier <marc.zyngier@arm.com>, robin.murphy@arm.com, alex.williamson@redhat.com, Will Deacon <will.deacon@arm.com>, joro@8bytes.org, "tglx@linutronix.de" <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, drjones@redhat.com, kvm@vger.kernel.org, punit.agrawal@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 30, 2016 at 3:44 PM, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Ganapat,
>
> On 30/11/2016 11:04, Ganapatrao Kulkarni wrote:
>> Hi Eric,
>>
>> in you repo "https://github.com/eauger/linux/tree/v4.9-rc5-reserved-rfc-v3"
>> there is 11th patch "pci: Enable overrides for missing ACS capabilities"
>> is this patch part of some other series?
>
> Actually this is a very old patch from Alex aimed at working around lack
> of PCIe ACS support: https://lkml.org/lkml/2013/5/30/513
>

i have tried this patchset on thunderx-83xx for vfio and it works for me!
i was wondering is this patch required? i guess not.

please cc me when you respin this patchset.

thanks
Ganapat

> Thanks
>
> Eric
>>
>> thanks
>> Ganapat
>>
>> On Wed, Nov 30, 2016 at 3:19 PM, Auger Eric <eric.auger@redhat.com> wrote:
>>> Hi,
>>>
>>> On 15/11/2016 14:09, Eric Auger wrote:
>>>> Following LPC discussions, we now report reserved regions through
>>>> iommu-group sysfs reserved_regions attribute file.
>>>>
>>>> Reserved regions are populated through the IOMMU get_resv_region callback
>>>> (former get_dm_regions), now implemented by amd-iommu, intel-iommu and
>>>> arm-smmu.
>>>>
>>>> The intel-iommu reports the [FEE0_0000h - FEF0_000h] MSI window as an
>>>> IOMMU_RESV_NOMAP reserved region.
>>>>
>>>> arm-smmu reports the MSI window (arbitrarily located at 0x8000000 and
>>>> 1MB large) and the PCI host bridge windows.
>>>>
>>>> The series integrates a not officially posted patch from Robin:
>>>> "iommu/dma: Allow MSI-only cookies".
>>>>
>>>> This series currently does not address IRQ safety assessment.
>>>
>>> I will respin this series taking into account Joerg's comment. Does
>>> anyone have additional comments or want to put forward some conceptual
>>> issues with the current direction and with this implementation?
>>>
>>> As for the IRQ safety assessment, in a first step I would propose to
>>> remove the IOMMU_CAP_INTR_REMAP from arm-smmus and consider the
>>> assignment as unsafe. Any objection?
>>>
>>> Thanks
>>>
>>> Eric
>>>
>>>
>>>> Best Regards
>>>>
>>>> Eric
>>>>
>>>> Git: complete series available at
>>>> https://github.com/eauger/linux/tree/v4.9-rc5-reserved-rfc-v3
>>>>
>>>> History:
>>>> RFC v2 -> v3:
>>>> - switch to an iommu-group sysfs API
>>>> - use new dummy allocator provided by Robin
>>>> - dummy allocator initialized by vfio-iommu-type1 after enumerating
>>>>   the reserved regions
>>>> - at the moment ARM MSI base address/size is left unchanged compared
>>>>   to v2
>>>> - we currently report reserved regions and not usable IOVA regions as
>>>>   requested by Alex
>>>>
>>>> RFC v1 -> v2:
>>>> - fix intel_add_reserved_regions
>>>> - add mutex lock/unlock in vfio_iommu_type1
>>>>
>>>>
>>>> Eric Auger (10):
>>>>   iommu/dma: Allow MSI-only cookies
>>>>   iommu: Rename iommu_dm_regions into iommu_resv_regions
>>>>   iommu: Add new reserved IOMMU attributes
>>>>   iommu: iommu_alloc_resv_region
>>>>   iommu: Do not map reserved regions
>>>>   iommu: iommu_get_group_resv_regions
>>>>   iommu: Implement reserved_regions iommu-group sysfs file
>>>>   iommu/vt-d: Implement reserved region get/put callbacks
>>>>   iommu/arm-smmu: Implement reserved region get/put callbacks
>>>>   vfio/type1: Get MSI cookie
>>>>
>>>>  drivers/iommu/amd_iommu.c       |  20 +++---
>>>>  drivers/iommu/arm-smmu.c        |  52 +++++++++++++++
>>>>  drivers/iommu/dma-iommu.c       | 116 ++++++++++++++++++++++++++-------
>>>>  drivers/iommu/intel-iommu.c     |  50 ++++++++++----
>>>>  drivers/iommu/iommu.c           | 141 ++++++++++++++++++++++++++++++++++++----
>>>>  drivers/vfio/vfio_iommu_type1.c |  26 ++++++++
>>>>  include/linux/dma-iommu.h       |   7 ++
>>>>  include/linux/iommu.h           |  49 ++++++++++----
>>>>  8 files changed, 391 insertions(+), 70 deletions(-)
>>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
