Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FAC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:49:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C2A2067D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bqRlWmWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C2A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 820A18823B;
	Tue, 30 Jun 2020 04:49:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NIk30rky5nZk; Tue, 30 Jun 2020 04:49:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCE398821F;
	Tue, 30 Jun 2020 04:49:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1BA0C0865;
	Tue, 30 Jun 2020 04:49:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E828C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3A4938823B
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sZP1-eAGLl8s for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 04:49:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6384F881EC
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:50 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id a205so10991167ybg.8
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 21:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=oOkAbwq8p407mhg423y3Mz2Wo+eujw0WSddpP6QvRRY=;
 b=bqRlWmWFtzvxjY/hGDN0smVXPSmteQpIkwImH3mOT3bpWT/83vg+H0LthEfYPvJ7eE
 OjdTm6vaUdar72o0GcothiKheZeLXY7WnbrCw32HNKpBzmrv29B/o2bQ5xh7ABw2gufw
 mlRStONhvk4aqg1Wm/SDCEf+n8a2VvRaHWDp+XYCGXqqJFsUmUv5De4SMEXzX3LQOcnS
 D8qqp/Jrqpg93hmyRNyrvvyrQ4WxAfasyRtrR5wmPtICzJKIVTmGGsQKT1Qj2krwqX/i
 CvmWUZtpw4xXae7d25HqX1Fgd92sxB0Vq0pPAGdHDqgQblCn1WJbVR8GQf9F3iapw932
 QFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=oOkAbwq8p407mhg423y3Mz2Wo+eujw0WSddpP6QvRRY=;
 b=oDHbZc6KA88qhcJZGuvjGQXslz6SXj/is5gbfN5DLa5sJmK+RRBaER4oWEA8k0WpXM
 ED6enqzievB7wuWTaeVdzLgucruIqd5HdUHjl61mEN14qPeek0lGqWpi38gb59zBNeFC
 YzVGLqO6HGluvIcGsrajvVACHVybulY56TM297HMDxaontOUJ/LuvCc5BuuJBSKsvAwM
 DHViTyIDXcYpx0zHOhKydxo1unvJWOAzunuoYAokf4SuCQz+f+r5gxv6sI1GmyqBAMCB
 nSPm3fLFXLipUtcnItbr7wZ2azTTgs10eB4yxvUREohK/VaA3ovtoZ9PK1HlWAHXflX3
 IJiA==
X-Gm-Message-State: AOAM531hgMUoZAcolIe0NtdxflN79LUrTCxHu1RxQEyTHfDNALpYINA5
 uCl73HQHO377VrOWWUD9mlMQA30ABiLH
X-Google-Smtp-Source: ABdhPJxhj935WeKux4i7rydgzCngHBXskKxNfygrruRg/KnQPX5IW/lx4g7i2XO9UTRgefom2yTqLzVuowMz
X-Received: by 2002:a25:408:: with SMTP id 8mr31144133ybe.500.1593492589407;
 Mon, 29 Jun 2020 21:49:49 -0700 (PDT)
Date: Mon, 29 Jun 2020 21:49:37 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-2-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 1/7] PCI: Keep the ACS capability offset in device
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

Currently this is being looked up at a number of places. Read and store it
once at bootup so that it can be used by all later.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Commit log cosmetic changes

 drivers/pci/p2pdma.c |  2 +-
 drivers/pci/pci.c    | 21 +++++++++++++++++----
 drivers/pci/pci.h    |  2 +-
 drivers/pci/probe.c  |  2 +-
 drivers/pci/quirks.c |  8 ++++----
 include/linux/pci.h  |  1 +
 6 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e8e444eeb1cd2..f29a48f8fa594 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -253,7 +253,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
 	int pos;
 	u16 ctrl;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ACS);
+	pos = pdev->acs_cap;
 	if (!pos)
 		return 0;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce096272f52b1..d2ff987585855 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -51,6 +51,7 @@ EXPORT_SYMBOL(pci_pci_problems);
 
 unsigned int pci_pm_d3_delay;
 
+static void pci_enable_acs(struct pci_dev *dev);
 static void pci_pme_list_scan(struct work_struct *work);
 
 static LIST_HEAD(pci_pme_list);
@@ -3284,7 +3285,7 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
 	if (!pci_dev_specific_disable_acs_redir(dev))
 		return;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
 	if (!pos) {
 		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
 		return;
@@ -3310,7 +3311,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	u16 cap;
 	u16 ctrl;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
 	if (!pos)
 		return;
 
@@ -3336,7 +3337,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
@@ -3362,7 +3363,7 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	int pos;
 	u16 cap, ctrl;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ACS);
+	pos = pdev->acs_cap;
 	if (!pos)
 		return false;
 
@@ -3487,6 +3488,18 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 	return true;
 }
 
+/**
+ * pci_acs_init - Initialize if hardware supports it
+ * @dev: the PCI device
+ */
+void pci_acs_init(struct pci_dev *dev)
+{
+	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+
+	if (dev->acs_cap)
+		pci_enable_acs(dev);
+}
+
 /**
  * pci_rebar_find_pos - find position of resize ctrl reg for BAR
  * @pdev: PCI device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f758671064..12fb79fbe29d3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -532,7 +532,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 	return resource_alignment(res);
 }
 
-void pci_enable_acs(struct pci_dev *dev);
+void pci_acs_init(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f66988cea257..6d87066a5ecc5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2390,7 +2390,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_ats_init(dev);		/* Address Translation Services */
 	pci_pri_init(dev);		/* Page Request Interface */
 	pci_pasid_init(dev);		/* Process Address Space ID */
-	pci_enable_acs(dev);		/* Enable ACS P2P upstream forwarding */
+	pci_acs_init(dev);		/* Access Control Services */
 	pci_ptm_init(dev);		/* Precision Time Measurement */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 812bfc32ecb82..b341628e47527 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4653,7 +4653,7 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
 	if (!pci_quirk_intel_spt_pch_acs_match(dev))
 		return -ENOTTY;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
 
@@ -4961,7 +4961,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	if (!pci_quirk_intel_spt_pch_acs_match(dev))
 		return -ENOTTY;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
 
@@ -4988,7 +4988,7 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
 	if (!pci_quirk_intel_spt_pch_acs_match(dev))
 		return -ENOTTY;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
 
@@ -5355,7 +5355,7 @@ int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *l, int timeout)
 	bool found;
 	struct pci_dev *bridge = bus->self;
 
-	pos = pci_find_ext_capability(bridge, PCI_EXT_CAP_ID_ACS);
+	pos = bridge->acs_cap;
 
 	/* Disable ACS SV before initial config reads */
 	if (pos) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c79d83304e529..a26be5332bba6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -486,6 +486,7 @@ struct pci_dev {
 #ifdef CONFIG_PCI_P2PDMA
 	struct pci_p2pdma *p2pdma;
 #endif
+	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	char		*driver_override; /* Driver name to force a match */
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
