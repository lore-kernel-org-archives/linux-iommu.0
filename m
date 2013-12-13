From: Youquan Song <youquan.song@intel.com>
Subject: [PATCH 3/3] dmar: reduce loop to find multi-devices owned by IOMMU
Date: Fri, 13 Dec 2013 00:16:27 -0500
Message-ID: <1386911787-25375-3-git-send-email-youquan.song@intel.com>
References: <1386911787-25375-1-git-send-email-youquan.song@intel.com>
 <1386911787-25375-2-git-send-email-youquan.song@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386911787-25375-2-git-send-email-youquan.song@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, David Woodhouse <David.Woodhouse@intel.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Youquan Song <youquan.song@linux.intel.com>, Youquan Song <youquan.song@intel.com>, zhiyuan.zhou@intel.com
List-Id: iommu@lists.linux-foundation.org

When try to find if the iommu owns other devices in the domain except the 
device will be moved. It will loop all devices under the domain if the removed
device is the first device in domain devices list.

This patch will improve it and it only loop before find the removed device and
 one of other device, so save the loop time and make the code more clear.

Signed-off-by: Youquan Song <youquan.song@intel.com>
---
 drivers/iommu/intel-iommu.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index aa821fc..9f3bf3f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3785,7 +3785,7 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 	struct device_domain_info *info, *tmp;
 	struct intel_iommu *iommu;
 	unsigned long flags;
-	int found = 0;
+	int found = 0, del = 0;
 
 	iommu = device_to_iommu(pci_domain_nr(pdev->bus), pdev->bus->number,
 				pdev->devfn);
@@ -3806,16 +3806,13 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 			free_devinfo_mem(info);
 
 			spin_lock_irqsave(&device_domain_lock, flags);
-
-			if (found)
-				break;
-			else
-				continue;
-		}
-
-		if (iommu == device_to_iommu(info->segment, info->bus,
+			del = 1;
+		} else if (iommu == device_to_iommu(info->segment, info->bus,
 					    info->devfn))
 			found = 1;
+
+		if (found & del)
+			break;
 	}
 
 	spin_unlock_irqrestore(&device_domain_lock, flags);
-- 
1.7.7.4
