Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4DEC433F7
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 17:09:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8261E20792
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 17:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVVHKM1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8261E20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61C2888550;
	Tue, 28 Jul 2020 17:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FPcITdkzzLhT; Tue, 28 Jul 2020 17:09:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA16B8851D;
	Tue, 28 Jul 2020 17:09:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF5A8C0050;
	Tue, 28 Jul 2020 17:09:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6B9DC004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 17:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CFD8E88538
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 17:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rAsXYSCgfkNC for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 17:09:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6DE3F8851D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 17:09:07 +0000 (UTC)
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D79B220792;
 Tue, 28 Jul 2020 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595956147;
 bh=VAI8WP8+wW4qJ9tQCB41NOf7v1n5wUijWbIgNFmDwXo=;
 h=From:To:Cc:Subject:Date:From;
 b=BVVHKM1hkuYqzDbdJY7kVXUv0ivAY/LK1Dv96e+cQ+PqTB7JE8fjQP0QgWeTqV8Ye
 yfUgaaDqu/cJ5WTGUXX9j4p3Ux++RApP4b3XtVy93aOP5Sr6phKNzmJwr1lIhyz1Xw
 LflB5f5oj03w3YvssSPJ5y1jV1y4FETmM78HYmPA=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Rob Clark <robdclark@gmail.com>,
 Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/3] iommu: amd: Fix kerneldoc
Date: Tue, 28 Jul 2020 19:08:57 +0200
Message-Id: <20200728170859.28143-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Cc: Krzysztof Kozlowski <krzk@kernel.org>
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
index 958050c213f9..4a37169b1b1b 100644
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
