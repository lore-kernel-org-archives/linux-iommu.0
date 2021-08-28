Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94513C43214
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F02604AC
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21F02604AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBFAF606D9;
	Sat, 28 Aug 2021 15:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mekHafBWUOx9; Sat, 28 Aug 2021 15:38:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E235D6065C;
	Sat, 28 Aug 2021 15:38:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF32FC0010;
	Sat, 28 Aug 2021 15:38:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE037C000E
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB85D83B2B
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="GcuCR7By";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="VAraJN/0"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SLWh4xoIVfQu for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 15:38:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48B3E83B28
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:17 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 58FD5580A6E;
 Sat, 28 Aug 2021 11:38:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sat, 28 Aug 2021 11:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=VOZYRWe/dCFEY
 gtDB/y8If80bqsPEhIyIqpzLtzl4Hc=; b=GcuCR7ByuI5yY/6cjLAL1kvR+JGIa
 tuNNUF5/2iRJ/6dVLNsDj7mDEA6zLgvs/32n/DAocnIwuByEUV1QR4lZoTNkxBWA
 C2tk2PLuQMFKO1Borr5iY7Kmybdu1OkWljNmWpcOJ0EQ4XTb6x5aeS48XzOnkmuv
 3x3aeb60b7PyS0QkTYo1z0rw0F6kJqqmCGIdm7c+aiDvlPOFUZ8hh9ihI/kTWp/N
 /Vrs1ybSR9h4RSiJg1M6fAoqs4Ma44jfscjhVWBOqRy7cpES+Ciq8lIEGOAyynoo
 beiO4DuQI+oOtWzhhRwgN6XHcltDOTS3A/4kNyYprA0u0SP20yQNvqscw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=VOZYRWe/dCFEYgtDB/y8If80bqsPEhIyIqpzLtzl4Hc=; b=VAraJN/0
 kAZ6lqfus8PZos9W6yuq4IDYrRIBTsEm21ZG0912AOQH3TZf8djPkgB4w5kkromY
 SxkjONRjzkCCPZ3qeIR/tv7t0r4Dr4pZpJkhTnz75pQmsScdxjVUtg470T6Qr5hJ
 n0Z0UVwPJv64q2gEZ3uYzwKHsGy4Ukj2xU8Xyq93ssV12lrHo0KKrPiKRQuaE4rR
 owwI8VjIG7ewoqp+Gzbjd8eHZ2gGqC+Oag2Ajz3F4sN5lsYjI4wXDnx+hAvuku0p
 BmTxqiMbhVIp7baJ9uEh3A71jzedwvnpzILOJGWUcZ48ZkPTrE1q7b7vbLITwsE5
 iDB7JHDxWWBhvg==
X-ME-Sender: <xms:ZlgqYSrZqdJEW73I6l9NEAnYKs57IduFWobdOL1IM3EMtcCakRaliQ>
 <xme:ZlgqYQpPGzLVYozFO0EXzZXztRXVzBh3aCrahan6pz-WI-SSMmc12tJLGeL6Eshsa
 MbKrKMGOGcXTs-huBQ>
X-ME-Received: <xmr:ZlgqYXP7O1-cMmnzj0vh_xa3lNHfhbEE3bTFcDmuZ570e-WcXgW7WdaRHDn8-SIevG8A6CvAo2uHxu7AtnV0iadxp9sHWUTEsLnoq_nE8jU2Vz_rpNC4bLcUwECARQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:ZlgqYR7OWj0z79LYDIyKDcuMpOm7XHTWvuH_OTdk0-le2rhhaPiHVg>
 <xmx:ZlgqYR57xPj5dQZfkxgqaNa9yChoQfRPysWFtpNodqef-spFFC1C1g>
 <xmx:ZlgqYRj803aVUiLP_ckN4JOAaWP-_YKM0ctegfBcUZJb_XKf5pmRog>
 <xmx:Z1gqYWGyVwx0JpOetdhu1Ap1WpqG_sDdXS4p9OyL4JUjfQQsiY4rBQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:12 -0400 (EDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/8] iommu/dma: Align size for untrusted devs to IOVA
 granule
Date: Sat, 28 Aug 2021 17:36:35 +0200
Message-Id: <20210828153642.19396-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210828153642.19396-1-sven@svenpeter.dev>
References: <20210828153642.19396-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Up until now PAGE_SIZE was always a multiple of iovad->granule
such that adjacent pages were never exposed to untrusted devices
due to allocations done as part of the coherent DMA API.
With PAGE_SIZE < iovad->granule however all these allocations
must also be aligned to iovad->granule.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 40 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d0bc8c06e1a4..e8eae34e9e4f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -735,10 +735,16 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
 		unsigned long attrs)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	struct page **pages;
 	struct sg_table sgt;
 	void *vaddr;
 
+	if (dev_is_untrusted(dev))
+		size = iova_align(iovad, size);
+
 	pages = __iommu_dma_alloc_noncontiguous(dev, size, &sgt, gfp, prot,
 						attrs);
 	if (!pages)
@@ -762,12 +768,18 @@ static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
 		size_t size, enum dma_data_direction dir, gfp_t gfp,
 		unsigned long attrs)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	struct dma_sgt_handle *sh;
 
 	sh = kmalloc(sizeof(*sh), gfp);
 	if (!sh)
 		return NULL;
 
+	if (dev_is_untrusted(dev))
+		size = iova_align(iovad, size);
+
 	sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp,
 						    PAGE_KERNEL, attrs);
 	if (!sh->pages) {
@@ -780,8 +792,15 @@ static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
 static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt, enum dma_data_direction dir)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	struct dma_sgt_handle *sh = sgt_handle(sgt);
 
+
+	if (dev_is_untrusted(dev))
+		size = iova_align(iovad, size);
+
 	__iommu_dma_unmap(dev, sgt->sgl->dma_address, size);
 	__iommu_dma_free_pages(sh->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 	sg_free_table(&sh->sgt);
@@ -1127,10 +1146,17 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 
 static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	size_t alloc_size = PAGE_ALIGN(size);
-	int count = alloc_size >> PAGE_SHIFT;
+	int count;
 	struct page *page = NULL, **pages = NULL;
 
+	if (dev_is_untrusted(dev))
+		alloc_size = iova_align(iovad, alloc_size);
+	count = alloc_size >> PAGE_SHIFT;
+
 	/* Non-coherent atomic allocation? Easy */
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    dma_free_from_pool(dev, cpu_addr, alloc_size))
@@ -1166,12 +1192,18 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 		struct page **pagep, gfp_t gfp, unsigned long attrs)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	bool coherent = dev_is_dma_coherent(dev);
 	size_t alloc_size = PAGE_ALIGN(size);
 	int node = dev_to_node(dev);
 	struct page *page = NULL;
 	void *cpu_addr;
 
+	if (dev_is_untrusted(dev))
+		alloc_size = iova_align(iovad, alloc_size);
+
 	page = dma_alloc_contiguous(dev, alloc_size, gfp);
 	if (!page)
 		page = alloc_pages_node(node, gfp, get_order(alloc_size));
@@ -1203,6 +1235,9 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	struct page *page = NULL;
@@ -1216,6 +1251,9 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 				dma_pgprot(dev, PAGE_KERNEL, attrs), attrs);
 	}
 
+	if (dev_is_untrusted(dev))
+		size = iova_align(iovad, size);
+
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
