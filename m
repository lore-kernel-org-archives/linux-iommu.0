Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FC1C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 16:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BD5F607BC;
	Mon,  4 Apr 2022 16:54:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yo8opQSqRmmp; Mon,  4 Apr 2022 16:54:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C41296070A;
	Mon,  4 Apr 2022 16:54:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D831C001D;
	Mon,  4 Apr 2022 16:54:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28625C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 16:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16700607BC
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 16:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eYn3kEXpr2BN for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 16:54:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 35F906070A
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=juT257hsMDR0kNSqLpseTautg+enIq2U1DAPgu8Wesk=; b=s/vYPj0Nor2v9/P0q0FW0qkQdS
 //RkASVpogRE49d7MHgaKIv7L75NGdkMsqGz4tgko3CrOzdXyUI81IDqNth8GY32HjluEeiAgDXwP
 CS3s3rWZV+Uno8cm94Bb3AGHi9cu6tY2tyAdFvn4K5HD66JDcEpjyz0rzpoJNuQQiUFoT4Pm9OArc
 IOOG2bCYiwDOK26J/YlKuykhePNHMWz08kfsbpLLS6I6J1Viygh6qyt3SOTCj32+Jm9xqVc9xAYkt
 w4+g+WGp9adapRaa9FjfGqEVZ0Qm9EK1wJ3zdnqTtbOvaDJtt9ae1O48psTeU0SQHTzs5kXP7PrXa
 j9YnusPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nbPyP-00FryS-Ni; Mon, 04 Apr 2022 16:54:37 +0000
Date: Mon, 4 Apr 2022 09:54:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 0/2] Fix issues with untrusted devices and AMD IOMMU
Message-ID: <YksizUJzRgEEdHLJ@infradead.org>
References: <20220404164707.1128-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220404164707.1128-1-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Will Deacon <will@kernel.org>, Hegde Vasant <Vasant.Hegde@amd.com>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Apr 04, 2022 at 11:47:05AM -0500, Mario Limonciello wrote:
> The bounce buffers were originally set up, but torn down during
> the boot process.
> * This happens because as part of IOMMU initialization
>   `amd_iommu_init_dma_ops` gets called and resets the global swiotlb to 0.
> * When late_init gets called `pci_swiotlb_late_init` `swiotlb_exit` is
>   called and the buffers are torn down.

I think the proper thing is to do this:

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a1ada7bff44e6..079694f894b85 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1838,17 +1838,10 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 	amd_iommu_domain_flush_complete(domain);
 }
 
-static void __init amd_iommu_init_dma_ops(void)
-{
-	swiotlb = (iommu_default_passthrough() || sme_me_mask) ? 1 : 0;
-}
-
 int __init amd_iommu_init_api(void)
 {
 	int err;
 
-	amd_iommu_init_dma_ops();
-
 	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
 	if (err)
 		return err;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
