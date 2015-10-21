From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/8] iommu: Make core iommu-groups code more generic
Date: Wed, 21 Oct 2015 23:51:35 +0200
Message-ID: <1445464303-18206-1-git-send-email-joro@8bytes.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

this patch-set makes the core code for managing iommu-groups
more generic by lifting its dependencies on PCI. The core
function iommu_group_get_for_dev() had a hard dev_is_pci()
check in it, followed by PCI specific handling.

This check is removed in favour of the the revived
device_group() iommu-ops call-back. With this call-back an
IOMMU driver can define how the devices it manages are
grouped together. Two functions, one generic and one for PCI
devices, are provided that can be uses as a device_group()
call-back or might be used in such a call-back.

The existing drivers making use of the iommu_group_get_for_dev()
function are converted to this call-back.

	
	Joerg

Joerg Roedel (8):
  iommu: Revive device_group iommu-ops call-back
  iommu: Export and rename iommu_group_get_for_pci_dev()
  iommu: Add generic_device_group() function
  iommu: Add device_group call-back to x86 iommu drivers
  iommu/fsl: Convert to device_group call-back
  iommu/arm-smmu: Switch to device_group call-back
  iommu: Remove is_pci_dev() fall-back from iommu_group_get_for_dev
  iommu: Move default domain allocation to iommu_group_get_for_dev()

 drivers/iommu/amd_iommu.c       |  1 +
 drivers/iommu/arm-smmu-v3.c     |  1 +
 drivers/iommu/arm-smmu.c        | 77 ++++++++++++++++++++++++-----------------
 drivers/iommu/fsl_pamu_domain.c | 41 +++++++++-------------
 drivers/iommu/intel-iommu.c     |  1 +
 drivers/iommu/iommu.c           | 46 +++++++++++++++++-------
 include/linux/iommu.h           |  7 +++-
 7 files changed, 105 insertions(+), 69 deletions(-)

-- 
1.9.1
