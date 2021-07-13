Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E06AC07E95
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0639613A9
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0639613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EF5A4061F;
	Tue, 13 Jul 2021 08:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AfxCWCXVeTs3; Tue, 13 Jul 2021 08:47:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3712E405CC;
	Tue, 13 Jul 2021 08:47:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08F28C0022;
	Tue, 13 Jul 2021 08:47:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 394D2C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18BFF40613
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9bMkdEKKrJIK for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:47:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66102405C5
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:49 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id p9so11712592pjl.3
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EjR09xl/s+Zlx+uuKDPZmG38VH07hTVA8QsJdDWGoMM=;
 b=0VNyBgTY7yxOchYvhwFlmk9k2udQOWCUUMpM8nhTR7Bk4VZtxT4ZI8f98TzkKevJk5
 dYLlzzFa5wsVMHn13aVEoDurgoQ/B97Q+JhhlkS6OR7p2ukAzqbqaIA6heoBr2mvaW2u
 LWKNdvE1D06+3O4nambhTYRGp9OSBjhVsvc+sS1fRJwI0tKIi1LcEHcgiIroKNvO+Tk9
 Y9lhU4YFRflDnAO1ytSChBfqW/0Xf2PueeNxk3B7oGv7K2ZJPXdQOsXRxJSUBz/FAPuC
 yq81H3J4EOgBB4At7Bf6X83H6Bjq4AOEWbBPDSkXpZtUwXWHYKXE5SKnGfz6IjR2oj55
 XrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EjR09xl/s+Zlx+uuKDPZmG38VH07hTVA8QsJdDWGoMM=;
 b=LFHaYqBJi7NBsfZC9+rGmNI5PNEeOxDcdmVkfvs1fxKTJef7zQHyJcl5GQ8+1g2PnT
 J0UyXwlvWvHeDVyBqD70l/6OgvgXN9GE8tokUfi5RcJvAECOo/Ppuj3W431f+G4nTe/X
 SKKBtq4ILFhNPfHB03yium6PspajzNu+49+2GmxAc6sneP4ql84/AcorS9h9Ds7Wan7v
 sumJ+EE+4W9LFLMvFPgX8u9sB5RFY7sV0eGaPy3bZB0MfMI7iaMEpCJrSMkdUJWnpIHI
 C3QWHDqi1FkM2wafz1HfSmqoluEuVT6x2G6qo2O8vZ6uU6GJEBJsdSrzlO+5VL9XsRlp
 DEPw==
X-Gm-Message-State: AOAM530hfezoT0BJ9iUCI2Kx9BJlM+4cn6Um5QFJ7FtbLDpavIoz//vF
 FrV5CxemM9WiSc6gWFUZLx7S
X-Google-Smtp-Source: ABdhPJw5LSlu0ju1WyptJVUqPCDp3E+vXWICCBRXlUH6oKTubBRS+RfF2LpFzJEBJMPewe5KBLVzVw==
X-Received: by 2002:a17:902:7610:b029:12b:f9f:727 with SMTP id
 k16-20020a1709027610b029012b0f9f0727mr2734371pll.65.1626166068835; 
 Tue, 13 Jul 2021 01:47:48 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id i12sm9336715pjj.9.2021.07.13.01.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 01:47:48 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com
Subject: [PATCH v9 07/17] virtio: Don't set FAILED status bit on device index
 allocation failure
Date: Tue, 13 Jul 2021 16:46:46 +0800
Message-Id: <20210713084656.232-8-xieyongji@bytedance.com>
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

We don't need to set FAILED status bit on device index allocation
failure since the device initialization hasn't been started yet.

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
