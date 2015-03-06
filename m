From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/2] Kill off pgsize_bitmap field from struct iommu_ops
Date: Fri,  6 Mar 2015 11:34:46 +0000
Message-ID: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

These patches move the pgsize_bitmap field out of iommu_ops and into
the iommu_domain structure, as there are systems containing multiple
instances of a given IOMMU (e.g. the ARM SMMU) with different page size
support on the individual devices.

Once that's done, we can get back to treating the iommu_ops as constant,
since they just contain function pointers.

Comments welcome,

Will

--->8

Robin Murphy (1):
  iommu: of: enforce const-ness of struct iommu_ops

Will Deacon (1):
  iommu: move pgsize_bitmap from struct iommu_ops to struct iommu_domain

 arch/arm/include/asm/dma-mapping.h   |  2 +-
 arch/arm/mm/dma-mapping.c            |  6 +++---
 arch/arm64/include/asm/dma-mapping.h |  3 ++-
 drivers/iommu/amd_iommu.c            |  2 +-
 drivers/iommu/arm-smmu.c             | 12 +++++-------
 drivers/iommu/exynos-iommu.c         |  3 ++-
 drivers/iommu/intel-iommu.c          |  2 +-
 drivers/iommu/iommu.c                | 16 ++++++++--------
 drivers/iommu/ipmmu-vmsa.c           |  2 +-
 drivers/iommu/msm_iommu.c            |  3 ++-
 drivers/iommu/of_iommu.c             | 12 ++++++------
 drivers/iommu/omap-iommu.c           |  3 ++-
 drivers/iommu/rockchip-iommu.c       |  2 +-
 drivers/iommu/shmobile-iommu.c       |  2 +-
 drivers/iommu/tegra-gart.c           |  2 +-
 drivers/iommu/tegra-smmu.c           |  3 +--
 drivers/of/platform.c                |  2 +-
 drivers/vfio/vfio_iommu_type1.c      |  2 +-
 include/linux/dma-mapping.h          |  2 +-
 include/linux/iommu.h                |  6 +-----
 include/linux/of_iommu.h             |  8 ++++----
 21 files changed, 46 insertions(+), 49 deletions(-)

-- 
2.1.4
