Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A3DC433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:39:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CAC61057
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2CAC61057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA9C640794;
	Tue, 19 Oct 2021 16:39:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rGL8UQD5APpe; Tue, 19 Oct 2021 16:39:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79BE040747;
	Tue, 19 Oct 2021 16:39:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5755DC000F;
	Tue, 19 Oct 2021 16:39:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB957C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B91CF606B6
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="hUMMPcmo";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="ULZxfFz4"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eDPQvGyGvSge for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 16:39:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24EBB60667
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:39:03 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailnew.nyi.internal (Postfix) with ESMTP id 63B23580FA5;
 Tue, 19 Oct 2021 12:39:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 19 Oct 2021 12:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=K/Q+kXswZ8pNa
 mY2+chOmBmfbuOVgms4J6hIOAdKNjc=; b=hUMMPcmoBJTFgc11T1yAGEgHBGexy
 0MngiwF/KS5UtO6O81W0rYDabqXmXgefUSoPeYn/ERnGdivrfS95eDZfjQfR/iAl
 5AxUiGnR0Wt7Yj7Fyxa6c1ducO0heshTrvtx0YgL8EVEBI4jJHk0fQ8UilKa+cMc
 1HDmpR2XB8WbD+vtKkl7FgFVHzItpcBXy6aZogpkk6Ic0/fS8uf4qDhT3f1FzbEO
 dNOAHexhUbkfOjMFPkY6Mjvd84qBoLJrHVymkT+lJXmF04qHxs0kP+HpKhnA0KXw
 ray6mSebrZrJ+ShgjurvSX3lk6+/netyoKJCLwRtvdX5UcHmZtiUehM+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=K/Q+kXswZ8pNamY2+chOmBmfbuOVgms4J6hIOAdKNjc=; b=ULZxfFz4
 lFeA3KQAcWwvvOS1SMMl3THt+AqJDSzEC9Ob91T278HMm+BkmM0bMBd7XtGt3+1K
 ZGDzGbgiWP+YFEPK4tS0Ia/na/mpa2pxAjnu/dm/TOgoTD3UmjeZlXC517EkO6Yd
 +XuJdIpEMMtF2H51nkAYnr7p+Xx42WWiLi0OKQNrCVHuE4yShWWLSeZyB3KwM7Y4
 JDTdArfdr5GiJNHayFJ7SkZ5ibCCk9DOzmThCW6rLRSVk0G3/Bwk+IbtnAHAYROI
 DZpMhw40WveaymNEtnDDPn8XNlBTvWBIWnAAXv8SzcqMIfN2Th/t+nK0mMvUzE2V
 7IIwPLnGk36jwQ==
X-ME-Sender: <xms:pfRuYXBeZweuYxZvs8IG7GzijaqO1kFRUrUM6zDkb0ujnCrLlk7wuA>
 <xme:pfRuYdjxEX0xx4tXK3Xgcbjnh3nq3dZJxzskgC8EP2WDVmGIO6mEv61RxGpQXw_7k
 cqfbfmfAy-bM74biq0>
X-ME-Received: <xmr:pfRuYSlhbJrRLqjrzhVKVE6mSTDvtY_XzuiqWChTVH6lcHiNCcXF-ONvCn8gYhnAZzYq860qlZI_GlhzDVWIGXEIS93vaplVE75V0LP85o8jfdL13-DZqG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:pfRuYZygH4RRgMJhBugBPmH1_WNAyCRLBayP2MQot6fm5RHmmCvong>
 <xmx:pfRuYcRO1z_lKpbFC2G4llTxkUbWksQHfLqRLUue5GVq6jVo8hGQsw>
 <xmx:pfRuYcY9B7UKVXhNLTrcpaDf1HhMWV8ESfV4IBGK4qN18UpzdIKycQ>
 <xmx:pvRuYRIaf6Uy7AJ9e_LQlv4aRYR2i7b4kuDHtl2RckQnBjXnGHoPjg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:59 -0400 (EDT)
To: iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 6/6] iommu/dart: Remove force_bypass logic
Date: Tue, 19 Oct 2021 18:37:37 +0200
Message-Id: <20211019163737.46269-7-sven@svenpeter.dev>
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

Now that the dma-iommu API supports IOMMU granules which are larger than
the CPU page size and that the kernel no longer runs into a BUG_ON when
devices are attached to a domain with such a granule there's no need to
force bypass mode anymore.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 280ff8df728d..ce92195db638 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -90,7 +90,6 @@
  * @lock: lock for hardware operations involving this dart
  * @pgsize: pagesize supported by this DART
  * @supports_bypass: indicates if this DART supports bypass mode
- * @force_bypass: force bypass mode due to pagesize mismatch?
  * @sid2group: maps stream ids to iommu_groups
  * @iommu: iommu core device
  */
@@ -107,7 +106,6 @@ struct apple_dart {
 
 	u32 pgsize;
 	u32 supports_bypass : 1;
-	u32 force_bypass : 1;
 
 	struct iommu_group *sid2group[DART_MAX_STREAMS];
 	struct iommu_device iommu;
@@ -488,9 +486,6 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
 
-	if (cfg->stream_maps[0].dart->force_bypass &&
-	    domain->type != IOMMU_DOMAIN_IDENTITY)
-		return -EINVAL;
 	if (!cfg->stream_maps[0].dart->supports_bypass &&
 	    domain->type == IOMMU_DOMAIN_IDENTITY)
 		return -EINVAL;
@@ -619,8 +614,6 @@ static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
 	if (cfg_dart) {
 		if (cfg_dart->supports_bypass != dart->supports_bypass)
 			return -EINVAL;
-		if (cfg_dart->force_bypass != dart->force_bypass)
-			return -EINVAL;
 		if (cfg_dart->pgsize != dart->pgsize)
 			return -EINVAL;
 	}
@@ -726,8 +719,6 @@ static int apple_dart_def_domain_type(struct device *dev)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 
-	if (cfg->stream_maps[0].dart->force_bypass)
-		return IOMMU_DOMAIN_IDENTITY;
 	if (!cfg->stream_maps[0].dart->supports_bypass)
 		return IOMMU_DOMAIN_DMA;
 
@@ -884,7 +875,6 @@ static int apple_dart_probe(struct platform_device *pdev)
 	dart_params[1] = readl(dart->regs + DART_PARAMS2);
 	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
 	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
-	dart->force_bypass = dart->pgsize > PAGE_SIZE;
 
 	ret = request_irq(dart->irq, apple_dart_irq, IRQF_SHARED,
 			  "apple-dart fault handler", dart);
@@ -908,8 +898,8 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 	dev_info(
 		&pdev->dev,
-		"DART [pagesize %x, bypass support: %d, bypass forced: %d] initialized\n",
-		dart->pgsize, dart->supports_bypass, dart->force_bypass);
+		"DART [pagesize %x, bypass support: %d] initialized\n",
+		dart->pgsize, dart->supports_bypass);
 	return 0;
 
 err_sysfs_remove:
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
