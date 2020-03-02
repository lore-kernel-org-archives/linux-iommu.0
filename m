Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9984DC3F2D1
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAAA246B7
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BgurVRTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAAA246B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 51D7820365;
	Mon,  2 Mar 2020 00:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pdETQn2vfhf6; Mon,  2 Mar 2020 00:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A765E20356;
	Mon,  2 Mar 2020 00:05:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94376C1D74;
	Mon,  2 Mar 2020 00:05:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 201A1C013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E2E848508E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HT_ACADyTlkn for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 00:05:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B710E850AD
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:17 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id cx7so455895pjb.3
 for <iommu@lists.linux-foundation.org>; Sun, 01 Mar 2020 16:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=RPmHFZTKj0WwBmDgwWbw42yXpLHF3ujlV0a487GCqvA=;
 b=BgurVRTtvkBstb+I4bGWFCbWRBHkrlK0UsFYaaorA7v1fEmjgbDlIfLa13frM7+oaO
 57BvUNo3q4741skQJf+Vmiee2Z4W3fNe0abo/32vJYCKDa82mnRtN1+16ANQ5vm7y2X/
 rPy43yBu/cWX3gSzbItiq1T2oMb+oE2/NVeoiycEPVW3LGYndUc1Zd6dJ3eiwJQ4mMkv
 0UeyoMJ8P+XrzEUSPBcTQpvu/5ISHt7iT8x/uYp5y/28fBbiwOs0+DG5AAkoUW3djQVX
 wF9lZDcjbBUl9Zk87M0c2fbquH7bUD2lIjFoimsqcu5ugN6XFz0SIH5V+Xg2o9qZHmTv
 PQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=RPmHFZTKj0WwBmDgwWbw42yXpLHF3ujlV0a487GCqvA=;
 b=bqYfkoncnMEyQM6TLQLJWvQ3Z1PRUd4Jf8+Gp8hi4TWn7eTnR/myMDVR/CpcKUkNDL
 cqIs1GftmTroUqVRDJV5Na+ZqV6vN51d1H6XVAiwgjdVgojOM+gGWgl5/8u5gDjbsv7f
 U/1SNj6Kmnt1mW5Pwn9eG6s88cd3g5QoxvO5++f3mTrkdznafX6lL0/jBmrrL1OOPE4o
 uD/Z2K0vJC5naoCY+Qq8LfvO6vWXosNdtrS5wtXNE0qiyBluOOID5Ocsx3ncm+p0bOut
 qVVFtOrNTHfVCeyXhJp58DnhqvUlPCoScXZvlniJ8zJGfyBEGZTMvwCcQ5m41Hz3Gdlh
 yUQg==
X-Gm-Message-State: APjAAAUDM23dflffPas070zz2hoEfIqu0GqYYyGkT+I6Z08uSE+jXGU+
 B5pOBQVpH11zzMjSI616lApbwQ==
X-Google-Smtp-Source: APXvYqx9iey6XnkSQZUMWmmv45zjt1VPdN1q+QNNob+566rj9Xs7u+I7LOmA8T13B6gvzZ79j/d5BQ==
X-Received: by 2002:a17:90a:f492:: with SMTP id
 bx18mr18661440pjb.118.1583107517069; 
 Sun, 01 Mar 2020 16:05:17 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id h132sm14335385pfe.118.2020.03.01.16.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 16:05:16 -0800 (PST)
Date: Sun, 1 Mar 2020 16:05:16 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [rfc 3/6] dma-remap: wire up the atomic pools depending on gfp
 mask
In-Reply-To: <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003011537220.213582@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 baekhw@google.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


When allocating non-blockable memory, determine the optimal gfp mask of
the device and use the appropriate atomic pool.

The coherent DMA mask will remain the same between allocation and free
and, thus, memory will be freed to the same atomic pool it was allocated
from.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/dma-direct.h |  2 ++
 kernel/dma/direct.c        |  6 +++---
 kernel/dma/remap.c         | 34 ++++++++++++++++++++++++++--------
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -67,6 +67,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 }
 
 u64 dma_direct_get_required_mask(struct device *dev);
+gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
+				  u64 *phys_mask);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -44,8 +44,8 @@ u64 dma_direct_get_required_mask(struct device *dev)
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
-static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
-		u64 *phys_limit)
+gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
+				  u64 *phys_limit)
 {
 	u64 dma_limit = min_not_zero(dma_mask, dev->bus_dma_limit);
 
@@ -88,7 +88,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	/* we always manually zero the memory once we are done: */
 	gfp &= ~__GFP_ZERO;
-	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
+	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 			&phys_limit);
 	page = dma_alloc_contiguous(dev, alloc_size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -188,28 +188,44 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
+static inline struct gen_pool *dev_to_pool(struct device *dev)
+{
+	u64 phys_mask;
+	gfp_t gfp;
+
+	gfp = dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
+					  &phys_mask);
+	if (IS_ENABLED(CONFIG_ZONE_DMA) && gfp == GFP_DMA)
+		return atomic_pool;
+	if (IS_ENABLED(CONFIG_ZONE_DMA32) && gfp == GFP_DMA32)
+		return atomic_pool_dma32;
+	return atomic_pool_normal;
+}
+
 static bool dma_in_atomic_pool(struct device *dev, void *start, size_t size)
 {
-	if (unlikely(!atomic_pool))
-		return false;
+	struct gen_pool *pool = dev_to_pool(dev);
 
-	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
+	if (unlikely(!pool))
+		return false;
+	return gen_pool_has_addr(pool, (unsigned long)start, size);
 }
 
 void *dma_alloc_from_pool(struct device *dev, size_t size,
 			  struct page **ret_page, gfp_t flags)
 {
+	struct gen_pool *pool = dev_to_pool(dev);
 	unsigned long val;
 	void *ptr = NULL;
 
-	if (!atomic_pool) {
-		WARN(1, "coherent pool not initialised!\n");
+	if (!pool) {
+		WARN(1, "%pGg atomic pool not initialised!\n", &flags);
 		return NULL;
 	}
 
-	val = gen_pool_alloc(atomic_pool, size);
+	val = gen_pool_alloc(pool, size);
 	if (val) {
-		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
+		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
 
 		*ret_page = pfn_to_page(__phys_to_pfn(phys));
 		ptr = (void *)val;
@@ -221,9 +237,11 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
+	struct gen_pool *pool = dev_to_pool(dev);
+
 	if (!dma_in_atomic_pool(dev, start, size))
 		return false;
-	gen_pool_free(atomic_pool, (unsigned long)start, size);
+	gen_pool_free(pool, (unsigned long)start, size);
 	return true;
 }
 #endif /* CONFIG_DMA_DIRECT_REMAP */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
