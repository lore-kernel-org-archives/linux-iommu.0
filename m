Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE17CC07E95
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:48:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F58613A9
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F58613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9833040473;
	Tue, 13 Jul 2021 08:48:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id noxrj26pURVM; Tue, 13 Jul 2021 08:48:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 792194045F;
	Tue, 13 Jul 2021 08:48:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62D40C000E;
	Tue, 13 Jul 2021 08:48:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1C5EC000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C60440487
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NPrgkBL-Bwgz for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:48:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9928D40465
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:48:00 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id v14so3800230plg.9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LsGekY4BvYvIO5Z8AgcJapYB7A/KQEKxuOgJFJnV+F0=;
 b=Et7FbWZVS2cx+fpTA8oSkjyi22zfg/JVBDFbigj20lktndc6w8VizCfnQbd8DLvnBV
 VNEhNSeBTNpJFAegw09Rg0mEfMyli4GMRdum0q4qn3U74w57SPrdejSMPmNtu9yMiPCF
 TiTyNrOHaIEsr8Bx2ZBmhMhJIuXrBF5pSlk5FJueUhyp4hfHn5krzzUtF6Q9Pl85RJaq
 SKkCpcUcgTDMKntqvaiRWItj7upm0Y9Xhp3HloIdnzr5/LU16LGuAsmTpAo3w7IY0Gn5
 K4vArTZXMxMG7swExsxAVe8b+arAc/H+tSgN2OIWI2JOdcmaiAlQmmKNmF3cbmgNWuUL
 EKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LsGekY4BvYvIO5Z8AgcJapYB7A/KQEKxuOgJFJnV+F0=;
 b=BxPut8bqrBrDaSIIOPAWwDiDVeVT9Yv5f0/xcCAVKz9SEzgcp9XFFHBFpp4mNX7fBa
 MNxhMXUe2y+2CK5bzHnmkdMJB+GSF1nuEry8iMpINWxkJn07gDoAEl+xtC66r2qBN/77
 s1vFASubI3GFupb09nMPP6qBEo9E+MvIvpY2w61kbUxBPoGXnAELCKgU9pFNaR0OjAQq
 z9BF74dIHc5v4PBC79edoMKvB3EmRUA1SzCliGnxULy5E4RLqdVqzgeXGeETp9gAB4dV
 Hy5Q1WrwV9EzaexQf2VrBcWYss1wnTSXQFeziiNPpN/uX+sZyPBFPcfrL3YeJ4uEbyZb
 Ezmw==
X-Gm-Message-State: AOAM533mHUAv7NP+Ozm2KlMSFVx7S6xVoIX9QTIb/z6KfqQisgT9bv03
 gdqanAr8q28j/unOWBAJM0Fe
X-Google-Smtp-Source: ABdhPJzFJWinFNSX5sjhEi7EUxUYGzqDtd7WH488DhV7Pgm2CsQABcNDQNUVm8LAg6MjG7Qz0MbUVw==
X-Received: by 2002:a17:90a:5b07:: with SMTP id
 o7mr3372998pji.35.1626166080091; 
 Tue, 13 Jul 2021 01:48:00 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id x10sm2437739pgj.73.2021.07.13.01.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 01:47:59 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com
Subject: [PATCH v9 10/17] virtio: Handle device reset failure in
 register_virtio_device()
Date: Tue, 13 Jul 2021 16:46:49 +0800
Message-Id: <20210713084656.232-11-xieyongji@bytedance.com>
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

The device reset may fail in virtio-vdpa case now, so add checks to
its return value and fail the register_virtio_device().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a15beb6b593b..8df75425fb43 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -349,7 +349,9 @@ int register_virtio_device(struct virtio_device *dev)
 
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up.  This also tests that code path a little. */
-	dev->config->reset(dev);
+	err = dev->config->reset(dev);
+	if (err)
+		goto err_reset;
 
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
@@ -362,10 +364,13 @@ int register_virtio_device(struct virtio_device *dev)
 	 */
 	err = device_add(&dev->dev);
 	if (err)
-		ida_simple_remove(&virtio_index_ida, dev->index);
-out:
-	if (err)
-		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+		goto err_add;
+
+	return 0;
+err_add:
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+err_reset:
+	ida_simple_remove(&virtio_index_ida, dev->index);
 	return err;
 }
 EXPORT_SYMBOL_GPL(register_virtio_device);
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
