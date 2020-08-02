Return-Path: <SRS0=vGvh=BM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37943C433E0
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 10:23:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3EF2075B
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 10:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3EF2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7D0BD876E3;
	Sun,  2 Aug 2020 10:23:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSUGX-J5OIvG; Sun,  2 Aug 2020 10:23:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C99FB87691;
	Sun,  2 Aug 2020 10:23:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A67EDC0051;
	Sun,  2 Aug 2020 10:23:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01981C004C
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 10:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D8CD785D40
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 10:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JEmLgPiq3dap for <iommu@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 10:23:01 +0000 (UTC)
X-Greylist: delayed 00:15:06 by SQLgrey-1.7.6
Received: from ZXSHCAS1.zhaoxin.com (unknown [203.148.12.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4836685D3F
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 10:23:01 +0000 (UTC)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 2 Aug 2020
 18:07:44 +0800
Received: from localhost.localdomain (114.242.249.158) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 2 Aug 2020
 18:07:42 +0800
From: FelixCuioc <FelixCui-oc@zhaoxin.com>
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>
Subject: [PATCH] iommu/vt-d:Add support for ACPI device in RMRR
Date: Sun, 2 Aug 2020 06:07:35 -0400
Message-ID: <20200802100735.2722-1-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [114.242.249.158]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Cc: CobeChen@zhaoxin.com, RaymondPang@zhaoxin.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Some ACPI devices require access to the specified reserved memory
region.BIOS report the specified reserved memory region through
RMRR structures.Add analysis of ACPI device in RMRR and establish
identity mapping for ACPI device.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
---
 drivers/iommu/intel/dmar.c  | 74 ++++++++++++++++++++-----------------
 drivers/iommu/intel/iommu.c | 46 ++++++++++++++++++++++-
 drivers/iommu/iommu.c       |  6 +++
 include/linux/dmar.h        | 12 +++++-
 include/linux/iommu.h       |  3 ++
 5 files changed, 105 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 93e6345f3414..024ca38dba12 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -215,7 +215,7 @@ static bool dmar_match_pci_path(struct dmar_pci_notify_info *info, int bus,
 }
 
 /* Return: > 0 if match found, 0 if no match found, < 0 if error happens */
-int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
+int dmar_pci_insert_dev_scope(struct dmar_pci_notify_info *info,
 			  void *start, void*end, u16 segment,
 			  struct dmar_dev_scope *devices,
 			  int devices_cnt)
@@ -304,7 +304,7 @@ static int dmar_pci_bus_add_dev(struct dmar_pci_notify_info *info)
 
 		drhd = container_of(dmaru->hdr,
 				    struct acpi_dmar_hardware_unit, header);
-		ret = dmar_insert_dev_scope(info, (void *)(drhd + 1),
+		ret = dmar_pci_insert_dev_scope(info, (void *)(drhd + 1),
 				((void *)drhd) + drhd->header.length,
 				dmaru->segment,
 				dmaru->devices, dmaru->devices_cnt);
@@ -696,48 +696,56 @@ dmar_find_matched_drhd_unit(struct pci_dev *dev)
 
 	return dmaru;
 }
-
-static void __init dmar_acpi_insert_dev_scope(u8 device_number,
-					      struct acpi_device *adev)
+int dmar_acpi_insert_dev_scope(u8 device_number,
+				struct acpi_device *adev,
+				void *start, void *end,
+				struct dmar_dev_scope *devices,
+				int devices_cnt)
 {
-	struct dmar_drhd_unit *dmaru;
-	struct acpi_dmar_hardware_unit *drhd;
 	struct acpi_dmar_device_scope *scope;
 	struct device *tmp;
 	int i;
 	struct acpi_dmar_pci_path *path;
 
+	for (; start < end; start += scope->length) {
+		scope = start;
+		if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
+			continue;
+		if (scope->enumeration_id != device_number)
+			continue;
+		path = (void *)(scope + 1);
+		for_each_dev_scope(devices, devices_cnt, i, tmp)
+			if (tmp == NULL) {
+				devices[i].bus = scope->bus;
+				devices[i].devfn = PCI_DEVFN(path->device, path->function);
+				rcu_assign_pointer(devices[i].dev,
+						   get_device(&adev->dev));
+				return 1;
+			}
+		WARN_ON(i >= devices_cnt);
+	}
+	return 0;
+}
+static int dmar_acpi_bus_add_dev(u8 device_number, struct acpi_device *adev)
+{
+	struct dmar_drhd_unit *dmaru;
+	struct acpi_dmar_hardware_unit *drhd;
+	int ret = 0;
+
 	for_each_drhd_unit(dmaru) {
 		drhd = container_of(dmaru->hdr,
 				    struct acpi_dmar_hardware_unit,
 				    header);
+		ret = dmar_acpi_insert_dev_scope(device_number, adev, (void *)(drhd+1),
+						((void *)drhd)+drhd->header.length,
+						dmaru->devices, dmaru->devices_cnt);
+		if (ret)
+			break;
+	}
+	ret = dmar_rmrr_add_acpi_dev(device_number, adev);
 
-		for (scope = (void *)(drhd + 1);
-		     (unsigned long)scope < ((unsigned long)drhd) + drhd->header.length;
-		     scope = ((void *)scope) + scope->length) {
-			if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
-				continue;
-			if (scope->enumeration_id != device_number)
-				continue;
+	return ret;
 
-			path = (void *)(scope + 1);
-			pr_info("ACPI device \"%s\" under DMAR at %llx as %02x:%02x.%d\n",
-				dev_name(&adev->dev), dmaru->reg_base_addr,
-				scope->bus, path->device, path->function);
-			for_each_dev_scope(dmaru->devices, dmaru->devices_cnt, i, tmp)
-				if (tmp == NULL) {
-					dmaru->devices[i].bus = scope->bus;
-					dmaru->devices[i].devfn = PCI_DEVFN(path->device,
-									    path->function);
-					rcu_assign_pointer(dmaru->devices[i].dev,
-							   get_device(&adev->dev));
-					return;
-				}
-			BUG_ON(i >= dmaru->devices_cnt);
-		}
-	}
-	pr_warn("No IOMMU scope found for ANDD enumeration ID %d (%s)\n",
-		device_number, dev_name(&adev->dev));
 }
 
 static int __init dmar_acpi_dev_scope_init(void)
@@ -766,7 +774,7 @@ static int __init dmar_acpi_dev_scope_init(void)
 				       andd->device_name);
 				continue;
 			}
