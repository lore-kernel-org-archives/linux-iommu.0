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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9564EC2D0C0
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EC92073A
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb4L4pil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EC92073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 29D7385A37;
	Mon, 23 Dec 2019 18:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O-ZcLLf3L6hu; Mon, 23 Dec 2019 18:59:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A878185551;
	Mon, 23 Dec 2019 18:59:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 884E2C1D82;
	Mon, 23 Dec 2019 18:59:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F819C0881;
 Mon, 23 Dec 2019 18:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0903F85778;
 Mon, 23 Dec 2019 18:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WpKYgMEF9QWO; Mon, 23 Dec 2019 18:59:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9498785551;
 Mon, 23 Dec 2019 18:59:22 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id s21so4781031plr.7;
 Mon, 23 Dec 2019 10:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=TCR4AR5ucUHlq9yNJFguI2NxlI68W/tsOUZcT+YMNl0=;
 b=eb4L4pil+JCG+cmdA0+Y497EM/NtrHh8JtUYUrydX0icSwue7g/LT7YybIYtTTcV/M
 MDaDFzfK3rGsshR2RJN/EE3X86kt4E4btFV3briwaxtCutIASq/3rWfK0hgKIeBr+pCL
 1DrjLmswrvXHxs3IvDOhgMcK+NehUow+N4Tv6eZIfMecsqBWCVjOwfJB/B9FMksOPQ/b
 fk3OA/ihwGFJVxTedK7BuI7EMQMK1YysKr8bZUBHso5sGbkgqhpLR2KssbBPoVEOEyug
 qB+K4Y29piISqu3qBMy6P1HWvW8dFPImPXFO3HIM7wgp0lRloRUfgj2KHzIbucnt9eu/
 uC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TCR4AR5ucUHlq9yNJFguI2NxlI68W/tsOUZcT+YMNl0=;
 b=QlhLlXACu5iKuUd4U5IUHMf8KYjpU/0HuPo5qNI1tncoFLyWSGu18WauqRTv2URZo7
 WYRTlnQwbtQlTRq0q2coZmTjMOTZk9dvGtkTyT83d4Eg5J0IErrxzQeyh1vXvq2gMZ/H
 cxIVQcwmbJI6jg/G48v7hz404TkS7fMqP+cXTVUYwieIY8nSKKoRM6mFfAPZWvZiJtm/
 v+sMSXPQ+Vhm4RNf1zV6ubv73pvcIf5h4bqFEXNlt/fKWAvuls3TcoUGP88KTkkGm49+
 YHZ+RoICZVnU/qCrUYETPbahCIUkq0wqQQcBNJMP9wEBPnYVnUFImzc/L5nkcY9NhKbX
 pS0g==
X-Gm-Message-State: APjAAAW1T5PQjBKKGn3GYBI+/yloP5xjo09goegkh7aqtIY7OIGaNHHA
 b7QvOktvyZZwj3IUP22ctUg=
X-Google-Smtp-Source: APXvYqz84TR8y+QXxgUTlt23B6h//l3KypRdsMB1YXrNQMBidJsu/m2w0mjr/wrZCM0wu9iBN7SuOQ==
X-Received: by 2002:a17:902:b186:: with SMTP id
 s6mr32565870plr.333.1577127561141; 
 Mon, 23 Dec 2019 10:59:21 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
 by smtp.gmail.com with ESMTPSA id r62sm25858012pfc.89.2019.12.23.10.59.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Dec 2019 10:59:20 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: m.szyprowski@samsung.com, joro@8bytes.org, kgene@kernel.org,
 krzk@kernel.org, matthias.bgg@gmail.com, agross@kernel.org,
 bjorn.andersson@linaro.org, robdclark@gmail.com, heiko@sntech.de,
 mst@redhat.com, jasowang@redhat.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 1/6] iommu/omap: convert to devm_platform_ioremap_resource
Date: Mon, 23 Dec 2019 18:59:12 +0000
Message-Id: <20191223185918.9877-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
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
 drivers/iommu/omap-iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index be551cc34be4..297c1be7ecb0 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1175,7 +1175,6 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	int err = -ENODEV;
 	int irq;
 	struct omap_iommu *obj;
-	struct resource *res;
 	struct device_node *of = pdev->dev.of_node;
 	struct orphan_dev *orphan_dev, *tmp;
 
@@ -1218,8 +1217,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	spin_lock_init(&obj->iommu_lock);
 	spin_lock_init(&obj->page_table_lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	obj->regbase = devm_ioremap_resource(obj->dev, res);
+	obj->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(obj->regbase))
 		return PTR_ERR(obj->regbase);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
