Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C5CC4320E
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 12:08:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0A960F58
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 12:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B0A960F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 795A060751;
	Wed, 18 Aug 2021 12:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uAxNZffG1SO9; Wed, 18 Aug 2021 12:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5060D607E1;
	Wed, 18 Aug 2021 12:08:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13D8CC0023;
	Wed, 18 Aug 2021 12:08:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B864C000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AE4940746
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:08:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HP89YV7sTijK for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 12:08:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 598684073E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:08:12 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id s11so2013568pgr.11
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 05:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gmTErZoHuljLWy5ftQQYPa0Y5andptGPajJ0BViKZSc=;
 b=E3gyfzX3p6VBgxg4pWT29QlWqOVlMy2BbTsKDlOSqzh+60rUYJOYzZg/a/5H3opHzL
 saLXHrsiT1qdodUTrFNAgvKbawgYE3Zbm7sn9ZpSgO/ujOQBcpFtfGY4XwBjUDn6GNal
 EhHyVOkhOeoCKu7mzikuQ1LEvOCr0QP3Ui1owbajYTEZ06+xgudTTGigvPrJ2d4x58EY
 MmNck5Ubt3Ii6BQ75nMino2+g6g1YOBh3xKoyB6i659GtUm1nXhgpamk38ax4ZDs77eC
 LhhnoMrfcRaaR3SJ/oWEsIHbg5n7LcIB7PTvdS74RYTDsSB0MVlf2hh+yaU9DqxCtMbV
 WlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gmTErZoHuljLWy5ftQQYPa0Y5andptGPajJ0BViKZSc=;
 b=q6sNlAov3fQmFG6f17el5Ty08ThUz67S87W8/81Af/8SVCGeKRjasgYTfCt70CqWNs
 zHUk+kl0N5xm4zv4ajXylDqaQGcYOTUvm0utPQjenIXCJ3wCW/BCO93gZasXZFfp/BZ/
 C/FYbl5B6vR4NODZ3UsU9/T+86VK8Lp89FE27FowS83jmUB+lcwaW/FgVBdDjcsFZLL+
 CZwY/iOetm2l/wZiDqm11s7oLIy+hZflrye1YkCn4nMSfvAeisZvWhVw2VpYqjwGfEok
 3/H+R3hEkbK8thLyAaHfSRngqUCTt/HYMPPImuXSwW5IM7035DZGbHbfz3qVtzBL4iKD
 cHAg==
X-Gm-Message-State: AOAM5322ydZJ3JG+8G82+3JM0GwJD3UrlLZ422tKwTuqWfcNw1xUeS6T
 LczA2BVX+9z4Tfdxpcv92jXM
X-Google-Smtp-Source: ABdhPJxmHpTevC3n4Gyq6WE+y24vE0c1i9BWHhgK52+NypaaWeKzW65MHbptj1Q4rFojFfdr/JykVQ==
X-Received: by 2002:a62:8f86:0:b029:32e:33d7:998b with SMTP id
 n128-20020a628f860000b029032e33d7998bmr9257363pfd.64.1629288491854; 
 Wed, 18 Aug 2021 05:08:11 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id u24sm6642220pfm.81.2021.08.18.05.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Aug 2021 05:08:11 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
Subject: [PATCH v11 07/12] vdpa: Add an opaque pointer for
 vdpa_config_ops.dma_map()
Date: Wed, 18 Aug 2021 20:06:37 +0800
Message-Id: <20210818120642.165-8-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818120642.165-1-xieyongji@bytedance.com>
References: <20210818120642.165-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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

Add an opaque pointer for DMA mapping.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 6 +++---
 drivers/vhost/vdpa.c             | 2 +-
 include/linux/vdpa.h             | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index e30d89b399d9..827d613c4eb6 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -544,14 +544,14 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
 }
 
 static int vdpasim_dma_map(struct vdpa_device *vdpa, u64 iova, u64 size,
-			   u64 pa, u32 perm)
+			   u64 pa, u32 perm, void *opaque)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int ret;
 
 	spin_lock(&vdpasim->iommu_lock);
-	ret = vhost_iotlb_add_range(vdpasim->iommu, iova, iova + size - 1, pa,
-				    perm);
+	ret = vhost_iotlb_add_range_ctx(vdpasim->iommu, iova, iova + size - 1,
+					pa, perm, opaque);
 	spin_unlock(&vdpasim->iommu_lock);
 
 	return ret;
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index d99d75ad30cc..87ab104792fb 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -574,7 +574,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 		return r;
 
 	if (ops->dma_map) {
-		r = ops->dma_map(vdpa, iova, size, pa, perm);
+		r = ops->dma_map(vdpa, iova, size, pa, perm, NULL);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, dev->iotlb);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index af7ea5ad795f..18f81612217e 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -271,7 +271,7 @@ struct vdpa_config_ops {
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
 	int (*dma_map)(struct vdpa_device *vdev, u64 iova, u64 size,
-		       u64 pa, u32 perm);
+		       u64 pa, u32 perm, void *opaque);
 	int (*dma_unmap)(struct vdpa_device *vdev, u64 iova, u64 size);
 
 	/* Free device resources */
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
