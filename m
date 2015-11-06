From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v2 7/9] iommu/amd: copy old tables and do not update dev
	tables before driver init
Date: Fri,  6 Nov 2015 20:10:49 +0800
Message-ID: <1446811851-20623-8-git-send-email-bhe@redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446811851-20623-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c      | 19 +++++------
 drivers/iommu/amd_iommu_init.c | 71 ++++++++++++++++++++++++------------------
 2 files changed, 49 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 48bcd83..90c6205 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1992,14 +1992,15 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	/* Update data structures */
 	dev_data->domain = domain;
 	list_add(&dev_data->list, &domain->dev_list);
-	set_dte_entry(dev_data->devid, domain, ats);
+	if (!translation_pre_enabled()) {
+		set_dte_entry(dev_data->devid, domain, ats);
+		/* Flush the DTE entry */
+		device_flush_dte(dev_data);
+	}
 
 	/* Do reference counting */
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
-
-	/* Flush the DTE entry */
-	device_flush_dte(dev_data);
 }
 
 static void do_detach(struct iommu_dev_data *dev_data)
@@ -2194,13 +2195,6 @@ static int attach_device(struct device *dev,
 	ret = __attach_device(dev_data, domain);
 	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 
-	/*
-	 * We might boot into a crash-kernel here. The crashed kernel
-	 * left the caches in the IOMMU dirty. So we have to flush
-	 * here to evict all dirty stuff.
-	 */
-	domain_flush_tlb_pde(domain);
-
 	return ret;
 }
 
@@ -3767,6 +3761,9 @@ static int modify_irte(u16 devid, int index, union irte irte)
 	if (!table)
 		return -ENOMEM;
 
+	if (translation_pre_enabled() && (table->table[index] == irte.val))
+		return 0;
+
 	spin_lock_irqsave(&table->lock, flags);
 	table->table[index] = irte.val;
 	spin_unlock_irqrestore(&table->lock, flags);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 9c414f0..d978f80 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -820,22 +820,24 @@ static void __init set_iommu_for_device(struct amd_iommu *iommu, u16 devid)
 static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 					   u16 devid, u32 flags, u32 ext_flags)
 {
-	if (flags & ACPI_DEVFLAG_INITPASS)
-		set_dev_entry_bit(devid, DEV_ENTRY_INIT_PASS);
-	if (flags & ACPI_DEVFLAG_EXTINT)
-		set_dev_entry_bit(devid, DEV_ENTRY_EINT_PASS);
-	if (flags & ACPI_DEVFLAG_NMI)
-		set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
-	if (flags & ACPI_DEVFLAG_SYSMGT1)
-		set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1);
-	if (flags & ACPI_DEVFLAG_SYSMGT2)
-		set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2);
-	if (flags & ACPI_DEVFLAG_LINT0)
-		set_dev_entry_bit(devid, DEV_ENTRY_LINT0_PASS);
-	if (flags & ACPI_DEVFLAG_LINT1)
-		set_dev_entry_bit(devid, DEV_ENTRY_LINT1_PASS);
-
-	amd_iommu_apply_erratum_63(devid);
+	if ( !translation_pre_enabled()) {
+		if (flags & ACPI_DEVFLAG_INITPASS)
+			set_dev_entry_bit(devid, DEV_ENTRY_INIT_PASS);
+		if (flags & ACPI_DEVFLAG_EXTINT)
+			set_dev_entry_bit(devid, DEV_ENTRY_EINT_PASS);
+		if (flags & ACPI_DEVFLAG_NMI)
+			set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
+		if (flags & ACPI_DEVFLAG_SYSMGT1)
+			set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1);
+		if (flags & ACPI_DEVFLAG_SYSMGT2)
+			set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2);
+		if (flags & ACPI_DEVFLAG_LINT0)
+			set_dev_entry_bit(devid, DEV_ENTRY_LINT0_PASS);
+		if (flags & ACPI_DEVFLAG_LINT1)
+			set_dev_entry_bit(devid, DEV_ENTRY_LINT1_PASS);
+
+		amd_iommu_apply_erratum_63(devid);
+	}
 
 	set_iommu_for_device(iommu, devid);
 }
@@ -919,7 +921,8 @@ static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
 		 * per device. But we can enable the exclusion range per
 		 * device. This is done here
 		 */
-		set_dev_entry_bit(devid, DEV_ENTRY_EX);
+		if (!translation_pre_enabled())
+			set_dev_entry_bit(devid, DEV_ENTRY_EX);
 		iommu->exclusion_start = m->range_start;
 		iommu->exclusion_length = m->range_length;
 	}
@@ -1525,10 +1528,11 @@ static int __init amd_iommu_init_pci(void)
 			break;
 	}
 
-	init_device_table_dma();
-
-	for_each_iommu(iommu)
-		iommu_flush_all_caches(iommu);
+	if (!translation_pre_enabled()) {
+		init_device_table_dma();
+		for_each_iommu(iommu)
+			iommu_flush_all_caches(iommu);
+	}
 
 	ret = amd_iommu_init_api();
 
@@ -1818,14 +1822,20 @@ static void early_enable_iommus(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
-		iommu_disable(iommu);
-		iommu_init_flags(iommu);
-		iommu_set_device_table(iommu);
-		iommu_enable_command_buffer(iommu);
-		iommu_enable_event_buffer(iommu);
-		iommu_set_exclusion_range(iommu);
-		iommu_enable(iommu);
-		iommu_flush_all_caches(iommu);
+		 if ( !translation_pre_enabled() ) {
+			iommu_disable(iommu);
+			iommu_init_flags(iommu);
+			iommu_set_device_table(iommu);
+			iommu_enable_command_buffer(iommu);
+			iommu_enable_event_buffer(iommu);
+			iommu_set_exclusion_range(iommu);
+			iommu_enable(iommu);
+			iommu_flush_all_caches(iommu);
+		} else {
+			copy_dev_tables();
+			copy_command_buffer();
+			copy_event_buffer();
+		}
 	}
 }
 
@@ -2112,7 +2122,8 @@ static int __init early_amd_iommu_init(void)
 		goto out;
 
 	/* init the device table */
-	init_device_table();
+	if (!translation_pre_enabled())
+		init_device_table();
 
 out:
 	/* Don't leak any ACPI memory */
-- 
2.4.0
