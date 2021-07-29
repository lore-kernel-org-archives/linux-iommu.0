Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4782AC432BE
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E9261078
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3E9261078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D45C140521;
	Thu, 29 Jul 2021 07:36:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nuM0BXJUa12M; Thu, 29 Jul 2021 07:36:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1AAD40527;
	Thu, 29 Jul 2021 07:36:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E042C0010;
	Thu, 29 Jul 2021 07:36:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8FF7C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA66240319
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hzkz2aaWZjyg for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 07:36:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 32B2640522
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:20 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id ca5so9000500pjb.5
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 00:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VIBGZakN9k8BoO8YLMnCoI0EQ62bM67Edlzhv2usKjY=;
 b=YB4ZBkJ2UbGmacd15CUj5610iSRVIyAVm76CETlhwePaAGMy1nP4wVboLGC4DJ45kw
 wS034hRrqM5JbLcfYkHr4l64Vo3/J7EvtnF4ZFGz4XKOPCmyEorUa6O2v/DEV3nMMEBS
 u61bKP+sFu957CxpAsLhY0E5+ZnndnrsVtCqI36OjNoRLVQnERyMUuw0KViH6f22atFV
 UXjKMFPdgNpgcD4LFCaQHABx2iEsyXCpIIxTpPuUla8nJAobGV+MuufDJkoSesH1Nm60
 n0AnQe+Eu0XBc/6JOLDRrzfVdrvAKRjfv4rTmabJC9d1ZMzG1tTMB2NX42dPf7u6CP2o
 +Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VIBGZakN9k8BoO8YLMnCoI0EQ62bM67Edlzhv2usKjY=;
 b=eDpRYFt6dz5tT02HHBa2T3sDZkUej8mjLvzGi7F/NFVSFHWZjAkCjPN1oooPbRwgxn
 HicWYui3JCcfaVxjHMp8clXxlR38LzBTL36t8m6XcXW2DIXcmDPstapq+/MmzSskr26a
 J8lzZsVbigwO1SRNPBA4nyuzWpfkPPGdPq6Cs4UTbh0xjkC8fQ65WF3G20W+O2Lk6EXU
 qKFruqqi/UtsK1ZKdmqdJKyBIJqDAjmFq6YY9nAVeDT9BBRAXNyvRn0UiP6ffLI/m/f+
 uhXpYSFM8q2dqBP+64ShweRQnsah4gII7cAt8aHq24oDxNC6e8yCFO0MBPHCKn97jZbR
 cA8Q==
X-Gm-Message-State: AOAM5335FsA8WGqkHx7Upkof1t+VDqDzndzcKjsf5YbGTOMR8ypaaJe8
 +x1BGecA0GFquHmh+0gluYyx
X-Google-Smtp-Source: ABdhPJxTWwlUeqHVaW44eybtOYtbAcCrpe+XMQRRaXjatyWL8/OnDv5TWZQAFglLde0iZkvroMKDbQ==
X-Received: by 2002:aa7:87cd:0:b029:32e:7954:2872 with SMTP id
 i13-20020aa787cd0000b029032e79542872mr3825545pfo.0.1627544179762; 
 Thu, 29 Jul 2021 00:36:19 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id v15sm2469337pff.105.2021.07.29.00.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jul 2021 00:36:19 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
Subject: [PATCH v10 04/17] vdpa: Fail the vdpa_reset() if fail to set device
 status to zero
Date: Thu, 29 Jul 2021 15:34:50 +0800
Message-Id: <20210729073503.187-5-xieyongji@bytedance.com>
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
resetting. Otherwise, fail the vdpa_reset() after timeout.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 include/linux/vdpa.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 406d53a606ac..d1a80ef05089 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
+#include <linux/delay.h>
 
 /**
  * struct vdpa_calllback - vDPA callback definition.
@@ -340,12 +341,24 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 	return vdev->dma_dev;
 }
 
-static inline void vdpa_reset(struct vdpa_device *vdev)
+#define VDPA_RESET_TIMEOUT_MS 1000
+
+static inline int vdpa_reset(struct vdpa_device *vdev)
 {
 	const struct vdpa_config_ops *ops = vdev->config;
+	int timeout = 0;
 
 	vdev->features_valid = false;
 	ops->set_status(vdev, 0);
+	while (ops->get_status(vdev)) {
+		timeout += 20;
+		if (timeout > VDPA_RESET_TIMEOUT_MS)
+			return -EIO;
+
+		msleep(20);
+	}
+
+	return 0;
 }
 
 static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
