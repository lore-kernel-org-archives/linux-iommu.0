From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/3] Exynos SYSMMU (IOMMU) updates for Exynos DRM
Date: Mon, 01 Jun 2015 13:15:13 +0200
Message-ID: <1433157316-6341-1-git-send-email-m.szyprowski@samsung.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

Main changes for Exynos SYSMMU (IOMMU) driver has been finally scheduled
for merging - see
https://git.kernel.org/cgit/linux/kernel/git/joro/iommu.git/commit/?h=next

To let Exynos IOMMU driver work correctly, some fixes are also needed in
Exynos DRM driver. To ease merge process I've decided to rebased Exynos
DRM changes onto latest exynos-drm-next tree from:
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git
exynos-drm-next

I've also added one more patch fixing issue, which can be observed when
upcoming IOMMU probe deferal patches has been applied. To hide
dma-mapping internals from Exynos DRM driver, a direct check for NULL
has been replaced by more error-proof comparison of dma_get_ops()
values.

Inki: could you queue those patches to exynos-drm-next and get them
merged to v4.2 to have it functional for the release?

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Marek Szyprowski (3):
  drm/exynos: fimd: ensure proper hw state in fimd_clear_channel()
  drm/exynos: iommu: detach from default dma-mapping domain on init
  drm/exynos: iommu: improve a check for non-iommu dma_ops

 drivers/gpu/drm/exynos/exynos_drm_fimd.c  | 26 +++++++++++++++++---------
 drivers/gpu/drm/exynos/exynos_drm_iommu.c |  7 +++++--
 2 files changed, 22 insertions(+), 11 deletions(-)

-- 
1.9.2
