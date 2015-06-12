From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 0/6] vSMMU initialization
Date: Fri, 12 Jun 2015 16:20:04 +0200
Message-ID: <1434118810-28219-1-git-send-email-b.reynal@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
Cc: tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The ARM SMMU has support for 2-stages address translations, allowing a virtual
address to be translated at two levels:
- Stage 1 translates a virtual address (VA) into an intermediate physical
address (IPA)
- Stage 2 translates an IPA into a physical address (PA)

Will Deacon introduced a virtual SMMU interface for KVM, which gives a virtual
machine the possibility to use an IOMMU with native drivers. While the VM will
program the first stage of translation (stage 1), the interface will program
the second (stage 2) on the physical SMMU.

This RFC brings support for the vSMMU on QEMU-side, introducing the code for
vSMMU initialization and the device tree operations needed to attach devices
to it.

The main purpose of such vSMMU device is to allow VFIO devices to benefit
from an IOMMU on the guest side, for userspace drivers or nested VFIO.

It is an early state of development so:
- Interrupts are not handled for now
- Only one device can be bound to the vSMMU

I'm open to any comments or suggestions.

Baptiste Reynal (6):
  headers sync
  hw/core/platform-bus: initialization notifier
  hw/core/platform-bus: add base_address field
  hw/vfio: vsmmu device
  hw/arm/sysbus-fdt: enable vsmmu dynamic instantiation
  hw/arm/sysbus-fdt: add smmu masters in device tree

 hw/arm/sysbus-fdt.c             |  78 ++++++++++++++++++++
 hw/arm/virt.c                   |   4 +
 hw/core/platform-bus.c          |  13 ++++
 hw/vfio/Makefile.objs           |   1 +
 hw/vfio/common.c                |   8 +-
 hw/vfio/platform.c              |   2 +
 hw/vfio/smmu.c                  | 157 ++++++++++++++++++++++++++++++++++++++++
 include/hw/platform-bus.h       |   3 +
 include/hw/vfio/vfio-platform.h |   1 +
 include/hw/vfio/vfio-smmu.h     |  50 +++++++++++++
 linux-headers/linux/kvm.h       |  15 ++++
 11 files changed, 330 insertions(+), 2 deletions(-)
 create mode 100644 hw/vfio/smmu.c
 create mode 100644 include/hw/vfio/vfio-smmu.h

-- 
2.4.3
