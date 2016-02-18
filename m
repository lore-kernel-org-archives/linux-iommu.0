From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/io-pgtable: Updates for 4.6
Date: Thu, 18 Feb 2016 17:49:18 +0000
Message-ID: <20160218174918.GF16883@arm.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Here are the io-pgtable updates from Robin for 4.6.

The bulk of this is adding support for the ARM v7s page table format,
which will be used by the Mediatek IOMMU driver from Yong Wu. Subsequent
work may also enable this format for the ARM SMMU.

Cheers,

Will

--->8

The following changes since commit 18558cae0272f8fd9647e69d3fec1565a7949865:

  Linux 4.5-rc4 (2016-02-14 13:05:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/io-pgtable

for you to fetch changes up to c8bff3a68f33b94e53f65aa9a4c0e9be34b6b514:

  MAINTAINERS: update ARM SMMU entry (2016-02-17 14:43:40 +0000)

----------------------------------------------------------------
Robin Murphy (4):
      iommu/io-pgtable: Add ARMv7 short descriptor support
      iommu/io-pgtable: Add helper functions for TLB ops
      iommu/io-pgtable: Avoid redundant TLB syncs
      iommu/io-pgtable: Rationalise quirk handling

Will Deacon (1):
      MAINTAINERS: update ARM SMMU entry

 MAINTAINERS                        |   2 +
 drivers/iommu/Kconfig              |  19 +
 drivers/iommu/Makefile             |   1 +
 drivers/iommu/io-pgtable-arm-v7s.c | 846 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c     |  34 +-
 drivers/iommu/io-pgtable.c         |   5 +-
 drivers/iommu/io-pgtable.h         |  53 ++-
 7 files changed, 943 insertions(+), 17 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-v7s.c
