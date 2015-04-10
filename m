From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v10 04/10] iommu/vt-d: functions to copy data from old mem
Date: Fri, 10 Apr 2015 16:42:07 +0800
Message-ID: <1428655333-19504-5-git-send-email-zhen-hual@hp.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1428655333-19504-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
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
 drivers/iommu/intel-iommu.c | 102 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |   6 +++
 2 files changed, 108 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ff5ac04..5ba403a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -373,6 +373,17 @@ static struct context_entry *device_to_existing_context_entry(
 				struct intel_iommu *iommu,
 				u8 bus, u8 devfn);
 
+/*
+ * A structure used to store the address allocated by ioremap();
+ * The we need to call iounmap() to free them out of spin_lock_irqsave/unlock;
+ */
+struct iommu_remapped_entry {
+	struct list_head list;
+	void __iomem *mem;
+};
+static LIST_HEAD(__iommu_remapped_mem);
+static DEFINE_MUTEX(__iommu_mem_list_lock);
+
 
 /*
  * This domain is a statically identity mapping domain.
@@ -4817,3 +4828,94 @@ static struct context_entry *device_to_existing_context_entry(
 	return ret;
 }
 
+/*
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
+
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index a65208a..4bca7b5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -368,4 +368,10 @@ extern int dmar_ir_support(void);
 
 extern const struct attribute_group *intel_iommu_groups[];
 
+extern int __iommu_load_from_oldmem(void *to, unsigned long from,
+					unsigned long size);
+extern int __iommu_save_to_oldmem(unsigned long to, void *from,
+					unsigned long size);
+extern int __iommu_free_mapped_mem(void);
+
 #endif
-- 
2.0.0-rc0