-			dmar_acpi_insert_dev_scope(andd->device_number, adev);
+			dmar_acpi_bus_add_dev(andd->device_number, adev);
 		}
 	}
 	return 0;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ca557d351518..be1793415326 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4507,6 +4507,24 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
 
 	return ret;
 }
+int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_device *adev)
+{
+	int ret;
+	struct dmar_rmrr_unit *rmrru;
+	struct acpi_dmar_reserved_memory *rmrr;
+
+	list_for_each_entry(rmrru, &dmar_rmrr_units, list) {
+		rmrr = container_of(rmrru->hdr,
+				struct acpi_dmar_reserved_memory,
+				header);
+		ret = dmar_acpi_insert_dev_scope(device_number, adev, (void *)(rmrr + 1),
+						((void *)rmrr) + rmrr->header.length,
+						rmrru->devices, rmrru->devices_cnt);
+		if (ret)
+			break;
+	}
+	return 0;
+}
 
 int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 {
@@ -4523,7 +4541,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 		rmrr = container_of(rmrru->hdr,
 				    struct acpi_dmar_reserved_memory, header);
 		if (info->event == BUS_NOTIFY_ADD_DEVICE) {
-			ret = dmar_insert_dev_scope(info, (void *)(rmrr + 1),
+			ret = dmar_pci_insert_dev_scope(info, (void *)(rmrr + 1),
 				((void *)rmrr) + rmrr->header.length,
 				rmrr->segment, rmrru->devices,
 				rmrru->devices_cnt);
@@ -4541,7 +4559,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 
 		atsr = container_of(atsru->hdr, struct acpi_dmar_atsr, header);
 		if (info->event == BUS_NOTIFY_ADD_DEVICE) {
-			ret = dmar_insert_dev_scope(info, (void *)(atsr + 1),
+			ret = dmar_pci_insert_dev_scope(info, (void *)(atsr + 1),
 					(void *)atsr + atsr->header.length,
 					atsr->segment, atsru->devices,
 					atsru->devices_cnt);
@@ -4779,6 +4797,26 @@ static int __init platform_optin_force_iommu(void)
 
 	return 1;
 }
+static int acpi_device_create_direct_mappings(struct device *pn_dev, struct device *acpi_device)
+{
+	int ret;
+	struct iommu_group *group;
+
+	if (pn_dev == NULL) {
+		acpi_device->bus->iommu_ops = &intel_iommu_ops;
+		ret = iommu_probe_device(acpi_device);
+		if (ret) {
+			pr_err("acpi_device probe fail! ret:%d\n", ret);
+			return ret;
+		}
+		return 0;
+	}
+	acpi_device->bus->iommu_ops = &intel_iommu_ops;
+	group = iommu_group_get(pn_dev);
+	__acpi_device_create_direct_mappings(group, acpi_device);
+
+	return 0;
+}
 
 static int __init probe_acpi_namespace_devices(void)
 {
@@ -4794,6 +4832,7 @@ static int __init probe_acpi_namespace_devices(void)
 			struct acpi_device_physical_node *pn;
 			struct iommu_group *group;
 			struct acpi_device *adev;
+			struct device *pn_dev = NULL;
 
 			if (dev->bus != &acpi_bus_type)
 				continue;
@@ -4804,6 +4843,7 @@ static int __init probe_acpi_namespace_devices(void)
 					    &adev->physical_node_list, node) {
 				group = iommu_group_get(pn->dev);
 				if (group) {
+					pn_dev = pn->dev;
 					iommu_group_put(group);
 					continue;
 				}
@@ -4812,7 +4852,9 @@ static int __init probe_acpi_namespace_devices(void)
 				ret = iommu_probe_device(pn->dev);
 				if (ret)
 					break;
+				pn_dev = pn->dev;
 			}
+			ret = acpi_device_create_direct_mappings(pn_dev, dev);
 			mutex_unlock(&adev->physical_node_lock);
 
 			if (ret)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25bf154..4f714a2d5ef7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -779,6 +779,12 @@ static bool iommu_is_attach_deferred(struct iommu_domain *domain,
 	return false;
 }
 
+void  __acpi_device_create_direct_mappings(struct iommu_group *group, struct device *acpi_device)
+{
+	iommu_create_device_direct_mappings(group, acpi_device);
+}
+EXPORT_SYMBOL_GPL(__acpi_device_create_direct_mappings);
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 65565820328a..881ac61a4336 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -113,10 +113,14 @@ extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
 				struct dmar_dev_scope **devices, u16 segment);
 extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
 extern void dmar_free_dev_scope(struct dmar_dev_scope **devices, int *cnt);
-extern int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
+extern int dmar_pci_insert_dev_scope(struct dmar_pci_notify_info *info,
 				 void *start, void*end, u16 segment,
 				 struct dmar_dev_scope *devices,
 				 int devices_cnt);
+extern int dmar_acpi_insert_dev_scope(u8 device_number,
+				struct acpi_device *adev, void *start, void *end,
+				struct dmar_dev_scope *devices, int devices_cnt);
+
 extern int dmar_remove_dev_scope(struct dmar_pci_notify_info *info,
 				 u16 segment, struct dmar_dev_scope *devices,
 				 int count);
@@ -140,6 +144,7 @@ extern int dmar_parse_one_atsr(struct acpi_dmar_header *header, void *arg);
 extern int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void *arg);
 extern int dmar_release_one_atsr(struct acpi_dmar_header *hdr, void *arg);
 extern int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert);
+extern int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_device *adev);
 extern int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info);
 #else /* !CONFIG_INTEL_IOMMU: */
 static inline int intel_iommu_init(void) { return -ENODEV; }
@@ -150,6 +155,11 @@ static inline void intel_iommu_shutdown(void) { }
 #define	dmar_check_one_atsr		dmar_res_noop
 #define	dmar_release_one_atsr		dmar_res_noop
 
+static inline int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_device *adev)
+{
+	return 0;
+}
+
 static inline int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 {
 	return 0;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fee209efb756..9be134775886 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -514,6 +514,9 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
 
+extern void __acpi_device_create_direct_mappings(struct iommu_group *group,
+						struct device *acpi_device);
+
 static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
 {
 	if (domain->ops->flush_iotlb_all)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
