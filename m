Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FC9C282DA
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 03:22:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110C020835
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 03:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110C020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A8365CBC;
	Wed, 17 Apr 2019 03:22:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A8590CB8
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 02:40:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EB6016C5
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 02:40:52 +0000 (UTC)
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
	by Forcepoint Email with ESMTPS id F29EDF06712163835CA3;
	Wed, 17 Apr 2019 10:40:49 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
	by mse01.zte.com.cn with ESMTP id x3H2ejda060299;
	Wed, 17 Apr 2019 10:40:45 +0800 (GMT-8)
	(envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
	by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2019041710410560-8909552 ;
	Wed, 17 Apr 2019 10:41:05 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/mediatek: fix leaked of_node references
Date: Wed, 17 Apr 2019 10:41:19 +0800
Message-Id: <1555468879-34684-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
	8.5.3FP6|November 21, 2013) at 2019-04-17 10:41:05,
	Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17,
	2016) at 2019-04-17 10:40:37,
	Serialize complete at 2019-04-17 10:40:37
X-MAIL: mse01.zte.com.cn x3H2ejda060299
X-Mailman-Approved-At: Wed, 17 Apr 2019 03:22:55 +0000
Cc: wang.yi59@zte.com.cn, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Wen Yang <wen.yang99@zte.com.cn>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417024119.5_-vxCh1hNLO15qiiXrJUxYGckqkM1tZmxoIXlM5pZU@z>

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

581 static int mtk_iommu_probe(struct platform_device *pdev)
582 {
    ...
626         for (i = 0; i < larb_nr; i++) {
627                 struct device_node *larbnode;
    ...
631                 larbnode = of_parse_phandle(...);
632                 if (!larbnode)
633                         return -EINVAL;
634
635                 if (!of_device_is_available(larbnode))
636                         continue;             ---> leaked here
637
    ...
643                 if (!plarbdev)
644                         return -EPROBE_DEFER; ---> leaked here
    ...
647                 component_match_add_release(dev, &match, release_of,
648                                             compare_of, larbnode);
                                   ---> release_of will call of_node_put
649         }
    ...
650

Detected by coccinelle with the following warnings:
./drivers/iommu/mtk_iommu.c:644:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 631, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iommu/mtk_iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index de3e022..b66d11b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -632,16 +632,20 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		if (!larbnode)
 			return -EINVAL;
 
-		if (!of_device_is_available(larbnode))
+		if (!of_device_is_available(larbnode)) {
+			of_node_put(larbnode);
 			continue;
+		}
 
 		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
 		if (ret)/* The id is consecutive if there is no this property */
 			id = i;
 
 		plarbdev = of_find_device_by_node(larbnode);
-		if (!plarbdev)
+		if (!plarbdev) {
+			of_node_put(larbnode);
 			return -EPROBE_DEFER;
+		}
 		data->smi_imu.larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, &match, release_of,
-- 
2.9.5

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
