Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D08C433B4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3CE610C9
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3CE610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0635A4049D;
	Mon, 17 May 2021 10:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RDdnPmUeqE7i; Mon, 17 May 2021 10:02:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4F17B404D5;
	Mon, 17 May 2021 10:02:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44A6CC0023;
	Mon, 17 May 2021 10:02:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72DE7C0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D92EA4031D
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VtTj1bKIzv98 for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:56:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6FD14033C
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:32 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id f22so3334683pgb.9
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MiTzCoiARAPRNIQZKCdAoWpd+Y7xHLWKPx88X9tHUnM=;
 b=NnzXAfPY0YhOdrb/igGoB82JqscE+d2Pa+2xgOq6FRozhr0VDXEsa/3R74UDV6qDvL
 NmWOpid02s3aFySNIvclYDSpLeKDjHgaCX/LJ6sMXMaTFTz06M3BaWnjOE9I++fEcP1y
 7ZLQGtdYTX8mBaV8cSWlkro8L4Y/uvBMSPP10SwPstjxEOyqFJKNvNcapjroMEH3O1Si
 6lt2UFFNfVbH4kB4sJZzqaEcfIa8ixz0Mmthcl4Xp1OQKEIwZTY7ZAGkoiH5eZ4CulFp
 VjRJPXlxdg/OOy8wvVNAsw8U7mDvQRd8+2IlusVlsRX8U8YgIgGIjk4uY6gOGSBkBD+S
 iddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MiTzCoiARAPRNIQZKCdAoWpd+Y7xHLWKPx88X9tHUnM=;
 b=g+YV6nWDIV1dowfUGvWaNp0jznSGYuT0rOJ5qLVdaPrquhXyApwDy9OyOQeU09SLRF
 p89bGzjdjn0Vl+PVjvsbYFYHVTMFlW9QQHR2pDeuQ4FkAxTby0yt94K+RyruSjdrcbLU
 C0U9Bmh47ehGUucVn48o0jGJGv36KNLYV8MPEF8+hE4fPRyknjU9wxpPocP/iwF85exO
 jAxc1Knmmk/yRR+kuQNLssHbucNPAq3cFQsENKs8CLkCvxcEcN5maGwnce2CNFiUuXNx
 QRpHcEy95m8jOZ1hS5108M7I97ZZOvNdlOOW5z/XcPbFz1sxOLs3Tdio+9l4DIG7SAFq
 43jA==
X-Gm-Message-State: AOAM530OLklf3WUV7waK777u2wQEjwMd2UL0y7IAPTQCOHLRdKjX9BnY
 rU5noKzVW16p6qgPOvgzlysc
X-Google-Smtp-Source: ABdhPJwf/8KiAxmByhb3YRcFhmW7d2PIrOWfRucWh3OaV4e7GnS1UqxdzBy3y1vT4AYJtTbTW+MF1g==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr57052108pgc.45.1621245392180; 
 Mon, 17 May 2021 02:56:32 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id jz7sm1414768pjb.32.2021.05.17.02.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 02:56:31 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
Subject: [PATCH v7 09/12] vdpa: Support transferring virtual addressing during
 DMA mapping
Date: Mon, 17 May 2021 17:55:10 +0800
Message-Id: <20210517095513.850-10-xieyongji@bytedance.com>
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
index ab0ab5cf0f6e..daf9746e51e6 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -476,7 +476,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
-				    dev, &ifc_vdpa_ops, NULL);
+				    dev, &ifc_vdpa_ops, NULL, false);
 	if (adapter == NULL) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
 		return -ENOMEM;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 189e4385df40..8a4cb999152b 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2005,7 +2005,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
 	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
-				 name);
+				 name, false);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index bb3f1d1f0422..8f01d6a7ecc5 100644
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
index efd0cb3d964d..a43479cf57ea 100644
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
index c76ebb531212..f907f42e83bb 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -399,7 +399,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 
 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
-				    dev, &vp_vdpa_ops, NULL);
+				    dev, &vp_vdpa_ops, NULL, false);
 	if (vp_vdpa == NULL) {
 		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
 		return -ENOMEM;
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 3c773654bf40..20a0a9f32331 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -520,8 +520,28 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, u64 start, u64 last)
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
 
@@ -556,21 +576,21 @@ static int perm_to_iommu_flags(u32 perm)
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
@@ -578,13 +598,15 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
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
@@ -605,6 +627,56 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
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
@@ -671,7 +743,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
 				ret = vhost_vdpa_map(v, iova, csize,
 						     map_pfn << PAGE_SHIFT,
-						     perm);
+						     perm, NULL);
 				if (ret) {
 					/*
 					 * Unpin the pages that are left unmapped
@@ -700,7 +772,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 	/* Pin the rest chunk */
 	ret = vhost_vdpa_map(v, iova, (last_pfn - map_pfn + 1) << PAGE_SHIFT,
-			     map_pfn << PAGE_SHIFT, perm);
+			     map_pfn << PAGE_SHIFT, perm, NULL);
 out:
 	if (ret) {
 		if (nchunks) {
@@ -733,6 +805,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 					   struct vhost_iotlb_msg *msg)
 {
 	struct vhost_dev *dev = &v->vdev;
+	struct vdpa_device *vdpa = v->vdpa;
 	struct vhost_iotlb *iotlb = dev->iotlb;
 
 	if (msg->iova < v->range.first ||
@@ -743,6 +816,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
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
index 281f768cb597..85124d197c55 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -44,6 +44,7 @@ struct vdpa_mgmt_dev;
  * @config: the configuration ops for this device.
  * @index: device index
  * @features_valid: were features initialized? for legacy guests
+ * @use_va: indicate whether virtual address must be used by this device
  * @nvqs: maximum number of supported virtqueues
  * @mdev: management device pointer; caller must setup when registering device as part
  *	  of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
@@ -54,6 +55,7 @@ struct vdpa_device {
 	const struct vdpa_config_ops *config;
 	unsigned int index;
 	bool features_valid;
+	bool use_va;
 	int nvqs;
 	struct vdpa_mgmt_dev *mdev;
 };
@@ -69,6 +71,16 @@ struct vdpa_iova_range {
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
@@ -254,14 +266,15 @@ struct vdpa_config_ops {
 
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
