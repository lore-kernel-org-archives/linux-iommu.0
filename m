From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v10 12/12] iommu/amd: Disable iommu only if amd_iommu=off is specified
Date: Wed,  9 Aug 2017 16:33:44 +0800
Message-ID: <1502267624-7066-13-git-send-email-bhe@redhat.com>
References: <1502267624-7066-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502267624-7066-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

It's ok to disable iommu early in normal kernel or in kdump kernel when
amd_iommu=off is specified. While we should not disable it in kdump kernel
when on-flight dma is still on-going.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v9->v10:
  Change to call disable_iommus() in normal kernel and the case that
  amd_iommu=off is set in kdump kernel. Otherwise if in kdump kernel
  but amd_iommu=off is not specified, we can just keep it as it is
  in 1st kernel.

 drivers/iommu/amd_iommu_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 88e7a6e950ae..c7d03251c80a 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2499,7 +2499,8 @@ static int __init early_amd_iommu_init(void)
 		goto out;
 
 	/* Disable any previously enabled IOMMUs */
-	disable_iommus();
+	if (!is_kdump_kernel() || amd_iommu_disabled)
+		disable_iommus();
 
 	if (amd_iommu_irq_remap)
 		amd_iommu_irq_remap = check_ioapic_information();
-- 
2.5.5
