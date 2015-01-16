From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 13/18] iommu: exynos: add support for runtime_pm
Date: Fri, 16 Jan 2015 10:13:07 +0100
Message-ID: <1421399592-7482-14-git-send-email-m.szyprowski@samsung.com>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch fixes support for runtime power management for SYSMMU
controllers, so they are enabled when master device is attached.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c6cca44d7858..f8609f40ae59 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -695,6 +695,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	list_for_each_entry(data, &owner->clients, owner_node) {
+		pm_runtime_get_sync(data->sysmmu);
 		ret = __sysmmu_enable(data, pagetable, domain);
 		if (ret >= 0) {
 			data->master = dev;
@@ -736,6 +737,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 				data->master = NULL;
 				list_del_init(&data->domain_node);
 			}
+			pm_runtime_put(data->sysmmu);
 			found = true;
 		}
 	}
-- 
1.9.2
