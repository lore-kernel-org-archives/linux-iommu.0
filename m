Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2387EC433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 16:25:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDA464F1C
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 16:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDA464F1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6865F841FA;
	Thu, 18 Mar 2021 16:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3mC0EYuUtBK4; Thu, 18 Mar 2021 16:25:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BFD984198;
	Thu, 18 Mar 2021 16:25:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0396EC000A;
	Thu, 18 Mar 2021 16:25:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04727C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 16:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1C4A841E0
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 16:25:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bSIJ3nfvI7Au for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 16:25:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20C1984198
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=9gEP8raZOg3EB9wo1YlmqP5MKZV8/kqbQaScw+YfWuE=; b=JnuhGi9J4kooWrHzFkSJvSQB/f
 H1LyP5FBzoY04johHQs63+EOvbbCIVrj5RI97Wzqrpu5/ANSHEXfUXSSHmdx8qZkrYl0CqZPmQyqD
 gUuOdJ02W96mrTGr0lh+bCwDZO6ub/Uc/WxBzk9LMWBGZefHttJAq4B8N6Oi+F+13iVW8MEutZfAR
 KhQuThABIusZgmw132kdn9enlQGOEPn3Q5pRjO2nNpenvm5KpiptkisJ0z5ZklqDVtXsxC2KvXNFB
 IxMjAONqS2TPXowUqOYB3qGo+qaWd6+I+m/Zd/mrIzgAeF0iNeQFlhB66jMOxkfVk2r8Yaub0v3Mb
 dDfJBBug==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lMvRV-003DLG-Ih; Thu, 18 Mar 2021 16:24:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 3/3] swiotlb: remove swiotlb_nr_tbl
Date: Thu, 18 Mar 2021 17:14:24 +0100
Message-Id: <20210318161424.489045-4-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210318161424.489045-1-hch@lst.de>
References: <20210318161424.489045-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, Claire Chang <tientzu@chromium.org>,
 linuxppc-dev@lists.ozlabs.org, Dongli Zhang <dongli.zhang@oracle.com>
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

All callers just use it to check if swiotlb is active at all, for which
they can just use is_swiotlb_active.  In the longer run drivers need
to stop using is_swiotlb_active as well, but let's do the simple step
first.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gem/i915_gem_internal.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c        | 2 +-
 drivers/pci/xen-pcifront.c                   | 2 +-
 include/linux/swiotlb.h                      | 1 -
 kernel/dma/swiotlb.c                         | 7 +------
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
index ad22f42541bda6..a9d65fc8aa0eab 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
@@ -42,7 +42,7 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
 
 	max_order = MAX_ORDER;
 #ifdef CONFIG_SWIOTLB
-	if (swiotlb_nr_tbl()) {
+	if (is_swiotlb_active()) {
 		unsigned int max_segment;
 
 		max_segment = swiotlb_max_segment();
diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index a37bc3d7b38b3b..9662522aa0664a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -321,7 +321,7 @@ nouveau_ttm_init(struct nouveau_drm *drm)
 	}
 
 #if IS_ENABLED(CONFIG_SWIOTLB) && IS_ENABLED(CONFIG_X86)
-	need_swiotlb = !!swiotlb_nr_tbl();
+	need_swiotlb = is_swiotlb_active();
 #endif
 
 	ret = ttm_bo_device_init(&drm->ttm.bdev, &nouveau_bo_driver,
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 2d75026482197d..b7a8f3a1921f83 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -693,7 +693,7 @@ static int pcifront_connect_and_init_dma(struct pcifront_device *pdev)
 
 	spin_unlock(&pcifront_dev_lock);
 
-	if (!err && !swiotlb_nr_tbl()) {
+	if (!err && !is_swiotlb_active()) {
 		err = pci_xen_swiotlb_init_late();
 		if (err)
 			dev_err(&pdev->xdev->dev, "Could not setup SWIOTLB!\n");
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 63f7a63f61d098..216854a5e5134b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -37,7 +37,6 @@ enum swiotlb_force {
 
 extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
-extern unsigned long swiotlb_nr_tbl(void);
 unsigned long swiotlb_size_or_default(void);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
 extern int swiotlb_late_init_with_default_size(size_t default_size);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 13de669a9b4681..539c76beb52e07 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -94,12 +94,6 @@ setup_io_tlb_npages(char *str)
 }
 early_param("swiotlb", setup_io_tlb_npages);
 
-unsigned long swiotlb_nr_tbl(void)
-{
-	return io_tlb_default_mem ? io_tlb_default_mem->nslabs : 0;
-}
-EXPORT_SYMBOL_GPL(swiotlb_nr_tbl);
-
 unsigned int swiotlb_max_segment(void)
 {
 	return io_tlb_default_mem ? max_segment : 0;
@@ -652,6 +646,7 @@ bool is_swiotlb_active(void)
 {
 	return io_tlb_default_mem != NULL;
 }
+EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
 #ifdef CONFIG_DEBUG_FS
 
-- 
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
