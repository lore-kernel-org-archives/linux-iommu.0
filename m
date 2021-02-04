Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C9FC433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 01:53:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E79564DDE
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 01:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E79564DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C90AF87158;
	Thu,  4 Feb 2021 01:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRENXI-nFXFC; Thu,  4 Feb 2021 01:53:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CB45D8716D;
	Thu,  4 Feb 2021 01:53:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B91B4C0174;
	Thu,  4 Feb 2021 01:53:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02119C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D22ED27261
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E5-bJezrrpyS for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 01:53:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 233A7272F6
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:53:01 +0000 (UTC)
IronPort-SDR: yHsNXUOrVZISMK/+zTK6f+07sunTA+6bf6fipBHK+A6bJhpOcFpeZDwSlIeJsnqTLHpAr89XeQ
 BhjejB5ekdTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="245227158"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="245227158"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 17:53:00 -0800
IronPort-SDR: WqXfhB77lwvJniN/7aIIkSlXSMBTF50+WMkSfbw4yIhVzvNbD4xkiLs1tsI4+vEIXI5Ymib64i
 AYvqDWbPfaAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="406911228"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 17:52:58 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 6/7] iommu/vt-d: Parse SATC reporting structure
Date: Thu,  4 Feb 2021 09:44:00 +0800
Message-Id: <20210204014401.2846425-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204014401.2846425-1-baolu.lu@linux.intel.com>
References: <20210204014401.2846425-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kyung Min Park <kyung.min.park@intel.com>, iommu@lists.linux-foundation.org,
 Chuck Lever <chuck.lever@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

From: Yian Chen <yian.chen@intel.com>

Software should parse every SATC table and all devices in the tables
reported by the BIOS and keep the information in kernel list for further
reference.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Link: https://lore.kernel.org/r/20210203093329.1617808-1-baolu.lu@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  |  8 ++++
 drivers/iommu/intel/iommu.c | 89 +++++++++++++++++++++++++++++++++++++
 include/linux/dmar.h        |  2 +
 3 files changed, 99 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 980e8ae090af..d5c51b5c20af 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -526,6 +526,7 @@ dmar_table_print_dmar_entry(struct acpi_dmar_header *header)
 	struct acpi_dmar_reserved_memory *rmrr;
 	struct acpi_dmar_atsr *atsr;
 	struct acpi_dmar_rhsa *rhsa;
+	struct acpi_dmar_satc *satc;
 
 	switch (header->type) {
 	case ACPI_DMAR_TYPE_HARDWARE_UNIT:
@@ -555,6 +556,10 @@ dmar_table_print_dmar_entry(struct acpi_dmar_header *header)
 		/* We don't print this here because we need to sanity-check
 		   it first. So print it in dmar_parse_one_andd() instead. */
 		break;
+	case ACPI_DMAR_TYPE_SATC:
+		satc = container_of(header, struct acpi_dmar_satc, header);
+		pr_info("SATC flags: 0x%x\n", satc->flags);
+		break;
 	}
 }
 
@@ -642,6 +647,7 @@ parse_dmar_table(void)
 		.cb[ACPI_DMAR_TYPE_ROOT_ATS] = &dmar_parse_one_atsr,
 		.cb[ACPI_DMAR_TYPE_HARDWARE_AFFINITY] = &dmar_parse_one_rhsa,
 		.cb[ACPI_DMAR_TYPE_NAMESPACE] = &dmar_parse_one_andd,
+		.cb[ACPI_DMAR_TYPE_SATC] = &dmar_parse_one_satc,
 	};
 
 	/*
@@ -2077,6 +2083,7 @@ static guid_t dmar_hp_guid =
 #define	DMAR_DSM_FUNC_DRHD		1
 #define	DMAR_DSM_FUNC_ATSR		2
 #define	DMAR_DSM_FUNC_RHSA		3
+#define	DMAR_DSM_FUNC_SATC		4
 
 static inline bool dmar_detect_dsm(acpi_handle handle, int func)
 {
@@ -2094,6 +2101,7 @@ static int dmar_walk_dsm_resource(acpi_handle handle, int func,
 		[DMAR_DSM_FUNC_DRHD] = ACPI_DMAR_TYPE_HARDWARE_UNIT,
 		[DMAR_DSM_FUNC_ATSR] = ACPI_DMAR_TYPE_ROOT_ATS,
 		[DMAR_DSM_FUNC_RHSA] = ACPI_DMAR_TYPE_HARDWARE_AFFINITY,
+		[DMAR_DSM_FUNC_SATC] = ACPI_DMAR_TYPE_SATC,
 	};
 
 	if (!dmar_detect_dsm(handle, func))
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ecbd05d8a1fc..ee0932307d64 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -316,8 +316,18 @@ struct dmar_atsr_unit {
 	u8 include_all:1;		/* include all ports */
 };
 
+struct dmar_satc_unit {
+	struct list_head list;		/* list of SATC units */
+	struct acpi_dmar_header *hdr;	/* ACPI header */
+	struct dmar_dev_scope *devices;	/* target devices */
+	struct intel_iommu *iommu;	/* the corresponding iommu */
+	int devices_cnt;		/* target device count */
+	u8 atc_required:1;		/* ATS is required */
+};
+
 static LIST_HEAD(dmar_atsr_units);
 static LIST_HEAD(dmar_rmrr_units);
