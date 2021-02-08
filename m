Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F7CC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 14:50:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C2864E6C
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 14:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C2864E6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 42B4B2079A;
	Mon,  8 Feb 2021 14:50:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7ttzwk0VbHH; Mon,  8 Feb 2021 14:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C04C7204E8;
	Mon,  8 Feb 2021 14:50:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95356C1DA9;
	Mon,  8 Feb 2021 14:50:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D4ACC1DA9
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 14:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6B527204E8
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 14:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5C9FGJWbK4JR for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 14:50:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 3039A20338
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=LbVdEP6Q8sdgfOzBxgO4V1zaoOM6OhmNlKX6TnKe0gU=; b=UK19lT76lf81jqlGSn+5yRUE9A
 eoh59SO2HusP3NHZuWli8aBBZic3BEbHGUbWFa03/NI6EczhF8dU8W0c2Ir3uY9Ft7ra8yTF4tCMa
 IVFb8ENbP93Zp2VMVVjBgslqUtgvkHTkZ1+dJ/5yvb7bKv87d3epy0cEot9Y3xegVTzOer7Ksv09+
 1PBy0uKNz03QNHOfhP+JpYDShZ/zk2bctze+zLppzHiOwcsejgLRD5F+r/Y7m0l/99v7Ur5wRhnLn
 YXTQdrVoOtwut87NEo64JkgMv0+AgVp5UQ0eSAh7yh+mb3xOUs+MIQuIbh8+e0D+qqxlxP85YnACM
 ojngzDHQ==;
Received: from [2001:4bb8:184:7d04:e3ed:f9d6:78e2:6f0f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l97rx-0066da-9O; Mon, 08 Feb 2021 14:50:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/6] MIPS/malta: simplify plat_setup_iocoherency
Date: Mon,  8 Feb 2021 15:50:19 +0100
Message-Id: <20210208145024.3320420-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208145024.3320420-1-hch@lst.de>
References: <20210208145024.3320420-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Merge plat_enable_iocoherency into plat_setup_iocoherency to simplify
the code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/mti-malta/malta-setup.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index e1fb8b5349447e..f3fec5a5a07c76 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -90,7 +90,7 @@ static void __init fd_activate(void)
 }
 #endif
 
-static int __init plat_enable_iocoherency(void)
+static void __init plat_setup_iocoherency(void)
 {
 	int supported = 0;
 	u32 cfg;
@@ -118,19 +118,13 @@ static int __init plat_enable_iocoherency(void)
 		/* Nothing special needs to be done to enable coherency */
 		pr_info("CMP IOCU detected\n");
 		cfg = __raw_readl((u32 *)CKSEG1ADDR(ROCIT_CONFIG_GEN0));
-		if (!(cfg & ROCIT_CONFIG_GEN0_PCI_IOCU)) {
+		if (cfg & ROCIT_CONFIG_GEN0_PCI_IOCU)
+			supported = 1;
+		else
 			pr_crit("IOCU OPERATION DISABLED BY SWITCH - DEFAULTING TO SW IO COHERENCY\n");
-			return 0;
-		}
-		supported = 1;
 	}
-	hw_coherentio = supported;
-	return supported;
-}
 
-static void __init plat_setup_iocoherency(void)
-{
-	if (plat_enable_iocoherency()) {
+	if (supported)
 		if (coherentio == IO_COHERENCE_DISABLED)
 			pr_info("Hardware DMA cache coherency disabled\n");
 		else
@@ -141,6 +135,7 @@ static void __init plat_setup_iocoherency(void)
 		else
 			pr_info("Software DMA cache coherency enabled\n");
 	}
+	hw_coherentio = supported;
 }
 
 static void __init pci_clock_check(void)
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
