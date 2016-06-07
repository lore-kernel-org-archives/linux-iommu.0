From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 4/9] genirq/msi-doorbell: msi_doorbell_pages
Date: Tue,  7 Jun 2016 16:01:23 +0000
Message-ID: <1465315288-5931-5-git-send-email-eric.auger@redhat.com>
References: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

msi_doorbell_pages sum up the number of iommu pages of a given order
requested to map all the registered doorbells. This function will allow
to dimension the intermediate physical address (IPA) aperture requested
to map the MSI doorbells.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v10: creation
---
 include/linux/msi-doorbell.h | 14 ++++++++++++
 kernel/irq/msi-doorbell.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/linux/msi-doorbell.h b/include/linux/msi-doorbell.h
index bbc7321..abdaaa0 100644
--- a/include/linux/msi-doorbell.h
+++ b/include/linux/msi-doorbell.h
@@ -57,6 +57,14 @@ void msi_doorbell_unregister(void *chip_data);
 struct irq_chip_msi_doorbell_info *
 msi_doorbell_lookup(void *chip_data);
 
+/**
+ * msi_doorbell_pages: compute the number of iommu pages of size 1 << order
+ * requested to map all the registered doorbells
+ *
+ * @order: iommu page order
+ */
+int msi_doorbell_pages(unsigned int order);
+
 #else
 
 static inline int
@@ -74,6 +82,12 @@ msi_doorbell_lookup(void *chip_data)
 	return NULL;
 }
 
+static inline int
+msi_doorbell_pages(unsigned int order)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MSI_DOORBELL */
 
 #endif
diff --git a/kernel/irq/msi-doorbell.c b/kernel/irq/msi-doorbell.c
index 84ecca1..65ca9292 100644
--- a/kernel/irq/msi-doorbell.c
+++ b/kernel/irq/msi-doorbell.c
@@ -80,3 +80,55 @@ msi_doorbell_lookup(void *chip_data)
 }
 EXPORT_SYMBOL_GPL(msi_doorbell_lookup);
 
+static int compute_db_mapping_requirements(phys_addr_t addr, size_t size,
+					   unsigned int order)
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
+static int
+compute_dbinfo_mapping_requirements(struct irq_chip_msi_doorbell_info *dbinfo,
+				    unsigned int order)
+{
+	int ret = 0;
+
+	if (!dbinfo->doorbell_is_percpu) {
+		ret = compute_db_mapping_requirements(dbinfo->global_doorbell,
+						      dbinfo->size, order);
+	} else {
+		phys_addr_t __percpu *pbase;
+		int cpu;
+
+		for_each_possible_cpu(cpu) {
+			pbase = per_cpu_ptr(dbinfo->percpu_doorbells, cpu);
+			ret += compute_db_mapping_requirements(*pbase,
+							       dbinfo->size,
+							       order);
+		}
+	}
+	return ret;
+}
+
+int msi_doorbell_pages(unsigned int order)
+{
+	struct irqchip_doorbell *db;
+	int ret = 0;
+
+	mutex_lock(&irqchip_doorbell_mutex);
+	list_for_each_entry(db, &irqchip_doorbell_list, next) {
+		ret += compute_dbinfo_mapping_requirements(&db->info, order);
+	}
+	mutex_unlock(&irqchip_doorbell_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_pages);
+
-- 
1.9.1
