From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Tue, 13 Sep 2016 13:40:20 +0100
Message-ID: <e24821be-5cc4-52b3-f961-1eb32cf58293@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
	<92f27a6b-9752-516d-3924-c552fc6a5ace@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <92f27a6b-9752-516d-3924-c552fc6a5ace-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

On 13/09/16 13:14, Auger Eric wrote:
> Hi Robin
> 
> On 12/09/2016 18:13, Robin Murphy wrote:
>> Hi all,
>>
>> To any more confusing fixups and crazily numbered extra patches, here's
>> a quick v7 with everything rebased into the right order. The significant
>> change this time is to implement iommu_fwspec properly from the start,
>> which ends up being far simpler and more robust than faffing about
>> introducing it somewhere 'less intrusive' to move toward core code later.
>>
>> New branch in the logical place:
>>
>> git://linux-arm.org/linux-rm iommu/generic-v7
> I just tested your branch on AMD overdrive *without* updating the device
> tree description according to the new syntax and I get a kernel oops.
> See logs attached. Continuing my investigations ...

Looking at that backtrace, it seems the offending commit is actually in
Will's devel branch _underneath_ this series; what's blowing up there is
the short-descriptor io-pgtable selftests, which you should be able to
reproduce on anything back to 4.6-rc1 with
CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST=y.

The short-descriptor code is never going to work on Seattle due to the
lack of 32-bit addressable memory - in normal use it would fail
gracefully because it couldn't allocate anything, but since the
selftests bypass the DMA API and corresponding checks, you end up with
nastiness happening via truncated addresses. A while back I did start
looking into generalising the selftests to remove all the "if
(!selftest_running)" special-casing; might be time to pick that up again.

Robin.

> 
> Best Regards
> 
> Eric
>>
>> Robin.
>>
>> Mark Rutland (1):
>>   Docs: dt: add PCI IOMMU map bindings
>>
>> Robin Murphy (21):
>>   of/irq: Break out msi-map lookup (again)
>>   iommu/of: Handle iommu-map property for PCI
>>   iommu: Introduce iommu_fwspec
>>   Docs: dt: document ARM SMMUv3 generic binding usage
>>   iommu/arm-smmu: Fall back to global bypass
>>   iommu/arm-smmu: Implement of_xlate() for SMMUv3
>>   iommu/arm-smmu: Support non-PCI devices with SMMUv3
>>   iommu/arm-smmu: Set PRIVCFG in stage 1 STEs
>>   iommu/arm-smmu: Handle stream IDs more dynamically
>>   iommu/arm-smmu: Consolidate stream map entry state
>>   iommu/arm-smmu: Keep track of S2CR state
>>   iommu/arm-smmu: Refactor mmu-masters handling
>>   iommu/arm-smmu: Streamline SMMU data lookups
>>   iommu/arm-smmu: Add a stream map entry iterator
>>   iommu/arm-smmu: Intelligent SMR allocation
>>   iommu/arm-smmu: Convert to iommu_fwspec
>>   Docs: dt: document ARM SMMU generic binding usage
>>   iommu/arm-smmu: Wire up generic configuration support
>>   iommu/arm-smmu: Set domain geometry
>>   iommu/dma: Add support for mapping MSIs
>>   iommu/dma: Avoid PCI host bridge windows
>>
>>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   8 +-
>>  .../devicetree/bindings/iommu/arm,smmu.txt         |  63 +-
>>  .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++
>>  arch/arm64/mm/dma-mapping.c                        |   2 +-
>>  drivers/gpu/drm/exynos/exynos_drm_iommu.h          |   2 +-
>>  drivers/iommu/Kconfig                              |   2 +-
>>  drivers/iommu/arm-smmu-v3.c                        | 386 +++++----
>>  drivers/iommu/arm-smmu.c                           | 962 ++++++++++-----------
>>  drivers/iommu/dma-iommu.c                          | 161 +++-
>>  drivers/iommu/iommu.c                              |  56 ++
>>  drivers/iommu/of_iommu.c                           |  52 +-
>>  drivers/irqchip/irq-gic-v2m.c                      |   3 +
>>  drivers/irqchip/irq-gic-v3-its.c                   |   3 +
>>  drivers/of/irq.c                                   |  78 +-
>>  drivers/of/of_pci.c                                | 102 +++
>>  include/linux/device.h                             |   3 +
>>  include/linux/dma-iommu.h                          |  12 +-
>>  include/linux/iommu.h                              |  38 +
>>  include/linux/of_pci.h                             |  10 +
>>  19 files changed, 1323 insertions(+), 791 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
>>
> 
> 
> 
