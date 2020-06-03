Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5231AC433DF
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 13:25:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F069720679
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 13:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hyHgdnES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F069720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C557286101;
	Wed,  3 Jun 2020 13:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00VT-r-F_qfu; Wed,  3 Jun 2020 13:25:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3DB6860F9;
	Wed,  3 Jun 2020 13:25:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89BE4C0888;
	Wed,  3 Jun 2020 13:25:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24565C016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 13:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0CC87884DE
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 13:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rWuLPkaGSSqb for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 13:25:55 +0000 (UTC)
X-Greylist: delayed 00:22:33 by SQLgrey-1.7.6
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 36A68884C1
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 13:25:55 +0000 (UTC)
Received: by mail-qt1-f202.google.com with SMTP id y7so1813727qti.8
 for <iommu@lists.linux-foundation.org>; Wed, 03 Jun 2020 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=db/kQaLQg+0T8fOHQ2nb3EujmTQZxSTonth9y+N64Uw=;
 b=hyHgdnESty+it4dM91ZX8qfTsvjopVZuLx7NZhlI7ymz/gMbMzfiSUOuSk3et7Fc3r
 NYzkXQpApAIQ1KtveTHMUkeKsGl38ohGlyaccallRwA2bVzLUyG1D7jJKbXQRh6QhSPT
 ZOZ7kWh0lu1nCNO95TPKVAst4EcTrn7qYt7HVUYmkDRel57RDygHEncjvFtJxpOpPumP
 JxBaRZb/MyjsAYom7lKZeRdDenDUO7d3xtH5yJq5siM/Lv2HHCYXWJPohh49YGUoNWdr
 imMezI6+UFIRUDX8opuJ/H3qsniO6imliwxPP1svQIExziR6B1TVg+alavwOiuic9UHW
 8FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=db/kQaLQg+0T8fOHQ2nb3EujmTQZxSTonth9y+N64Uw=;
 b=ivxOcWCb0IO4ciHNWtJFgU4T2UB8CnIrHZpJsP4QB1EmLb97ejBJkV/yxHGegKajNH
 WXOR7cXpeVEGJUyEe0BX08sG1QHXRn5Ams5n7w763gjdOBDGEvcAGItYVC1sEjvXTnrs
 hc3ZXA1yzkCE2JmvCx1dHksrUgu5YSnCgQPLCI/BGPY928MViPxDbHOOrhDAg29hCYM0
 d/fwEsKy8gzAo073N1ivbbHsWDL3CgerNLpL0qAiRDd0g99Pa4fjGavPhrlC7ho+7B9W
 mQevMhWi6fDoN407gwFXYvYee4zjFaVePWRmwsYv0iw+oRa7OPTPjVI8V1gqiS1wULds
 kNow==
X-Gm-Message-State: AOAM532FwDy2eIJOhvf9gpi4uIhG4v4v51n8q83TnPMIMlDrcYPRHO71
 joI84cF0kRT1M9oagcpm2505pI6F73uc
X-Google-Smtp-Source: ABdhPJzCA2PDywVGKDjNV3Cc55Uhss57Yqby9p8/gWrwS/ZB5sXzZjsmUyQMBnxfrIOcPgZGdZ10I20m2iTW
X-Received: by 2002:ad4:4572:: with SMTP id o18mr30227802qvu.204.1591189400865; 
 Wed, 03 Jun 2020 06:03:20 -0700 (PDT)
Date: Wed,  3 Jun 2020 06:03:17 -0700
Message-Id: <20200603130317.94672-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH v4] iommu/vt-d: Don't apply gfx quirks to untrusted devices
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
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
v4: - Add Ashok Raj's "Reviewed-by"
    - Use pci_info() and split debug print cleanly into 2 statements. 
v3: - Separate out the warning mesage in a function to be called from
      other places. Change the warning string as suggested.
v2: - Change the warning print strings.
    - Add Lu Baolu's acknowledgement.

 drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e5..efd1e5de947b9 100644
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
