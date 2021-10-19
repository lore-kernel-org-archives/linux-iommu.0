Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5012C433F5
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:39:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB3061260
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FB3061260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5241660667;
	Tue, 19 Oct 2021 16:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ewut6IHgElve; Tue, 19 Oct 2021 16:39:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2986860723;
	Tue, 19 Oct 2021 16:39:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 145AEC000F;
	Tue, 19 Oct 2021 16:39:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4277EC000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3289183403
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:39:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="UAH0Uejp";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="QPcnXBkz"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5IFh7fzBKEdD for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 16:39:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91CE683A4C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:39:00 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id CCA83580FAA;
 Tue, 19 Oct 2021 12:38:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 19 Oct 2021 12:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=a1UTEBM3qu37a
 dXN3TtDd2bHBFc6ZdJD1PMfOV0rBTc=; b=UAH0UejpxJNl4iCrusIzo7Dn9FluB
 e1+UFVdT5oSv1qGWHBdm9Bg4YnWXbDXWdefp4n6elrkicbxO4YVTGGBgt4tNirOc
 rday3uXRmpG7FzYUgNfETlQozJpmSBKyPpiHySyGuLE+mbpaautdMJue4I5DtEZ2
 qJnVsX6QBPUXNHGbi1yOoLhl11L41DJAomSJg75pIA9JlzDUxtZZtj0m6atbVkqV
 QcPBgmWCwQMaGGoYjdHN8fWBvu4P7kRm8xjNphPMOXc4DlAUlhbonRpyqNxXjw0G
 zCsBmU5UAe7/D26YZ63z4FZfJYLzaAja+WE5zOjyfFNxjfffVk3OXKqlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=a1UTEBM3qu37adXN3TtDd2bHBFc6ZdJD1PMfOV0rBTc=; b=QPcnXBkz
 drq90m+57PEPe33fnaqAftQCsD2eSGwpSEAIvgmoER3Cnkloz7rTWm5L4cO+/cjQ
 0yxlKShZxJIvH0KQ04n9XCnuhHTKJJIenvp+zkSugmN0v5bi2+qtgNS/0JnMAsft
 hb1ONrM+Z24sElChIl+2eIP0Jy5x6bqaPA5djv5ifR8kfUvD9aoCIb1GFM04zx0l
 aRTDtGLtSq0NyXUZWA9ohkQW9S8R+fz2WsSLbMyc6CTOrgBcPTSYhHCba5tJxIJa
 jCdRouo3aCMOu1x+NNvSa3YncbpdUP4HDpqxUXYa52zDzTS/j+zDw12BezqYz+Rf
 RGMO5buStwn1Tw==
X-ME-Sender: <xms:o_RuYe9gvls68I_eZ-KqELpREqkwxAtlrgnj6gv06povvNNWYH7IeQ>
 <xme:o_RuYesbcAESiGDwa46uXAyzZEO1M8dH4R8tYYAXtvdwM6yiTo72MLlSq3kcVEEcX
 2gH6fdLpZE1DI0ub6E>
X-ME-Received: <xmr:o_RuYUBd1dM6jYUifrUHUOva7o-H07KwY1EYAUg4uXAQlYG0VV_dyF0kznCWP02ObTZngWSuLbUK_ykpAckYxY4e6v6JvSS27IUsegM1ry-zGH_M870GN3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:o_RuYWegg5_FsC_xtJRvR8lXReC6QJuZ-p_l92_5uLHeDQPFOSRzJA>
 <xmx:o_RuYTOaX5oiSQl-_TQ1VqE7TNBtSzEc4OPWXY3NNLxCzIKDY6duiw>
 <xmx:o_RuYQkWKYH0ptvgGo-vp5OnvDQvVWYG71yMAQ0I7prszdmDBj4AiQ>
 <xmx:o_RuYUEf_YBJUAr-KNa0jN4vW5usDQpApW7rzqZA_VqnAmBMArnMMA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:58 -0400 (EDT)
To: iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 5/6] iommu: Introduce __IOMMU_DOMAIN_LP
Date: Tue, 19 Oct 2021 18:37:36 +0200
Message-Id: <20211019163737.46269-6-sven@svenpeter.dev>
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

__IOMMU_DOMAIN_LP (large pages) indicates that a domain can handle
conditions where PAGE_SIZE might be smaller than the IOMMU page size.
Always allow attaching trusted devices to such domains and set the flag for
IOMMU_DOMAIN_DMA, which can now handle these situations.

Note that untrusted devices are not yet supported. Those require
additional changes to allow aligning swiotlb buffers to granularities
larger than PAGE_SIZE.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/iommu.c |  9 +++++++--
 include/linux/iommu.h | 13 +++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 28896739964b..66bba6a6bb28 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1976,10 +1976,15 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
-static int iommu_check_page_size(struct iommu_domain *domain)
+static int iommu_check_page_size(struct iommu_domain *domain,
+				struct device *dev)
 {
+	bool trusted = !(dev_is_pci(dev) && to_pci_dev(dev)->untrusted);
+
 	if (!iommu_is_paging_domain(domain))
 		return 0;
+	if (iommu_is_large_pages_domain(domain) && trusted)
+		return 0;
 
 	if (!(domain->pgsize_bitmap & (PAGE_SIZE | (PAGE_SIZE - 1)))) {
 		pr_warn("IOMMU pages cannot exactly represent CPU pages.\n");
@@ -2007,7 +2012,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	 * only limit domain->pgsize_bitmap after having attached the first
 	 * device.
 	 */
-	ret = iommu_check_page_size(domain);
+	ret = iommu_check_page_size(domain, dev);
 	if (ret) {
 		__iommu_detach_device(domain, dev);
 		return ret;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cabd25879613..1f1af59d0522 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -62,6 +62,8 @@ struct iommu_domain_geometry {
 					      implementation              */
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
+#define __IOMMU_DOMAIN_LP	(1U << 4)  /* Support for PAGE_SIZE smaller
+					      than IOMMU page size        */
 
 /*
  * This are the possible domain-types
@@ -81,10 +83,12 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
 #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
-				 __IOMMU_DOMAIN_DMA_API)
+				 __IOMMU_DOMAIN_DMA_API |       \
+				 __IOMMU_DOMAIN_LP)
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
-				 __IOMMU_DOMAIN_DMA_FQ)
+				 __IOMMU_DOMAIN_DMA_FQ |        \
+				 __IOMMU_DOMAIN_LP)
 
 struct iommu_domain {
 	unsigned type;
@@ -106,6 +110,11 @@ static inline bool iommu_is_paging_domain(struct iommu_domain *domain)
 	return domain->type & __IOMMU_DOMAIN_PAGING;
 }
 
+static inline bool iommu_is_large_pages_domain(struct iommu_domain *domain)
+{
+	return domain->type & __IOMMU_DOMAIN_LP;
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
