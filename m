From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.14
Date: Tue, 17 Dec 2013 18:08:54 +0000
Message-ID: <20131217180854.GG349@mudshark.cambridge.arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg, Alex,

Please pull the arm-smmu updates below for 3.14. The main changes are adding
an IOMMU_EXEC flag to allow for non-executable mappings (in response to work
that rmk has done for the CPU-side of things) and automatically adding
devices to an IOMMU group.

Thanks,

Will

--->8

The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to cf2d45b19ddb361241f36d8c9f3d0b234a18459b:

  iommu/arm-smmu: add support for IOMMU_EXEC (2013-12-16 19:30:32 +0000)

----------------------------------------------------------------
Antonios Motakis (1):
      iommu/arm-smmu: add devices attached to the SMMU to an IOMMU group

Will Deacon (3):
      iommu/arm-smmu: use VA_BITS to determine arm64 virtual address space
      iommu: add IOMMU_EXEC flag for safely allowing XN mappings
      iommu/arm-smmu: add support for IOMMU_EXEC

 drivers/iommu/arm-smmu.c | 33 ++++++++++++++++++++++++++-------
 include/linux/iommu.h    |  7 ++++---
 2 files changed, 30 insertions(+), 10 deletions(-)
