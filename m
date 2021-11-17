Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7A5C433F5
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:54:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB816128A
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FB816128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48D2F4057E;
	Wed, 17 Nov 2021 21:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LAelbaQ_jbJN; Wed, 17 Nov 2021 21:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ECE0940917;
	Wed, 17 Nov 2021 21:54:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B71FC003E;
	Wed, 17 Nov 2021 21:54:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 602D4C0036
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44C8A400EB
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WOIPMlC8WCHJ for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 21:54:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D08F5400D0
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=eTDwkIdh5VVB1A6kvJWI8S8U3pygCOVAXIxj1iLgIvE=; b=SQppbxuiwygLRJ7DQxog7ZaSod
 0RRBTWAKJOw8Ex6wR262KavH+Sz3+W3gwMLbzGhuJjKb8TIX9XyAV4Siaq0AqFBEH7RrGWVJ4GXcA
 5TuBux3E/JXhT4m1N/mC0TpVjFCtMbYExyKx3R2mzgxOJkGEosdVBf7WtrBrwqvzW+aVsftmuewbY
 I30+UP5IXAJSIsF8Oflm3I1t0acYWm9XvXJMljxucAU6vqDU6fDZy8hF/jA0Cp4c5pSQ9UGRsOObi
 GxifhDD07oL9ZxpIfJsKPpDcPZlLr9bcRh8gHUbqdjhDZ9b/b54L5oLjNfC8cK/lpvWdoZliu63np
 7oERExbQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1mnSsi-000Zo4-TD; Wed, 17 Nov 2021 14:54:18 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mnSsd-0000yo-Oo; Wed, 17 Nov 2021 14:54:11 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Wed, 17 Nov 2021 14:53:48 -0700
Message-Id: <20211117215410.3695-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117215410.3695-1-logang@deltatee.com>
References: <20211117215410.3695-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com,
 jgg@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 01/23] lib/scatterlist: cleanup macros into static inline
 functions
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

Convert the sg_is_chain(), sg_is_last() and sg_chain_ptr() macros
into static inline functions. There's no reason for these to be macros
and static inline are generally preferred these days.

Also introduce the SG_PAGE_LINK_MASK define so the P2PDMA work, which is
adding another bit to this mask, can do so more easily.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/scatterlist.h | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 266754a55327..7ff9d6386c12 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -69,10 +69,27 @@ struct sg_append_table {
  * a valid sg entry, or whether it points to the start of a new scatterlist.
  * Those low bits are there for everyone! (thanks mason :-)
  */
-#define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
-#define sg_is_last(sg)		((sg)->page_link & SG_END)
-#define sg_chain_ptr(sg)	\
-	((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
+#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END)
+
+static inline unsigned int __sg_flags(struct scatterlist *sg)
+{
+	return sg->page_link & SG_PAGE_LINK_MASK;
+}
+
+static inline struct scatterlist *sg_chain_ptr(struct scatterlist *sg)
+{
+	return (struct scatterlist *)(sg->page_link & ~SG_PAGE_LINK_MASK);
+}
+
+static inline bool sg_is_chain(struct scatterlist *sg)
+{
+	return __sg_flags(sg) & SG_CHAIN;
+}
+
+static inline bool sg_is_last(struct scatterlist *sg)
+{
+	return __sg_flags(sg) & SG_END;
+}
 
 /**
  * sg_assign_page - Assign a given page to an SG entry
@@ -92,7 +109,7 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
 	 * In order for the low bit stealing approach to work, pages
 	 * must be aligned at a 32-bit boundary as a minimum.
 	 */
-	BUG_ON((unsigned long) page & (SG_CHAIN | SG_END));
+	BUG_ON((unsigned long)page & SG_PAGE_LINK_MASK);
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg_is_chain(sg));
 #endif
@@ -126,7 +143,7 @@ static inline struct page *sg_page(struct scatterlist *sg)
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg_is_chain(sg));
 #endif
-	return (struct page *)((sg)->page_link & ~(SG_CHAIN | SG_END));
+	return (struct page *)((sg)->page_link & ~SG_PAGE_LINK_MASK);
 }
 
 /**
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
