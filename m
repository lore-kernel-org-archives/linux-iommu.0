Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2748C433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:39:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDDC61260
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BDDC61260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75E9B40546;
	Tue, 19 Oct 2021 16:39:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mXVjDkZ_0-ZG; Tue, 19 Oct 2021 16:39:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 292F740561;
	Tue, 19 Oct 2021 16:39:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D66B8C000F;
	Tue, 19 Oct 2021 16:39:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62503C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5084560745
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="Bmoc8dCa";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="nLaaDYZG"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hkRpIALeEbdZ for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 16:38:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E7FF60667
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:58 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id DD7B1580FA5;
 Tue, 19 Oct 2021 12:38:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 19 Oct 2021 12:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=mUxFOhf4FPGG2
 wGC5ii+fwrgIB1PK7ggmQy9Gi+FDDc=; b=Bmoc8dCaGevTZngBfyDKv9gFVU3x5
 4szr37nykRc38nZ/BiXYAjopZsOH2GWQb22Wm+RAn9OAZw6hEt9rZoPAG2HJXWRT
 N18URP30eUAlZTVzSAYYLMKclNxMmArMmpMi7ulFd4qfFg2ZoejMfLW1UWkg5AiX
 5XZEk73zHK0Hv8H+I5gFfsr0TiuarD0O/21Pthm/BbwQIZqIj6iRwAL1A5boOxAu
 3eB5jXb6vedd27+nG4kZKYssDr9CKl9LVQtoWIV11oMpq+zIRhOTii1brAN1/Gp0
 iAkWR0bM9nPioCuyb6gPGLVlYu4aCG2oKjAjmleqiz/ZHNT8cQIobRZHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=mUxFOhf4FPGG2wGC5ii+fwrgIB1PK7ggmQy9Gi+FDDc=; b=nLaaDYZG
 IfDEQ1mQsGdYRxJS8wSes6/Y5ROtxQLResvCXv5qJ14/X4jiZUVc77duxBn0vbl6
 GytzPqo1nvFU+oN5gn5zN0uHdvFD3W9w04kjf6/rJ7pXRV157yNYz0yl3N7ZZp/p
 YIh5Z121W74mxNcNr7+92O61H4Y7qkFoAIEwfmn2O5OxOrIZdc3W82CRSPx/J5n1
 OeJlPxhhsORzsIb0eiCIKM4Y1TaoO7gSVop6onXy8esUuTqOJf+BDRb7HaoFgYhQ
 JZlDCk8kPydUBtUyyQOzaNhu5drV0ytO1SGjPI7Hn4PT9zPDFLbGdfRQiocdJgjc
 pDBvlXYR+c5dCQ==
X-ME-Sender: <xms:ofRuYZ9gcA3St1WGre702N3UPNC6mUo09R3XYnv7ROIXdLBlNER20Q>
 <xme:ofRuYdsZMuzN-smlA7UO4aze64-yNKsOJ_xeLAa2nik84SnR3iCApYVdnabFkZsWR
 dgp5S_q_B8rmc-4UkI>
X-ME-Received: <xmr:ofRuYXAc1Eum-0fuGWasN57ZjusFLsxYq__x5WGQaJQXNU5X5o1W85YLu22zUM28kgf42a4vk2OzrIX-DazMqYsCHA8WoK77fXCDki8w--t5-xI7OLto19E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:ofRuYdcnAHfsHVEcAxKJE8q91g1q9cBOPRuFsQthpOkY040GYzurZA>
 <xmx:ofRuYePkUzdc7s8Kf0NPiTblxc7-5kIC8BCDoVjCFjHiewvf_aCAcA>
 <xmx:ofRuYfkCh0r6IQLNzf_CcQsbZfVxnOr0MZEa_4Du1j7NIQpUL8ypaw>
 <xmx:ofRuYfF1WRtVKzEyLR-e3LPSULpmyCsNMIrmGgD2tIOHiyaxf3tV7g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:56 -0400 (EDT)
To: iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 4/6] iommu: Move IOMMU pagesize check to attach_device
Date: Tue, 19 Oct 2021 18:37:35 +0200
Message-Id: <20211019163737.46269-5-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211019163737.46269-1-sven@svenpeter.dev>
References: <20211019163737.46269-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Will Deacon <will@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

The iova allocator is capable of handling any granularity which is a power
of two. Remove the much stronger condition that the granularity must be
smaller or equal to the CPU page size from a BUG_ON there.
Instead, check this condition during __iommu_attach_device and fail
gracefully.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/iommu.c | 35 ++++++++++++++++++++++++++++++++---
 drivers/iommu/iova.c  |  7 ++++---
 include/linux/iommu.h |  5 +++++
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dd7863e453a5..28896739964b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -80,6 +80,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
+static void __iommu_detach_device(struct iommu_domain *domain,
+				  struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
 static void __iommu_detach_group(struct iommu_domain *domain,
@@ -1974,6 +1976,19 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
+static int iommu_check_page_size(struct iommu_domain *domain)
+{
+	if (!iommu_is_paging_domain(domain))
+		return 0;
+
+	if (!(domain->pgsize_bitmap & (PAGE_SIZE | (PAGE_SIZE - 1)))) {
+		pr_warn("IOMMU pages cannot exactly represent CPU pages.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
@@ -1983,9 +1998,23 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->attach_dev(domain, dev);
-	if (!ret)
-		trace_attach_device_to_domain(dev);
-	return ret;
+	if (ret)
+		return ret;
+
+	/*
+	 * Check that CPU pages can be represented by the IOVA granularity.
+	 * This has to be done after ops->attach_dev since many IOMMU drivers
+	 * only limit domain->pgsize_bitmap after having attached the first
+	 * device.
+	 */
+	ret = iommu_check_page_size(domain);
+	if (ret) {
+		__iommu_detach_device(domain, dev);
+		return ret;
+	}
+
+	trace_attach_device_to_domain(dev);
+	return 0;
 }
 
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9e8bc802ac05..707eb0ceb29f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -50,10 +50,11 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 {
 	/*
 	 * IOVA granularity will normally be equal to the smallest
-	 * supported IOMMU page size; both *must* be capable of
-	 * representing individual CPU pages exactly.
+	 * supported IOMMU page size; while both usually are capable of
+	 * representing individual CPU pages exactly the IOVA allocator
+	 * supports any granularities that are an exact power of two.
 	 */
-	BUG_ON((granule > PAGE_SIZE) || !is_power_of_2(granule));
+	BUG_ON(!is_power_of_2(granule));
 
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d2f3435e7d17..cabd25879613 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -101,6 +101,11 @@ static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
 	return domain->type & __IOMMU_DOMAIN_DMA_API;
 }
 
+static inline bool iommu_is_paging_domain(struct iommu_domain *domain)
+{
+	return domain->type & __IOMMU_DOMAIN_PAGING;
+}
+
 enum iommu_cap {
 	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
 					   transactions */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
