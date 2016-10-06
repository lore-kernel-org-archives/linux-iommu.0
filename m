From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v13 05/15] genirq/msi: msi_doorbell_calc_pages
Date: Thu,  6 Oct 2016 08:45:21 +0000
Message-ID: <1475743531-4780-6-git-send-email-eric.auger@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, yehuday@marvell.com, Manish.Jaggi@caviumnetworks.com
List-Id: iommu@lists.linux-foundation.org

msi_doorbell_calc_pages() sum up the number of iommu pages of a given order
requested to map all the registered doorbells. This function will allow
to dimension the intermediate physical address (IPA) aperture requested
to map the MSI doorbells.

Note this requirement cannot be computed at MSI doorbell registration time
since the IOMMU page order is not known.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v11 -> v12:
- fix style issues: remove useless line break, remove pointless braces,
  fix kernel-doc comments
- reword commit message
- rename msi_doorbell_pages into msi_doorbell_calc_pages
- rename static compute* functions

v10: creation
---
 include/linux/msi-doorbell.h | 15 +++++++++++
 kernel/irq/msi-doorbell.c    | 64 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/msi-doorbell.h b/include/linux/msi-doorbell.h
index c18a382..f1106cb 100644
--- a/include/linux/msi-doorbell.h
+++ b/include/linux/msi-doorbell.h
@@ -54,6 +54,15 @@ void msi_doorbell_unregister_global(struct msi_doorbell_info *db);
  */
 bool msi_doorbell_safe(void);
 
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
 
 static inline int
@@ -72,6 +81,12 @@ static inline bool msi_doorbell_safe(void)
 {
 	return true;
 }
+
+static inline int msi_doorbell_calc_pages(unsigned int order)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MSI_DOORBELL */
 
 #endif
diff --git a/kernel/irq/msi-doorbell.c b/kernel/irq/msi-doorbell.c
index 60a262a..d1cc525 100644
--- a/kernel/irq/msi-doorbell.c
+++ b/kernel/irq/msi-doorbell.c
@@ -96,3 +96,67 @@ bool msi_doorbell_safe(void)
 	return !nb_unsafe_doorbells;
 }
 EXPORT_SYMBOL_GPL(msi_doorbell_safe);
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
