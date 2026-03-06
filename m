Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5837F72D
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793451; cv=none; b=FC6EnWwlfPxHEHUgMGrxnp67u+HnVsGEp3S4kFX4UQMvwW5LAVCZcBeeYrcRKbHcSL1nI8vlS9KUxfmWpmqHbMQ7vESp3KOjfIVsqJRecdY+kcUWoJLoZFLzR4T7BOS0V0rY47Io70LznF5mvjcO/K5tV/4OFv0aTBqRDliNLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793451; c=relaxed/simple;
	bh=jnEWfPpzZhM9PT5/4IIyDdYQm5qsF5MEa9uiNa9/840=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=YOyEAMcFgSCVj7QTE+Gf7WqGmiw9bPLrll5Y7rQgk40tSMqZ4AE0yT7CJF/iyNK0NJ7d3Zv1JYGHTeGwfA85qbIufqWEIv4571SGlqM95+yipyOehMsCZFBs08gltjoH1q3bvZclYvDuadJmpqird2FBJlQ3Tam+/XqjnnPAro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnZkILcE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnZkILcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772793446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZ1uxUMfdvEVIiXLLllIOCQX5Y7WK3c/GBbiTWtJcUU=;
	b=fnZkILcExJ8pgXy8ARNbW0urQwj3E9hEaq57RfM2MTyLjEAaFrcywR/hBKFSImgDPi+5/B
	B0Pl3qLfJdFslY64p5vuz3Rt0g4eCV+SHoEwrgwS5kjMJVxTA77dUrzVeI/YGT9V7g+Jm4
	enuKaiTYyTVeVAKQ02Ba4K+IL5zu1RE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-AAMy9kKQN4eRmXL4ZNJgAg-1; Fri,
 06 Mar 2026 05:37:22 -0500
X-MC-Unique: AAMy9kKQN4eRmXL4ZNJgAg-1
X-Mimecast-MFC-AGG-ID: AAMy9kKQN4eRmXL4ZNJgAg_1772793440
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43CE718005B9;
	Fri,  6 Mar 2026 10:37:20 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.45.226.103])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E1CA180058B;
	Fri,  6 Mar 2026 10:37:13 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 06 Mar 2026 11:36:33 +0100
Subject: [PATCH v3 2/6] dma-buf: dma-heap: split dma_heap_add
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260306-b4-dmabuf-heap-coherent-rmem-v3-2-3d00d36c9bc4@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772793417; l=6927;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=jnEWfPpzZhM9PT5/4IIyDdYQm5qsF5MEa9uiNa9/840=;
 b=Uq16kJks+H+M48RJxOWpGu8dbWraHuDz9VUhJlh3teNs+cTNDwHXuQtrqIYX0saef7gs9UfOD
 kjuetUfxw/5A+RGtAyaCBo6FmPDtCDuojyos6wX0xUOjdQR0OgL/nth
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: QmNC4J_WF6Xhuo3Dr2_DCj3GOFKY5Q8pg4T7P6TlUIc_1772793440
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Split dma_heap_add() into creation and registration
phases while preserving the ordering between
cdev_add() and device_add(), and ensuring all
device fields are initialised.

This lets callers build a heap and its device,
bind reserved memory, and cleanly unwind on failure
before the heap is registered. It also avoids a window
where userspace can see a heap that exists but isn’t
fully functional. The coherent heap will need this to
bind rmem to the heap device prior to registration.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/dma-buf/dma-heap.c | 126 +++++++++++++++++++++++++++++++++++----------
 include/linux/dma-heap.h   |   3 ++
 2 files changed, 103 insertions(+), 26 deletions(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 1124d63eb1398..ba87e5ac16ae2 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -238,15 +238,30 @@ struct device *dma_heap_get_dev(struct dma_heap *heap)
 }
 EXPORT_SYMBOL_NS_GPL(dma_heap_get_dev, "DMA_BUF_HEAP");
 
+static void dma_heap_dev_release(struct device *dev)
+{
+	struct dma_heap *heap;
+
+	pr_debug("heap device: '%s': %s\n", dev_name(dev), __func__);
+	heap = dev_get_drvdata(dev);
+	kfree(heap->name);
+	kfree(heap);
+	kfree(dev);
+}
+
 /**
- * dma_heap_add - adds a heap to dmabuf heaps
- * @exp_info: information needed to register this heap
+ * dma_heap_create() - allocate and initialize a heap object
+ * @exp_info: information needed to create a heap
+ *
+ * Creates a heap instance but does not register it or create device nodes.
+ * Use dma_heap_register() to make it visible to userspace, or
+ * dma_heap_destroy() to release it.
+ *
+ * Returns a heap on success or ERR_PTR(-errno) on failure.
  */
-struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
+struct dma_heap *dma_heap_create(const struct dma_heap_export_info *exp_info)
 {
-	struct dma_heap *heap, *h, *err_ret;
-	unsigned int minor;
-	int ret;
+	struct dma_heap *heap;
 
 	if (!exp_info->name || !strcmp(exp_info->name, "")) {
 		pr_err("dma_heap: Cannot add heap without a name\n");
@@ -265,13 +280,41 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	heap->name = exp_info->name;
 	heap->ops = exp_info->ops;
 	heap->priv = exp_info->priv;
+	heap->heap_dev = kzalloc_obj(*heap->heap_dev);
+	if (!heap->heap_dev) {
+		kfree(heap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	device_initialize(heap->heap_dev);
+	dev_set_drvdata(heap->heap_dev, heap);
+
+	dev_set_name(heap->heap_dev, heap->name);
+	heap->heap_dev->class = dma_heap_class;
+	heap->heap_dev->release = dma_heap_dev_release;
+
+	return heap;
+}
+EXPORT_SYMBOL_NS_GPL(dma_heap_create, "DMA_BUF_HEAP");
+
+/**
+ * dma_heap_register() - register a heap with the dma-heap framework
+ * @heap: heap instance created with dma_heap_create()
+ *
+ * Registers the heap, creating its device node and adding it to the heap
+ * list. Returns 0 on success or a negative error code on failure.
+ */
+int dma_heap_register(struct dma_heap *heap)
+{
+	struct dma_heap *h;
+	unsigned int minor;
+	int ret;
 
 	/* Find unused minor number */
 	ret = xa_alloc(&dma_heap_minors, &minor, heap,
 		       XA_LIMIT(0, NUM_HEAP_MINORS - 1), GFP_KERNEL);
 	if (ret < 0) {
 		pr_err("dma_heap: Unable to get minor number for heap\n");
-		err_ret = ERR_PTR(ret);
 		goto err0;
 	}
 
@@ -282,42 +325,34 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	ret = cdev_add(&heap->heap_cdev, heap->heap_devt, 1);
 	if (ret < 0) {
 		pr_err("dma_heap: Unable to add char device\n");
-		err_ret = ERR_PTR(ret);
 		goto err1;
 	}
 
-	heap->heap_dev = device_create(dma_heap_class,
-				       NULL,
-				       heap->heap_devt,
-				       NULL,
-				       heap->name);
-	if (IS_ERR(heap->heap_dev)) {
-		pr_err("dma_heap: Unable to create device\n");
-		err_ret = ERR_CAST(heap->heap_dev);
+	heap->heap_dev->devt = heap->heap_devt;
+
+	ret = device_add(heap->heap_dev);
+	if (ret) {
+		pr_err("dma_heap: Unable to add device\n");
 		goto err2;
 	}
 
 	mutex_lock(&heap_list_lock);
 	/* check the name is unique */
 	list_for_each_entry(h, &heap_list, list) {
-		if (!strcmp(h->name, exp_info->name)) {
+		if (!strcmp(h->name, heap->name)) {
 			mutex_unlock(&heap_list_lock);
 			pr_err("dma_heap: Already registered heap named %s\n",
-			       exp_info->name);
-			err_ret = ERR_PTR(-EINVAL);
+			       heap->name);
+			ret = -EINVAL;
 			goto err3;
 		}
 	}
 
-	/* Make sure it doesn't disappear on us */
-	heap->heap_dev = get_device(heap->heap_dev);
-
-
 	/* Add heap to the list */
 	list_add(&heap->list, &heap_list);
 	mutex_unlock(&heap_list_lock);
 
-	return heap;
+	return 0;
 
 err3:
 	device_destroy(dma_heap_class, heap->heap_devt);
@@ -326,8 +361,47 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 err1:
 	xa_erase(&dma_heap_minors, minor);
 err0:
-	kfree(heap);
-	return err_ret;
+	dma_heap_destroy(heap);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(dma_heap_register, "DMA_BUF_HEAP");
+
+/**
+ * dma_heap_destroy() - release a heap created by dma_heap_create()
+ * @heap: heap instance to release
+ *
+ * Drops the heap device reference; the heap and its device are freed in the
+ * device release path when the last reference is gone.
+ */
+void dma_heap_destroy(struct dma_heap *heap)
+{
+	put_device(heap->heap_dev);
+}
+EXPORT_SYMBOL_NS_GPL(dma_heap_destroy, "DMA_BUF_HEAP");
+
+/**
+ * dma_heap_add - adds a heap to dmabuf heaps
+ * @exp_info: information needed to register this heap
+ */
+struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
+{
+	struct dma_heap *heap;
+	int ret;
+
+	heap = dma_heap_create(exp_info);
+	if (IS_ERR(heap)) {
+		pr_err("dma_heap: failed to create heap (%ld)\n", PTR_ERR(heap));
+		return ERR_CAST(heap);
+	}
+
+	ret = dma_heap_register(heap);
+	if (ret) {
+		pr_err("dma_heap: failed to register heap (%d)\n", ret);
+		dma_heap_destroy(heap);
+		return ERR_PTR(ret);
+	}
+
+	return heap;
 }
 EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");
 
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 493085e69b70e..1b0ea43ba66c3 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -46,6 +46,9 @@ void *dma_heap_get_drvdata(struct dma_heap *heap);
 const char *dma_heap_get_name(struct dma_heap *heap);
 struct device *dma_heap_get_dev(struct dma_heap *heap);
 
+struct dma_heap *dma_heap_create(const struct dma_heap_export_info *exp_info);
+int dma_heap_register(struct dma_heap *heap);
+void dma_heap_destroy(struct dma_heap *heap);
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info);
 
 extern bool mem_accounting;

-- 
2.52.0

