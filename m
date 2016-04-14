From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V4 1/4] iommu/vt-d: replace *hdr with {drhd/atsr}[0] in struct
	dmar_{drhd/atsr}_unit
Date: Thu, 14 Apr 2016 14:55:07 +0000
Message-ID: <1460645710-22656-2-git-send-email-richard.weiyang@gmail.com>
References: <1460645710-22656-1-git-send-email-richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1460645710-22656-1-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Before commit <6b1972493a84> ("iommu/vt-d: Implement DMAR unit hotplug
framework"), dmaru->hdr just points to the memory region of DMA remapping
hardware definition. In this case, it would have no difference to where we
put hdr.

After this commit, DMA remapping hardware definition is copied and
attach to the end of dmaru structure. By replacing a pointer with a
zero-sized array, that would save some space for this structure.

This patch replace *hdr with drhd[0] in struct dmar_drhd_unit and change
the type from acpi_dmar_header to acpi_dmar_hardware_unit. By doing so, it
reflects the real data type contained in dmar_drhd_unit and avoid some type
cast between them.

The same thing happens to struct dmar_atsr_unit, so this patch does similar
change for this structure.

Besides this, this patch includes another change:
* remove redundant type cast to the same type in dmar_table_detect()

Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c                |   17 +++++------------
 drivers/iommu/intel-iommu.c         |   18 +++++++++---------
 drivers/iommu/intel_irq_remapping.c |   10 ++++------
 include/linux/dmar.h                |    3 ++-
 4 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 80e3c17..80199b3 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -292,8 +292,7 @@ static int dmar_pci_bus_add_dev(struct dmar_pci_notify_info *info)
 		if (dmaru->include_all)
 			continue;
 
-		drhd = container_of(dmaru->hdr,
-				    struct acpi_dmar_hardware_unit, header);
+		drhd = dmaru->drhd;
 		ret = dmar_insert_dev_scope(info, (void *)(drhd + 1),
 				((void *)drhd) + drhd->header.length,
 				dmaru->segment,
@@ -390,8 +389,7 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
 	 * If header is allocated from slab by ACPI _DSM method, we need to
 	 * copy the content because the memory buffer will be freed on return.
 	 */
-	dmaru->hdr = (void *)(dmaru + 1);
-	memcpy(dmaru->hdr, header, header->length);
+	memcpy(dmaru->drhd, drhd, drhd->header.length);
 	dmaru->reg_base_addr = drhd->address;
 	dmaru->segment = drhd->segment;
 	dmaru->include_all = drhd->flags & 0x1; /* BIT0: INCLUDE_ALL */
@@ -529,8 +527,7 @@ static int __init dmar_table_detect(void)
 
 	/* if we could find DMAR table, then there are DMAR devices */
 	status = acpi_get_table_with_size(ACPI_SIG_DMAR, 0,
-				(struct acpi_table_header **)&dmar_tbl,
-				&dmar_tbl_size);
+				&dmar_tbl, &dmar_tbl_size);
 
 	if (ACPI_SUCCESS(status) && !dmar_tbl) {
 		pr_warn("Unable to map DMAR\n");
@@ -663,9 +660,7 @@ dmar_find_matched_drhd_unit(struct pci_dev *dev)
 
 	rcu_read_lock();
 	for_each_drhd_unit(dmaru) {
-		drhd = container_of(dmaru->hdr,
-				    struct acpi_dmar_hardware_unit,
-				    header);
+		drhd = dmaru->drhd;
 
 		if (dmaru->include_all &&
 		    drhd->segment == pci_domain_nr(dev->bus))
@@ -693,9 +688,7 @@ static void __init dmar_acpi_insert_dev_scope(u8 device_number,
 	struct acpi_dmar_pci_path *path;
 
 	for_each_drhd_unit(dmaru) {
-		drhd = container_of(dmaru->hdr,
-				    struct acpi_dmar_hardware_unit,
-				    header);
+		drhd = dmaru->drhd;
 
 		for (scope = (void *)(drhd + 1);
 		     (unsigned long)scope < ((unsigned long)drhd) + drhd->header.length;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ac73876..ab03f79 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -442,10 +442,11 @@ struct dmar_rmrr_unit {
 
 struct dmar_atsr_unit {
 	struct list_head list;		/* list of ATSR units */
-	struct acpi_dmar_header *hdr;	/* ACPI header */
 	struct dmar_dev_scope *devices;	/* target devices */
 	int devices_cnt;		/* target device count */
 	u8 include_all:1;		/* include all ports */
+	struct acpi_dmar_atsr atsr[0];	/* Root Port ATS Capability
+					   Reporting Structure */
 };
 
 static LIST_HEAD(dmar_atsr_units);
@@ -4089,7 +4090,7 @@ static struct dmar_atsr_unit *dmar_find_atsr(struct acpi_dmar_atsr *atsr)
 	struct acpi_dmar_atsr *tmp;
 
 	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list) {
-		tmp = (struct acpi_dmar_atsr *)atsru->hdr;
+		tmp = atsru->atsr;
 		if (atsr->segment != tmp->segment)
 			continue;
 		if (atsr->header.length != tmp->header.length)
@@ -4109,7 +4110,7 @@ int dmar_parse_one_atsr(struct acpi_dmar_header *hdr, void *arg)
 	if (system_state != SYSTEM_BOOTING && !intel_iommu_enabled)
 		return 0;
 
-	atsr = container_of(hdr, struct acpi_dmar_atsr, header);
+	atsr = (struct acpi_dmar_atsr *)hdr;
 	atsru = dmar_find_atsr(atsr);
 	if (atsru)
 		return 0;
@@ -4123,8 +4124,7 @@ int dmar_parse_one_atsr(struct acpi_dmar_header *hdr, void *arg)
 	 * copy the memory content because the memory buffer will be freed
 	 * on return.
 	 */
-	atsru->hdr = (void *)(atsru + 1);
-	memcpy(atsru->hdr, hdr, hdr->length);
+	memcpy(atsru->atsr, hdr, hdr->length);
 	atsru->include_all = atsr->flags & 0x1;
 	if (!atsru->include_all) {
 		atsru->devices = dmar_alloc_dev_scope((void *)(atsr + 1),
@@ -4152,7 +4152,7 @@ int dmar_release_one_atsr(struct acpi_dmar_header *hdr, void *arg)
 	struct acpi_dmar_atsr *atsr;
 	struct dmar_atsr_unit *atsru;
 
-	atsr = container_of(hdr, struct acpi_dmar_atsr, header);
+	atsr = (struct acpi_dmar_atsr *)hdr;
 	atsru = dmar_find_atsr(atsr);
 	if (atsru) {
 		list_del_rcu(&atsru->list);
@@ -4170,7 +4170,7 @@ int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void *arg)
 	struct acpi_dmar_atsr *atsr;
 	struct dmar_atsr_unit *atsru;
 
-	atsr = container_of(hdr, struct acpi_dmar_atsr, header);
+	atsr = (struct acpi_dmar_atsr *)hdr;
 	atsru = dmar_find_atsr(atsr);
 	if (!atsru)
 		return 0;
@@ -4328,7 +4328,7 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list) {
-		atsr = container_of(atsru->hdr, struct acpi_dmar_atsr, header);
+		atsr = atsru->atsr;
 		if (atsr->segment != pci_domain_nr(dev->bus))
 			continue;
 
@@ -4377,7 +4377,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 		if (atsru->include_all)
 			continue;
 
-		atsr = container_of(atsru->hdr, struct acpi_dmar_atsr, header);
+		atsr = atsru->atsr;
 		if (info->event == BUS_NOTIFY_ADD_DEVICE) {
 			ret = dmar_insert_dev_scope(info, (void *)(atsr + 1),
 					(void *)atsr + atsr->header.length,
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 1fae188..e35062e 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -886,17 +886,15 @@ static int ir_parse_one_ioapic_scope(struct acpi_dmar_device_scope *scope,
 	return 0;
 }
 
-static int ir_parse_ioapic_hpet_scope(struct acpi_dmar_header *header,
+static int ir_parse_ioapic_hpet_scope(struct acpi_dmar_hardware_unit *drhd,
 				      struct intel_iommu *iommu)
 {
 	int ret = 0;
-	struct acpi_dmar_hardware_unit *drhd;
 	struct acpi_dmar_device_scope *scope;
 	void *start, *end;
 
-	drhd = (struct acpi_dmar_hardware_unit *)header;
 	start = (void *)(drhd + 1);
-	end = ((void *)drhd) + header->length;
+	end = ((void *)drhd) + drhd->header.length;
 
 	while (start < end && ret == 0) {
 		scope = start;
@@ -940,7 +938,7 @@ static int __init parse_ioapics_under_ir(void)
 		if (!ecap_ir_support(iommu->ecap))
 			continue;
 
-		ret = ir_parse_ioapic_hpet_scope(drhd->hdr, iommu);
+		ret = ir_parse_ioapic_hpet_scope(drhd->drhd, iommu);
 		if (ret)
 			return ret;
 
@@ -1420,7 +1418,7 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 		return -ENODEV;
 	}
 
-	if (ir_parse_ioapic_hpet_scope(dmaru->hdr, iommu)) {
+	if (ir_parse_ioapic_hpet_scope(dmaru->drhd, iommu)) {
 		pr_warn("DRHD %Lx: failed to parse managed IOAPIC/HPET\n",
 			iommu->reg_phys);
 		return -ENODEV;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e9bc929..70ef3cf 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -52,7 +52,6 @@ struct dmar_dev_scope {
 extern struct acpi_table_header *dmar_tbl;
 struct dmar_drhd_unit {
 	struct list_head list;		/* list of drhd units	*/
-	struct  acpi_dmar_header *hdr;	/* ACPI header		*/
 	u64	reg_base_addr;		/* register base address*/
 	struct	dmar_dev_scope *devices;/* target device array	*/
 	int	devices_cnt;		/* target device count	*/
@@ -60,6 +59,8 @@ struct dmar_drhd_unit {
 	u8	ignored:1; 		/* ignore drhd		*/
 	u8	include_all:1;
 	struct intel_iommu *iommu;
+	struct  acpi_dmar_hardware_unit drhd[0];
+					/* ACPI Hardware Unit Definition */
 };
 
 struct dmar_pci_path {
-- 
1.7.9.5
