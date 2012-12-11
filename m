From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v5 01/14] iommu/exynos: add missing cache flush for removed
 pagetable entries
Date: Tue, 11 Dec 2012 20:07:59 +0900
Message-ID: <003101cdd78f$c7e8f280$57bad780$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Cc: 'Dae Inki' <inki.dae@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahun Sharma' <rahul.sharma@samsung.com>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, 'Subash Patel' <subash.ramaswamy@linaro.org>, 'SWKim' <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This commit adds cache flush for removed small page and large page
entries in exynos_iommu_unmap(). Missing cache flush of removed
page table entries can cause missing page fault interrupt when a
master IP accesses an unmapped area.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7fe44f8..b96f3b9 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1002,6 +1002,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 
 	if (lv2ent_small(ent)) {
 		*ent = 0;
+		pgtable_flush(ent, ent + 1);
 		size = SPAGE_SIZE;
 		priv->lv2entcnt[lv1ent_offset(iova)] += 1;
 		goto done;
@@ -1011,6 +1012,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	BUG_ON(size < LPAGE_SIZE);
 
 	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
+	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
 
 	size = LPAGE_SIZE;
 	priv->lv2entcnt[lv1ent_offset(iova)] += SPAGES_PER_LPAGE;
-- 
1.8.0
