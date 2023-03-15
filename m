Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C155669
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 16:42:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DC514B3;
	Wed, 15 Mar 2023 09:42:47 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.53.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22A1A3F67D;
	Wed, 15 Mar 2023 09:42:00 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
Date: Wed, 15 Mar 2023 16:41:52 +0000
Message-Id: <20230315164152.333251-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to exynos, we need a set_platform_dma_ops() callback for proper
operation on ARM 32 bit after recent changes in the IOMMU framework
(detach ops removal).

Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
Signed-off-by: Steven Price <steven.price@arm.com>
---
This fixes a splat I was seeing on a Firefly-RK3288, more details here:
https://lore.kernel.org/all/26a5d1b8-40b3-b1e4-bc85-740409c26838@arm.com/

 drivers/iommu/rockchip-iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index f30db22ea5d7..312a3df19904 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1183,6 +1183,12 @@ static int rk_iommu_of_xlate(struct device *dev,
 	return 0;
 }
 
+static void rk_iommu_set_platform_dma(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	rk_iommu_detach_device(domain, dev);
+}
+
 static const struct iommu_ops rk_iommu_ops = {
 	.domain_alloc = rk_iommu_domain_alloc,
 	.probe_device = rk_iommu_probe_device,
@@ -1190,6 +1196,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.device_group = rk_iommu_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
+	.set_platform_dma_ops = rk_iommu_set_platform_dma,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= rk_iommu_attach_device,
 		.map		= rk_iommu_map,
-- 
2.34.1

