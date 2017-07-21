From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v8 13/13] iommu/amd: Disable iommu only if amd_iommu=off is specified
Date: Fri, 21 Jul 2017 16:59:11 +0800
Message-ID: <1500627551-12930-14-git-send-email-bhe@redhat.com>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, root <root@amd-dinar-02.lab.bos.redhat.com>, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

From: root <root@amd-dinar-02.lab.bos.redhat.com>

It's ok to disable iommu in normal kernel. While there's no need
to disable it in kdump kernel after the on-flight dma issue has
heen fixed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 8b4bac978062..880f693c809b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2494,7 +2494,8 @@ static int __init early_amd_iommu_init(void)
 		goto out;
 
 	/* Disable any previously enabled IOMMUs */
-	disable_iommus();
+	if (amd_iommu_disabled)
+		disable_iommus();
 
 	if (amd_iommu_irq_remap)
 		amd_iommu_irq_remap = check_ioapic_information();
-- 
2.5.5
