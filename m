From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu: KVM PCIe/MSI passthrough on ARM/ARM64 for 4.11
Date: Fri, 27 Jan 2017 16:50:22 +0000
Message-ID: <20170127165021.GC10758@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull Eric's guest-MSI series for 4.11. This has been through
considerable review and associated rework (including a session at LPC),
but it has stabilised at last and we all seem to be happy with it. Eric's
done a great job of respinning these and remaining patient while we
pulled him in a bunch of different directions.

With these patches applied, it's possible for us to pass PCI devices
through to KVM guests on arm64 using VFIO and have them signal interrupts
using MSIs targetting the ITS via the SMMU. Acronym soup, sure, but it's
much better than legacy wired irqs!

Cheers,

Will

--->8

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git iommu/guest-msi

for you to fetch changes up to 5018c8d5ef0c172592eb98cf10e253d47b544ba8:

  iommu/arm-smmu: Do not advertise IOMMU_CAP_INTR_REMAP anymore (2017-01-23 15:00:47 +0000)

----------------------------------------------------------------
Eric Auger (17):
      iommu: Rename iommu_dm_regions into iommu_resv_regions
      iommu: Add a new type field in iommu_resv_region
      iommu: iommu_alloc_resv_region
      iommu: Only map direct mapped regions
      iommu: iommu_get_group_resv_regions
      iommu: Implement reserved_regions iommu-group sysfs file
      iommu/vt-d: Implement reserved region get/put callbacks
      iommu/amd: Declare MSI and HT regions as reserved IOVA regions
      iommu/arm-smmu: Implement reserved region get/put callbacks
      iommu/arm-smmu-v3: Implement reserved region get/put callbacks
      irqdomain: Add irq domain MSI and MSI_REMAP flags
      genirq/msi: Set IRQ_DOMAIN_FLAG_MSI on MSI domain creation
      irqdomain: irq_domain_check_msi_remap
      irqchip/gicv3-its: Sets IRQ_DOMAIN_FLAG_MSI_REMAP
      vfio/type1: Allow transparent MSI IOVA allocation
      vfio/type1: Check MSI remapping at irq domain level
      iommu/arm-smmu: Do not advertise IOMMU_CAP_INTR_REMAP anymore

Robin Murphy (1):
      iommu/dma: Allow MSI-only cookies

 .../ABI/testing/sysfs-kernel-iommu_groups          |  12 ++
 drivers/iommu/amd_iommu.c                          |  54 ++++---
 drivers/iommu/arm-smmu-v3.c                        |  30 +++-
 drivers/iommu/arm-smmu.c                           |  30 +++-
 drivers/iommu/dma-iommu.c                          | 119 +++++++++++---
 drivers/iommu/intel-iommu.c                        |  92 ++++++++---
 drivers/iommu/iommu.c                              | 177 +++++++++++++++++++--
 drivers/irqchip/irq-gic-v3-its.c                   |   1 +
 drivers/vfio/vfio_iommu_type1.c                    |  37 ++++-
 include/linux/dma-iommu.h                          |   6 +
 include/linux/iommu.h                              |  46 ++++--
 include/linux/irqdomain.h                          |  36 +++++
 kernel/irq/irqdomain.c                             |  39 +++++
 kernel/irq/msi.c                                   |   4 +-
 14 files changed, 590 insertions(+), 93 deletions(-)
