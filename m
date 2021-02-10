Return-Path: <SRS0=5Lc9=HM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE1CC433DB
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:56:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04FC60235
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04FC60235
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7C48E8722F;
	Wed, 10 Feb 2021 09:56:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LeQrZ0s5r0Ha; Wed, 10 Feb 2021 09:56:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BEF1787227;
	Wed, 10 Feb 2021 09:56:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A20DAC0891;
	Wed, 10 Feb 2021 09:56:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D6C5C013A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E84CB8558A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6wPqM3rxx1J2 for <iommu@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:56:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3974584F61
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=7mvLgu1+Gyqd04nyTJl2tT4bnW3tEVEKyJ4XIZnRr1Y=; b=ieikQQAMDHkfRGHAsR3EZ4LdRF
 XHtcGxUwEVvFbFsRfy+TLDLAPGUrnkuC7+jMiQay2ou/D8WJh7S9PzTIwqnG+tobigY50b8OBfols
 UXn+wasaF6b/BBgjAE6f+q+ocziytpwDr7DvTFflWrDN2eipufomVE3drrox0nsMxxIm+QuArUdOz
 oDFWtDIsRT3yQZJuZB8/Lcyd5ASvzxnMijIhRh+QZkiWatE0fOwHe/duzmC28AeOm72G9RrPXyM9e
 sB5rmSqABEuLkZwfpsd+obDpLC8xOMAipLnLm8za4elA1gjc8ZrZZS+M5W3OP1i7xm8tsTl4m6OGq
 zg5ogTaQ==;
Received: from [2001:4bb8:184:7d04:5e70:671e:7b3:191] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l9mEo-008g4A-JP; Wed, 10 Feb 2021 09:56:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/6] MIPS/malta: simplify plat_setup_iocoherency
Date: Wed, 10 Feb 2021 10:56:36 +0100
Message-Id: <20210210095641.23856-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210210095641.23856-1-hch@lst.de>
References: <20210210095641.23856-1-hch@lst.de>
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

Given that plat_mem_setup runs before earlyparams are handled and malta
selects CONFIG_DMA_MAYBE_COHERENT, coherentio can only be set to
IO_COHERENCE_DEFAULT at this point.  So remove the checking for other
options and merge plat_enable_iocoherency into plat_setup_iocoherency
to simplify the code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/mti-malta/malta-setup.c | 32 +++++++++----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index e1fb8b5349447e..4caff9e3b45637 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -90,16 +90,15 @@ static void __init fd_activate(void)
 }
 #endif
 
-static int __init plat_enable_iocoherency(void)
+static void __init plat_setup_iocoherency(void)
 {
-	int supported = 0;
 	u32 cfg;
 
 	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO) {
 		if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
 			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
 			pr_info("Enabled Bonito CPU coherency\n");
-			supported = 1;
+			hw_coherentio = 1;
 		}
 		if (strstr(fw_getcmdline(), "iobcuncached")) {
 			BONITO_PCICACHECTRL &= ~BONITO_PCICACHECTRL_IOBCCOH_EN;
@@ -118,29 +117,16 @@ static int __init plat_enable_iocoherency(void)
 		/* Nothing special needs to be done to enable coherency */
 		pr_info("CMP IOCU detected\n");
 		cfg = __raw_readl((u32 *)CKSEG1ADDR(ROCIT_CONFIG_GEN0));
-		if (!(cfg & ROCIT_CONFIG_GEN0_PCI_IOCU)) {
+		if (cfg & ROCIT_CONFIG_GEN0_PCI_IOCU)
+			hw_coherentio = 1;
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
-		if (coherentio == IO_COHERENCE_DISABLED)
-			pr_info("Hardware DMA cache coherency disabled\n");
-		else
-			pr_info("Hardware DMA cache coherency enabled\n");
-	} else {
-		if (coherentio == IO_COHERENCE_ENABLED)
-			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
-		else
-			pr_info("Software DMA cache coherency enabled\n");
-	}
+	if (hw_coherentio)
+		pr_info("Hardware DMA cache coherency enabled\n");
+	else
+		pr_info("Software DMA cache coherency enabled\n");
 }
 
 static void __init pci_clock_check(void)
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
