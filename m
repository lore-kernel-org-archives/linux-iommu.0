From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v14 05/16] iommu/dma: Introduce iommu_calc_msi_resv
Date: Wed, 12 Oct 2016 13:22:13 +0000
Message-ID: <1476278544-3397-6-git-send-email-eric.auger@redhat.com>
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

iommu_calc_msi_resv() sum up the number of iommu pages of the lowest
order supported by the iommu domain requested to map all the registered
doorbells. This function will allow to dimension the intermediate
physical address (IPA) aperture requested to map the MSI doorbells.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

v13 -> v14
- name and proto changed, moved to dma-iommu
---
 drivers/iommu/dma-iommu.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h | 11 +++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d8a7d86..3a4b73b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -830,3 +830,73 @@ bool iommu_msi_doorbell_safe(void)
 	return !nb_unsafe_doorbells;
 }
 EXPORT_SYMBOL_GPL(iommu_msi_doorbell_safe);
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
+static int calc_dbinfo_reqs(struct iommu_msi_doorbell_info *dbi,
+			    unsigned int order)
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
+int iommu_calc_msi_resv(struct iommu_domain *domain)
+{
+	unsigned long order = __ffs(domain->pgsize_bitmap);
+	struct iommu_msi_doorbell *db;
+	phys_addr_t granule;
+	int size = 0;
+
+	mutex_lock(&iommu_msi_doorbell_mutex);
+	list_for_each_entry(db, &iommu_msi_doorbell_list, next)
+		size += calc_dbinfo_reqs(&db->info, order);
+
+	mutex_unlock(&iommu_msi_doorbell_mutex);
+
+	granule = (uint64_t)(1 << order);
+	domain->msi_resv.size = size * granule;
+	domain->msi_resv.alignment = granule;
+
+	return 0;
+}
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 9640a27..95875c8 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -97,6 +97,16 @@ void iommu_msi_doorbell_free(struct iommu_msi_doorbell_info *db);
  */
 bool iommu_msi_doorbell_safe(void);
 
+/**
+ * iommu_calc_msi_resv - compute the number of pages of the lowest order
+ * supported by @domain, requested to map all the registered doorbells.
+ *
+ * @domain: iommu_domain
+ * @msi_resv: MSI reserved window requirements
+ *
+ */
+int iommu_calc_msi_resv(struct iommu_domain *domain);
+
 #else
 
 struct iommu_domain;
@@ -139,7 +149,6 @@ static inline bool iommu_msi_doorbell_safe(void)
 {
 	return false;
 }
-
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
1.9.1
