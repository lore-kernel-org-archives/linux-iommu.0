Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18917C11F69
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBC2613C9
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBC2613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B351D60886;
	Tue, 13 Jul 2021 08:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yF02pQfyitO0; Tue, 13 Jul 2021 08:47:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A245F60873;
	Tue, 13 Jul 2021 08:47:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77C1AC001A;
	Tue, 13 Jul 2021 08:47:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28CF8C001A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 025404061E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vWwmeKdFXpa2 for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:47:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B4014061A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:42 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 v18-20020a17090ac912b0290173b9578f1cso1502927pjt.0
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FdoZ+4EM7JCQgZ86bDT9RbGlh7q+AWgllGjoIYPWL9Q=;
 b=gA1/QgaUqMMGrBGGpEVYK8fMzHiF70tOx013tB9CxkOMsIAz6K9CyWbLukiYsceeeK
 WT3omC6T/UV02GbqJntqFcUEJy/CsH+2v38lltH8hTUVi5bDMirNFM2m8jsgCd53U/1v
 Lc/Oygn7Gsw282JeKIqoiMuvIbDZt/am73WeLkzOY2/CkX4nQAuUu3ul4s5GPTxJkyx3
 dWRyzileES+3pFwFh509M/IKBfUS06G83m9tPJd2yiq3RvUawNvAiQ6SGLm5AoV3JD3Q
 Yf50mdZiBV6HqGDPHp59XIyHUg9RniZUw56YWfFOmyWOXjXu+QsXkJ6TpitVDuk7cFO9
 CT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FdoZ+4EM7JCQgZ86bDT9RbGlh7q+AWgllGjoIYPWL9Q=;
 b=PpeXiaQB1QDHZHM2KxWFqaacehoM2jUsND4Vi/C2awY2RoFOtNzu0edKsGVRpdU9QY
 oc8Qyhl1Mkmmwqotu73u17LHNsX0ngoiY2WktsQMM9LJ8/9ILQYsDwY0bsqdykOVBvE/
 slIx9Mok0w1fO1srm5p5DY43XaOCTD+PbwRIMNJBnjsknGiFrmAbPU6wXsVCbGUMH0NY
 AP/iQPSxq7aJmlvRaepATuDjYd1+cH3KJ0m2nZh75tCJdqZzpIcR3AtqLgjp0grU4KIu
 iULiDiVEv5XFIQgY2OETr7UJox9qlfKSQTikYfnLN/POcTPPUsmvF2G9IDe23xeGEjhP
 Uhmw==
X-Gm-Message-State: AOAM533LJY+dIglxH20WbpPB0Cl9prtB36B/8fE0+ZJp722ojHzCK6vR
 Rc9hADlenBiRQN3DvMed4m+X
X-Google-Smtp-Source: ABdhPJy/YXaKCppxOExioeRxTLQv1sj8lcUHDptTXIY/sm3klehqPKR0QkOZNRfSckm4SM+jax8f+w==
X-Received: by 2002:a17:90b:1b4d:: with SMTP id
 nv13mr1935868pjb.216.1626166061630; 
 Tue, 13 Jul 2021 01:47:41 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id w2sm15858457pjq.5.2021.07.13.01.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 01:47:41 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com
Subject: [PATCH v9 05/17] vhost-vdpa: Fail the vhost_vdpa_set_status() on
 reset failure
Date: Tue, 13 Jul 2021 16:46:44 +0800
Message-Id: <20210713084656.232-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
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
index bb374a801bda..62b6d911c57d 100644
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
