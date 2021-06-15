Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1D0C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 14:14:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB91613DA
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 14:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB91613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8542160759;
	Tue, 15 Jun 2021 14:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FjUKH_4zlmOH; Tue, 15 Jun 2021 14:14:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7C73660879;
	Tue, 15 Jun 2021 14:14:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62C52C000E;
	Tue, 15 Jun 2021 14:14:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AA4CC000E
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 14:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B1F1836F0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 14:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7G1S5VckJCSt for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 14:14:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4ABF836CE
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 14:14:16 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id e33so6829215pgm.3
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/FJesSbjdD3ax6QLZHwWomAg+hmA/0XqmQi+5t3uBts=;
 b=QAmzB4gHG7Cy4ZN45ovZfpN6L1SILefQ0L+NxivAp0a6ufJ3shF5BHnlp4wRjjtevl
 Z7kY9HIEZPuiRINzUexcDU0nWp6ZF+CkmwLIjH/F4xTYMpgJqWG4JL36Su/+tnFQyM38
 PQsbmnUUSs6LfqFK6Y5pWTfk0aWhWAYKWk3g51/NT9lXSx9FY82ucMbd7x4whRd3GnDT
 SNV/a9nSjTPjAT1DTDg/fOVFZMXcOzmVcwqxnUn+YWCFSPuFh8NDIbjMsRQ/k+L1hbNc
 Fp6wCNh2LQAkqhTBA8ShNGsEatOTf0DgYL0PYQmlXjFQUADRCb0aB401iUdLw5ezIe7M
 6dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/FJesSbjdD3ax6QLZHwWomAg+hmA/0XqmQi+5t3uBts=;
 b=CX0og2QqPghRssVkv3rmmZb9IrPnHYrd5iOknHfMwfmRtwVedqPdE1FwoacJUDIWmA
 6Ay367m3ElHhMAXOJ1N/eEuW9iN3tnvLuxfzaqARqj3FbqkoYdv4gmgMkhF8GxlJHZLJ
 gNXyRLm3DhRZVZgWYVcNarHkaRyCh0MiUs+N00aM0dseFf0qFbbDU3yaRDp69l0HzXIH
 ifVr4Lk0pMD0O6HhX5c11PZgOhnfd1XxpbB0P+6nCN0szZ4AUy9rJOmVGhKVu5dohfrh
 SEZXYy4UUFHkKJALwvBZtEFpQ+cLK8zNJ6rte3LRgLNfic8/oXUwQrQLQUGIZ8Xv2jA0
 bFqA==
X-Gm-Message-State: AOAM530uV/DB7YbzcigFG5/XBvrMi4RWxN706MTYOmPTULrgFIX0O0c+
 OwVDBMd1xDkvgp5ISrtYkKPs
X-Google-Smtp-Source: ABdhPJyjoOKdYN6iIafASuxZ0lb8ce4AFMzIucMsE/2yfL6/wOtvuhzP/4QXvpNfGDsqISSeoNQjLg==
X-Received: by 2002:a62:1d0e:0:b029:2d8:30a3:687f with SMTP id
 d14-20020a621d0e0000b02902d830a3687fmr4531470pfd.17.1623766456186; 
 Tue, 15 Jun 2021 07:14:16 -0700 (PDT)
Received: from localhost ([139.177.225.241])
 by smtp.gmail.com with ESMTPSA id h8sm2255456pgc.60.2021.06.15.07.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jun 2021 07:14:15 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org
Subject: [PATCH v8 05/10] vdpa: Add an opaque pointer for
 vdpa_config_ops.dma_map()
Date: Tue, 15 Jun 2021 22:13:26 +0800
Message-Id: <20210615141331.407-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141331.407-1-xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
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
index 98f793bc9376..efd0cb3d964d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -542,14 +542,14 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
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
index fb41db3da611..1d5c5c6b6d5d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -565,7 +565,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 		return r;
 
 	if (ops->dma_map) {
-		r = ops->dma_map(vdpa, iova, size, pa, perm);
+		r = ops->dma_map(vdpa, iova, size, pa, perm, NULL);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, dev->iotlb);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index f311d227aa1b..281f768cb597 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -245,7 +245,7 @@ struct vdpa_config_ops {
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
