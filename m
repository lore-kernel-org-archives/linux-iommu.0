From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v6 15/21] iommu/tegra: gart: Fix NULL pointer dereference
Date: Sun,  9 Dec 2018 23:29:44 +0300
Message-ID: <20181209202950.31486-16-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Fix NULL pointer dereference on IOMMU domain destruction that happens
because clients list is being iterated unsafely and its elements are
getting deleted during the iteration.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index d4a642c636f1..bb5303b06845 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -260,9 +260,9 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 	if (gart) {
 		spin_lock(&gart->client_lock);
 		if (!list_empty(&gart->client)) {
-			struct gart_client *c;
+			struct gart_client *c, *tmp;
 
-			list_for_each_entry(c, &gart->client, list)
+			list_for_each_entry_safe(c, tmp, &gart->client, list)
 				__gart_iommu_detach_dev(domain, c->dev);
 		}
 		spin_unlock(&gart->client_lock);
-- 
2.19.1
