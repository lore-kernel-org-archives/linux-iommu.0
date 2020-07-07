Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5CCC433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 04:54:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6661F20772
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 04:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KBMF4A+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6661F20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ED251893C5;
	Tue,  7 Jul 2020 04:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aluIL+JzFN5z; Tue,  7 Jul 2020 04:54:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AA025893AB;
	Tue,  7 Jul 2020 04:54:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85C7DC0891;
	Tue,  7 Jul 2020 04:54:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5A6FC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 04:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BB1B387A72
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 04:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7gZmcJ4VeAFK for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 04:54:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B8E4187A2F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 04:54:23 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id z7so45638342ybz.1
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 21:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=YqakijUY5rIqvNKdnSiWGTqS4puVI9fRR5ao3T7q6kk=;
 b=KBMF4A+i7aqyRaI16URtKpzgstGFjLUGMtU/fI2t/3PnWHUOxJwC6/yV6tgEW3QQtO
 cWVfaF+8LV9SNEVBIFwBG0aK7b4FhlC8C6lkmgxLbfQq0qMnEuLNt2ucDPfWoRdJy5vr
 EqUGYLyT2IAaaz+BZ/AiJXj+O9Qw6rF16+WRqrKBmBJOAv9VpLkFK2F//debvd7fHFdZ
 EBljpGxDJHm9Ge1hLpDSSEWkGF5i4G8JlPNvMTwz3LOpYhR6iKCTdAvSybBFrClwRJiL
 i8O3yIbnpZBDjy1RZ9uccvq/sNnY2qeoHh95Iqi6NqvjgA6AsQbi07Bh07VESfOXFfib
 J2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=YqakijUY5rIqvNKdnSiWGTqS4puVI9fRR5ao3T7q6kk=;
 b=BUY8dJk6Dmg1/3g97Spo9mZa7cvl2fm8EyD3HJ1RBfNTHKii+amMMnDRa9B08omZ++
 P3jvYDhCjl70UnW0Oo3buFIBj8hkiK5kgNQWVIImKnkbsqDhTAe8jsXolZt6HOCN0YkU
 b4O2TsKX5tEoPyMhBdJ19dTsSbDuUmKvkTqLYBKXjYNU9P9xu4eb35uTh5X19b4lc+3J
 wZJJe/5F5oyXZOREc1HUNQn3Vpe6ypuewALxWnbGD7+11PdRWaSrejyupozcBfxScmtB
 J/SJF+B3oGLq2KR5V5nK1OPfdAriwFEGEn1SzVWl7BoJNqUoo2MxZHjdUTWN4qIt3K0n
 3oCw==
X-Gm-Message-State: AOAM533iphpcHThnaxE1P2wVFx4VEUIdtyZZZmW8P5/EEBVuByl0oAe3
 qlGcRuvqEWsv0fTAHodxUvbxmiSH86m+
X-Google-Smtp-Source: ABdhPJyEx3XEjmvcNkVjkEo25R0Rd4DvXNjVbvc5TnR6H1xwKbEM81YAwlVCEq5RqELxqf8tzNeR6hiifVoy
X-Received: by 2002:a25:b19e:: with SMTP id h30mr88732285ybj.70.1594097662656; 
 Mon, 06 Jul 2020 21:54:22 -0700 (PDT)
Date: Mon,  6 Jul 2020 21:54:15 -0700
Message-Id: <20200707045418.3517076-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3 1/4] PCI: Move pci_enable_acs() and its dependencies up in
 pci.c
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

Move pci_enable_acs() and the functions it depends on, further up in the
source code to avoid having to forward declare it when we make it static
in near future (next patch).

No functional changes intended.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: Initial version of the patch, created per Bjorn's suggestion

 drivers/pci/pci.c | 254 +++++++++++++++++++++++-----------------------
 1 file changed, 127 insertions(+), 127 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce096272f52b1..eec625f0e594e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -777,6 +777,133 @@ int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask)
 	return 0;
 }
 
