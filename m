Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1905FC433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 06:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3042410BC;
	Tue,  1 Mar 2022 06:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fOm_mdu4UzUF; Tue,  1 Mar 2022 06:33:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 75FF24059D;
	Tue,  1 Mar 2022 06:33:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43A08C0077;
	Tue,  1 Mar 2022 06:33:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD16C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 06:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00C5840620
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 06:33:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NkE8tPxa2xVT for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 06:33:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37E7D4061F
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 06:33:40 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id v4so13256015pjh.2
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3mPo8lvO91fSVL2zNMVudPsfj5UeWu8/OYFDNcv6JjI=;
 b=EyPMwTGdSNloKDGKnCt8Rx2I35rLxgk25XazRMqOUdZAnlqtNAaW0nMyonJiVrtKmE
 yP3lz59YCiJ8K1jROjN7oh95FFAscuHexJXRDsuSXRCPYUJO3PqAPkirtQx94qiQsqnY
 PaSrbE1Ef+S/4DJ8DYi++i3W3+G5mD8JjK3gW/DaFx6VaepqdN9IPFSzmUj+XFZyV8Ce
 YbG8WLEop0vY5p68XEc5rcCMF4toOedFJ73D2Cn0B8b2JIFOfd8lg7cG8YPaUlVPx5c+
 Y9JrVKc4EytbyKW4xRpAOMB8NtJLaRlTWVnGoPY8k+jx9p6eCQyaJynwOg+jehwCnycx
 yhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3mPo8lvO91fSVL2zNMVudPsfj5UeWu8/OYFDNcv6JjI=;
 b=DQa2+hRFN5sbbzft4j2etVkA9uBkjfeRnp/GASWNSbu2w04EvtyvKHrYQ8139gAS+Q
 tbJny6Rh2nzDjFaPFEpYINqeFduXf+WQqW1/O9arROfhlVKveT2wq1Y9ZHzUvGBRDsAf
 +xJjyrZ9E0RHqTjsAi+NUO7QMqOjAux1X6542E6QsSUFfTD+U9I1t9JVHAva3LLWxnKN
 WD9WnxHTgjRNi40zC3XVVe7m5r0MZ2X5z2MLqGXg3AuyXM0UmCWQSTspQ6SDavXGZrA2
 lO+L/zoAcrEM6nWLPv7EyKcvD+59yihqCqfFJ0cmzdBd7kaZwKEWFSuqkMZ5kZXo181V
 ne2A==
X-Gm-Message-State: AOAM530bizywFIf+LAbnlcmRpoBjXrFsp/ECcv8j7QjjngwfjgMkug4Z
 aOMfJ3ZMNLC2b95GIBjz7RA=
X-Google-Smtp-Source: ABdhPJxdw4f+rvERiG34ZF0VdlqFmBtf/joQpRNDllZHRbpWuzAwzWwF9v2uTYwiaAQTf/T2yM4txg==
X-Received: by 2002:a17:902:b58d:b0:14d:3d38:2690 with SMTP id
 a13-20020a170902b58d00b0014d3d382690mr23671504pls.78.1646116419615; 
 Mon, 28 Feb 2022 22:33:39 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
 by smtp.googlemail.com with ESMTPSA id
 s17-20020a17090a441100b001bc1b59fe1asm1087916pjg.38.2022.02.28.22.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Feb 2022 22:33:39 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Suman Anna <s-anna@ti.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/omap: Fix missing put_device() call in
 omap_iommu_probe_device
Date: Tue,  1 Mar 2022 06:33:25 +0000
Message-Id: <20220301063326.18120-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
References: <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
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
MIME-Version: 1.0
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
---
 drivers/iommu/omap-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 91749654fd49..2222b30a0a00 100644
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
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
