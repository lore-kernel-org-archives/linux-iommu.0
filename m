Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC99CC07E96
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAFB613AB
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAFB613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27B424049B;
	Tue, 13 Jul 2021 08:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cs-qhagybCcm; Tue, 13 Jul 2021 08:47:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DC01D4049C;
	Tue, 13 Jul 2021 08:47:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5375C001A;
	Tue, 13 Jul 2021 08:47:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10C59C001A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4BA640440
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6TgflXB6Jw2j for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:47:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F54440486
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:53 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id 21so18934987pfp.3
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2fP/MAmI7gUka5e/DKUQ2mjQlxJxe0/QRKPw5yBwyTk=;
 b=rpVEQUV1X70OmbrrQTJJKvk5vCPqC4uyyQYqM8mgOg9WDN/eKRObLhREIgC9AhlQtG
 eUZsoe1ZtDcx9fRxn5K5cTmakEDk81uPA+xScHZGg3Tqu81c80BChtmTqJDJYMUUT2FX
 I8vD0sFKqshhBkFve+LFV2d7iGakKJ6UO++oA6/QFcNuQGOsSjYmiPWVYrZl3U10Hqmm
 N6egKhnknsyBTg02r1Hz+54X/yG9BUJz2HuqTsK2D2UErp3uOrJUQlLV7QFYJqAnHhic
 z3Jy2j8PSswSLNBDJg5a+jUolEiDfEm0gqiykb9N4UFR//SYSeYkWWUQ83/UgrjRRwug
 POjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2fP/MAmI7gUka5e/DKUQ2mjQlxJxe0/QRKPw5yBwyTk=;
 b=QHfOODQd3sWklTmOkI7r7rhvZ3OuupLdFaHel6XdD8+oGcfGtU3a2Frsztp/zEJmWC
 pIN6fj5z/e6s+cp1pQ/7QYnkbxUK2doVaevHqr3UWjA8iYUBUXPR0AIcFqqPKpqTx1Wi
 2paLCMsqAUv9XXZhKOyNeHjYqX5Pqo0E6hK/uVfREd0QDYlVrHF2tviYsxi+o+3ChodQ
 uHbbLSFKY6rvPsIjFs4JO0uchn9FJrtr+baiih9xM3yw9w5fJF4EjeOXq+voQfFz9dv1
 7A8rk2wi3NTVMiH8sddlv/GM9ZzUm7O1OzkSy1edwfLnoYGM7Le1IS2Gb/4LG+nBTS4f
 dgEw==
X-Gm-Message-State: AOAM531cOcS3Us0T/QIPxLRp1E2+suiDHNpUno34RDuhzcTf8P+Nzm6Z
 7XkmytyI28tLhTlOXowMkzRH
X-Google-Smtp-Source: ABdhPJyBkUB9QNAx3I8j5SvXv3BBPI0eQfjjVmRO0YZO2mJNlMqzj7TJp+Nb22Xnek5hLerTt0F38A==
X-Received: by 2002:a65:5c89:: with SMTP id a9mr3285855pgt.207.1626166072648; 
 Tue, 13 Jul 2021 01:47:52 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id e2sm21544494pgh.5.2021.07.13.01.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 01:47:52 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com
Subject: [PATCH v9 08/17] virtio_config: Add a return value to reset function
Date: Tue, 13 Jul 2021 16:46:47 +0800
Message-Id: <20210713084656.232-9-xieyongji@bytedance.com>
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

This adds a return value to reset function so that we can
handle the reset failure later. No functional changes.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 arch/um/drivers/virtio_uml.c             | 4 +++-
 drivers/platform/mellanox/mlxbf-tmfifo.c | 4 +++-
 drivers/remoteproc/remoteproc_virtio.c   | 4 +++-
 drivers/s390/virtio/virtio_ccw.c         | 6 ++++--
 drivers/virtio/virtio_pci_legacy.c       | 4 +++-
 drivers/virtio/virtio_pci_modern.c       | 4 +++-
 drivers/virtio/virtio_vdpa.c             | 4 +++-
 include/linux/virtio_config.h            | 3 ++-
 8 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 4412d6febade..ca02deaf9b32 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -828,11 +828,13 @@ static void vu_set_status(struct virtio_device *vdev, u8 status)
 	vu_dev->status = status;
 }
 
