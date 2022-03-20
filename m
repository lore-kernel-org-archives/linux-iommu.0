Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493A3C433EF
	for <iommu@archiver.kernel.org>; Sun, 20 Mar 2022 06:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC9E360B01;
	Sun, 20 Mar 2022 06:29:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZSxgw0jA02MH; Sun, 20 Mar 2022 06:29:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C7DA3605BA;
	Sun, 20 Mar 2022 06:29:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2538C001A;
	Sun, 20 Mar 2022 06:29:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1257C000B
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B053A4026A
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:29:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XjHZBPcjCaXn for <iommu@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 06:29:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DAB840232
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:29:17 +0000 (UTC)
Received: by mail-yb1-xb4a.google.com with SMTP id
 k13-20020a25c60d000000b006339008b92fso9191003ybf.1
 for <iommu@lists.linux-foundation.org>; Sat, 19 Mar 2022 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ASJzKtjYfW3z8f/kiOdf3O3IhYj+R3xbLBVIICLaL3k=;
 b=dPFkW/Ck2UL5AoOdA6Cz0rPjNvn8yK05uE0Xm2HL/viXm1ySX1TLtgDnqRKai9VyMl
 KLy4K5nYOqrleAfGBOFi14Jz8snJOM/Ma3lE5CQaWYaq9GNDs8Tbwqgb9al+0Frlcho0
 cXAEGoW8VtU11wcxOJOnzwgXAgwWe6avL9HI6MybXN92SKK6Mn2o330K1OzbD3AE5f4c
 AX0t6SUjhSdCulmD3jO0nRMVEwMLRkEAja9VO8AX8kQnJDyncnJdrdCeFcDee0PM4inx
 5bq5duGStWNWRNbLTMkjtH5WgvXivj37aFUbhbREceZOmLwQ2PCavmihJR2SuBIsN2yH
 CivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ASJzKtjYfW3z8f/kiOdf3O3IhYj+R3xbLBVIICLaL3k=;
 b=6w/D3D1SyrisN2nuTTLdFp8bI3REIK7lWVq/mr1HMC2q1Rc6TYc2bptr9wbkU2jTHy
 pTVwLLOfMYPII5GKnxTjVxJ5s93F++qunYpwP5OP/lfu5EZTLctgdwjYT9+lBmPOuI0a
 a+WMI3uBDPvS+v8YeC8FQdQbdclVoBRd6GKV3NVuM8WmCMFSvKQH193+hETr32DZlJDn
 oDrtCDm/XTONE8yob1TDzoZbVTFHXpAj0t+etoPS1AyBgDPoKIeWjg0wPLqv19rIlQIk
 7spn823KM5yyKD8jvqMZz7x+azny4u5YZOhbub8jUzDSdq8aCCY198OhwvDg7IovDVPs
 GU8Q==
X-Gm-Message-State: AOAM531Of1mi0Du3ZNd+x6yioode9E4z6tSn/zXqumWx05dRGbosjpmC
 jNIu8o4uQmBLdVE3gI5xZ4kvMTglxdBp
X-Google-Smtp-Source: ABdhPJyA1/PLVkOcQRO7zP5IrnCWC5GLuOxnX8km0260X51BYH8R29UtxaOINOdqUREPgrXHVEXZVZqiVanY
X-Received: from rajat2.mtv.corp.google.com
 ([2620:15c:202:201:5445:bc31:4f4a:d610])
 (user=rajatja job=sendgmr) by 2002:a25:c884:0:b0:633:7961:8a06 with SMTP id
 y126-20020a25c884000000b0063379618a06mr17596271ybf.38.1647757756226; Sat, 19
 Mar 2022 23:29:16 -0700 (PDT)
Date: Sat, 19 Mar 2022 23:29:06 -0700
In-Reply-To: <20220320062907.3272903-1-rajatja@google.com>
Message-Id: <20220320062907.3272903-2-rajatja@google.com>
Mime-Version: 1.0
References: <20220320062907.3272903-1-rajatja@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v4 2/2] PCI: ACPI: Support Microsoft's "DmaProperty"
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
---
v4: * Add the GUID. 
    * Use the (now) renamed property - pci_dev->poses_dma_risk)
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
index 1f15ab7eabf8..5360f1af2ed3 100644
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
+		dev->poses_dma_risk = 1;
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
2.35.1.894.gb6a874cedc-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
