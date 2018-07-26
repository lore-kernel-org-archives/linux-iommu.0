From: Dmitry Osipenko <digetx@gmail.com>
Subject: [RFC PATCH v1 5/6] drm/nouveau: tegra: Universally avoid implicit DMA backing with IOMMU
Date: Fri, 27 Jul 2018 02:16:23 +0300
Message-ID: <20180726231624.21084-6-digetx@gmail.com>
References: <20180726231624.21084-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726231624.21084-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <cyndis@kapsi.fi>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Nicolas Chauvet <kwizart@gmail.com>
Cc: devicetree@vger.kernel.org, nouveau@lists.freedesktop.org, iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Implicit backing DMA with IOMMU breaks Nouveau on Tegra, the current
approach with detaching device from IOMMU that was added in commit
b59fb482b522 ("drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping")
works only for arm32 which has the CONFIG_ARM_DMA_USE_IOMMU, but not for
arm64 which doesn't have that config option. Drivers core now allows to
avoid the implicit backing, that is a universal solution unlike the
current variant with the detaching.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_platform.c b/drivers/gpu/drm/nouveau/nouveau_platform.c
index 039e23548e08..0b57f4f9b638 100644
--- a/drivers/gpu/drm/nouveau/nouveau_platform.c
+++ b/drivers/gpu/drm/nouveau/nouveau_platform.c
@@ -90,6 +90,7 @@ MODULE_DEVICE_TABLE(of, nouveau_platform_match);
 struct platform_driver nouveau_platform_driver = {
 	.driver = {
 		.name = "nouveau",
+		.no_implicit_iommu = true,
 		.of_match_table = of_match_ptr(nouveau_platform_match),
 	},
 	.probe = nouveau_platform_probe,
-- 
2.18.0
