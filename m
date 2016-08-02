From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v12 05/11] genirq/msi: msi_doorbell_calc_pages
Date: Tue,  2 Aug 2016 17:23:31 +0000
Message-ID: <1470158617-7022-6-git-send-email-eric.auger@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470158617-7022-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dennis.chen-5wv7dgnIgG8@public.gmane.org, robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

msi_doorbell_calc_pages() sum up the number of iommu pages of a given order
requested to map all the registered doorbells. This function will allow
to dimension the intermediate physical address (IPA) aperture requested
to map the MSI doorbells.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v11 -> v12:
- fix style issues: remove useless line break, remove pointless braces,
  fix kernel-doc comments
- reword commit message
- rename msi_doorbell_pages into msi_doorbell_calc_pages
- rename static compute* functions

v10: creation
---
 include/linux/msi-doorbell.h | 14 ++++++++++
 kernel/irq/msi-doorbell.c    | 64 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/linux/msi-doorbell.h b/include/linux/msi-doorbell.h
index a2a033b..bbedb3b 100644
--- a/include/linux/msi-doorbell.h
+++ b/include/linux/msi-doorbell.h
@@ -38,6 +38,15 @@ msi_doorbell_register_global(phys_addr_t base, size_t size,
  */
 void msi_doorbell_unregister_global(struct msi_doorbell_info *db);
 
+/**
+ * msi_doorbell_calc_pages - compute the number of pages
+ * requested to map all the registered doorbells
+ * @order: iommu page order
+ *
+ * Return: the number of requested pages
+ */
+int msi_doorbell_calc_pages(unsigned int order);
+
 #else
 
 static inline struct msi_doorbell_info *
@@ -50,6 +59,11 @@ msi_doorbell_register_global(phys_addr_t base, size_t size,
 static inline void
 msi_doorbell_unregister_global(struct msi_doorbell_info *db) {}
 
+static inline int msi_doorbell_calc_pages(unsigned int order)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MSI_DOORBELL */
 
 #endif
diff --git a/kernel/irq/msi-doorbell.c b/kernel/irq/msi-doorbell.c
index e3e0d95..5c6c2aa 100644
--- a/kernel/irq/msi-doorbell.c
+++ b/kernel/irq/msi-doorbell.c
@@ -66,3 +66,67 @@ void msi_doorbell_unregister_global(struct msi_doorbell_info *dbinfo)
 	kfree(db);
 }
 EXPORT_SYMBOL_GPL(msi_doorbell_unregister_global);
+
+/**
+ * calc_region_reqs - compute the number of pages requested to map a region
+ *
+ * @addr: physical base address of the region
+ * @size: size of the region
+ * @order: the page order
+ *
+ * Return: the number of requested pages to map this region
+ */
+static int calc_region_reqs(phys_addr_t addr, size_t size, unsigned int order)
+{
+	phys_addr_t offset, granule;
+	unsigned int nb_pages;
+
+	granule = (uint64_t)(1 << order);
+	offset = addr & (granule - 1);
+	size = ALIGN(size + offset, granule);
+	nb_pages = size >> order;
+
+	return nb_pages;
+}
+
+/**
+ * calc_dbinfo_reqs - compute the number of pages requested to map a given
+ * MSI doorbell
+ *
+ * @dbi: doorbell info descriptor
+ * @order: page order
+ *
+ * Return: the number of requested pages to map this doorbell
+ */
+static int calc_dbinfo_reqs(struct msi_doorbell_info *dbi, unsigned int order)
+{
+	int ret = 0;
+
+	if (!dbi->doorbell_is_percpu) {
+		ret = calc_region_reqs(dbi->global_doorbell, dbi->size, order);
+	} else {
+		phys_addr_t __percpu *pbase;
+		int cpu;
+
+		for_each_possible_cpu(cpu) {
+			pbase = per_cpu_ptr(dbi->percpu_doorbells, cpu);
+			ret += calc_region_reqs(*pbase, dbi->size, order);
+		}
+	}
+	return ret;
+}
+
+int msi_doorbell_calc_pages(unsigned int order)
+{
+	struct msi_doorbell *db;
+	int ret = 0;
+
+	mutex_lock(&msi_doorbell_mutex);
+	list_for_each_entry(db, &msi_doorbell_list, next)
+		ret += calc_dbinfo_reqs(&db->info, order);
+
+	mutex_unlock(&msi_doorbell_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_calc_pages);
-- 
1.9.1
