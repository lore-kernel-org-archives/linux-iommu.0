From: =?UTF-8?q?Hugh=20Sipi=C3=A8re?= <hgsipiere@gmail.com>
Subject: [PATCH] iommu: Place spaces after if for coding style
Date: Fri, 29 Dec 2017 18:36:49 +0000
Message-ID: <20171229183649.8833-1-hgsipiere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: dwmw2@infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Hugh=20Sipi=C3=A8re?= <hgsipiere@gmail.com>
List-Id: iommu@lists.linux-foundation.org

The code style states to use a space after if so I'm putting a space
between the if and open bracket in these two cases.

Signed-off-by: Hugh Sipière <hgsipiere@gmail.com>
---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4a2de34895ec..8d836d2e1b52 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4469,7 +4469,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 				((void *)rmrr) + rmrr->header.length,
 				rmrr->segment, rmrru->devices,
 				rmrru->devices_cnt);
-			if(ret < 0)
+			if (ret < 0)
 				return ret;
 		} else if (info->event == BUS_NOTIFY_REMOVED_DEVICE) {
 			dmar_remove_dev_scope(info, rmrr->segment,
@@ -4489,7 +4489,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 					atsru->devices_cnt);
 			if (ret > 0)
 				break;
-			else if(ret < 0)
+			else if (ret < 0)
 				return ret;
 		} else if (info->event == BUS_NOTIFY_REMOVED_DEVICE) {
 			if (dmar_remove_dev_scope(info, atsr->segment,
-- 
2.15.1
