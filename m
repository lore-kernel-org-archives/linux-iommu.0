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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA11C2D0D0
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5968E206B7
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sj3ScPvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5968E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 32FE585A4B;
	Mon, 23 Dec 2019 18:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07fHoyFvLhvZ; Mon, 23 Dec 2019 18:59:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D181B85551;
	Mon, 23 Dec 2019 18:59:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEE66C1D80;
	Mon, 23 Dec 2019 18:59:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31E5EC0881;
 Mon, 23 Dec 2019 18:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 20596204FE;
 Mon, 23 Dec 2019 18:59:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4AmQlWDCSnG9; Mon, 23 Dec 2019 18:59:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 63B372050A;
 Mon, 23 Dec 2019 18:59:34 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 4so9591965pfz.9;
 Mon, 23 Dec 2019 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5ZbWphWmX6hvFuVRk+RWFgQofrZKH9eYm1th2d0tMTE=;
 b=sj3ScPvYKe5RHFI5xmOOMlBPRjGR/tgOjWkESOKIqqPmaDssnIshdfvUqClYJX9tBI
 aWTj09Nymr7gywt/h1PZWcO4ZCSrk4jUIfNb9EczsWNEBsdXnKKNITMxCjyYVu+s19l7
 YAXAq4G5jR40lkSkK0YEvsK99KKl/GnrZZaTiZ3SpESVNG2IP5Ulkq1MmJRItVOmbX6v
 XMrllxsXefXzoO2sZFtT//QIbDgjkg0TqQCyXeh2aZuxSrgKCrkqi5gQmYuZ8AUI75qV
 YnI+G38Iba0W+Ixlv9IzdrnX4eE2J66bcVf5qNE5uqUZPU3l5fAfYo7YPXp3fl8fFIqR
 lw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5ZbWphWmX6hvFuVRk+RWFgQofrZKH9eYm1th2d0tMTE=;
 b=XMMOO/IqNvGGfGB98JOmXOo2t2044WtW7PQz4itpIbUxHbNGW9vgN0/C9mLawcrQpn
 aOKjJOKtA88ix1/jNZI5xvrV4OAgczFD/AhGDeuIKZd1m6TpdbVzANCdEnllSfEccGxY
 irIUTDV1XUjXMdmEg8iRzSzWSu+kT4/RZpkLIimMcOdkmUGwlJlHHv6fe2pAuCLyb0F8
 ZTKoOIf5Zb9c15Z7Hrfnr9BVHrVsY7S9zpZqYq29fT5u3kiQT0crtat7pQIiW9/zEWXG
 o0e5zYFGmz9xY/yL/W7z9RoHO6p8C7pt/0VZstlT3eDMlkc/PeR7UDgoE9cLZ0TB8zZ8
 oaVQ==
X-Gm-Message-State: APjAAAVjkFYMB/CnLZnX/7FqDASe9eJqNgMF2lFs3Pjh9wbBi991JyMT
 FZVojgeM+WaLERyqRnOdB08=
X-Google-Smtp-Source: APXvYqyfnDFqyHRd1X6VzN2h1ANIGyik0u9/k4DGw0m2HkGzu2Jgf7Z0vBWv5sTHp/iv1nwqNbTz6Q==
X-Received: by 2002:a63:214f:: with SMTP id s15mr34495783pgm.238.1577127574002; 
 Mon, 23 Dec 2019 10:59:34 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
 by smtp.gmail.com with ESMTPSA id d5sm21091646pfd.107.2019.12.23.10.59.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Dec 2019 10:59:33 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: m.szyprowski@samsung.com, joro@8bytes.org, kgene@kernel.org,
 krzk@kernel.org, matthias.bgg@gmail.com, agross@kernel.org,
 bjorn.andersson@linaro.org, robdclark@gmail.com, heiko@sntech.de,
 mst@redhat.com, jasowang@redhat.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 6/6] iommu/rockchip: convert to devm_platform_ioremap_resource
Date: Mon, 23 Dec 2019 18:59:18 +0000
Message-Id: <20191223185918.9877-7-tiny.windzz@gmail.com>
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
 drivers/iommu/rockchip-iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index b33cdd5aad81..c6d50396f4c2 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1138,7 +1138,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rk_iommu *iommu;
-	struct resource *res;
 	int num_res = pdev->num_resources;
 	int err, i;
 
@@ -1156,10 +1155,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < num_res; i++) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		if (!res)
-			continue;
-		iommu->bases[i] = devm_ioremap_resource(&pdev->dev, res);
+		iommu->bases[i] = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(iommu->bases[i]))
 			continue;
 		iommu->num_mmu++;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
