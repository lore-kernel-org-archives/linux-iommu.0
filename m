Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23BFC433E2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 06:26:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF3D206A4
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 06:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WxTCKh5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF3D206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 07BB52342E;
	Wed, 16 Sep 2020 06:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CknKznTWbhaP; Wed, 16 Sep 2020 06:26:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 019A12043F;
	Wed, 16 Sep 2020 06:25:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E089BC0859;
	Wed, 16 Sep 2020 06:25:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A674C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 06:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4CD9286A0F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 06:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LBEJxP42BFtT for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 06:25:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B52148560C
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 06:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=rZz7WEucbLzmcSBpKZVSsyybm+o08I+OYE053DvRjjM=; b=WxTCKh5RipO/ghifOttWKDY07y
 QNmTljydnuaqDLQ3kR/uRVM5HpNnUWS5FbFx0Kp8Kt9rimc4W3gIvIa8DayD7I9+mtCAnKGz6/w3T
 e4i815xpazXxeeB9uo+qUbZ4axz35wmCVGx1ifmhNI1laNYSGVkapVzYPnsdbtHPRl9bO/Kj4FCKW
 1n5cWUKmNXdn9m1c9qSWX8Hix1q1NrzHTfqcV1dEWx+36tFDJC4xG4kuvntDGtb/gw0n+TXkaU94v
 D5hbJNS63JnwIXTHAGWlf54tzj7lxAqMGvsT3qhQaY8wkKhfgBfcwnMHumJeJ6PsCwvzpl2lqQTI2
 lphIJfIw==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIQt9-0007Y3-K4; Wed, 16 Sep 2020 06:25:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/6] ARM/keystone: move the DMA offset handling under ifdef
 CONFIG_ARM_LPAE
Date: Wed, 16 Sep 2020 08:14:57 +0200
Message-Id: <20200916061500.1970090-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916061500.1970090-1-hch@lst.de>
References: <20200916061500.1970090-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>, linux-sh@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, linux-usb@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nathan Chancellor <natechancellor@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

The DMA offset notifier can only be used if PHYS_OFFSET is at least
KEYSTONE_HIGH_PHYS_START, which can't be represented by a 32-bit
phys_addr_t.  Currently the code compiles fine despite that, a pending
change to the DMA offset handling would create a compiler warning for
this case.  Add an ifdef to not compile the code except for LPAE
configs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/mach-keystone/keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 638808c4e12247..dcd031ba84c2e0 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -24,6 +24,7 @@
 
 #include "keystone.h"
 
+#ifdef CONFIG_ARM_LPAE
 static unsigned long keystone_dma_pfn_offset __read_mostly;
 
 static int keystone_platform_notifier(struct notifier_block *nb,
@@ -48,14 +49,17 @@ static int keystone_platform_notifier(struct notifier_block *nb,
 static struct notifier_block platform_nb = {
 	.notifier_call = keystone_platform_notifier,
 };
+#endif /* CONFIG_ARM_LPAE */
 
 static void __init keystone_init(void)
 {
+#ifdef CONFIG_ARM_LPAE
 	if (PHYS_OFFSET >= KEYSTONE_HIGH_PHYS_START) {
 		keystone_dma_pfn_offset = PFN_DOWN(KEYSTONE_HIGH_PHYS_START -
 						   KEYSTONE_LOW_PHYS_START);
 		bus_register_notifier(&platform_bus_type, &platform_nb);
 	}
+#endif
 	keystone_pm_runtime_init();
 }
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
