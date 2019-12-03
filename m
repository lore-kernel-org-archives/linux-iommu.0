Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7328C432C3
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 15:50:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB262070A
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 15:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EBwqc6Mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB262070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8CBA186931;
	Tue,  3 Dec 2019 15:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OKyJajJe15Na; Tue,  3 Dec 2019 15:50:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0FE1284D2E;
	Tue,  3 Dec 2019 15:50:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0300CC1799;
	Tue,  3 Dec 2019 15:50:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4AA7C087F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 15:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 928B9226B3
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 15:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YPlqH7T2oFPV for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 15:50:35 +0000 (UTC)
X-Greylist: delayed 00:06:16 by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by silver.osuosl.org (Postfix) with ESMTPS id EA02E20026
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 15:50:35 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id n96so1691582pjc.3
 for <iommu@lists.linux-foundation.org>; Tue, 03 Dec 2019 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
 b=EBwqc6MulSxDWmm7FdPAlxIr1bsXOSVCfKzrNL1doUXKxjR7GgAOrbgPO8OBy0Z3G9
 Bm5CZmA9BZ/TbmkovBpvwhZIJ30cFgj4XLfb9ILKVsr87CAknH81elcvsIszKP1NoAKR
 aGoWTjt56RQiNo6Q7npeqkPdw3vqrupsnmyNtB545Okihe9VojG2/NA2Ckyu3YYNO8Ta
 C1ZIdxjKY/1vUndUI8IXOAd6NhogSj/gSUsdveQKA62ryk1FVsjhdXZ10hz3jkr3p0Dh
 n+eWdL0KL9P0/2mppivVB0C8itzjIFmTufIqXQ7MSmQ672wzoes8agSVU8kh0p/b22CV
 uykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
 b=Qn4PzBkV4BjTyrgeJSTXgYmaKXLg27hwTNUDX5tmjuv9tfKkob2v/ssJoDYk3eiSBI
 7aIM3NQs3Y0NBJBoZu313YBbGdW612SwQ/GGZTnOnnzY8tKfPfP5r6aO0sZcCLrYRONd
 AYxkRAWqlamrh8bGq0D8Wtx9tJ7LlDVpxrDjXAOKRnj92fB8We+RAkCd2KdFTFOWY+6y
 M3tydE1MDXjJbEPIRyHg7tJOMlUFbVqcb88pflW0xYgDSawX6M0gtLz+wpcsO8X1DZGl
 Wn3NZE7dtv/DOBgwQjvDGJwbPUHi6fPU02AZ+sgcp5dBolucMWsu1izoN8shuYISgxfw
 nLkw==
X-Gm-Message-State: APjAAAVhqyQpqLzTsSBMrygdjhsnfKlsQkyk7SmKTRz5SDhNZJHGo29+
 txlrOpOcnmQCyDYGbLVNFqgG1A==
X-Google-Smtp-Source: APXvYqwi1quFBuB5qYP3TcIJe8VNkDjJWejd8MLtlpQR7IQidLMT9GSnDbiV/IMnm1WNzKlpfKtONQ==
X-Received: by 2002:a17:90a:d353:: with SMTP id
 i19mr6306671pjx.43.1575387858722; 
 Tue, 03 Dec 2019 07:44:18 -0800 (PST)
Received: from [10.83.42.232] ([217.173.96.166])
 by smtp.gmail.com with ESMTPSA id e11sm3953969pgh.54.2019.12.03.07.44.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Dec 2019 07:44:17 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v6 3/3] PCI: Add DMA alias quirk for PLX PEX NTB
In-Reply-To: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
Date: Tue, 3 Dec 2019 15:44:15 +0000
Message-Id: <DB3DFAF8-D126-4ECB-A4E0-C314F4F46205@arista.com>
References: <910070E3-7964-4549-B77F-EC7FC6144503@arista.com>
 <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
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
