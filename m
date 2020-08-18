Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB0C433E3
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 23:41:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A65420786
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 23:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A65420786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D9893207A4;
	Tue, 18 Aug 2020 23:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m9s-gGAVar9l; Tue, 18 Aug 2020 23:41:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B8EB220770;
	Tue, 18 Aug 2020 23:41:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FFABC07FF;
	Tue, 18 Aug 2020 23:41:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 134E8C0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 23:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 02C6520781
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 23:41:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1iNpnhnMexQl for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 23:41:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by silver.osuosl.org (Postfix) with ESMTPS id 72F0D20770
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 23:41:24 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6E44E13EDB51EF48A31A;
 Wed, 19 Aug 2020 07:41:20 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.140) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 07:41:14 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
Subject: [PATCH v4 1/3] iommu/arm-smmu-v3: replace symbolic permissions by
 octal permissions for module parameter
Date: Wed, 19 Aug 2020 11:38:25 +1200
Message-ID: <20200818233827.21452-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200818233827.21452-1-song.bao.hua@hisilicon.com>
References: <20200818233827.21452-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.203.140]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 prime.zeng@hisilicon.com, linuxarm@huawei.com
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

This fixed the below checkpatch issue:
WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using
octal permissions '0444'.
417: FILE: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:417:
module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);

-v4:
   * cleanup the existing module parameter of bypass_
   * add ARM_SMMU_OPT_MSIPOLL flag with respect to Robin's comments

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7196207be7ea..eea5f7c6d9ab 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -414,7 +414,7 @@
 #define MSI_IOVA_LENGTH			0x100000
 
 static bool disable_bypass = 1;
-module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
+module_param_named(disable_bypass, disable_bypass, bool, 0444);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
-- 
2.27.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
