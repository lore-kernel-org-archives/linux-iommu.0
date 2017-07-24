From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.13
Date: Mon, 24 Jul 2017 13:29:43 +0100
Message-ID: <20170724122943.GE29919@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please can you pull these arm-smmu/io-pgtable fixes for 4.13? The two main
things are:

  1. Ensure that we reject out-of-range map/unmap requests in the io-pgtable
     code (rather than operate on silently truncated addresses).

  2. Serialise TLB sync operations on arm-smmu, otherwise we can limit
     forward progress and cause timeouts in the driver (as observed by Ray).
     This undoes a previous micro-optimisation that is no longer sensible
     with the pgtable locsk removed, but which is required for correctness
     on the MTK IOMMU, so the MTK driver is updated to keep things working
     there.

Thanks,

Will

--->8

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to 76557391433c77d330cede1a531b358d2f90df66:

  iommu/io-pgtable: Sanitise map/unmap addresses (2017-07-20 10:30:28 +0100)

----------------------------------------------------------------
Robin Murphy (3):
      iommu/mtk: Avoid redundant TLB syncs locally
      Revert "iommu/io-pgtable: Avoid redundant TLB syncs"
      iommu/io-pgtable: Sanitise map/unmap addresses

Vivek Gautam (1):
      iommu/arm-smmu: Fix the error path in arm_smmu_add_device

Will Deacon (1):
      iommu/arm-smmu: Reintroduce locking around TLB sync operations

 drivers/iommu/arm-smmu.c           | 18 +++++++++++++-----
 drivers/iommu/io-pgtable-arm-v7s.c |  6 ++++++
 drivers/iommu/io-pgtable-arm.c     |  7 +++++++
 drivers/iommu/io-pgtable.h         |  9 +--------
 drivers/iommu/mtk_iommu.c          |  6 ++++++
 drivers/iommu/mtk_iommu.h          |  1 +
 6 files changed, 34 insertions(+), 13 deletions(-)
