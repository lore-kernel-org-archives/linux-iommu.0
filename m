From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/amd: Fix section mismatch warning
Date: Sat, 19 Aug 2017 00:40:26 +0200
Message-ID: <1503096026-6851-2-git-send-email-joro@8bytes.org>
References: <1503096026-6851-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503096026-6851-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The variable amd_iommu_pre_enabled is used in non-init
code-paths, so remove the __initdata annotation.

Fixes: 3ac3e5ee5ed56 ('iommu/amd: Copy old trans table from old kernel')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index f2023cd..ff8887a 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -264,7 +264,7 @@ static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
 
-static bool __initdata amd_iommu_pre_enabled = true;
+static bool amd_iommu_pre_enabled = true;
 
 bool translation_pre_enabled(struct amd_iommu *iommu)
 {
-- 
2.7.4
