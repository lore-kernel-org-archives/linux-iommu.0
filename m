From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 00/13] SYSMMU driver update and support for Exynos 5433
Date: Thu, 18 Feb 2016 15:12:47 +0100
Message-ID: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

This patchset updates Exynos SYSMMU (IOMMU) driver to make use of the
new features in the IOMMU core (support for IOMMU_DOMAIN_DMA) and adds
support for SYSMMU v5 controllers, which are available in Samsung Exynos
5433 SoCs. The driver has been also updated to compile and work on ARM64
architecture.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Changelog:
v2:
- added support for multiple calls of device_attach (without detach),
  needed for default domain handling in iommu core (patch no 13), more
  information in the following thread:
  https://lists.linaro.org/pipermail/linaro-mm-sig/2016-February/004625.html
- fixed support for SYSMMU controllers with bogus version register value
  (patch no 9)

v1: http://www.spinics.net/lists/arm-kernel/msg483531.html
- initial version

Patch summary:

Marek Szyprowski (13):
  iommu: exynos: rework iommu group initialization
  iommu: exynos: add support for IOMMU_DOMAIN_DMA domain type
  iommu: exynos: remove ARM-specific cache flush interface
  iommu: exynos: simplify master clock operations
  iommu: exynos: refactor code (no direct register access)
  iommu: exynos: refactor fault handling code
  iommu: exynos: refactor init config code
  iommu: exynos: unify code for fldp cache invalidation
  iommu: exynos: add support for SYSMMU controller with bogus version
    reg
  iommu: exynos: update device tree documentation
  iommu: exynos: add support for v5 SYSMMU
  iommu: exynos: add Maintainers entry for Exynos SYSMMU driver
  iommu: exynos: support multiple attach_device calls

 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  22 +-
 MAINTAINERS                                        |   6 +
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/exynos-iommu.c                       | 598 ++++++++++++---------
 4 files changed, 372 insertions(+), 256 deletions(-)

-- 
1.9.2
