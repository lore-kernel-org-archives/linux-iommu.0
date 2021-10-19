Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C61DC4332F
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:38:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCD361360
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBCD361360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EAD9606B6;
	Tue, 19 Oct 2021 16:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BTMNW0zoM8jL; Tue, 19 Oct 2021 16:38:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 99157605DD;
	Tue, 19 Oct 2021 16:38:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71BF8C000F;
	Tue, 19 Oct 2021 16:38:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A788C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B0F0830B8
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="Qckc3S1I";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="HNhByT1o"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8onLr9vIBjXo for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 16:38:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE21682D12
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:54 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 06463580FA7;
 Tue, 19 Oct 2021 12:38:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 19 Oct 2021 12:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=K2t/DvVPjAuEc
 abBFkidRQEXkrnP10k3G+xp4Jju30k=; b=Qckc3S1ICYXDedKw5rojS5l69V79n
 ir2oCC9nBcTO25+dNHSJIzXzTHfEA86hADdP2vpXzfJNky6m73bzE5L459bMQYfR
 pD5dlypiWD1El7Il4X3Dzvr3+OC7jPywhZcMxGR4FKBj8otoXFhbpLt7ZiltgHl3
 KRcTlnKFuoI1wwoKKKOmw2ecdtYaqYNuPHECVU30u0V3dWIF9WPNXL8nFR5C4Pjz
 Qpqo8oDDpCQUukG0gD1MdxHFaxzaW55okjDXsQPfaeqED71NK7asjcdZJcuYZHPo
 wZ6b//OB+YesEwdmobHJSNBnbZ71YHsiLlzMvGu1hHZOsdS3X4W72V90A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=K2t/DvVPjAuEcabBFkidRQEXkrnP10k3G+xp4Jju30k=; b=HNhByT1o
 QJZwdx0azEx4sBkS25JeAjznTDNWcQDf2KQsXnsjvz+22mXLMizu1i4Xl5Acu9Od
 REmgaIVBYhUnncZFUFdcjj26Sqi/6KKsXl1qg1yvfBeNoei88rR8H1kffD7UOCSF
 aUcCWd7/NULCbmwZNMx4TFRyFWgk5fEa3azAWRCNoL3XhncqYyNITnAN0IVPNhRe
 yrO55S5oECRtllYYB/95J/O2GKtDW/M23xcs7U8UZcFNReexL4EsVTZolmr6Q+Yn
 LU2HPr34Nm76pFBnxGljsVRSmV7jKu/SL6yVkYaxmJ/XwN9P9GcZxHCerEuHsVY2
 dMbNnyCCksi9Ig==
X-ME-Sender: <xms:nfRuYSqpJD94VLvq-JjC1nUYILHEvPwfvp88HXlecEzfMqHkL4II7A>
 <xme:nfRuYQrfRXla6-MqOxJRvjj9htIobr6bR4RNP8NrObvyeiy4ZHxcJKPa9ZBN9ZWyX
 Hy1OE2agjXwavBED04>
X-ME-Received: <xmr:nfRuYXNLu6konw67nz8hYgl9UkuOWprBTNIEbkwb6-iLbsd_QTJN0vmSe2HYOB29oogh_1HNiMSidOW6l3o-5Kg8WH2tXUtOMUi80sCaTj7XBWiXbj1q4mI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:nfRuYR7ebxcCbu6ulGB_xDaC5ulxnsUGf1o2P484s4VNtLerOmqqeQ>
 <xmx:nfRuYR5LHIDOXroh9SQclW8LHz9U7RMHZ7V_x-alHqtQvHtcdz9izA>
 <xmx:nfRuYRiMF7x-EHG2CDNzupyGXQJml7GdYeYc_5wJGCcnytiWzxqipA>
 <xmx:nvRuYezgw5lMdemCGRpCEkNPUMZksU3ta_AsplCzpyKzm2HZ0m8RZw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:52 -0400 (EDT)
To: iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 2/6] iommu/dma: Support granule > PAGE_SIZE in dma_map_sg
Date: Tue, 19 Oct 2021 18:37:33 +0200
Message-Id: <20211019163737.46269-3-sven@svenpeter.dev>
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

Add support to iommu_dma_map_sg's impedance matching to also align
sg_lists correctly when the IOMMU granule is larger than PAGE_SIZE.

Co-developed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 17f25632a0d6..ea799e70fc98 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/pfn.h>
 #include <linux/pci.h>
 #include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
@@ -878,8 +879,9 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		unsigned int s_length = sg_dma_len(s);
 		unsigned int s_iova_len = s->length;
 
-		s->offset += s_iova_off;
-		s->length = s_length;
+		sg_set_page(s,
+			    pfn_to_page(PHYS_PFN(sg_phys(s) + s_iova_off)),
+			    s_length, s_iova_off & ~PAGE_MASK);
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
@@ -920,13 +922,17 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 static void __invalidate_sg(struct scatterlist *sg, int nents)
 {
 	struct scatterlist *s;
+	phys_addr_t orig_paddr;
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		if (sg_dma_address(s) != DMA_MAPPING_ERROR)
-			s->offset += sg_dma_address(s);
-		if (sg_dma_len(s))
-			s->length = sg_dma_len(s);
+		if (sg_dma_len(s)) {
+			orig_paddr = sg_phys(s) + sg_dma_address(s);
+			sg_set_page(s,
+				    pfn_to_page(PHYS_PFN(orig_paddr)),
+				    sg_dma_len(s),
+				    sg_dma_address(s) & ~PAGE_MASK);
+		}
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 	}
@@ -1003,15 +1009,16 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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
+		sg_set_page(s, pfn_to_page(PHYS_PFN(s_phys - s_iova_off)),
+			    s_length, s->offset & ~s_iova_off);
 
 		/*
 		 * Due to the alignment of our single IOVA allocation, we can
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
