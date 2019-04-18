From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iommu/dmar: Use struct_size() helper
Date: Thu, 18 Apr 2019 13:46:24 -0500
Message-ID: <20190418184624.GA17025@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: iommu@lists.linux-foundation.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace code of the following form:

size = sizeof(*info) + level * sizeof(info->path[0]);

with:

size = struct_size(info, path, level);

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9c49300e9fb7..6d969a172fbb 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -145,7 +145,7 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 		for (tmp = dev; tmp; tmp = tmp->bus->self)
 			level++;
 
-	size = sizeof(*info) + level * sizeof(info->path[0]);
+	size = struct_size(info, path, level);
 	if (size <= sizeof(dmar_pci_notify_info_buf)) {
 		info = (struct dmar_pci_notify_info *)dmar_pci_notify_info_buf;
 	} else {
-- 
2.21.0
