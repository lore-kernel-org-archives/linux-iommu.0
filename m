Return-Path: <SRS0=Rrtl=2Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284ADC2D0DA
	for <iommu@archiver.kernel.org>; Thu, 26 Dec 2019 09:59:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85FD2080D
	for <iommu@archiver.kernel.org>; Thu, 26 Dec 2019 09:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sQKn9VfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85FD2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADA4481F63;
	Thu, 26 Dec 2019 09:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tvy5+uJXSu6X; Thu, 26 Dec 2019 09:59:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0C6B58409C;
	Thu, 26 Dec 2019 09:59:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7A3CC1797;
	Thu, 26 Dec 2019 09:59:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63484C0881
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 09:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5FA448499A
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 09:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L-AY1-19GecA for <iommu@lists.linux-foundation.org>;
 Thu, 26 Dec 2019 09:59:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7B229843E9
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 09:59:46 +0000 (UTC)
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-07.nifty.com
 with ESMTP id xBQ9pdxJ003482
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 18:51:39 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id xBQ9owph023896;
 Thu, 26 Dec 2019 18:50:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com xBQ9owph023896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1577353859;
 bh=NhUagKKjH1a+HNNxh90mRJCDlPp2AH9R9coPb0ehMDo=;
 h=From:To:Cc:Subject:Date:From;
 b=sQKn9VfBXtp3Wxh+M4b0yfgWfx/dlWKr4ftTQnJKm5YVElGOQPbAa5TqibegXpMGI
 molTYuHv+JNa/Kawe+PsWljhzyRbE/fS8souFOI0UCIPwvL4qPGYGjtIAu7wn0jywI
 zUYem3YY0FuMc5NDk4MYRtaVewslii2O7x8HH5XmUYqfi/YGJLbaK3EgGiSmPhu8tb
 IGlpkG3YavBEnrxdn2qfszs89QVjRnuSCjo6EZ6fxhs5D5CI4+WDZfGbKgOK5oDYed
 8uxWd91lcgBgJt3ay12uZl0UQ/tH6AoGFR6n7gO01+Nb1f2ejee7RftuXPt6xqJg4v
 eHf2aL+Nh31tA==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/arm-smmu-v3: fix resource_size check
Date: Thu, 26 Dec 2019 18:50:56 +0900
Message-Id: <20191226095056.30256-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This is an off-by-one mistake.

resource_size() returns res->end - res->start + 1.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d9e0d9c19b4f..b463599559d2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3599,7 +3599,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
+	if (resource_size(res) < arm_smmu_resource_size(smmu)) {
 		dev_err(dev, "MMIO region too small (%pr)\n", res);
 		return -EINVAL;
 	}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
