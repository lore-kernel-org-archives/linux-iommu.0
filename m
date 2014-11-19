From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.19
Date: Wed, 19 Nov 2014 19:00:06 +0000
Message-ID: <20141119190006.GL15985@arm.com>
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
Cc: a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please can you pull these ARM SMMU changes for 3.19? As well as the
usual driver updates (enabling support for the new NESTING attribute),
there are also the IOMMU_NOEXEC patches from Antonios, which includes
a fix for a resulting compiler warning in the AMD IOMMU driver.

Cheers,

Will

--->8

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to c752ce45b213de8532baaf987ba930638f77c439:

  iommu/arm-smmu: add support for DOMAIN_ATTR_NESTING attribute (2014-11-14 14:41:39 +0000)

----------------------------------------------------------------
Antonios Motakis (3):
      iommu/arm-smmu: change IOMMU_EXEC to IOMMU_NOEXEC
      iommu: add capability IOMMU_CAP_NOEXEC
      iommu/arm-smmu: add IOMMU_CAP_NOEXEC to the ARM SMMU driver

Thierry Reding (1):
      iommu/arm-smmu: Play nice on non-ARM/SMMU systems

Will Deacon (2):
      iommu/amd: remove compiler warning due to IOMMU_CAP_NOEXEC
      iommu/arm-smmu: add support for DOMAIN_ATTR_NESTING attribute

 drivers/iommu/amd_iommu.c |   2 +
 drivers/iommu/arm-smmu.c  | 133 +++++++++++++++++++++++++++++++++++++---------
 include/linux/iommu.h     |   3 +-
 3 files changed, 113 insertions(+), 25 deletions(-)
