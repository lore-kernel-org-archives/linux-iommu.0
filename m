From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 3/3] iommu/vt-d: Use dev_is_pci() to check whether it is pci device
Date: Thu, 5 Dec 2013 19:43:42 +0800
Message-ID: <1386243822-23972-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>, Hanjun Guo <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Use PCI standard marco dev_is_pci() instead of directly compare
pci_bus_type to check whether it is pci device.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/iommu/intel-iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 43b9bfe..64d8942 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2758,7 +2758,7 @@ static int iommu_no_mapping(struct device *dev)
 	struct pci_dev *pdev;
 	int found;
 
-	if (unlikely(dev->bus != &pci_bus_type))
+	if (unlikely(!dev_is_pci(dev)))
 		return 1;
 
 	pdev = to_pci_dev(dev);
-- 
1.7.1