-static void vu_reset(struct virtio_device *vdev)
+static int vu_reset(struct virtio_device *vdev)
 {
 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
 
 	vu_dev->status = 0;
+
+	return 0;
 }
 
 static void vu_del_vq(struct virtqueue *vq)
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 38800e86ed8a..e3c513c2d4fa 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -989,11 +989,13 @@ static void mlxbf_tmfifo_virtio_set_status(struct virtio_device *vdev,
 }
 
 /* Reset the device. Not much here for now. */
-static void mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev)
+static int mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev)
 {
 	struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
 
 	tm_vdev->status = 0;
+
+	return 0;
 }
 
 /* Read the value of a configuration field. */
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index cf4d54e98e6a..975c845b3187 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -191,7 +191,7 @@ static void rproc_virtio_set_status(struct virtio_device *vdev, u8 status)
 	dev_dbg(&vdev->dev, "status: %d\n", status);
 }
 
-static void rproc_virtio_reset(struct virtio_device *vdev)
+static int rproc_virtio_reset(struct virtio_device *vdev)
 {
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 	struct fw_rsc_vdev *rsc;
@@ -200,6 +200,8 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
 
 	rsc->status = 0;
 	dev_dbg(&vdev->dev, "reset !\n");
+
+	return 0;
 }
 
 /* provide the vdev features as retrieved from the firmware */
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index d35e7a3f7067..5221cdad531d 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -710,14 +710,14 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	return ret;
 }
 
-static void virtio_ccw_reset(struct virtio_device *vdev)
+static int virtio_ccw_reset(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct ccw1 *ccw;
 
 	ccw = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw));
 	if (!ccw)
-		return;
+		return -ENOMEM;
 
 	/* Zero status bits. */
 	vcdev->dma_area->status = 0;
@@ -729,6 +729,8 @@ static void virtio_ccw_reset(struct virtio_device *vdev)
 	ccw->cda = 0;
 	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_RESET);
 	ccw_device_dma_free(vcdev->cdev, ccw, sizeof(*ccw));
+
+	return 0;
 }
 
 static u64 virtio_ccw_get_features(struct virtio_device *vdev)
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d62e9835aeec..0b5d95e3efa1 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -89,7 +89,7 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 	iowrite8(status, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
 }
 
-static void vp_reset(struct virtio_device *vdev)
+static int vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* 0 status means a reset. */
@@ -99,6 +99,8 @@ static void vp_reset(struct virtio_device *vdev)
 	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
+
+	return 0;
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 30654d3a0b41..b0cde3b2f0ff 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -158,7 +158,7 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 	vp_modern_set_status(&vp_dev->mdev, status);
 }
 
-static void vp_reset(struct virtio_device *vdev)
+static int vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
@@ -174,6 +174,8 @@ static void vp_reset(struct virtio_device *vdev)
 		msleep(1);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
+
+	return 0;
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index ff43f9b62b2f..3e666f70e829 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -97,11 +97,13 @@ static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
 	return ops->set_status(vdpa, status);
 }
 
-static void virtio_vdpa_reset(struct virtio_device *vdev)
+static int virtio_vdpa_reset(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 
 	vdpa_reset(vdpa);
+
+	return 0;
 }
 
 static bool virtio_vdpa_notify(struct virtqueue *vq)
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 8519b3ae5d52..203407992c30 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -47,6 +47,7 @@ struct virtio_shm_region {
  *	After this, status and feature negotiation must be done again
  *	Device must not be reset from its vq/config callbacks, or in
  *	parallel with being added/removed.
+ *	Returns 0 on success or error status
  * @find_vqs: find virtqueues and instantiate them.
  *	vdev: the virtio_device
  *	nvqs: the number of virtqueues to find
@@ -82,7 +83,7 @@ struct virtio_config_ops {
 	u32 (*generation)(struct virtio_device *vdev);
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
-	void (*reset)(struct virtio_device *vdev);
+	int (*reset)(struct virtio_device *vdev);
 	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
 			const char * const names[], const bool *ctx,
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
