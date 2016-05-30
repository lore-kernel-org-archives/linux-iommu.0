From: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 0/6] vfio-pci: Add support for mmapping MSI-X table
Date: Mon, 30 May 2016 21:32:07 +0800
Message-ID: <201605301337.u4UDY6Os028683@mx0a-001b2d01.pphosted.com>
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
To: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org, nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Current vfio-pci implementation disallows to mmap the page
containing MSI-X table in case that users can write directly
to MSI-X table and generate an incorrect MSIs.

However, this will cause some performance issue when there
are some critical device registers in the same page as the 
MSI-X table. We have to handle the mmio access to these
registers in QEMU emulation rather than in guest.

To solve this issue, this series allows to expose MSI-X table
to userspace when hardware enables the capability of interrupt
remapping which can ensure that a given PCI device can only
shoot the MSIs assigned for it. And we introduce a new bus_flags
PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
for different archs.

The patch 3 are based on the proposed patchset[1].

Changelog v2: 
- Make the commit log more clear
- Replace pci_bus_check_msi_remapping() with pci_bus_msi_isolated()
  so that we could clearly know what the function does
- Set PCI_BUS_FLAGS_MSI_REMAP in pci_create_root_bus() instead
  of iommu_bus_notifier()
- Reserve VFIO_REGION_INFO_FLAG_CAPS when we allow to mmap MSI-X
  table so that we can know whether we allow to mmap MSI-X table
  in QEMU

[1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html

Yongji Xie (6):
  PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
  PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller enables IRQ remapping
  PCI: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
  iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu driver initialization
  pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
  vfio-pci: Allow to expose MSI-X table to userspace if interrupt remapping is enabled

 arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
 drivers/iommu/iommu.c                     |    8 ++++++++
 drivers/pci/msi.c                         |   15 +++++++++++++++
 drivers/pci/probe.c                       |    7 +++++++
 drivers/vfio/pci/vfio_pci.c               |   17 ++++++++++++++---
 drivers/vfio/pci/vfio_pci_rdwr.c          |    3 ++-
 include/linux/msi.h                       |    5 ++++-
 include/linux/pci.h                       |    1 +
 8 files changed, 59 insertions(+), 5 deletions(-)

-- 
1.7.9.5
