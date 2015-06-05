From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 02/17] iommu/vt-d: Remove __iommu_save_to_oldmem() function
Date: Fri,  5 Jun 2015 16:10:48 +0200
Message-ID: <1433513463-19128-3-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This function is unused and can be removed.

Tested-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 36 ------------------------------------
 include/linux/intel-iommu.h |  2 --
 2 files changed, 38 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 60d5491..a061c3f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4978,42 +4978,6 @@ int __iommu_load_from_oldmem(void *to, unsigned long from, unsigned long size)
 }
 
 /*
- * Copy memory from a virtually-addressed area into a physically-addressed area
- */
-int __iommu_save_to_oldmem(unsigned long to, void *from, unsigned long size)
-{
-	unsigned long pfn;		/* Page Frame Number */
-	size_t csize = (size_t)size;	/* Num(bytes to copy) */
-	unsigned long offset;		/* Lower 12 bits of to */
-	void __iomem *virt_mem;
-	struct iommu_remapped_entry *mapped;
-
-	pfn = to >> VTD_PAGE_SHIFT;
-	offset = to & (~VTD_PAGE_MASK);
-
-	if (page_is_ram(pfn)) {
-		memcpy(pfn_to_kaddr(pfn) + offset, from, csize);
-	} else{
-		mapped = kzalloc(sizeof(struct iommu_remapped_entry),
-				GFP_KERNEL);
-		if (!mapped)
-			return -ENOMEM;
-
-		virt_mem = ioremap_cache((unsigned long)to, size);
-		if (!virt_mem) {
-			kfree(mapped);
-			return -ENOMEM;
-		}
-		memcpy(virt_mem, from, size);
-		mutex_lock(&__iommu_mem_list_lock);
-		mapped->mem = virt_mem;
-		list_add_tail(&mapped->list, &__iommu_remapped_mem);
-		mutex_unlock(&__iommu_mem_list_lock);
-	}
-	return size;
-}
-
-/*
  * Free the mapped memory for ioremap;
  */
 int __iommu_free_mapped_mem(void)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index a81ceee..9526c28 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -393,8 +393,6 @@ extern const struct attribute_group *intel_iommu_groups[];
 
 extern int __iommu_load_from_oldmem(void *to, unsigned long from,
 					unsigned long size);
-extern int __iommu_save_to_oldmem(unsigned long to, void *from,
-					unsigned long size);
 extern int __iommu_free_mapped_mem(void);
 
 #endif
-- 
1.9.1
