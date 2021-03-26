Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E541C433C1
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 06:25:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC4E61A3F
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 06:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC4E61A3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 547BB414D1;
	Fri, 26 Mar 2021 06:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1SWRa4aSr4xH; Fri, 26 Mar 2021 06:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C5C34035F;
	Fri, 26 Mar 2021 06:25:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D46D0C000F;
	Fri, 26 Mar 2021 06:25:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 803F0C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BA1184183
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tnxY_Zb6Yh0e for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 06:25:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8F1983E9F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:36 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6Bjc0gCrzNqRh;
 Fri, 26 Mar 2021 14:23:00 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:25:26 +0800
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
Subject: [PATCH 0/8] iommu: fix a couple of spelling mistakes detected by
 codespell tool
Date: Fri, 26 Mar 2021 14:24:04 +0800
Message-ID: <20210326062412.1262-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
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

This detection and correction covers the entire driver/iommu directory.

Zhen Lei (8):
  iommu/pamu: fix a couple of spelling mistakes
  iommu/omap: Fix spelling mistake "alignement" -> "alignment"
  iommu/mediatek: Fix spelling mistake "phyiscal" -> "physical"
  iommu/sun50i: Fix spelling mistake "consits" -> "consists"
  iommu: fix a couple of spelling mistakes
  iommu/amd: fix a couple of spelling mistakes
  iommu/arm-smmu: Fix spelling mistake "initally" -> "initially"
  iommu/vt-d: fix a couple of spelling mistakes

 drivers/iommu/amd/amd_iommu_types.h   | 2 +-
 drivers/iommu/amd/init.c              | 4 ++--
 drivers/iommu/amd/iommu.c             | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 drivers/iommu/fsl_pamu.c              | 2 +-
 drivers/iommu/fsl_pamu_domain.c       | 2 +-
 drivers/iommu/fsl_pamu_domain.h       | 2 +-
 drivers/iommu/intel/dmar.c            | 6 +++---
 drivers/iommu/intel/iommu.c           | 2 +-
 drivers/iommu/intel/irq_remapping.c   | 2 +-
 drivers/iommu/iommu.c                 | 4 ++--
 drivers/iommu/iova.c                  | 2 +-
 drivers/iommu/mtk_iommu.c             | 2 +-
 drivers/iommu/omap-iommu.c            | 2 +-
 drivers/iommu/sun50i-iommu.c          | 2 +-
 15 files changed, 19 insertions(+), 19 deletions(-)

-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
