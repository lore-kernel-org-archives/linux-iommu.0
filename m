Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E09C432BE
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 05:00:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFDA60F6C
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 05:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8EFDA60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 715344042F;
	Mon, 30 Aug 2021 05:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oLVmSqsGOT43; Mon, 30 Aug 2021 05:00:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE28340425;
	Mon, 30 Aug 2021 05:00:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBB5BC0010;
	Mon, 30 Aug 2021 05:00:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDE12C001F
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 05:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAB8A401E0
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 05:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o_QGRfF0H1Fu for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 05:00:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A505D401DF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 05:00:31 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id c17so12321576pgc.0
 for <iommu@lists.linux-foundation.org>; Sun, 29 Aug 2021 22:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rNro/SVWUv53bWZVvRwdq3+oqlN2MzMlKhJNAj3RBQs=;
 b=SnOOVo00WQXBu7XiDSvc+pPdG7jSk8OScnrPcRaBwVE5/sJRbN0FDuqPTgR9ap3oxi
 DNuFV2RdyH8xhSDRtjjBNQbsWsPrC57K9ZzgCNmH+uW13+ip4QA2w1jztLoKxdW5DPAl
 a9wBQz9AD6DK7oSL36aKM0JeXfcWXs1u44pt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rNro/SVWUv53bWZVvRwdq3+oqlN2MzMlKhJNAj3RBQs=;
 b=Fmea2GlEojsMDeAjfGq91ECBmOmisXeiHEHjWwJNoLTHnHjiN0Ay1O5rkDofmsIiVS
 qsJutySG9JWh1s0XzVaBuFLYw3hyirUg0Ffr86ifk/Q5M8iT/HqdpxUMDwnT0yPdapKr
 XDxYhiHLpORZw8OjHoOdAu+XxayqprP3hcacJJEBD+o0WkPaJKpNlP40tQl1hhQwZBkF
 76bFWhymvOXHikL3BkAZ3quEyaYhB5VFkLQpl40jAygiL6/NvqCgCgJ55cpFYxFIFV1j
 ZREwhWBQVLGE2GsmNYUtymeQI42dWxMdi8WAwgrAERuj0Yi/QFy0nqVfdcS1iahopnVe
 MeGA==
X-Gm-Message-State: AOAM530xcsB68sVlecdMNAJ5rPMCJdXSpZwkwd1CvJCmXUFY0mX+gTSn
 i25mKnkGrYCYB8oe+tUFa7a6gQ==
X-Google-Smtp-Source: ABdhPJzRYF+lof5fgEG6WSccqYtdxFdliwQ0H776GHTjAuynO8sa5VDj2GFzOfyvtmCxXqPyNMD6vw==
X-Received: by 2002:a05:6a00:1687:b029:3e0:eb00:108e with SMTP id
 k7-20020a056a001687b02903e0eb00108emr21532379pfc.16.1630299631153; 
 Sun, 29 Aug 2021 22:00:31 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:28a5:1b9f:af1d:5542])
 by smtp.gmail.com with UTF8SMTPSA id t14sm15458818pga.62.2021.08.29.22.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Aug 2021 22:00:30 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 5/7] dma-iommu: Check CONFIG_SWIOTLB more broadly
Date: Mon, 30 Aug 2021 13:59:23 +0900
Message-Id: <20210830045925.4163412-6-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
References: <20210830045925.4163412-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Rajat Jain <rajatja@google.com>, Will Deacon <will@kernel.org>
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

From: David Stevens <stevensd@chromium.org>

Introduce a new dev_use_swiotlb function to guard swiotlb code, instead
of overloading dev_is_untrusted. This allows CONFIG_SWIOTLB to be
checked more broadly, so the swiotlb related code can be removed more
aggressively.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 95bfa57be488..714bec7a53c2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -317,6 +317,11 @@ static bool dev_is_untrusted(struct device *dev)
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
 
+static bool dev_use_swiotlb(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
+}
+
 /* sysfs updates are serialised by the mutex of the group owning @domain */
 int iommu_dma_init_fq(struct iommu_domain *domain)
 {
@@ -730,7 +735,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -746,7 +751,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -764,7 +769,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
@@ -780,7 +785,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
 							 sg_dma_address(sg),
@@ -807,8 +812,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
-	    iova_offset(iovad, phys | size)) {
+	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
 		void *padding_start;
 		size_t padding_size;
 
@@ -991,7 +995,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
@@ -1063,7 +1067,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
-- 
2.33.0.259.gc128427fd7-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
