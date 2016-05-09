From: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla@cavium.com>
Subject: Re: [PATCH v9 0/8] KVM PCIe/MSI passthrough on ARM/ARM64: kernel part
 2/3: msi changes
Date: Mon, 9 May 2016 15:23:43 +0000
Message-ID: <50F1DA1B-3760-474F-A401-43AA26A5F6B6@caviumnetworks.com>
References: <1462375094-2390-1-git-send-email-eric.auger@linaro.org>
 <9C17BA6B-7304-47CA-A287-77FB41D96AD3@caviumnetworks.com>
 <573040D6.9050803@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <573040D6.9050803@linaro.org>
Content-Language: en-US
Content-ID: <C427F8189E047740AC6F061D0B830201@namprd07.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Auger <eric.auger@linaro.org>, "eric.auger@st.com" <eric.auger@st.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "yehuday@marvell.com" <yehuday@marvell.com>, "patches@linaro.org" <patches@linaro.org>, "Jean-Philippe.Brucker@arm.com" <Jean-Philippe.Brucker@arm.com>, "p.fedin@samsung.com" <p.fedin@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>, "julien.grall@arm.com" <julien.grall@arm.com>, "pranav.sawargaonkar@gmail.com" <pranav.sawargaonkar@gmail.com>
List-Id: iommu@lists.linux-foundation.org






On 5/9/16, 12:48 AM, "Eric Auger" <eric.auger@linaro.org> wrote:

>Hi Chalarmala,
>On 05/05/2016 07:44 PM, Chalamarla, Tirumalesh wrote:
>> Hi Eric,
>> 
>> Does this series supports gicv3-its emulation?
>> Do we have a tree with all the dependent patches
>GICv3 ITS emulation support comes with:
>[PATCH v4 00/12] KVM: arm64: GICv3 ITS emulation
>http://permalink.gmane.org/gmane.comp.emulators.kvm.arm.devel/5738
>
>My series just allows PCI device MSI transactions to reach the host MSI
>frame through the SMMU. Only host GICv2m has been tested at the moment
>with a guest exposed with a GICv2m too.


