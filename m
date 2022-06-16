Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F79ECCA47A
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 11:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51E8761109;
	Thu, 16 Jun 2022 11:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cDf9AO7e8lRt; Thu, 16 Jun 2022 11:08:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2AFE261138;
	Thu, 16 Jun 2022 11:08:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38F39C0088;
	Thu, 16 Jun 2022 11:08:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F98CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 11:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0324405A7
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 11:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ipWfTass32eU for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 11:08:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16F5040590
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 11:08:44 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id BB0C66601756;
 Thu, 16 Jun 2022 12:08:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1655377723;
 bh=Ym8V4C7cqusZmnKUp44mYzfUNnjhU5hnhfnX8Zm9pqA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NmtPN0WvcM9Ve1t1pov1LUxFbiFgFsHXn7r1U0/dBzpD2ev+nNt/AsBREsxoLTnvg
 1MXrkjTKKJ2o3BdglJrC/B/r0wtT7q/Bd1JOTv4SG0kt9axG22fWfGU61cHQUDFq8G
 sGjjCszu4KJdE/J7JzQ5U7AP45Msq8+2TkLltrtmxCq2CPMnRIMMDCGxZZhvAIbgFL
 wusIWrO6ZpaBFJOSF6Du39eqV3BaWwFAPhGtE3zlRKZHppx0Qy2rh6BvZ+aXB+DvyO
 0NXS43OHcFjvEcxekxmHDZwzuA/EpVcnhbEyBSPSDcEnjVvkMn9TpG8mtQelh9vn0T
 svphRSs2SqIIg==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Subject: [PATCH v4 5/5] iommu/mediatek: Cleanup pericfg lookup flow
Date: Thu, 16 Jun 2022 13:08:30 +0200
Message-Id: <20220616110830.26037-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, miles.chen@mediatek.com,
 matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org,
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

Since only the INFRA type IOMMU needs to modify register(s) in the
pericfg iospace, it's safe to drop the pericfg_comp_str NULL check;
also, directly assign the regmap handle to data->pericfg instead of
to the infracfg variable to improve code readability.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 90685946fcbe..b2ae84046249 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1217,15 +1217,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			dev_err(dev, "mm dts parse fail(%d).", ret);
 			goto out_runtime_disable;
 		}
-	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
-		   data->plat_data->pericfg_comp_str) {
-		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
-		if (IS_ERR(infracfg)) {
-			ret = PTR_ERR(infracfg);
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
+		p = data->plat_data->pericfg_comp_str;
+		data->pericfg = syscon_regmap_lookup_by_compatible(p);
+		if (IS_ERR(data->pericfg)) {
+			ret = PTR_ERR(data->pericfg);
 			goto out_runtime_disable;
 		}
-
-		data->pericfg = infracfg;
 	}
 
 	platform_set_drvdata(pdev, data);
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
