Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870D3C433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BC574061E;
	Tue,  1 Mar 2022 02:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fbr43G6jH_ag; Tue,  1 Mar 2022 02:04:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B6FAD40602;
	Tue,  1 Mar 2022 02:04:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A072CC0077;
	Tue,  1 Mar 2022 02:04:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C772CC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B706281771
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0gZy7EcGbWKy for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:04:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9DEB8175C
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646100247; x=1677636247;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eXh9Lm1L3vPkuDkiB1/N5WNnwDQC3Qw9O8G9Dl1EzaE=;
 b=DGjJe+p0T3L40DQgrHx1IvFEYRe6+N9ZuEBtS0wcn0053ae45P9CpRMQ
 YnF1F3PwOrQIzn+obt47zyCEwkDziHmuGUzUcsg19nwbZ4lwp4tDJHSN+
 oSSJuElmqzWExbfjzqspz5KxE02Deb1lfY0aq4huGqSj7+0mju0pczA3s
 Xf3C2WtQe17EW85PXXCzputV+fyZtYog3i8fMv2qo8YFldmqbt+Oa5Ayv
 DKJPsetNeyP2NMCUxEXkpYjjpXooalo9c+tOzDdq5PZha+v/pid9twQr4
 Pt0swtCJWRroM4U0O3k1CI61jyrPrncRLZlujQOFZ2vovzO5gUXErTptn g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339468506"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="339468506"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 18:04:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="685551252"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 18:04:05 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 12/12] iommu/vt-d: Enable ATS for the devices in SATC table
Date: Tue,  1 Mar 2022 10:01:59 +0800
Message-Id: <20220301020159.633356-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301020159.633356-1-baolu.lu@linux.intel.com>
References: <20220301020159.633356-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: YueHaibing <yuehaibing@huawei.com>, Marco Bonelli <marco@mebeim.net>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
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

Starting from Intel VT-d v3.2, Intel platform BIOS can provide additional
SATC table structure. SATC table includes a list of SoC integrated devices
that support ATC (Address translation cache).

Enabling ATC (via ATS capability) can be a functional requirement for SATC
device operation or optional to enhance device performance/functionality.
This is determined by the bit of ATC_REQUIRED in SATC table. When IOMMU is
working in scalable mode, software chooses to always enable ATS for every
device in SATC table because Intel SoC devices in SATC table are trusted to
use ATS.

On the other hand, if IOMMU is in legacy mode, ATS of SATC capable devices
can work transparently to software and be automatically enabled by IOMMU
hardware. As the result, there is no need for software to enable ATS on
these devices.

This also removes dmar_find_matched_atsr_unit() helper as it becomes dead
code now.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Link: https://lore.kernel.org/r/20220222185416.1722611-1-yian.chen@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 40 +++++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4909d6c9ac21..2f9891cb3d00 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -693,7 +693,6 @@ static inline int nr_pte_to_next_page(struct dma_pte *pte)
 }
 
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
-extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
 
 extern int dmar_enable_qi(struct intel_iommu *iommu);
 extern void dmar_disable_qi(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 19562891d6ef..df5c62ecf942 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3693,7 +3693,31 @@ static void intel_iommu_free_dmars(void)
 	}
 }
 
-int dmar_find_matched_atsr_unit(struct pci_dev *dev)
+static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
+{
+	struct dmar_satc_unit *satcu;
+	struct acpi_dmar_satc *satc;
+	struct device *tmp;
+	int i;
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
+static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 {
 	int i, ret = 1;
 	struct pci_bus *bus;
@@ -3701,8 +3725,20 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
 	struct device *tmp;
 	struct acpi_dmar_atsr *atsr;
 	struct dmar_atsr_unit *atsru;
+	struct dmar_satc_unit *satcu;
 
 	dev = pci_physfn(dev);
+	satcu = dmar_find_matched_satc_unit(dev);
+	if (satcu)
+		/*
+		 * This device supports ATS as it is in SATC table.
+		 * When IOMMU is in legacy mode, enabling ATS is done
+		 * automatically by HW for the device that requires
+		 * ATS, hence OS should not enable this device ATS
+		 * to avoid duplicated TLB invalidation.
+		 */
+		return !(satcu->atc_required && !sm_supported(iommu));
+
 	for (bus = dev->bus; bus; bus = bus->parent) {
 		bridge = bus->self;
 		/* If it's an integrated device, allow ATS */
@@ -4550,7 +4586,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	if (dev_is_pci(dev)) {
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
-		    dmar_find_matched_atsr_unit(pdev))
+		    dmar_ats_supported(pdev, iommu))
 			info->ats_supported = 1;
 
 		if (sm_supported(iommu)) {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
