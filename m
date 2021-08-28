Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AEAC432BE
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D74A60E77
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D74A60E77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02B81402C6;
	Sat, 28 Aug 2021 15:38:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PV19HNqmdSwa; Sat, 28 Aug 2021 15:38:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0DE7040161;
	Sat, 28 Aug 2021 15:38:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E82DCC0010;
	Sat, 28 Aug 2021 15:38:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A0CDC000E
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37A3E40105
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9IzspBzxSZ4b for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 15:38:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1A8D42750
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:18 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id ECEF7580A77;
 Sat, 28 Aug 2021 11:38:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sat, 28 Aug 2021 11:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=D4PCd0JOhWxqQ
 0FHLtGzqrwB4RN73vh1ozYKHe2Vr6c=; b=rp/coHPSJpRsYRFZEpxdqPJWHVy1/
 XP9fwqWZkTA8puZ+wweuwWDcMD67nLgqnPSHJCIU9HbeplW1+CFC3vJC4ylxReTq
 pGaCDh2vbyxbGMPn6Ypq7LDPFmOIEg5m2V1ozmjMgzprAyIlgflFoqqyEPOu9iDy
 yXNiPgA7x9MaaN+9ErygG1PfLAZb3gaphcZSh72f09ujk6WWHCrZH9vMkOJON/YC
 deWzL+nzhPh9/drASa48mKmF1AbhTXEXAPMCsOpTB2NAuwYYLy+miV+SUYT4tL7p
 4anGIrlSdzZbEH/oRU/YmGz7t+/NdHX0xwVZKt2Hcys98kqJ77AWMIrmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=D4PCd0JOhWxqQ0FHLtGzqrwB4RN73vh1ozYKHe2Vr6c=; b=Qln4h02r
 1mZd5/ji4lV6ubnGH9nj1q/ACldcUehel8GJW/hLWalmYvgJ5kNCy7lLfMBLY3mm
 BII5kQpsvlRJcSECkXQrBTNHDK52ENw5BnzU/O6RdkgK7mKgH56p0iJqsNyhQMTd
 nsiqvnzhXMd6zww7OefKdMKLuwP9cynksTGGU2ze69TEnlH4Q5QugSZj3val11/k
 AqRMVmjsAuxTTxXMVy16Y7UHiPa0YZz19AF2VNtBO42hK3TL6bU0DALSLnaZrR+C
 7DNvcKokMZVnoez4zz94gTEcVeot+0BOEqotY0zRAMNYKeDAPgGHnu5mztkBkU+S
 qLW68lDpKaYngA==
X-ME-Sender: <xms:aFgqYaN54exDeEWwPDDEhtgbSLcuhElr4yWCxE8N-nNcH4VVtMjG4Q>
 <xme:aFgqYY9YgzOICuV-7sF6H9eeK-5_stAPt94x2pqiZT7AK4JXP3yhmj0mGbF7GhamD
 s9yxQ2W4Y2ejcTLvTg>
X-ME-Received: <xmr:aFgqYRSHsY2Q0sTbjGABPgnF_YRscfGNJc5IL24JVLuaj5wujUUQV-G1bBfWGAqyrM6CNJnYf17Kh9-mqkqrUDLFrC204MSZjx5FelbNNkChk5-Eb0waSSC9d5Zjtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:aFgqYavnRfdZAWJi3gj1b8ZzyXLzjPS-L1Cp1X4QYYBYe1ktEmkANQ>
 <xmx:aFgqYScKzy49E_g5Z5KJdzYCuhH0z4DuszYUJumYsp4rQk3A7Ban7w>
 <xmx:aFgqYe34IKB52NzVpJH4x8dVxXzcPtIQ8KgRrV3OYkFpoDGJ11Srfg>
 <xmx:aVgqYS5JIIsMO3NHrU_7qWnBqT-AZ36xXmwBrFTJZH2khQLLZJDkVw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:15 -0400 (EDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/8] iommu/dma: Fail unaligned map requests for untrusted
 devs
Date: Sat, 28 Aug 2021 17:36:36 +0200
Message-Id: <20210828153642.19396-3-sven@svenpeter.dev>
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

If swiotlb is enabled we should never try to create any mappings that
would expose more memory than requested to the device.
WARN_ON and refuse those mappings just in case.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e8eae34e9e4f..d6e273ec3de6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -534,13 +534,20 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_off = iova_offset(iovad, phys);
+	size_t size_aligned = iova_align(iovad, size + iova_off);
 	dma_addr_t iova;
 
 	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
 	    iommu_deferred_attach(dev, domain))
 		return DMA_MAPPING_ERROR;
 
-	size = iova_align(iovad, size + iova_off);
+	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev)) {
+		if (WARN_ON(iova_off))
+			return DMA_MAPPING_ERROR;
+		if (WARN_ON(size_aligned != size))
+			return DMA_MAPPING_ERROR;
+	}
+	size = size_aligned;
 
 	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
 	if (!iova)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
