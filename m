Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF50C432BE
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 12:08:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1898610E7
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 12:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1898610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 756A780DB6;
	Wed, 18 Aug 2021 12:08:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXu3NH0_9_xy; Wed, 18 Aug 2021 12:08:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5CA2F80DB4;
	Wed, 18 Aug 2021 12:08:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39981C001D;
	Wed, 18 Aug 2021 12:08:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B26BC000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09EC640249
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:08:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6SIFfKmjr2mQ for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 12:08:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8E36401C7
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:08:00 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id x4so2011540pgh.1
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h3cBaHMfU52s7B4IKQZfv/Mv4AwRAWrj25gFgUhSo0U=;
 b=BSEezFXK8s9mIq1KmFaXULVeK3aSeyUogMR5eD4dSvtorIgyvtWBSxykWIDi2Mf8pr
 X5b162/G8WPmPUAGFLqIwL0ckm9Ys6EESEOmKMZOP0yUwunUWxu3972h2sop/3olzLJy
 +IddzNhjRBi9dNG9AR0ALhnxsPULvsgdBtWjeyQNb90yCiAG9ofU/B/rl//+ZPKJ4xvC
 +dt5yiC6AAS7EhGnuWJ7Q9BYkTy7pDDvx8baBuxDEgJnKxcO7qGyGDW7avh8GUwYddOo
 33vORXAaeWGUY3lf7K8R+UkAVom11YqRB/1UwDF/3jh8VGWc6YZBRKuzp3zS4SAgt24N
 IbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h3cBaHMfU52s7B4IKQZfv/Mv4AwRAWrj25gFgUhSo0U=;
 b=jMQ8VSRWFfnITNCf90hBqlOgRkCKcaNTIaWgmRoqAc9NHsQmk5pwnzB4XvQ6uMSYBW
 vSqBnRw4gSvO4fUsYro5bh6+q/VJIE8/d+ibTzMj1qCB2v/wvd9l22bYkrC+ZjEepALf
 74P6+i6Qyh9UHiJgVUA5FWxzzkmF4edbDjWG1dW86Sih4S7MHHG2SboqXSpCO/7MiqEr
 Q9gyOLF9svw8FCwKmip/Eb+hSnUQlYRLQDdOlFnxjgbGRZUIkYUPfjSECGlVpp3+Ejo2
 J+W60qF/oacP2QGl+e6eIn+Ws8ZBycMldrtfAo1tVOeNrkOHro8I5q2AcMO6x42thqAR
 9fAg==
X-Gm-Message-State: AOAM531QaQ1npGBbdNbQhM83CSm3A8T4XgrPOQ9W9kgZ1ymfvgvyW6fZ
 elPWHuNvlJFv4XwfQDV0KFiI
X-Google-Smtp-Source: ABdhPJylpJBebPvrUUXvngWerpOz2/KsXpZmy7xMNWLgfzpdybMKiIoAmHmo7Y5tBNvbw/zln+2/Kg==
X-Received: by 2002:a62:e90b:0:b029:30e:4530:8dca with SMTP id
 j11-20020a62e90b0000b029030e45308dcamr9110885pfh.17.1629288480323; 
 Wed, 18 Aug 2021 05:08:00 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id 73sm6785078pfz.73.2021.08.18.05.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Aug 2021 05:07:59 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
Subject: [PATCH v11 04/12] vdpa: Add reset callback in vdpa_config_ops
Date: Wed, 18 Aug 2021 20:06:34 +0800
Message-Id: <20210818120642.165-5-xieyongji@bytedance.com>
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

This adds a new callback to support device specific reset
behavior. The vdpa bus driver will call the reset function
instead of setting status to zero during resetting if device
driver supports the new callback.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c |  9 +++++++--
 include/linux/vdpa.h | 11 ++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b07aa161f7ad..b1c91b4db0ba 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -157,7 +157,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	u8 status, status_old;
-	int nvqs = v->nvqs;
+	int ret, nvqs = v->nvqs;
 	u16 i;
 
 	if (copy_from_user(&status, statusp, sizeof(status)))
@@ -172,7 +172,12 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 	if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
 		return -EINVAL;
 
-	ops->set_status(vdpa, status);
+	if (status == 0 && ops->reset) {
+		ret = ops->reset(vdpa);
+		if (ret)
+			return ret;
+	} else
+		ops->set_status(vdpa, status);
 
 	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
 		for (i = 0; i < nvqs; i++)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 8a645f8f4476..af7ea5ad795f 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -196,6 +196,9 @@ struct vdpa_iova_range {
  *				@vdev: vdpa device
  *				Returns the iova range supported by
  *				the device.
+ * @reset:			Reset device (optional)
+ *				@vdev: vdpa device
+ *				Returns integer: success (0) or error (< 0)
  * @set_map:			Set device memory mapping (optional)
  *				Needed for device that using device
  *				specific DMA translation (on-chip IOMMU)
@@ -263,6 +266,7 @@ struct vdpa_config_ops {
 			   const void *buf, unsigned int len);
 	u32 (*get_generation)(struct vdpa_device *vdev);
 	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
+	int (*reset)(struct vdpa_device *vdev);
 
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
@@ -351,12 +355,17 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 	return vdev->dma_dev;
 }
 
-static inline void vdpa_reset(struct vdpa_device *vdev)
+static inline int vdpa_reset(struct vdpa_device *vdev)
 {
 	const struct vdpa_config_ops *ops = vdev->config;
 
 	vdev->features_valid = false;
+	if (ops->reset)
+		return ops->reset(vdev);
+
 	ops->set_status(vdev, 0);
+
+	return 0;
 }
 
 static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
