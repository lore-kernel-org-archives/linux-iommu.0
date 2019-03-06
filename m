From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 2/3] iommu/tegra-smmu: Properly release domain resources
Date: Thu,  7 Mar 2019 01:50:08 +0300
Message-ID: <20190306225009.3391-3-digetx@gmail.com>
References: <20190306225009.3391-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306225009.3391-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Release all memory allocations associated with a released domain and emit
warning if domain is in-use at the time of destruction.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 8d30653cd13a..27b1249f0773 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -327,6 +327,9 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
 
 	/* TODO: free page directory and page tables */
 
+	WARN_ON_ONCE(as->use_count);
+	kfree(as->count);
+	kfree(as->pts);
 	kfree(as);
 }
 
-- 
2.20.1
