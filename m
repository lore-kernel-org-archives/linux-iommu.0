Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FFFC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 01:53:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC58264E42
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 01:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC58264E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A4B6A86388;
	Thu,  4 Feb 2021 01:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M7glpZdb4klw; Thu,  4 Feb 2021 01:53:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 05776861BC;
	Thu,  4 Feb 2021 01:53:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E82CAC0174;
	Thu,  4 Feb 2021 01:53:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28E2FC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0FC82272F6
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id odvrvM4h8BDl for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 01:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 3049F27261
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:53:03 +0000 (UTC)
IronPort-SDR: QI8BSgHDDQ74+Xpna9GDRvCJkCrEcw7x0kvBZcP766y+wawFITBbdN/+2wiWQWtR5N1PBm3iPA
 zmtap8fOJn4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="245227163"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="245227163"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 17:53:02 -0800
IronPort-SDR: A5mRTn80PqqwngEqFGIBKNmGZg4RBwTbS5MgEWodKdycVHj3Eb3LTJ2AyFYQ2VpGn5rzzpqYwE
 J/9DOTKjdrvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="406911241"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 17:53:00 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 7/7] iommu/vt-d: Apply SATC policy
Date: Thu,  4 Feb 2021 09:44:01 +0800
Message-Id: <20210204014401.2846425-8-baolu.lu@linux.intel.com>
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

Starting from Intel VT-d v3.2, Intel platform BIOS can provide a new SATC
table structure. SATC table lists a set of SoC integrated devices that
require ATC to work (VT-d specification v3.2, section 8.8). Furthermore,
the new version of IOMMU supports SoC device ATS in both its Scalable mode
and legacy mode.

When IOMMU is working in scalable mode, software must enable device ATS
support. On the other hand, when IOMMU is in legacy mode for whatever
reason, the hardware managed ATS will automatically take effect and the
SATC required devices can work transparently to the software. As the
result, software shouldn't enable ATS on that device, otherwise duplicate
device TLB invalidations will occur.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Link: https://lore.kernel.org/r/20210203093329.1617808-1-baolu.lu@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 73 +++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..3e30c340e6a9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -872,6 +872,60 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
 	return false;
 }
 
+static bool iommu_support_ats(struct intel_iommu *iommu)
+{
+	return ecap_dev_iotlb_support(iommu->ecap);
+}
+
+static bool device_support_ats(struct pci_dev *dev)
+{
+	return pci_ats_supported(dev) && dmar_find_matched_atsr_unit(dev);
+}
+
+static int segment_atc_required(u16 segment)
+{
+	struct acpi_dmar_satc *satc;
+	struct dmar_satc_unit *satcu;
+	int ret = 1;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
+		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
+		if (satcu->atc_required && satcu->devices_cnt &&
+		    satc->segment == segment)
+			goto out;
+	}
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int device_atc_required(struct pci_dev *dev)
+{
+	struct dmar_satc_unit *satcu;
+	struct acpi_dmar_satc *satc;
+	struct device *tmp;
+	int i, ret = 1;
+
+	dev = pci_physfn(dev);
+	rcu_read_lock();
+	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
+		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
+		if (!satcu->atc_required ||
+		    satc->segment != pci_domain_nr(dev->bus))
+			continue;
+
+		for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
+			if (to_pci_dev(tmp) == dev)
+				goto out;
+	}
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 {
 	struct dmar_drhd_unit *drhd = NULL;
@@ -2555,10 +2609,16 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
 
-		if (ecap_dev_iotlb_support(iommu->ecap) &&
-		    pci_ats_supported(pdev) &&
-		    dmar_find_matched_atsr_unit(pdev))
-			info->ats_supported = 1;
+		/*
+		 * Support ATS by default if it's supported by both IOMMU and
+		 * client sides, except that the device's ATS is required by
+		 * ACPI/SATC but the IOMMU scalable mode is disabled. In that
+		 * case the hardware managed ATS will be automatically used.
+		 */
+		if (iommu_support_ats(iommu) && device_support_ats(pdev)) {
+			if (!device_atc_required(pdev) || sm_supported(iommu))
+				info->ats_supported = 1;
+		}
 
 		if (sm_supported(iommu)) {
 			if (pasid_supported(iommu)) {
@@ -3155,6 +3215,11 @@ static int __init init_dmars(void)
 	 * endfor
 	 */
 	for_each_drhd_unit(drhd) {
+		if (pci_ats_disabled() && segment_atc_required(drhd->segment)) {
+			pr_warn("Scalable mode disabled -- Use hardware managed ATS because PCIe ATS is disabled but some devices in PCIe segment 0x%x require it.",
+				drhd->segment);
+			intel_iommu_sm = 0;
+		}
 		/*
 		 * lock not needed as this is only incremented in the single
 		 * threaded kernel __init code path all other access are read
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
