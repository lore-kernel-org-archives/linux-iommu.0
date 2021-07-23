Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E196C41537
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:50:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D1760F23
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9D1760F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAA3D83B56;
	Fri, 23 Jul 2021 17:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WIyLg3A3gUPQ; Fri, 23 Jul 2021 17:50:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ADE7883B53;
	Fri, 23 Jul 2021 17:50:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1C1CC0024;
	Fri, 23 Jul 2021 17:50:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C8F3C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4960983B52
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:50:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZZYf06z6-oW7 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 17:50:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E25583B4E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=3+NKDp2q/0zHzVVwq3INd+w6NURPV4dE2hTg9/0ITMI=; b=p5v2Ta39J/FMFArdqmG9hSG4dJ
 GVRjnEedIhEO1h1r5PxFM08gIBm2nd5NToaIWZ7khZNaAntYnBCZUWT0JxZdoSW9l1fdwLGQfi0X3
 lbubJp9G7o8oDw/JDXbE/idqJCA1fHd/koaMSZyJUWEIAXuMnTNHuyqeQmpH1vtLOBamcAC/zV6XL
 5FI4jeQ2Z+mEOnsWyzTxTyD6b5+Udusu7tJ0clJtv+ZswVDDZVA5y4XKO2x7PSA1AXTf4tKdtp/JU
 4AxOqYl9AObVsclV8wS/PiUkaSSPgigS2efnAtBdAJWeCeYgFhDY5hULZaNiPuGhFkfmEfLJZJnwf
 1AX9mNhw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1m6zJj-0005Li-J2; Fri, 23 Jul 2021 11:50:36 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1m6zJL-0005qk-5K; Fri, 23 Jul 2021 11:50:11 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Jul 2021 11:49:52 -0600
Message-Id: <20210723175008.22410-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723175008.22410-1-logang@deltatee.com>
References: <20210723175008.22410-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, sbates@raithlin.com,
 martin.oliveira@eideticom.com, logang@deltatee.com, rth@twiddle.net,
 ink@jurassic.park.msu.ru, mattst88@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 05/21] alpha: return error code from alpha_pci_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Stephen Bates <sbates@raithlin.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
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

From: Martin Oliveira <martin.oliveira@eideticom.com>

The .map_sg() op now expects an error code instead of zero on failure.

pci_map_single_1() can fail for different reasons, but since the only
supported type of error return is DMA_MAPPING_ERROR, we coalesce those
errors into EIO.

ENOMEM is returned when no page tables can be allocated.

Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/pci_iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 35d7b3096d6e..21f9ac101324 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -649,7 +649,9 @@ static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 		sg->dma_address
 		  = pci_map_single_1(pdev, SG_ENT_VIRT_ADDRESS(sg),
 				     sg->length, dac_allowed);
-		return sg->dma_address != DMA_MAPPING_ERROR;
+		if (sg->dma_address == DMA_MAPPING_ERROR)
+			return -EIO;
+		return 1;
 	}
 
 	start = sg;
@@ -685,8 +687,10 @@ static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 	if (out < end)
 		out->dma_length = 0;
 
-	if (out - start == 0)
+	if (out - start == 0) {
 		printk(KERN_WARNING "pci_map_sg failed: no entries?\n");
+		return -ENOMEM;
+	}
 	DBGA("pci_map_sg: %ld entries\n", out - start);
 
 	return out - start;
@@ -699,7 +703,7 @@ static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 	   entries.  Unmap them now.  */
 	if (out > start)
 		pci_unmap_sg(pdev, start, out - start, dir);
-	return 0;
+	return -ENOMEM;
 }
 
 /* Unmap a set of streaming mode DMA translations.  Again, cpu read
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
