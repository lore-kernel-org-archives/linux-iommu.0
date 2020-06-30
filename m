Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05650C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 05:51:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9023206E9
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 05:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qKfJwCm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9023206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6164687CBE;
	Tue, 30 Jun 2020 05:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZJmkcUZcRENZ; Tue, 30 Jun 2020 05:50:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8370887CA3;
	Tue, 30 Jun 2020 05:50:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EF55C07FF;
	Tue, 30 Jun 2020 05:50:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A363C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 05:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1F36420377
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 05:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BsZ3uyyHJ8V7 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 05:50:55 +0000 (UTC)
X-Greylist: delayed 00:54:08 by SQLgrey-1.7.6
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com
 [209.85.161.74])
 by silver.osuosl.org (Postfix) with ESMTPS id E024D20357
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 05:50:54 +0000 (UTC)
Received: by mail-oo1-f74.google.com with SMTP id f20so770471oot.7
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=4vDncP2teZqEXBfb800/aEh0NO8oHsdmcXXXRRGWulY=;
 b=qKfJwCm7AT0BlfktAUmwXkHFpGx7Oh79bjH+pxC9SFGuzzGtOsIQxWs5Yj5phY/cqR
 45gYinm4T35G4tjqFwkV9aSr7wWQxsY1P4wUDPVSLq7L144QzVPw9Je6ohlEDpSLC9nm
 Uqd6Gb5/YhRsTodxBhPYntMsn2Gfo/0bCSgfjk2MiN5Cc3Bivrb2skYwEKddwTq9qSSj
 31cbZbHQz15k9yatl1muDzJiSkFI+87X7Xa5iBSnZami9myyuYwEW/ifoFJAh5sMur4H
 zysOT+Xrvm66HaayFqV0f6nbFP2WrzQBAb4HBOufuAhGFqxcrqI+6IeKEiNqG8A/jaLj
 KggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=4vDncP2teZqEXBfb800/aEh0NO8oHsdmcXXXRRGWulY=;
 b=M1/WDZ3S3d880qVDtjMzB16JJRo70owQQVaWdsvD/v5t6PvLsWGKIfTnDrT+XgOacF
 YaJ5Yt+svQXV4f8i50gU6wrGcwclTfhwB53oFfK5hXkNDY9aL4Bo1OJ/+JeWWTyxIWMV
 eys2a3QP9QJQrwIVcOyba34oreOCJoPjb2XahQpbJD8TwqCiIe0bHKks06VQo8u9dTqw
 597LU67xD6QEecAaS23JVUYVuFNSM2ouGH1MgU0Ja140mKHX+/IuBq2SN82yVbKId/g+
 rhRaYGHF59dPj87TsqcBgnINBEcX2i9faMy/6bDQLivy2qmoLQgu0LdkHCn12Ln1+zn6
 jScA==
X-Gm-Message-State: AOAM53048FGH55K4830FKeQFh8Gal9reszzfT8JsfuhQcEaURKDbIP9V
 I1tbPZqNIvzqNh8ud+qBWgn2xQJ3dNBl
X-Google-Smtp-Source: ABdhPJy7/9qcpqbednFkmBX9y9QX6DThdAm5Y+t91G8xTDRUtBBKWkL0VbqPTiirQl0bhQoYHnqP79Ft+Iel
X-Received: by 2002:a17:90a:304:: with SMTP id
 4mr20033768pje.219.1593492601508; 
 Mon, 29 Jun 2020 21:50:01 -0700 (PDT)
Date: Mon, 29 Jun 2020 21:49:43 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-8-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 7/7] PCI: Add parameter to disable attaching external
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

Introduce a PCI parameter that disables the automatic attachment of
external devices to their drivers.

This is needed to allow an admin to control which drivers he wants to
allow on external ports. For more context, see threads at:
https://lore.kernel.org/linux-pci/20200609210400.GA1461839@bjorn-Precision-5520/
https://lore.kernel.org/linux-pci/CACK8Z6H-DZQYBMqtU5_H5TTwwn35Q7Yysm9a7Wj0twfQP8QBzA@mail.gmail.com/

drivers_autoprobe can only be disabled after userspace comes up. So
any external devices that were plugged in before boot may still bind
to drivers before userspace gets a chance to clear drivers_autoprobe.
Another problem is that even with drivers_autoprobe=0, the hot-added
PCI devices are bound to drivers because PCI explicitly calls
device_attach() asking driver core to find and attach a driver. This
patch helps with both of these problems.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Use the newly introduced dev_is_external() from device core
    commit log elaborated

 drivers/pci/bus.c | 11 ++++++++---
 drivers/pci/pci.c |  9 +++++++++
 drivers/pci/pci.h |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3cef835b375fd..c11725bccffb0 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -321,9 +321,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_bridge_d3_update(dev);
 
 	dev->match_driver = true;
-	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER)
-		pci_warn(dev, "device attach failed (%d)\n", retval);
+
+	if (pci_dont_attach_external_devs && dev_is_external(&dev->dev)) {
+		pci_info(dev, "not attaching external device\n");
+	} else {
+		retval = device_attach(&dev->dev);
+		if (retval < 0 && retval != -EPROBE_DEFER)
+			pci_warn(dev, "device attach failed (%d)\n", retval);
+	}
 
 	pci_dev_assign_added(dev, true);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 35f25ac39167b..3ebcfa8b33178 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -128,6 +128,13 @@ static bool pcie_ats_disabled;
 /* If set, the PCI config space of each device is printed during boot. */
 bool pci_early_dump;
 
+/*
+ * If set, the devices behind external-facing bridges (as marked by firmware)
+ * shall not be attached automatically. Userspace will need to attach them
+ * manually: echo <pci device>  > /sys/bus/pci/drivers/<driver>/bind
+ */
+bool pci_dont_attach_external_devs;
+
 bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
@@ -6539,6 +6546,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strcmp(str, "dont_attach_external_devs")) {
+				pci_dont_attach_external_devs = true;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12fb79fbe29d3..875fecb9b2612 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,7 @@
 
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
+extern bool pci_dont_attach_external_devs;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
