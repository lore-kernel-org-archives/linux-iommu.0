Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB3EC433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 23:18:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C5C20708
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 23:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C5C20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 58FE788730;
	Mon, 22 Jun 2020 23:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kmDKhwaUM-fT; Mon, 22 Jun 2020 23:18:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 577C88870A;
	Mon, 22 Jun 2020 23:18:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FFEBC089E;
	Mon, 22 Jun 2020 23:18:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71712C016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6184686DA1
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 94f1UzuCHYog for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 23:18:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B249B86D6A
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:05 +0000 (UTC)
IronPort-SDR: gqAHY8aSjllS5ciGBbNakuq+W0V9NZGzceyBpbQeqIBYUMCsqLMLuVybfG5HHJWk8tvJq7756R
 UGFourg+N+AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="145405642"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="145405642"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 16:18:05 -0700
IronPort-SDR: HMvk6RRXxD859ZXybX/K9sO2bPq0f66B15g1qtA+AS1ewSXR6/BXoZ40a/bzJ+WKBiILGxhkF5
 OxX9u15qlyCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="301006537"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2020 16:18:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/6] iommu/vt-d: Don't apply gfx quirks to untrusted devices
Date: Tue, 23 Jun 2020 07:13:42 +0800
Message-Id: <20200622231345.29722-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622231345.29722-1-baolu.lu@linux.intel.com>
References: <20200622231345.29722-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Rajat Jain <rajatja@google.com>
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

From: Rajat Jain <rajatja@google.com>

Currently, an external malicious PCI device can masquerade the VID:PID
of faulty gfx devices, and thus apply iommu quirks to effectively
disable the IOMMU restrictions for itself.

Thus we need to ensure that the device we are applying quirks to, is
indeed an internal trusted device.

Signed-off-by: Rajat Jain <rajatja@google.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0fa394f7bbf9..66d07b1a3be2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -6020,6 +6020,23 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
+/*
+ * Check that the device does not live on an external facing PCI port that is
+ * marked as untrusted. Such devices should not be able to apply quirks and
+ * thus not be able to bypass the IOMMU restrictions.
+ */
+static bool risky_device(struct pci_dev *pdev)
+{
+	if (pdev->untrusted) {
+		pci_info(pdev,
+			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
+			 pdev->vendor, pdev->device);
+		pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");
+		return true;
+	}
+	return false;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -6059,6 +6076,9 @@ const struct iommu_ops intel_iommu_ops = {
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
 {
+	if (risky_device(dev))
+		return;
+
 	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
@@ -6100,6 +6120,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
+	if (risky_device(dev))
+		return;
+
 	/*
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
 	 * but needs it. Same seems to hold for the desktop versions.
@@ -6130,6 +6153,9 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 {
 	unsigned short ggc;
 
+	if (risky_device(dev))
+		return;
+
 	if (pci_read_config_word(dev, GGC, &ggc))
 		return;
 
@@ -6163,6 +6189,12 @@ static void __init check_tylersburg_isoch(void)
 	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
 	if (!pdev)
 		return;
+
+	if (risky_device(pdev)) {
+		pci_dev_put(pdev);
+		return;
+	}
+
 	pci_dev_put(pdev);
 
 	/* System Management Registers. Might be hidden, in which case
@@ -6172,6 +6204,11 @@ static void __init check_tylersburg_isoch(void)
 	if (!pdev)
 		return;
 
+	if (risky_device(pdev)) {
+		pci_dev_put(pdev);
+		return;
+	}
+
 	if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
 		pci_dev_put(pdev);
 		return;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
