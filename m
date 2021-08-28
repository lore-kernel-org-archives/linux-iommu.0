Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837A7C4320A
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C57060E52
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C57060E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C7BE83E4F;
	Sat, 28 Aug 2021 15:38:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h1Dksq9zvdhg; Sat, 28 Aug 2021 15:38:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3AE2483E6D;
	Sat, 28 Aug 2021 15:38:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15D0EC0010;
	Sat, 28 Aug 2021 15:38:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 952D0C000E
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84504403A8
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="axWy0Gmi";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="jTAIQyL5"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OINk4lJBUl1l for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 15:38:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1031240327
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:31 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 446FB580A77;
 Sat, 28 Aug 2021 11:38:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Sat, 28 Aug 2021 11:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=XZQg+0zFS2CpV
 gEtfLzvy7d7UeLR2l4fefdb0n1QThA=; b=axWy0Gmip4RJeRjzrqOkd0MzACiTI
 kZnXyK3zrM8t4vxgw3h4hsTrZXlqAUNhAJO2Hkdv9Djq6R35gUQ4m6jd5ranXhkz
 Cuf5yPL/yOS2v3tm40xIrWckWlM7b3fn3ZurlACAx7kzSMsMKo/iF+ntbMahGL6E
 aMGe1vVK5Ac+HDcHsrNc/bR74tMMJ5CBkRwReTtp5Ma54x8k52AEWYarQOlt1z8m
 0VVkJLeNY5d1VcAanrhJwp7n0Cqm0TLK/3V0YFij1TqsCh6XD/aNvb5IYWklOBma
 OnHX68j9vrJT/PC/IGN/zdrw+GkF0J2XF9jPPKPp9WDpcULty4YuaMczg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=XZQg+0zFS2CpVgEtfLzvy7d7UeLR2l4fefdb0n1QThA=; b=jTAIQyL5
 j7pOaQ6CnELvdglo37lfTxEgP2Dal7vfoMIYZe5hmk9tHSZxevxrtdfyWGnVk2Bd
 WGcSPKar3iBAoGcBx5wVNgOyLN7P20yqA9uLRBDhxuHnsWoU9GKxBPROIq9rhm3o
 sSQb2bXAGlclO1FPxAspc5o+/KBQVhe9xM8nUe2+IG+LGAeMHX0ASofxsmU9oS1R
 MI5lZq3NFakmfNc2P3A5AHCA8qbo1wFiTaAcUk2c4WvOAWucLUeXPvjLbgnTQiVD
 OgTd/G6toYOVsKnF3Khiq23FSM/XujpttD3JE6HSbI3NVZm5bFk7RH0AJigh2eoL
 mzhngXO3dXErTQ==
X-ME-Sender: <xms:dVgqYYtXnAa5MrKZE5ajeEgZTM8p7VyF7PBWGMFWpngH-FeHA7NFAg>
 <xme:dVgqYVdEUs2GN268wrNHikgXM0wd59UtgtAiorWjiRl0mGDUD_PetqZ4St3lJHlz4
 o17Vhgk7kPsOjrY6RU>
X-ME-Received: <xmr:dVgqYTybAb-WIWYKj4EzEWcbtLDOOxoEy_ySmRf9XpZVrsOEepDm55bKNy3SN9EAkC1c8-9dP4WKm8CkPpCTH-tcca8RrAM6l5d_nHP0535QJ6LaIDt0gHdF_Q46eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgledvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:dVgqYbNsWi0TMuv551B3TDTcK2GV1m34Ttk6SLvzQIzZJbb7nbQzcg>
 <xmx:dVgqYY_ecDgryvmlAQReQ1SnoDIS-TH3_tdjQlvkg5vB5x8u8rqCMA>
 <xmx:dVgqYTXZvR7RcD-cuMWc8b8KR1JD7-k1xbpes1kXLmhKMElMoAhtrg>
 <xmx:dlgqYTYgALfWfnO-lJruAWoDNkJzptd79KlUH_RhkwzTv9qQTKLt1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:28 -0400 (EDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 8/8] iommu/dart: Remove force_bypass logic
Date: Sat, 28 Aug 2021 17:36:42 +0200
Message-Id: <20210828153642.19396-9-sven@svenpeter.dev>
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

Now that the dma-iommu API supports IOMMU granules which are larger than
the CPU page size and that the kernel no longer runs into a BUG_ON when
devices are attached to a domain with such a granule there's no need to
force bypass mode anymore.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 559db9259e65..c37fb4790e8a 100644
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
@@ -506,9 +504,6 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
 
-	if (cfg->stream_maps[0].dart->force_bypass &&
-	    domain->type != IOMMU_DOMAIN_IDENTITY)
-		return -EINVAL;
 	if (!cfg->stream_maps[0].dart->supports_bypass &&
 	    domain->type == IOMMU_DOMAIN_IDENTITY)
 		return -EINVAL;
@@ -638,8 +633,6 @@ static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
 	if (cfg_dart) {
 		if (cfg_dart->supports_bypass != dart->supports_bypass)
 			return -EINVAL;
-		if (cfg_dart->force_bypass != dart->force_bypass)
-			return -EINVAL;
 		if (cfg_dart->pgsize != dart->pgsize)
 			return -EINVAL;
 	}
@@ -713,8 +706,6 @@ static int apple_dart_def_domain_type(struct device *dev)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 
-	if (cfg->stream_maps[0].dart->force_bypass)
-		return IOMMU_DOMAIN_IDENTITY;
 	if (!cfg->stream_maps[0].dart->supports_bypass)
 		return IOMMU_DOMAIN_DMA;
 
@@ -844,7 +835,6 @@ static int apple_dart_probe(struct platform_device *pdev)
 	dart_params[1] = readl(dart->regs + DART_PARAMS2);
 	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
 	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
-	dart->force_bypass = dart->pgsize > PAGE_SIZE;
 
 	ret = request_irq(dart->irq, apple_dart_irq, IRQF_SHARED,
 			  "apple-dart fault handler", dart);
@@ -868,8 +858,8 @@ static int apple_dart_probe(struct platform_device *pdev)
 
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
