Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9738C433EF
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 17:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86D5C60BF5;
	Tue, 26 Apr 2022 17:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D1EPC6-AYwmt; Tue, 26 Apr 2022 17:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68D0760EBA;
	Tue, 26 Apr 2022 17:21:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C42AC0039;
	Tue, 26 Apr 2022 17:21:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 044C9C002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 17:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF5CB418AE
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 17:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dUvtyn_snz5q for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 17:21:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9ED34418AF
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 17:21:10 +0000 (UTC)
Received: by mail-yb1-xb49.google.com with SMTP id
 d22-20020a25add6000000b00645d796034fso10282972ybe.2
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=K4cYGbh8rteU7qjrkcHqWVz1gvqfkrcrzyhG72fd0AA=;
 b=E9wtd87DRD48eM33gm49dXZAuiy90o56mu8zO7VUJbEb2zsXsjqgtolPYWCvofqG4u
 1O1IsLQkG+xSduUpGX8min2UXIAtDIAtXFUF6lE3kZan3d0wm6003yclVrY0HU/QCFq3
 Qzk4Vm1l5PbUtJyxSQvalZTNS8Yu4LZyIrsediKkJM2B3WYNTnuuM6kwpTh3RGjE5LSw
 TiSdmY4BPd/kJ63/LXh93F5GhHxsveoWeRxqazIQVC4553hBedfxSiBjCsFo1jBzzCPP
 8VuAtASAUq8RcINKQsGXGwocf9VGGn0JiQaJbyJUzDFElq22mc57sAX3UYxHzxf/9VUP
 7eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=K4cYGbh8rteU7qjrkcHqWVz1gvqfkrcrzyhG72fd0AA=;
 b=kXbPrszltYWAlhuFqjANiW0bKgHZCkVum0IpOIsZGsbqV3cqXa6KhQBhCcD426kR+P
 Pjj0rowNjfBC03TJlJh3McATUz2NQBm7S7dywTyDfFTHPR7u3RNSuqH33sKJ19LWVGRa
 YyRGye2Chx9y3UvNAuDlpFYSaxeRg3TEuPa5eo3nGkSVXNiraI44iITw3EU3/9kRXH0K
 nmfP97Phc59Ekzk7DFohPZdKZW5GQ20IsK7tKvj5w7gGuwO75M4poZIb7PoNoqFwLsXf
 S/CURSB4nM4owntJWV2JzEPc1EYUX5/gqwFCQWEZq6lhqlKmkauxC4Gd73nMtaoVw+4b
 Swag==
X-Gm-Message-State: AOAM5320TpQk8TC02mzlx9ibk4lKPLRQdxYFrnetNA6HiAbt+16EIv6O
 S0GjNdz9Fqsh6WJGK5wc8ZupmgdGSGrw
X-Google-Smtp-Source: ABdhPJzYSi5B3Wy/sEmQfwOrq+K0Yc+a58hKNTB54O8pj+BeIlXY7fRBF1kOrEQw8bcB/yl4ql5Vf+Va2No7
X-Received: from rajat2.mtv.corp.google.com
 ([2620:15c:202:201:ce74:273e:a60f:b750])
 (user=rajatja job=sendgmr) by 2002:a25:4243:0:b0:645:7c15:c34b with SMTP id
 p64-20020a254243000000b006457c15c34bmr22669071yba.46.1650993669427; Tue, 26
 Apr 2022 10:21:09 -0700 (PDT)
Date: Tue, 26 Apr 2022 10:21:04 -0700
Message-Id: <20220426172105.3663170-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v7 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
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
Cc: Rajat Jain <rajatja@google.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
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

The "DmaProperty" is supported and currently documented and used by
Microsoft [link 1 below], to flag internal PCIe root ports that need
DMA protection [link 2 below]. We have discussed with them and reached
a common understanding that they shall change their MSDN documentation
to say that the same property can be used to protect any PCI device,
and not just internal PCIe root ports (since there is no point
introducing yet another property for arbitrary PCI devices). This helps
with security from internal devices that offer an attack surface for
DMA attacks (e.g. internal network devices).

Support DmaProperty to mark DMA from a PCI device as untrusted.

Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v7: * Update the comment, based on feedback.
v6: * Take care of Bjorn's comments:
       - Update the commit log
       - Rename to pci_dev_has_dma_property()
       - Use acpi_dev_get_property()
v5: * Reorder the patches in the series
v4: * Add the GUID. 
    * Update the comment and commitlog.
v3: * Use Microsoft's documented property "DmaProperty"
    * Resctrict to ACPI only

 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 12bbfe833609..bafe35c301ac 100644
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
index 3ae435beaf0a..8cb4725d41fa 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1369,12 +1369,34 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static int pci_dev_has_dma_property(struct pci_dev *dev)
+{
+	struct acpi_device *adev;
+	const union acpi_object *obj;
+
+	adev = ACPI_COMPANION(&dev->dev);
+	if (!adev)
+		return 0;
+
+	/*
+	 * Property used by Microsoft Windows to enforce IOMMU DMA
+	 * protection from any device, that the system may not fully trust;
+	 * we'll honour it the same way.
+	 */
+	if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
+				   &obj) && obj->integer.value == 1)
+		return 1;
+
+	return 0;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
