Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0DBC4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 13:52:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D389060FDA
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 13:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D389060FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 966958356C;
	Tue, 10 Aug 2021 13:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eTGz8hH6qE3Q; Tue, 10 Aug 2021 13:52:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7711B834D3;
	Tue, 10 Aug 2021 13:52:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B753C0010;
	Tue, 10 Aug 2021 13:52:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E099FC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 13:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF71B40404
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 13:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IwmLUipcCVIy for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 13:52:27 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.8.0
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AFBE040435
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 13:52:26 +0000 (UTC)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:5c69:2226:1f00:1a90])
 by laurent.telenet-ops.be with bizsmtp
 id fpnL2500a1ffYXh01pnMiA; Tue, 10 Aug 2021 15:47:23 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mDS6C-001cUJ-NC; Tue, 10 Aug 2021 15:47:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mDS6C-001Q7Z-7i; Tue, 10 Aug 2021 15:47:20 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>
Subject: [PATCH] iommu: APPLE_DART should depend on ARCH_APPLE
Date: Tue, 10 Aug 2021 15:47:19 +0200
Message-Id: <44fcf525273b32c9afcd7e99acbd346d47f0e047.1628603162.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

The Apple DART (Device Address Resolution Table) IOMMU is only present
on Apple ARM SoCs like the M1.  Hence add a dependency on ARCH_APPLE, to
prevent asking the user about this driver when configuring a kernel
without support for the Apple Silicon SoC family.

Fixes: 05ce9d20d699b093 ("iommu/dart: Add DART iommu driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dfe81da483e9e073..e908b8222e4ed679 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -292,7 +292,7 @@ config SPAPR_TCE_IOMMU
 
 config APPLE_DART
 	tristate "Apple DART IOMMU Support"
-	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on ARCH_APPLE || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	default ARCH_APPLE
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
