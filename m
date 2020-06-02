Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC646C433E1
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 23:26:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D7B2067B
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 23:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LWFlQGg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D7B2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F3A986745;
	Tue,  2 Jun 2020 23:26:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SQ7wKGxZNgZd; Tue,  2 Jun 2020 23:26:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 88CEC86457;
	Tue,  2 Jun 2020 23:26:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CD23C0178;
	Tue,  2 Jun 2020 23:26:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DCFDC016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4207520033
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WOBc8p3S12gg for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 23:26:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by silver.osuosl.org (Postfix) with ESMTPS id 390712034D
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:26:07 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id t4so410548yba.12
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=NynG8XTmY06ZJBNFnLG4IHgPIRP64YxzgsMAMDjv2W8=;
 b=LWFlQGg6pL6oyAUYXPL9fpD43ADEegVgD8UlcvNOPsLJJDFXrNrNrmGLKqEKIHpEsR
 RNz9nTGMOc3LBWWiobW+3ns/Ttc4Ky71CnxJwaTq+BuKaGOQh6qttsS3jU30DQ792d4T
 YBFt2VAsxMg9b821uHv6Boc5xHmfdEhbXh4wAVmaHtqQLEg+z0ZED9spNAyyP6sy/iV+
 cVbLTPCsF+Y1NCt+Ka2VOdvfrAdfS2WkTx5h4V1pB/4iSkqpZ4HzUnoXjFJCmDArbCN3
 ikG2DMBXAnlbno20z7uC/RkNndIRmZuqP+QjMCaM3q5a4qyYf19GJmvvi0tTzk2zvi2y
 b7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=NynG8XTmY06ZJBNFnLG4IHgPIRP64YxzgsMAMDjv2W8=;
 b=Fz0IR/1NBvMK+lGUDiqONpgZ7rKXTYWy7hMYQmBVU4zayeIsoj0BkwcoI52oIuvjxU
 U79qCweKOYtCr2d5KVSy1Jf1zlgr++bP/ri2TEt6Oo9YJ3Z7LMIgLSbqrpPA3fVmQdyz
 bL5dZkNxQ1ktQ9lR9D2RNvbTc5JwNNQR+ful7kBnv5tbH0BL2IZbVu912KLs4+TZjkc4
 CGBdI9+yW/WuJ2+U/LRs3Ao5PovDfR75g6ZHr56Y//JCl3pb+ZPsXLagSaHWCHGKQ0gP
 X401I3AiDqyyAU3cfJzMcijRcXHPYnHoCJZmDE6j8zkv/NzTPxiJRVy9nDn4OwSoyOu8
 hVbQ==
X-Gm-Message-State: AOAM531ocV/SnBhal+i6Wovp3GmMeTA+sAZnnmmjHgPAOAy+AUfv1S1o
 R4EqY9iXrKklFTrEClWjutqrnPQvZDuB
X-Google-Smtp-Source: ABdhPJy7StIRmqY8PtQKaVBItShwpG3VOObe8CYIJhXNAvjpzjPuiuVIy8eYCXkZ+LuoN7XKfnI74pyyRrTh
X-Received: by 2002:a25:258f:: with SMTP id
 l137mr37546571ybl.221.1591140366131; 
 Tue, 02 Jun 2020 16:26:06 -0700 (PDT)
Date: Tue,  2 Jun 2020 16:26:02 -0700
Message-Id: <20200602232602.156049-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted devices
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@intel.com>, 
 Ashok Raj <ashok.raj@intel.com>, lalithambika.krishnakumar@intel.com
Cc: tbroch@google.com, rajatxjain@gmail.com, pmalani@google.com,
 mnissler@google.com, bleung@google.com, Rajat Jain <rajatja@google.com>,
 zsm@google.com, levinale@google.com
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Currently, an external malicious PCI device can masquerade the VID:PID
of faulty gfx devices, and thus apply iommu quirks to effectively
disable the IOMMU restrictions for itself.

Thus we need to ensure that the device we are applying quirks to, is
indeed an internal trusted device.

Signed-off-by: Rajat Jain <rajatja@google.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
---
v3: - Separate out the warning mesage in a function to be called from
      other places. Change the warning string as suggested.
v2: - Change the warning print strings.
    - Add Lu Baolu's acknowledgement.

 drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e5..dc859f02985a0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -6185,6 +6185,23 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
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
+		pci_warn(pdev,
+			 "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
+			 " PCI link. Please check with your BIOS/Platform"
+			 " vendor about this\n", pdev->vendor, pdev->device);
+		return true;
+	}
+	return false;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -6214,6 +6231,9 @@ const struct iommu_ops intel_iommu_ops = {
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
 {
+	if (risky_device(dev))
+		return;
+
 	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
@@ -6255,6 +6275,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
+	if (risky_device(dev))
+		return;
+
 	/*
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
 	 * but needs it. Same seems to hold for the desktop versions.
@@ -6285,6 +6308,9 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 {
 	unsigned short ggc;
 
+	if (risky_device(dev))
+		return;
+
 	if (pci_read_config_word(dev, GGC, &ggc))
 		return;
 
@@ -6318,6 +6344,12 @@ static void __init check_tylersburg_isoch(void)
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
@@ -6327,6 +6359,11 @@ static void __init check_tylersburg_isoch(void)
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
2.27.0.rc2.251.g90737beb825-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
