Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7851BC43461
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31280611ED
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31280611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F3D5608B8;
	Mon, 17 May 2021 10:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PZHJXnEXWdI; Mon, 17 May 2021 10:02:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9076608D9;
	Mon, 17 May 2021 10:01:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42233C002D;
	Mon, 17 May 2021 10:01:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B4EFC0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 390DC608CB
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zlmkZdGP7fCV for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:56:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C36236090B
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:12 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id t30so4277668pgl.8
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tx8QMBGpZJX1ew8np0gTCpYyfE19GueKJf7/gIkdvaI=;
 b=xuePQKnI02Lahx+4Y+JNH3sW8SQG8Ak9dQIdwLXgLchUJt1JVNjIL6rVMKCJfgNgzb
 Vb/qRjAR9wDRbRbqECJXSfbAViZOzuMI57xitwX91penLlPfZgA7sMJ43Smd4aM5TW08
 W+LwxP2K0D1yO52eg/OLk1l5ch7fYVaqmjdJJ9Kw9hOGMhzR4ee650DrK2bmhH+3HJR2
 fdA778/MCyyZBHTQGJIxo1Xt9bXg79iwAcMQHgDf2TBv1ll7WWWCv3PfLTDFLYaqBzQK
 9VOL17IcPdxDmUjnB6bN0Nng4ug8GZbN4WTz46Yng2r58wITMeBLORKVGF+sp54AnFA+
 R36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tx8QMBGpZJX1ew8np0gTCpYyfE19GueKJf7/gIkdvaI=;
 b=V6ZHaQJ+88cKYRABVvJ4u2CKkxsT6ZsjmjCaOT1fOQh8RBZ/FFitvf8XfjUfHCkhCg
 8vF3mh3WJjQgS9VgtzBdS/BTXwKmqBDAC0JTMHseKrFiQoFMZAfZa9fw3H2nhGcUDHZH
 +IyIOE4d7MFE764Qf/2xKkMbfa0zJwtQgtBQOYDBt3gxzftfe0oS7XnCSwxJpLYpApX2
 GDK+Ku2/W3GENyXsuP0FHElSagfOxAZHQfMHjKtnyavP2DKzsYd0eBeIKrHhDkeBbqE4
 6F1R5Oaddkzjl5olOzeRpuZeCD0oDNIllytW67401tGYRQ3CIKJjErs6Zs8F6wjOH4z9
 yPFQ==
X-Gm-Message-State: AOAM5322WQFI6vhcK5UBFIM1O2qcpktqxOnwXX8nSMOy33omTjpGT5oq
 rlJBbSmNMMVr4Yz6nQG1isAH
X-Google-Smtp-Source: ABdhPJz4jJ0Z7VvRRYZhi1VrL3hoPcZzoDQgK9lGdzLpuPpHEzBKkdKEplH7qnfQz5cB3LlwWpUAjA==
X-Received: by 2002:a05:6a00:787:b029:2dd:15b6:515a with SMTP id
 g7-20020a056a000787b02902dd15b6515amr1691311pfu.26.1621245372172; 
 Mon, 17 May 2021 02:56:12 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id d9sm14749696pjx.41.2021.05.17.02.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 02:56:11 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
Subject: [PATCH v7 04/12] virtio-blk: Add validation for block size in config
 space
Date: Mon, 17 May 2021 17:55:05 +0800
Message-Id: <20210517095513.850-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 17 May 2021 10:01:55 +0000
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org
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

This ensures that we will not use an invalid block size
in config space (might come from an untrusted device).

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index ebb4d3fe803f..c848aa36d49b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -826,7 +826,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &blk_size);
-	if (!err)
+	if (!err && blk_size > 0 && blk_size <= max_size)
 		blk_queue_logical_block_size(q, blk_size);
 	else
 		blk_size = queue_logical_block_size(q);
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
