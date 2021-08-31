Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BE3C432BE
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 10:37:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E1460FC3
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 10:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59E1460FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 33F5B40474;
	Tue, 31 Aug 2021 10:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zk6Axi1f7f-j; Tue, 31 Aug 2021 10:37:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 07DA3400F0;
	Tue, 31 Aug 2021 10:37:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB0BBC001A;
	Tue, 31 Aug 2021 10:37:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E937C000E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A73D404AC
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w0Ycj1lYTxnz for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 10:37:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FE8340499
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:19 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id j1so11483165pjv.3
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bOb5vmojDqQCbnIcWiSlBRwm7/pGzlrCLVRi/6lo5DU=;
 b=IyT/NoploiLL1m73R8JnOX8d0hJVoSoHJLHHsR0hVN4P3tyO//LrM1hHo9MZ9I7dJm
 tbYpBKj4x1li4TYGN1YxbeFtkIngXwdO5YUG0b0t/Ly/YLJV55OII0nScsA9ToHRAER6
 jzCZdTL7N+kRIr1SSlMfn5zmQWZsKKENdbS4gC6iZ3LOfjt6+T5HwZe2PN0PEBUoDMSK
 BEh4YBpcIWrqSSFEOSHzOzRlYEuzu4eEh+nXX7FGJRE1xLCkS5isJSdLfXKOJpC+JCPY
 8LTEwKM15Y1SJh4NtNOZ8eD9nQ3tvkn0ZhHqzIExgXiyEhr/mkdIU47uFDSf0kk1uFD+
 nIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bOb5vmojDqQCbnIcWiSlBRwm7/pGzlrCLVRi/6lo5DU=;
 b=ddufUSgSJF7CLuKRA0EYjEJ0GZ4WGYQYcBaK46ep6erDEXVe0FgdXrxxC1rl4fcjDB
 1vzqVYV8nlB9AD+sJFqUm4iMDYf3BsZoQBEOpNlpLRaJHX52O+kdUWx5u/cjYTA/aZQL
 aDpBP/VibdqoTr3sz1ADFL/hlvvpYIXQ71wgHJ89IGFLTOpcl4CWTjeTggicKGwkGB7t
 WnfnIy3Igx+rtxY3KontF1x3XH+vIQ8RX982F1hMk6EJI6C/Lrru/3Y3dQW+MGgshJLh
 kX2QdNFSMK/ZrFWY9TCaJj1H2jaC0QXPnGXADuZEVETeGo4Ay0mM2D2pAd7GhOeKVaXw
 UZoA==
X-Gm-Message-State: AOAM5317e3S5tNII2+0VZZ9aeVM561NL+eJDJxp4rVwoP0i/QL3IkGmg
 SBqPRvrF/3OxqGoJOjM0sHdT
X-Google-Smtp-Source: ABdhPJwsEb0F2LDGXnZMhPPIEKLwUW/eoF35j5kV7o83UkOC/ix7knMX7fPB6WYft1GoDjlF8pdFCA==
X-Received: by 2002:a17:902:ba81:b0:132:3a70:c16 with SMTP id
 k1-20020a170902ba8100b001323a700c16mr4051866pls.60.1630406238599; 
 Tue, 31 Aug 2021 03:37:18 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id m18sm2555499pjq.32.2021.08.31.03.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 03:37:18 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
Subject: [PATCH v13 04/13] vdpa: Fix some coding style issues
Date: Tue, 31 Aug 2021 18:36:25 +0800
Message-Id: <20210831103634.33-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831103634.33-1-xieyongji@bytedance.com>
References: <20210831103634.33-1-xieyongji@bytedance.com>
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
