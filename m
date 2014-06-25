From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch Part3 V3 01/21] iommu/vt-d: match segment number when searching for dev_iotlb capable devices
Date: Wed, 25 Jun 2014 17:02:27 +0800
Message-ID: <1403686967-10887-2-git-send-email-jiang.liu@linux.intel.com>
References: <1403686967-10887-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403686967-10887-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Yijing Wang <wangyijing@huawei.com>, Tony Luck <tony.luck@intel.com>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

For virtual machine and static identity domains, there may be devices
from different PCI segments associated with the same domain.
So function iommu_support_dev_iotlb() should also match PCI segment
number (iommu unit) when searching for dev_iotlb capable devices.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 51b6b77dc3e5..e29d963f3967 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1275,7 +1275,8 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry(info, &domain->devices, link)
-		if (info->bus == bus && info->devfn == devfn) {
+		if (info->iommu == iommu && info->bus == bus &&
+		    info->devfn == devfn) {
 			found = 1;
 			break;
 		}
-- 
1.7.10.4
