Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2765C433EF
	for <iommu@archiver.kernel.org>; Fri, 14 Jan 2022 17:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77539415C2;
	Fri, 14 Jan 2022 17:11:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bBo5OPQnn-bx; Fri, 14 Jan 2022 17:11:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 43C01415C1;
	Fri, 14 Jan 2022 17:11:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23174C002F;
	Fri, 14 Jan 2022 17:11:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A9E1C001E
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 17:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6851860808
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 17:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E8FOcO1aaNHZ for <iommu@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 17:11:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0CAF605B3
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642180288; x=1673716288;
 h=from:to:cc:subject:date:message-id;
 bh=5bMRkSbwda2W++UDW9AENUPPKl67d4aXOGbqSNY+4Dc=;
 b=Q33qbkC9h81nOMBJtdUjBvG2lOa11aQhfeneviaap7/f6nqld6MRns7U
 wpXJWuiqrZMUCE8enLUMOjP3JGkasPuz0WnbeDKJYsqWCoQlg/NdcymVX
 5hSrdGfCaGNjplz2YuK9STiM6iO6y4uVv5LceuaNDS+rp7J1l98x5+Rtq
 Y4Xs8eyyXFP4LWpR1uL77mxLw3yF1RRKAtBEVk25Ba7loxkGkN6uMtgBu
 gUL1gnQnPlPYWEtbUqgNUXIUOOurKx9Fsaf6dhQUiUgGijmSaoRv2Ik/l
 oBQpOUyCTOC+cihPxiCH1IbLqc6iEQnpzDcAG5F/Kbr1YUZw947RbjLEV w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="268653051"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; d="scan'208";a="268653051"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 09:11:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; d="scan'208";a="594121048"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by fmsmga004.fm.intel.com with ESMTP; 14 Jan 2022 09:11:13 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>
Subject: [PATCH v2] iommu/vt-d: Fix PCI bus rescan device hot add
Date: Fri, 14 Jan 2022 00:21:10 -0800
Message-Id: <1642148470-11949-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Raj Ashok <ashok.raj@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

During PCI bus rescan, adding new devices involve two notifiers.
1. dmar_pci_bus_notifier()
2. iommu_bus_notifier()
The current code sets #1 as low priority (INT_MIN) which resulted in #2
being invoked first. The result is that struct device pointer cannot be
found in DRHD search for the new device's DMAR/IOMMU. Subsequently, the
device is put under the "catch-all" IOMMU instead of the correct one.

This could cause system hang when device TLB invalidation is sent to the
wrong IOMMU. Invalidation timeout error and hard lockup have been observed.

On the reverse direction for device removal, the order should be #2-#1
such that DMAR cleanup is done after IOMMU.

This patch fixes the issue by setting proper priorities for
dmar_pci_bus_notifier around IOMMU bus notifier. DRHD search for a new
device will find the correct IOMMU. The order with this patch is the
following:
1. dmar_pci_bus_add_dev()
2. iommu_probe_device()
3. iommu_release_device()
4. dmar_pci_bus_remove_dev()

Fixes: 59ce0515cdaf ("iommu/vt-d: Update DRHD/RMRR/ATSR device scope")
Reported-by: Zhang, Bernice <bernice.zhang@intel.com>
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 69 ++++++++++++++++++++++++++++----------
 drivers/iommu/iommu.c      |  1 +
 include/linux/iommu.h      |  1 +
 3 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 915bff76fe96..5f4751ba6bb1 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -340,15 +340,19 @@ static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
 	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&physfn->dev));
 }
 
