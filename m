Return-Path: <SRS0=IIdK=A5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9535EC433E6
	for <iommu@archiver.kernel.org>; Sat, 18 Jul 2020 19:35:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C37F2080D
	for <iommu@archiver.kernel.org>; Sat, 18 Jul 2020 19:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="M9rbBpaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C37F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 403D087848;
	Sat, 18 Jul 2020 19:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMLwA1nM28Wd; Sat, 18 Jul 2020 19:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 72ADD87804;
	Sat, 18 Jul 2020 19:35:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CBCAC0865;
	Sat, 18 Jul 2020 19:35:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0144C0733
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jul 2020 19:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CF13E860FE
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jul 2020 19:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhwZ9gRwaONy for <iommu@lists.linux-foundation.org>;
 Sat, 18 Jul 2020 19:35:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 49C95860F2
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jul 2020 19:35:12 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f134e7a0002>; Sat, 18 Jul 2020 12:33:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Sat, 18 Jul 2020 12:35:11 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Sat, 18 Jul 2020 12:35:11 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 18 Jul
 2020 19:35:08 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Sat, 18 Jul 2020 19:35:07 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
 rnnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5f134eea0000>; Sat, 18 Jul 2020 12:35:07 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <robh+dt@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>
Subject: [PATCH v11 1/5] iommu/arm-smmu: move TLB timeout and spin count macros
Date: Sat, 18 Jul 2020 12:34:53 -0700
Message-ID: <20200718193457.30046-2-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718193457.30046-1-vdumpa@nvidia.com>
References: <20200718193457.30046-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1595100794; bh=qPS2Zde0PkvVJILigsJkjD3Do3jtE9kFjxO2xm+rwAI=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=M9rbBpaEoRYm8EV2DiOWt9d9YwENtbZkmGs//oEHYoU9c3iNQWLAiBE/CFo9Vah1Y
 emZRVNQgaIK85moYVKKQvBdpF2k/UzMnIAC5BasTCSm5HiZml0a6bIrBRjIQGSAiqZ
 5z820WELHgI9Jr2fl97Xr17mSqhR+JuaN8HDkHXrKxNGTsdEySXdyqf+LvYXb/cZdS
 1Y5xOdmrI3hGOg+q1Gr8EXPIEE0E3wWj7ncfGWEvK3QOwUgBjPZ3naufiUg//rZEsU
 WLfk1F+qewRrE0w/ckH4XOqcQqd5WdWsjnORQE8J3EnyJSxYAdsbAhM+0HUS79mowU
 eAo2tCpALigUA==
Cc: snikam@nvidia.com, devicetree@vger.kernel.org, mperttunen@nvidia.com,
 bhuntsman@nvidia.com, yhsu@nvidia.com, linux-kernel@vger.kernel.org,
 talho@nvidia.com, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, praithatha@nvidia.com,
 linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Move TLB timeout and spin count macros to header file to
allow using the same from vendor specific implementations.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Pritesh Raithatha <praithatha@nvidia.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 3 ---
 drivers/iommu/arm-smmu.h | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 19f906de6420..cdd15ead9bc4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -52,9 +52,6 @@
  */
 #define QCOM_DUMMY_VAL -1
 
-#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
-#define TLB_SPIN_COUNT			10
-
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index d172c024be61..c7d0122a7c6c 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -236,6 +236,8 @@ enum arm_smmu_cbar_type {
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
 
+#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
+#define TLB_SPIN_COUNT			10
 
 /* Shared driver definitions */
 enum arm_smmu_arch_version {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
