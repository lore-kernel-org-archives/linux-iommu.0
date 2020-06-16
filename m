Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D12C433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 01:17:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACFE2074D
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 01:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="K64yw4Ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACFE2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B549872CF;
	Tue, 16 Jun 2020 01:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5VInMyfmhb2H; Tue, 16 Jun 2020 01:17:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 29B7086A54;
	Tue, 16 Jun 2020 01:17:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1668BC0890;
	Tue, 16 Jun 2020 01:17:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09D41C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 01:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E931325A0F
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 01:17:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hcqEag+RPeuT for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 01:17:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by silver.osuosl.org (Postfix) with ESMTPS id 5BE1325A5E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 01:17:54 +0000 (UTC)
Received: by mail-qv1-f74.google.com with SMTP id ba13so14391442qvb.15
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 18:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=/xX6nZw43qnrS5POTejrGqQ7NU/q6i+TSuGWkPxARP8=;
 b=K64yw4UaVuSTB06zM70ynWO3Qe34OlpnWZDFtQx+XohI9pGel76JaZtLQSBoWSuTVn
 iUzYet0x27iuRTb1k2C8psq+ocK+eUc+lbqn/lM4DjoyK8Lwthh6he1ErlgUVUwd2DYt
 +Ye+ql9uWjMbbc98okBddDJZZSEPasbtsclPT6fSyzC2cMfQoctWhwgA1EprQkRAaKW3
 kZpng1WUzZbMtCYVB9VeNUn8PkNpzWWpfDFshQHOc4eQsm4yRF+loPV3Fp3xPvwnmEqr
 I9MkdliB1IiEzSTXoV4J1n+HUh2x8Vc310feGGYXQTOVnGd2k9zdRqFaiLC6Nf2wojul
 zk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=/xX6nZw43qnrS5POTejrGqQ7NU/q6i+TSuGWkPxARP8=;
 b=UIpBmmXF3oCXneRwezKpIMpkBuR9xQk7oS2TzlThvOGSLhhwlF4ek2/+hdDpYBsE0p
 +lc6kkf8EElPyckcpOQiq1lJ7RXgnGqKZT+3RXUoXsPdYBIl8Ygz7fefD+HFdlOaXy5Y
 ewAaGf/5UvzM435JalQ2Z3uiy46n93DwzK7NMWUxaTRG9wVzq55225rAVHPyrfkTU36t
 OXEqj02o6jlgQyuLr0GjWmO452V+0VVg5T8HKoQtgzcw7lb+++gkFw8+nkPt0dHM0wh7
 gRtcO1PUKVT5bVPExW2Tjg8pBmWPXkM6wUZOh+mX28KCmYeUi8k/OyGxMMXM3JDubZCr
 VX5w==
X-Gm-Message-State: AOAM531M2HDb5fKMVK+hSuBkHviEzc+alO1rFQ/W97hE6FW9wIKAuRbO
 +R1w/0rXlJPjKbWK2/LZcy4OB3ZwPaM3
X-Google-Smtp-Source: ABdhPJx/VShp5rkGDpPUGAg/FhXNCRybPGhdLZkWV0hxwM8Gk42L1iKKJC5+PkUN237Ww8vlTPH4HPEgQvLG
X-Received: by 2002:ad4:4374:: with SMTP id u20mr548678qvt.144.1592270273220; 
 Mon, 15 Jun 2020 18:17:53 -0700 (PDT)
Date: Mon, 15 Jun 2020 18:17:41 -0700
In-Reply-To: <20200616011742.138975-1-rajatja@google.com>
Message-Id: <20200616011742.138975-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 3/4] pci: acs: Enable PCI_ACS_TB for untrusted/external-facing
 devices
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oohall@gmail.com
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

When enabling ACS, currently the bit "translation blocking" was
not getting changed at all. Set it to disable translation blocking
too for all external facing or untrusted devices. This is OK
because ATS is only allowed on internal devces.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci.c    |  4 ++++
 drivers/pci/quirks.c | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d2ff987585855..79853b52658a2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3330,6 +3330,10 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	/* Upstream Forwarding */
 	ctrl |= (cap & PCI_ACS_UF);
 
+	if (dev->external_facing || dev->untrusted)
+		/* Translation Blocking */
+		ctrl |= (cap & PCI_ACS_TB);
+
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b341628e47527..6294adeac4049 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
 	}
 }
 
+/*
+ * Currently this quirk does the equivalent of
+ * PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV
+ *
+ * Currently missing, it also needs to do equivalent of PCI_ACS_TB,
+ * if dev->external_facing || dev->untrusted
+ */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
 	if (!pci_quirk_intel_pch_acs_match(dev))
@@ -4973,6 +4980,10 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
+	if (dev->external_facing || dev->untrusted)
+		/* Translation Blocking */
+		ctrl |= (cap & PCI_ACS_TB);
+
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
 
 	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
-- 
2.27.0.290.gba653c62da-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
