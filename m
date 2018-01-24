From: Dmitry Safonov <dima@arista.com>
Subject: [PATCH 1/5] iommu/intel: Add __init for dmar_register_bus_notifier()
Date: Wed, 24 Jan 2018 13:19:53 +0000
Message-ID: <20180124131957.9549-2-dima@arista.com>
References: <20180124131957.9549-1-dima@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124131957.9549-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

It's called only from intel_iommu_init(), which is init function.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9a7ffd13c7f0..accf58388bdb 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -806,7 +806,7 @@ int __init dmar_dev_scope_init(void)
 	return dmar_dev_scope_status;
 }
 
-void dmar_register_bus_notifier(void)
+void __init dmar_register_bus_notifier(void)
 {
 	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
 }
-- 
2.13.6
