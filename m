Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A01C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 07:09:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849CB20789
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 07:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kgmFvkEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849CB20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4064886792;
	Wed, 30 Sep 2020 07:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZrxM-Uaz+x0; Wed, 30 Sep 2020 07:09:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C62B78683F;
	Wed, 30 Sep 2020 07:09:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2F78C0889;
	Wed, 30 Sep 2020 07:09:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0C4AC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EC46A86847
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lg7UNAeSMwmg for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 07:09:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2F6588683F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:09:55 +0000 (UTC)
X-UUID: 5b2a7115b4464f6aaf4a0f2605758e6f-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=MFAon3GhNDukKivbaCYhme9yuORluMflbyHTCeqY9+E=; 
 b=kgmFvkEPNz0rb9jCSnONjuy0houoewZ5TwPWrVjQsp3Wy7dbErJZFEr/dmdYNvZCKzpvG2tWW/s7ElP9rjDe4soKlP3dOv3YxvifdB9ey5Kb3Pn4fmVoDbOxW/KZ55R5w6Mf+vaNT4cFxB2zPyDe554aYJl/WXr57E26Lrb61MU=;
X-UUID: 5b2a7115b4464f6aaf4a0f2605758e6f-20200930
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1759492625; Wed, 30 Sep 2020 15:09:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:09:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:09:50 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH v3 14/24] iommu/mediatek: Add pm runtime callback
Date: Wed, 30 Sep 2020 15:06:37 +0800
Message-ID: <20200930070647.10188-15-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, kernel-team@android.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Greg Kroah-Hartman <gregkh@google.com>, linux-arm-kernel@lists.infradead.org
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

This patch adds pm runtime callback.

In pm runtime case, all the registers backup/restore and bclk are
controlled in the pm_runtime callback, then pm_suspend is not needed in
this case.

runtime PM is disabled when suspend, thus we call
pm_runtime_status_suspended instead of pm_runtime_suspended.

And, m4u doesn't have its special pm runtime domain in previous SoC, in
this case dev->power.runtime_status is RPM_SUSPENDED defaultly, thus add
a "dev->pm_domain" checking for the SoC that has pm runtime domain.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5625458b21ba..052eb72acf69 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -770,7 +770,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused mtk_iommu_suspend(struct device *dev)
+static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
@@ -788,7 +788,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mtk_iommu_resume(struct device *dev)
+static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
@@ -815,7 +815,25 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused mtk_iommu_suspend(struct device *dev)
+{
+	/* runtime PM is disabled when suspend in pm_runtime case. */
+	if (dev->pm_domain && pm_runtime_status_suspended(dev))
+		return 0;
+
+	return mtk_iommu_runtime_suspend(dev);
+}
+
+static int __maybe_unused mtk_iommu_resume(struct device *dev)
+{
+	if (dev->pm_domain && pm_runtime_status_suspended(dev))
+		return 0;
+
+	return mtk_iommu_runtime_resume(dev);
+}
+
 static const struct dev_pm_ops mtk_iommu_pm_ops = {
+	SET_RUNTIME_PM_OPS(mtk_iommu_runtime_suspend, mtk_iommu_runtime_resume, NULL)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
 };
 
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
