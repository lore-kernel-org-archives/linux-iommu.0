Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69285C433F5
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 11:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25DBD40CC7;
	Wed, 30 Mar 2022 11:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3tfwgzjOqjhP; Wed, 30 Mar 2022 11:48:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A26440320;
	Wed, 30 Mar 2022 11:48:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBB6CC001D;
	Wed, 30 Mar 2022 11:48:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64103C0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61224408E0
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:48:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lMDoCMrivwGY for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 11:48:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4C6740872
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:48:54 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D9AB46162C;
 Wed, 30 Mar 2022 11:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBF7C36AE3;
 Wed, 30 Mar 2022 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648640932;
 bh=Yw9KpInkgsNYhh+OCNup/aC8fKxzxvvo6UbYxOjbCnQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ukJPwQxo66ZQ8HYDWDJCCeoPDTtzB4grXjeDGQUYLE2TMQng7jShzU86DrWGMTBQo
 6hqb9iuf5Fth1gacOxOdT4wUuhEz2bng7dzYhpOsyvpmsHdBfJn81dT4AszgFNbqWc
 ilV5myNX8phBu9YmQhdHJ6mYj11QhhZOiEjKvPICmvKRR6XHDwdesHLw/AxRCSHDaK
 OG7Q9Ip4vSIoMVsVFZFcFdWUXq/DQ4nGLo7kRPGb2GFmv/dZGT7X5KYUo8OwAIDlix
 2aPsGRKbO57zJPUVYYFoxYN9h9mvrXib+krXpO5eWgH1vv67kN1wYa4+kDbponjjbm
 psm8u8608l4cA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 12/59] media: iommu/mediatek: Return ENODEV if
 the device is NULL
Date: Wed, 30 Mar 2022 07:47:44 -0400
Message-Id: <20220330114831.1670235-12-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330114831.1670235-1-sashal@kernel.org>
References: <20220330114831.1670235-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 matthias.bgg@gmail.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

From: Yong Wu <yong.wu@mediatek.com>

[ Upstream commit 2fb0feed51085db77606de9b9477c96894328809 ]

The platform device is created at:
of_platform_default_populate_init:  arch_initcall_sync
  ->of_platform_populate
        ->of_platform_device_create_pdata

When entering our probe, all the devices should be already created.
if it is null, means NODEV. Currently we don't get the fail case.
It's a minor fix, no need add fixes tags.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu.c    | 2 +-
 drivers/iommu/mtk_iommu_v1.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 25b834104790..77ae20ff9b35 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -848,7 +848,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		plarbdev = of_find_device_by_node(larbnode);
 		if (!plarbdev) {
 			of_node_put(larbnode);
-			return -EPROBE_DEFER;
+			return -ENODEV;
 		}
 		data->larb_imu[id].dev = &plarbdev->dev;
 
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 1467ba1e4417..68bf02f87cfd 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -604,7 +604,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		plarbdev = of_find_device_by_node(larbnode);
 		if (!plarbdev) {
 			of_node_put(larbnode);
-			return -EPROBE_DEFER;
+			return -ENODEV;
 		}
 		data->larb_imu[i].dev = &plarbdev->dev;
 
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
