Return-Path: <SRS0=5Lc9=HM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F88C433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:57:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E616B64E37
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E616B64E37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 97DDD86739;
	Wed, 10 Feb 2021 09:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ImePX0CnwPY3; Wed, 10 Feb 2021 09:57:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2145F86730;
	Wed, 10 Feb 2021 09:57:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E717C0891;
	Wed, 10 Feb 2021 09:57:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A25CC013A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67DA16F62B
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:56:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z3kry6uYiHPh for <iommu@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:56:57 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 611466F4D2; Wed, 10 Feb 2021 09:56:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69BA36F499
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=8LNOsPgjWIgMUBWaUxbVqhVEgDcpqshclRns6ZWbyUk=; b=Tb6BTJyVgqk6wZXJPDM/6g+NVX
 f3Y5oD+Htxwy08eJQg7Lf+U6wJ8D+KkflU2o8pV3wtTHqLdt3nfDeEYp2ZCNItD+wnC6GwzmWmwEA
 AwnpaGrua8tl6O+4WVoJLMW/sVfqTekXHplkJrQ1ax6FgOTmR4QIdGEJvFtANlNHgt/wh5J6KcvLA
 a3CQq9eVdTx6squwDFR02NEEP/8pEs/mh6hQQC0FAmA+KKDS7jzMnYspEwqmGov0iukbmnVp4nTZD
 Ug1IKJmsinE/CFTnDwHAQ0EJQyR0RTY2BA2v+gRiSMskS/PKGheTlUty6k44LzwYgvILc3izbUtQU
 m/HE1H4A==;
Received: from [2001:4bb8:184:7d04:5e70:671e:7b3:191] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l9mEr-008g4I-L1; Wed, 10 Feb 2021 09:56:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/6] MIPS/alchemy: factor out the DMA coherent setup
Date: Wed, 10 Feb 2021 10:56:37 +0100
Message-Id: <20210210095641.23856-3-hch@lst.de>
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

Factor out a alchemy_dma_coherent helper that determines if the platform
is DMA coherent.  Also stop initializing the hw_coherentio variable, given
that is only ever set to a non-zero value by the malta setup code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/alchemy/common/setup.c | 33 ++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 0f60efe0481ecc..c2da68e7984450 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -37,6 +37,23 @@
 extern void __init board_setup(void);
 extern void __init alchemy_set_lpj(void);
 
+static bool alchemy_dma_coherent(void)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1100:
+		return false;
+	case ALCHEMY_CPU_AU1200:
+		/* Au1200 AB USB does not support coherent memory */
+		if ((read_c0_prid() & PRID_REV_MASK) == 0)
+			return false;
+		return true;
+	default:
+		return true;
+	}
+}
+
 void __init plat_mem_setup(void)
 {
 	alchemy_set_lpj();
@@ -48,20 +65,8 @@ void __init plat_mem_setup(void)
 		/* Clear to obtain best system bus performance */
 		clear_c0_config(1 << 19); /* Clear Config[OD] */
 
-	hw_coherentio = 0;
-	coherentio = IO_COHERENCE_ENABLED;
-	switch (alchemy_get_cputype()) {
-	case ALCHEMY_CPU_AU1000:
-	case ALCHEMY_CPU_AU1500:
-	case ALCHEMY_CPU_AU1100:
-		coherentio = IO_COHERENCE_DISABLED;
-		break;
-	case ALCHEMY_CPU_AU1200:
-		/* Au1200 AB USB does not support coherent memory */
-		if (0 == (read_c0_prid() & PRID_REV_MASK))
-			coherentio = IO_COHERENCE_DISABLED;
-		break;
-	}
+	coherentio = alchemy_dma_coherent() ?
+		IO_COHERENCE_ENABLED : IO_COHERENCE_DISABLED;
 
 	board_setup();	/* board specific setup */
 
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
