Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9062EC4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368C060F02
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 368C060F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18A4040500;
	Thu, 29 Jul 2021 07:36:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vvgZ7-RcF_qh; Thu, 29 Jul 2021 07:36:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F1DB40319;
	Thu, 29 Jul 2021 07:36:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B9C9C0010;
	Thu, 29 Jul 2021 07:36:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3D12C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B63C740319
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n6jIr_f83yOB for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 07:36:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEAA0404FC
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:13 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 u9-20020a17090a1f09b029017554809f35so14216445pja.5
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ezTwUwcHdLzbLJ6Qex8t9bSwQh5nV4gM1nW+onIqamc=;
 b=aJeeKmO1iUSf5ulfQYOmU/f6LrJOJ/xpojaG8sp5MHHhsHcHMnmIPAHKBLhJjNXk9I
 SdMsytyS3rpG7e6wxN4paTE8aVeoxADQ2Qq2VajHXG4r7NSce8dZXAAfl9JaBWANBaRx
 62S32j4gMEjGzd6F2uS/UK4OCyD90ujkUW/g8osNQTriob7uuqrBY8QD40XGCDT+tN2r
 S96uxeNvFTeXzWXlZhJR4HK9PQRPgGSR4ZaMIRepsa9zFFjt3FCL/aHCfKqU1O86lhtV
 BKjZynlYbYg8IdfiD8WOoifTvfmhUBkRhWKiO7j2lB54h5a/mglAbeZ0WzkX2aAkZUz9
 Nm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ezTwUwcHdLzbLJ6Qex8t9bSwQh5nV4gM1nW+onIqamc=;
 b=Oh6QzgPJjGGAQ83ykQkg50huSTJ6J3sd3MzhLB7SAixWXgFYjXs94Zhty+RdJibl/K
 nQnQhQs+NxZrLcU607Zv62nFN+WlUaalTSEyemsouNhaWTHzDgxZVYuezynTWmTa1J3A
 pjG/66D2UF2b9ZBdMySJ2jLXvLhqmMKrJgfyGk5Nk81wY+aVFqSGEYIQWrV2x00ps9l+
 HuvV16/Wh3SOjsWFlFmEAnGvBPNn9dv/lbbWg2BWKpv9MN6jl8G5/4oBIgpHSGOhj9+D
 MQDLH3nVkbVVRgQhdbmjr23VnrV9kSwHsEjf60XS4VJMeRG3MCIFPLGe2CgHB6q9UszQ
 ifyA==
X-Gm-Message-State: AOAM5312PU2HptbCMvmYudmWNWRuGNo2J2Qr+5ZZK0IUyjRloq5GT54G
 HQvfd0CgvuHK5FGUzflE41Rd
X-Google-Smtp-Source: ABdhPJy5HgYXGcMdvwyyUChEjHwAKCF6yZJqkhXxctPNS68GNGc1IbWVQnCkOAkuA+3j2foct0eGxg==
X-Received: by 2002:a17:902:a9c6:b029:129:8fdb:698f with SMTP id
 b6-20020a170902a9c6b02901298fdb698fmr3526952plr.15.1627544173432; 
 Thu, 29 Jul 2021 00:36:13 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id y10sm2148879pjy.18.2021.07.29.00.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jul 2021 00:36:12 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
Subject: [PATCH v10 03/17] vdpa: Fix code indentation
Date: Thu, 29 Jul 2021 15:34:49 +0800
Message-Id: <20210729073503.187-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729073503.187-1-xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
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

Use tabs to indent the code instead of spaces.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 include/linux/vdpa.h | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 7c49bc5a2b71..406d53a606ac 100644
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
@@ -342,25 +342,24 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 
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
 static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
 				   void *buf, unsigned int len)
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
