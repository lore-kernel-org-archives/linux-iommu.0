Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871C5C19F37
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 20:16:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FC160F23
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 20:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49FC160F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 458A94054D;
	Thu, 29 Jul 2021 20:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zfItgPMKIAjh; Thu, 29 Jul 2021 20:16:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 76E2340554;
	Thu, 29 Jul 2021 20:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C39BBC0027;
	Thu, 29 Jul 2021 20:16:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAC61C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 20:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A97E740694
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 20:16:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K7P1cwrTiIt2 for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 20:16:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EE0940689
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 20:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=n2R1GNZpiJpIvqPgMoFv818LmwSs1yl8HL/LWwKcvVk=; b=qVpAzv/zp8q1uIn30gxe4THVOf
 7iNjpDJyE9tFtkro3GQAlbokQ/gpGsazqTnsZjslwNvED+wmSRwE7P3xxRHzqUmsDIw51O5WfvnH0
 nD1V0NYBvy80T/DJaC7xHT/CQo/Al0w+HfRcFic/sdrs04csrckHR3kzyqbYmr+VmMG/MDM0eo/uS
 83M0ZzC8oUMYB0G7/wjdMOHZy+w3RJRj7TGV2AmDx3G16Wat0ZmzRhUL3VnB8xcF/7+cDRyQ6eSeZ
 quUs301ROSNu1my9v9/FEaJwUycdweQ9Y3aVike4HEIeDvqy5dDDjfUiEHtg812pNl3hB7i8pKrKQ
 xD7+UHvA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1m9CRk-0008VN-7E; Thu, 29 Jul 2021 14:16:01 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1m9CRU-0001Th-7E; Thu, 29 Jul 2021 14:15:44 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Thu, 29 Jul 2021 14:15:24 -0600
Message-Id: <20210729201539.5602-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729201539.5602-1-logang@deltatee.com>
References: <20210729201539.5602-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, sbates@raithlin.com,
 martin.oliveira@eideticom.com, logang@deltatee.com, linux@armlinux.org.uk,
 tsbogend@alpha.franken.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v3 06/21] ARM/dma-mapping: return error code from .map_sg() ops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Stephen Bates <sbates@raithlin.com>, Russell King <linux@armlinux.org.uk>,
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
In the case of a DMA_MAPPING_ERROR, -EIO is returned. Otherwise,
-ENOMEM or -EINVAL is returned depending on the error from
__map_sg_chunk().

Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/arm/mm/dma-mapping.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c4b8df2ad328..113b9cb3701b 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -980,7 +980,7 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
-	int i, j;
+	int i, j, ret;
 
 	for_each_sg(sg, s, nents, i) {
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
@@ -988,15 +988,17 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 #endif
 		s->dma_address = ops->map_page(dev, sg_page(s), s->offset,
 						s->length, dir, attrs);
-		if (dma_mapping_error(dev, s->dma_address))
+		if (dma_mapping_error(dev, s->dma_address)) {
+			ret = -EIO;
 			goto bad_mapping;
+		}
 	}
 	return nents;
 
  bad_mapping:
 	for_each_sg(sg, s, i, j)
 		ops->unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, attrs);
-	return 0;
+	return ret;
 }
 
 /**
@@ -1622,7 +1624,7 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		     bool is_coherent)
 {
 	struct scatterlist *s = sg, *dma = sg, *start = sg;
-	int i, count = 0;
+	int i, count = 0, ret;
 	unsigned int offset = s->offset;
 	unsigned int size = s->offset + s->length;
 	unsigned int max = dma_get_max_seg_size(dev);
@@ -1634,8 +1636,10 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		s->dma_length = 0;
 
 		if (s->offset || (size & ~PAGE_MASK) || size + s->length > max) {
-			if (__map_sg_chunk(dev, start, size, &dma->dma_address,
-			    dir, attrs, is_coherent) < 0)
+			ret = __map_sg_chunk(dev, start, size,
+					     &dma->dma_address, dir, attrs,
+					     is_coherent);
+			if (ret < 0)
 				goto bad_mapping;
 
 			dma->dma_address += offset;
@@ -1648,8 +1652,9 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		}
 		size += s->length;
 	}
-	if (__map_sg_chunk(dev, start, size, &dma->dma_address, dir, attrs,
-		is_coherent) < 0)
+	ret = __map_sg_chunk(dev, start, size, &dma->dma_address, dir, attrs,
+			     is_coherent);
+	if (ret < 0)
 		goto bad_mapping;
 
 	dma->dma_address += offset;
@@ -1660,7 +1665,9 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 bad_mapping:
 	for_each_sg(sg, s, count, i)
 		__iommu_remove_mapping(dev, sg_dma_address(s), sg_dma_len(s));
-	return 0;
+	if (ret == -ENOMEM)
+		return ret;
+	return -EINVAL;
 }
 
 /**
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
