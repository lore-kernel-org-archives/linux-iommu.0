From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch Part1 V2 18/20] iommu/vt-d, PCI, trivial: use dev_is_pci() instead of hardcoding
Date: Fri,  6 Dec 2013 11:21:21 +0800
Message-ID: <1386300083-6882-19-git-send-email-jiang.liu@linux.intel.com>
References: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ashok Raj <ashok.raj@intel.com>, Yijing Wang <wangyijing@huawei.com>, Jiri Kosina <trivial@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Use helper dev_is_pci() instead of hardcoding.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fc3473b..c1831d7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2700,7 +2700,7 @@ static int iommu_no_mapping(struct device *dev)
 	struct pci_dev *pdev;
 	int found;
 
-	if (unlikely(dev->bus != &pci_bus_type))
+	if (unlikely(!dev_is_pci(dev)))
 		return 1;
 
 	pdev = to_pci_dev(dev);
-- 
1.7.10.4
