From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/5] io-pgtable fixes + ARM short-descriptor format
Date: Fri,  4 Dec 2015 17:52:57 +0000
Message-ID: <cover.1449246988.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This has been tested on an MMU-500 Fast Model, with the ARM SMMU driver
hacked up to force short-descriptor at stage 1 - doing it properly needs
more work to decouple the context format from the kernel bit-ness. Since
I didn't want to delay getting this lot posted, that can come later.

Thanks,
Robin.

Robin Murphy (5):
  iommu/io-pgtable-arm: Avoid dereferencing bogus PTEs
  iommu/io-pgtable: Indicate granule for TLB maintenance
  iommu/arm-smmu: Invalidate TLBs properly
  iommu/io-pgtable: Make io_pgtable_ops_to_pgtable() macro common
  iommu/io-pgtable: Add ARMv7 short descriptor support

 drivers/iommu/Kconfig              |  19 +
 drivers/iommu/Makefile             |   1 +
 drivers/iommu/arm-smmu-v3.c        |   2 +-
 drivers/iommu/arm-smmu.c           |  21 +-
 drivers/iommu/io-pgtable-arm-v7s.c | 836 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c     |  38 +-
 drivers/iommu/io-pgtable.c         |   3 +
 drivers/iommu/io-pgtable.h         |  20 +-
 drivers/iommu/ipmmu-vmsa.c         |   4 +-
 9 files changed, 916 insertions(+), 28 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-v7s.c

-- 
1.9.1
