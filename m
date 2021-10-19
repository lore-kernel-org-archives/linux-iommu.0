Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2050C433FE
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:38:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AE061057
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96AE061057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA432400CB;
	Tue, 19 Oct 2021 16:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yTRE96Nr8PhG; Tue, 19 Oct 2021 16:38:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5A17A402A8;
	Tue, 19 Oct 2021 16:38:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35663C000F;
	Tue, 19 Oct 2021 16:38:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EDF5C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F9A282D12
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="L+91XSFh";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="VTQGR+iT"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xsMnaIYirOmy for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 16:38:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E496880DF4
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:52 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 05A18580FA6;
 Tue, 19 Oct 2021 12:38:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 19 Oct 2021 12:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=Pc6itoB43a0du
 3xvsVw42627DuQ30enUuCWOyiMqqSk=; b=L+91XSFhczFWo9O4veNnaBiEmWsUL
 TIY7sVbTSXSARX6kBsxtBuWxF6B7sTIHfhnzXtGt+95k4FJgXIqaIdj7waQ86DjK
 PU23fziM1DA4vo6jiP9/pmNtkIpcFidMX8gH4awMq7qThX11Oxtq/UBGsxYC2ibq
 Hn2+WtGcxRNnbdsJLnCKctxQntEeLVhQMrb/dHb+rnwyETemj2KXp3C3Mxo9XEjA
 W11voY7D3Q1zpvvF2T3e6CU7FH7F6StQp83eSqn8/kdvo0JXjIMx/juq2+sckcHq
 Bu21/gk7+JQM4upkzAeXeCB/dvtRDFrUVSHQVqqlZegriCySN+z1kEcMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=Pc6itoB43a0du3xvsVw42627DuQ30enUuCWOyiMqqSk=; b=VTQGR+iT
 jz0nEwmJRe86D50NysZi1Py/A2/Qqf76VxPuSuQNqaBg9vDkfCdcOJOwlxaobSZw
 NmR+CIeD64nGs8AhJ6RCeS71SvL+mIFek8V65qbpCqmtemUd23yYUsO24yRLWA8O
 xYsXPvXdzDq+2YUsp+5vhKPnc7K6Pq0GkFTuW47OTc5TCJ9151adSOXT5rktuL3Y
 2lhdjSzJdcHP1RuduDc9+AbFnEF404wLjeQoXxmoXPcx846Z4XsrIB+9eTY2NyWB
 zl404sti2Au34AbpSvRppY1vguvn01D39RBZ60EF9OFQfD8aOp5fDf1Rbgx0Uhww
 FO4NKb6iarmy+A==
X-ME-Sender: <xms:m_RuYa5LmM56YxwspPu-nuwpsJLhv-iYMkHGtlwSA35A07M7LKgkXQ>
 <xme:m_RuYT6pNLuIhbQBjwF7DwngdLgRgLFcV7qOBG_XU1BUAqqaHGwHAYvKoDn3ugUXa
 oHEw9nkNf7_67rbVQ8>
X-ME-Received: <xmr:m_RuYZcbAsaOr5HSxiD5CagXMj09XCMNk9Ra5oUgN5EQnuqrTLnh0FZwg9-te-ndXFGA7TO1N-kMDZ46oIOlNc6xm0aHUBUkSUJ04O17TBBxQFEqchnfjLU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:m_RuYXLVxtlew9ypWl4Z8lLd-CHeuWEW_B-XHJ_4gEo_vrvB0a4nzA>
 <xmx:m_RuYeIRyTo4BCZJ4G0UFA4BAah3pCneBNOTlwiqW3pNMBg-8I7SDQ>
 <xmx:m_RuYYxF7KbPJEtuRrN_ylaVOvMJ1g9UEI_aGOLvwo6vVxMeLc5bkw>
 <xmx:nPRuYbDg_-nzMUC48vIKaP_fjEh498bhKxglwMpOxhqTR-YVq78h7w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:50 -0400 (EDT)
To: iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 1/6] iommu/dma: Disable get_sgtable for granule > PAGE_SIZE
Date: Tue, 19 Oct 2021 18:37:32 +0200
Message-Id: <20211019163737.46269-2-sven@svenpeter.dev>
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

While this function *probably* works correctly without any changes for
granule > PAGE_SIZE I don't have any code to actually test it and cannot
reason about how the function is supposed to work.
Disable it instead until we run into a use case where it's required.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index de5040b65529..17f25632a0d6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1249,9 +1249,15 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
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
