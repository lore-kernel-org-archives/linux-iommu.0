Return-Path: <SRS0=4dF3=NP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC354C4338F
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 11:10:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E636613AB
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 11:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E636613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56FF340424;
	Tue, 24 Aug 2021 11:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I37i1b7_WoV3; Tue, 24 Aug 2021 11:10:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 342B24046B;
	Tue, 24 Aug 2021 11:10:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 077C6C001A;
	Tue, 24 Aug 2021 11:10:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EA61C000E
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 11:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F6334046B
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 11:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kb2SLcc7m8zO for <iommu@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:10:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E241F40424
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629803403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MzIVYD6Rkcf1avefY9xlULEY3kI1KocMJ7+mbhVSUk=;
 b=J9zoicPacGc8JCVXDTJ1GPTrxpOvQpo1Q/257vWmOFjmtp5Agg0IF8Dg9Q/xwcx1Ik7eRK
 BWYjpB6K7Aqy5VmftBmDWsYkhPbASYgWnqYorRktJDMywF5vTY/k8HvGljgnemD44ew/Nv
 OpbAykFaiQPxE3CZdd2bEWOOJrxEAyM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-fdDwMek2NRSAdFbcmoeKgw-1; Tue, 24 Aug 2021 07:10:02 -0400
X-MC-Unique: fdDwMek2NRSAdFbcmoeKgw-1
Received: by mail-ed1-f70.google.com with SMTP id
 r12-20020aa7d14c000000b003c1aa118ad1so4401915edo.2
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 04:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6MzIVYD6Rkcf1avefY9xlULEY3kI1KocMJ7+mbhVSUk=;
 b=qz3/6FMTxQkWNUozpyb+fs/7Eq67+Q1t9ZalCt0aII9KltAFC164fm5qml5g6AN7HH
 hEvFQTHuv3U0XhOEtwXsXFdaJ2xOCb62fFZt0ZuRH885u42kYQpC0Aolb1iLssgOWvly
 a3fzIDCi4SawnMSNGLACnji71mY7xQQL0i7MAZwJ6pqYPw+5uNkMf/FnVyYehUnZnmKb
 5+8HcCXAHvpxjgGkjUCjsljAelZIrcO0Ty0feHR3qZcGHob60k0qpyglMQ7cek/i9TYt
 HxqJzRUOrZcIYsVBip1OLlAkcibqbbhjZFtu9GPiiduT/fXkUz/FZIHcnjH6wvs5Oziq
 u1mw==
X-Gm-Message-State: AOAM533hf0eh04CgmhUGv1AyKUmnV0+OIErOLBtQAdrj/yu0M7JXczRP
 0vWncj+2vL13icXexVZqDOGz/rKLJpbW3DNXm83beJ8dgG3esUCnVTDTAm8aFMaavXJlrhbADMP
 6UgzqrXKaqw98P2eCAX7b2zrfAEFnqA==
X-Received: by 2002:a17:906:9bdc:: with SMTP id
 de28mr40030321ejc.154.1629803401189; 
 Tue, 24 Aug 2021 04:10:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym2zZCfOfkB6aYg6hvpM9EYCUNutnmi5ZkMGiE/H3YmE4qf/VSJ5+nHLjDGlfYfIZpl2VYMg==
X-Received: by 2002:a17:906:9bdc:: with SMTP id
 de28mr40030281ejc.154.1629803400969; 
 Tue, 24 Aug 2021 04:10:00 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it.
 [79.45.8.152])
 by smtp.gmail.com with ESMTPSA id u2sm9003772ejc.61.2021.08.24.04.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 04:10:00 -0700 (PDT)
Date: Tue, 24 Aug 2021 13:09:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 03/12] vdpa: Fix some coding style issues
Message-ID: <20210824110956.gtajf34s2xpm66gx@steredhat>
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-4-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-4-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, willy@infradead.org, hch@infradead.org,
 dan.carpenter@oracle.com, xiaodong.liu@intel.com,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, joe@perches.com, robin.murphy@arm.com,
 mika.penttila@nextfour.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Aug 18, 2021 at 08:06:33PM +0800, Xie Yongji wrote:
>Fix some code indent issues and following checkpatch warning:
>
>WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>371: FILE: include/linux/vdpa.h:371:
>+static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> include/linux/vdpa.h | 34 +++++++++++++++++-----------------
> 1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 954b340f6c2f..8a645f8f4476 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -43,17 +43,17 @@ struct vdpa_vq_state_split {
>  * @last_used_idx: used index
>  */
> struct vdpa_vq_state_packed {
>-        u16	last_avail_counter:1;
>-        u16	last_avail_idx:15;
>-        u16	last_used_counter:1;
>-        u16	last_used_idx:15;
>+	u16	last_avail_counter:1;
>+	u16	last_avail_idx:15;
>+	u16	last_used_counter:1;
>+	u16	last_used_idx:15;
> };
>
> struct vdpa_vq_state {
>-     union {
>-          struct vdpa_vq_state_split split;
>-          struct vdpa_vq_state_packed packed;
>-     };
>+	union {
>+		struct vdpa_vq_state_split split;
>+		struct vdpa_vq_state_packed packed;
>+	};
> };
>
> struct vdpa_mgmt_dev;
>@@ -131,7 +131,7 @@ struct vdpa_iova_range {
>  *				@vdev: vdpa device
>  *				@idx: virtqueue index
>  *				@state: pointer to returned state (last_avail_idx)
>- * @get_vq_notification: 	Get the notification area for a virtqueue
>+ * @get_vq_notification:	Get the notification area for a virtqueue
>  *				@vdev: vdpa device
>  *				@idx: virtqueue index
>  *				Returns the notifcation area
>@@ -353,25 +353,25 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>
> static inline void vdpa_reset(struct vdpa_device *vdev)
> {
>-        const struct vdpa_config_ops *ops = vdev->config;
>+	const struct vdpa_config_ops *ops = vdev->config;
>
> 	vdev->features_valid = false;
>-        ops->set_status(vdev, 0);
>+	ops->set_status(vdev, 0);
> }
>
> static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> {
>-        const struct vdpa_config_ops *ops = vdev->config;
>+	const struct vdpa_config_ops *ops = vdev->config;
>
> 	vdev->features_valid = true;
>-        return ops->set_features(vdev, features);
>+	return ops->set_features(vdev, features);
> }
>
>-
>-static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
>-				   void *buf, unsigned int len)
>+static inline void vdpa_get_config(struct vdpa_device *vdev,
>+				   unsigned int offset, void *buf,
>+				   unsigned int len)
> {
>-        const struct vdpa_config_ops *ops = vdev->config;
>+	const struct vdpa_config_ops *ops = vdev->config;
>
> 	/*
> 	 * Config accesses aren't supposed to trigger before features are set.
>-- 
>2.11.0
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
