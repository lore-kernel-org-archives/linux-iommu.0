From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/7] iommu/amd: Disable IOMMUs at boot if they are enabled
Date: Fri, 16 Jun 2017 16:09:54 +0200
Message-ID: <1497622200-18188-2-git-send-email-joro@8bytes.org>
References: <1497622200-18188-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497622200-18188-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

When booting, make sure the IOMMUs are disabled. They could
be previously enabled if we boot into a kexec or kdump
kernel. So make sure they are off.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index d9f5ddd..fb7035f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2316,6 +2316,9 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	/* Disable any previously enabled IOMMUs */
+	disable_iommus();
+
 	if (amd_iommu_irq_remap)
 		amd_iommu_irq_remap = check_ioapic_information();
 
-- 
2.7.4
