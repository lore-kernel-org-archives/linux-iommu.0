Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673A3C35242
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 23:07:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4E5206B6
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 23:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="d8VvKbHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4E5206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F06F022797;
	Fri, 14 Feb 2020 23:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Rptv8g2du26; Fri, 14 Feb 2020 23:07:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EC1202274A;
	Fri, 14 Feb 2020 23:07:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF81EC0881;
	Fri, 14 Feb 2020 23:07:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EBEDC0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 23:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7567D876DA
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 23:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3myButMwe4x0 for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 23:07:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E41CA876A0
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 23:06:58 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1581721620; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Ngya2sELbTUtwPSa9Tco4Zs/75SfdxNfR45aMO4h/R8=;
 b=d8VvKbHtu/n3upFyxj+tcjOSXxEYocS+tW9tT9O9vl/yOlH6tditv96EGxaKXqRMOGAHR5of
 J4tzx09mqAHo+hQ21OugYaqCi+WvtWtVLEFNnOamuHQS9ZwqpjQ/UwGDR6D9NyInO42i4bVx
 dHerXMNQdcrmjTO+Spe5je4i2/k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e472809.7f4a1e1e0110-smtp-out-n01;
 Fri, 14 Feb 2020 23:06:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 8F49AC4479D; Fri, 14 Feb 2020 23:06:49 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 60447C43383;
 Fri, 14 Feb 2020 23:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60447C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iommu/iova: Add a best-fit algorithm
Date: Fri, 14 Feb 2020 15:06:42 -0800
Message-Id: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, kernel-team@android.com,
 pratikp@codeaurora.org, Liam Mark <lmark@codeaurora.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Liam Mark <lmark@codeaurora.org>

Using the best-fit algorithm, instead of the first-fit
algorithm, may reduce fragmentation when allocating
IOVAs.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/dma-iommu.c | 17 +++++++++++
 drivers/iommu/iova.c      | 73 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/dma-iommu.h |  7 +++++
 include/linux/iova.h      |  1 +
 4 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a2e96a5..af08770 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -364,9 +364,26 @@ static int iommu_dma_deferred_attach(struct device *dev,
 	if (unlikely(ops->is_attach_deferred &&
 			ops->is_attach_deferred(domain, dev)))
 		return iommu_attach_device(domain, dev);
+	return 0;
+}
+
+/*
+ * Should be called prior to using dma-apis.
+ */
+int iommu_dma_enable_best_fit_algo(struct device *dev)
+{
+	struct iommu_domain *domain;
+	struct iova_domain *iovad;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain || !domain->iova_cookie)
+		return -EINVAL;
 
+	iovad = &((struct iommu_dma_cookie *)domain->iova_cookie)->iovad;
+	iovad->best_fit = true;
 	return 0;
 }
+EXPORT_SYMBOL(iommu_dma_enable_best_fit_algo);
 
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e6a953..716b05f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -50,6 +50,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
+	iovad->best_fit = false;
 	init_iova_rcaches(iovad);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
@@ -227,6 +228,69 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	return -ENOMEM;
 }
 
+static int __alloc_and_insert_iova_best_fit(struct iova_domain *iovad,
+		unsigned long size, unsigned long limit_pfn,
+			struct iova *new, bool size_aligned)
+{
+	struct rb_node *curr, *prev;
+	struct iova *curr_iova, *prev_iova;
+	unsigned long flags;
+	unsigned long align_mask = ~0UL;
+	struct rb_node *candidate_rb_parent;
+	unsigned long new_pfn, candidate_pfn = ~0UL;
+	unsigned long gap, candidate_gap = ~0UL;
+
+	if (size_aligned)
+		align_mask <<= limit_align(iovad, fls_long(size - 1));
+
+	/* Walk the tree backwards */
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	curr = &iovad->anchor.node;
+	prev = rb_prev(curr);
+	for (; prev; curr = prev, prev = rb_prev(curr)) {
+		curr_iova = rb_entry(curr, struct iova, node);
+		prev_iova = rb_entry(prev, struct iova, node);
+
+		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
+		new_pfn = (limit_pfn - size) & align_mask;
+		gap = curr_iova->pfn_lo - prev_iova->pfn_hi - 1;
+		if ((limit_pfn >= size) && (new_pfn > prev_iova->pfn_hi)
+				&& (gap < candidate_gap)) {
+			candidate_gap = gap;
+			candidate_pfn = new_pfn;
+			candidate_rb_parent = curr;
+			if (gap == size)
+				goto insert;
+		}
+	}
+
+	curr_iova = rb_entry(curr, struct iova, node);
+	limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
+	new_pfn = (limit_pfn - size) & align_mask;
+	gap = curr_iova->pfn_lo - iovad->start_pfn;
+	if (limit_pfn >= size && new_pfn >= iovad->start_pfn &&
+			gap < candidate_gap) {
+		candidate_gap = gap;
+		candidate_pfn = new_pfn;
+		candidate_rb_parent = curr;
+	}
+
+insert:
+	if (candidate_pfn == ~0UL) {
+		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+		return -ENOMEM;
+	}
+
+	/* pfn_lo will point to size aligned address if size_aligned is set */
+	new->pfn_lo = candidate_pfn;
+	new->pfn_hi = new->pfn_lo + size - 1;
+
+	/* If we have 'prev', it's a valid place to start the insertion. */
+	iova_insert_rbtree(&iovad->rbroot, new, candidate_rb_parent);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	return 0;
+}
+
 static struct kmem_cache *iova_cache;
 static unsigned int iova_cache_users;
 static DEFINE_MUTEX(iova_cache_mutex);
@@ -302,8 +366,13 @@ struct iova *
 	if (!new_iova)
 		return NULL;
 
-	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
-			new_iova, size_aligned);
+	if (iovad->best_fit) {
+		ret = __alloc_and_insert_iova_best_fit(iovad, size,
+				limit_pfn + 1, new_iova, size_aligned);
+	} else {
+		ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
+				new_iova, size_aligned);
+	}
 
 	if (ret) {
 		free_iova_mem(new_iova);
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2112f21..b01a31a 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,6 +37,8 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_dma_enable_best_fit_algo(struct device *dev);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
@@ -78,5 +80,10 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline int iommu_dma_enable_best_fit_algo(struct device *dev)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iova.h b/include/linux/iova.h
index a0637ab..58713bb 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -95,6 +95,7 @@ struct iova_domain {
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
 						   when not */
+	bool best_fit;
 };
 
 static inline unsigned long iova_size(struct iova *iova)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
