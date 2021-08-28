Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C931C432BE
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5347F60524
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5347F60524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 361A4402C6;
	Sat, 28 Aug 2021 15:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Brm9vFhDr5zn; Sat, 28 Aug 2021 15:38:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 71EB240161;
	Sat, 28 Aug 2021 15:38:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AB26C0010;
	Sat, 28 Aug 2021 15:38:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 305D9C001F
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F27F14022F
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="PFErue+N";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="s04JViXx"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZX8qP6ARrTY2 for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 15:38:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65DD9401B0
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:22 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9842A580A70;
 Sat, 28 Aug 2021 11:38:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Sat, 28 Aug 2021 11:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=PwFP4HxzvK7Rc
 gD49PhDeopMka3fjX2dpZ9I2SZ3weU=; b=PFErue+NMN/w4km2ChFvzfPySAnh0
 FBKLGJBUIN3AN6tHZXztsT3wcGs1byVNHn3jXe79yHaIQnB79awWuH0EA+6+KeyS
 U6Bcu3n+fVXIzOwrYXI22JJwSmxMBEuYX9xM76tWN0zs2+gjoWBt/xeOZyTCIpUF
 ivVcGHuXfAWYHF4OiqfGS9n73U3YUdjc+Ftyx8XKHiEuYGXeltSL8i38U45osa0z
 rVgFG+tFDEWq0nkpCrc7sinsLIl7gDwbgLSLCSJsVKg7+FOwZ0w6bGClwcNxrP84
 1Qo7UX7i5vGG7CU8JSK78B9lb2XoG8u49h2R+koSOq38+lbp31317Qkhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=PwFP4HxzvK7RcgD49PhDeopMka3fjX2dpZ9I2SZ3weU=; b=s04JViXx
 /FbAdZ6nCpHBnbia4qXypuoKF9fliCl5/YhXhg2oSV36ZOfsZR7AcID/XqKlXKJK
 zz8W6rIsFbcUfRRVCkjEwfJNthF9SzF0ZP+XYkoASJjM5szdCBfI6EDKy83uisnf
 6ds5BEsVl4A6wUeV8USEsFZv9wj5qhnfZdGEjJeoniBr8V7G7UHoP7CWUiYUpPDS
 YzCrwhnj6w8fa1yj9p+3mTjRmXcuH62YQh2Wm4BnBvcM2+KXwvyYR8Wndzj8mhY+
 Ma9+A4aDf3HaZRO9liimSfG2jGEAtjHVSerzjemxYiqTaj2zFKsuhFKHPTLyiOQ1
 wkWHmu38lWaL6w==
X-ME-Sender: <xms:bVgqYQFEG5G9OICsXZ_g_3WHR6wlcZkoKEHL5IRjIllzNBC5v9lh0Q>
 <xme:bVgqYZX2lh6IgJhKlYQv-W8ScJJ16jdXkYJJaXyb1kto1it34mOHy_zYYFO2UBrj7
 acGaOyuyL2c3GZqe88>
X-ME-Received: <xmr:bVgqYaIzjSb81IkDOorJTGtpLOeRyb6A1J8CjRC2UqpxzhWvCQAqi-hjceGRh45Bxw-QfNuOww0AE5rZFwbnjH4w1GU7NDJH1hheFQJDj8KDDxNncxFeWceLsPQcTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:bVgqYSH0vaDpgPtTALhF3ztwtbYF4id_clj6GoVvfC6W8qGNEtx7yQ>
 <xmx:bVgqYWVc5gLn0dUoPt0yQObgpOxH4zPyyWEQFRyYVab4Tox8i5_yPg>
 <xmx:bVgqYVOxGneOov6SmST3PCisbBkj-INZVB_aaxND20-cuTnEkQNBqA>
 <xmx:bVgqYSRfLGhCnUOafyBKTr_Ixb7NYZbSFwBXYH67ZSQclmrzlVOsrQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:19 -0400 (EDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 4/8] iommu/dma: Support granule > PAGE_SIZE in dma_map_sg
Date: Sat, 28 Aug 2021 17:36:38 +0200
Message-Id: <20210828153642.19396-5-sven@svenpeter.dev>
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

Add support to iommu_dma_map_sg's impedance matching to also align
sg_lists correctly when the IOMMU granule is larger than PAGE_SIZE.

Co-developed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 64fbd9236820..a091cff5829d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -932,8 +932,8 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		unsigned int s_length = sg_dma_len(s);
 		unsigned int s_iova_len = s->length;
 
-		s->offset += s_iova_off;
-		s->length = s_length;
+		sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
+			    s_iova_off & ~PAGE_MASK);
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
@@ -977,10 +977,11 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		if (sg_dma_address(s) != DMA_MAPPING_ERROR)
-			s->offset += sg_dma_address(s);
 		if (sg_dma_len(s))
-			s->length = sg_dma_len(s);
+			sg_set_page(s,
+				    phys_to_page(sg_phys(s) + sg_dma_address(s)),
+				    sg_dma_len(s),
+				    sg_dma_address(s) & ~PAGE_MASK);
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 	}
@@ -1056,15 +1057,16 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	 * stashing the unaligned parts in the as-yet-unused DMA fields.
 	 */
 	for_each_sg(sg, s, nents, i) {
-		size_t s_iova_off = iova_offset(iovad, s->offset);
+		phys_addr_t s_phys = sg_phys(s);
+		size_t s_iova_off = iova_offset(iovad, s_phys);
 		size_t s_length = s->length;
 		size_t pad_len = (mask - iova_len + 1) & mask;
 
 		sg_dma_address(s) = s_iova_off;
 		sg_dma_len(s) = s_length;
-		s->offset -= s_iova_off;
 		s_length = iova_align(iovad, s_length + s_iova_off);
-		s->length = s_length;
+		sg_set_page(s, phys_to_page(s_phys - s_iova_off),
+			    s_length, s->offset & ~s_iova_off);
 
 		/*
 		 * Due to the alignment of our single IOVA allocation, we can
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
