Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC9BC433F5
	for <iommu@archiver.kernel.org>; Sun,  6 Feb 2022 20:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2DE3440207;
	Sun,  6 Feb 2022 20:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j3x0pSPtddZR; Sun,  6 Feb 2022 20:37:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CA545401D6;
	Sun,  6 Feb 2022 20:37:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BED5C001A;
	Sun,  6 Feb 2022 20:37:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D640C000B
 for <iommu@lists.linux-foundation.org>; Sun,  6 Feb 2022 20:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 822A460ADC
 for <iommu@lists.linux-foundation.org>; Sun,  6 Feb 2022 20:37:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ixit.cz
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Op247g2YzbZM for <iommu@lists.linux-foundation.org>;
 Sun,  6 Feb 2022 20:37:04 +0000 (UTC)
X-Greylist: delayed 00:07:14 by SQLgrey-1.8.0
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38B74607D1
 for <iommu@lists.linux-foundation.org>; Sun,  6 Feb 2022 20:37:04 +0000 (UTC)
Received: from newone.lan (_gateway [10.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id A560320056;
 Sun,  6 Feb 2022 21:29:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1644179386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mJbQE9aLpDKahWvRXxUd+4aTtXVGsiL8uHGSLEVhR0w=;
 b=DiVIEK2kVh9/PD98+QqNQmpY4Ou7lkgRwa2gzTB9TugbXr4CV3NtvDuah7cvYqP+o2o5M+
 GqGz8M9++antjbHwnZgxrdvou8pCCu3n3lhHzixFjSY/xA62awUPiSDEwT4xZJOlGqRPyl
 0Vo7ufwISCVvpe1S7/Wue88q/DfGLII=
From: David Heidelberg <david@ixit.cz>
To: Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/msm: simplify with dev_err_probe()
Date: Sun,  6 Feb 2022 21:29:45 +0100
Message-Id: <20220206202945.465195-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
 linux-kernel@vger.kernel.org
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

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless error is
printed.

Fixes warnings as:
msm_iommu 7500000.iommu: could not get smmu_pclk

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iommu/msm_iommu.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352b603f..6e6cff5fc469 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -710,36 +710,32 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&iommu->ctx_list);
 
 	iommu->pclk = devm_clk_get(iommu->dev, "smmu_pclk");
-	if (IS_ERR(iommu->pclk)) {
-		dev_err(iommu->dev, "could not get smmu_pclk\n");
-		return PTR_ERR(iommu->pclk);
-	}
+	if (IS_ERR(iommu->pclk))
+		return dev_err_probe(iommu->dev, PTR_ERR(iommu->pclk),
+				     "could not get smmu_pclk\n");
 
 	ret = clk_prepare(iommu->pclk);
-	if (ret) {
-		dev_err(iommu->dev, "could not prepare smmu_pclk\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(iommu->dev, ret,
+				     "could not prepare smmu_pclk\n");
 
 	iommu->clk = devm_clk_get(iommu->dev, "iommu_clk");
 	if (IS_ERR(iommu->clk)) {
-		dev_err(iommu->dev, "could not get iommu_clk\n");
 		clk_unprepare(iommu->pclk);
-		return PTR_ERR(iommu->clk);
+		return dev_err_probe(iommu->dev, PTR_ERR(iommu->clk),
+				     "could not get iommu_clk\n");
 	}
 
 	ret = clk_prepare(iommu->clk);
 	if (ret) {
-		dev_err(iommu->dev, "could not prepare iommu_clk\n");
 		clk_unprepare(iommu->pclk);
-		return ret;
+		return dev_err_probe(iommu->dev, ret, "could not prepare iommu_clk\n");
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iommu->base = devm_ioremap_resource(iommu->dev, r);
 	if (IS_ERR(iommu->base)) {
-		dev_err(iommu->dev, "could not get iommu base\n");
-		ret = PTR_ERR(iommu->base);
+		ret = dev_err_probe(iommu->dev, PTR_ERR(iommu->base), "could not get iommu base\n");
 		goto fail;
 	}
 	ioaddr = r->start;
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
