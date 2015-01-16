From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/2] Reuse generic PCI DMA alias parsing code for the ARM SMMU
Date: Fri, 16 Jan 2015 16:58:32 +0000
Message-ID: <1421427514-16579-1-git-send-email-will.deacon@arm.com>
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
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: m-karicheri2-l0cyMroinI0@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

This series of two patches removes the (incomplete) PCI DMA alias parsing
code from the ARM SMMU driver and instead modifies the generic
iommu_group_get_for_pci_dev implementation to return the alias as well as
the group.

One snag is that iommu_group_get_for_pci_dev is no longer static after
the change, but returning the alias from iommu_group_get_for_dev doesn't
feel right either, as we don't currently have any generic IOMMU grouping
for the platform bus.

Feedback welcome,

Will

--->8

Will Deacon (2):
  iommu: return dma alias from iommu_group_get_for_pci_dev()
  iommu/arm-smmu: remove homebrew PCI dma alias parsing

 drivers/iommu/arm-smmu.c | 58 ++++++++++++++++++++++++++----------------------
 drivers/iommu/iommu.c    | 14 ++++++++++--
 include/linux/iommu.h    |  2 ++
 3 files changed, 45 insertions(+), 29 deletions(-)

-- 
2.1.4
