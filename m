Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBA2C432BE
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F17160F56
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F17160F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D53C40447;
	Mon, 30 Aug 2021 14:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bEuano5qmE1w; Mon, 30 Aug 2021 14:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 316F8403C0;
	Mon, 30 Aug 2021 14:22:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEFE2C001A;
	Mon, 30 Aug 2021 14:22:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB51AC000E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F1D460644
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E7Dvb5kqPJKV for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 14:22:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1396605E5
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:12 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id u6so11699699pfi.0
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BKNG+AOYpL8owuJUrkmxn4BoZ9fJGrSTP/0iPYdfs8Q=;
 b=QHQIqtZ0BiuX8NDq8OEK3FPQA9xxrJeaWuUx/MBelQavHmtTtictA+7ptC5Y4U6lK+
 laHN4NVdppMHC8s8BHM4FgteywY+CEeAZQSt1ViICplfdUTarJOrwz82EFINPzOG4CwY
 CkgnET8VHUt7j3YBHEdug+wY/8UGH8nMUSUwuwR2QcxhCKUyqaxBUeLIZJvzVZcTxCTc
 DzrxuBPu/5szboyfubQlQXsr6a9s8g8nUHa6fI63xVLeGVR0MG7mTS1nIEWdKozOWYl6
 dJ7mcd9PQ7W8HdFnJsqX3OzDhXFctBguV0Cg8L9bsWr3X+hEVzyj/XMgGcMPyoCNEImu
 /Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BKNG+AOYpL8owuJUrkmxn4BoZ9fJGrSTP/0iPYdfs8Q=;
 b=NRGO39nx1lgcWPpaRPj631ZdbO78t8tfl6/r7gOtnWunPibCnQiP3La3UQVXMXkeuP
 TyLi5dapzktTYHtJlWNMmPGQM5FbAJU9LDGBUf1IHUuyf8Bch/9Z4s9PliMYuUSkiycm
 qHULX8zBEU4F5BkHaU2fs6upZwKKtjtwhpc0h7QkQM/rixFFFpGQv30eecTNFzLvCU33
 XjMWifwqwtWLBwMKCOjA+dA0b4yBAUXX7iZXow1KhuskkFC0E1JZELOlRzn1xSLWMPbm
 JR/nDlHHrNXB3dTXu22G2QrBGsPOR0RT/mhzrP08EUHsQt9b9xmOSTDthsY69YTmWkh4
 w20A==
X-Gm-Message-State: AOAM531BtL3ECQmF0cDbzyzGN5+/atO4X3J4o0YAGcUAtFaGHbCjBzau
 /Aan29gAXETwwHplCDu5rvNP
X-Google-Smtp-Source: ABdhPJz9RJRR2P1GpjQcdpQj7817mkqO7RMnTmUXjkaIV9fUadvblK4+XRhRAQSBTQ8y8PVvxUedTA==
X-Received: by 2002:a65:4c47:: with SMTP id l7mr19494286pgr.211.1630333332111; 
 Mon, 30 Aug 2021 07:22:12 -0700 (PDT)
Received: from localhost ([139.177.225.237])
 by smtp.gmail.com with ESMTPSA id p3sm20852651pjt.0.2021.08.30.07.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 07:22:11 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
Subject: [PATCH v12 05/13] vdpa: Add reset callback in vdpa_config_ops
Date: Mon, 30 Aug 2021 22:17:29 +0800
Message-Id: <20210830141737.181-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830141737.181-1-xieyongji@bytedance.com>
References: <20210830141737.181-1-xieyongji@bytedance.com>
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

This adds a new callback to support device specific reset
behavior. The vdpa bus driver will call the reset function
instead of setting status to zero during resetting.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c   | 35 +++++++++++++++++++++++-----------
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 40 +++++++++++++++++++++++----------------
 drivers/vdpa/vdpa_sim/vdpa_sim.c  | 18 +++++++++++++++---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 15 +++++++++++++--
 drivers/vhost/vdpa.c              |  9 +++++++--
 include/linux/vdpa.h              |  8 ++++++--
 6 files changed, 89 insertions(+), 36 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index bfc3d7d40c09..6708671a0603 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -222,17 +222,6 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 	if (status_old == status)
 		return;
 
