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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F01C2D0D2
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC7A206B7
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjgIjnGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC7A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 226BD2050E;
	Mon, 23 Dec 2019 18:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lr4Zgic5f6Vu; Mon, 23 Dec 2019 18:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7CDB82050F;
	Mon, 23 Dec 2019 18:59:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A071C1D88;
	Mon, 23 Dec 2019 18:59:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22AFDC0881;
 Mon, 23 Dec 2019 18:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DF59D8528B;
 Mon, 23 Dec 2019 18:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CKKEMdgVlPt7; Mon, 23 Dec 2019 18:59:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D6FD0834E6;
 Mon, 23 Dec 2019 18:59:27 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id a6so6784478plm.3;
 Mon, 23 Dec 2019 10:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bLznaHMy4KKZ0cyTMqudvu5r2Rqk/jELD1oKLNSR2dU=;
 b=RjgIjnGy+JvVdj2w8xB8Td7Jcp/uaEDjiyOG1FJNw7ItOBOMlDiBexx/UkW6dkkAGm
 voY0QC4zCFHaNyKdZbneErqsNlEEsUkH+mUTUEX4IGwRuLutautx5/QiGR7Dg54OfMF4
 Pzd2xf3gtJb7iLRKy3oLhDhaoannVg2g07KyLU/4m8Tg9yffQkks69i7RNV4T7iLy6Dw
 leXWNSpzbps7unh9oz1fwH+msb7iJL7CO2jLuJIISG1WX9/pxpG18Yu7So73y4H8ZtNa
 74d58L/NAst17PBprENwJOgzCuTFMGvNh/uHdQUQxylZpO1+sNfkhBafPyxxAqhwGPS0
 uB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bLznaHMy4KKZ0cyTMqudvu5r2Rqk/jELD1oKLNSR2dU=;
 b=cwGj3Eeth19+pVB/oGbgzfGfbla89DHEqrn/J1p1eQoUwTfhXAWvl++QqvkVyUTo/V
 VWkQlBShwBclrarQSNyqYS90doTxHnI1bHJAmCPFi+7PFtttpWsDqwaq2ke8CX4KnH9n
 zqBy9G0SSSCGS7Zw/DCAFxA/h4C13g3LEwDGbZIWAapyaVVLg/d/VEFBsUDj2xHNR2Az
 Nacm6xZB6DnD2AyQLqCOqRZvnICjwHxqP+G2MP9LbtOV3QRm7HzcqtT9XhthwHwxkixj
 1/ycJwRk3eGJWom1bRAx0VauzXCaOUrHM8ZHjZ7Bxn2kT+1enbD18tHRDzOYdF6Qngkk
 jxaA==
X-Gm-Message-State: APjAAAUlCod1JtQTNkwXptgBY8yhsBKT0gLxVN5Z1MEtxdi94yqP7qw3
 w4L0z+fk39FlLgmABOtSlM4=
X-Google-Smtp-Source: APXvYqwSmasDf38gpvZQ5kYkHfbJ9oeF2AFKtP2Fehgro57BEHYXKQsly+hr8s0/HHHdkDEArOHtIA==
X-Received: by 2002:a17:902:b788:: with SMTP id
 e8mr32700948pls.1.1577127567423; 
 Mon, 23 Dec 2019 10:59:27 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
 by smtp.gmail.com with ESMTPSA id x4sm25703139pff.143.2019.12.23.10.59.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Dec 2019 10:59:26 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: m.szyprowski@samsung.com, joro@8bytes.org, kgene@kernel.org,
 krzk@kernel.org, matthias.bgg@gmail.com, agross@kernel.org,
 bjorn.andersson@linaro.org, robdclark@gmail.com, heiko@sntech.de,
 mst@redhat.com, jasowang@redhat.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 3/6] iommu/qcom: convert to devm_platform_ioremap_resource
Date: Mon, 23 Dec 2019 18:59:15 +0000
Message-Id: <20191223185918.9877-4-tiny.windzz@gmail.com>
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
 drivers/iommu/qcom_iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 52f38292df5b..bf94d4d67da4 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -709,7 +709,6 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 	struct qcom_iommu_ctx *ctx;
 	struct device *dev = &pdev->dev;
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev->parent);
-	struct resource *res;
 	int ret, irq;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
@@ -719,8 +718,7 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 	platform_set_drvdata(pdev, ctx);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctx->base = devm_ioremap_resource(dev, res);
+	ctx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ctx->base))
 		return PTR_ERR(ctx->base);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
