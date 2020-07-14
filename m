Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07220C433DF
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 22:16:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B381F20658
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 22:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="S2GVzOkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B381F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F0A520531;
	Tue, 14 Jul 2020 22:15:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gq3INkV6a7JI; Tue, 14 Jul 2020 22:15:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F34F32049B;
	Tue, 14 Jul 2020 22:15:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C04D2C0888;
	Tue, 14 Jul 2020 22:15:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5EF4C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 22:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A11F2876DB
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 22:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v-L9kpgPvZ8S for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 22:15:55 +0000 (UTC)
X-Greylist: delayed 01:31:19 by SQLgrey-1.7.6
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com
 [209.85.222.74])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 87F8B876D7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 22:15:55 +0000 (UTC)
Received: by mail-ua1-f74.google.com with SMTP id l10so1092uap.11
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=k8sSMgjK9I2PUQMRw/GWlcNooM3tXXrf+Vhg/OAtdZg=;
 b=S2GVzOkC2LGtGQ21lvarvs9uv1aEUX8YsRU1aoZZE1+59iLM2WChsBBWqbtUFhGnJe
 skhA4nhLC0cZjFmHedgRpWJ8wAylwTiRzy+nHZhHXZ/peY/4t9Xl3GBqVAP+GSCQzQy7
 t4SArJ5g3XVdGGf+YJRvi+guvQvZ8t/kdE51J8xOXGnfDo1T39uO7pZ61cNd3lKHoaMS
 Qv21vzUYEzSrpAqdw9M8gY2KT081z/v6EXry5P+MISlDEa/l2DkucnwJbMHP/PEX/Dmi
 ivGV0gqVCM763+8JJTAx738FPM++fQKoL94CzaZ8bYMCm4OpFCkiVFkJ5XiQ9yFOv5+v
 2Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=k8sSMgjK9I2PUQMRw/GWlcNooM3tXXrf+Vhg/OAtdZg=;
 b=SjaBsoWVkRY3IUbGLW4EPvL7IVxEU3Cs1fpwGFFivY6YTD7dEG23z6BLbGVRYHBFU2
 ig2Hsu3uT7Hx7p6kqJU98Gsks1MoWcXgKmqW3VbEk5Ndl7p2i35bmgB3qJz9hnZRKenM
 yzbVZ+9cd6keKI8+atqDeIsRWWgV+at3ZAyfBJ2OuAi+fa8KjHdQfEYXmrAWS2jrXIVm
 3YFLK/Nn37foN4qumQrnImOIMyPZuJLAG9TQrSOOPUcSOC+ohbFu89Ey8SKDAB/iBkac
 43GmLMU5VSw86Zb4LiUZxy/GYV4mtJpbtquBmylkHV1E58JjYQOoSzvxX8x+eQ04vpHO
 Vpag==
X-Gm-Message-State: AOAM533E/FEInIzFaZ770sLd1WqcFt728BrZjud6CL5qQYqHSHbXXH0V
 gvFrCKzqripGGfGIvL8a3n2UjSfBeerd
X-Google-Smtp-Source: ABdhPJwHlifHg+spec7YOdMDJm+3uxVhSlu5bZvFHXamqwQeKt8gqiqlfnbxbsk5PbdhuRmTp8ZcTz1dt5uu
X-Received: by 2002:a0c:b2d1:: with SMTP id d17mr6537991qvf.100.1594757743926; 
 Tue, 14 Jul 2020 13:15:43 -0700 (PDT)
Date: Tue, 14 Jul 2020 13:15:40 -0700
Message-Id: <20200714201540.3139140-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH v5] PCI/ACS: Enable PCI_ACS_TB and disable only when needed
 for ATS
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

The ACS "Translation Blocking" bit blocks the translated addresses from
the devices. We don't expect such traffic from devices unless ATS is
enabled on them. A device sending such traffic without ATS enabled,
indicates malicious intent, and thus should be blocked.

Enable PCI_ACS_TB by default for all devices, and it stays enabled until
atleast one of the devices downstream wants to enable ATS. It gets
disabled to enable ATS on a device downstream it, and then gets enabled
back on once all the downstream devices don't need ATS.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
Note that I'm ignoring the devices that require quirks to enable or
disable ACS, instead of using the standard way for ACS configuration.
The reason is that it would require adding yet another quirk table or
quirk function pointer, that I don't know how to implement for those
devices, and will neither have the devices to test that code.

