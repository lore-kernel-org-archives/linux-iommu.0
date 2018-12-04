From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/9] Access dev->iommu_fwspec through functions
Date: Tue,  4 Dec 2018 17:29:53 +0100
Message-ID: <20181204163002.15800-1-joro@8bytes.org>
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
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a patch-set to wrap accesses to dev->iommu_fwspec
into functions. This will make it easier to move the pointer
into a separate struct and consolitdate the iommu-related
pointers in 'struct device'.

Regards,

	Joerg

Joerg Roedel (9):
  iommu: Introduce wrappers around dev->iommu_fwspec
  ACPI/IORT: Use helper functions to access dev->iommu_fwspec
  iommu/arm-smmu: Use helper functions to access dev->iommu_fwspec
  iommu/dma: Use helper functions to access dev->iommu_fwspec
  iommu/ipmmu-vmsa: Use helper functions to access dev->iommu_fwspec
  iommu/mediatek: Use helper functions to access dev->iommu_fwspec
  iommu/of: Use helper functions to access dev->iommu_fwspec
  iommu/qcom: Use helper functions to access dev->iommu_fwspec
  iommu/tegra: Use helper functions to access dev->iommu_fwspec

 drivers/acpi/arm64/iort.c    | 12 +++++++-----
 drivers/iommu/arm-smmu-v3.c  | 16 +++++++++-------
 drivers/iommu/arm-smmu.c     | 12 ++++++------
 drivers/iommu/dma-iommu.c    |  2 +-
 drivers/iommu/iommu.c        | 14 +++++++-------
 drivers/iommu/ipmmu-vmsa.c   | 12 ++++++++----
 drivers/iommu/mtk_iommu.c    | 21 ++++++++++++---------
 drivers/iommu/mtk_iommu_v1.c | 28 ++++++++++++++++------------
 drivers/iommu/of_iommu.c     |  7 +++++--
 drivers/iommu/qcom_iommu.c   | 18 ++++++++++--------
 drivers/iommu/tegra-smmu.c   |  2 +-
 include/linux/iommu.h        | 11 +++++++++++
 12 files changed, 93 insertions(+), 62 deletions(-)

-- 
2.17.1
