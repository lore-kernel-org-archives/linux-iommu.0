Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C364C433EF
	for <iommu@archiver.kernel.org>; Fri,  7 Jan 2022 08:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D57F8831E7;
	Fri,  7 Jan 2022 08:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MmhbEN4Fo_mV; Fri,  7 Jan 2022 08:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CDDB7831D5;
	Fri,  7 Jan 2022 08:04:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1406C0030;
	Fri,  7 Jan 2022 08:04:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B484C001E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 08:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52FAA831E3
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 08:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6OC-lmbymWWV for <iommu@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 08:04:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD60A831D5
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 08:04:33 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 l16-20020a17090a409000b001b2e9628c9cso5732394pjg.4
 for <iommu@lists.linux-foundation.org>; Fri, 07 Jan 2022 00:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=5wW8NfAn9pQjxsJKsrZHm4OzxBBzuThAXcIy8E5AppU=;
 b=C/xfse/uxT2x9U/Tl+654bYJSgGUNOo661B+VyheRZrXA/TtzFIeiRbcIjHxH0RYT3
 Gt1y6wEmMzdV8HTH5F6gk6s7qQfFX5GC4TPFO5rzoerh5MXtn+dw2XgjPTNca20YiBsT
 R+7t5IOsj4DquenT2BiiGtDUXvlqb//qBkTGVoQNFOVTDR14/qfqVu2/KGLImu4ASX3r
 btfkRNgesp8oC4WSYRI9FoknS5gKBUSssP5udDH1o1fHs/0NKNuqaMTBs2xddLVKYAEe
 EvwXR+J+pDbICtJOAydYtPMb2OGRgH+D0PjgGoXXMd1aI7xvFqS2pqQ6MJtIq2k6uOwx
 7HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=5wW8NfAn9pQjxsJKsrZHm4OzxBBzuThAXcIy8E5AppU=;
 b=4AJrccLCr00CRrM0ADTOzCUKG7WW8WD9p/e4ZR49XKu0RhY0Ir4lvI7S+XFUKDaAt1
 MQ/R6EDBQZ43QnPNaWv0lJZ3lN5V5jTo3KKFG3d2DW1ssyji+KECpkPc8A4NsqAgl8bS
 daozb4aLVH2mKlIk3NQ5LueNKMg1CnrXD6jYkJQOUjYg5IpDe0zBTN2O3nf1IYn+7tew
 OpwJRlU6ma2d3fcoC93Kj+BlaVfU0xbjdUSgrU5WmKDV2EIonmSOvCvLK6/euC//EwY/
 7u8GgcpcHlPNM5fKhVIoGQvFhe236wb5ZhYdyMsv6umOVel9XEIGSg4pCQe4ah32+hmO
 goMA==
X-Gm-Message-State: AOAM5325pl68mmPqA2ATH9hCb4lG9SoKaWYVwzdJ2gzx0e5DlQHI5tMd
 lXZxDIixqgOCe/U4QRCuE7ceq8wGsJM3kILTlLU=
X-Google-Smtp-Source: ABdhPJxqn041UHbxvVSnHdNKGkj65+PAU2TXMvpsM1SyWkimxkNQbsHYzQdgIS0Tn1N+1c3rRVAyhQ==
X-Received: by 2002:a17:90a:7f98:: with SMTP id
 m24mr6788243pjl.163.1641542673336; 
 Fri, 07 Jan 2022 00:04:33 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
 by smtp.googlemail.com with ESMTPSA id f10sm5416663pfj.145.2022.01.07.00.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jan 2022 00:04:33 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: 
Subject: [PATCH] iommu/omap: Fix missing put_device() call in
 omap_iommu_probe_device
Date: Fri,  7 Jan 2022 08:04:28 +0000
Message-Id: <20220107080428.10873-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linmq006@gmail.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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
Add the corresponding 'put_device()' in the error handling paths.

Fixes: ede1c2e7d4dc ("iommu/omap: Store iommu_dev pointer in arch_data")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/omap-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 91749654fd49..cbc7ca5e890a 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1684,6 +1684,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 		oiommu = platform_get_drvdata(pdev);
 		if (!oiommu) {
 			of_node_put(np);
+			put_device(&pdev->dev);
 			kfree(arch_data);
 			return ERR_PTR(-EINVAL);
 		}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
