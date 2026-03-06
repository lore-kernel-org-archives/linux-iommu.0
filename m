Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD336309A
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793455; cv=none; b=mRIcY4+GTsrkl+KhbBEsPV5PPQMEY3ct1QwHKPAkocsX18m4q14hVyH/tqakBEKpdIJd5wrYC8VR6Iv4qJzQ9apeRLTi9JYaPTdiNxlu0qeaqyaF4aiftSrIIpPcl/hgHdygD+tVuF29HiQ3LqX4yHjhKAfYwOsqxRYRxoOe70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793455; c=relaxed/simple;
	bh=rgrqri/qil5mD0TqCg7stpgdjtBE6SE/MHI+utJVZN0=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=f0jYOcPywbjo5fFtGXuGOQN1hihuLBVeRyooT8vqLPVRqx/YYR70UXRxxf7+OKWx2X3sp/lQKVCo9o8g5NNTaGIsXiKeYkhMpjHa/ToJrxBKwBXTTisp0BztZEMx6sN5xoPfYv5QBVKfakPX88VvnS6Qwxi/aqJzBDL54kA05EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDD7Nisy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDD7Nisy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772793453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suRtAZrxz3OO0NlvM3Q3uQcnaecb9vHR4v4iJlgEyR8=;
	b=MDD7Nisy1KTDco5tnhHjF7zOmmpGSiCgd/w8koOdKTJK2mp3aiXBvMlWkHj+hB9AzTtrvD
	GpU2sUG21MQXTbHlza9LmwwIA2+x+MgYVR2Tjh3buGYZGOZ4LCem62CKGtXdgwQzIgzLRS
	vnxHGJSfNCtIJQgJQhb6LrCTzIdYoo8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-xTjywzMWNs6YmfKnZZPkig-1; Fri,
 06 Mar 2026 05:37:29 -0500
X-MC-Unique: xTjywzMWNs6YmfKnZZPkig-1
X-Mimecast-MFC-AGG-ID: xTjywzMWNs6YmfKnZZPkig_1772793447
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B23F51956095;
	Fri,  6 Mar 2026 10:37:26 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.45.226.103])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D16FF1800576;
	Fri,  6 Mar 2026 10:37:20 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 06 Mar 2026 11:36:34 +0100
Subject: [PATCH v3 3/6] of_reserved_mem: add a helper for rmem device_init
 op
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260306-b4-dmabuf-heap-coherent-rmem-v3-3-3d00d36c9bc4@redhat.com>
References: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
In-Reply-To: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@redhat.com, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772793417; l=4434;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=rgrqri/qil5mD0TqCg7stpgdjtBE6SE/MHI+utJVZN0=;
 b=/9NHwRWbwX4ljPKtYhgTcPVxYkxoBoVNNBgLyQk3ultqrgYvfZaohRku503CZAnxdi2GQrCDJ
 nuJ5HYgcUNyDgdH+gO0uk9X4NPANrQnY0hXLw41OgZNS7WS/AMYTTyJ
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: zxiQG5fcZKHQUOjbsU7f8jdrmKKkZv0B5v5yCTlPgxk_1772793447
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a helper function wrapping internal reserved memory
device_init call and expose it externally.

Use the new helper function within of_reserved_mem_device_init_by_idx().

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/of/of_reserved_mem.c    | 68 ++++++++++++++++++++++++++---------------
 include/linux/of_reserved_mem.h |  8 +++++
 2 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1fd28f8056108..26ca871f7f919 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -605,6 +605,49 @@ struct rmem_assigned_device {
 static LIST_HEAD(of_rmem_assigned_device_list);
 static DEFINE_MUTEX(of_rmem_assigned_device_mutex);
 
+/**
+ * of_reserved_mem_device_init_with_mem() - assign reserved memory region to
+ *					    given device
+ * @dev:	Pointer to the device to configure
+ * @rmem:	Reserved memory region to assign
+ *
+ * This function assigns respective DMA-mapping operations based on the
+ * reserved memory region already provided in @rmem to the @dev device,
+ * without walking DT nodes.
+ *
+ * Returns error code or zero on success.
+ */
+int of_reserved_mem_device_init_with_mem(struct device *dev,
+					 struct reserved_mem *rmem)
+{
+	struct rmem_assigned_device *rd;
+	int ret;
+
+	if (!dev || !rmem || !rmem->ops || !rmem->ops->device_init)
+		return -EINVAL;
+
+	rd = kmalloc_obj(struct rmem_assigned_device);
+	if (!rd)
+		return -ENOMEM;
+
+	ret = rmem->ops->device_init(rmem, dev);
+	if (ret == 0) {
+		rd->dev = dev;
+		rd->rmem = rmem;
+
+		mutex_lock(&of_rmem_assigned_device_mutex);
+		list_add(&rd->list, &of_rmem_assigned_device_list);
+		mutex_unlock(&of_rmem_assigned_device_mutex);
+
+		dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
+	} else {
+		kfree(rd);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_reserved_mem_device_init_with_mem);
+
 /**
  * of_reserved_mem_device_init_by_idx() - assign reserved memory region to
  *					  given device
@@ -623,10 +666,8 @@ static DEFINE_MUTEX(of_rmem_assigned_device_mutex);
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx)
 {
-	struct rmem_assigned_device *rd;
 	struct device_node *target;
 	struct reserved_mem *rmem;
-	int ret;
 
 	if (!np || !dev)
 		return -EINVAL;
@@ -643,28 +684,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 	rmem = of_reserved_mem_lookup(target);
 	of_node_put(target);
 
-	if (!rmem || !rmem->ops || !rmem->ops->device_init)
-		return -EINVAL;
-
-	rd = kmalloc_obj(struct rmem_assigned_device);
-	if (!rd)
-		return -ENOMEM;
-
-	ret = rmem->ops->device_init(rmem, dev);
-	if (ret == 0) {
-		rd->dev = dev;
-		rd->rmem = rmem;
-
-		mutex_lock(&of_rmem_assigned_device_mutex);
-		list_add(&rd->list, &of_rmem_assigned_device_list);
-		mutex_unlock(&of_rmem_assigned_device_mutex);
-
-		dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
-	} else {
-		kfree(rd);
-	}
-
-	return ret;
+	return of_reserved_mem_device_init_with_mem(dev, rmem);
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_device_init_by_idx);
 
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index f573423359f48..12f7ddb7ee61f 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -32,6 +32,8 @@ typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
 #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
 	_OF_DECLARE(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
+int of_reserved_mem_device_init_with_mem(struct device *dev,
+					 struct reserved_mem *rmem);
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx);
 int of_reserved_mem_device_init_by_name(struct device *dev,
@@ -51,6 +53,12 @@ int of_reserved_mem_region_count(const struct device_node *np);
 #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
 	_OF_DECLARE_STUB(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
+static inline int of_reserved_mem_device_init_with_mem(struct device *dev,
+						       struct reserved_mem *rmem)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
 					struct device_node *np, int idx)
 {

-- 
2.52.0