-static int dmar_pci_bus_notifier(struct notifier_block *nb,
+static int dmar_pci_bus_add_notifier(struct notifier_block *nb,
 				 unsigned long action, void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(data);
 	struct dmar_pci_notify_info *info;
 
-	/* Only care about add/remove events for physical functions.
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return NOTIFY_DONE;
+
+	/*
 	 * For VFs we actually do the lookup based on the corresponding
-	 * PF in device_to_iommu() anyway. */
+	 * PF in device_to_iommu() anyway.
+	 */
 	if (pdev->is_virtfn) {
 		/*
 		 * Ensure that the VF device inherits the irq domain of the
@@ -358,13 +362,34 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
 		 * from the PF device, but that's yet another x86'sism to
 		 * inflict on everybody else.
 		 */
-		if (action == BUS_NOTIFY_ADD_DEVICE)
-			vf_inherit_msi_domain(pdev);
+		vf_inherit_msi_domain(pdev);
 		return NOTIFY_DONE;
 	}
 
-	if (action != BUS_NOTIFY_ADD_DEVICE &&
-	    action != BUS_NOTIFY_REMOVED_DEVICE)
+	info = dmar_alloc_pci_notify_info(pdev, action);
+	if (!info)
+		return NOTIFY_DONE;
+
+	down_write(&dmar_global_lock);
+	dmar_pci_bus_add_dev(info);
+	up_write(&dmar_global_lock);
+	dmar_free_pci_notify_info(info);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block dmar_pci_bus_add_nb = {
+	.notifier_call = dmar_pci_bus_add_notifier,
+	.priority = IOMMU_BUS_NOTIFY_PRIORITY + 1,
+};
+
+static int dmar_pci_bus_remove_notifier(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(data);
+	struct dmar_pci_notify_info *info;
+
+	if (pdev->is_virtfn || action != BUS_NOTIFY_REMOVED_DEVICE)
 		return NOTIFY_DONE;
 
 	info = dmar_alloc_pci_notify_info(pdev, action);
@@ -372,10 +397,7 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	down_write(&dmar_global_lock);
-	if (action == BUS_NOTIFY_ADD_DEVICE)
-		dmar_pci_bus_add_dev(info);
-	else if (action == BUS_NOTIFY_REMOVED_DEVICE)
-		dmar_pci_bus_del_dev(info);
+	dmar_pci_bus_del_dev(info);
 	up_write(&dmar_global_lock);
 
 	dmar_free_pci_notify_info(info);
@@ -383,11 +405,10 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block dmar_pci_bus_nb = {
-	.notifier_call = dmar_pci_bus_notifier,
-	.priority = INT_MIN,
+static struct notifier_block dmar_pci_bus_remove_nb = {
+	.notifier_call = dmar_pci_bus_remove_notifier,
+	.priority = IOMMU_BUS_NOTIFY_PRIORITY - 1,
 };
-
 static struct dmar_drhd_unit *
 dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
 {
@@ -835,7 +856,17 @@ int __init dmar_dev_scope_init(void)
 
 void __init dmar_register_bus_notifier(void)
 {
-	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
+	/*
+	 * We need two notifiers in that we need to make sure the ordering
+	 * is enforced as the following:
+	 * 1. dmar_pci_bus_add_dev()
+	 * 2. iommu_probe_device()
+	 * 3. iommu_release_device()
+	 * 4. dmar_pci_bus_remove_dev()
+	 * Notifier block priority is used to enforce the order
+	 */
+	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_add_nb);
+	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_remove_nb);
 }
 
 
@@ -2151,8 +2182,10 @@ static int __init dmar_free_unused_resources(void)
 	if (dmar_in_use())
 		return 0;
 
-	if (dmar_dev_scope_status != 1 && !list_empty(&dmar_drhd_units))
-		bus_unregister_notifier(&pci_bus_type, &dmar_pci_bus_nb);
+	if (dmar_dev_scope_status != 1 && !list_empty(&dmar_drhd_units)) {
+		bus_unregister_notifier(&pci_bus_type, &dmar_pci_bus_add_nb);
+		bus_unregister_notifier(&pci_bus_type, &dmar_pci_bus_remove_nb);
+	}
 
 	down_write(&dmar_global_lock);
 	list_for_each_entry_safe(dmaru, dmaru_n, &dmar_drhd_units, list) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8b86406b7162..6103bcde1f65 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1841,6 +1841,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 		return -ENOMEM;
 
 	nb->notifier_call = iommu_bus_notifier;
+	nb->priority = IOMMU_BUS_NOTIFY_PRIORITY;
 
 	err = bus_register_notifier(bus, nb);
 	if (err)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index de0c57a567c8..8e13c69980be 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -403,6 +403,7 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 	};
 }
 
+#define IOMMU_BUS_NOTIFY_PRIORITY		0
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
 #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
 #define IOMMU_GROUP_NOTIFY_BIND_DRIVER		3 /* Pre Driver bind */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
