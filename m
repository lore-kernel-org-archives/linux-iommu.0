From: Tom Murphy <tmurphy@arista.com>
Subject: [PATCH 9/9] iommu/amd: Add allocated domain to global list earlier
Date: Thu, 11 Apr 2019 19:47:38 +0100
Message-ID: <20190411184741.27540-10-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-rockchi
List-Id: iommu@lists.linux-foundation.org

dma_ops_domain_free() expects domain to be in a global list.
Arguably, could be called before protection_domain_init().

Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 02b351834a3b..bfb021d656aa 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1801,8 +1801,12 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	if (protection_domain_init(domain))
-		goto free_domain;
+	if (protection_domain_init(domain)) {
+		kfree(domain);
+		return NULL;
+	}
+
+	add_domain_to_list(domain);
 
 	domain->mode = PAGE_MODE_3_LEVEL;
 	domain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
@@ -1824,8 +1828,6 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	/* Initialize reserved ranges */
 	iommu_dma_copy_reserved_iova(&reserved_iova_ranges, &domain->domain);
 
-	add_domain_to_list(domain);
-
 	return domain;
 
 free_cookie:
-- 
2.17.1
