From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.19
Date: Fri, 27 Jul 2018 12:51:42 +0100
Message-ID: <20180727115141.GE25592@arm.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull these ARM SMMU updates for 4.19. Most of these are non-critical
fixes, but the main change is switching our default behaviour so that we
now abort transactions originating from unknown devices (i.e. those which
are not attached to an iommu domain) rather than silently let them bypass
the SMMU.

Cheers,

Will

--->8

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to b63b3439b85609338e4faabd5d2588dbda137e5c:

  iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel (2018-07-27 11:12:37 +0100)

----------------------------------------------------------------
Jean-Philippe Brucker (2):
      iommu/io-pgtable-arm: Fix pgtable allocation in selftest
      iommu/io-pgtable-arm-v7s: Abort allocation when table address overflows the PTE

Miao Zhong (1):
      iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer register

Vivek Gautam (1):
      iommu/arm-smmu: Error out only if not enough context interrupts

Will Deacon (1):
      iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel

Zhen Lei (1):
      iommu/arm-smmu-v3: Prevent any devices access to memory without registration

 drivers/iommu/arm-smmu-v3.c        | 25 ++++++++++++++++++-------
 drivers/iommu/arm-smmu.c           | 16 ++++++++++------
 drivers/iommu/io-pgtable-arm-v7s.c |  7 ++++++-
 drivers/iommu/io-pgtable-arm.c     |  3 ++-
 4 files changed, 36 insertions(+), 15 deletions(-)
