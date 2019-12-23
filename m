Return-Path: <SRS0=R7pc=2N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791ECC2D0D2
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D10C21569
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2OtLypZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D10C21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D62284F69;
	Mon, 23 Dec 2019 18:59:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LS3eBHKRdV7L; Mon, 23 Dec 2019 18:59:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 40E1F8528B;
	Mon, 23 Dec 2019 18:59:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A2ABC1D82;
	Mon, 23 Dec 2019 18:59:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29C4EC0881;
 Mon, 23 Dec 2019 18:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 169D6204FE;
 Mon, 23 Dec 2019 18:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQS2ZaysBSeF; Mon, 23 Dec 2019 18:59:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 5FAB520522;
 Mon, 23 Dec 2019 18:59:32 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id m13so149370pjb.2;
 Mon, 23 Dec 2019 10:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CulQ2ExP6GUQxiub5iNVhoHCStywwXMifBLq7s/S0pk=;
 b=H2OtLypZu26xwRAoHkfmTQ6dLHQpJJ15epMWHv3JdQQs1xiDmnIbBvdX5p8SoP63NR
 rrDwAR1ojV5CKjmV4nursw0hSVhDYhezg4aNZc5/7bKtI/xLNTNVESyeUS1ReQ8QUzXY
 UjlHZSp+USG1XCS3YJhbCo1epwt7/p+HAmwZbHV1DoyKW2mpH2yxt1RhlPTT+H9cqBOw
 AY8x17GodBM0jTcLq3+6EoR945XlFBUaoGwXYyPAfUphbu5u0bI6unawWUIQHMkgTvTe
 PovOlROY679qDH1MfZR1zkp55JOxaXvP4G4yILAA2rFEV19iB/YsqSyFWlKbgPCqziiM
 1imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CulQ2ExP6GUQxiub5iNVhoHCStywwXMifBLq7s/S0pk=;
 b=btKKJz2eEaw31IBUVPJs1YYK8jtJT2Zdr5PrJvED3jHu7Gc6q7iKXkSxhTWnDNd+j+
 BbVxXQfYn0PA8WGyT5Zx4IjGM3AoEl+0cIhoo3GaY1dcMsA7u+eiCXlw5b20LDqZZ+nq
 Uv1ocBt2/lwO00ZeKZZ9GHslET6eBsqUDId0qYRJU0ePKgMoEbRA3mz44w7GCuwCmn7H
 LTn0JxzlKkkZtn7tFEo4VmnUc2XUZDEKPNKAuHZpVUF1KJcgcs42kUPtWt6HNINsk5ZM
 GQnUfrvckR0CellN7Z6m8vv1rmM9JHPzj5Sx3b/NR8FSpXpzU20aAHmPkJN+oyM7Ec2w
 CtlQ==
X-Gm-Message-State: APjAAAUoTiEBqoKZ/HrlfpZoUoVs2lKO2oKDUxZJvXc1Gl6BNWEtWPxX
 pkSLFYbPwL1NN9ZIix6ATuA=
X-Google-Smtp-Source: APXvYqzeiLM4mhrhwEk4S029shHvVfQZIjFYMq3cAbFIsqix9vo2bHpZaR9lUgguOerS7aVYGUejXg==
X-Received: by 2002:a17:902:74c5:: with SMTP id
 f5mr30567441plt.229.1577127572024; 
 Mon, 23 Dec 2019 10:59:32 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
 by smtp.gmail.com with ESMTPSA id a19sm209212pju.11.2019.12.23.10.59.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Dec 2019 10:59:31 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: m.szyprowski@samsung.com, joro@8bytes.org, kgene@kernel.org,
 krzk@kernel.org, matthias.bgg@gmail.com, agross@kernel.org,
 bjorn.andersson@linaro.org, robdclark@gmail.com, heiko@sntech.de,
 mst@redhat.com, jasowang@redhat.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 5/6] iommu/mediatek: convert to devm_platform_ioremap_resource
Date: Mon, 23 Dec 2019 18:59:17 +0000
Message-Id: <20191223185918.9877-6-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223185918.9877-1-tiny.windzz@gmail.com>
References: <20191223185918.9877-1-tiny.windzz@gmail.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iommu/mtk_iommu_v1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index e93b94ecac45..3d6bb08b2a54 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -553,7 +553,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 {
 	struct mtk_iommu_data		*data;
 	struct device			*dev = &pdev->dev;
-	struct resource			*res;
 	struct component_match		*match = NULL;
 	struct of_phandle_args		larb_spec;
 	struct of_phandle_iterator	it;
@@ -573,8 +572,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(dev, res);
+	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
