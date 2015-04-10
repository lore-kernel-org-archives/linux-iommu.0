From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v10 05/10] iommu/vt-d: Add functions to load and save old re
Date: Fri, 10 Apr 2015 16:42:08 +0800
Message-ID: <1428655333-19504-6-git-send-email-zhen-hual@hp.com>
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

Add functions to load root entry table from old kernel, and to save updated
root entry table.
Add two member in struct intel_iommu, to store the RTA in old kernel, and
the mapped virt address of it.

We use the old RTA in dump kernel, and when the iommu->root_entry is used as
a cache in kdump kernel, its phys address will not be save to RTA register,
but when its data is changed, we will save the new data to old root entry table.

Li, Zhen-hua:
    The functions and logics.

Takao Indoh:
    Add __iommu_flush_cache.

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Signed-off-by: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  3 +++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5ba403a..ef8a99c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -373,6 +373,10 @@ static struct context_entry *device_to_existing_context_entry(
 				struct intel_iommu *iommu,
 				u8 bus, u8 devfn);
 
+static void __iommu_load_old_root_entry(struct intel_iommu *iommu);
+
+static void __iommu_update_old_root_entry(struct intel_iommu *iommu, int index);
+
 /*
  * A structure used to store the address allocated by ioremap();
  * The we need to call iounmap() to free them out of spin_lock_irqsave/unlock;
@@ -384,7 +388,6 @@ struct iommu_remapped_entry {
 static LIST_HEAD(__iommu_remapped_mem);
 static DEFINE_MUTEX(__iommu_mem_list_lock);
 
-
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
@@ -4919,3 +4922,52 @@ int __iommu_free_mapped_mem(void)
 	return 0;
 }
 
+/*
+ * Load the old root entry table to new root entry table.
+ */
+static void __iommu_load_old_root_entry(struct intel_iommu *iommu)
+{
+	if ((!iommu)
+		|| (!iommu->root_entry)
+		|| (!iommu->root_entry_old_virt)
+		|| (!iommu->root_entry_old_phys))
+		return;
+	memcpy(iommu->root_entry, iommu->root_entry_old_virt, PAGE_SIZE);
+
+	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
+}
+
+/*
+ * When the data in new root entry table is changed, this function
+ * must be called to save the updated data to old root entry table.
+ */
+static void __iommu_update_old_root_entry(struct intel_iommu *iommu, int index)
+{
+	u8 start;
+	unsigned long size;
+	void __iomem *to;
+	void *from;
+
+	if ((!iommu)
+		|| (!iommu->root_entry)
+		|| (!iommu->root_entry_old_virt)
+		|| (!iommu->root_entry_old_phys))
+		return;
+
+	if (index < -1 || index >= ROOT_ENTRY_NR)
+		return;
+
+	if (index == -1) {
+		start = 0;
+		size = ROOT_ENTRY_NR * sizeof(struct root_entry);
+	} else {
+		start = index * sizeof(struct root_entry);
+		size = sizeof(struct root_entry);
+	}
+	to = iommu->root_entry_old_virt;
+	from = iommu->root_entry;
+	memcpy(to + start, from + start, size);
+
+	__iommu_flush_cache(iommu, to + start, size);
+}
+
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4bca7b5..6fa0804 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -328,6 +328,9 @@ struct intel_iommu {
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
 
+	void __iomem	*root_entry_old_virt; /* mapped from old root entry */
+	unsigned long	root_entry_old_phys; /* root entry in old kernel */
+
 	struct iommu_flush flush;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
2.0.0-rc0
