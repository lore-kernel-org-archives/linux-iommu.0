Return-Path: <SRS0=VQ5+=43=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B920BC10F27
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 18:25:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA2B205F4
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 18:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA2B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2AB622152F;
	Tue, 10 Mar 2020 18:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Stz6Nskc6grB; Tue, 10 Mar 2020 18:25:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D22BC203F1;
	Tue, 10 Mar 2020 18:25:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC152C07FE;
	Tue, 10 Mar 2020 18:25:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B799C0177
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 18:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5661488C0A
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 18:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gOzZkRlZMTwY for <iommu@lists.linux-foundation.org>;
 Tue, 10 Mar 2020 18:25:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E798388C06
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 18:25:49 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3E8C268BE1; Tue, 10 Mar 2020 19:25:46 +0100 (CET)
Date: Tue, 10 Mar 2020 19:25:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
Message-ID: <20200310182546.GA9268@lst.de>
References: <bug-206175-5873@https.bugzilla.kernel.org/>
 <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de>
 <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, aros@gmx.com, linux-kernel@vger.kernel.org
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

FYI, Linus' latest rant shows up in bugzilla, but never made it to me,
just as the other replies from Artem and Hans.  This just shows how
broken bugzilla is as a reporting tool.  Please be a little more calm,
I've always taken reported regressions series and as a first priority,
but it really does not help if information is hidden away.  Adding
Artem to the Cc list and drop bugzilla to make this work a bit better.

Artem, can you test the patch below?  This fixes the broken dma_mask
handling in platform_device_register_full that could override a
perfectly valid mask with 0.  If this doesn't work, can you throw
in a dump_stack() into the working kernel build to see where
platform_device_register_full and setup_pdev_dma_masks get called
for your system?

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f1288b..03035661eb6b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -662,19 +662,6 @@ struct platform_device *platform_device_register_full(
 	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
 
 	if (pdevinfo->dma_mask) {
-		/*
-		 * This memory isn't freed when the device is put,
-		 * I don't have a nice idea for that though.  Conceptually
-		 * dma_mask in struct device should not be a pointer.
-		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
-		 */
-		pdev->dev.dma_mask =
-			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
-		if (!pdev->dev.dma_mask)
-			goto err;
-
-		kmemleak_ignore(pdev->dev.dma_mask);
-
 		*pdev->dev.dma_mask = pdevinfo->dma_mask;
 		pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
 	}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
