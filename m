Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E1DC433E1
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36ABD2065D
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="X1ehmlg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ABD2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA16F8783F;
	Mon, 17 Aug 2020 21:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l9y6-T2FsSy0; Mon, 17 Aug 2020 21:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D7FB38780D;
	Mon, 17 Aug 2020 21:33:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD52AC088B;
	Mon, 17 Aug 2020 21:33:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95BD7C0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 21:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7965F860DB
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 21:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7vWvqEOkV8J8 for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 21:33:08 +0000 (UTC)
X-Greylist: delayed 00:13:09 by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7419185BCC
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 21:33:08 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id k18so8867578pfp.7
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g3b17tpQsxeSrpEJMNS65bCpVzCghTE72IhZ2F4sGm8=;
 b=X1ehmlg/aGEGwU8TlqB+7kJoeA7pGAjwOZUvoxZgjsb9cYUBO53eVjUbxfMC95XFPL
 Q8KTcz9XTCWFgfS2tP8/KtjBKQPS068kT06iwABH7hw+JoPmc92WjyUnCMMIOG3y3dVW
 8Q/jbqfphqosT0z/JKfeFL8aItaLAym4bVWP7q0TSCm4m0ToVhuJ35Ap7r2ZPap6h069
 bBTcdGkCwAwiKRLgIDJ19J8Tm4ve5mEQYQSNx8/ncgRMWb+p/t2HqFZdgrG5YRevMlXg
 JWZl6E+oOmLw2z+QC7yOGH/x/ODm219KdBiBikoMblD5i0+ahzg7NSv3BQ7zeySsdG5t
 oYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g3b17tpQsxeSrpEJMNS65bCpVzCghTE72IhZ2F4sGm8=;
 b=jEHLOpi2CvBft4myrwbJ38D1I1wbeRx6RZo2tHnbvEdyj0YwqKPx+JgbyuHsG8PzfK
 e9oN6AW9OQP6zNL6g1JVe+oIEejNSaWll0vwdRRuX9CRdwPn2bmiR3mig3oPdMy+TRRX
 WnBOFpk+FHNEva8Fz8k3wOR9mXfToxt/8ZuvP4fsE2qDTFGA5IaoM/3rGt/w7DpzM+m1
 tJoMqZdSqqXTMPvitXfgQAuAs55N9G3ButCpIPQ3YPasH+T9knPeCeOLI1pu9ERp4CCK
 2fYqkXFfdv4RjFU1L1Gg4REj1ZPBdhy3HYeftAYNTItfPfyHScT0s4eMHHyA4qdsPlEx
 ghNA==
X-Gm-Message-State: AOAM530sEE7sRibp+CwgGwSxdgCasIzk9IrPX22Isc8VdRCIrEzVSjSU
 UfgNMZRNEUBHV8J8KpmK91m6SDFAXvipzWsG
X-Google-Smtp-Source: ABdhPJxZlziJHTCHPvQS4XhFGDrR51ylltOsuD3KwPoc2QE6wRzaZSRbXWvH7K1WQcYlUvdGvfnT7w==
X-Received: by 2002:aa7:9468:: with SMTP id t8mr12312380pfq.182.1597698056896; 
 Mon, 17 Aug 2020 14:00:56 -0700 (PDT)
Received: from localhost.localdomain (S0106ac17c8c0ce82.vc.shawcable.net.
 [24.87.214.6])
 by smtp.googlemail.com with ESMTPSA id b20sm21158263pfo.88.2020.08.17.14.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 14:00:56 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: Rename iommu_tlb_* functions to iommu_iotlb_*
Date: Mon, 17 Aug 2020 22:00:49 +0100
Message-Id: <20200817210051.13546-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, person@a.com, Robin Murphy <robin.murphy@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>, Alex Williamson <alex.williamson@redhat.com>,
 Will Deacon <will@kernel.org>
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

To keep naming consistent we should stick with *iotlb*. This patch
renames a few remaining functions.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c       |  2 +-
 drivers/iommu/iommu.c           |  4 ++--
 drivers/vfio/vfio_iommu_type1.c |  2 +-
 include/linux/io-pgtable.h      |  2 +-
 include/linux/iommu.h           | 10 +++++-----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 79e6d8d799a3..59adb1a0aefc 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -503,7 +503,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 			domain->ops->flush_iotlb_range(domain, dma_addr, size,
 					freelist);
 		else
-			iommu_tlb_sync(domain, &iotlb_gather);
+			iommu_iotlb_sync(domain, &iotlb_gather);
 	}
 
 	iommu_dma_free_iova(cookie, dma_addr, size, freelist);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9065127d7e9c..70a85f41876f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -762,7 +762,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 
 	}
 
-	iommu_flush_tlb_all(domain);
+	iommu_flush_iotlb_all(domain);
 
 out:
 	iommu_put_resv_regions(dev, &mappings);
@@ -2317,7 +2317,7 @@ size_t iommu_unmap(struct iommu_domain *domain,
 	if (ops->flush_iotlb_range)
 		ops->flush_iotlb_range(domain, iova, ret, freelist);
 	else
-		iommu_tlb_sync(domain, &iotlb_gather);
+		iommu_iotlb_sync(domain, &iotlb_gather);
 
 	return ret;
 }
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 570ebf878fea..d550ceb7b2aa 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -774,7 +774,7 @@ static long vfio_sync_unpin(struct vfio_dma *dma, struct vfio_domain *domain,
 	long unlocked = 0;
 	struct vfio_regions *entry, *next;
 
-	iommu_tlb_sync(domain->domain, iotlb_gather);
+	iommu_iotlb_sync(domain->domain, iotlb_gather);
 
 	list_for_each_entry_safe(entry, next, regions, list) {
 		unlocked += vfio_unpin_pages_remote(dma,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 53d53c6c2be9..d3f2bd4a3ac4 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -31,7 +31,7 @@ enum io_pgtable_fmt {
  *                  single page.  IOMMUs that cannot batch TLB invalidation
  *                  operations efficiently will typically issue them here, but
  *                  others may decide to update the iommu_iotlb_gather structure
- *                  and defer the invalidation until iommu_tlb_sync() instead.
+ *                  and defer the invalidation until iommu_iotlb_sync() instead.
  *
  * Note that these can all be called in atomic context and must therefore
  * not block.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 77e773d03f22..7b363f24bf99 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -542,7 +542,7 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
 
-static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
+static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	if (domain->ops->flush_iotlb_all)
 		domain->ops->flush_iotlb_all(domain);
@@ -556,7 +556,7 @@ static inline void flush_iotlb_range(struct iommu_domain *domain,
 		domain->ops->flush_iotlb_range(domain, iova, size, freelist);
 }
 
-static inline void iommu_tlb_sync(struct iommu_domain *domain,
+static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 				  struct iommu_iotlb_gather *iotlb_gather)
 {
 	if (domain->ops->iotlb_sync)
@@ -579,7 +579,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 	if (gather->pgsize != size ||
 	    end < gather->start || start > gather->end) {
 		if (gather->pgsize)
-			iommu_tlb_sync(domain, gather);
+			iommu_iotlb_sync(domain, gather);
 		gather->pgsize = size;
 	}
 
@@ -762,11 +762,11 @@ static inline size_t iommu_map_sg_atomic(struct iommu_domain *domain,
 	return 0;
 }
 
-static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
+static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 }
 
-static inline void iommu_tlb_sync(struct iommu_domain *domain,
+static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 				  struct iommu_iotlb_gather *iotlb_gather)
 {
 }
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