+static LIST_HEAD(dmar_satc_units);
 
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
@@ -3716,6 +3726,57 @@ int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void *arg)
 	return 0;
 }
 
+static struct dmar_satc_unit *dmar_find_satc(struct acpi_dmar_satc *satc)
+{
+	struct dmar_satc_unit *satcu;
+	struct acpi_dmar_satc *tmp;
+
+	list_for_each_entry_rcu(satcu, &dmar_satc_units, list,
+				dmar_rcu_check()) {
+		tmp = (struct acpi_dmar_satc *)satcu->hdr;
+		if (satc->segment != tmp->segment)
+			continue;
+		if (satc->header.length != tmp->header.length)
+			continue;
+		if (memcmp(satc, tmp, satc->header.length) == 0)
+			return satcu;
+	}
+
+	return NULL;
+}
+
+int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
+{
+	struct acpi_dmar_satc *satc;
+	struct dmar_satc_unit *satcu;
+
+	if (system_state >= SYSTEM_RUNNING && !intel_iommu_enabled)
+		return 0;
+
+	satc = container_of(hdr, struct acpi_dmar_satc, header);
+	satcu = dmar_find_satc(satc);
+	if (satcu)
+		return 0;
+
+	satcu = kzalloc(sizeof(*satcu) + hdr->length, GFP_KERNEL);
+	if (!satcu)
+		return -ENOMEM;
+
+	satcu->hdr = (void *)(satcu + 1);
+	memcpy(satcu->hdr, hdr, hdr->length);
+	satcu->atc_required = satc->flags & 0x1;
+	satcu->devices = dmar_alloc_dev_scope((void *)(satc + 1),
+					      (void *)satc + satc->header.length,
+					      &satcu->devices_cnt);
+	if (satcu->devices_cnt && !satcu->devices) {
+		kfree(satcu);
+		return -ENOMEM;
+	}
+	list_add_rcu(&satcu->list, &dmar_satc_units);
+
+	return 0;
+}
+
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
 	int sp, ret;
@@ -3823,6 +3884,7 @@ static void intel_iommu_free_dmars(void)
 {
 	struct dmar_rmrr_unit *rmrru, *rmrr_n;
 	struct dmar_atsr_unit *atsru, *atsr_n;
+	struct dmar_satc_unit *satcu, *satc_n;
 
 	list_for_each_entry_safe(rmrru, rmrr_n, &dmar_rmrr_units, list) {
 		list_del(&rmrru->list);
@@ -3834,6 +3896,11 @@ static void intel_iommu_free_dmars(void)
 		list_del(&atsru->list);
 		intel_iommu_free_atsr(atsru);
 	}
+	list_for_each_entry_safe(satcu, satc_n, &dmar_satc_units, list) {
+		list_del(&satcu->list);
+		dmar_free_dev_scope(&satcu->devices, &satcu->devices_cnt);
+		kfree(satcu);
+	}
 }
 
 int dmar_find_matched_atsr_unit(struct pci_dev *dev)
@@ -3885,8 +3952,10 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 	int ret;
 	struct dmar_rmrr_unit *rmrru;
 	struct dmar_atsr_unit *atsru;
+	struct dmar_satc_unit *satcu;
 	struct acpi_dmar_atsr *atsr;
 	struct acpi_dmar_reserved_memory *rmrr;
+	struct acpi_dmar_satc *satc;
 
 	if (!intel_iommu_enabled && system_state >= SYSTEM_RUNNING)
 		return 0;
@@ -3927,6 +3996,23 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 				break;
 		}
 	}
+	list_for_each_entry(satcu, &dmar_satc_units, list) {
+		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
+		if (info->event == BUS_NOTIFY_ADD_DEVICE) {
+			ret = dmar_insert_dev_scope(info, (void *)(satc + 1),
+					(void *)satc + satc->header.length,
+					satc->segment, satcu->devices,
+					satcu->devices_cnt);
+			if (ret > 0)
+				break;
+			else if (ret < 0)
+				return ret;
+		} else if (info->event == BUS_NOTIFY_REMOVED_DEVICE) {
+			if (dmar_remove_dev_scope(info, satc->segment,
+					satcu->devices, satcu->devices_cnt))
+				break;
+		}
+	}
 
 	return 0;
 }
@@ -4270,6 +4356,9 @@ int __init intel_iommu_init(void)
 	if (list_empty(&dmar_atsr_units))
 		pr_info("No ATSR found\n");
 
+	if (list_empty(&dmar_satc_units))
+		pr_info("No SATC found\n");
+
 	if (dmar_map_gfx)
 		intel_iommu_gfx_mapped = 1;
 
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 65565820328a..e04436a7ff27 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -138,6 +138,7 @@ extern void intel_iommu_shutdown(void);
 extern int dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg);
 extern int dmar_parse_one_atsr(struct acpi_dmar_header *header, void *arg);
 extern int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void *arg);
+extern int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg);
 extern int dmar_release_one_atsr(struct acpi_dmar_header *hdr, void *arg);
 extern int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert);
 extern int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info);
@@ -149,6 +150,7 @@ static inline void intel_iommu_shutdown(void) { }
 #define	dmar_parse_one_atsr		dmar_res_noop
 #define	dmar_check_one_atsr		dmar_res_noop
 #define	dmar_release_one_atsr		dmar_res_noop
+#define	dmar_parse_one_satc		dmar_res_noop
 
 static inline int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
