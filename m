From: Andreea-Cristina Bernat <bernat.ada@gmail.com>
Subject: [PATCH] iommu: Replace rcu_assign_pointer() with RCU_INIT_POINTER()
Date: Mon, 18 Aug 2014 15:20:56 +0300
Message-ID: <20140818122056.GA29961@ada>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com
List-Id: iommu@lists.linux-foundation.org

The use of "rcu_assign_pointer()" is NULLing out the pointer.
According to RCU_INIT_POINTER()'s block comment:
"1.   This use of RCU_INIT_POINTER() is NULLing out the pointer"
it is better to use it instead of rcu_assign_pointer() because it has a
smaller overhead.

The following Coccinelle semantic patch was used:
@@
@@

- rcu_assign_pointer
+ RCU_INIT_POINTER
  (..., NULL)

Signed-off-by: Andreea-Cristina Bernat <bernat.ada@gmail.com>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9a4f05e..da9220b 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -246,7 +246,7 @@ int dmar_remove_dev_scope(struct dmar_pci_notify_info *info, u16 segment,
 
 	for_each_active_dev_scope(devices, count, index, tmp)
 		if (tmp == &info->dev->dev) {
-			rcu_assign_pointer(devices[index].dev, NULL);
+			RCU_INIT_POINTER(devices[index].dev, NULL);
 			synchronize_rcu();
 			put_device(tmp);
 			return 1;
-- 
1.9.1
