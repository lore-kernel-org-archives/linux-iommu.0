Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B421AC432BE
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 10:37:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B714601FD
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 10:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B714601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4DE5340496;
	Tue, 31 Aug 2021 10:37:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3SWlRmkfCPZ9; Tue, 31 Aug 2021 10:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E1AFE4048D;
	Tue, 31 Aug 2021 10:37:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B444BC001A;
	Tue, 31 Aug 2021 10:37:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71386C000E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52A12823DD
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lK6CrKR1IbFB for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 10:37:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5004E82419
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:40 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id c6so1239686pjv.1
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=03Nd7u7okYdu6gFT64ik5NaZ4PZ8j5m+esOMp2eCUlA=;
 b=EFplu0Nv5ZvVC7+F6A4FAox8fzDvjooAOVa4CHdZHqn8LeHH7KuNYZOwQ7HbExBaRI
 Hi74HKwwJXl7DAp0gNwzUG5IX0dbVTCWTxZG/izY/1CzGtuQo7MvDxr6oztleO2z4COy
 hciuMHDRC3D4s58A6bs7kpPAZ1/Lr5qrHuxG/W8ZOuxeaz7im7kmTmVDwT3faeHrFJmD
 k0o1QYatwqi1RtqbZvlitzWQSWAdTj5JXuB4C41Aw18FKZhqnahYgElsypr0Scs77ThM
 kX0zcSSRIUipSPL/thkps0n/Yyv+xqBVCficA70kFh/g0YyT5ysTZ0AymT/KW7JT28Ci
 37GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=03Nd7u7okYdu6gFT64ik5NaZ4PZ8j5m+esOMp2eCUlA=;
 b=bqowBNJpowtbpjzspERb05omums7ix/NwByElBX6btd7OoCz4Z7cdb32/cR59hgUgl
 QiOZYey/uX83ofTkRzrd/a7ep0ON8PbBkoDn4EeiDCP9tCsgRP/1ktjfn9lSPhKu5D3r
 QVMHQfzfubBzUifaAvgfEgEDxpytAAon0/72U0a68Ug5SnuDgevdr43eWM06OvBYWOoG
 /YLZYe08rUsSKVWh8iYDR6jlNp0vSlei1vRwjUbc0thYrinmkeOqrVThac46GJ0gwXR6
 TdL3WDPNi1hb5E7tRlA/qrrJlnoqSBqFI0362IZeVr1JrXRHWl24/dqQ9BTi348iKWs/
 DPJQ==
X-Gm-Message-State: AOAM533CO7w2LNYgdqMvHTe30R4MiV/7EAfLkCCAmjyw/PSKpTDR7kGA
 q6UJvujVHORp0jK6iEnjsNvw
X-Google-Smtp-Source: ABdhPJySEijLsBATU5VtgDOxkvIujEDgS/kjkjZUXgzX7bM/ioNbDcShciw0Xjb9ZaDp4pnhRewwBA==
X-Received: by 2002:a17:902:7202:b029:12c:dc6b:928f with SMTP id
 ba2-20020a1709027202b029012cdc6b928fmr4068412plb.55.1630406259582; 
 Tue, 31 Aug 2021 03:37:39 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id h20sm17985717pfn.173.2021.08.31.03.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 03:37:39 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
Subject: [PATCH v13 10/13] vdpa: Support transferring virtual addressing
 during DMA mapping
Date: Tue, 31 Aug 2021 18:36:31 +0800
Message-Id: <20210831103634.33-11-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831103634.33-1-xieyongji@bytedance.com>
References: <20210831103634.33-1-xieyongji@bytedance.com>
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
 include/linux/vdpa.h              | 20 ++++++--
 7 files changed, 117 insertions(+), 19 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 4293481ce910..dcd648e1f7e7 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -515,7 +515,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
 	pdev = ifcvf_mgmt_dev->pdev;
 	dev = &pdev->dev;
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
-				    dev, &ifc_vdpa_ops, name);
+				    dev, &ifc_vdpa_ops, name, false);
 	if (IS_ERR(adapter)) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
 		return PTR_ERR(adapter);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 608f6b900cd9..08f39952fa6a 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2425,7 +2425,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
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
index a70fd2a08ff1..5f484fff8dbe 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -251,7 +251,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 		ops = &vdpasim_config_ops;
 
 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
-				    dev_attr->name);
+				    dev_attr->name, false);
 	if (IS_ERR(vdpasim)) {
 		ret = PTR_ERR(vdpasim);
 		goto err_alloc;
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index cd7718b43a6e..5bcd00246d2e 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -446,7 +446,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 
 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
-				    dev, &vp_vdpa_ops, NULL);
+				    dev, &vp_vdpa_ops, NULL, false);
 	if (IS_ERR(vp_vdpa)) {
 		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
 		return PTR_ERR(vp_vdpa);
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 49a1f45ccef8..e7b75f49f668 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -526,8 +526,28 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, u64 start, u64 last)
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
 
@@ -562,21 +582,21 @@ static int perm_to_iommu_flags(u32 perm)
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
@@ -584,13 +604,15 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
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
@@ -611,6 +633,56 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
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
@@ -677,7 +749,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
 				ret = vhost_vdpa_map(v, iova, csize,
 						     map_pfn << PAGE_SHIFT,
-						     perm);
+						     perm, NULL);
 				if (ret) {
 					/*
 					 * Unpin the pages that are left unmapped
@@ -706,7 +778,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 	/* Pin the rest chunk */
 	ret = vhost_vdpa_map(v, iova, (last_pfn - map_pfn + 1) << PAGE_SHIFT,
-			     map_pfn << PAGE_SHIFT, perm);
+			     map_pfn << PAGE_SHIFT, perm, NULL);
 out:
 	if (ret) {
 		if (nchunks) {
@@ -739,6 +811,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 					   struct vhost_iotlb_msg *msg)
 {
 	struct vhost_dev *dev = &v->vdev;
+	struct vdpa_device *vdpa = v->vdpa;
 	struct vhost_iotlb *iotlb = dev->iotlb;
 
 	if (msg->iova < v->range.first || !msg->size ||
@@ -750,6 +823,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
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
index f3014aaca47e..3972ab765de1 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -65,6 +65,7 @@ struct vdpa_mgmt_dev;
  * @config: the configuration ops for this device.
  * @index: device index
  * @features_valid: were features initialized? for legacy guests
+ * @use_va: indicate whether virtual address must be used by this device
  * @nvqs: maximum number of supported virtqueues
  * @mdev: management device pointer; caller must setup when registering device as part
  *	  of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
@@ -75,6 +76,7 @@ struct vdpa_device {
 	const struct vdpa_config_ops *config;
 	unsigned int index;
 	bool features_valid;
+	bool use_va;
 	int nvqs;
 	struct vdpa_mgmt_dev *mdev;
 };
@@ -90,6 +92,16 @@ struct vdpa_iova_range {
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
@@ -279,7 +291,8 @@ struct vdpa_config_ops {
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
-					size_t size, const char *name);
+					size_t size, const char *name,
+					bool use_va);
 
 /**
  * vdpa_alloc_device - allocate and initilaize a vDPA device
@@ -289,15 +302,16 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
  * @parent: the parent device
  * @config: the bus operations that is supported by this device
  * @name: name of the vdpa device
+ * @use_va: indicate whether virtual address must be used by this device
  *
  * Return allocated data structure or ERR_PTR upon error
  */
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
