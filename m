Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD295C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 18:49:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448F52072F
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SOcja528"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448F52072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D7765227F8;
	Tue,  2 Jun 2020 18:49:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gSvwD1+Uv6QG; Tue,  2 Jun 2020 18:49:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3681A2278E;
	Tue,  2 Jun 2020 18:49:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2575EC0865;
	Tue,  2 Jun 2020 18:49:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11BE0C016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 18:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0D01787B60
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 18:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RTtqX4mlQk0z for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 18:49:28 +0000 (UTC)
X-Greylist: delayed 00:07:49 by SQLgrey-1.7.6
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5EFB887B5B
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 18:49:28 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id u6so18469953ybo.18
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=8tpv364uuoi5MEZfjTVmpI+b4taGRM4u8bQyj2pnBh4=;
 b=SOcja528ER/iTI2CrS98AHZhtT0sh74Df7GwIHRhAXIZCMLzeHsm+NOtlMuRMDQZ6x
 6hZOXLkrhV70Ou5JOEP+OHc6ERc0icCN6IKVYkf3ju6LMJls+zT1a/p24k8T0BLO109F
 k9kQU8UBno4rcsBxDFoMbosDTDLkmr+EJzJ3bta+cIFHwLy7avzrxODzrwf6AThuk0K7
 LNqiVoEm3tWJ3IoBuWitZFxHXHwY3bwx4JQlI80R2TieckjWrVF15cA+XaBP+DPnge+M
 0exYfssplAHJL0+eBQE0unWoxqw9ZMEtxQTS3qUZ9tLl1Xz/44i2Ef7PdMx+H9KbAzro
 2J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=8tpv364uuoi5MEZfjTVmpI+b4taGRM4u8bQyj2pnBh4=;
 b=PfM80ZBBEkq/81682UTsPdMv96nJTa3P7U9xmkQrTUnFkXkchAHYzI+kJ6zwC4pzay
 aFV5Nugj1BdSPoFtrFBRx7GwlzvgejthLn2JrrqmMxWNwxASfEQUyr3sj5n1eiAwtvLY
 bKZV4FaRNrT2k+eTTbmYiK2O8chjVG2HOvVvfUIzaHpIUKajZiCYeArfOo9DJDBHrg4L
 nFCltIGlUlJjB98TemypVYsf/w3pNekplBbDu+Xtw/pa2d6FKbicC7anvfczQi6/ynxY
 wofe2fcVkbwaYPNdFCGt+XlzERwkzDriyR+80maILgpbdDZ1eTesta5HtnNer12MTCyI
 whHg==
X-Gm-Message-State: AOAM530k8PBO+YuXIfsY1W8FHL5F8ZmswsPAYKmfXFpmb/iHuae0mR5X
 Yj6op58eoVrFSFuTrsRCs63XPIjsPUZz
X-Google-Smtp-Source: ABdhPJyhb8sVgjMH1V+zDqj3cCk0pEWzt3uIaVGtWHCpt+IVA/OQmIcUX6iRC8BXRiQLzMJHvueq2dHh2VLz
X-Received: by 2002:a5b:785:: with SMTP id b5mr21343779ybq.96.1591123297999;
 Tue, 02 Jun 2020 11:41:37 -0700 (PDT)
Date: Tue,  2 Jun 2020 11:41:33 -0700
Message-Id: <20200602184133.75525-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH v2] iommu/vt-d: Don't apply gfx quirks to untrusted devices
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
V2: - Change the warning print strings.
    - Add Lu Baolu's acknowledgement.

 drivers/iommu/intel-iommu.c | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e5..fdfbea4ff8cb3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -6214,6 +6214,13 @@ const struct iommu_ops intel_iommu_ops = {
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
 {
+	if (dev->untrusted) {
+		pci_warn(dev,
+			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
+			 __func__);
+		return;
+	}
+
 	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
@@ -6255,6 +6262,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
+	if (dev->untrusted) {
+		pci_warn(dev,
+			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
+			 __func__);
+		return;
+	}
+
 	/*
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
 	 * but needs it. Same seems to hold for the desktop versions.
@@ -6285,6 +6299,13 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 {
 	unsigned short ggc;
 
+	if (dev->untrusted) {
+		pci_warn(dev,
+			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
+			 __func__);
+		return;
+	}
+
 	if (pci_read_config_word(dev, GGC, &ggc))
 		return;
 
@@ -6318,6 +6339,15 @@ static void __init check_tylersburg_isoch(void)
 	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
 	if (!pdev)
 		return;
+
+	if (pdev->untrusted) {
+		pci_warn(pdev,
+			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
+			 __func__);
+		pci_dev_put(pdev);
+		return;
+	}
+
 	pci_dev_put(pdev);
 
 	/* System Management Registers. Might be hidden, in which case
@@ -6327,6 +6357,14 @@ static void __init check_tylersburg_isoch(void)
 	if (!pdev)
 		return;
 
+	if (pdev->untrusted) {
+		pci_warn(pdev,
+			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
+			 __func__);
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