-	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) &&
-	    !(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
-		ifcvf_stop_datapath(adapter);
-		ifcvf_free_irq(adapter, vf->nr_vring);
-	}
-
-	if (status == 0) {
-		ifcvf_reset_vring(adapter);
-		return;
-	}
-
 	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
 	    !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
 		ret = ifcvf_request_irq(adapter);
@@ -252,6 +241,29 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 	ifcvf_set_status(vf, status);
 }
 
+static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
+{
+	struct ifcvf_adapter *adapter;
+	struct ifcvf_hw *vf;
+	u8 status_old;
+
+	vf  = vdpa_to_vf(vdpa_dev);
+	adapter = vdpa_to_adapter(vdpa_dev);
+	status_old = ifcvf_get_status(vf);
+
+	if (status_old == 0)
+		return 0;
+
+	if (status_old & VIRTIO_CONFIG_S_DRIVER_OK)
+		ifcvf_stop_datapath(adapter);
+		ifcvf_free_irq(adapter, vf->nr_vring);
+	}
+
+	ifcvf_reset_vring(adapter);
+
+	return 0;
+}
+
 static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
 {
 	return IFCVF_QUEUE_MAX;
@@ -435,6 +447,7 @@ static const struct vdpa_config_ops ifc_vdpa_ops = {
 	.set_features	= ifcvf_vdpa_set_features,
 	.get_status	= ifcvf_vdpa_get_status,
 	.set_status	= ifcvf_vdpa_set_status,
+	.reset		= ifcvf_vdpa_reset,
 	.get_vq_num_max	= ifcvf_vdpa_get_vq_num_max,
 	.get_vq_state	= ifcvf_vdpa_get_vq_state,
 	.set_vq_state	= ifcvf_vdpa_set_vq_state,
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 4ba3ac48ee83..608f6b900cd9 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2154,22 +2154,6 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	int err;
 
 	print_status(mvdev, status, true);
-	if (!status) {
-		mlx5_vdpa_info(mvdev, "performing device reset\n");
-		teardown_driver(ndev);
-		clear_vqs_ready(ndev);
-		mlx5_vdpa_destroy_mr(&ndev->mvdev);
-		ndev->mvdev.status = 0;
-		ndev->mvdev.mlx_features = 0;
-		memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
-		ndev->mvdev.actual_features = 0;
-		++mvdev->generation;
-		if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
-			if (mlx5_vdpa_create_mr(mvdev, NULL))
-				mlx5_vdpa_warn(mvdev, "create MR failed\n");
-		}
-		return;
-	}
 
 	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
 		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
@@ -2192,6 +2176,29 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
 }
 
+static int mlx5_vdpa_reset(struct vdpa_device *vdev)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+
+	print_status(mvdev, 0, true);
+	mlx5_vdpa_info(mvdev, "performing device reset\n");
+	teardown_driver(ndev);
+	clear_vqs_ready(ndev);
+	mlx5_vdpa_destroy_mr(&ndev->mvdev);
+	ndev->mvdev.status = 0;
+	ndev->mvdev.mlx_features = 0;
+	memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
+	ndev->mvdev.actual_features = 0;
+	++mvdev->generation;
+	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
+		if (mlx5_vdpa_create_mr(mvdev, NULL))
+			mlx5_vdpa_warn(mvdev, "create MR failed\n");
+	}
+
+	return 0;
+}
+
 static size_t mlx5_vdpa_get_config_size(struct vdpa_device *vdev)
 {
 	return sizeof(struct virtio_net_config);
@@ -2305,6 +2312,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.get_vendor_id = mlx5_vdpa_get_vendor_id,
 	.get_status = mlx5_vdpa_get_status,
 	.set_status = mlx5_vdpa_set_status,
+	.reset = mlx5_vdpa_reset,
 	.get_config_size = mlx5_vdpa_get_config_size,
 	.get_config = mlx5_vdpa_get_config,
 	.set_config = mlx5_vdpa_set_config,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 5b51d0ac8bae..f292bb05d6c9 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -92,7 +92,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
 	vq->vring.notify = NULL;
 }
 
