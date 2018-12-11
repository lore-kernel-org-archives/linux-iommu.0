From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/9 v2] Access dev->iommu_fwspec through functions
Date: Tue, 11 Dec 2018 13:19:01 +0100
Message-ID: <20181211121910.5604-1-joro@8bytes.org>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

here is the second patch-set to wrap accesses to
dev->iommu_fwspec into functions so that the pointer
location can be changed more easily later on.

This version is rebased to v4.20-rc6 and addresses Robin's
comments. The Ack from will is also added.

If there are no objections I'd like to queue these patches
soon.

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

 drivers/acpi/arm64/iort.c    | 19 ++++++++++---------
 drivers/iommu/arm-smmu-v3.c  | 16 +++++++++-------
 drivers/iommu/arm-smmu.c     | 12 ++++++------
 drivers/iommu/dma-iommu.c    |  2 +-
 drivers/iommu/iommu.c        | 14 +++++++-------
 drivers/iommu/ipmmu-vmsa.c   | 12 ++++++++----
 drivers/iommu/mtk_iommu.c    | 21 ++++++++++++---------
 drivers/iommu/mtk_iommu_v1.c | 28 ++++++++++++++++------------
 drivers/iommu/of_iommu.c     | 10 +++++++---
 drivers/iommu/qcom_iommu.c   | 18 ++++++++++--------
 drivers/iommu/tegra-smmu.c   |  2 +-
 include/linux/iommu.h        | 11 +++++++++++
 12 files changed, 98 insertions(+), 67 deletions(-)

-- 
2.17.1
