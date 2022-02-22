Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B1FC433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 18:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF8C9402DD;
	Tue, 22 Feb 2022 18:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Unext7RsoFRy; Tue, 22 Feb 2022 18:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A0243402BC;
	Tue, 22 Feb 2022 18:54:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F9F7C001A;
	Tue, 22 Feb 2022 18:54:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 721FEC0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 18:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5203F60EEF
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 18:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8rc0DIzo4iIf for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:54:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85C1760B6A
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 18:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645556073; x=1677092073;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=oaMfgQdcTHgSG9PJV6HqTAIJsJi+MkXGCe+Nq5OSzjw=;
 b=D9j+ZN+bBx/Z6ja0bESCCNHW+XXEEB9TMqkNoqapVECuYsnWNW7EZbz1
 jV29TMDiuXLQJBx9wq/19brQOY188DtkwNHVZSQDaKDOWArpy+am1d8GG
 XuGDVWs5UO0HmN37NwDCfANe8oAL26xdoN+KIopojaPY8jwJGXVAiMkjx
 Hwhr6ClVgN2KVqHQhW94QkgHusi9hpVi5GDd+VtS4PpR2s754HgSBT87S
 J88YqDoeM50M3dMKLdjN1nFtB3ZbvycwO6jV8hLfap30+y0nrRevhuSb4
 gBv1+DcP80HrGnf4AGaIQ/sn2nB0E6P75bY0kFH2EgcUX2dx4CPr4Qtgi A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="239168606"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="239168606"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 10:54:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="508105491"
Received: from oux.sc.intel.com ([10.3.52.57])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 10:54:24 -0800
From: Yian Chen <yian.chen@intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Yian Chen <yian.chen@intel.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=C2=A0=201/2=5D=20iommu/vt-d=3A=20Enable=20ATS=20for=20the=20devices=20in=20SATC=20table?=
Date: Tue, 22 Feb 2022 10:54:15 -0800
Message-Id: <20220222185416.1722611-2-yian.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222185416.1722611-1-yian.chen@intel.com>
References: <20220222185416.1722611-1-yian.chen@intel.com>
MIME-Version: 1.0
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

Starting from Intel VT-d v3.2, Intel platform BIOS can provide
additional SATC table structure. SATC table includes a list of
SoC integrated devices that support ATC (Address translation
cache).

Enabling ATC (via ATS capability) can be a functional requirement
for SATC device operation or an optional to enhance device
performance/functionality. This is determined by the bit of
ATC_REQUIRED in SATC table. When IOMMU is working in scalable
mode, software chooses to always enable ATS for every device in
SATC table because Intel SoC devices in SATC table are trusted
to use ATS.

On the other hand, if IOMMU is in legacy mode, ATS of SATC
capable devices can work transparently to software and be
automatically enabled by IOMMU hardware. As the result,
there is no need for software to enable ATS on these devices.

Signed-off-by: Yian Chen <yian.chen@intel.com>
---
 drivers/iommu/intel/iommu.c | 42 +++++++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h |  2 +-
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..aa0b27b5bf83 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2684,7 +2684,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
-		    dmar_find_matched_atsr_unit(pdev))
+		    dmar_ats_supported(pdev, iommu))
 			info->ats_supported = 1;
 
 		if (sm_supported(iommu)) {
@@ -4020,7 +4020,31 @@ static void intel_iommu_free_dmars(void)
 	}
 }
 
-int dmar_find_matched_atsr_unit(struct pci_dev *dev)
+static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
+{
+	int i;
+	struct device *tmp;
+	struct dmar_satc_unit *satcu;
+	struct acpi_dmar_satc *satc;
+
+	dev = pci_physfn(dev);
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
+		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
+		if (satc->segment != pci_domain_nr(dev->bus))
+			continue;
+		for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
+			if (to_pci_dev(tmp) == dev)
+				goto out;
+	}
+	satcu = NULL;
+out:
+	rcu_read_unlock();
+	return satcu;
+}
+
+int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 {
 	int i, ret = 1;
 	struct pci_bus *bus;
@@ -4028,8 +4052,22 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
 	struct device *tmp;
 	struct acpi_dmar_atsr *atsr;
 	struct dmar_atsr_unit *atsru;
+	struct dmar_satc_unit *satcu;
 
 	dev = pci_physfn(dev);
+	satcu = dmar_find_matched_satc_unit(dev);
+	if (satcu) {
+		/* This dev supports ATS as it is in SATC table!
+		 * When IOMMU is in legacy mode, enabling ATS is done
+		 * automatically by HW for the device that requires
+		 * ATS, hence OS should not enable this device ATS
+		 * to avoid duplicated TLB invalidation
+		 */
+		if (satcu->atc_required && !sm_supported(iommu))
+			ret = 0;
+		return ret;
+	}
+
 	for (bus = dev->bus; bus; bus = bus->parent) {
 		bridge = bus->self;
 		/* If it's an integrated device, allow ATS */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 69230fd695ea..fe9fd417d611 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -717,7 +717,7 @@ static inline int nr_pte_to_next_page(struct dma_pte *pte)
 }
 
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
-extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
+extern int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu);
 
 extern int dmar_enable_qi(struct intel_iommu *iommu);
 extern void dmar_disable_qi(struct intel_iommu *iommu);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
