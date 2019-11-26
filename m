Return-Path: <SRS0=2ATj=ZS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B049C432C0
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 17:42:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF19C2073F
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 17:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Mnkk/0t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF19C2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 631218147D;
	Tue, 26 Nov 2019 17:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LJO5G2r+Lpce; Tue, 26 Nov 2019 17:42:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 41FAD81135;
	Tue, 26 Nov 2019 17:42:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A532C0881;
	Tue, 26 Nov 2019 17:42:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C211C0878
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 17:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 56C97860D1
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 17:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nFqZg0Afyu+o for <iommu@lists.linux-foundation.org>;
 Tue, 26 Nov 2019 17:42:30 +0000 (UTC)
X-Greylist: delayed 00:06:14 by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 741B785CD0
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 17:42:30 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id s5so23493794wrw.2
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=oQnkvcGSn3FnEJK1c4dN5xwxykVF7o2DUxDzMF/X+eI=;
 b=Mnkk/0t0RTn7IldxKQ3Eup+9Qromr30JeG+ClpG/lEi7SvhU08fLh3sTUwi3fRXn8o
 voqfByxV6S1yQs7duEUcBQ+otoKhhYWSzZo1+I1m10ZThT3NnZjbg0OTRaF5BkOhlixk
 kua+SDFmNUIKqGyx4nkaK4GfJ8JSvs72ytszQfmqdcfr0nbPSHMJ4HZSMUx2L/hrj4RR
 mVRLHqw2Vs4pYWOHyD33y+RKWFglL1Yy1zoVn3HVpdRAy2/ztShsyHvkLHpz5lSv4Bcu
 eaoAMINu4XfTT7/oouyZoP2thSGXxNQJrJl0VRILeMb8Rc6Gmt/mlb8Ut9EY7Toj61q7
 lo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=oQnkvcGSn3FnEJK1c4dN5xwxykVF7o2DUxDzMF/X+eI=;
 b=ba224L9Qy4YLVWjQIwPqvjQNRLbm+E+la2jwaUbv8FvASGpjZIoK0HE2H2qnAKBUNZ
 N4sowQlvSCt9hRp/BgV5WcNYtq5jQQkdDR7phBzRnbSdvs5b47nDI46rVkZeO+BKzE2Y
 3OUi+NjlCBjByfkRKFtglHbeo43ifSykDNgBtnBE6FNp4vHlAAoltIkuHeKINCTbi1j/
 HtvOSzc2vO7jkSGCVltcVDtjm0BnXMa8QF97XeTOhJsUDQxAEMqUza0pBbkmfwdzBnAI
 BHlwSgtxJywR7ghRRLWqDe5NuXU/+ayCRbSrye+uign8/UVaHsbeIBvWynjCQS5+3fRP
 LmNw==
X-Gm-Message-State: APjAAAUEOJ65Z+Q/WqNqTrAfnuQw+s1z/HpBRlZYgCu4yl9eWeZ1r0qd
 6eXkevM3wIoJ39sSnOOGIdl5Cw==
X-Google-Smtp-Source: APXvYqwwyrGNIbRS/1qiWBQIFeTr+lTeHiS5H7x0RANPsRpLXbMnbMrkarvfrwaOtJUga4n5tQr3WQ==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr29615883wrp.12.1574789774900; 
 Tue, 26 Nov 2019 09:36:14 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
 by smtp.gmail.com with ESMTPSA id m9sm15092174wro.66.2019.11.26.09.36.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Nov 2019 09:36:14 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v3 1/2] PCI: Add helper pci_add_dma_alias_range
In-Reply-To: <3cd1d36f-a8ba-92dc-f991-19e2f9196eba@deltatee.com>
Date: Tue, 26 Nov 2019 17:36:13 +0000
Message-Id: <8855EF11-4B75-4D09-B1E3-CD668DE94C27@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <3cd1d36f-a8ba-92dc-f991-19e2f9196eba@deltatee.com>
To: linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Cc: Dmitry Safonov <dima@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
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

pci_add_dma_alias_range can be used to create a dma alias for range of
devfns.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c   | 30 +++++++++++++++++++++++-------
 include/linux/pci.h |  1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..68339309c0f4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5854,6 +5854,18 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 	return 0;
 }
 
+int _pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int len)
+{
+	if (!dev->dma_alias_mask)
+		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
+	if (!dev->dma_alias_mask) {
+		pci_warn(dev, "Unable to allocate DMA alias mask\n");
+		return -ENOMEM;
+	}
+	bitmap_set(dev->dma_alias_mask, devfn_from, len);
+	return 0;
+}
+
 /**
  * pci_add_dma_alias - Add a DMA devfn alias for a device
  * @dev: the PCI device for which alias is added
@@ -5875,18 +5887,22 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
  */
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
-	if (!dev->dma_alias_mask)
-		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
-	if (!dev->dma_alias_mask) {
-		pci_warn(dev, "Unable to allocate DMA alias mask\n");
+	if (_pci_add_dma_alias_range(dev, devfn, 1) != 0)
 		return;
-	}
-
-	set_bit(devfn, dev->dma_alias_mask);
 	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
 		 PCI_SLOT(devfn), PCI_FUNC(devfn));
 }
 
+void pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int len)
+{
+	int devfn_to = devfn_from + len - 1;
+
+	if (_pci_add_dma_alias_range(dev, devfn_from, len) != 0)
+		return;
+	pci_info(dev, "Enabling fixed DMA alias for devfn range from %02x.%d to %02x.%d\n",
+		 PCI_SLOT(devfn_from), PCI_FUNC(devfn_from), PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
+}
+
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
 {
 	return (dev1->dma_alias_mask &&
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1a6cf19eac2d..6765f3d0102b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2324,6 +2324,7 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 #endif
 
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
+void pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int len);
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
 int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
