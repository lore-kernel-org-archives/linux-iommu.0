Return-Path: <SRS0=o1xy=ZV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400FBC432C0
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 17:57:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F331C2158A
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 17:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="c2lqMUF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F331C2158A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C85F986C29;
	Fri, 29 Nov 2019 17:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZGSSXs4xg4PV; Fri, 29 Nov 2019 17:57:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B803786AE1;
	Fri, 29 Nov 2019 17:57:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7348C1DD9;
	Fri, 29 Nov 2019 17:57:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9B2FC0881
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 17:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D857A87E71
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 17:57:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1F23ZG8cjEin for <iommu@lists.linux-foundation.org>;
 Fri, 29 Nov 2019 17:57:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4F85187E2B
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 17:57:24 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id n13so14930557pff.1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 09:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
 b=c2lqMUF03+NSISePuwEOQ8Bd5i/uGHLhUPTsAK4hss2wEZNO0YtKZZP+M6/3ykCaUV
 YcetGbI59k7rYvyGajEF+jYtXpODH//HkgX/NLg+AaXkMdP88G569ABBt6CkB8/E/FCD
 wtCSgaV4vJt7qaH+XdQGLTeQx4bDc0mg8FsG9X0IH3JYGgHBs2DN1gj/oDCTZSg9GjDg
 sXjeWlR0zFuvErWy+pocrKwGJxdoPytMflbh4lLohMKQM0wIZcZk8D54+NRLdCNjRyom
 fujXxl6O0Mt6DySUUTU6s9BM1YwdYI1MCH2NmrhA7n8cGNVFY4U20ECnfVoS5trgLGgU
 yulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
 b=Y96rvYQu8xM7R2OhbhsmO8B5z5MkOWRmo8BFzpdKZ41P8wGu7Vw8bfMK3HOepC2nEf
 v+TNH/c0vbgESau7M+iDvLGW+42QyovatD8WYtnxdeutZxuYxuE4jkZm+919YwuRBQDZ
 9e9WTaBFpmt14sVKSPPjZniYPtuvFwuQ//VleUbUk+87sssvVkoXpcGCh60eEMk/VdPK
 fcS4FNGw8Mh66c3FijSHBUKxFFZvOuvqWPDV4VCg0Dml3Rpj/njOiri5wvX1FTLHqMzl
 K/o7F950q7hgixwDW0mJZsJZ6K/vLi+1B36DDQq9zPDsiRlK2+ConIFJH1e/tYKYedEo
 Da5Q==
X-Gm-Message-State: APjAAAVuVdaDiANgjtUqh3jCZY6yHkoznfSHtQpAXnHCRs1PP73HIt1Z
 T73V6U0r1Dqor76vfpwlABVMNQ==
X-Google-Smtp-Source: APXvYqw9Eg6DFBj7pyzOk1ulRHR0zTPsy8bNtI9mmkXKnlGLTxoL+kXcdVsCFL9rQKLOL9a11hNA7Q==
X-Received: by 2002:a63:1402:: with SMTP id u2mr18046875pgl.224.1575050243696; 
 Fri, 29 Nov 2019 09:57:23 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
 by smtp.gmail.com with ESMTPSA id s7sm9962922pfe.22.2019.11.29.09.57.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Nov 2019 09:57:22 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v5 3/3] PCI: Add DMA alias quirk for PLX PEX NTB
In-Reply-To: <07D724A1-308F-44C3-8937-EE0C21EF3170@arista.com>
Date: Fri, 29 Nov 2019 17:57:20 +0000
Message-Id: <7B1FC6DB-18D2-4946-A0AF-9C1EC626D3B7@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
 <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
 <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
 <d811576e-0f89-2303-a554-2701af5c5647@deltatee.com>
 <9DD82D05-6B9E-4AF5-9A3C-D459B75C0089@arista.com>
 <07D724A1-308F-44C3-8937-EE0C21EF3170@arista.com>
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
