Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610E6C636C9
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 17:16:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D568613D4
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 17:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D568613D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4618F4037B;
	Thu, 15 Jul 2021 17:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0FfTybOVCNMg; Thu, 15 Jul 2021 17:16:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33D5E40E7E;
	Thu, 15 Jul 2021 17:16:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF0E5C0020;
	Thu, 15 Jul 2021 17:16:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27FD4C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1617D4037B
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gZXH-Fvw9Y9d for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 17:16:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89C1B403CD
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=yHZJDyrbtc2DNRkkLnCWk6LyCavHBAROxZPaBwPJV+w=; b=Uk9hmVlOMLTaHT5Tplw3GW15jH
 CeVS5nCeJY2tUo3aAcbZduCSQVDn0jptjFbmtnj3v5G8CraUuCNv7B/bA1lXnwAqLJwQNB2t23QL6
 GCZqhLMOwzqRH34G+Y5BBzb4NQhwdrGK5mOkNWXt9gAGnvdQqFYRscmaU6pWKWcE7qUt7wO4D80pe
 8/PNToWYD9qaWrwbmxJrGUcHjdK3p3BXVy4naPhfKpzb1aURkg8IXCH/NXXzv+OOVY95aZoB5qwfA
 QHHlGEKoZAnVNvL5MsmbOBHtpgrk0NyNnIEds8LB/+w6+0+ZS1RCVbWjm8vff/8qi0kFo6Sr+2pOL
 bwtGjm0w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1m44V0-0001ye-IS; Thu, 15 Jul 2021 10:46:11 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1m44Uo-0001nQ-Dh; Thu, 15 Jul 2021 10:45:58 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Thu, 15 Jul 2021 10:45:35 -0600
Message-Id: <20210715164544.6827-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715164544.6827-1-logang@deltatee.com>
References: <20210715164544.6827-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, sbates@raithlin.com,
 martin.oliveira@eideticom.com, logang@deltatee.com, mpe@ellerman.id.au,
 schnelle@linux.ibm.com, tsbogend@alpha.franken.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v1 07/16] ia64/sba_iommu: return error code from
 sba_map_sg_attrs()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Stephen Bates <sbates@raithlin.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
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

Propagate the return of dma_mapping_error() up, if it is an errno.

sba_coalesce_chunks() may only presently fail if sba_alloc_range()
fails, which in turn only fails if the iommu is out of mapping
resources, hence a -ENOMEM is used in that case.

Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/ia64/hp/common/sba_iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 9148ddbf02e5..09dbe07a18c1 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -1431,7 +1431,7 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			    unsigned long attrs)
 {
 	struct ioc *ioc;
-	int coalesced, filled = 0;
+	int coalesced, filled = 0, ret;
 #ifdef ASSERT_PDIR_SANITY
 	unsigned long flags;
 #endif
@@ -1458,8 +1458,9 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 		sglist->dma_length = sglist->length;
 		sglist->dma_address = sba_map_page(dev, sg_page(sglist),
 				sglist->offset, sglist->length, dir, attrs);
-		if (dma_mapping_error(dev, sglist->dma_address))
-			return 0;
+		ret = dma_mapping_error(dev, sglist->dma_address);
+		if (ret)
+			return ret;
 		return 1;
 	}
 
@@ -1486,7 +1487,7 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 	coalesced = sba_coalesce_chunks(ioc, dev, sglist, nents);
 	if (coalesced < 0) {
 		sba_unmap_sg_attrs(dev, sglist, nents, dir, attrs);
-		return 0;
+		return -ENOMEM;
 	}
 
 	/*
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
