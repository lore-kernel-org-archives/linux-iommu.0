Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD57C11F67
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:48:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F236101D
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F236101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7ECE160591;
	Tue, 13 Jul 2021 08:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WsFRWXH9qD7w; Tue, 13 Jul 2021 08:48:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E86106087A;
	Tue, 13 Jul 2021 08:48:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFA23C001A;
	Tue, 13 Jul 2021 08:48:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2C33C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A313C40257
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r3Y4IpRwenvg for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:48:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A28B9400FE
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:48:15 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id l11so11714530pji.5
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y4ufJe1pqoQtqMP3ixyl76pbDy1hGYJP4XFdOY1YVyY=;
 b=WQuU/gG7ZfTNI2qZpsTs3nFbw3nGQz58SeTex5OzuWpcg0kawm2pwWU3SS9wmThtD7
 8SuQKUzHbZdL+eLavT5+YRBAi0zmAoF3t2E3SoNDTO3c4D0gyq5q5vOJ64II6vfAd4aT
 71QQPF9/laUlyzOfQoVzNja3HoTyWs8WAGyHW2tFN9KbReARF+Jsge6Z3XnKKTf4ks8U
 utVVPAsVmo7WGuvvgX6H5ZATzkWQ/yddy7LlXwLGRWxnXXGAB0PPn7iJMOENuO0eZ444
 qQrj04dP1ATna4I3q9+iU/DxS0eJuKeELHTy5OsXbFmUU0q1Ngqw9zUHXdbVI6/h072e
 BWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y4ufJe1pqoQtqMP3ixyl76pbDy1hGYJP4XFdOY1YVyY=;
 b=CbokV/kLrr8BCRx0uiWbPKeCYPN9KeTamHEVT8uenqj8Q8YE2zNQ9mi8KSET9m9sC3
 aR83H7yJfnKqvrqYNnXe4BPb4PuB9NnKKzl9fQus6duG/I55UhHO1uS+EcF5sVHMZh5b
 Ohz3OHANQO78J47vbiwBtfdHZ79LwOAR7SrjZ6K+DapC7suR+GeWCj3eLvRIdEFx8q1i
 XKpnzVYwyNOep/dxCrRG7CTE5U6B5TdWx/rrA64OjRh62DUccnwo4svcOzvsoJmxyL+U
 RZ1DJKqvBhwvibTOYn1LQVKwZJWsrBFnFq30SRb0MCx13rb0c6v7+g5YCiFO88hYRlyo
 6s+w==
X-Gm-Message-State: AOAM53079AukspB7wXbq4hSzbtPfWQcFbsdRYZyb3IQr4Psa1V+35N5M
 zEZSddscMCZAhfamdTukrklV
X-Google-Smtp-Source: ABdhPJwqa943zq1Ntq/jM0YGq1xzB0bh9LWs6ajK6UMzkrpe/h3ODorWGfeeWAcPP8rS7//MZIB7gQ==
X-Received: by 2002:a17:902:b188:b029:11b:1549:da31 with SMTP id
 s8-20020a170902b188b029011b1549da31mr2646108plr.7.1626166095039; 
 Tue, 13 Jul 2021 01:48:15 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id y6sm20418758pgk.79.2021.07.13.01.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 01:48:14 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com
Subject: [PATCH v9 14/17] vdpa: Support transferring virtual addressing during
 DMA mapping
Date: Tue, 13 Jul 2021 16:46:53 +0800
Message-Id: <20210713084656.232-15-xieyongji@bytedance.com>
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

This patch introduces an attribute for vDPA device to indicate
whether virtual address can be used. If vDPA device driver set
it, vhost-vdpa bus driver will not pin user page and transfer
userspace virtual address instead of physical address during
DMA mapping. And corresponding vma->vm_file and offset will be
also passed as an opaque pointer.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c   |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  2 +-
 drivers/vdpa/vdpa.c               |  9 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c  |  2 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c |  2 +-
 drivers/vhost/vdpa.c              | 99 ++++++++++++++++++++++++++++++++++-----
 include/linux/vdpa.h              | 19 ++++++--
 7 files changed, 116 insertions(+), 19 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index b4b89a66607f..fc848aafe5a9 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -492,7 +492,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
-				    dev, &ifc_vdpa_ops, NULL);
+				    dev, &ifc_vdpa_ops, NULL, false);
 	if (adapter == NULL) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
 		return -ENOMEM;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 683452c41a36..79cb2f130bf0 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2035,7 +2035,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
 	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
