Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00236C4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB08D61054
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB08D61054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EA4960861;
	Thu, 29 Jul 2021 07:36:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YzNA8lZR2Ped; Thu, 29 Jul 2021 07:36:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 106C56072E;
	Thu, 29 Jul 2021 07:36:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0886C0010;
	Thu, 29 Jul 2021 07:36:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55CC6C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 443C683ADF
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FZvWA49vrLpf for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 07:36:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E771283AEA
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:44 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 e2-20020a17090a4a02b029016f3020d867so8000335pjh.3
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=79+lwfgqPqTMCDJYOtelsxZhwWsCxwv7dGGvPGe+0Sw=;
 b=pht7EHvBPEmalFMQJxnA5uITGsCuOlxP9Y280Ur4c4Xr3lJdEeqiDYxP7TC7vQPgGd
 I/ZPYxIAF7wX+D7ibW2+QAbkf4ckwDUGvyyRhT83wHCsspVChvqBgO1K/tQZaoBTt9Yp
 Lir6sHtO0AUKIhh8vlXiMiD+sbirh9E/DVJcXMoijXcC4aQJapQYNS+qNggApM9o0DIi
 ZzEoPv6irKFSlf6epkzfwm9d0JWIMWZMQhLEIbRJUy/HXVHCsfR9gQAfB/8EirRwTMsF
 uRKiOnqoMqV2cLI/WjkPsIhOBs4mwx41zQl+qu/lOvaz0BIStwAPZwrefnhImIRH+0MY
 YaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=79+lwfgqPqTMCDJYOtelsxZhwWsCxwv7dGGvPGe+0Sw=;
 b=dyvNOuYMAyb2mHKdJYNYW0BW6EuhIeIarEnNoAFNJTyug5PYb5TEjdUJ+jJPiAdMBE
 g1p6h4DQWjUDqAST8jxJXdT2AMYv71JUxYDKdpxI7MYxrnQc5ChUjmGQCed1hvxmKslq
 16cIbHM/NtWQOIg0YGkfnMYhQErQtohNKdxaZZVRZVksBie+fbtafE0S5yNlWahivhqF
 3tdSzAvq4lQeqsBnmAU5LYuxJuKaYeihXHx3gCPcFu2FMPHVHOXdiKp9PtDwLNrYbiLK
 pRNDz/9HUSkUspUEq9dOJ2VffJbSq3LFF/Dyb1/if0M8SGFomZ6R5c9jZrNPfzMMH0qa
 8FEg==
X-Gm-Message-State: AOAM530A2n6ARyO1Mn5imiYGixpbCNiiBOHDYbdaa2fDdEyVArsSQVIk
 Jk5pvuU1yKKin0So1xl4MlFD
X-Google-Smtp-Source: ABdhPJwd6fqL59b6zB2Y1X6Xa6fhnvr9Evz97aQU4N4q/6V8MSENkC+yj5nWiVm8Rzev8LmszMzr1w==
X-Received: by 2002:a05:6a00:2:b029:32e:3ef0:770a with SMTP id
 h2-20020a056a000002b029032e3ef0770amr3859510pfk.8.1627544204478; 
 Thu, 29 Jul 2021 00:36:44 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id ge21sm2237949pjb.55.2021.07.29.00.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jul 2021 00:36:43 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
Subject: [PATCH v10 09/17] virtio-vdpa: Handle the failure of vdpa_reset()
Date: Thu, 29 Jul 2021 15:34:55 +0800
Message-Id: <20210729073503.187-10-xieyongji@bytedance.com>
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
