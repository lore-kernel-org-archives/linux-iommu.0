Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B535AC433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 04:49:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7305A64DD9
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 04:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7305A64DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A7AB86DF0;
	Tue,  2 Feb 2021 04:49:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Aix8PV5xRwK5; Tue,  2 Feb 2021 04:49:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD87086F79;
	Tue,  2 Feb 2021 04:49:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 989DEC0FA7;
	Tue,  2 Feb 2021 04:49:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 704C1C1825
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 04:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 619318673E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 04:49:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYyzuavU7gK5 for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 04:49:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 99A4586688
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 04:49:30 +0000 (UTC)
IronPort-SDR: Pa2C0xf0/LMbMfMfnq6/qYTmVBOc1UQ8ZJeDTtWE6FQZ+HXcW8HmyhlbFgBFsyGWLH8yF/73nz
 ULqkT2548gQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="199708363"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; d="scan'208";a="199708363"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 20:49:30 -0800
IronPort-SDR: aRjBaadAdemjEMGH0oR7+SK0in9VzE2z5ny5CalLmKOxVxb7FCJM8gDMlzRgvpgvflqTFES7jd
 MY7HKCCMaQVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; d="scan'208";a="479423200"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2021 20:49:29 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 3/3] iommu/vt-d: Apply SATC policy
Date: Tue,  2 Feb 2021 12:40:57 +0800
Message-Id: <20210202044057.615277-4-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 72 ++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b20fd305fc60..131fac718a4b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -872,6 +872,59 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
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
+		if (satcu->atc_required &&
+		    satcu->devices_cnt &&
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
+		if (satc->segment == pci_domain_nr(dev->bus) && satcu->atc_required) {
+			for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
+				if (to_pci_dev(tmp) == dev)
+					goto out;
+		}
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
@@ -2575,10 +2628,16 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
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
@@ -3175,6 +3234,11 @@ static int __init init_dmars(void)
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
