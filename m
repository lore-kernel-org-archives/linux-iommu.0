Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D88EC433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 19:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8F8241670;
	Wed, 16 Feb 2022 19:36:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AsDYh2TaWAFb; Wed, 16 Feb 2022 19:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B2D754166D;
	Wed, 16 Feb 2022 19:36:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90E87C001A;
	Wed, 16 Feb 2022 19:36:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D35CAC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 19:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD9CD41676
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 19:36:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A4avg25k9hYw for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 19:36:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 919B24166D
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 19:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645040178; x=1676576178;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5szMQlEDye63aiiwYqhef/hAzPhF9F7nlQ69TY5qzo0=;
 b=DPoGQkCU8kNjgT1jMi8B3DiM2sxKR3uoQnoZFUlmw6jY5+uhlC8Baq+t
 KtrHGcikZ1WPL0AuKlS5dMWWDnevr848lMTrckDl7qQwvhFSlvxYwJEVE
 +zK4EZWybdAYAzULL47IFhUyjWE2du20XMKtiD42MsuDn2W/VbMss7F3G
 njevQEbwA/sKP4mhAt4X0BoUOuWYmX3AW+ec/FWLkR/1mhg/5oFFypbzh
 RYC7/16IItC58gTA41vw5ixbgl+OYdltw7wpFVS0h1KSlPls8R+IUF5o1
 odsU933krZ6cS/yxpXTno4ZWzzcE9Kosa8VngxekTXTLuPXcLGqFlhTN7 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="230670117"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; d="scan'208";a="230670117"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2022 11:36:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; d="scan'208";a="529669418"
Received: from oux.sc.intel.com ([10.3.52.57])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2022 11:36:17 -0800
From: Yian Chen <yian.chen@intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Yian Chen <yian.chen@intel.com>
Subject: [PATCH] iommu/vt-d: Enable ATS for the devices in SATC table
Date: Wed, 16 Feb 2022 11:36:09 -0800
Message-Id: <20220216193609.686107-1-yian.chen@intel.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++++++++++---
 include/linux/intel-iommu.h |  2 +-
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..58a80cec50bb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -872,7 +872,6 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
 
 	return false;
 }
-
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 {
 	struct dmar_drhd_unit *drhd = NULL;
@@ -2684,7 +2683,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
-		    dmar_find_matched_atsr_unit(pdev))
+		    dmar_ats_supported(pdev, iommu))
 			info->ats_supported = 1;
 
 		if (sm_supported(iommu)) {
@@ -4020,7 +4019,42 @@ static void intel_iommu_free_dmars(void)
 	}
 }
 
-int dmar_find_matched_atsr_unit(struct pci_dev *dev)
+/* dev_satc_state - Find if dev is in a DMAR SATC table
+ *
+ * return value:
+ *    1: dev is in STAC table and ATS is required
+ *    0: dev is in SATC table and ATS is optional
+ *    -1: dev isn't in SATC table
+ */
+static int dev_satc_state(struct pci_dev *dev)
+{
+	int i, ret = -1;
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
+			if (to_pci_dev(tmp) == dev) {
+				if (satc->flags)
+					ret = 1;
+				else
+					ret = 0;
+				goto out;
+			}
+	}
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 {
 	int i, ret = 1;
 	struct pci_bus *bus;
@@ -4030,6 +4064,19 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
 	struct dmar_atsr_unit *atsru;
 
 	dev = pci_physfn(dev);
+	i = dev_satc_state(dev);
+	if (i >= 0) {
+		/* This dev supports ATS as it is in SATC table!
+		 * When IOMMU is in legacy mode, enabling ATS is done
+		 * automatically by HW for the device that requires
+		 * ATS, hence OS should not enable this device ATS
+		 * to avoid duplicated TLB invalidation
+		 */
+		if (i && !sm_supported(iommu))
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
