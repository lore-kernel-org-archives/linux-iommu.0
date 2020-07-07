Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE2AC433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 22:46:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E89C20775
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 22:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Gc/SRTnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E89C20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F18DC2271F;
	Tue,  7 Jul 2020 22:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFOkRWqZJQDR; Tue,  7 Jul 2020 22:46:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2EA6322170;
	Tue,  7 Jul 2020 22:46:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AC02C0893;
	Tue,  7 Jul 2020 22:46:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FB2BC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 22:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A70452276C
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 22:46:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yhL5IID3BAZv for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 22:46:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by silver.osuosl.org (Postfix) with ESMTPS id 0F93422170
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 22:46:14 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 124so16674277ybb.5
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jul 2020 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=n09L38FqLziZB80XiEEa4U3Rbl7E07buKJV52yFHq04=;
 b=Gc/SRTnIxUHoSJi+odkT9ED/cAZBziEF60Mve91fM9ATmPS3FGriWKvJORZEl5Z0i6
 Rt1q9Vj5DMEAtIDwvsa0svlN3MYRac1QJf+VBjUzkBJ22HvTQa8Now99YUMjCbAmUArG
 5X+9HsquJ7uXVe4Pxn4vmk60HOhkEddPfyOyNrHxPW1zHyAcQIwk3gp0EqwnVfa3GZY4
 q4JcOTH38ilJwF+ZrP6i0omqbEBDlm/Qojb6gfUCxgu5Ue6rglL1jV4JOPjCNpS+ODQj
 hyRyy82rMnXmypFgaIK9L3UolmGvLn5iAPdb1li5GfA7hM9hQC5Y3D/8RLFnLgvk5HSZ
 pO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=n09L38FqLziZB80XiEEa4U3Rbl7E07buKJV52yFHq04=;
 b=XH0IefX7cuTuVxHEHd/5gwqt+XKtJ4/XAeHqdTALBRuiofcPG9CFmgiuWeNp04T0eM
 6pisCwatBNVu8ebvMrF2CCA2Tv0nQsCV4JHnQzgbin0VGp41afOL+tyeI4L/AzGbw9cJ
 bViqEicZSnk9GJmX9g5WXnaGvSxlEo1UHqxcfk5b53SB/+Xd9VwkeTFNurWZzw/b3KUA
 ucZTvAtQEsAyyC+NZkHL45JdjJbeRqOrNp8WVViAqzCtrZHFXFtfH8TxU/+gn1ipS68g
 fLqPnDlcRTizYRsC8RJb5knDaW6Uxs3Ipl+kYRMUmrCGV/WTL9xOi2UQb2lEnBogHpMG
 6xyA==
X-Gm-Message-State: AOAM532ESxE0SJQQLyu2hmt3ceHIoCcKHc+hoo4Oc1QHCoHkYw4fdxqi
 ijolU2j5H6+8s7x5i/3olkgsx/smvUWL
X-Google-Smtp-Source: ABdhPJyqUZg0SfkVxfU/L4DX91czSrlqUnkerJoAkpXyDw0tpSP0A/Ld1JaoBY9wWt59l+/b2cp9XcCWy7MR
X-Received: by 2002:a25:8007:: with SMTP id m7mr31698114ybk.60.1594161972909; 
 Tue, 07 Jul 2020 15:46:12 -0700 (PDT)
Date: Tue,  7 Jul 2020 15:46:04 -0700
In-Reply-To: <20200707224604.3737893-1-rajatja@google.com>
Message-Id: <20200707224604.3737893-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200707224604.3737893-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>, 
 lalithambika.krishnakumar@intel.com, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Prashant Malani <pmalani@google.com>, 
 Benson Leung <bleung@google.com>, Todd Broch <tbroch@google.com>,
 Alex Levin <levinale@google.com>, 
 Mattias Nissler <mnissler@google.com>, Rajat Jain <rajatxjain@gmail.com>, 
 Bernie Keany <bernie.keany@intel.com>, Aaron Durbin <adurbin@google.com>, 
 Diego Rivas <diegorivas@google.com>, Duncan Laurie <dlaurie@google.com>, 
 Furquan Shaikh <furquan@google.com>, Jesse Barnes <jsbarnes@google.com>, 
 Christian Kellner <christian@kellner.me>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oohall@gmail.com, 
 Saravana Kannan <saravanak@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rajat Jain <rajatja@google.com>
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

When enabling ACS, enable translation blocking for external facing ports
and untrusted devices.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v4: Add braces to avoid warning from kernel robot
    print warning for only external-facing devices.
v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
    Minor code comments fixes.
v2: Commit log change

 drivers/pci/pci.c    |  8 ++++++++
 drivers/pci/quirks.c | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 73a8627822140..a5a6bea7af7ce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	/* Upstream Forwarding */
 	ctrl |= (cap & PCI_ACS_UF);
 
+	/* Enable Translation Blocking for external devices */
+	if (dev->external_facing || dev->untrusted) {
+		if (cap & PCI_ACS_TB)
+			ctrl |= PCI_ACS_TB;
+		else if (dev->external_facing)
+			pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
+	}
+
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b341628e47527..bb22b46c1d719 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
 	}
 }
 
+/*
+ * Currently this quirk does the equivalent of
+ * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
+ *
+ * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
+ * if dev->external_facing || dev->untrusted
+ */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
 	if (!pci_quirk_intel_pch_acs_match(dev))
@@ -4973,6 +4980,14 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
+	/* Enable Translation Blocking for external devices */
+	if (dev->external_facing || dev->untrusted) {
+		if (cap & PCI_ACS_TB)
+			ctrl |= PCI_ACS_TB;
+		else if (dev->external_facing)
+			pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
+	}
+
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
 
 	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
