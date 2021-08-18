Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0169C4338F
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 12:08:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC966108B
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 12:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4BC966108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B64140599;
	Wed, 18 Aug 2021 12:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Emz7CZN_X2F4; Wed, 18 Aug 2021 12:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EBDA440746;
	Wed, 18 Aug 2021 12:08:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C65A7C001A;
	Wed, 18 Aug 2021 12:08:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F16CFC0024
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3CE560B92
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:08:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rd0TJeuRgPTg for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 12:08:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C16CA607E1
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:08:04 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 w13-20020a17090aea0db029017897a5f7bcso2153576pjy.5
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Upxg8K2RjM27bp0rNDyYgc14eCE3NIhEIdC+t18pOCs=;
 b=lygAyD3Keugif/7sVDBS0Q0WByJtqD55lFbxdT5snDeED0JPyahQ3wtT1oTmd/nNab
 YI0+3N8u2CnAhouYjLrt5FI/zRDPh+xjkeiBRbuBaw4yBwZcdpS5c+n+kJsgc+cZ59YU
 u2oOzgjEWW5Mpxf4M8OXllJPqNvTAuUYwxr9efXDrsvtc2zMeb2R4jci5Q8LkpOkAGVo
 nBYBnmI5yCDv9ZFIP+4XR0Cc3hWps8F6T+lqRcTYBnCHbMgTRfSATpE+zVZrOIiUH/c2
 ZOw4QXOAhQ7R3EWtb2d6awNdUcI8Gp3/S07gCrocQRhZuxHdS/QRSYuMchNsJXeIysoW
 gwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Upxg8K2RjM27bp0rNDyYgc14eCE3NIhEIdC+t18pOCs=;
 b=V5AxFEgctYbtqMuOT+ciYeHVPfNaFnv4xC1SajcCgbZ6McZDW8bApgHQgPL4hLNY8R
 IZy8hzm9HvmYfOPUkVBGhF5JXZB0/ES5Zl41J9HJCM83Z7fExVkcafZ34CPf9wEgiJRt
 BuWqeqY5vuepv/nghwfgQL9uW3h9jH7e28UBgef2JE9E433HZoAIEZkQRhAmJq2ldGN/
 98jk0qrVZS6Z/jBHGxw9a8l9zbbW9gESzxmrNXg8BmOpMkieu8HRGf0jOOcsB1CzP6k+
 zDm9tXxLM7FA1SrrFZLPdA66WSnWFpXbAIlbDrw6Ytavqs4MIWFrUWgPay+cJ1L712AN
 WiBA==
X-Gm-Message-State: AOAM532wxKDVTnhCmvJOXOnvQ1Tc/x2koYXU+EJebN+mc2rfW86ayQg9
 tgtjzNDnZXND12J7mYwc4O15
X-Google-Smtp-Source: ABdhPJx2zpHHk/rm1pUU6+vYW29Qy78558N3aIjYPaB+DOhvx26kSUU8EJK1qwKqbMvnWiWPs1Xy+g==
X-Received: by 2002:a17:90a:d149:: with SMTP id t9mr8962859pjw.0.1629288484275; 
 Wed, 18 Aug 2021 05:08:04 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id y62sm6138669pfy.183.2021.08.18.05.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Aug 2021 05:08:03 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
Subject: [PATCH v11 05/12] vhost-vdpa: Handle the failure of vdpa_reset()
Date: Wed, 18 Aug 2021 20:06:35 +0800
Message-Id: <20210818120642.165-6-xieyongji@bytedance.com>
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

The vdpa_reset() may fail now. This adds check to its return
value and fail the vhost_vdpa_open().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b1c91b4db0ba..d99d75ad30cc 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -116,12 +116,13 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
 	irq_bypass_unregister_producer(&vq->call_ctx.producer);
 }
 
-static void vhost_vdpa_reset(struct vhost_vdpa *v)
+static int vhost_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
 
-	vdpa_reset(vdpa);
 	v->in_batch = 0;
+
+	return vdpa_reset(vdpa);
 }
 
 static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
@@ -868,7 +869,9 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 		return -EBUSY;
 
 	nvqs = v->nvqs;
-	vhost_vdpa_reset(v);
+	r = vhost_vdpa_reset(v);
+	if (r)
+		goto err;
 
 	vqs = kmalloc_array(nvqs, sizeof(*vqs), GFP_KERNEL);
 	if (!vqs) {
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
