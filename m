From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 0/8] Introduce automatic DMA configuration for IOMMU masters
Date: Fri, 28 Nov 2014 13:29:38 +0000
Message-ID: <1417181386-18142-1-git-send-email-will.deacon@arm.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here is v5 of the patches I've previously sent here:

  RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
  RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
  RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
  RFCv4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302711.html

Changes since RFCv4 include:

  - Dropped the RFC tag, since has been used by a couple of people now

  - Dropped the DMA segment configuration from of_dma_configure, as there
    appear to be assumptions about 64k segments elsewhere in the kernel

  - Added acks/tested-bys (thanks to everybody who reviewed the series)

  - A few small fixes for issues found by Marek

Arnd: Is this too late for 3.19? We could merge the first 6 patches
with no issues, since there aren't any callers of of_iommu_init
without patch 7 anyway.

Up to you.

Will

--->8

Marek Szyprowski (1):
  iommu: fix initialization without 'add_device' callback

Will Deacon (7):
  iommu: provide early initialisation hook for IOMMU drivers
  dma-mapping: replace set_arch_dma_coherent_ops with arch_setup_dma_ops
  iommu: add new iommu_ops callback for adding an OF device
  iommu: provide helper function to configure an IOMMU for an of master
  dma-mapping: detect and configure IOMMU in of_dma_configure
  arm: call iommu_init before of_platform_populate
  arm: dma-mapping: plumb our iommu mapping ops into arch_setup_dma_ops

 arch/arm/include/asm/dma-mapping.h | 12 +++---
 arch/arm/kernel/setup.c            |  2 +
 arch/arm/mm/dma-mapping.c          | 83 ++++++++++++++++++++++++++++++++++----
 drivers/iommu/Kconfig              |  2 +-
 drivers/iommu/iommu.c              |  2 +-
 drivers/iommu/of_iommu.c           | 50 +++++++++++++++++++++++
 drivers/of/platform.c              | 50 ++++++++++++-----------
 include/asm-generic/vmlinux.lds.h  |  2 +
 include/linux/dma-mapping.h        | 13 +++---
 include/linux/iommu.h              |  8 ++++
 include/linux/of_iommu.h           | 31 ++++++++++++++
 11 files changed, 211 insertions(+), 44 deletions(-)

-- 
2.1.1
