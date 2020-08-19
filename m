Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F7BC433DF
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A4F207DE
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr++aJx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A4F207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61CEB87D7F;
	Wed, 19 Aug 2020 17:54:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IIlOw4VfL1zU; Wed, 19 Aug 2020 17:54:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DF0E287D11;
	Wed, 19 Aug 2020 17:54:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC04FC0889;
	Wed, 19 Aug 2020 17:54:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AFD4C0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 395FB875D1
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bu3Jnx34AdHo for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 17:54:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BDF9587456
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:54:01 +0000 (UTC)
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6510E20882;
 Wed, 19 Aug 2020 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597859641;
 bh=xQWEIIlwVSrNVIwqxQa97UJ/2LYi1t/KDj5ZfXkSnIM=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Kr++aJx5I/+vnkogrZnmW2Zx+reR+cV0sFSv6uwfYVcPtNuxeqeiCfwoXinQvA5oJ
 EgTrvKHu2z5bIzR4nQUzQQsiT7WGnfZIrAFG6tPJpDHv2oXtZCkn+6Z0yICnIqj3ee
 d2DXfOpa0P2ZYiHK1Qea/WBOabUPysyPM3FivzGs=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [RESEND PATCH 3/5] iommu: amd: Fix kerneldoc
Date: Wed, 19 Aug 2020 19:53:43 +0200
Message-Id: <20200819175345.20833-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819175345.20833-1-krzk@kernel.org>
References: <20200819175345.20833-1-krzk@kernel.org>
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

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/iommu/amd/init.c:1586: warning: Function parameter or member 'ivrs' not described in 'get_highest_supported_ivhd_type'
    drivers/iommu/amd/init.c:1938: warning: Function parameter or member 'iommu' not described in 'iommu_update_intcapxt'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c652f16eb702..908d8e89764c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1578,7 +1578,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 /**
  * get_highest_supported_ivhd_type - Look up the appropriate IVHD type
- * @ivrs          Pointer to the IVRS header
+ * @ivrs: Pointer to the IVRS header
  *
  * This function search through all IVDB of the maximum supported IVHD
  */
@@ -1929,7 +1929,7 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 #define XT_INT_VEC(x)		(((x) & 0xFFULL) << 32)
 #define XT_INT_DEST_HI(x)	((((x) >> 24) & 0xFFULL) << 56)
 
-/**
+/*
  * Setup the IntCapXT registers with interrupt routing information
  * based on the PCI MSI capability block registers, accessed via
  * MMIO MSI address low/hi and MSI data registers.
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
