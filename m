Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FE9C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 18:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F214A401CC;
	Tue, 22 Feb 2022 18:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UP_Q68IGaHNn; Tue, 22 Feb 2022 18:54:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B41940167;
	Tue, 22 Feb 2022 18:54:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44589C001A;
	Tue, 22 Feb 2022 18:54:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 907E8C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 18:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4288C60EE0
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 18:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QeeIVTlc6rde for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:54:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7508B60B6A
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 18:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645556074; x=1677092074;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0eEVoBEoLghU3hLOEP5nLnPp5kV4RYKvZKL/+tFfRYo=;
 b=lUyyX0vJg8qk5t9wiR72U+j6w23dT+TdSXh7Nozm2I8c8DUk1MHq64Ds
 ynvVUpNgt9copWdfGyu3Y7qv3tPmeBAs+P+m4tz0SIM91kj8CDda/GyFl
 R7I9EJFaSqy0i9FVCh2Bknr2jrrJ1MoIEYiNxI67Gy6i6plvVuC8+3vA8
 tRv8QYN/ChH20vIXipIbE8QU3aIIZU4UrDudvhTCxdaSa8eRm52iF6cLS
 eHpoyODCaYpPCXKPhsEgvSLa46M/uji2eBAznLlxbesYAqvK0djXl4K9e
 /8LU0hHNw5ZANSBsJq83o4H56YQ3Ugrc6S66srTwcxzyQpg/J8Gi5FYhX g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="239168608"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="239168608"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 10:54:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="508105495"
Received: from oux.sc.intel.com ([10.3.52.57])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 10:54:24 -0800
From: Yian Chen <yian.chen@intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Yian Chen <yian.chen@intel.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=C2=A0=202/2=5D=20iommu/vt-d=3A=20Declare=20dmar=5Fats=5Fsupported=28=29=20as=20static=20function?=
Date: Tue, 22 Feb 2022 10:54:16 -0800
Message-Id: <20220222185416.1722611-3-yian.chen@intel.com>
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

dmar_ats_supported() is defined in and only used by iommu.c
so that declare it as a static function and move the
code accordingly.

Signed-off-by: Yian Chen <yian.chen@intel.com>
---
 drivers/iommu/intel/iommu.c | 164 ++++++++++++++++++------------------
 include/linux/intel-iommu.h |   1 -
 2 files changed, 82 insertions(+), 83 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index aa0b27b5bf83..eaf9764c476d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2643,6 +2643,88 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
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
+static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
+{
+	int i, ret = 1;
+	struct pci_bus *bus;
+	struct pci_dev *bridge = NULL;
+	struct device *tmp;
+	struct acpi_dmar_atsr *atsr;
+	struct dmar_atsr_unit *atsru;
+	struct dmar_satc_unit *satcu;
+
+	dev = pci_physfn(dev);
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
+	for (bus = dev->bus; bus; bus = bus->parent) {
+		bridge = bus->self;
+		/* If it's an integrated device, allow ATS */
+		if (!bridge)
+			return 1;
+		/* Connected via non-PCIe: no ATS */
+		if (!pci_is_pcie(bridge) ||
+		    pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)
+			return 0;
+		/* If we found the root port, look it up in the ATSR */
+		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
+			break;
+	}
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list) {
+		atsr = container_of(atsru->hdr, struct acpi_dmar_atsr, header);
+		if (atsr->segment != pci_domain_nr(dev->bus))
+			continue;
+
+		for_each_dev_scope(atsru->devices, atsru->devices_cnt, i, tmp)
+			if (tmp == &bridge->dev)
+				goto out;
+
+		if (atsru->include_all)
+			goto out;
+	}
+	ret = 0;
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    int bus, int devfn,
 						    struct device *dev,
@@ -4020,88 +4102,6 @@ static void intel_iommu_free_dmars(void)
 	}
 }
 
-static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
-{
-	int i;
-	struct device *tmp;
-	struct dmar_satc_unit *satcu;
-	struct acpi_dmar_satc *satc;
-
-	dev = pci_physfn(dev);
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
-		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
-		if (satc->segment != pci_domain_nr(dev->bus))
-			continue;
-		for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
-			if (to_pci_dev(tmp) == dev)
-				goto out;
-	}
-	satcu = NULL;
-out:
-	rcu_read_unlock();
-	return satcu;
-}
-
-int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
-{
-	int i, ret = 1;
-	struct pci_bus *bus;
-	struct pci_dev *bridge = NULL;
-	struct device *tmp;
-	struct acpi_dmar_atsr *atsr;
-	struct dmar_atsr_unit *atsru;
-	struct dmar_satc_unit *satcu;
-
-	dev = pci_physfn(dev);
-	satcu = dmar_find_matched_satc_unit(dev);
-	if (satcu) {
-		/* This dev supports ATS as it is in SATC table!
-		 * When IOMMU is in legacy mode, enabling ATS is done
-		 * automatically by HW for the device that requires
-		 * ATS, hence OS should not enable this device ATS
-		 * to avoid duplicated TLB invalidation
-		 */
-		if (satcu->atc_required && !sm_supported(iommu))
-			ret = 0;
-		return ret;
-	}
-
-	for (bus = dev->bus; bus; bus = bus->parent) {
-		bridge = bus->self;
-		/* If it's an integrated device, allow ATS */
-		if (!bridge)
-			return 1;
-		/* Connected via non-PCIe: no ATS */
-		if (!pci_is_pcie(bridge) ||
-		    pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)
-			return 0;
-		/* If we found the root port, look it up in the ATSR */
-		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
-			break;
-	}
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list) {
-		atsr = container_of(atsru->hdr, struct acpi_dmar_atsr, header);
-		if (atsr->segment != pci_domain_nr(dev->bus))
-			continue;
-
-		for_each_dev_scope(atsru->devices, atsru->devices_cnt, i, tmp)
-			if (tmp == &bridge->dev)
-				goto out;
-
-		if (atsru->include_all)
-			goto out;
-	}
-	ret = 0;
-out:
-	rcu_read_unlock();
-
-	return ret;
-}
-
 int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 {
 	int ret;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fe9fd417d611..9262cdf04f05 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -717,7 +717,6 @@ static inline int nr_pte_to_next_page(struct dma_pte *pte)
 }
 
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
-extern int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu);
 
 extern int dmar_enable_qi(struct intel_iommu *iommu);
 extern void dmar_disable_qi(struct intel_iommu *iommu);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
