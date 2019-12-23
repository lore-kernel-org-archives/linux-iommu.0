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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B18C2D0D5
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EB2206B7
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIrbocA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EB2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D0AF52050B;
	Mon, 23 Dec 2019 18:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M2-fLBM0eM5u; Mon, 23 Dec 2019 18:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CFEF82051D;
	Mon, 23 Dec 2019 18:59:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE14CC1D82;
	Mon, 23 Dec 2019 18:59:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78936C0881;
 Mon, 23 Dec 2019 18:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 755F385A1E;
 Mon, 23 Dec 2019 18:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZJ22D1f6TLM; Mon, 23 Dec 2019 18:59:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0EAC685778;
 Mon, 23 Dec 2019 18:59:30 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id k3so9248909pgc.3;
 Mon, 23 Dec 2019 10:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yYuhXbk2VYWkJUHqsC8Dp7ziko2oh3QWGKXaw3BKzKQ=;
 b=bIrbocA75GjiXkwSJP3C51ubVyAnSLI/fBMTmh6962W79PT4Tqv+1+Mjw3cq7AGKFU
 jHYIhsxDoH7RHVORa6yJexdhOgetkpm/PkZ6ybiEGu0rEOpFeiagFzU/A8ajKUUkgukz
 3AsjKYBf3/aZo2PMmRXKMgxEkfrblyUVI3V0AYfA5DshVaGFTRxoepTY4p6RKBua5+RC
 hwdBV6ESUTN2NcyHSsnNvmOAqmENn4PYY7sviRlsrgrPKRl79k7z6YX1VvUkJpHwbF8l
 d6ihCxrqxgEDPq21x1NWyz3OWGl9kB/2yiUVsYw2xw4mEWhcBS8hcPRUPF2UdAVwvS+g
 6lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yYuhXbk2VYWkJUHqsC8Dp7ziko2oh3QWGKXaw3BKzKQ=;
 b=hFZS+daRAYLC+a+0dzMAWVkXx9janf0AOG8wi6mpwx9cVqu5BlUCDVQL+8UwwjRmNb
 7fPfg5q3BoZV3mPtcqCnGfrNBZ+7zSDhFpY0KVTFZ7o+80FnCHuov+EVPcFYT4ArJyk8
 oKnExP5haW6DKEIsKwb6So+OicIqyFnz3Uuk//J7vqdzF9CdOSpRDd6WigP1iRNGBmf2
 4gZMlmFntuj4ZT8O+JQNaQUhA8PoVbxtsWZMWUg5EaVt+qx2HEJXQZ2nDkeaTrKJMEeX
 SFl1HbMG/Qqj7VOadZDZ8PQo4hCrTG1ElCkkJbJMmJzdVz7szmtEeBkgkv0OVAvgQeD9
 /JFw==
X-Gm-Message-State: APjAAAXwyeB0yQY91Qan6fiENqdPkV5s0LHnJQ6djNgfO9se+hHAI9g5
 ShAOTjn2OJkLXYj1KPqINcM=
X-Google-Smtp-Source: APXvYqxUB7sZmq8y8VINmqjxcxw1nx5P7rd/13e79L+vtzHV6ANBCs8nm6SgxE2CIKPWmst9f3sWdw==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr33198806pfi.260.1577127569760; 
 Mon, 23 Dec 2019 10:59:29 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
 by smtp.gmail.com with ESMTPSA id e1sm26283596pfl.98.2019.12.23.10.59.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Dec 2019 10:59:29 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: m.szyprowski@samsung.com, joro@8bytes.org, kgene@kernel.org,
 krzk@kernel.org, matthias.bgg@gmail.com, agross@kernel.org,
 bjorn.andersson@linaro.org, robdclark@gmail.com, heiko@sntech.de,
 mst@redhat.com, jasowang@redhat.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 4/6] iommu/ipmmu-vmsa: convert to
 devm_platform_ioremap_resource
Date: Mon, 23 Dec 2019 18:59:16 +0000
Message-Id: <20191223185918.9877-5-tiny.windzz@gmail.com>
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
 drivers/iommu/ipmmu-vmsa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index d02edd2751f3..3124e28fee85 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1015,7 +1015,6 @@ static const struct of_device_id ipmmu_of_ids[] = {
 static int ipmmu_probe(struct platform_device *pdev)
 {
 	struct ipmmu_vmsa_device *mmu;
-	struct resource *res;
 	int irq;
 	int ret;
 
@@ -1033,8 +1032,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
 
 	/* Map I/O memory and request IRQ. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmu->base = devm_ioremap_resource(&pdev->dev, res);
+	mmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mmu->base))
 		return PTR_ERR(mmu->base);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
