Return-Path: <SRS0=A6MP=2O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B595C2D0CF
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 08:32:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541DA206B7
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 08:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="w1D1o9lL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541DA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F4F8868F7;
	Tue, 24 Dec 2019 08:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HdcLT42wdBvs; Tue, 24 Dec 2019 08:32:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8814B857D6;
	Tue, 24 Dec 2019 08:32:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67487C1D80;
	Tue, 24 Dec 2019 08:32:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6801C0881
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 08:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CCB9C8653F
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 08:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dvAkFfUEki7H for <iommu@lists.linux-foundation.org>;
 Tue, 24 Dec 2019 08:32:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CE6BE857D6
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 08:32:43 +0000 (UTC)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-09.nifty.com
 with ESMTP id xBO8Fj4Z004749
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 17:15:45 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id xBO8F6tO002467;
 Tue, 24 Dec 2019 17:15:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com xBO8F6tO002467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1577175308;
 bh=NbmBvDtMJ9z3Td8I6VubahSRd9ne5gs2UkZ7H3zze/8=;
 h=From:To:Cc:Subject:Date:From;
 b=w1D1o9lLd17YUs9iR6sMAJ70Ko/YIzdjEGoKti9JQCdALk56d5wqxG1STTEJUkUeV
 OvRF13UWwZZf8xS6CXgiOg+/jwFaX01jDqcRYaZegKpO4OalJyND/FAalfnQPVDv2y
 7v5hvfSt6B2jVx2SdXBZ6WSY8dfCN9QcFYrNyG+6SK20UV82gTdius2NerU2XrkCH8
 dDi6g/PE0uyrpptvh/YijOR5bixz6F6b9gVRbHQ3y5Awhsp856QkkWkfWZl+jMtVGP
 hT2nXixKIw+I0oY/lXK0tAZgkn8cwzuD1Ak07HI0atUmHZDT3a/mEkh27vroNROc9Z
 TbrVy0Ofau6Sg==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 1/2] iommu/arm-smmu-v3: remove useless of_match_ptr()
Date: Tue, 24 Dec 2019 17:14:59 +0900
Message-Id: <20191224081500.18628-1-yamada.masahiro@socionext.com>
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

The CONFIG option controlling this driver, ARM_SMMU_V3,
depends on ARM64, which select's OF.

So, CONFIG_OF is always defined when building this driver.
of_match_ptr(arm_smmu_of_match) is the same as arm_smmu_of_match.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index effe72eb89e7..d9e0d9c19b4f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3698,7 +3698,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu-v3",
-		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.of_match_table	= arm_smmu_of_match,
 		.suppress_bind_attrs = true,
 	},
 	.probe	= arm_smmu_device_probe,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
