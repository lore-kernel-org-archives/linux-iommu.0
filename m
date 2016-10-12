From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v14 04/16] iommu/dma: MSI doorbell alloc/free
Date: Wed, 12 Oct 2016 13:22:12 +0000
Message-ID: <1476278544-3397-5-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We introduce the capability to (un)register MSI doorbells.

A doorbell region is characterized by its physical address base, size,
and whether it its safe (ie. it implements IRQ remapping). A doorbell
can be per-cpu or global. We currently only care about global doorbells.

A function returns whether all registered doorbells are safe.

MSI controllers likely to work along with IOMMU that translate MSI
transaction must register their doorbells to allow device assignment
with MSI support.  Otherwise the MSI transactions will cause IOMMU faults.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

v13 -> v14:
- previously in msi-doorbell.h/c
---
 drivers/iommu/dma-iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h | 41 ++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d45f9a0..d8a7d86 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -43,6 +43,38 @@ struct iommu_dma_cookie {
 	spinlock_t		msi_lock;
 };
 
+/**
+ * struct iommu_msi_doorbell_info - MSI doorbell region descriptor
+ * @percpu_doorbells: per cpu doorbell base address
+ * @global_doorbell: base address of the doorbell
+ * @doorbell_is_percpu: is the doorbell per cpu or global?
+ * @safe: true if irq remapping is implemented
+ * @size: size of the doorbell
+ */
+struct iommu_msi_doorbell_info {
+	union {
+		phys_addr_t __percpu    *percpu_doorbells;
+		phys_addr_t             global_doorbell;
+	};
+	bool    doorbell_is_percpu;
+	bool    safe;
+	size_t  size;
+};
+
+struct iommu_msi_doorbell {
+	struct iommu_msi_doorbell_info	info;
+	struct list_head		next;
+};
+
+/* list of registered MSI doorbells */
+static LIST_HEAD(iommu_msi_doorbell_list);
+
+/* counts the number of unsafe registered doorbells */
+static uint nb_unsafe_doorbells;
+
+/* protects the list and nb_unsafe_doorbells */
+static DEFINE_MUTEX(iommu_msi_doorbell_mutex);
+
 static inline struct iova_domain *cookie_iovad(struct iommu_domain *domain)
 {
 	return &((struct iommu_dma_cookie *)domain->iova_cookie)->iovad;
@@ -755,3 +787,46 @@ int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
 	return 0;
 }
 EXPORT_SYMBOL(iommu_get_dma_msi_region_cookie);
+
+struct iommu_msi_doorbell_info *
+iommu_msi_doorbell_alloc(phys_addr_t base, size_t size, bool safe)
+{
+	struct iommu_msi_doorbell *db;
+
+	db = kzalloc(sizeof(*db), GFP_KERNEL);
+	if (!db)
+		return ERR_PTR(-ENOMEM);
+
+	db->info.global_doorbell = base;
+	db->info.size = size;
+	db->info.safe = safe;
+
+	mutex_lock(&iommu_msi_doorbell_mutex);
+	list_add(&db->next, &iommu_msi_doorbell_list);
+	if (!db->info.safe)
+		nb_unsafe_doorbells++;
+	mutex_unlock(&iommu_msi_doorbell_mutex);
+	return &db->info;
+}
+EXPORT_SYMBOL_GPL(iommu_msi_doorbell_alloc);
+
+void iommu_msi_doorbell_free(struct iommu_msi_doorbell_info *dbinfo)
+{
+	struct iommu_msi_doorbell *db;
+
+	db = container_of(dbinfo, struct iommu_msi_doorbell, info);
+
+	mutex_lock(&iommu_msi_doorbell_mutex);
+	list_del(&db->next);
+	if (!db->info.safe)
+		nb_unsafe_doorbells--;
+	mutex_unlock(&iommu_msi_doorbell_mutex);
+	kfree(db);
+}
+EXPORT_SYMBOL_GPL(iommu_msi_doorbell_free);
+
+bool iommu_msi_doorbell_safe(void)
+{
+	return !nb_unsafe_doorbells;
+}
+EXPORT_SYMBOL_GPL(iommu_msi_doorbell_safe);
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 05ab5b4..9640a27 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -19,6 +19,8 @@
 #ifdef __KERNEL__
 #include <asm/errno.h>
 
+struct iommu_msi_doorbell_info;
+
 #ifdef CONFIG_IOMMU_DMA
 #include <linux/iommu.h>
 #include <linux/msi.h>
@@ -70,6 +72,31 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
 				    dma_addr_t base, u64 size);
 
+/**
+ * iommu_msi_doorbell_alloc - allocate a global doorbell
+ * @base: physical base address of the doorbell
+ * @size: size of the doorbell
+ * @safe: true is irq_remapping implemented for this doorbell
+ *
+ * Return: the newly allocated doorbell info or a pointer converted error
+ */
+struct iommu_msi_doorbell_info *
+iommu_msi_doorbell_alloc(phys_addr_t base, size_t size, bool safe);
+
+/**
+ * iommu_msi_doorbell_free - free a global doorbell
+ * @db: doorbell info to free
+ */
+void iommu_msi_doorbell_free(struct iommu_msi_doorbell_info *db);
+
+/**
+ * iommu_msi_doorbell_safe - return whether all registered doorbells are safe
+ *
+ * Safe doorbells are those which implement irq remapping
+ * Return: true if all doorbells are safe, false otherwise
+ */
+bool iommu_msi_doorbell_safe(void);
+
 #else
 
 struct iommu_domain;
@@ -99,6 +126,20 @@ static inline int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline struct iommu_msi_doorbell_info *
+iommu_msi_doorbell_alloc(phys_addr_t base, size_t size, bool safe)
+{
+	return NULL;
+}
+
+static inline void
+iommu_msi_doorbell_free(struct msi_doorbell_info *db) {}
+
+static inline bool iommu_msi_doorbell_safe(void)
+{
+	return false;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
1.9.1
