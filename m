From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/7] IOMMU: Groups support
Date: Tue, 29 May 2012 23:10:01 -0600
Message-ID: <20120530045150.1543.73660.stgit@bling.home>
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
To: joerg.roedel-5C7GfCeVMHo@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

These are the IOMMU related patches from the v2 IOMMU Groups +
VFIO series.  I've separated out PCI and VFIO to try to make
progress on the foundation we need for VFIO.  Patches 5 & 6
of this series depend on patches 1 & 2 of the PCI series found
here:

http://marc.info/?l=linux-kernel&m=133835363021384

Patch 1 adds an iommu_group pointer to struct device so that we
have a place to link a device to a specific iommu group.  GregKH
has already acked this, so it should go in with the group support
itself.  Patch 2 is the core of the IOMMU group support.  Patches
3 & 4 allow groups to be created on AMD-Vi and Intel VT-d systems.
Patches 5 & 6 make use of the additional PCI DMA quirks and ACS
support checking to make groups more secure.  Patch 7 removes the
iommu=group_mf option as ACS checking results in most multifunction
devices being grouped already.

These patches, as well as the PCI support patches and VFIO can be
found in git here:

git://github.com/awilliam/linux-vfio.git (iommu-group-vfio-next-20120529)

Please consider these for 3.5, but I'll settle for any kind of next
branch.  Thanks,

Alex

---

Alex Williamson (7):
      iommu: Remove group_mf
      intel-iommu: Make use of DMA quirks and ACS checks in IOMMU groups
      amd_iommu: Make use of DMA quirks and ACS checks in IOMMU groups
      intel-iommu: Support IOMMU groups
      amd_iommu: Support IOMMU groups
      iommu: IOMMU Groups
      driver core: Add iommu_group tracking to struct device


 .../ABI/testing/sysfs-kernel-iommu_groups          |   14 
 Documentation/kernel-parameters.txt                |    1 
 arch/ia64/include/asm/iommu.h                      |    2 
 arch/ia64/kernel/pci-dma.c                         |    1 
 arch/x86/include/asm/iommu.h                       |    1 
 arch/x86/kernel/pci-dma.c                          |   11 
 drivers/iommu/amd_iommu.c                          |   62 +-
 drivers/iommu/intel-iommu.c                        |   82 ++-
 drivers/iommu/iommu.c                              |  578 +++++++++++++++++++-
 include/linux/device.h                             |    2 
 include/linux/iommu.h                              |  104 +++-
 11 files changed, 751 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-iommu_groups
