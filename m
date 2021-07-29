Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC7C4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CFB60241
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0CFB60241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AD0740341;
	Thu, 29 Jul 2021 07:36:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kalzrOQ7zAzy; Thu, 29 Jul 2021 07:36:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0CF664032A;
	Thu, 29 Jul 2021 07:36:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB1AFC001D;
	Thu, 29 Jul 2021 07:36:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A70CC000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89B4240526
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NSSez5IEDKYo for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 07:36:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9DDA40521
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:24 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id j1so9038362pjv.3
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X6m+j6D+552UMlknTc2y1DCtUDa099ibFfLa+38yD24=;
 b=L80tblxe3wtC2HKOtW3renZJvhfc7GFjS2AU2pPB5D73BMRY5myTcL/dhJfOO3bvlS
 JtQFCV+tA2gcpqYeaWfCYxb8vXm8jpR+HCadwYr5BhMkmKpmvKsmqB9UTRdts+3U9SP1
 z3jVWGbtk9bPdxyirEaJmHDRgjeE+wxcZ6RxbnBwB78D9RNokjcCtEUjS/aYPQ1BGtRp
 QFcakWAIabACF+QbfqNnv3dJP3ygewcdcN8WcuxnO6USt7gbjEjTS14J3bC3C+ylNHGA
 u7uQ2WlKZfweCuq8ckMwiJvO3WR69GUOvElFAR5Jm7PnsV3dbG2bnld3LKJUmpYFmdKv
 gQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X6m+j6D+552UMlknTc2y1DCtUDa099ibFfLa+38yD24=;
 b=YPRN6qX4fdz8bTz4o2+K5ZncJf5XGS9snmocKOxTYFW04tu/vWxX8H+ghORJB2Mlhk
 cWnr8W+Fm4apEUAM2+6Ce+qa2DPh5Jf8LJXd82d/seOUAWZRW90djpmlh/5jtmPA2vFx
 QsLGDfJAHiWFL4kcsf+VT0a4wGNZM6IUwUxF3Lr/NGoRe+Xi7Ta8/SSCTdvo3n7AesIE
 aYkOUaENfvayd7x30Sh2FxwR1/eAfGFGbyrGbKaGtxj/USWUmt7T3zlQSbD2nlDfRAFj
 cDHZNySxn824JAUvPZagSuJzjtDRkx1yynXcXbkx48Fqx/Hcu4LZu3oRu6ElrFQomMC7
 NCjg==
X-Gm-Message-State: AOAM533FUHJ/wfz3hXrlFgeWHV75BlsOEsMJ6+oupfttms0IjzkXiNbX
 sSduoF3VqfyH4m1PLwG9oyqQ
X-Google-Smtp-Source: ABdhPJzL8jwmp/JqGX6fQcP4HFWd79KgnMjKHajdRntovUI/IJhBr5JEygiGnHX6aUTtQVmAfW1PyA==
X-Received: by 2002:a62:e90b:0:b029:30e:4530:8dca with SMTP id
 j11-20020a62e90b0000b029030e45308dcamr3799994pfh.17.1627544184395; 
 Thu, 29 Jul 2021 00:36:24 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id l10sm2164343pjg.11.2021.07.29.00.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jul 2021 00:36:23 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
Subject: [PATCH v10 05/17] vhost-vdpa: Fail the vhost_vdpa_set_status() on
 reset failure
Date: Thu, 29 Jul 2021 15:34:51 +0800
Message-Id: <20210729073503.187-6-xieyongji@bytedance.com>
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

Re-read the device status to ensure it's set to zero during
resetting. Otherwise, fail the vhost_vdpa_set_status() after timeout.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b07aa161f7ad..dd05c1e1133c 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -157,7 +157,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	u8 status, status_old;
-	int nvqs = v->nvqs;
+	int timeout = 0, nvqs = v->nvqs;
 	u16 i;
 
 	if (copy_from_user(&status, statusp, sizeof(status)))
@@ -173,6 +173,15 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 		return -EINVAL;
 
 	ops->set_status(vdpa, status);
+	if (status == 0) {
+		while (ops->get_status(vdpa)) {
+			timeout += 20;
+			if (timeout > VDPA_RESET_TIMEOUT_MS)
+				return -EIO;
+
+			msleep(20);
+		}
+	}
 
 	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
 		for (i = 0; i < nvqs; i++)
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
