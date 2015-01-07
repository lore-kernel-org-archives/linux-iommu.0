From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v7 04/10] iommu/vt-d: functions to copy data from old mem
Date: Wed,  7 Jan 2015 12:04:28 +0800
Message-ID: <1420603474-4235-5-git-send-email-zhen-hual@hp.com>
References: <1420603474-4235-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1420603474-4235-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add some functions to copy the data from old kernel.
These functions are used to copy context tables and page tables.

To avoid calling iounmap between spin_lock_irqsave and spin_unlock_irqrestore,
use a link here, store the pointers , and then use iounmap to free them in
another place.

Li, Zhen-hua:
    The functions and logics.

Takao Indoh:
    Check if pfn is ram:
        if (page_is_ram(pfn))

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Signed-off-by: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 97 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  9 +++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c0bebd6..8a7ad72 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -388,6 +388,13 @@ static int intel_iommu_get_dids_from_old_kernel(struct intel_iommu *iommu);
 
 static int device_to_domain_id(struct intel_iommu *iommu, u8 bus, u8 devfn);
 
+struct iommu_remapped_entry {
+	struct list_head list;
+	void __iomem *mem;
+};
+static LIST_HEAD(__iommu_remapped_mem);
+static DEFINE_MUTEX(__iommu_mem_list_lock);
+
 #endif /* CONFIG_CRASH_DUMP */
 
 /*
@@ -4843,6 +4850,96 @@ static void __init check_tylersburg_isoch(void)
 #ifdef CONFIG_CRASH_DUMP
 
 /*
+ * Copy memory from a physically-addressed area into a virtually-addressed area
+ */
+int __iommu_load_from_oldmem(void *to, unsigned long from, unsigned long size)
+{
+	unsigned long pfn;		/* Page Frame Number */
+	size_t csize = (size_t)size;	/* Num(bytes to copy) */
+	unsigned long offset;		/* Lower 12 bits of to */
+	void __iomem *virt_mem;
+	struct iommu_remapped_entry *mapped;
+
+	pfn = from >> VTD_PAGE_SHIFT;
+	offset = from & (~VTD_PAGE_MASK);
+
+	if (page_is_ram(pfn)) {
+		memcpy(to, pfn_to_kaddr(pfn) + offset, csize);
+	} else{
+
+		mapped = kzalloc(sizeof(struct iommu_remapped_entry),
+				GFP_KERNEL);
+		if (!mapped)
+			return -ENOMEM;
+
+		virt_mem = ioremap_cache((unsigned long)from, size);
+		if (!virt_mem) {
+			kfree(mapped);
+			return -ENOMEM;
+		}
+		memcpy(to, virt_mem, size);
+
+		mutex_lock(&__iommu_mem_list_lock);
+		mapped->mem = virt_mem;
+		list_add_tail(&mapped->list, &__iommu_remapped_mem);
+		mutex_unlock(&__iommu_mem_list_lock);
+	}
+	return size;
+}
+
+/*
+ * Copy memory from a virtually-addressed area into a physically-addressed area
+ */
+int __iommu_save_to_oldmem(unsigned long to, void *from, unsigned long size)
+{
+	unsigned long pfn;		/* Page Frame Number */
+	size_t csize = (size_t)size;	/* Num(bytes to copy) */
+	unsigned long offset;		/* Lower 12 bits of to */
+	void __iomem *virt_mem;
+	struct iommu_remapped_entry *mapped;
+
+	pfn = to >> VTD_PAGE_SHIFT;
+	offset = to & (~VTD_PAGE_MASK);
+
+	if (page_is_ram(pfn)) {
+		memcpy(pfn_to_kaddr(pfn) + offset, from, csize);
+	} else{
+		mapped = kzalloc(sizeof(struct iommu_remapped_entry),
+				GFP_KERNEL);
+		if (!mapped)
+			return -ENOMEM;
+
+		virt_mem = ioremap_cache((unsigned long)to, size);
+		if (!virt_mem) {
+			kfree(mapped);
+			return -ENOMEM;
+		}
+		memcpy(virt_mem, from, size);
+		mutex_lock(&__iommu_mem_list_lock);
+		mapped->mem = virt_mem;
+		list_add_tail(&mapped->list, &__iommu_remapped_mem);
+		mutex_unlock(&__iommu_mem_list_lock);
+	}
+	return size;
+}
+
+/*
+ * Free the mapped memory for ioremap;
+ */
+int __iommu_free_mapped_mem(void)
+{
+	struct iommu_remapped_entry *mem_entry, *tmp;
+
+	mutex_lock(&__iommu_mem_list_lock);
+	list_for_each_entry_safe(mem_entry, tmp, &__iommu_remapped_mem, list) {
+		iounmap(mem_entry->mem);
+		list_del(&mem_entry->list);
+		kfree(mem_entry);
+	}
+	mutex_unlock(&__iommu_mem_list_lock);
+	return 0;
+}
+/*
  * Interfaces for when a new domain in the crashdump kernel needs some
  * values from the panicked kernel's context entries
  *
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index a65208a..8ffa523 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -26,6 +26,7 @@
 #include <linux/iova.h>
 #include <linux/io.h>
 #include <linux/dma_remapping.h>
+#include <linux/crash_dump.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
 
@@ -368,4 +369,12 @@ extern int dmar_ir_support(void);
 
 extern const struct attribute_group *intel_iommu_groups[];
 
+#ifdef CONFIG_CRASH_DUMP
+extern int __iommu_load_from_oldmem(void *to, unsigned long from,
+					unsigned long size);
+extern int __iommu_save_to_oldmem(unsigned long to, void *from,
+					unsigned long size);
+extern int __iommu_free_mapped_mem(void);
+#endif /* CONFIG_CRASH_DUMP */
+
 #endif
-- 
2.0.0-rc0