-				 name);
+				 name, false);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index d77d59811389..41377df674d5 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -71,6 +71,7 @@ static void vdpa_release_dev(struct device *d)
  * @config: the bus operations that is supported by this device
  * @size: size of the parent structure that contains private data
  * @name: name of the vdpa device; optional.
+ * @use_va: indicate whether virtual address must be used by this device
  *
  * Driver should use vdpa_alloc_device() wrapper macro instead of
  * using this directly.
@@ -80,7 +81,8 @@ static void vdpa_release_dev(struct device *d)
  */
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
-					size_t size, const char *name)
+					size_t size, const char *name,
+					bool use_va)
 {
 	struct vdpa_device *vdev;
 	int err = -EINVAL;
@@ -91,6 +93,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	if (!!config->dma_map != !!config->dma_unmap)
 		goto err;
 
+	/* It should only work for the device that use on-chip IOMMU */
+	if (use_va && !(config->dma_map || config->set_map))
+		goto err;
+
 	err = -ENOMEM;
 	vdev = kzalloc(size, GFP_KERNEL);
 	if (!vdev)
@@ -106,6 +112,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	vdev->index = err;
 	vdev->config = config;
 	vdev->features_valid = false;
+	vdev->use_va = use_va;
 
 	if (name)
 		err = dev_set_name(&vdev->dev, "%s", name);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index f456f4baf86d..472d573d755c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -250,7 +250,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 		ops = &vdpasim_config_ops;
 
 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
-				    dev_attr->name);
+				    dev_attr->name, false);
 	if (!vdpasim)
 		goto err_alloc;
 
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index ee723c645aec..c828b9f9d92a 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -435,7 +435,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 
 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
-				    dev, &vp_vdpa_ops, NULL);
+				    dev, &vp_vdpa_ops, NULL, false);
 	if (vp_vdpa == NULL) {
 		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
 		return -ENOMEM;
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 3e260038beba..0db701fa935f 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -533,8 +533,28 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, u64 start, u64 last)
 	}
 }
 
+static void vhost_vdpa_va_unmap(struct vhost_vdpa *v, u64 start, u64 last)
+{
+	struct vhost_dev *dev = &v->vdev;
+	struct vhost_iotlb *iotlb = dev->iotlb;
+	struct vhost_iotlb_map *map;
+	struct vdpa_map_file *map_file;
+
+	while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
+		map_file = (struct vdpa_map_file *)map->opaque;
+		fput(map_file->file);
+		kfree(map_file);
+		vhost_iotlb_map_free(iotlb, map);
+	}
+}
+
 static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v, u64 start, u64 last)
 {
+	struct vdpa_device *vdpa = v->vdpa;
+
+	if (vdpa->use_va)
+		return vhost_vdpa_va_unmap(v, start, last);
+
 	return vhost_vdpa_pa_unmap(v, start, last);
 }
 
@@ -569,21 +589,21 @@ static int perm_to_iommu_flags(u32 perm)
 	return flags | IOMMU_CACHE;
 }
 
-static int vhost_vdpa_map(struct vhost_vdpa *v,
-			  u64 iova, u64 size, u64 pa, u32 perm)
+static int vhost_vdpa_map(struct vhost_vdpa *v, u64 iova,
+			  u64 size, u64 pa, u32 perm, void *opaque)
 {
 	struct vhost_dev *dev = &v->vdev;
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	int r = 0;
 
-	r = vhost_iotlb_add_range(dev->iotlb, iova, iova + size - 1,
-				  pa, perm);
+	r = vhost_iotlb_add_range_ctx(dev->iotlb, iova, iova + size - 1,
+				      pa, perm, opaque);
 	if (r)
 		return r;
 
 	if (ops->dma_map) {
-		r = ops->dma_map(vdpa, iova, size, pa, perm, NULL);
+		r = ops->dma_map(vdpa, iova, size, pa, perm, opaque);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, dev->iotlb);
@@ -591,13 +611,15 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 		r = iommu_map(v->domain, iova, pa, size,
 			      perm_to_iommu_flags(perm));
 	}
-
-	if (r)
+	if (r) {
 		vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
-	else
+		return r;
+	}
+
+	if (!vdpa->use_va)
 		atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
 
-	return r;
+	return 0;
 }
 
 static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
@@ -618,6 +640,56 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
 	}
 }
 
