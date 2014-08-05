From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 11/29] DRM: exynos: add DRIVER_HAS_OWN_IOMMU_MANAGER flag to
 all sub-drivers
Date: Tue, 05 Aug 2014 12:47:39 +0200
Message-ID: <1407235677-26324-12-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tomasz.figa@gmail.com>, linaro-mm-sig@lists.linaro.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Cho KyongHo <pullip.cho@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Exynos DRM drivers do their own management of IO address space of all
controlled devices, so set DRIVER_HAS_OWN_IOMMU_MANAGER flag to instruct
IOMMU subsystem not to create any defaults for them.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimc.c    | 1 +
 drivers/gpu/drm/exynos/exynos_drm_fimd.c    | 1 +
 drivers/gpu/drm/exynos/exynos_drm_g2d.c     | 1 +
 drivers/gpu/drm/exynos/exynos_drm_gsc.c     | 1 +
 drivers/gpu/drm/exynos/exynos_drm_rotator.c | 1 +
 drivers/gpu/drm/exynos/exynos_mixer.c       | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index 831dde9..fe84215 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -1896,6 +1896,7 @@ struct platform_driver fimc_driver = {
 		.name	= "exynos-drm-fimc",
 		.owner	= THIS_MODULE,
 		.pm	= &fimc_pm_ops,
+		.flags	= DRIVER_HAS_OWN_IOMMU_MANAGER,
 	},
 };
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 33161ad..41904df 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -1031,5 +1031,6 @@ struct platform_driver fimd_driver = {
 		.name	= "exynos4-fb",
 		.owner	= THIS_MODULE,
 		.of_match_table = fimd_driver_dt_match,
+		.flags	= DRIVER_HAS_OWN_IOMMU_MANAGER,
 	},
 };
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 8001587..dddeae3 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1555,5 +1555,6 @@ struct platform_driver g2d_driver = {
 		.owner	= THIS_MODULE,
 		.pm	= &g2d_pm_ops,
 		.of_match_table = exynos_g2d_match,
+		.flags	= DRIVER_HAS_OWN_IOMMU_MANAGER,
 	},
 };
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 9e3ff16..76e8b1e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1797,6 +1797,7 @@ struct platform_driver gsc_driver = {
 		.name	= "exynos-drm-gsc",
 		.owner	= THIS_MODULE,
 		.pm	= &gsc_pm_ops,
+		.flags	= DRIVER_HAS_OWN_IOMMU_MANAGER,
 	},
 };
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
index f01fbb6..2da91c4 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -852,5 +852,6 @@ struct platform_driver rotator_driver = {
 		.owner	= THIS_MODULE,
 		.pm	= &rotator_pm_ops,
 		.of_match_table = exynos_rotator_match,
+		.flags	= DRIVER_HAS_OWN_IOMMU_MANAGER,
 	},
 };
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 7529946..79b1309a 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -1320,6 +1320,7 @@ struct platform_driver mixer_driver = {
 		.name = "exynos-mixer",
 		.owner = THIS_MODULE,
 		.of_match_table = mixer_match_types,
+		.flags	= DRIVER_HAS_OWN_IOMMU_MANAGER,
 	},
 	.probe = mixer_probe,
 	.remove = mixer_remove,
-- 
1.9.2
