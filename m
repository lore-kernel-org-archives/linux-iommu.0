Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645C3C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 04:49:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3D464DD9
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 04:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3D464DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC8C88672C;
	Tue,  2 Feb 2021 04:49:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tg9dFWo6+hy1; Tue,  2 Feb 2021 04:49:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E65186688;
	Tue,  2 Feb 2021 04:49:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65BCFC0FA7;
	Tue,  2 Feb 2021 04:49:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BE41C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 04:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0B26E86688
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 04:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MAu-n429ZmeB for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 04:49:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 25F85866A8
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 04:49:29 +0000 (UTC)
IronPort-SDR: 9OeVx5X6V+0VmZPBuS0dhUS94fQYPJNao7PmHtHcPygvLEkK5UQVQMNUeWrLltiHuehHmAQTmg
 73TNBh6kdIgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="199708358"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; d="scan'208";a="199708358"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 20:49:28 -0800
IronPort-SDR: R/dNSg65RdZPshCin9P8MfwjoRkOamHZaZKqFUoG5HBlszNxdqZUxUfpgHAi2mp5xBNJ94GPYf
 aq1c6jqM+aqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; d="scan'208";a="479423192"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2021 20:49:27 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/3] iommu/vt-d: Parse SATC reporting structure
Date: Tue,  2 Feb 2021 12:40:56 +0800
Message-Id: <20210202044057.615277-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202044057.615277-1-baolu.lu@linux.intel.com>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
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
SATC policy deployment.

Signed-off-by: Yian Chen <yian.chen@intel.com>
---
 drivers/iommu/intel/dmar.c  |  9 ++++
 drivers/iommu/intel/iommu.c | 89 +++++++++++++++++++++++++++++++++++++
 include/linux/dmar.h        |  2 +
 3 files changed, 100 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 980e8ae090af..6bd357966d4e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -526,6 +526,7 @@ dmar_table_print_dmar_entry(struct acpi_dmar_header *header)
 	struct acpi_dmar_reserved_memory *rmrr;
 	struct acpi_dmar_atsr *atsr;
 	struct acpi_dmar_rhsa *rhsa;
+	struct acpi_dmar_satc *satc;
 
 	switch (header->type) {
 	case ACPI_DMAR_TYPE_HARDWARE_UNIT:
@@ -555,6 +556,11 @@ dmar_table_print_dmar_entry(struct acpi_dmar_header *header)
 		/* We don't print this here because we need to sanity-check
 		   it first. So print it in dmar_parse_one_andd() instead. */
 		break;
+	case ACPI_DMAR_TYPE_SATC:
+		satc = container_of(header, struct acpi_dmar_satc, header);
+		pr_info("SATC flags: 0x%x\n", satc->flags);
+		break;
+
 	}
 }
 
@@ -642,6 +648,7 @@ parse_dmar_table(void)
 		.cb[ACPI_DMAR_TYPE_ROOT_ATS] = &dmar_parse_one_atsr,
 		.cb[ACPI_DMAR_TYPE_HARDWARE_AFFINITY] = &dmar_parse_one_rhsa,
 		.cb[ACPI_DMAR_TYPE_NAMESPACE] = &dmar_parse_one_andd,
+		.cb[ACPI_DMAR_TYPE_SATC] = &dmar_parse_one_satc,
 	};
 
 	/*
@@ -2077,6 +2084,7 @@ static guid_t dmar_hp_guid =
 #define	DMAR_DSM_FUNC_DRHD		1
 #define	DMAR_DSM_FUNC_ATSR		2
 #define	DMAR_DSM_FUNC_RHSA		3
+#define	DMAR_DSM_FUNC_SATC		4
 
 static inline bool dmar_detect_dsm(acpi_handle handle, int func)
 {
@@ -2094,6 +2102,7 @@ static int dmar_walk_dsm_resource(acpi_handle handle, int func,
 		[DMAR_DSM_FUNC_DRHD] = ACPI_DMAR_TYPE_HARDWARE_UNIT,
 		[DMAR_DSM_FUNC_ATSR] = ACPI_DMAR_TYPE_ROOT_ATS,
 		[DMAR_DSM_FUNC_RHSA] = ACPI_DMAR_TYPE_HARDWARE_AFFINITY,
+		[DMAR_DSM_FUNC_SATC] = ACPI_DMAR_TYPE_SATC,
 	};
 
 	if (!dmar_detect_dsm(handle, func))
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ecd36e456de3..b20fd305fc60 100644
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
@@ -3736,6 +3746,57 @@ int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void *arg)
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
@@ -3843,6 +3904,7 @@ static void intel_iommu_free_dmars(void)
 {
 	struct dmar_rmrr_unit *rmrru, *rmrr_n;
 	struct dmar_atsr_unit *atsru, *atsr_n;
+	struct dmar_satc_unit *satcu, *satc_n;
 
 	list_for_each_entry_safe(rmrru, rmrr_n, &dmar_rmrr_units, list) {
 		list_del(&rmrru->list);
@@ -3854,6 +3916,11 @@ static void intel_iommu_free_dmars(void)
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
@@ -3905,8 +3972,10 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 	int ret;
 	struct dmar_rmrr_unit *rmrru;
 	struct dmar_atsr_unit *atsru;
+	struct dmar_satc_unit *satcu;
 	struct acpi_dmar_atsr *atsr;
 	struct acpi_dmar_reserved_memory *rmrr;
+	struct acpi_dmar_satc *satc;
 
 	if (!intel_iommu_enabled && system_state >= SYSTEM_RUNNING)
 		return 0;
@@ -3947,6 +4016,23 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
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
@@ -4290,6 +4376,9 @@ int __init intel_iommu_init(void)
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
