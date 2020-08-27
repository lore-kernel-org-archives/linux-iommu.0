Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025DCC433E3
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 09:33:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42D020738
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 09:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42D020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AEBDF85137;
	Thu, 27 Aug 2020 09:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aPIwONAVp-a5; Thu, 27 Aug 2020 09:33:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9C9D18554A;
	Thu, 27 Aug 2020 09:33:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 874ABC016F;
	Thu, 27 Aug 2020 09:33:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F71DC0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 09:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 09D8687722
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 09:33:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p5Izh9V5aFCh for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 09:33:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 691A686D81
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 09:33:04 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 81143E9A77B2D15133A9;
 Thu, 27 Aug 2020 17:32:59 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.71) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 27 Aug 2020 17:32:50 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <iommu@lists.linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 2/3] iommu/arm-smmu-v3: replace module_param_named by
 module_param for disable_bypass
Date: Thu, 27 Aug 2020 21:29:56 +1200
Message-ID: <20200827092957.22500-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200827092957.22500-1-song.bao.hua@hisilicon.com>
References: <20200827092957.22500-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.200.71]
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, will@kernel.org
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

Just use module_param() - going out of the way to specify a "different"
name that's identical to the variable name is silly.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v5: add Robin's reviewed-by

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index eea5f7c6d9ab..5b40d535a7c8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -414,7 +414,7 @@
 #define MSI_IOVA_LENGTH			0x100000
 
 static bool disable_bypass = 1;
-module_param_named(disable_bypass, disable_bypass, bool, 0444);
+module_param(disable_bypass, bool, 0444);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
-- 
2.27.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
