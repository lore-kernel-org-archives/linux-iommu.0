Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96DFC433C1
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 06:25:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A72761A43
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 06:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A72761A43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BA1584BA0;
	Fri, 26 Mar 2021 06:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1uATtcdKRGQ; Fri, 26 Mar 2021 06:25:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B72884183;
	Fri, 26 Mar 2021 06:25:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17993C000E;
	Fri, 26 Mar 2021 06:25:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0B17C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD3F0606E2
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id idYRKLPg8mMW for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 06:25:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CA2B6067A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:38 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6Bjc15hyzNqS0;
 Fri, 26 Mar 2021 14:23:00 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:25:27 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel" <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Yong Wu <yong.wu@mediatek.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, linux-mediatek
 <linux-mediatek@lists.infradead.org>, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@siol.net>,
 "David Woodhouse" <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/8] iommu/pamu: fix a couple of spelling mistakes
Date: Fri, 26 Mar 2021 14:24:05 +0800
Message-ID: <20210326062412.1262-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210326062412.1262-1-thunder.leizhen@huawei.com>
References: <20210326062412.1262-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
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

There are several spelling mistakes, as follows:
Returs  ==> Returns
defaul ==> default
assocaited ==> associated

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/fsl_pamu.c        | 2 +-
 drivers/iommu/fsl_pamu_domain.c | 2 +-
 drivers/iommu/fsl_pamu_domain.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index b9a974d9783113d..48ebbf0daa21cf9 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -503,7 +503,7 @@ void get_ome_index(u32 *omi_index, struct device *dev)
  * @stash_dest_hint: L1, L2 or L3
  * @vcpu: vpcu target for a particular cache type.
  *
- * Returs stash on success or ~(u32)0 on failure.
+ * Returns stash on success or ~(u32)0 on failure.
  *
  */
 u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index b2110767caf49c8..be664cd18c51970 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -418,7 +418,7 @@ static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
 		pr_debug("dma_domain allocation failed\n");
 		return NULL;
 	}
-	/* defaul geometry 64 GB i.e. maximum system address */
+	/* default geometry 64 GB i.e. maximum system address */
 	dma_domain->iommu_domain. geometry.aperture_start = 0;
 	dma_domain->iommu_domain.geometry.aperture_end = (1ULL << 36) - 1;
 	dma_domain->iommu_domain.geometry.force_aperture = true;
diff --git a/drivers/iommu/fsl_pamu_domain.h b/drivers/iommu/fsl_pamu_domain.h
index 2865d42782e8021..4f508fa041080e3 100644
--- a/drivers/iommu/fsl_pamu_domain.h
+++ b/drivers/iommu/fsl_pamu_domain.h
@@ -24,7 +24,7 @@ struct fsl_dma_domain {
 	 */
 	dma_addr_t			geom_size;
 	/*
-	 * Number of windows assocaited with this domain.
+	 * Number of windows associated with this domain.
 	 * During domain initialization, it is set to the
 	 * the maximum number of subwindows allowed for a LIODN.
 	 * Minimum value for this is 1 indicating a single PAMU
-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
