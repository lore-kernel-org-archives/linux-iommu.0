From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [patch] iommu/vt-d: unlock on error in
	intel_iommu_load_translation_tables()
Date: Tue, 2 Jun 2015 13:09:58 +0300
Message-ID: <20150602100958.GC11247@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Li-p7QCHhHlqjPG026l+vzAeHxJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Smatch found some error paths that don't unlock.  Also we can return
-ENOMEM instead of -1 if we don't have an old root entry.

Fixes: 5908f10af4b9 ('iommu/vt-d: datatypes and functions used for kdump')
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
Releasing the lock is good, but we might need to do other error handling
as well.  Presumably this function always succeeds anyway?  It seems
like it might be essential for booting.

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2926907..0e2e635 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5151,22 +5151,24 @@ static int intel_iommu_load_translation_tables(struct intel_iommu *iommu)
 		iommu->root_entry =
 			(struct root_entry *)alloc_pgtable_page(iommu->node);
 		if (!iommu->root_entry) {
-			spin_unlock_irqrestore(&iommu->lock, flags);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_unlock;
 		}
 	}
 
 	iommu->root_entry_old_phys = q & VTD_PAGE_MASK;
 	if (!iommu->root_entry_old_phys) {
 		pr_err("Could not read old root entry address.");
-		return -1;
+		ret = -ENOMEM;
+		goto err_unlock;
 	}
 
 	iommu->root_entry_old_virt = ioremap_cache(iommu->root_entry_old_phys,
 						VTD_PAGE_SIZE);
 	if (!iommu->root_entry_old_virt) {
 		pr_err("Could not map the old root entry.");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_unlock;
 	}
 
 	__iommu_load_old_root_entry(iommu);
@@ -5179,6 +5181,10 @@ static int intel_iommu_load_translation_tables(struct intel_iommu *iommu)
 	__iommu_free_mapped_mem();
 
 	return ret;
+
+err_unlock:
+	spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
 }
 
 static void unmap_device_dma(struct dmar_domain *domain,
