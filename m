From: Anup Patel via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH 0/5] FlexRM support in VFIO platform
Date: Wed, 19 Jul 2017 15:03:53 +0530
Message-ID: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
Reply-To: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patchset primarily adds Broadcom FlexRM reset module for
VFIO platform driver. We also have minor improvments in IOMMU
and VFIO driver to allow VFIO no-IOMMU mode access to FlexRM.

The patches are based on Linux-4.13-rc1 and can also be
found at flexrm-vfio-v1 branch of
https://github.com/Broadcom/arm64-linux.git

Anup Patel (5):
  iommu: Add capability IOMMU_CAP_BYPASS
  iommu/arm-smmu: add IOMMU_CAP_BYPASS to the ARM SMMU driver
  iommu/arm-smmu-v3: add IOMMU_CAP_BYPASS to the ARM SMMUv3 driver
  vfio: Allow No-IOMMU mode for IOMMUs with bypass capability
  vfio: platform: reset: Add Broadcom FlexRM reset module

 drivers/iommu/arm-smmu-v3.c                        |  2 +
 drivers/iommu/arm-smmu.c                           |  2 +
 drivers/vfio/platform/reset/Kconfig                |  9 +++
 drivers/vfio/platform/reset/Makefile               |  1 +
 .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 91 ++++++++++++++++++++++
 drivers/vfio/vfio.c                                | 13 +++-
 include/linux/iommu.h                              |  4 +
 7 files changed, 119 insertions(+), 3 deletions(-)
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c

-- 
2.7.4