+static int pci_acs_enable;
+
+/**
+ * pci_request_acs - ask for ACS to be enabled if supported
+ */
+void pci_request_acs(void)
+{
+	pci_acs_enable = 1;
+}
+
+static const char *disable_acs_redir_param;
+
+/**
+ * pci_disable_acs_redir - disable ACS redirect capabilities
+ * @dev: the PCI device
+ *
+ * For only devices specified in the disable_acs_redir parameter.
+ */
+static void pci_disable_acs_redir(struct pci_dev *dev)
+{
+	int ret = 0;
+	const char *p;
+	int pos;
+	u16 ctrl;
+
+	if (!disable_acs_redir_param)
+		return;
+
+	p = disable_acs_redir_param;
+	while (*p) {
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret < 0) {
+			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
+				     disable_acs_redir_param);
+
+			break;
+		} else if (ret == 1) {
+			/* Found a match */
+			break;
+		}
+
+		if (*p != ';' && *p != ',') {
+			/* End of param or invalid format */
+			break;
+		}
+		p++;
+	}
+
+	if (ret != 1)
+		return;
+
+	if (!pci_dev_specific_disable_acs_redir(dev))
+		return;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos) {
+		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
+		return;
+	}
+
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+
+	/* P2P Request & Completion Redirect */
+	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+
+	pci_info(dev, "disabled ACS redirect\n");
+}
+
+/**
+ * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
+ * @dev: the PCI device
+ */
+static void pci_std_enable_acs(struct pci_dev *dev)
+{
+	int pos;
+	u16 cap;
+	u16 ctrl;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+
+	/* Source Validation */
+	ctrl |= (cap & PCI_ACS_SV);
+
+	/* P2P Request Redirect */
+	ctrl |= (cap & PCI_ACS_RR);
+
+	/* P2P Completion Redirect */
+	ctrl |= (cap & PCI_ACS_CR);
+
+	/* Upstream Forwarding */
+	ctrl |= (cap & PCI_ACS_UF);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+}
+
+/**
+ * pci_enable_acs - enable ACS if hardware support it
+ * @dev: the PCI device
+ */
+void pci_enable_acs(struct pci_dev *dev)
+{
+	if (!pci_acs_enable)
+		goto disable_acs_redir;
+
+	if (!pci_dev_specific_enable_acs(dev))
+		goto disable_acs_redir;
+
+	pci_std_enable_acs(dev);
+
+disable_acs_redir:
+	/*
+	 * Note: pci_disable_acs_redir() must be called even if ACS was not
+	 * enabled by the kernel because it may have been enabled by
+	 * platform firmware.  So if we are told to disable it, we should
+	 * always disable it after setting the kernel's default
+	 * preferences.
+	 */
+	pci_disable_acs_redir(dev);
+}
+
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
@@ -3230,133 +3357,6 @@ void pci_configure_ari(struct pci_dev *dev)
 	}
 }
 
-static int pci_acs_enable;
-
-/**
- * pci_request_acs - ask for ACS to be enabled if supported
- */
-void pci_request_acs(void)
-{
-	pci_acs_enable = 1;
-}
-
-static const char *disable_acs_redir_param;
-
-/**
- * pci_disable_acs_redir - disable ACS redirect capabilities
- * @dev: the PCI device
- *
- * For only devices specified in the disable_acs_redir parameter.
- */
-static void pci_disable_acs_redir(struct pci_dev *dev)
-{
-	int ret = 0;
-	const char *p;
-	int pos;
-	u16 ctrl;
-
-	if (!disable_acs_redir_param)
-		return;
-
-	p = disable_acs_redir_param;
-	while (*p) {
-		ret = pci_dev_str_match(dev, p, &p);
-		if (ret < 0) {
-			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
-				     disable_acs_redir_param);
-
-			break;
-		} else if (ret == 1) {
-			/* Found a match */
-			break;
-		}
-
-		if (*p != ';' && *p != ',') {
-			/* End of param or invalid format */
-			break;
-		}
-		p++;
-	}
-
-	if (ret != 1)
-		return;
-
-	if (!pci_dev_specific_disable_acs_redir(dev))
-		return;
-
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
-	if (!pos) {
-		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
-		return;
-	}
-
-	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
-
-	/* P2P Request & Completion Redirect */
-	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
-
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
-
-	pci_info(dev, "disabled ACS redirect\n");
-}
-
-/**
- * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
- * @dev: the PCI device
- */
-static void pci_std_enable_acs(struct pci_dev *dev)
-{
-	int pos;
-	u16 cap;
-	u16 ctrl;
-
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
-	if (!pos)
-		return;
-
-	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
-	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
-
-	/* Source Validation */
-	ctrl |= (cap & PCI_ACS_SV);
-
-	/* P2P Request Redirect */
-	ctrl |= (cap & PCI_ACS_RR);
-
-	/* P2P Completion Redirect */
-	ctrl |= (cap & PCI_ACS_CR);
-
-	/* Upstream Forwarding */
-	ctrl |= (cap & PCI_ACS_UF);
-
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
-}
-
-/**
- * pci_enable_acs - enable ACS if hardware support it
- * @dev: the PCI device
- */
-void pci_enable_acs(struct pci_dev *dev)
-{
-	if (!pci_acs_enable)
-		goto disable_acs_redir;
-
-	if (!pci_dev_specific_enable_acs(dev))
-		goto disable_acs_redir;
-
-	pci_std_enable_acs(dev);
-
-disable_acs_redir:
-	/*
-	 * Note: pci_disable_acs_redir() must be called even if ACS was not
-	 * enabled by the kernel because it may have been enabled by
-	 * platform firmware.  So if we are told to disable it, we should
-	 * always disable it after setting the kernel's default
-	 * preferences.
-	 */
-	pci_disable_acs_redir(dev);
-}
-
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	int pos;
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
