Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F6AC433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 18:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A3E8A40597;
	Fri, 25 Mar 2022 18:46:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FPyVgqN8rYYT; Fri, 25 Mar 2022 18:46:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3E1AE40022;
	Fri, 25 Mar 2022 18:46:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21DA9C002C;
	Fri, 25 Mar 2022 18:46:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 969F2C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77C79605B2
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UT0t5tiCRsnC for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 18:46:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3665A600C7
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:46:15 +0000 (UTC)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-2d2d45c0df7so67087837b3.1
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=woMjFLNUegNjbJ51x62lvW6UbmQA+Ba7zyUjvkY6YYA=;
 b=pPUMCEvf8BZ62Y/c+W1qNInLop6JGyWd784jOQMkj1CbDHqg6py/a0QUTHIl90KdK9
 w8p+a0V9OwXTGRp2ndKsQIWc5a+N8W0cnnGZFdPvIxrlF1S6agDjEDnrq+kop7VArS9W
 RbYNWRUOGzcuxrBV4L2CC5m9He2upt/Ljn2rs9gmG3kXrsXyBQMYXRw3Gbsg1t4Arnqw
 Vz5BauwAV3zM0pm0GHPutIyIuVDPFsGPQzM4SkLsQISvm66TNi9ybfRXySbc8zm/ozK8
 dVwdJktR7GmW3rsxUBUyM3bSBrBGyKaXWu9kydtN+Kk/btVZUC8+M9kY4J9l0j+/DcQR
 l9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=woMjFLNUegNjbJ51x62lvW6UbmQA+Ba7zyUjvkY6YYA=;
 b=Laayr1MXvwqZS+oIqNPE4P7U5EEAan5UaUbOaDwZMDQKNjAgDJvjmLNW7dDwE8e/1r
 FWg1uIRL17w18mmjLT1uSd5QpZEsaFUyV6AwZQSSElEJ78hM9AmxQyeXv/KfsjbDlQE8
 v1rqzw4Kb5OsId+6s1t+qvWtA8ii//0hjMSe+HHvhXKuJwapoWHgAZ/d/zNDgoO3y9rM
 EgfdxoIABD9ePG/txl0VsWU9sTRZkzcU7ME2Vb8DkX8//6KACnX76oirpSMHMpv2E1YJ
 UJwTUcBW6Sn8rgLklqjd82RFsApon+se0JA5beFg6fdFon/fH8slm2IjA7vyGyfym7GH
 qPQQ==
X-Gm-Message-State: AOAM532iuF0KSZQf9OS3XchZGC8DBpLjZo45JsZPkha2xaCJ7j5QsWkw
 rEHOkChlUd+3KdWr/T6KIkr1s08ADYoO
X-Google-Smtp-Source: ABdhPJyRS7LP7fvCaSt0TldDrztqH9QfayLTVY7BMeLHgtTzqTb9UkZpPGUKvtovyGUbBIdo731RsDJISrP1
X-Received: from rajat2.mtv.corp.google.com
 ([2620:15c:202:201:4cfc:6eaf:38d8:46d6])
 (user=rajatja job=sendgmr) by 2002:a81:94d:0:b0:2e5:b91a:195b with SMTP id
 74-20020a81094d000000b002e5b91a195bmr12106133ywj.44.1648233973993; Fri, 25
 Mar 2022 11:46:13 -0700 (PDT)
Date: Fri, 25 Mar 2022 11:46:08 -0700
Message-Id: <20220325184609.4059963-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v5 1/2] PCI: ACPI: Support Microsoft's "DmaProperty"
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rajat Jain <rajatxjain@gmail.com>, 
 Dmitry Torokhov <dtor@google.com>, Jesse Barnes <jsbarnes@google.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Pavel Machek <pavel@denx.de>,
 "Oliver O'Halloran" <oohall@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, 
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
 iommu@lists.linux-foundation.org
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

The "DmaProperty" is supported and documented by Microsoft here:
https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
They use this property for DMA protection:
https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt

Support the "DmaProperty" with the same semantics. This is useful for
internal PCI devices that do not hang off a PCIe rootport, but offer
an attack surface for DMA attacks (e.g. internal network devices).

Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v5: * Reorder the patches in the series
v4: * Add the GUID. 
    * Update the comment and commitlog.
v3: * Use Microsoft's documented property "DmaProperty"
    * Resctrict to ACPI only

 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d0986bda2964..20603cacc28d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -48,6 +48,9 @@ static const guid_t prp_guids[] = {
 	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
 	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
 		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
+	/* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
+	GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
+		  0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
 };
 
 /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1f15ab7eabf8..378e05096c52 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1350,12 +1350,28 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
+{
+	u8 val;
+
+	/*
+	 * Property also used by Microsoft Windows for same purpose,
+	 * (to implement DMA protection from a device, using the IOMMU).
+	 */
+	if (device_property_read_u8(&dev->dev, "DmaProperty", &val))
+		return;
+
+	if (val)
+		dev->untrusted = 1;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_acpi_check_for_dma_protection(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.35.1.1021.g381101b075-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
