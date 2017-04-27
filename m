From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH 0/2] iommu/s390: Fix iommu-groups and add sysfs support
Date: Thu, 27 Apr 2017 17:28:23 +0200
Message-ID: <1493306905-32334-1-git-send-email-joro@8bytes.org>
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
To: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hey,

here are two patches for the s390 PCI and IOMMU code. It is
based on the assumption that every pci_dev that points to
the same zpci_dev shares a single dma-table (and thus a
single address space).

If this assupmtion is true (as it looks to me from reading
the code) then the iommu-group setup code in the s390 iommu
driver needs to be updated.

These patches do this and also add support for the
iommu_device_register interface to the s390 iommu driver.

Any comments and testing appreciated.

Thanks,

	Joerg

Joerg Roedel (2):
  iommu/s390: Fix IOMMU groups
  iommu/s390: Add support for iommu_device handling

 arch/s390/include/asm/pci.h |  8 +++++
 arch/s390/pci/pci.c         | 10 ++++++-
 drivers/iommu/s390-iommu.c  | 71 ++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 78 insertions(+), 11 deletions(-)

-- 
1.9.1
