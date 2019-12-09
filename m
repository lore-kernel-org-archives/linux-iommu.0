Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E22C3F68F
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A710207FD
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMW40Gli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A710207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6690488301;
	Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3uQLlqkWUNgN; Mon,  9 Dec 2019 14:50:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 336878829D;
	Mon,  9 Dec 2019 14:50:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02A18C1DD5;
	Mon,  9 Dec 2019 14:50:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA43FC1D8C;
 Mon,  9 Dec 2019 14:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AD97988189;
 Mon,  9 Dec 2019 14:50:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HJXo1OZtHms5; Mon,  9 Dec 2019 14:50:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8A2BE881D0;
 Mon,  9 Dec 2019 14:50:22 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id a15so16482606wrf.9;
 Mon, 09 Dec 2019 06:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v6i9DrODxvVzc7sEu1n26IoTawSzw3EOrGL5427sW0Q=;
 b=qMW40Glimuk8RCsOpQuJ/pexDlbz4FJLVtFyjhBvedGJfjxS4yJweoEhUs42NkR8ym
 ceaQO7flrjft3Ema57FQ4RUg5SaisdUyht8l2r3bp27a3Yqvf9KqWMFIb5hcuQD0MDck
 6aTI0aVh5Kx5Gs/FBgPYx3Vvu043B0vg+XvmlVjhhNE/JHmgzKamOdPGvIxNv21VtyoU
 YBqmv46iNclra+yjNW58pyG8B0uXyXVQM2HgfWVZlMvZMgNNKD8zTu5wRNc6W7Fsb2oH
 sL+3hR/RGv9m+EYzbye8FGIEJijiVk6ee10zp4cGSW8cLTfwtxrCZ41IRcihwAKbQ30G
 xo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v6i9DrODxvVzc7sEu1n26IoTawSzw3EOrGL5427sW0Q=;
 b=SGW3EFfPVVdNKUCmnTl+J2AN958b2G/vomCrfZCUEfPXkSzq6G9MeaJL0G2IIaeiAV
 QBpbAmOEfun3Jhj1/KSeG1jhJH0WWSWUpjQ/UqRUTghhgl18KwOKB2NFwnHfjboE0QRc
 i62M7yAe/5AaoowK4ZLSU7rFVsn/92dJOhuMt8fxoyaRNK1siW5XqtVQssGGLdiLS0s3
 OCb/XW11Kb/zBJyOew/J70EbPdJr+V7GrcQnYzenyiRS4GatwR/vy7y4pSxKoDCHVTN3
 4Ig/ievTefBWiauHA2Nj1sUEsCG5pox81IyxQqCrCrJJ940Fl19lk8usmksS0ef0YcBC
 CuOQ==
X-Gm-Message-State: APjAAAXGYxIy0edjXzM5dbYDiVp8TTwTAZ6/mKPQddoNmmGPAWsbzsa4
 wiU8Yjfct0vI5zwY4QFQRrQ=
X-Google-Smtp-Source: APXvYqycPV9EZHFU8VN58XAVcMErrL4NDZbeMSU6cPaHd0nxxJDiVJbBvYMs0iBbchsEY0d1dIwJOQ==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr2576924wrp.167.1575903020783; 
 Mon, 09 Dec 2019 06:50:20 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id a16sm26990396wrt.37.2019.12.09.06.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 06:50:19 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 5/5] iommu: virtio: Use iommu_put_resv_regions_simple()
Date: Mon,  9 Dec 2019 15:50:07 +0100
Message-Id: <20191209145007.2433144-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209145007.2433144-1-thierry.reding@gmail.com>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

Use the new standard function instead of open-coding it.

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- change subject prefix to 'iommu: virt:' to 'iommu: virtio:'

 drivers/iommu/virtio-iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 315c7cc4f99d..834e56a28d4d 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -837,14 +837,6 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static void viommu_put_resv_regions(struct device *dev, struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 static struct iommu_ops viommu_ops;
 static struct virtio_driver virtio_iommu_drv;
 
@@ -914,7 +906,7 @@ static int viommu_add_device(struct device *dev)
 err_unlink_dev:
 	iommu_device_unlink(&viommu->iommu, dev);
 err_free_dev:
-	viommu_put_resv_regions(dev, &vdev->resv_regions);
+	iommu_put_resv_regions_simple(dev, &vdev->resv_regions);
 	kfree(vdev);
 
 	return ret;
@@ -932,7 +924,7 @@ static void viommu_remove_device(struct device *dev)
 
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&vdev->viommu->iommu, dev);
-	viommu_put_resv_regions(dev, &vdev->resv_regions);
+	iommu_put_resv_regions_simple(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
 
@@ -961,7 +953,7 @@ static struct iommu_ops viommu_ops = {
 	.remove_device		= viommu_remove_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.put_resv_regions	= viommu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.of_xlate		= viommu_of_xlate,
 };
 
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
