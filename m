From: =?ISO-8859-1?Q?Radmila_Kompov=E1?= <xkompo00@stud.fit.vutbr.cz>
Subject: [PATCH 1/2] drivers/iommu/amd_iommu.c: fix resource leak in iommu_init_device()
Date: Thu, 02 May 2013 17:24:25 +0200
Message-ID: <51828529.90900@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Detected by cppcheck.

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
---
 drivers/iommu/amd_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8301837..5523ffb 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -448,8 +448,10 @@ static int iommu_init_device(struct device *dev)
 	}

 	ret = init_iommu_group(dev);
-	if (ret)
+	if (ret) {
+		free_dev_data(dev_data);
 		return ret;
+	}

 	if (pci_iommuv2_capable(pdev)) {
 		struct amd_iommu *iommu;
-- 
1.8.1.5
