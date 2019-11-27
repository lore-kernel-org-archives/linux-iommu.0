Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5BC432C3
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 13:28:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FBB2071E
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 13:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bqeEfwiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FBB2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 397F22273B;
	Wed, 27 Nov 2019 13:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J42fo9t1jseT; Wed, 27 Nov 2019 13:28:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5177322735;
	Wed, 27 Nov 2019 13:28:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E919C1DD5;
	Wed, 27 Nov 2019 13:28:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AD44C0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 13:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EE83A84FDE
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 13:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2LhxaPWZNBmC for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 13:28:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 335EC84947
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 13:28:42 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id g206so7103248wme.1
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 05:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
 b=bqeEfwiqk0IKUu+/s7/f4KVO2FRmMdw4XJ0fWLSmDH0To6KqDOOgO4XrlX3zZnuG7X
 6rR5jF2kApx7IBGq8ez5zVO0VljO3aEtwJozblGMlk/j3MszTPXVqJ+QZiH6LkijbL/5
 B/y0jiNBhHnx4cmlJrZaRaRs3XjtgcACB4oZATVNaAV2K8sPw72l4vN/8wisuQb7nCeL
 2FxRB5o1Tsz5cfFURBAFBPR3cfBac8nV42z10V5sUISiPdrELV46WirrSt8CDdtEv3i7
 EVtPD9Efq8eacJUUognqws7jWObIWGiXy2X1JMYtSfbi22+SS1yAQFR+4VAmkj2AnFYU
 P2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
 b=RIJyGWZpAn7fRrW239rY9RVIkNq4NXYO825rXCEIud/oMVxqY9q+OMOMY4CwjOSTQa
 /APDpTuEIwcAMPf8lHFw2lQD2PutnksqDXDuRagguHSU7ValNK8rjfEQZzQJpjxQyfDU
 M85CGudsuAyPysfXso1p3kS/TguTOl+pQRfh5YbgzjxFNtfKezdOxOEzv6A0juP8/hMi
 55z6uBUYbUCzITLMJRKUyqPs/dle1FHZhyV5aRF1byCRu+XcFNcgxrwOsIEPzyuZW+qr
 o8TGL+e9TV5RtGDrE9eQwEg+ZbHcIez1h+OrNT8xKNcchRDg1Vo/SmQwTwIYh2mGDQBe
 CqQw==
X-Gm-Message-State: APjAAAXhQgFTNezyOiDtGaSJEGY/s7Wfrvs/HUh7evaVrprQqjF1efYG
 pBYKbmBK5JDDPrwbpEbhky/iWg==
X-Google-Smtp-Source: APXvYqwQ816W3GKWS10H6Ble2Ctbp4cU63fRLOyXrTZyx6yPK307q9gUbHR2eQPabyEVRDjo2i+RzQ==
X-Received: by 2002:a1c:2b82:: with SMTP id r124mr4492218wmr.112.1574861320452; 
 Wed, 27 Nov 2019 05:28:40 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
 by smtp.gmail.com with ESMTPSA id v15sm6609957wmh.24.2019.11.27.05.28.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Nov 2019 05:28:39 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v3 2/2] PCI: Add DMA alias quirk for PLX PEX NTB
In-Reply-To: <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
Date: Wed, 27 Nov 2019 13:28:36 +0000
Message-Id: <9A7F2676-5BB0-4C37-B97C-E67021AD5EB1@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
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

The PLX PEX NTB forwards DMA transactions using Requester ID's that
don't exist as PCI devices. The devfn for a transaction is used as an
index into a lookup table storing the origin of a transaction on the
other side of the bridge.

This patch aliases all possible devfn's to the NTB device so that any
transaction coming in is governed by the mappings for the NTB.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0f3f5afc73fd..3a67049ca630 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5315,6 +5315,21 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
 SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
 SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
 
+/*
+ * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. These IDs
+ * are used to forward responses to the originator on the other side of the
+ * NTB. Alias all possible IDs to the NTB to permit access when the IOMMU is
+ * turned on.
+ */
+static void quirk_plx_ntb_dma_alias(struct pci_dev *pdev)
+{
+	pci_info(pdev, "Setting PLX NTB proxy ID aliases\n");
+	/* PLX NTB may use all 256 devfns */
+	pci_add_dma_alias(pdev, 0, 256);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, quirk_plx_ntb_dma_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, quirk_plx_ntb_dma_alias);
+
 /*
  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS does
  * not always reset the secondary Nvidia GPU between reboots if the system
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
