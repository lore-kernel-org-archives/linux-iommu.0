From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu: arm/smmu: fixes for 3.13
Date: Fri, 6 Dec 2013 17:53:19 +0000
Message-ID: <20131206175319.GD8853@mudshark.cambridge.arm.com>
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
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Alex (CC'ing Joerg),

Please can you pull the following fixes to the arm/smmu driver for 3.13?

Cheers,

Will

--->8

The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:

  Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to 89a23cde75a7f0b3d8b0c156964eca0c23d2f1eb:

  iommu/arm-smmu: fix error return code in arm_smmu_device_dt_probe() (2013-12-06 16:44:25 +0000)

----------------------------------------------------------------
Wei Yongjun (1):
      iommu/arm-smmu: fix error return code in arm_smmu_device_dt_probe()

Will Deacon (2):
      iommu/arm-smmu: use mutex instead of spinlock for locking page tables
      iommu/arm-smmu: remove potential NULL dereference on mapping path

 drivers/iommu/arm-smmu.c | 66 ++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)
