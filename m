Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007A4C433E1
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:49:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32892067D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Fzmn3zBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32892067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3C9288268;
	Tue, 30 Jun 2020 04:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xw1TynrJgYoC; Tue, 30 Jun 2020 04:49:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B46F88256;
	Tue, 30 Jun 2020 04:49:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1685DC08A0;
	Tue, 30 Jun 2020 04:49:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B787C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1A3E387AB1
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pTSKxpAslZeu for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 04:49:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7980D87A1A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:54 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 13so6928271ybx.9
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 21:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=1GSrptB51Ebugg9FWmWRPrlpTSANe16GXZRwAajHZjI=;
 b=Fzmn3zBwkz61BImTOmDr+UTqOyqjePTXGkh2hh+S9U5oUAWTEewVvXE0uQnsPICARw
 I99XjUw5d2rDoIZdnlsNGHrUCAmkOxGbNHRwaHrLSQ93afd5NQ2O9b8bt/QFN+kmOqz8
 6b/2D1Px6vY61wmL7bbf75lz0DLo7RzK8C2ue6JEr9B6rGRMQj4D5lsoIRC4digE15t2
 Jq+U37h/FBmiVefuqrmdLQ6Ozp1XMDCz2/MkwVnK2u1QRTAvChjhJ0ETbjj6l2hlq6bC
 OCCFlluLgpNQH2STAKDJat5EyiTzGw1QCtWN/NrA7MNM/GfXkk71b9IypHvuQw2C32pP
 Gf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=1GSrptB51Ebugg9FWmWRPrlpTSANe16GXZRwAajHZjI=;
 b=iXueg6NJLKRVN25eJHJ7Uw6kEVL8/jaiBnF0zbGqLca5QrEh+BPSFuaIzQiJ3duZ7f
 vOxQkqOvE8jMmcpICm9CF+Bj6dKlGqII46ZGx+4CpprX0IZiJDp2vF1uSNomgP/pInCB
 4AmDcMDFkqD9dpEgtBlp5a3hbiHIyQExsiLCpQHrxPRYS+UF3Dt73Jk184RWwV6weC7p
 vLu3dnJyDKc+yg79keGk3r3//0FFWsFGaoVlKalGMCVpVk5VcD95Y4xF+ahH+6b3okOU
 dAwIq+5xXOTA4tBBvQCv/nyVxerlMt9WNom+lteMqwbhUbYi7KdXd9nvJ/dbYUVZJu5P
 t9mA==
X-Gm-Message-State: AOAM533ns92rOousnvHEE8on7//SGJgTaCx8Dz72aKG6msq/tWmOiGoR
 wrB+VCZUPiXz9rXU3ivjvn68u2GWdd8H
X-Google-Smtp-Source: ABdhPJyKXLRBH4F1knixflHShhi5F9yyQyirad1BSVGvjyy37E1ndR68pL34aiL8DZ68wClo3Fdo0aLLE7OB
X-Received: by 2002:a25:c442:: with SMTP id u63mr8382527ybf.92.1593492593590; 
 Mon, 29 Jun 2020 21:49:53 -0700 (PDT)
Date: Mon, 29 Jun 2020 21:49:39 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 3/7] PCI/ACS: Enable PCI_ACS_TB for
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
v2: Commit log change 

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
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
