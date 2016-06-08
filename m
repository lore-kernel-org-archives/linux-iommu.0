From: Auger Eric <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 0/7] KVM PCIe/MSI passthrough on ARM/ARM64: kernel part
	3/3: vfio changes
Date: Wed, 8 Jun 2016 10:29:35 +0200
Message-ID: <875b5791-f7c9-97ca-46de-4b1474fe65e0@linaro.org>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
	<573F34CA.5080308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <573F34CA.5080308-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-qxv4g6HH51o@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Dear all,
Le 20/05/2016 =E0 18:01, Eric Auger a =E9crit :
> Alex, Robin,
> =

> While my 3 part series primarily addresses the problematic of mapping
> MSI doorbells into arm-smmu, it fails in :
> =

> 1) determining whether the MSI controller is downstream or upstream to
> the IOMMU,
> 	=3D> indicates whether the MSI doorbell must be mapped
> 	=3D> participates in the decision about 2)
> =

> 2) determining whether it is safe to assign a PCIe device.
> =

> I think we share this understanding with Robin. All above of course
> stands for ARM.
> =

> I get stuck with those 2 issues and I have few questions about iommu
> group setup, PCIe, iommu dt/ACPI description. I would be grateful to you
> if you could answer part of those questions and advise about the
> strategy to fix those.

gentle reminder about the questions below; hope I did not miss any reply.
If anybody has some time to spent on this topic...

> =

> Best Regards
> =

> Eric
> =

> QUESTIONS:
> =

> 1) Robin, you pointed some host controllers which also are MSI
> controllers
> (http://thread.gmane.org/gmane.linux.kernel.pci/47174/focus=3D47268). In
> that case MSIs never reach the IOMMU. I failed in finding anything about
> MSIs in PCIe ACS spec. What should be the iommu groups in that
> situation. Isn't the upstreamed code able to see some DMA transfers are
> not properly isolated and alias devices in the same group? According to
> your security warning, Alex, I would think the code does not recognize
> it, can you confirm please?
my current understanding is end points would be in separate groups (assuming
ACS support) although MSI controller frame is not properly protected.
> =

> 2) can other PCIe components be MSI controllers?
> =

> 3) Am I obliged to consider arbitrary topologies where an MSI controller
> stands between the PCIe host and the iommu? in the PCIe space or
> platform space? If this only relates to PCIe couldn' I check if an MSI
> controller exists in the PCIe tree?
In my last series, I consider the assignment of platform device unsafe as
soon as there is a GICv2m. This is a change in the user experience compared=
 to
what we have before.
> =

> 4) Robin suggested in a private thread to enumerate through a list of
> "registered" doorbells and if any belongs to an unsafe MSI controller,
> consider the assignment is unsafe. This would be a first step before
> doing something more complex. Alex, would that be acceptable to you for
> issue #2?
I implemented this technique in my last series waiting for more discussion
on 4, 5.
> =

> 5) About issue #1: don't we miss tools in dt/ACPI to describe the
> location of the iommu on ARM? This is not needed on x86 because
> irq_remapping and IOMMU are at the same place but my understanding is
> that it is on ARM where
> - there is no connection between the MSI controller - which implements
> irq remapping - and the iommu
> - MSI are conveyed on the same address space as standard memory
> transactions.
> =

> 6)  can't we live with iommu/MSI controller respective location uncertain=
ty?
> =

> - in my current series, with the above Xilinx MSI controller, I would
> see there is an arm-smmu requiring mapping behind the PCI host, would
> query the characteristics of the MSI doorbell (not implemented by that
> controller), so no mapping would be done. So it would work I think.
> - However in case we have this topology: PCIe host -> MSI controller
> generally used behind an IOMMU (so registering a doorbell) -> IOMMU,
> this wouldn't work since the doorbell would be mapped.

Best Regards

Eric
> =

> =

> =

> =

> On 05/04/2016 01:54 PM, Eric Auger wrote:
>> This series allows the user-space to register a reserved IOVA domain.
>> This completes the kernel integration of the whole functionality on top
>> of part 1 (v9) & 2 (v8).
>>
>> It also depends on [PATCH 1/3] iommu: Add MMIO mapping type series,
>> http://comments.gmane.org/gmane.linux.kernel.iommu/12869
>>
>> We reuse the VFIO DMA MAP ioctl with a new flag to bridge to the
>> msi-iommu API. The need for provisioning such MSI IOVA range is reported
>> through capability chain, using VFIO_IOMMU_TYPE1_INFO_CAP_MSI_GEOMETRY.
>>
>> vfio_iommu_type1 checks if the MSI mapping is safe when attaching the
>> vfio group to the container (allow_unsafe_interrupts modality).
>>
>> On ARM/ARM64, the IOMMU does not astract IRQ remapping. the modality is
>> abstracted on MSI controller side. The GICv3 ITS is the first controller
>> advertising the modality.
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
>>   Intel X540-T2 (SR-IOV capable)
>> - also tested on Armada-7040 using an intel IXGBE (82599ES) by
>>   Yehuda Yitschak (v8)
>> - Not tested: ARM GICv3 ITS
>>
>> References:
>> [1] [RFC 0/2] VFIO: Add virtual MSI doorbell support
>>     (https://lkml.org/lkml/2015/7/24/135)
>> [2] [RFC PATCH 0/6] vfio: Add interface to map MSI pages
>>     (https://lists.cs.columbia.edu/pipermail/kvmarm/2015-September/01660=
7.html)
>> [3] [PATCH v2 0/3] Introduce MSI hardware mapping for VFIO
>>     (http://permalink.gmane.org/gmane.comp.emulators.kvm.arm.devel/3858)
>>
>> Git: complete series available at
>> https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v=
4.6-rc6-pcie-passthrough-v9
>>
>> previous version at
>> https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v=
4.6-rc5-pcie-passthrough-v8
>>
>> History:
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
>> - remove computation of nb IOVA pages -> will post a separate RFC for th=
at
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
>>   [this partially addresses Marc's comments on iommu_get/put_single_rese=
rved
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
>> - MSI controller natively programs the MSI addr with either the PA or IO=
VA.
>>   This is not done anymore in vfio-pci driver as suggested by Alex.
>> - check irq remapping capability of the group
>>
>> RFC v1 [2] -> PATCH v1:
>> - use the existing dma map/unmap ioctl interface with a flag to register=
 a
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
>> Eric Auger (7):
>>   vfio: introduce a vfio_dma type field
>>   vfio/type1: vfio_find_dma accepting a type argument
>>   vfio/type1: bypass unmap/unpin and replay for VFIO_IOVA_RESERVED slots
>>   vfio: allow reserved msi iova registration
>>   vfio/type1: also check IRQ remapping capability at msi domain
>>   iommu/arm-smmu: do not advertise IOMMU_CAP_INTR_REMAP
>>   vfio/type1: return MSI geometry through VFIO_IOMMU_GET_INFO capability
>>     chains
>>
>>  drivers/iommu/arm-smmu-v3.c     |   3 +-
>>  drivers/iommu/arm-smmu.c        |   3 +-
>>  drivers/vfio/vfio_iommu_type1.c | 270 +++++++++++++++++++++++++++++++++=
++++---
>>  include/uapi/linux/vfio.h       |  40 +++++-
>>  4 files changed, 298 insertions(+), 18 deletions(-)
>>
> =
