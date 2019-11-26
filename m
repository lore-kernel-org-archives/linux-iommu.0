Return-Path: <SRS0=2ATj=ZS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806DEC432C3
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 17:43:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C9E82073F
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 17:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Zxojlnbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9E82073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 292AA84B8B;
	Tue, 26 Nov 2019 17:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D98ueO0gXTm4; Tue, 26 Nov 2019 17:43:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A192E84B22;
	Tue, 26 Nov 2019 17:43:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82E72C0881;
	Tue, 26 Nov 2019 17:43:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92F1DC0878
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 17:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8212884B8B
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 17:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h0LamyJUP0KS for <iommu@lists.linux-foundation.org>;
 Tue, 26 Nov 2019 17:43:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A7A2E84B22
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 17:43:32 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id i12so23579875wro.5
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 09:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=o3onsAxcdCSVMT9wP5C3pAWBttyu/GDasTVkuGRwxts=;
 b=ZxojlnbpG1chj+2Uk+JMjXt7xE9rT3NDM/A7mr9cdTdLGBaRoswuJ2eY26ff2HP7xZ
 b9ZkX/M8hnGbMV2scgV7tCpgGmY5QYyeRwbU3SOHX8/9YzSUhAou6nZlyvtsoLbxfRxN
 ylCzoDNS9ymH4XmjEKabb8GEtFawb/HpoRSB3RDYCeQL4Il1jCSVqaOvWOUKYvlXogek
 HWRqu0Fb08ZQ6WTPXxQUrw2Ornwn50n4Z7mu7Gw4TDRAlJSgqvdLLerB+fbWEPTIyTJY
 MihphonvI0J7jF+bfAUiolJ1dWHm7PuLS03EZ7FEWbF43uFeFosItlH/EblE8mEjsBP8
 qpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=o3onsAxcdCSVMT9wP5C3pAWBttyu/GDasTVkuGRwxts=;
 b=gPvhie7SQkPpo/UrsewwkegAZZFJjGI1Mu9O79F1efXFunTXqX4nZ7woSTjGeSp1YY
 Un8vqIHPyAFZTBjb7hS128HbvKT+qz7kiP5CH2xOdTR99LPPmyE+lD7QkBGM98b31tZz
 PCfVQwWn4vuWrWGO/JftUC9Ids3iaGQCFJGUtzKAgSRy0bDpH5KB3EQsk4FnMw/hX20h
 Q9Jx87E5jSuhfpzOcjdP5l3W88Sgru+UyBXGn/Yum/m1NZ0Mbt0tPRLvLIKqD+oi5hy1
 5EOzBxV9QKq6e2Y1cN9BNRMVjAoyE1DMnU5KUebqkJknEou1SpexozkSw1RXeqfHdUjy
 +oXg==
X-Gm-Message-State: APjAAAWkgqJoOs7ma1OFrhki3UStF5SiXWt2B/NLLP0TKW3wrv0ZSHas
 0/5qPNI2Fg0A2yYvKhtCj+y/iA==
X-Google-Smtp-Source: APXvYqwJXPwldHGk26YVIoxFxkybsks6biw8yM458CHIbggRSvLXKeL4pOZQ+sSYdHSXBH4JwI4vRw==
X-Received: by 2002:adf:f651:: with SMTP id x17mr40181983wrp.114.1574789824259; 
 Tue, 26 Nov 2019 09:37:04 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
 by smtp.gmail.com with ESMTPSA id m9sm15092174wro.66.2019.11.26.09.37.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Nov 2019 09:37:03 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v3 2/2] PCI: Add DMA alias quirk for PLX PEX NTB
In-Reply-To: <8855EF11-4B75-4D09-B1E3-CD668DE94C27@arista.com>
Date: Tue, 26 Nov 2019 17:37:03 +0000
Message-Id: <C970ED71-21D8-44BF-9664-8B30217C9D2D@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <3cd1d36f-a8ba-92dc-f991-19e2f9196eba@deltatee.com>
 <8855EF11-4B75-4D09-B1E3-CD668DE94C27@arista.com>
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
index 320255e5e8f8..1ed230f739a4 100644
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
+	pci_add_dma_alias_range(pdev, 0, 256);
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
