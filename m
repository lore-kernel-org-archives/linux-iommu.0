Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D96BC432BE
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12AC60F46
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F12AC60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C703C403E0;
	Mon, 30 Aug 2021 14:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ZYY7YXI5udZ; Mon, 30 Aug 2021 14:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AE7DB403C0;
	Mon, 30 Aug 2021 14:22:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99333C001B;
	Mon, 30 Aug 2021 14:22:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED07FC000E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF2A8402EC
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QDZciEr5iIun for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 14:22:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14FFC402ED
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:09 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 mw10-20020a17090b4d0a00b0017b59213831so14007467pjb.0
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bOb5vmojDqQCbnIcWiSlBRwm7/pGzlrCLVRi/6lo5DU=;
 b=dTsAhtQq0wA+bieSGEDhFMrmBS/2eabwLraiL/FPpYegbrEJYy8SPUl32+FEZA8XPa
 GPzu6BH5ZUc0aGLJSj2InZ9rOImL7p0Z17+KZtU77QqhNDsul6JaCQGjYDdkzteIg6dY
 A62QHOr3RDnu2yPmfoD33iAgUfhLuIdDhZVkILskgC/KWD4gnibrlbu9NLxd+C+19mrp
 G7rSYf4k15oZRsKBY20xXZJErD9GYCVpKtdd53re59ym5GgcTXtcKvn7KVKI2RZWXQ4t
 EW4CzI/NkZ9FSf0lEhr76H5Fn/2sgHktT8riiAHOtBkdW/RPyTy6rDwWYP9n/zLItfC7
 0D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bOb5vmojDqQCbnIcWiSlBRwm7/pGzlrCLVRi/6lo5DU=;
 b=rTDWQ9fNDro66Bl8iCzbN/ErXE1q25p33i5ZIp7IJY5k2tCyEA+fWLrX3Z6uhq5x6T
 1LFDY2TDCE8exnUrQSC7E+WsP/JnsTNiUmS0vxdGSq1VPLcXeY7MxrrHQK3z2CpDgZWQ
 0di4BhjDd40o807e3tCNo+BuDNHD4X0EogWS2BUxomz1TCrwlLha3+tqRyfn5++a6kgS
 8AWc5/Murv3eZTLW2UEgn2m97efNwgqzRexRB5/Ku596V96gbmegTxZ9auM3WYBZqfrY
 H5sm5AD6R5I4qso/rG//mIkhbSulJQpqFFAFeHtjNX26Zv1J9Eg1XSxDYpfc5BXowPuo
 /bxA==
X-Gm-Message-State: AOAM530JbetMyTLVGdS4BvNJ/+My0WUfLUubkXUpiJWTFfTDxnPlLMqI
 y96ZOf6t0jGplw85ptcj0aTA
X-Google-Smtp-Source: ABdhPJwcArvmL0XfQpt3ieNfkp/kbYdcp3OEUwLqP357sEnbfZBLKdUOi3puK46BTRD2uiQCxs3oYA==
X-Received: by 2002:a17:90a:19da:: with SMTP id
 26mr32350111pjj.198.1630333328548; 
 Mon, 30 Aug 2021 07:22:08 -0700 (PDT)
Received: from localhost ([139.177.225.237])
 by smtp.gmail.com with ESMTPSA id gc20sm10539889pjb.17.2021.08.30.07.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 07:22:08 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
Subject: [PATCH v12 04/13] vdpa: Fix some coding style issues
Date: Mon, 30 Aug 2021 22:17:28 +0800
Message-Id: <20210830141737.181-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830141737.181-1-xieyongji@bytedance.com>
References: <20210830141737.181-1-xieyongji@bytedance.com>
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

Fix some code indent issues and following checkpatch warning:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
371: FILE: include/linux/vdpa.h:371:
+static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vdpa.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 8cfe49d201dd..8ae1134070eb 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -43,17 +43,17 @@ struct vdpa_vq_state_split {
  * @last_used_idx: used index
  */
 struct vdpa_vq_state_packed {
-        u16	last_avail_counter:1;
-        u16	last_avail_idx:15;
-        u16	last_used_counter:1;
-        u16	last_used_idx:15;
+	u16	last_avail_counter:1;
+	u16	last_avail_idx:15;
+	u16	last_used_counter:1;
+	u16	last_used_idx:15;
 };
 
 struct vdpa_vq_state {
-     union {
-          struct vdpa_vq_state_split split;
-          struct vdpa_vq_state_packed packed;
-     };
+	union {
+		struct vdpa_vq_state_split split;
+		struct vdpa_vq_state_packed packed;
+	};
 };
 
 struct vdpa_mgmt_dev;
@@ -131,7 +131,7 @@ struct vdpa_iova_range {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				@state: pointer to returned state (last_avail_idx)
- * @get_vq_notification: 	Get the notification area for a virtqueue
+ * @get_vq_notification:	Get the notification area for a virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns the notifcation area
@@ -350,25 +350,25 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 
 static inline void vdpa_reset(struct vdpa_device *vdev)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	vdev->features_valid = false;
-        ops->set_status(vdev, 0);
+	ops->set_status(vdev, 0);
 }
 
 static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	vdev->features_valid = true;
-        return ops->set_features(vdev, features);
+	return ops->set_features(vdev, features);
 }
 
-
-static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
-				   void *buf, unsigned int len)
+static inline void vdpa_get_config(struct vdpa_device *vdev,
+				   unsigned int offset, void *buf,
+				   unsigned int len)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	/*
 	 * Config accesses aren't supposed to trigger before features are set.
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
