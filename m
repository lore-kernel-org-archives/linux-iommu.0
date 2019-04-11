From: Tom Murphy <tmurphy@arista.com>
Subject: [PATCH 6/9] iommu/amd: Implement map_atomic
Date: Thu, 11 Apr 2019 19:47:35 +0100
Message-ID: <20190411184741.27540-7-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-rockchi
List-Id: iommu@lists.linux-foundation.org

Instead of using a spin lock I removed the mutex lock from both the
amd_iommu_map and amd_iommu_unmap path as well. iommu_map doesn’t lock
while mapping and so if iommu_map is called by two different threads on
the same iova region it results in a race condition even with the locks.
So the locking in amd_iommu_map and amd_iommu_unmap doesn't add any real
protection. The solution to this is for whatever manages the allocated
iova’s externally to make sure iommu_map isn’t called twice on the same
region at the same time.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2d4ee10626b4..b45e0e033adc 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3089,12 +3089,12 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
-static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
-			 phys_addr_t paddr, size_t page_size, int iommu_prot)
+static int __amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
+			 phys_addr_t paddr, size_t page_size, int iommu_prot,
+			 gfp_t gfp)
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	int prot = 0;
-	int ret;
 
 	if (domain->mode == PAGE_MODE_NONE)
 		return -EINVAL;
@@ -3104,11 +3104,21 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	mutex_lock(&domain->api_lock);
-	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
-	mutex_unlock(&domain->api_lock);
+	return iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
+}
 
-	return ret;
+static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
+			 phys_addr_t paddr, size_t page_size, int iommu_prot)
+{
+	return __amd_iommu_map(dom, iova, paddr, page_size, iommu_prot,
+			GFP_KERNEL);
+}
+
+static int amd_iommu_map_atomic(struct iommu_domain *dom, unsigned long iova,
+			 phys_addr_t paddr, size_t page_size, int iommu_prot)
+{
+	return __amd_iommu_map(dom, iova, paddr, page_size, iommu_prot,
+			GFP_ATOMIC);
 }
 
 static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
@@ -3262,6 +3272,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.attach_dev = amd_iommu_attach_device,
 	.detach_dev = amd_iommu_detach_device,
 	.map = amd_iommu_map,
+	.map_atomic = amd_iommu_map_atomic,
 	.unmap = amd_iommu_unmap,
 	.iova_to_phys = amd_iommu_iova_to_phys,
 	.add_device = amd_iommu_add_device,
-- 
2.17.1
