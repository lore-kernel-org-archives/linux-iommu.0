Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3508EC433EF
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:15:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E073861B71
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E073861B71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B782382400;
	Wed, 17 Nov 2021 21:15:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NyrdvIsbU4JV; Wed, 17 Nov 2021 21:15:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 89DCE823F4;
	Wed, 17 Nov 2021 21:15:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2886CC0037;
	Wed, 17 Nov 2021 21:15:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 304FAC0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E14A400EB
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="F2QEnSh7";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="cNK5VYz0"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mgiQhvbBnATQ for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 21:15:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EF3640452
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:31 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 0D6945806D0;
 Wed, 17 Nov 2021 16:15:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 17 Nov 2021 16:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=wPBXm1hEB0gt3
 4jZTLq7duc5h40FbhA9Yj5in8Tpo00=; b=F2QEnSh7HLLmJz1viZ1cWsA7UicA7
 SX6lcHbylYTro07UIqm4ni5LevGAViojKswXZtIXWTskxfudYwpUJOPdmHGZBSfH
 cl9oVUVaR63S6MzMXJndhY8ZkP36aTJcOVfI7I2Ro3j1I7+L5x3O6mEOaLHkLIK6
 hs+4Kk4JYIWYuupu1CDpnVqUGy1c7VKIQayM+AokxbDeLao9I4QdZj7AKEI/51lm
 UnWXi3AjNkoV2ext3XWHhf5zRNReIeYZAW8VUsktJAm6m5E4dffYFcJlJZNKrs7q
 JUOm15DCgL08/0cF9R2ifFdXGhsVG7KYA/28nAoeeXRtRyX4spJY3TnDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=wPBXm1hEB0gt34jZTLq7duc5h40FbhA9Yj5in8Tpo00=; b=cNK5VYz0
 y3f1fiaPuvaRg193CzV90rdNs4a03fEjmgh7wR4cImrGkxlVPZK9r6Hna1BREClu
 FMRubxTmsD3MuLKfMEvmVgzeQjvcnxG+OhB7zZ7gn0rUYbrSHqEXMDaoh4iv+j7Z
 NIV1MMUWg1Mwws05GG7sj2a1n0/TsUpULvxy+v+dO/BoDH0cGzeYOZCIUqVDX1LW
 8U8BSd6fWPJFi5zbqJ4d+rtfJN6hQoXmuThRTigu0SMaESyzgINl9b9X3Ww0fpTX
 nx44qttS7VWKIREVUJSSJz4nYgu2JNH1D3fSxswgQVke/VqJtwyHbvTGcXPLoRLu
 G7qnGzAWqVAO9Q==
X-ME-Sender: <xms:8XCVYb-8YVgQ_cSB5hPWT2Dktmm2xjfIY6Q-QGTrIbIEumMTDyWZ7g>
 <xme:8XCVYXsTO1sHLIcud8x8k06y9lU_xpSJREtLPMplFJarV3m25fO1tvvpnSmrBFrB8
 AqftYI_PmBGZxBZsr8>
X-ME-Received: <xmr:8XCVYZAlbIJdWooPIjPft6ldGrX8nzBUvW2RRVQeZ1iLkYzFcOEyaH2ZrOJ0t6_jjgjPxI5NKh4eUU-ORgZgFkX19qLKdBilNoyBWtmwDyE7t3JmSi7CWbUSUZsZyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggddugedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:8XCVYXfKbncoClymTnwTiZs_EP05QpukhSSKdPjnw3hwR3dFYzzXmQ>
 <xmx:8XCVYQPjCni0qVGq7qj73mP_RtVafoXj12nNRPiEmY0WjhquJX226Q>
 <xmx:8XCVYZn2QUYJUp1rGSKIQyHY70J0t2FnRRFqMncbXkyBO9Oy7KZNpQ>
 <xmx:8nCVYRE8TB6uAAQSWaaxbnNoLAzLs2W8SlcCX1PXnoKhggW0b_XVAg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 16:15:27 -0500 (EST)
To: iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/4] iommu/io-pgtable: Add DART subpage protection support
Date: Wed, 17 Nov 2021 22:15:07 +0100
Message-Id: <20211117211509.28066-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211117211509.28066-1-sven@svenpeter.dev>
References: <20211117211509.28066-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

DART allows to only expose a subpage to the device. While this is an
optional feature on the M1 DARTs the new ones present on the Pro/Max
models require this field in every PTE.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/io-pgtable-arm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index dd9e47189d0d..a8c660b8b3e9 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
 
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
@@ -133,6 +134,9 @@
 #define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
 #define APPLE_DART_PTE_PROT_NO_READ (1<<8)
 
+#define APPLE_DART_PTE_SUBPAGE_START	GENMASK_ULL(63, 52)
+#define APPLE_DART_PTE_SUBPAGE_END	GENMASK_ULL(51, 40)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -273,6 +277,12 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
+	if (data->iop.fmt == APPLE_DART) {
+		/* subpage protection: always allow access to the entire page */
+		pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_START, 0);
+		pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_END, 0xfff);
+	}
+
 	for (i = 0; i < num_entries; i++)
 		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