-static void vdpasim_reset(struct vdpasim *vdpasim)
+static void vdpasim_do_reset(struct vdpasim *vdpasim)
 {
 	int i;
 
@@ -460,11 +460,21 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 
 	spin_lock(&vdpasim->lock);
 	vdpasim->status = status;
-	if (status == 0)
-		vdpasim_reset(vdpasim);
 	spin_unlock(&vdpasim->lock);
 }
 
+static int vdpasim_reset(struct vdpa_device *vdpa)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	spin_lock(&vdpasim->lock);
+	vdpasim->status = 0;
+	vdpasim_do_reset(vdpasim);
+	spin_unlock(&vdpasim->lock);
+
+	return 0;
+}
+
 static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -608,6 +618,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.get_vendor_id          = vdpasim_get_vendor_id,
 	.get_status             = vdpasim_get_status,
 	.set_status             = vdpasim_set_status,
+	.reset			= vdpasim_reset,
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
@@ -636,6 +647,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.get_vendor_id          = vdpasim_get_vendor_id,
 	.get_status             = vdpasim_get_status,
 	.set_status             = vdpasim_set_status,
+	.reset			= vdpasim_reset,
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index fe0527329857..cd7718b43a6e 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -189,10 +189,20 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 	}
 
 	vp_modern_set_status(mdev, status);
+}
 
-	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
-	    (s & VIRTIO_CONFIG_S_DRIVER_OK))
+static int vp_vdpa_reset(struct vdpa_device *vdpa)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	u8 s = vp_vdpa_get_status(vdpa);
+
+	vp_modern_set_status(mdev, 0);
+
+	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
 		vp_vdpa_free_irq(vp_vdpa);
+
+	return 0;
 }
 
 static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
@@ -398,6 +408,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.set_features	= vp_vdpa_set_features,
 	.get_status	= vp_vdpa_get_status,
 	.set_status	= vp_vdpa_set_status,
+	.reset		= vp_vdpa_reset,
 	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
 	.get_vq_state	= vp_vdpa_get_vq_state,
 	.get_vq_notification = vp_vdpa_get_vq_notification,
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 9479f7f79217..ab7a24613982 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -157,7 +157,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	u8 status, status_old;
-	int nvqs = v->nvqs;
+	int ret, nvqs = v->nvqs;
 	u16 i;
 
 	if (copy_from_user(&status, statusp, sizeof(status)))
@@ -172,7 +172,12 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 	if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
 		return -EINVAL;
 
-	ops->set_status(vdpa, status);
+	if (status == 0) {
+		ret = ops->reset(vdpa);
+		if (ret)
+			return ret;
+	} else
+		ops->set_status(vdpa, status);
 
 	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
 		for (i = 0; i < nvqs; i++)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 8ae1134070eb..e1eae8c7483d 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -171,6 +171,9 @@ struct vdpa_iova_range {
  * @set_status:			Set the device status
  *				@vdev: vdpa device
  *				@status: virtio device status
+ * @reset:			Reset device
+ *				@vdev: vdpa device
+ *				Returns integer: success (0) or error (< 0)
  * @get_config_size:		Get the size of the configuration space
  *				@vdev: vdpa device
  *				Returns size_t: configuration size
@@ -255,6 +258,7 @@ struct vdpa_config_ops {
 	u32 (*get_vendor_id)(struct vdpa_device *vdev);
 	u8 (*get_status)(struct vdpa_device *vdev);
 	void (*set_status)(struct vdpa_device *vdev, u8 status);
+	int (*reset)(struct vdpa_device *vdev);
 	size_t (*get_config_size)(struct vdpa_device *vdev);
 	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
 			   void *buf, unsigned int len);
@@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 	return vdev->dma_dev;
 }
 
-static inline void vdpa_reset(struct vdpa_device *vdev)
+static inline int vdpa_reset(struct vdpa_device *vdev)
 {
 	const struct vdpa_config_ops *ops = vdev->config;
 
 	vdev->features_valid = false;
-	ops->set_status(vdev, 0);
+	return ops->reset(vdev);
 }
 
 static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
