Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599EEC07E95
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:48:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2773E613AB
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2773E613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03BCE82B53;
	Tue, 13 Jul 2021 08:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FtFmu-F3OwR9; Tue, 13 Jul 2021 08:48:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 172E4827C5;
	Tue, 13 Jul 2021 08:48:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC4AAC001A;
	Tue, 13 Jul 2021 08:48:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17F30C001D
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CE8183886
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JJEfpwXe22Dn for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:47:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A70C983843
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:56 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id s18so21002200pgg.8
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=79+lwfgqPqTMCDJYOtelsxZhwWsCxwv7dGGvPGe+0Sw=;
 b=XPYV6AqgUbZp6+vdppARBpAYCPqTsziLqNwvNsrjLuNKQsh6GS3q19GuTFueLqfI3W
 2mpioxtWWYo5lHGzcp+Jutobs4GmHGUTQiIvyRJOrhRaSYEd2g13fYjJdx8IqQbpVtg+
 U5M3F2NmfDR26UxFi92Yzg5HX/fYV6AYnZdE6d7ugOH+Y9vAV4e5UbOMWrmsG3AqiEzX
 NUPQt8B7lzQDca2Wt8iUkhnTLPaw8kJJmv71Rv4l+iNrRzjIvV51afp0ikEMovNJIa3w
 l3GoRQ485RyPX6RthpBauL0J2/vlNzokMcWZNI71JmewCwtjndkIJDGd4VS80mquizHp
 zreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=79+lwfgqPqTMCDJYOtelsxZhwWsCxwv7dGGvPGe+0Sw=;
 b=kQ3YrvWdAz0s2HPBz9CSJkfGudeovUOO5Cr59AfCwwqfrSDo/BvV+Cepwe2vIjIE5s
 WARw4/uIBJvrGjL5GGyV8vJ0J3svVHMHR0zaQHyqQz57effRpvOkCZQ47fdhbfh3ziEa
 UhhEAMtSZLMUugpY21kwEp48w6ppWv+q+w3BSJrTt//UTmiz0jgiScQtty2P0ta0Rul2
 haUYqf4qp6UvanXD5Uh/3ctmF+cXNdr6dzSSMeYM3EmwzpVQc5cqzGi1L34IEzFaVYVJ
 G3Vwgnxb5BkGXHYRxDph45SQOrA4LjHnA2xyKpr4S9Ga0lzTsv6wR0nCto2/3m35UCLt
 WoTQ==
X-Gm-Message-State: AOAM532cHiUZT7IHBtKfOSpzSCFv4ioVfx08TLRi8I/z0MuZiaGmwS0U
 KD0syeYo2AvRtXUH4q2/iTl4
X-Google-Smtp-Source: ABdhPJya/3d83k8xmEEz7mxN/KfDFTYEWfRDpJqmURKX4t0jIlbAdO7JalzXWyaKhiHPR7hvAQh/zQ==
X-Received: by 2002:aa7:808b:0:b029:2ef:cdd4:8297 with SMTP id
 v11-20020aa7808b0000b02902efcdd48297mr3574498pff.27.1626166076154; 
 Tue, 13 Jul 2021 01:47:56 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id q21sm11607775pff.55.2021.07.13.01.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 01:47:55 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com
Subject: [PATCH v9 09/17] virtio-vdpa: Handle the failure of vdpa_reset()
Date: Tue, 13 Jul 2021 16:46:48 +0800
Message-Id: <20210713084656.232-10-xieyongji@bytedance.com>
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

The vpda_reset() may fail now. This adds check to its return
value and fail the virtio_vdpa_reset().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_vdpa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 3e666f70e829..ebbd8471bbee 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -101,9 +101,7 @@ static int virtio_vdpa_reset(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 
-	vdpa_reset(vdpa);
-
-	return 0;
+	return vdpa_reset(vdpa);
 }
 
 static bool virtio_vdpa_notify(struct virtqueue *vq)
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
