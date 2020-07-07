Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E903C433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 06:43:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EA920578
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 06:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Xre+DO5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EA920578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B554B8675F;
	Tue,  7 Jul 2020 06:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RtJ3aEf1hpZ7; Tue,  7 Jul 2020 06:43:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EE2CD86429;
	Tue,  7 Jul 2020 06:43:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3F60C0891;
	Tue,  7 Jul 2020 06:43:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93B6AC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7965B254B3
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:43:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E2zw0JQy5tyj for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 06:43:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by silver.osuosl.org (Postfix) with ESMTPS id BED1925432
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:43:39 +0000 (UTC)
Received: by mail-pf1-f201.google.com with SMTP id s24so6974942pfe.9
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Qk/CudVh/aYmFA4VGFCO8mdbAWkl57VHCd1ZIJWN+1w=;
 b=Xre+DO5bBquqMu+hdF9c3GWOfwJPU0JSYZ82fhlA0HFoIo0LganFlMRGd90xICWjvh
 x6VqENjaJX+E6NmE7NvnAmKue5CkshpdqCfHOJDdbjwtbGNakh6+Y2o2MCQzOFHd8mWB
 Tx6gwJgY9b5m33RdN7MXjvEI7lNExtH3p/MO6RXgh/of/7qxV2dhNwE5Ya8bmsH5mhBC
 KVvnUlfyjdwVqd5LHb1/V/h1A+eW5DYc5Y2+BZt27U5BtA20FnqlrWGeEQKgYsXSbbew
 xusxlAqAeT++ykRLTsGvPyIrcRpvzT4IW00uhXW1Wj6u8ayVQwdQHaPEUuR7QMoK/PRD
 25lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Qk/CudVh/aYmFA4VGFCO8mdbAWkl57VHCd1ZIJWN+1w=;
 b=ZSKusKJjBpG9PTd/QEZjS+7qGX1VJGWAqXS8y62jwR3i7heqU9VSWQbwHYvRc2MFK8
 2TLIZeRAJzvFyWejPR8Bu4nzoUqQyOexrrk1zWEVZHdAH27hl6xSLu2YeZ1cuta5i2AF
 kRSmKWxtR67spdytg0abOhpT25xA42y/1jqwB2Vey0yQMg6cKqHq5ckfv/lMm9zlW/QK
 QH1ZHz8QFRHUhsuwaCboJKoqZFy2wM73/v+NoazviGkuBsu1YMWMkV6mGxRpamFNjb7O
 6SAVBa77ueBNlp6dHc2+yh02SIYM+fvTjPfDYyhQcE1fu9ZwrV70pnnn9rz0Sa/bsfjY
 vJnA==
X-Gm-Message-State: AOAM531Ccwut99bJ9hYPoaewlNMimkDLlbL0hKdLKEyGemNwUb1U4RyC
 l1oe53qLX32sWheGk+bN0RWKdix4ADos
X-Google-Smtp-Source: ABdhPJxwPXvnk3sNJWoQC6YwOTWi9tymhjLuGByDfNWQcfhaj8ZWG0wbKLQWCrNYPqv0Xn0Z4pBVaY07uBDo
X-Received: by 2002:a0c:aed6:: with SMTP id n22mr50763155qvd.70.1594097669245; 
 Mon, 06 Jul 2020 21:54:29 -0700 (PDT)
Date: Mon,  6 Jul 2020 21:54:18 -0700
In-Reply-To: <20200707045418.3517076-1-rajatja@google.com>
Message-Id: <20200707045418.3517076-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200707045418.3517076-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3 4/4] PCI/ACS: Enable PCI_ACS_TB for
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
v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
    Minor code comments fixes.
v2: Commit log change

 drivers/pci/pci.c    |  7 +++++++
 drivers/pci/quirks.c | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 73a8627822140..497ac05bf36e8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -876,6 +876,13 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	/* Upstream Forwarding */
 	ctrl |= (cap & PCI_ACS_UF);
 
+	/* Enable Translation Blocking for external devices */
+	if (dev->external_facing || dev->untrusted)
+		if (cap & PCI_ACS_TB)
+			ctrl |= PCI_ACS_TB;
+		else
+			pci_warn(dev, "ACS: No Trans Blocking on ext dev\n");
+
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b341628e47527..9cc8c1dc215ee 100644
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
@@ -4973,6 +4980,13 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
+	/* Enable Translation Blocking for external devices */
+	if (dev->external_facing || dev->untrusted)
+		if (cap & PCI_ACS_TB)
+			ctrl |= PCI_ACS_TB;
+		else
+			pci_warn(dev, "ACS: No Trans Blocking on ext dev\n");
+
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
 
 	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
