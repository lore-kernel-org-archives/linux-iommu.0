Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCAFC433B4
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 03:54:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D47961431
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 03:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D47961431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7166404C6;
	Mon, 10 May 2021 03:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rXoq2mH8EaMD; Mon, 10 May 2021 03:54:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA6804018C;
	Mon, 10 May 2021 03:54:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73849C000D;
	Mon, 10 May 2021 03:54:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD556C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 03:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3BAB83BED
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 03:54:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NweiYSM3_48z for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 03:54:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 712F683BD9
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 03:54:51 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FdnCz3bNXzQlQn;
 Mon, 10 May 2021 11:51:27 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 11:54:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Yong Wu <yong.wu@mediatek.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 "Chen-Yu Tsai" <wens@csie.org>, Jernej Skrabec <jernej.skrabec@siol.net>,
 iommu <iommu@lists.linux-foundation.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, linux-mediatek
 <linux-mediatek@lists.infradead.org>, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Subject: [PATCH v2 0/1] iommu: Clear a lot of spelling mistakes
Date: Mon, 10 May 2021 11:54:24 +0800
Message-ID: <20210510035425.3212-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.72]
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

v1 --> v2:
1. Merge into one patch
2. Add a new fix "appropriatley --> appropriately" in iommu.c, discovered by John Garry

Zhen Lei (1):
  iommu: Clear a lot of spelling mistakes

 drivers/iommu/amd/amd_iommu_types.h   | 2 +-
 drivers/iommu/amd/init.c              | 2 +-
 drivers/iommu/amd/iommu.c             | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 drivers/iommu/fsl_pamu.c              | 2 +-
 drivers/iommu/intel/dmar.c            | 6 +++---
 drivers/iommu/intel/iommu.c           | 2 +-
 drivers/iommu/intel/irq_remapping.c   | 2 +-
 drivers/iommu/iommu.c                 | 6 +++---
 drivers/iommu/iova.c                  | 2 +-
 drivers/iommu/mtk_iommu.c             | 2 +-
 drivers/iommu/omap-iommu.c            | 2 +-
 drivers/iommu/sun50i-iommu.c          | 2 +-
 13 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.26.0.106.g9fadedd


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