v5: Enable TB and disable ATS for all devices on boot. Disable TB later
    only if needed to enable ATS on downstream devices.
v4: Add braces to avoid warning from kernel robot
    print warning for only external-facing devices.
v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
    Minor code comments fixes.
v2: Commit log change

 drivers/pci/ats.c   |  5 ++++
 drivers/pci/pci.c   | 57 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h   |  2 ++
 drivers/pci/probe.c |  2 +-
 include/linux/pci.h |  2 ++
 5 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index b761c1f72f67..e2ea9083f30f 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -28,6 +28,9 @@ void pci_ats_init(struct pci_dev *dev)
 		return;
 
 	dev->ats_cap = pos;
+
+	dev->ats_enabled = 1; /* To avoid WARN_ON from pci_disable_ats() */
+	pci_disable_ats(dev);
 }
 
 /**
@@ -82,6 +85,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	}
 	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
 
+	pci_disable_acs_trans_blocking(dev);
 	dev->ats_enabled = 1;
 	return 0;
 }
@@ -102,6 +106,7 @@ void pci_disable_ats(struct pci_dev *dev)
 	ctrl &= ~PCI_ATS_CTRL_ENABLE;
 	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
 
+	pci_enable_acs_trans_blocking(dev);
 	dev->ats_enabled = 0;
 }
 EXPORT_SYMBOL_GPL(pci_disable_ats);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 73a862782214..614e3c1e8c56 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -876,6 +876,9 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	/* Upstream Forwarding */
 	ctrl |= (cap & PCI_ACS_UF);
 
+	/* Translation Blocking */
+	ctrl |= (cap & PCI_ACS_TB);
+
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
 }
 
@@ -904,6 +907,60 @@ static void pci_enable_acs(struct pci_dev *dev)
 	pci_disable_acs_redir(dev);
 }
 
+void pci_disable_acs_trans_blocking(struct pci_dev *pdev)
+{
+	u16 cap, ctrl, pos;
+	struct pci_dev *dev;
+
+	if (!pci_acs_enable)
+		return;
+
+	for (dev = pdev; dev; dev = pci_upstream_bridge(pdev)) {
+
+		pos = dev->acs_cap;
+		if (!pos)
+			continue;
+
+		/*
+		 * Disable translation blocking when first downstream
+		 * device that needs it (for ATS) wants to enable ATS
+		 */
+		if (++dev->ats_dependencies == 1) {
+			pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
+			pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+			ctrl &= ~(cap & PCI_ACS_TB);
+			pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+		}
+	}
+}
+
+void pci_enable_acs_trans_blocking(struct pci_dev *pdev)
+{
+	u16 cap, ctrl, pos;
+	struct pci_dev *dev;
+
+	if (!pci_acs_enable)
+		return;
+
+	for (dev = pdev; dev; dev = pci_upstream_bridge(pdev)) {
+
+		pos = dev->acs_cap;
+		if (!pos)
+			continue;
+
+		/*
+		 * Enable translation blocking when last downstream device
+		 * that depends on it (for ATS), doesn't need ATS anymore
+		 */
+		if (--dev->ats_dependencies == 0) {
+			pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
+			pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+			ctrl |= (cap & PCI_ACS_TB);
+			pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+		}
+	}
+}
+
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12fb79fbe29d..f5d8ecb6ba96 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -552,6 +552,8 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 	return -ENOTTY;
 }
 #endif
+void pci_disable_acs_trans_blocking(struct pci_dev *dev);
+void pci_enable_acs_trans_blocking(struct pci_dev *dev);
 
 /* PCI error reporting and recovery */
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8c40c00413e7..e2ff3a94e621 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2387,10 +2387,10 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_vpd_init(dev);		/* Vital Product Data */
 	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
 	pci_iov_init(dev);		/* Single Root I/O Virtualization */
+	pci_acs_init(dev);		/* Access Control Services */
 	pci_ats_init(dev);		/* Address Translation Services */
 	pci_pri_init(dev);		/* Page Request Interface */
 	pci_pasid_init(dev);		/* Process Address Space ID */
-	pci_acs_init(dev);		/* Access Control Services */
 	pci_ptm_init(dev);		/* Precision Time Measurement */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7a40cd5caed0..31da4355f0fd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -480,6 +480,8 @@ struct pci_dev {
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
 #endif
+	/* Total number of downstream devices below a bridge that need ATS */
+	u8		ats_dependencies;
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
-- 
2.27.0.389.gc38d7665816-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
