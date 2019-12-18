Return-Path: <SRS0=Tv0G=2I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81ACC2D0C3
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFBD21582
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEeDzlSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFBD21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A39586E59;
	Wed, 18 Dec 2019 13:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qX2D0qjPFlAp; Wed, 18 Dec 2019 13:42:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 870608795A;
	Wed, 18 Dec 2019 13:42:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7547AC1D85;
	Wed, 18 Dec 2019 13:42:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F7DAC077D;
 Wed, 18 Dec 2019 13:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 089D687E9D;
 Wed, 18 Dec 2019 13:42:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y-jj+jfV82J1; Wed, 18 Dec 2019 13:42:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BE4B688236;
 Wed, 18 Dec 2019 13:42:21 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id q6so2321075wro.9;
 Wed, 18 Dec 2019 05:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bI3H7fJjyT7cwzCxHkg0RoSKkE9h3LIoHk3spnZ/1k8=;
 b=ZEeDzlSAHcJKgSJOBltLwZ4gctZ6heHgw5D7C16qSZBk0BcEIRlw39Zy3UGuZ5UuhO
 PUkGJ+hbZ8GuYnGixq5JfQcbK9y3iacQnUbN45Dj83R2TbSGfhv8hxmkZnTY9dQhjmBt
 pLk01WPXEkN5usMHdmfX2wqWXb9nuXp7+6uOdVviLBNEtMIwl+bjUWAvisdSjbPCSkb2
 myvcPvaDT+lDArGcX3+Vcpd/20s6Anoh6oTnsULQhHWClvkwIMrVWERJAp7Cos8HgvNw
 U+DuKeNl9frs6LPgcheIIcwph6gsYFw+Kj1z4PNBcVkJWdlNdrqclvlakWsrSaiKxn4X
 fjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bI3H7fJjyT7cwzCxHkg0RoSKkE9h3LIoHk3spnZ/1k8=;
 b=PxAS+A4uWr+jmcpkq6Vm4awuOxz+TH4BWqTugyuuixFLL3aUcqXeY6vMtMkHfwzogj
 qBro3wYolqOa1hjxP/5x7NqKhpW+Frtq8wAKDHOqU/JnITLTAP4nNJY6Mm4iQ+y53YBj
 1XB0eQNLnX6hju78pVOxEDPrCJw9br/cOjD0sT3v2f4z/ieHyPoi3CPpQ+AR3NkoEhfO
 cKujDgs9IzcRawNoNqOtI9J5U0UlciX+cPimv66Kg19UlPGkq0usOoZgrdCRhN3ukfl7
 YwnFzczMypK+xklqYnbqlcUkoGRp83I5dbvllzBASTiyfPEJpG0oMqVvDw7F2JCn3ZCC
 8s0Q==
X-Gm-Message-State: APjAAAVojfYet/xg/9rA1gEpH7VSocXID6Hpc7xarBUPyXKsNGUMNwof
 ibcpUFN/QGjHYnjarotsWQg=
X-Google-Smtp-Source: APXvYqxraiIdHwEwu7ywFCdkxr9EHQN/eL8hSbyjl1Dfiv6tPoPwpVi8bvtLx2DxzSSf+A+feHN7FQ==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr2853607wrq.331.1576676540324; 
 Wed, 18 Dec 2019 05:42:20 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id e16sm2547391wrs.73.2019.12.18.05.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 05:42:19 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 5/5] iommu: virtio: Use generic_iommu_put_resv_regions()
Date: Wed, 18 Dec 2019 14:42:05 +0100
Message-Id: <20191218134205.1271740-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218134205.1271740-1-thierry.reding@gmail.com>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/virtio-iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 315c7cc4f99d..cce329d71fba 100644
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
+	generic_iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 
 	return ret;
@@ -932,7 +924,7 @@ static void viommu_remove_device(struct device *dev)
 
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&vdev->viommu->iommu, dev);
-	viommu_put_resv_regions(dev, &vdev->resv_regions);
+	generic_iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
 
@@ -961,7 +953,7 @@ static struct iommu_ops viommu_ops = {
 	.remove_device		= viommu_remove_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.put_resv_regions	= viommu_put_resv_regions,
+	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.of_xlate		= viommu_of_xlate,
 };
 
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
