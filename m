Return-Path: <SRS0=o1xy=ZV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAE3C432C0
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 12:49:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD18220869
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 12:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ccO+pIaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD18220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 77DA22313B;
	Fri, 29 Nov 2019 12:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q91fyGiJk-ro; Fri, 29 Nov 2019 12:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 575301FCB5;
	Fri, 29 Nov 2019 12:49:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37842C1DD5;
	Fri, 29 Nov 2019 12:49:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAC1DC0881
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 12:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B70E387BAD
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 12:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3PBwq5Z+-jNA for <iommu@lists.linux-foundation.org>;
 Fri, 29 Nov 2019 12:49:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1FCD087880
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 12:49:11 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id c14so10449268wrn.7
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 04:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=KQ41C7hYMna6sAbU8EUfQ5iT34umDLjP3M5diwe3VPg=;
 b=ccO+pIaE1Nan91mX03P5otmQNMI5uWGFVLAoA1tm1Q441nRDItfcdCouoMOqWmzDPc
 t0ZzOHAC6vcrUpG1bFEniw9PfJ35K99a4kfmFvJNRrDTWm934meTqbCR1mni/GQt9ky/
 bQTZJ8Wn2n/2UHM2jKWKS5zP6/HAD9hiM/7lojPl0e2psF/7yzB0BHwQAh1I88c6a8cX
 0Qdq3tYO3cjkO/Q0laovjzyS6UHaL2Cq/ufDyPYcIGQu27epEf/vwUKnOm63mXGM6wQQ
 Hzl3fo6Tvpb6VDa0GDSWGzgIXHdCiE612OfeZ+bmDdfJzRjpwEX6NmFRG2F0oiKrG2wi
 0f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=KQ41C7hYMna6sAbU8EUfQ5iT34umDLjP3M5diwe3VPg=;
 b=XY3e3H+3jAJdcL2uSGs9O6+oXEVVEmIEuiJdXihJ6M/2XAQaycxM9oDYD28Dj894O5
 QDBbAq4V6mKJ2vyjTTpi36z9azGMfFYMXYp8wD0ducbEpOIg+OLL84RDyoWb2VVeJ7I2
 hI3St/CGhllwnlVWwf984a2O4hRRqJ8EiX+uNzpv5odI6wGfZhl94sRGKLLmOviPBYEe
 oBQ2j+br7q6sfMEYB1862DEP3NfOViMR+XzzUDloOu7cg4MizIGKzJI6pXEmeoGSEdt/
 5zVmsLSCtYn7F2sFdnqInqMH+wwFc2paUv4DZQhgYsZSHHfMukhzAdyIFN1e8f7p52MO
 niOg==
X-Gm-Message-State: APjAAAU51ysFSIobnItJmEzHv44sWOIS6ULnoNve+zPfZkBrfuCB1yl3
 PEtUay0jRyMMAIHRkD8qF27WHg==
X-Google-Smtp-Source: APXvYqz5+q05loCQK47HPJR4wppd+hkrJRomxmQlQyEkw7Xu5Ad6/ecJvVocI3z94dpPi67+nVVHOg==
X-Received: by 2002:adf:b645:: with SMTP id i5mr963634wre.347.1575031749330;
 Fri, 29 Nov 2019 04:49:09 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
 by smtp.gmail.com with ESMTPSA id l10sm29695601wrg.90.2019.11.29.04.49.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Nov 2019 04:49:08 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v4 1/2] PCI: Add parameter nr_devfns to pci_add_dma_alias
In-Reply-To: <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
Date: Fri, 29 Nov 2019 12:49:07 +0000
Message-Id: <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
To: linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Dmitry Safonov <dima@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
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
From: James Sewart via iommu <iommu@lists.linux-foundation.org>
Reply-To: James Sewart <jamessewart@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

pci_add_dma_alias can now be used to create a dma alias for a range of
devfns.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c    | 23 ++++++++++++++++++-----
 drivers/pci/quirks.c | 14 +++++++-------
 include/linux/pci.h  |  2 +-
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..9b0e3481fe17 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5857,7 +5857,8 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 /**
  * pci_add_dma_alias - Add a DMA devfn alias for a device
  * @dev: the PCI device for which alias is added
- * @devfn: alias slot and function
+ * @devfn_from: alias slot and function
+ * @nr_devfns: Number of subsequent devfns to alias
  *
  * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
  * which is used to program permissible bus-devfn source addresses for DMA
@@ -5873,8 +5874,14 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
  * cannot be left as a userspace activity).  DMA aliases should therefore
  * be configured via quirks, such as the PCI fixup header quirk.
  */
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
 {
+	int devfn_to;
+
+	if (nr_devfns > U8_MAX+1)
+		nr_devfns = U8_MAX+1;
+	devfn_to = devfn_from + nr_devfns - 1;
+
 	if (!dev->dma_alias_mask)
 		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
@@ -5882,9 +5889,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 		return;
 	}
 
-	set_bit(devfn, dev->dma_alias_mask);
-	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
-		 PCI_SLOT(devfn), PCI_FUNC(devfn));
+	bitmap_set(dev->dma_alias_mask, devfn_from, nr_devfns);
+
+	if (nr_devfns == 1)
+		pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
+				PCI_SLOT(devfn_from), PCI_FUNC(devfn_from));
+	else if(nr_devfns > 1)
+		pci_info(dev, "Enabling fixed DMA alias for devfn range from %02x.%d to %02x.%d\n",
+				PCI_SLOT(devfn_from), PCI_FUNC(devfn_from),
+				PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
 }
 
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 320255e5e8f8..0f3f5afc73fd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3932,7 +3932,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 static void quirk_dma_func0_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 0)
-		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0), 1);
 }
 
 /*
@@ -3946,7 +3946,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
-		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1), 1);
 }
 
 /*
@@ -4031,7 +4031,7 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
 
 	id = pci_match_id(fixed_dma_alias_tbl, dev);
 	if (id)
-		pci_add_dma_alias(dev, id->driver_data);
+		pci_add_dma_alias(dev, id->driver_data, 1);
 }
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, quirk_fixed_dma_alias);
@@ -4073,9 +4073,9 @@ DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
  */
 static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
 {
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0), 1);
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0), 1);
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3), 1);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, quirk_mic_x200_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
@@ -5273,7 +5273,7 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
 			pci_dbg(pdev,
 				"Aliasing Partition %d Proxy ID %02x.%d\n",
 				pp, PCI_SLOT(devfn), PCI_FUNC(devfn));
-			pci_add_dma_alias(pdev, devfn);
+			pci_add_dma_alias(pdev, devfn, 1);
 		}
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1a6cf19eac2d..84a8d4c2b24e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2323,7 +2323,7 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
 
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns);
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
 int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
