Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD61C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 16:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E1BA40CDC;
	Thu,  7 Apr 2022 16:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lB9F-M6THDGJ; Thu,  7 Apr 2022 16:21:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF78540CD4;
	Thu,  7 Apr 2022 16:21:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8AFDC0089;
	Thu,  7 Apr 2022 16:21:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54D01C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 359FD840C0
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2NlkSEGQgKdz for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 16:21:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E284840BB
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=UO35KE8YVx2v+yNTFMhmKCQE8ptUbM1lG6ODy8MFD4U=; b=LMw5Rh20DcM5d3Dq/RAQudlUUm
 pdDtlqxuBvAu0xmse3lD5xY5hmgzp8R947S7R2jsS0GWxslaAcBPvwmJjj7hqRG50GT1x7/0ep8AF
 bsfusTGJF30H/i8vsUxpfkIpaROaJYKTJFFlEuke+PmjYJ4Vm33iK/ayNz1QIX0B05zhY4icWzaC0
 eejbcI76PxreVywpanJaCl/qgBtoDKGMGUXtcX5kOf+RgYNPeC3EA8tP3eHqX1OFxTFAXonV4SxZg
 oSA3nC2LAVV0jPvP6aCdEbD28nAoffDmVerckIp87s0HVl2Z51lAMgypbtpQlxC269BhhosRUaS84
 AEnUWm1Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMJ-002BBf-MY; Thu, 07 Apr 2022 09:47:44 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1ncUME-00022E-NV; Thu, 07 Apr 2022 09:47:38 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  7 Apr 2022 09:47:13 -0600
Message-Id: <20220407154717.7695-18-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154717.7695-1-logang@deltatee.com>
References: <20220407154717.7695-1-logang@deltatee.com>
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
 ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v6 17/21] lib/scatterlist: add check when merging zone device
 pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Ira Weiny <ira.weiny@intel.com>,
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

Consecutive zone device pages should not be merged into the same sgl
or bvec segment with other types of pages or if they belong to different
pgmaps. Otherwise getting the pgmap of a given segment is not possible
without scanning the entire segment. This helper returns true either if
both pages are not zone device pages or both pages are zone device
pages with the same pgmap.

Factor out the check for page mergability into a pages_are_mergable()
helper and add a check with zone_device_pages_are_mergeable().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 lib/scatterlist.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index d5e82e4a57ad..af53a0984f76 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -410,6 +410,15 @@ static struct scatterlist *get_next_sg(struct sg_append_table *table,
 	return new_sg;
 }
 
+static bool pages_are_mergeable(struct page *a, struct page *b)
+{
+	if (page_to_pfn(a) != page_to_pfn(b) + 1)
+		return false;
+	if (!zone_device_pages_have_same_pgmap(a, b))
+		return false;
+	return true;
+}
+
 /**
  * sg_alloc_append_table_from_pages - Allocate and initialize an append sg
  *                                    table from an array of pages
@@ -447,6 +456,7 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 	unsigned int chunks, cur_page, seg_len, i, prv_len = 0;
 	unsigned int added_nents = 0;
 	struct scatterlist *s = sgt_append->prv;
+	struct page *last_pg;
 
 	/*
 	 * The algorithm below requires max_segment to be aligned to PAGE_SIZE
@@ -460,21 +470,17 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 		return -EOPNOTSUPP;
 
 	if (sgt_append->prv) {
-		unsigned long paddr =
-			(page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +
-			 sgt_append->prv->offset + sgt_append->prv->length) /
-			PAGE_SIZE;
-
 		if (WARN_ON(offset))
 			return -EINVAL;
 
 		/* Merge contiguous pages into the last SG */
 		prv_len = sgt_append->prv->length;
-		while (n_pages && page_to_pfn(pages[0]) == paddr) {
+		last_pg = sg_page(sgt_append->prv);
+		while (n_pages && pages_are_mergeable(last_pg, pages[0])) {
 			if (sgt_append->prv->length + PAGE_SIZE > max_segment)
 				break;
 			sgt_append->prv->length += PAGE_SIZE;
-			paddr++;
+			last_pg = pages[0];
 			pages++;
 			n_pages--;
 		}
@@ -488,7 +494,7 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 	for (i = 1; i < n_pages; i++) {
 		seg_len += PAGE_SIZE;
 		if (seg_len >= max_segment ||
-		    page_to_pfn(pages[i]) != page_to_pfn(pages[i - 1]) + 1) {
+		    !pages_are_mergeable(pages[i], pages[i - 1])) {
 			chunks++;
 			seg_len = 0;
 		}
@@ -504,8 +510,7 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 		for (j = cur_page + 1; j < n_pages; j++) {
 			seg_len += PAGE_SIZE;
 			if (seg_len >= max_segment ||
-			    page_to_pfn(pages[j]) !=
-			    page_to_pfn(pages[j - 1]) + 1)
+			    !pages_are_mergeable(pages[j], pages[j - 1]))
 				break;
 		}
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
