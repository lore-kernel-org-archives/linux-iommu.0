Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78832C43334
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 10:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F4063606C0;
	Thu,  2 Jun 2022 10:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9-BrQQfo93b8; Thu,  2 Jun 2022 10:29:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E0AFF60644;
	Thu,  2 Jun 2022 10:29:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3CB2C0039;
	Thu,  2 Jun 2022 10:29:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84913C002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 10:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68535606A0
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 10:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W7v--ArVkrDb for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 10:29:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D3E160644
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 10:29:41 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id o17so4172937pla.6
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jun 2022 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=63b5H/jbrN4zsEaLSTowv5XFpFbFjaloCWZOaeCKErw=;
 b=FFB+1QOTTt8is4Lpy02ycAznu7zIS+nBeHgJm6A97sArAMtK4ouvIfXi/9Nmo02kFX
 x9Su2oapjRRtbDbKcG5zsp+U2MNJ07zXfURS0G2T4Dw/T3RNrEE7dyZpfn2BY8aAhaYV
 EfLwDuONuMr/5B3geO74OagdcDHZhW2r4BZcxkghTheDsLBz7gZ6YrkdcfRsGAWbq+em
 oZYbT5CyIotGnq8CpQv0rTlIMQPYae4hbre2C+joSY96odjT8knDKaBt9Gt8dTgLkBuX
 MRGO1Z3aiNkxO+yBlG4Gg9qdKl6tAtZyhFQp1L6GnE5OMlIj/VBjVRAqhhElOvpRozBC
 nW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=63b5H/jbrN4zsEaLSTowv5XFpFbFjaloCWZOaeCKErw=;
 b=gsiD4CrcM6YVnb8Bw61cQOcCMg8xVvJjovWkGsTEBpGWFVP3ggJTdHkko3/qQ3xhwn
 0OIhohuZOk6o2T0syGITuBazmLEmaD+ak+hLb/Jk5UHqbAbx9lIxbeIYpRw7+qnYt3dz
 oPZVU0rmatalGCwBugsmdvuE03Qb53I5kw1Z1M6ff+ddOQSZiJc80QJu+Hn/VhGstT3D
 mAnihfotQaqLVQD1kUVdfoIHVeIFGrHHnnNZgPitcBB57EOCqQaOHGu5USsgOQt4nhkC
 K7ALIk71GJm9Bkxs2/XA0IxqyWDOtmMVrHGYOyFLHbP96jmWyj+RWV/j9TPA224OabOH
 /JaQ==
X-Gm-Message-State: AOAM530l1GJekTNGBozUtV4fLpyZYIIJ72x9APAoyR3UHGWF8Rl0JkEy
 B7+ghAyUdhnS9yjX45hcQzE=
X-Google-Smtp-Source: ABdhPJwu9mqYKpYp1hwjbiBc5BO3cUGxpRnmcfigvPGjyE/9GFjj0Yq3NSrsum6ALSidivqGLDl+iQ==
X-Received: by 2002:a17:902:f552:b0:163:f64a:6154 with SMTP id
 h18-20020a170902f55200b00163f64a6154mr4202768plf.147.1654165780607; 
 Thu, 02 Jun 2022 03:29:40 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
 by smtp.googlemail.com with ESMTPSA id
 h11-20020a62830b000000b0050dc7628150sm3107441pfe.42.2022.06.02.03.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 03:29:39 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Suman Anna <s-anna@ti.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] iommu/omap: Fix missing put_device() call in
 omap_iommu_probe_device
Date: Thu,  2 Jun 2022 14:29:26 +0400
Message-Id: <20220602102926.47456-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linmq006@gmail.com
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

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path and
the regular path.

Fixes: ede1c2e7d4dc ("iommu/omap: Store iommu_dev pointer in arch_data")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- move put_device() before of_node_put().
- add put_device() in the regular path.

v1 Link: https://lore.kernel.org/r/20220107080428.10873-1-linmq006@gmail.com
v2 Link: https://lore.kernel.org/r/20220301063326.18120-1-linmq006@gmail.com
---
 drivers/iommu/omap-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d9cf2820c02e..58f3efdac3f7 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1683,6 +1683,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 
 		oiommu = platform_get_drvdata(pdev);
 		if (!oiommu) {
+			put_device(&pdev->dev);
 			of_node_put(np);
 			kfree(arch_data);
 			return ERR_PTR(-EINVAL);
@@ -1691,6 +1692,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 		tmp->iommu_dev = oiommu;
 		tmp->dev = &pdev->dev;
 
+		put_device(&pdev->dev);
 		of_node_put(np);
 	}
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
