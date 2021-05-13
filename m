Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85103C2B9FB
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA9F6144A
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA9F6144A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B44584633;
	Thu, 13 May 2021 22:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xTny8BPtl2eG; Thu, 13 May 2021 22:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB13584636;
	Thu, 13 May 2021 22:32:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F346C0042;
	Thu, 13 May 2021 22:32:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FC8CC0038
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 108B5606C5
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rR06l0eH9nyU for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 22:32:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 670AC60AB2
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=vkGnwru3sQ7lO5atwHiZHcltrNizNA3cWMJVaLsOWJc=; b=P3FzMtKpuxP/na0lxGo+61Gd76
 0j3+AT9C1QYj/XR3N3e77V/zIrBjzN99OnkEtVD6o6Xiv2x1gQIwFhOSCS7Jz4Zq7vy/HhZRnsplY
 A5NWYYKxedlpogAxfT4ir8f/8Im2Z1qqAhrBzvd3ZujSSZ21AxalLS/hoe9rxCQcer8VPxOviG7ev
 ifv7gtKFG3B33K8MK1kD4YPc+iajyZWCwMN0NL9yxT+uziWOX2JxGl3FG/SqVQ4C4/etKeJdGdKwu
 yiVtDqeKFiGrNXwT+A/HPD9twTwAWWrVF1UL5qRAfeN1xGkEj/h0qFToQMN+qhzA/udZIYjNDNwV2
 TmB57ZpA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsW-0000nD-DH; Thu, 13 May 2021 16:32:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsH-0001Sw-59; Thu, 13 May 2021 16:32:09 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 13 May 2021 16:31:51 -0600
Message-Id: <20210513223203.5542-11-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 10/22] iommu: Return full error code from
 iommu_map_sg[_atomic]()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
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

Convert to ssize_t return code so the return code from __iommu_map()
can be returned all the way down through dma_iommu_map_sg().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/iommu.c | 15 +++++++--------
 include/linux/iommu.h | 22 +++++++++++-----------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df5..df428206ea6e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2567,9 +2567,9 @@ size_t iommu_unmap_fast(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_unmap_fast);
 
-static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-			     struct scatterlist *sg, unsigned int nents, int prot,
-			     gfp_t gfp)
+static ssize_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+		struct scatterlist *sg, unsigned int nents, int prot,
+		gfp_t gfp)
 {
 	const struct iommu_ops *ops = domain->ops;
 	size_t len = 0, mapped = 0;
@@ -2610,19 +2610,18 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	/* undo mappings already done */
 	iommu_unmap(domain, iova, mapped);
 
-	return 0;
-
+	return ret;
 }
 
-size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-		    struct scatterlist *sg, unsigned int nents, int prot)
+ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+		     struct scatterlist *sg, unsigned int nents, int prot)
 {
 	might_sleep();
 	return __iommu_map_sg(domain, iova, sg, nents, prot, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(iommu_map_sg);
 
-size_t iommu_map_sg_atomic(struct iommu_domain *domain, unsigned long iova,
+ssize_t iommu_map_sg_atomic(struct iommu_domain *domain, unsigned long iova,
 		    struct scatterlist *sg, unsigned int nents, int prot)
 {
 	return __iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..9369458ba1bd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -414,11 +414,11 @@ extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 extern size_t iommu_unmap_fast(struct iommu_domain *domain,
 			       unsigned long iova, size_t size,
 			       struct iommu_iotlb_gather *iotlb_gather);
-extern size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-			   struct scatterlist *sg,unsigned int nents, int prot);
-extern size_t iommu_map_sg_atomic(struct iommu_domain *domain,
-				  unsigned long iova, struct scatterlist *sg,
-				  unsigned int nents, int prot);
+extern ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+		struct scatterlist *sg, unsigned int nents, int prot);
+extern ssize_t iommu_map_sg_atomic(struct iommu_domain *domain,
+				   unsigned long iova, struct scatterlist *sg,
+				   unsigned int nents, int prot);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
@@ -679,18 +679,18 @@ static inline size_t iommu_unmap_fast(struct iommu_domain *domain,
 	return 0;
 }
 
-static inline size_t iommu_map_sg(struct iommu_domain *domain,
-				  unsigned long iova, struct scatterlist *sg,
-				  unsigned int nents, int prot)
+static inline ssize_t iommu_map_sg(struct iommu_domain *domain,
+				   unsigned long iova, struct scatterlist *sg,
+				   unsigned int nents, int prot)
 {
-	return 0;
+	return -ENODEV;
 }
 
-static inline size_t iommu_map_sg_atomic(struct iommu_domain *domain,
+static inline ssize_t iommu_map_sg_atomic(struct iommu_domain *domain,
 				  unsigned long iova, struct scatterlist *sg,
 				  unsigned int nents, int prot)
 {
-	return 0;
+	return -ENODEV;
 }
 
 static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
