Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B61C48BCD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 08:33:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389AC61359
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 08:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389AC61359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF6FB40477;
	Wed,  9 Jun 2021 08:33:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LbGZ5OrGlBOY; Wed,  9 Jun 2021 08:33:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 805F2402C4;
	Wed,  9 Jun 2021 08:33:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0893CC000B;
	Wed,  9 Jun 2021 08:33:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29B9DC000D
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3A60402BC
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6Yt0CHDDzTd for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:33:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89C19402B2
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:33:08 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G0Kyd1RGHz6vjQ;
 Wed,  9 Jun 2021 16:29:13 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 16:33:04 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 16:33:04 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Yong Wu <yong.wu@mediatek.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 "Chen-Yu Tsai" <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 iommu <iommu@lists.linux-foundation.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, linux-mediatek
 <linux-mediatek@lists.infradead.org>, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Subject: [PATCH v3 0/2] iommu: Fix spelling mistakes
Date: Wed, 9 Jun 2021 16:32:49 +0800
Message-ID: <20210609083251.13827-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
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

v2 --> v3:
1) Add some new fixes for the latest linux-next:
   drivers/iommu/fsl_pamu_domain.c:366: Traverese ==> Traverse
   drivers/iommu/mtk_iommu.c:977: Uppon ==> Upon
   drivers/iommu/intel/svm.c:488: shuld ==> should
   drivers/iommu/intel/svm.c:920: requeset ==> request
   drivers/iommu/intel/dmar.c:2131: Specifiction ==> Specification
2) Add a new fix "Additionally, The ==> Additionally, the", discovered by Will Deacon
3) Add some new fixes for the header files of iommu/iova
   The header files to be checked are as follows:
   include/linux/iommu*.h
   include/linux/iova.h
   include/uapi/linux/iommu.h
4) Changes to files "iova.h" and "iova.c" are grouped into a new patch.


v1 --> v2:
1. Merge into one patch
2. Add a new fix "appropriatley --> appropriately" in iommu.c, discovered by John Garry

Zhen Lei (2):
  iommu/iova: Fix spelling mistakes
  iommu: Fix spelling mistakes

 drivers/iommu/amd/amd_iommu_types.h   |  2 +-
 drivers/iommu/amd/init.c              |  2 +-
 drivers/iommu/amd/iommu.c             |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c |  2 +-
 drivers/iommu/fsl_pamu.c              |  2 +-
 drivers/iommu/fsl_pamu_domain.c       |  2 +-
 drivers/iommu/intel/dmar.c            |  8 ++++----
 drivers/iommu/intel/iommu.c           |  2 +-
 drivers/iommu/intel/irq_remapping.c   |  2 +-
 drivers/iommu/intel/svm.c             |  4 ++--
 drivers/iommu/iommu.c                 |  6 +++---
 drivers/iommu/iova.c                  |  2 +-
 drivers/iommu/mtk_iommu.c             |  4 ++--
 drivers/iommu/omap-iommu.c            |  2 +-
 drivers/iommu/sun50i-iommu.c          |  2 +-
 include/linux/iova.h                  | 10 +++++-----
 16 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.25.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