I wanted to test this series on Cavium Thunder, but the only mode supported is Gicv3 with ITS, is there a chance 
That I get a tree with all the dependencies?
>
>Best Regards
>
>Eric
>
>
>> 
>> 
>> 
>> 
>> 
>> Thanks,
>> Tirumalesh. 
>> On 5/4/16, 8:18 AM, "linux-arm-kernel on behalf of Eric Auger" <linux-arm-kernel-bounces@lists.infradead.org on behalf of eric.auger@linaro.org> wrote:
>> 
>>> This series implements the MSI address mapping/unmapping in the MSI layer.
>>> IOMMU binding happens on pci_enable_msi since this function can sleep and
>>> return errors. On msi_domain_set_affinity, msi_domain_(de)activate, which
>>> are not allowed to sleep, we simply look for the already existing binding.
>>>
>>> A new MSI domain info flag value is introduced to report whether the msi
>>> domain implements IRQ remapping. GIC v3 ITS is the first MSI controller
>>> advertising it. This flag value will be used by VFIO subsystem to
>>> determine whether MSI forwarding is safe.
>>>
>>> More details & context can be found at:
>>> http://www.linaro.org/blog/core-dump/kvm-pciemsi-passthrough-armarm64/
>>>
>>> Best Regards
>>>
>>> Eric
>>>
>>> Applies on top of PART 1/3. Also depends on
>>> [PATCH 1/3] iommu: Add MMIO mapping type,
>>> http://comments.gmane.org/gmane.linux.kernel.iommu/12869
>>>
>>> Git: complete series available at
>>> https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.6-rc6-pcie-passthrough-v9-msi-v9
>>>
>>> This branch contains all parts in v9.
>>>
>>> History:
>>>
>>> v8 -> v9:
>>> - use a union in irq_chip_msi_doorbell_info + boolean telling whether the
>>>  doorbell is percpu
>>> - decouple irq_data parsing from the actual mapping/unmapping in
>>>  msi_handle_doorbell_mappings
>>> - fix misc style issues
>>>
>>> v7 -> v8:
>>> take into account Marc's comments:
>>> - use iommu_msi_msg_pa_to_va with new proto
>>> - change in irq_chip_msi_doorbell_info struct definition:
>>>  prot and size became shared between all doorbells and phys_addr_t __percpu
>>> - cleanups in v2m irqchip
>>> - eventually did not touch MSI_FLAG_IRQ_REMAPPING naming
>>> - On msi_handle_doorbell_mappings, stop on the first irqchip where doorbells
>>>  can be found
>>> - fix resource deallocation on mapping failure in msi_domain_alloc_irqs
>>>
>>> v6 -> v7:
>>> - do alloc/map handling on pci_enable_msi and search on msi_(de)domain_activate
>>> - add msi_doorbell_info callback in irq-chip to retrieve the characteristics
>>>  of doorbells
>>>
>>> RFC v5 -> patch v6:
>>> - split to ease the review process
>>> - rebase on default iommu domain code (irq_data_to_msi_mapping_domain
>>>  checks IOMMU_DOMAIN_DMA type)
>>> - fix unmap sequence on msi_domain_set_affinity (reported by Marc):
>>>  unmap the previous doorbell when the new one has been mapped & written to
>>>  the device, ie. irq_chip_write_msi_msg.
>>> - "msi: msi_compose wrapper removed" following change above
>>> - add size parameter to iommu_get_reserved_iova API following Marc's request
>>>
>>> RFC v4 -> RFC v5:
>>> - take into account Thomas' comments on MSI related patches
>>>  - split "msi: IOMMU map the doorbell address when needed"
>>>  - increase readability and add comments
>>>  - fix style issues
>>> - split "iommu: Add DOMAIN_ATTR_MSI_MAPPING attribute"
>>> - platform ITS now advertises IOMMU_CAP_INTR_REMAP
>>> - fix compilation issue with CONFIG_IOMMU API unset
>>> - arm-smmu-v3 now advertises DOMAIN_ATTR_MSI_MAPPING
>>>
>>> RFC v3 -> v4:
>>> - Move doorbell mapping/unmapping in msi.c
>>> - fix ref count issue on set_affinity: in case of a change in the address
>>>  the previous address is decremented
>>> - doorbell map/unmap now is done on msi composition. Should allow the use
>>>  case for platform MSI controllers
>>> - create dma-reserved-iommu.h/c exposing/implementing a new API dedicated
>>>  to reserved IOVA management (looking like dma-iommu glue)
>>> - series reordering to ease the review:
>>>  - first part is related to IOMMU
>>>  - second related to MSI sub-system
>>>  - third related to VFIO (except arm-smmu IOMMU_CAP_INTR_REMAP removal)
>>> - expose the number of requested IOVA pages through VFIO_IOMMU_GET_INFO
>>>  [this partially addresses Marc's comments on iommu_get/put_single_reserved
>>>   size/alignment problematic - which I did not ignore - but I don't know
>>>   how much I can do at the moment]
>>>
>>> RFC v2 -> RFC v3:
>>> - should fix wrong handling of some CONFIG combinations:
>>>  CONFIG_IOVA, CONFIG_IOMMU_API, CONFIG_PCI_MSI_IRQ_DOMAIN
>>> - fix MSI_FLAG_IRQ_REMAPPING setting in GICv3 ITS (although not tested)
>>>
>>> PATCH v1 -> RFC v2:
>>> - reverted to RFC since it looks more reasonable ;-) the code is split
>>>  between VFIO, IOMMU, MSI controller and I am not sure I did the right
>>>  choices. Also API need to be further discussed.
>>> - iova API usage in arm-smmu.c.
>>> - MSI controller natively programs the MSI addr with either the PA or IOVA.
>>>  This is not done anymore in vfio-pci driver as suggested by Alex.
>>> - check irq remapping capability of the group
>>>
>>> RFC v1 [2] -> PATCH v1:
>>> - use the existing dma map/unmap ioctl interface with a flag to register a
>>>  reserved IOVA range. Use the legacy Rb to store this special vfio_dma.
>>> - a single reserved IOVA contiguous region now is allowed
>>> - use of an RB tree indexed by PA to store allocated reserved slots
>>> - use of a vfio_domain iova_domain to manage iova allocation within the
>>>  window provided by the userspace
>>> - vfio alloc_map/unmap_free take a vfio_group handle
>>> - vfio_group handle is cached in vfio_pci_device
>>> - add ref counting to bindings
>>> - user modality enabled at the end of the series
>>>
>>>
>>> Eric Auger (8):
>>>  genirq/msi: Add a new MSI_FLAG_IRQ_REMAPPING flag
>>>  irqchip/gic-v3-its: ITS advertises MSI_FLAG_IRQ_REMAPPING
>>>  genirq/msi: export msi_get_domain_info
>>>  genirq/msi: msi_compose wrapper
>>>  genirq/irq: introduce msi_doorbell_info
>>>  irqchip/gicv2m: implement msi_doorbell_info callback
>>>  genirq/msi: map/unmap the MSI doorbells on msi_domain_alloc/free_irqs
>>>  genirq/msi: use the MSI doorbell's IOVA when requested
>>>
>>> drivers/irqchip/irq-gic-v2m.c                 |  16 +++
>>> drivers/irqchip/irq-gic-v3-its-pci-msi.c      |   3 +-
>>> drivers/irqchip/irq-gic-v3-its-platform-msi.c |   3 +-
>>> include/linux/irq.h                           |  15 ++-
>>> include/linux/msi.h                           |   2 +
>>> kernel/irq/msi.c                              | 136 +++++++++++++++++++++++---
>>> 6 files changed, 161 insertions(+), 14 deletions(-)
>>>
>>> -- 
>>> 1.9.1
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
