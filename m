From: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/5] vfio-pci: Add support for mmapping MSI-X table
Date: Wed, 27 Apr 2016 20:43:25 +0800
Message-ID: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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
Cc: alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org, nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Current vfio-pci implementation disallows to mmap the page 
containing MSI-X table in case that users can write to MSI-X
table and generate an incorrect MSIs.

However, this will cause some performance issue when there
are some critical device registers in the same page as the 
MSI-X table. We have to handle the mmio access to these 
registers in QEMU emulation rather than in guest.

To solve this issue, this series allows to mmap MSI-X table 
when hardware supports the capability of interrupt remapping 
which can ensure that a given pci device can only shoot the 
MSIs assigned for it. And we introduce a new bus_flags 
PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side 
for different archs.

The patch 3 are based on the proposed patchset[1].

[1] http://www.spinics.net/lists/kvm/msg130256.html

Yongji Xie (5):
  PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
  iommu: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
  PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller supports IRQ remapping
  pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
  vfio-pci: Allow to mmap MSI-X table if interrupt remapping is supported

 arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
 drivers/iommu/iommu.c                     |   15 +++++++++++++++
 drivers/pci/msi.c                         |   12 ++++++++++++
 drivers/pci/probe.c                       |    3 +++
 drivers/vfio/pci/vfio_pci.c               |    7 +++++--
 drivers/vfio/pci/vfio_pci_rdwr.c          |    3 ++-
 include/linux/msi.h                       |    6 +++++-
 include/linux/pci.h                       |    1 +
 8 files changed, 51 insertions(+), 4 deletions(-)

-- 
1.7.9.5
