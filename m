Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE90C4332F
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 16:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7B85612C6;
	Thu,  7 Apr 2022 16:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id abJcQLhorP8w; Thu,  7 Apr 2022 16:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D3BD3612A9;
	Thu,  7 Apr 2022 16:22:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 686CAC0012;
	Thu,  7 Apr 2022 16:22:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82C16C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6188A40CDA
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9GgNxYSE-UkJ for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 16:22:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BEB7F40CE4
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=NhYwwPYUOPNVkjQIdyegnu/TVIl/nr3VeJZ7F4Q1rQY=; b=kW115vO/lD5rTsxYR5wDs4inqe
 b62XLPVR1SKPBKhjIMGvH8/MnKPRwidsE+zcAlS8tHsYa6gYUO/lWQKAiq0fskHTB4DfCzP9KwEt2
 awuANPVzBGDxwiLlGKvFZcVBO0iijF1vKPmrj95MhayJpJlrS46NDTFfC+t7KI8DNk4ry1m5/8d1J
 +7oK34SQ8cIiJnBx3+JJHIyr3dMLRP4mSXQh6eF23EX5U4e3yvWW2GUbw6AGAk7S7lbdREAiI4Faf
 /F4ASkipN0tLk9wxIMmSs5rh/01GZKqdFrmMo+fMt2J66f3X0zQZYZqeS8UlYt9kYOkl7xUEiidL6
 7kOVCESQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMJ-002BBi-Mr; Thu, 07 Apr 2022 09:47:44 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1ncUME-00022A-Fc; Thu, 07 Apr 2022 09:47:38 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  7 Apr 2022 09:47:12 -0600
Message-Id: <20220407154717.7695-17-logang@deltatee.com>
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
Subject: [PATCH v6 16/21] block: add check when merging zone device pages
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

Add a helper to determine if zone device pages are mergeable and use
this helper in page_is_mergeable().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/bio.c        |  2 ++
 include/linux/mm.h | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index cdd7b2915c53..3406c0450db3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -834,6 +834,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
 		return false;
+	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
 	if (*same_page)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 14ef41af8b77..fb2264a17e4a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1108,6 +1108,24 @@ static inline bool is_zone_device_page(const struct page *page)
 {
 	return page_zonenum(page) == ZONE_DEVICE;
 }
+
+/*
+ * Consecutive zone device pages should not be merged into the same sgl
+ * or bvec segment with other types of pages or if they belong to different
+ * pgmaps. Otherwise getting the pgmap of a given segment is not possible
+ * without scanning the entire segment. This helper returns true either if
+ * both pages are not zone device pages or both pages are zone device pages
+ * with the same pgmap.
+ */
+static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
+						     const struct page *b)
+{
+	if (is_zone_device_page(a) != is_zone_device_page(b))
+		return false;
+	if (!is_zone_device_page(a))
+		return true;
+	return a->pgmap == b->pgmap;
+}
 extern void memmap_init_zone_device(struct zone *, unsigned long,
 				    unsigned long, struct dev_pagemap *);
 #else
@@ -1115,6 +1133,11 @@ static inline bool is_zone_device_page(const struct page *page)
 {
 	return false;
 }
+static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
+						     const struct page *b)
+{
+	return true;
+}
 #endif
 
 static inline bool folio_is_zone_device(const struct folio *folio)
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
