From: Tom Murphy <tmurphy@arista.com>
Subject: [PATCH 5/9] iommu/amd: Implement .flush_np_cache
Date: Thu, 11 Apr 2019 19:47:34 +0100
Message-ID: <20190411184741.27540-6-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-rockchi
List-Id: iommu@lists.linux-foundation.org

Implement flush_np_cache for the AMD iommu driver. This allows the amd
iommu non present cache to be flushed if amd_iommu_np_cache is set.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b319e51c379b..2d4ee10626b4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1319,6 +1319,18 @@ static void domain_flush_devices(struct protection_domain *domain)
 		device_flush_dte(dev_data);
 }
 
+static void amd_iommu_flush_np_cache(struct iommu_domain *domain,
+		unsigned long iova, size_t size)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+
+	if (unlikely(amd_iommu_np_cache)) {
+		domain_flush_pages(dom, iova, size);
+		domain_flush_complete(dom);
+	}
+}
+
+
 /****************************************************************************
  *
  * The functions below are used the create the page table mappings for
@@ -3263,6 +3275,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
 	.iotlb_range_add = amd_iommu_iotlb_range_add,
 	.iotlb_sync = amd_iommu_flush_iotlb_all,
+	.flush_np_cache = amd_iommu_flush_np_cache,
 };
 
 /*****************************************************************************
-- 
2.17.1
