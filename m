Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578B1C4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AAA60241
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08AAA60241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD91C83AF8;
	Thu, 29 Jul 2021 07:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SzTT9fHMLVIY; Thu, 29 Jul 2021 07:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E55282865;
	Thu, 29 Jul 2021 07:36:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BE1FC0010;
	Thu, 29 Jul 2021 07:36:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B79B4C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4ECC40219
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fnbW7RVoQ5vH for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 07:36:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8BE640220
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:34 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id n10so5960777plf.4
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Luhm9TAVP2wsLg1TvJFQP9kHuyEtOYvhVNQ1V8OHfQ0=;
 b=wFCV4SBCXk5621fdFr55sUuwMMbmIgTgY/rtUdXbW3xvNzAaZ2rL+ez1VeGAW96pA3
 wTub1rEunVnzrVZ+QhEgGsPZyDe6h1lwSFhkPHV7txnkJkEaxRGzEd7qlgM6+KrU54RC
 RIABMezMY+9/7jd4fFE6hAZGKYA/7DgtLjBpuNMPXH81H18MjVxlBG/RJJh3gk6Yr4qS
 TE6Amax82kmf6u0GMsZvZBRonygQ0ViZrAJ4IKBjmuhMU5deWYzHZ1HebLjzHXDoWbcN
 xK/THnoSQtI9V5WWj2+phY/JzTjnobU+hrzH2icQzEbd7QDXO2gvO2nH2Dm7fln7p90e
 5rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Luhm9TAVP2wsLg1TvJFQP9kHuyEtOYvhVNQ1V8OHfQ0=;
 b=sk5CTFAec2FBwUg2yZaerc61xcuCLyf3QRt+Fsz22sL4CmM3R1mNeOZ0Qgg6FZe3Ko
 LCidVG0y5K9dfmv0uVGaVOqLwbD4LuEZJiigCP8jYoJC//Nq+NPSIpSUE+g9nOqHmjvo
 MwHWcxBWN6Ju5jPpYvvl8r7eoZnWwUuYir6oRkHN6uYfIUejbc9F0AY8Zy5uX1x5K5Zy
 X7ibqwyTr8xCYJPHgiZo1qcLEoyfNlNz11SG2gmUy9eiQn/egO5rgFR2wmJ8vKkJvj79
 OqTx7j7uKka3cQRUFmwm73FYlIrwu7xSzfH1d8VTt5Sh2HrSKYt88N0OMf10y+6jTn6i
 hSXA==
X-Gm-Message-State: AOAM533r205wk2vBwXzpMetZijNCQQqcd+cG+yjF19zP+X/Q6IxI/Sqi
 TwlL+qRW2y4e/wUjOOO5Yo7R
X-Google-Smtp-Source: ABdhPJy55TZBFCrNFJg4WwvBWq2FhbimstBp0qiEjol4+eO0MEa2OTmyjosxt7zxacNnQd7bldoYCQ==
X-Received: by 2002:a17:903:31c3:b029:ed:6f74:49c7 with SMTP id
 v3-20020a17090331c3b02900ed6f7449c7mr3508604ple.12.1627544194419; 
 Thu, 29 Jul 2021 00:36:34 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id y35sm2412706pfa.34.2021.07.29.00.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jul 2021 00:36:33 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
Subject: [PATCH v10 07/17] virtio: Don't set FAILED status bit on device index
 allocation failure
Date: Thu, 29 Jul 2021 15:34:53 +0800
Message-Id: <20210729073503.187-8-xieyongji@bytedance.com>
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

We don't need to set FAILED status bit on device index allocation
failure since the device initialization hasn't been started yet.
This doesn't affect runtime, found in code review.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..a15beb6b593b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -338,7 +338,7 @@ int register_virtio_device(struct virtio_device *dev)
 	/* Assign a unique device index and hence name. */
 	err = ida_simple_get(&virtio_index_ida, 0, 0, GFP_KERNEL);
 	if (err < 0)
-		goto out;
+		return err;
 
 	dev->index = err;
 	dev_set_name(&dev->dev, "virtio%u", dev->index);
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
