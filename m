Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0B3C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 06:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03FD5605A0;
	Mon, 14 Feb 2022 06:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sah3_IdIk0n8; Mon, 14 Feb 2022 06:10:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D94DF60B9C;
	Mon, 14 Feb 2022 06:10:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B370FC0011;
	Mon, 14 Feb 2022 06:10:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04B35C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0181260B9C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:10:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MNfc7r_wUxAM for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:10:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43C72605A0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:10:27 +0000 (UTC)
X-UUID: 862b7b1f808d4b5a84f85ecfb3e4bcde-20220214
X-UUID: 862b7b1f808d4b5a84f85ecfb3e4bcde-20220214
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 853127056; Mon, 14 Feb 2022 14:10:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 14 Feb 2022 14:10:21 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:10:19 +0800
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Airlie
 <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH 09/23] drm/msm: Make use of the helper component_compare_of
Date: Mon, 14 Feb 2022 14:08:05 +0800
Message-ID: <20220214060819.7334-10-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220214060819.7334-1-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 James Wang <james.qian.wang@arm.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 srv_heupstream@mediatek.com, Stephen
 Boyd <sboyd@kernel.org>, freedreno@lists.freedesktop.org,
 Sebastian Reichel <sre@kernel.org>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Use the common compare helper from component.

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ad35a5d94053..50e5a6ff6487 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1173,15 +1173,6 @@ static const struct dev_pm_ops msm_pm_ops = {
  * Componentized driver support:
  */
 
-/*
- * NOTE: duplication of the same code as exynos or imx (or probably any other).
- * so probably some room for some helpers
- */
-static int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 /*
  * Identify what components need to be added by parsing what remote-endpoints
  * our MDP output ports are connected to. In the case of LVDS on MDP4, there
@@ -1239,7 +1230,7 @@ static int add_components_mdp(struct device *mdp_dev,
 
 		if (of_device_is_available(intf))
 			drm_of_component_match_add(master_dev, matchptr,
-						   compare_of, intf);
+						   component_compare_of, intf);
 
 		of_node_put(intf);
 	}
@@ -1285,7 +1276,7 @@ static int add_display_components(struct platform_device *pdev,
 		put_device(mdp_dev);
 
 		/* add the MDP component itself */
-		drm_of_component_match_add(dev, matchptr, compare_of,
+		drm_of_component_match_add(dev, matchptr, component_compare_of,
 					   mdp_dev->of_node);
 		break;
 	case KMS_MDP4:
@@ -1324,7 +1315,7 @@ static int add_gpu_components(struct device *dev,
 		return 0;
 
 	if (of_device_is_available(np))
-		drm_of_component_match_add(dev, matchptr, compare_of, np);
+		drm_of_component_match_add(dev, matchptr, component_compare_of, np);
 
 	of_node_put(np);
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
