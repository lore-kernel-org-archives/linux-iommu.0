Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76544C433DF
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 09:57:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3604920679
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 09:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="g9X7wqQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3604920679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10AB086126;
	Tue,  2 Jun 2020 09:57:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sBi-fNp68MBD; Tue,  2 Jun 2020 09:57:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 65A3184AAB;
	Tue,  2 Jun 2020 09:57:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 419BFC0178;
	Tue,  2 Jun 2020 09:57:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACC9FC016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A86A4876AA
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wipq1gyQ7OnX for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 07:35:44 +0000 (UTC)
X-Greylist: delayed 01:50:21 by SQLgrey-1.7.6
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6D35F876A4
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:35:44 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id r18so15962720ybg.10
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 00:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=qiAGy0O4D5sZPZBUDOyzmafsREfPwQ+6o5+tiGkldzk=;
 b=g9X7wqQHkwSsE67PytiDLtUkVlKt2EmXQ0Z2WRZ0Xh3f9+7wmd6h5PI65oCiURIzef
 MvAXbSoNA7xpUP+3svirF5JhGDvXQZ1hGiTiID+6+4TXZMqd9HGHl42YU8KYdn1jlXX1
 FMt8vXzUeNYIsYo7VzJ9wNA04qeDpKks+ZwPzp1zSUn24ptdkw6dUktr1kvqHK1hj/Dh
 RbuIe+jX/KArQ5VsuwdkY5TYXdHBF42uQJwZ9RNePDGIoHfqlRknnDTaAHMFGPsBlaKN
 2MW4rywYhNxn+jhu9c2wfi6Jt/pIxSZxA7DPdJ0zojBygsgLVkYPzDrLC7UFgRFc/Tqb
 QJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=qiAGy0O4D5sZPZBUDOyzmafsREfPwQ+6o5+tiGkldzk=;
 b=toLSg1/oBib0IGJUliYotejwVV2P/qnNiuzMBqH3pbYsY6/JjxsJDarVQMwoV8s+Dd
 og5E4+OG6ZakjccIQMnMGD3wZ09ZxMlVHQIh+l7tAfvVXL/KuDMO1HHg1I3pTGXiV4D3
 cWLUyB86SX6Phj9+CEKDkY5Ra4C2LFmquVODKlgzEFfGB/nsoZAQONN4TlvPp2kWEpVY
 xN/VHhl+S9XtY529DqIAsGFbuRT+hoKEnc5I4nid5pe3fVPmfHLJKuP213s3mtrbwkkr
 zETDpQY943Isup3yMOj1r8i8PwwkRZO3ByGXL264LJur168TmpUWfK8bUM5AjprtuRio
 4dTg==
X-Gm-Message-State: AOAM533fmUWAPXn6Lahp63zyIztHS18CKWrkpQg4kZY4lCA+dhFkqBef
 aKkSMik2+vGsa3IOSzBDhE4Ps4JHo7px
X-Google-Smtp-Source: ABdhPJxQRom+GrIfagQbwRffGMeJJ+pGvfAJjE78cF4/2hejCZlko1O5W4bBRi7rlSUMctQMMaNTzCgul32z
X-Received: by 2002:a25:fc5:: with SMTP id 188mr39503234ybp.429.1591076722056; 
 Mon, 01 Jun 2020 22:45:22 -0700 (PDT)
Date: Mon,  1 Jun 2020 22:45:17 -0700
Message-Id: <20200602054517.191244-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] iommu/vt-d: Don't apply gfx quirks to untrusted devices
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@intel.com>, 
 Ashok Raj <ashok.raj@intel.com>, lalithambika.krishnakumar@intel.com
X-Mailman-Approved-At: Tue, 02 Jun 2020 09:57:14 +0000
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
---
 drivers/iommu/intel-iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e5..f2a480168a02f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -6214,6 +6214,11 @@ const struct iommu_ops intel_iommu_ops = {
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
 {
+	if (dev->untrusted) {
+		pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
+		return;
+	}
+
 	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
@@ -6255,6 +6260,11 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
+	if (dev->untrusted) {
+		pci_warn(dev, "skipping iommu quirk for untrusted dev\n");
+		return;
+	}
+
 	/*
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
 	 * but needs it. Same seems to hold for the desktop versions.
@@ -6285,6 +6295,11 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 {
 	unsigned short ggc;
 
+	if (dev->untrusted) {
+		pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
+		return;
+	}
+
 	if (pci_read_config_word(dev, GGC, &ggc))
 		return;
 
@@ -6318,6 +6333,13 @@ static void __init check_tylersburg_isoch(void)
 	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
 	if (!pdev)
 		return;
+
+	if (pdev->untrusted) {
+		pci_warn(pdev, "skipping iommu quirk due to untrusted dev\n");
+		pci_dev_put(pdev);
+		return;
+	}
+
 	pci_dev_put(pdev);
 
 	/* System Management Registers. Might be hidden, in which case
@@ -6327,6 +6349,12 @@ static void __init check_tylersburg_isoch(void)
 	if (!pdev)
 		return;
 
+	if (pdev->untrusted) {
+		pci_warn(pdev, "skipping iommu quirk due to untrusted dev\n");
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
