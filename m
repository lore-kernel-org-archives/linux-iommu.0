From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 12/13] iommu: exynos: add Maintainers entry for Exynos
 SYSMMU driver
Date: Thu, 18 Feb 2016 15:12:59 +0100
Message-ID: <1455804780-9616-13-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Add Marek Szyprowski as maintainer for Exynos IOMMU driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc2f753cb357..4afc061e878a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4305,6 +4305,12 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 F:	drivers/gpu/drm/exynos/exynos_dp*
 
+EXYNOS SYSMMU (IOMMU) driver
+M:	Marek Szyprowski <m.szyprowski@samsung.com>
+L:	iommu@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/iommu/exynos-iommu.c
+
 EXYNOS MIPI DISPLAY DRIVERS
 M:	Inki Dae <inki.dae@samsung.com>
 M:	Donghwa Lee <dh09.lee@samsung.com>
-- 
1.9.2