+static int vhost_vdpa_va_map(struct vhost_vdpa *v,
+			     u64 iova, u64 size, u64 uaddr, u32 perm)
+{
+	struct vhost_dev *dev = &v->vdev;
+	u64 offset, map_size, map_iova = iova;
+	struct vdpa_map_file *map_file;
+	struct vm_area_struct *vma;
+	int ret;
+
+	mmap_read_lock(dev->mm);
+
+	while (size) {
+		vma = find_vma(dev->mm, uaddr);
+		if (!vma) {
+			ret = -EINVAL;
+			break;
+		}
+		map_size = min(size, vma->vm_end - uaddr);
+		if (!(vma->vm_file && (vma->vm_flags & VM_SHARED) &&
+			!(vma->vm_flags & (VM_IO | VM_PFNMAP))))
+			goto next;
+
+		map_file = kzalloc(sizeof(*map_file), GFP_KERNEL);
+		if (!map_file) {
+			ret = -ENOMEM;
+			break;
+		}
+		offset = (vma->vm_pgoff << PAGE_SHIFT) + uaddr - vma->vm_start;
+		map_file->offset = offset;
+		map_file->file = get_file(vma->vm_file);
+		ret = vhost_vdpa_map(v, map_iova, map_size, uaddr,
+				     perm, map_file);
+		if (ret) {
+			fput(map_file->file);
+			kfree(map_file);
+			break;
+		}
+next:
+		size -= map_size;
+		uaddr += map_size;
+		map_iova += map_size;
+	}
+	if (ret)
+		vhost_vdpa_unmap(v, iova, map_iova - iova);
+
+	mmap_read_unlock(dev->mm);
+
+	return ret;
+}
+
 static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			     u64 iova, u64 size, u64 uaddr, u32 perm)
 {
@@ -684,7 +756,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
 				ret = vhost_vdpa_map(v, iova, csize,
 						     map_pfn << PAGE_SHIFT,
-						     perm);
+						     perm, NULL);
 				if (ret) {
 					/*
 					 * Unpin the pages that are left unmapped
@@ -713,7 +785,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 	/* Pin the rest chunk */
 	ret = vhost_vdpa_map(v, iova, (last_pfn - map_pfn + 1) << PAGE_SHIFT,
-			     map_pfn << PAGE_SHIFT, perm);
+			     map_pfn << PAGE_SHIFT, perm, NULL);
 out:
 	if (ret) {
 		if (nchunks) {
@@ -746,6 +818,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 					   struct vhost_iotlb_msg *msg)
 {
 	struct vhost_dev *dev = &v->vdev;
+	struct vdpa_device *vdpa = v->vdpa;
 	struct vhost_iotlb *iotlb = dev->iotlb;
 
 	if (msg->iova < v->range.first ||
@@ -756,6 +829,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 				    msg->iova + msg->size - 1))
 		return -EEXIST;
 
+	if (vdpa->use_va)
+		return vhost_vdpa_va_map(v, msg->iova, msg->size,
+					 msg->uaddr, msg->perm);
+
 	return vhost_vdpa_pa_map(v, msg->iova, msg->size, msg->uaddr,
 				 msg->perm);
 }
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 4903e67c690b..b605ce09a5bd 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -66,6 +66,7 @@ struct vdpa_mgmt_dev;
  * @config: the configuration ops for this device.
  * @index: device index
  * @features_valid: were features initialized? for legacy guests
+ * @use_va: indicate whether virtual address must be used by this device
  * @nvqs: maximum number of supported virtqueues
  * @mdev: management device pointer; caller must setup when registering device as part
  *	  of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
@@ -76,6 +77,7 @@ struct vdpa_device {
 	const struct vdpa_config_ops *config;
 	unsigned int index;
 	bool features_valid;
+	bool use_va;
 	int nvqs;
 	struct vdpa_mgmt_dev *mdev;
 };
@@ -91,6 +93,16 @@ struct vdpa_iova_range {
 };
 
 /**
+ * Corresponding file area for device memory mapping
+ * @file: vma->vm_file for the mapping
+ * @offset: mapping offset in the vm_file
+ */
+struct vdpa_map_file {
+	struct file *file;
+	u64 offset;
+};
+
+/**
  * struct vdpa_config_ops - operations for configuring a vDPA device.
  * Note: vDPA device drivers are required to implement all of the
  * operations unless it is mentioned to be optional in the following
@@ -277,14 +289,15 @@ struct vdpa_config_ops {
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
-					size_t size, const char *name);
+					size_t size, const char *name,
+					bool use_va);
 
-#define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
+#define vdpa_alloc_device(dev_struct, member, parent, config, name, use_va)   \
 			  container_of(__vdpa_alloc_device( \
 				       parent, config, \
 				       sizeof(dev_struct) + \
 				       BUILD_BUG_ON_ZERO(offsetof( \
-				       dev_struct, member)), name), \
+				       dev_struct, member)), name, use_va), \
 				       dev_struct, member)
 
 int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
