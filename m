Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5D6C4320E
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F6E60E78
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29F6E60E78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BFFA606EC;
	Sat, 28 Aug 2021 15:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aGUUXIVzIUek; Sat, 28 Aug 2021 15:38:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 486DA60648;
	Sat, 28 Aug 2021 15:38:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2593EC0010;
	Sat, 28 Aug 2021 15:38:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 133CCC000E
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8F8383E4C
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="rA2AF9SD";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="W/mh6OS+"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ujZd5_nR8MAM for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 15:38:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8CBFE83B2A
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:20 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id C0B68580A6B;
 Sat, 28 Aug 2021 11:38:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sat, 28 Aug 2021 11:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=UYZp9goIX3db+
 451Td4TbHlI8QOyAlCJRHIWbYLh0Pc=; b=rA2AF9SDrVGmgwvvIQ/ymfgLrVxeQ
 j3p0ZFR35MjmK8SpH7uLxjKBpoH4JKOnq/Mq2hI9rCkpKaqf9SExOq4i6uz1OPn7
 YIO8+cW1Yew6yXa5rL2BRToLFy7r9hA8/YUc27LJbqOrFna6xRQNqbMrvlyWRbrW
 GYXO7cPi6UqdsklqFWLG7K/PM76dJiiETa1bS+bEKA7oF+Q573dnAVM4yXkJkLKu
 M+em7l1nlLHZDTT0NJTh/hb3nxH6wrk8nBqaPNXMEl5Cq1PszcR5/LCnSJu99iti
 Aa525AGM7vUOdUe7rSEpUOH1xL4DFFyJGJkG6f+REhCROG4Zmfsitzfzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=UYZp9goIX3db+451Td4TbHlI8QOyAlCJRHIWbYLh0Pc=; b=W/mh6OS+
 xmwG76ds68cQl/CY55NldYEJ0Lrlw2hMyV1uiIVdTilvkA5A9sA3X1hq0JKbwEi/
 LnnCCzWtiUGGBVP9G0vsLkR83huQ0TqcWSTrjDRIpTjkho819lt/GLENODEqlUFm
 /AZMUvlLhwbPDZKe0Tm83HPK00AvSE0g0VFZn43RhjRiIK/LD7SXWGKi/ckIKz6b
 TM4tb4R4s0BfeQ+NaeagiFXXq7BU3XvgtmZ/CPESm5p1M0V8PEam01B2faDhqVrx
 zy/VttZwf1q/Us0eoYLbV+JLfNBbmB/3eecg4hRvHyvAEMd2te+XIAxast2he6t6
 PWmuFNTMfVFCOw==
X-ME-Sender: <xms:a1gqYUO-X6cH76PihY0y8R3ZpHBvXbFvPanhK6HzuIgagDZxqckCPQ>
 <xme:a1gqYa9QbhDCyp0k19l_XSuUNBEnAca-HNg3ECEd_bPEHIc-CcnH-w9OQnQzJJCHN
 GjiRScR_WOBvO5SWQg>
X-ME-Received: <xmr:a1gqYbTsKTZnbLmSuwBY-nUKjoDOZghYadN-ehSLyMRv9xBY-dg9Fz8EZ_QSPpfJnwBOO3_S5EKhd-frlv_p3mwU1la-0JnkBcCdLTrhhvYrDI-6kEbT53L2ogsIZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:a1gqYcvsVk3eJpZ_t5zlteGi8fdLla-2808wXzyewFHEH6zg3QcKUQ>
 <xmx:a1gqYcf4KJgkW5jtkNcc_R4FvcWjma-3M-8MFIAlJxOkJ4mgTXGNCg>
 <xmx:a1gqYQ1TTwOae1ubeMP3DkFcYA4W8BJGQBFc2pYvXcSu5LFULLLHMA>
 <xmx:a1gqYU7W_NlHPYmWCohQz921YdfpvQFDZH4Y1ECnPthq1oesmRtM1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:18 -0400 (EDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 3/8] iommu/dma: Disable get_sgtable for granule > PAGE_SIZE
Date: Sat, 28 Aug 2021 17:36:37 +0200
Message-Id: <20210828153642.19396-4-sven@svenpeter.dev>
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

Pretend that iommu_dma_get_sgtable is not implemented when
granule > PAGE_SIZE since I can neither test this function right now
nor do I fully understand how it is used.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d6e273ec3de6..64fbd9236820 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1315,9 +1315,15 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	struct page *page;
 	int ret;
 
+	if (iovad->granule > PAGE_SIZE)
+		return -ENXIO;
+
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = dma_common_find_pages(cpu_addr);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
