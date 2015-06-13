From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 11/19] iommu/vt-d: Don't disable translation prior to OS handover
Date: Sat, 13 Jun 2015 08:47:19 +0200
Message-ID: <1434178047-17809-12-git-send-email-joro@8bytes.org>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434178047-17809-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: David Woodhouse <dwmw2@infradead.org>, zhen-hual@hp.com, bhe@redhat.com, ddutile@redhat.com, alex.williamson@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org, jroedel@8bytes.org, joro@8bytes.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

For all the copy-translation code to run, we have to keep
translation enabled in intel_iommu_init(). So remove the
code disabling it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e23d5b4..b47def6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4469,13 +4469,6 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 	}
 
-	/*
-	 * Disable translation if already enabled prior to OS handover.
-	 */
-	for_each_active_iommu(iommu, drhd)
-		if (iommu->gcmd & DMA_GCMD_TE)
-			iommu_disable_translation(iommu);
-
 	if (dmar_dev_scope_init() < 0) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR device scope\n");
-- 
1.9.1
