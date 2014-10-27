From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH v2 0/6] vfio: type1: support for ARM SMMUS with
	VFIO_IOMMU_TYPE1
Date: Mon, 27 Oct 2014 19:05:49 +0100
Message-ID: <1414433155-31600-1-git-send-email-a.motakis@virtualopensystems.com>
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
To: kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch series makes the VFIO_IOMMU_TYPE1 driver buildable on ARM, so it
may be used with ARM SMMUs. It also adds support for the IOMMU_NOEXEC flag
supported by SMMUs adhering to the ARM SMMU specification so the VFIO user can
specify whether the target memory can be executed by the device behind the
SMMU.

Changes from v1:
 - Bugfixes and corrected some typos
 - Use enum for VFIO IOMMU driver capabilities

Antonios Motakis (6):
  vfio: implement iommu driver capabilities with an enum
  vfio: type1: support for platform bus devices on ARM
  vfio: introduce the VFIO_DMA_MAP_FLAG_NOEXEC flag
  vfio: type1: replace domain wide protection flags with supported
    capabilities
  vfio: type1: replace vfio_domains_have_iommu_cache with generic
    function
  vfio: type1: implement the VFIO_DMA_MAP_FLAG_NOEXEC flag

 drivers/vfio/Kconfig            |  2 +-
 drivers/vfio/vfio_iommu_type1.c | 85 ++++++++++++++++++++++++++++-------------
 include/uapi/linux/vfio.h       | 27 +++++++------
 3 files changed, 76 insertions(+), 38 deletions(-)

-- 
2.1.1
