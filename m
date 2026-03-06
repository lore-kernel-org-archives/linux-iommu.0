Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FDA35B14B
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793441; cv=none; b=XBjoJnMrxAaPG3IjmR97iT9Wp+DBSZcbmRZmoHo1wzoL42pFkw04acfzIge1t8nl2GdtpieEnAS6AAOvcd67tdFWuAlgo31PaIL2B0TVsA3TRbapjIul9JgERng7z6ffM4dn3flOohXQavQQPKD6gX2I9qqLNZhEsCx+1NBukX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793441; c=relaxed/simple;
	bh=jEcsosu4FVff7wQTzKWFyuvhOs9GdLa7SAJlZveaz5I=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=EPRqmhC+WkF2qebgrJSJsJhL5OVQxPezXBF3MuA3Wwkecxl/MGAWevoXDEM1U6A1XtTIPBJD/pGJ7Jsd4GXNtU/WmW/GArSSBfWe9O9PEeFoJ2mZZPcJ/HIKYukaDPnVYpfPX48wOpAO06r4z8FD+HGP2bWvUev2fsKoklC9MIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBlLtmZt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBlLtmZt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772793439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJYSzg9vNyDy8YIRC70niUvoXuiagt/nl4vhegwZQ4I=;
	b=OBlLtmZtPgDmUvzNKWNvGxfGgrGLYXNoE5ZZKWHyJPYsw6I4EU1W+M+09vOZQ8UwfDbho5
	NGRaPahw2ZGjWGlOFfeRw+a4ZEogLJAc/DvYqSNxEwDyzup1RPdqiWcZHWhI/TVekVNRG6
	iarrWn3vsZqQlX+SA08DH9YSSCnMTA0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-ylLWy7D1MiK14lBlXpaTbg-1; Fri,
 06 Mar 2026 05:37:15 -0500
X-MC-Unique: ylLWy7D1MiK14lBlXpaTbg-1
X-Mimecast-MFC-AGG-ID: ylLWy7D1MiK14lBlXpaTbg_1772793433
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D891E1800344;
	Fri,  6 Mar 2026 10:37:12 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.45.226.103])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 033FE1800576;
	Fri,  6 Mar 2026 10:37:05 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 06 Mar 2026 11:36:32 +0100
Subject: [PATCH v3 1/6] dma-buf: dma-heap: Keep track of the heap device
 struct
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260306-b4-dmabuf-heap-coherent-rmem-v3-1-3d00d36c9bc4@redhat.com>
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
 Albert Esteve <aesteve@redhat.com>, mripard@redhat.com, echanude@redhat.com, 
 John Stultz <john.stultz@linaro.org>, Maxime Ripard <mripard@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772793417; l=3407;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=+cQjQX7wWYHly3CqYJA61GMkvrlvlEzfu2d2CAj6odw=;
 b=En+VXoYTUj9Wv8NJOCjiJ2RfNcXww6oL8TirckFIGLBYTejfT3hcTJrdgb6B6KgRDqrUo0tN9
 FelEna3sZ9ZD6c7cS4dja3evP5ZoiN/f//EuT4Ak6aRC+21Ljf0dHsJ
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: TMN5PSCXfioe6XhjVr5djWmHUT0u_D58xnl8y7f-Myw_1772793433
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: John Stultz <john.stultz@linaro.org>

Keep track of the heap device struct.

This will be useful for special DMA allocations
and actions.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/dma-buf/dma-heap.c | 34 ++++++++++++++++++++++++++--------
 include/linux/dma-heap.h   |  2 ++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index ac5f8685a6494..1124d63eb1398 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -31,6 +31,7 @@
  * @heap_devt:		heap device node
  * @list:		list head connecting to list of heaps
  * @heap_cdev:		heap char device
+ * @heap_dev:		heap device
  *
  * Represents a heap of memory from which buffers can be made.
  */
@@ -41,6 +42,7 @@ struct dma_heap {
 	dev_t heap_devt;
 	struct list_head list;
 	struct cdev heap_cdev;
+	struct device *heap_dev;
 };
 
 static LIST_HEAD(heap_list);
@@ -223,6 +225,19 @@ const char *dma_heap_get_name(struct dma_heap *heap)
 }
 EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
 
+/**
+ * dma_heap_get_dev() - get device struct for the heap
+ * @heap: DMA-Heap to retrieve device struct from
+ *
+ * Returns:
+ * The device struct for the heap.
+ */
+struct device *dma_heap_get_dev(struct dma_heap *heap)
+{
+	return heap->heap_dev;
+}
+EXPORT_SYMBOL_NS_GPL(dma_heap_get_dev, "DMA_BUF_HEAP");
+
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
  * @exp_info: information needed to register this heap
@@ -230,7 +245,6 @@ EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 {
 	struct dma_heap *heap, *h, *err_ret;
-	struct device *dev_ret;
 	unsigned int minor;
 	int ret;
 
@@ -272,14 +286,14 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 		goto err1;
 	}
 
-	dev_ret = device_create(dma_heap_class,
-				NULL,
-				heap->heap_devt,
-				NULL,
-				heap->name);
-	if (IS_ERR(dev_ret)) {
+	heap->heap_dev = device_create(dma_heap_class,
+				       NULL,
+				       heap->heap_devt,
+				       NULL,
+				       heap->name);
+	if (IS_ERR(heap->heap_dev)) {
 		pr_err("dma_heap: Unable to create device\n");
-		err_ret = ERR_CAST(dev_ret);
+		err_ret = ERR_CAST(heap->heap_dev);
 		goto err2;
 	}
 
@@ -295,6 +309,10 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 		}
 	}
 
+	/* Make sure it doesn't disappear on us */
+	heap->heap_dev = get_device(heap->heap_dev);
+
+
 	/* Add heap to the list */
 	list_add(&heap->list, &heap_list);
 	mutex_unlock(&heap_list_lock);
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 648328a64b27e..493085e69b70e 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 
 struct dma_heap;
+struct device;
 
 /**
  * struct dma_heap_ops - ops to operate on a given heap
@@ -43,6 +44,7 @@ struct dma_heap_export_info {
 void *dma_heap_get_drvdata(struct dma_heap *heap);
 
 const char *dma_heap_get_name(struct dma_heap *heap);
+struct device *dma_heap_get_dev(struct dma_heap *heap);
 
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info);
 

-- 
2.52.0

