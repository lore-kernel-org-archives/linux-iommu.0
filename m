Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FE347502
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541280; cv=none; b=J1N0D65CjZHsaQCMVkGvem8npY3gvvJLmXNTYBlIk8YxK6UFQX7jPH7fbryrSZkChDobWMD3NN/SDaQKqlu5PFf7yD4egCbg9bMjir1aA3IGzZzUA0zmBwYmwmiLy/TE2QNf+8mKd2WViyHgO22ZUaWTfwSMRJFyhSuVZUJ7M/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541280; c=relaxed/simple;
	bh=Oiyav+nKn59PGwnJ/kuaw2S3AHX/9+uyerzkejMZoD4=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=ZkRnwuOFgoHdITA3UmxnN2NrfbJy+Fl3qRkCTgD9NAIL7IHqTRjpDpEPV5icR8AOq8Tgo6ef8fyxLyCfuvnE8nem1Fk5uY0/zjroLMw86ICe87eF5a2wMFz1tEspo1VNYB4uGhhF5LpPziIT1jo1v1kM8N6kSzugW2P2AWhzjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZalmtWO7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZalmtWO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772541277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Eja0IKLWM7TXMINx19h4PVbisMkWsGrNkIdZK4d0xk=;
	b=ZalmtWO70PhE/tok8fIcWjTJyVCw48Z7ckbH3u0XzmaxmGkwYZir6+YNr/Bn0pNyWqyMER
	ieUJ+cSQBgQd5hETQI15Q2hzU7Xyw5iJzaLDKhKFfUo37b35gyXZxqcieNCvluT6NfPsBB
	oPkUcl7GyMczl7UiBYN/t1HGgBZW5ps=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-P4LtvZmcMl2bsCgGydgWWQ-1; Tue,
 03 Mar 2026 07:34:32 -0500
X-MC-Unique: P4LtvZmcMl2bsCgGydgWWQ-1
X-Mimecast-MFC-AGG-ID: P4LtvZmcMl2bsCgGydgWWQ_1772541270
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 847961800365;
	Tue,  3 Mar 2026 12:34:30 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.44.32.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0A7330001B9;
	Tue,  3 Mar 2026 12:34:24 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 03 Mar 2026 13:33:46 +0100
Subject: [PATCH v2 3/6] of_reserved_mem: add a helper for rmem device_init
 op
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260303-b4-dmabuf-heap-coherent-rmem-v2-3-65a4653b3378@redhat.com>
References: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
In-Reply-To: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
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
 Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772541243; l=3269;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=Oiyav+nKn59PGwnJ/kuaw2S3AHX/9+uyerzkejMZoD4=;
 b=i3wbq5E4k9VfhS9W3iaMgYMRMa0WY56H+E6aqqEhiNhouFoq+Q7bGPoRNT8RSld0ItGC3n+Mo
 VBn/S9AJdEHB91d8iZ3E61e216OnDtU3RjkvsWWVtnZ0J+Hin44U7YH
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: py7su5usY7qp_mEVIXlvDOV5BDiYa1C15OrbeM8avKU_1772541270
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a helper function wrapping internal reserved memory
device_init call and expose it externally.

Use the new helper function within of_reserved_mem_device_init_by_idx().

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/of/of_reserved_mem.c    | 27 +++++++++++++++++++++++----
 include/linux/of_reserved_mem.h |  8 ++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1fd28f8056108..3a350bef8f11e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -605,6 +605,28 @@ struct rmem_assigned_device {
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
+	if (!dev || !rmem || !rmem->ops || !rmem->ops->device_init)
+		return -EINVAL;
+
+	return rmem->ops->device_init(rmem, dev);
+}
+EXPORT_SYMBOL_GPL(of_reserved_mem_device_init_with_mem);
+
 /**
  * of_reserved_mem_device_init_by_idx() - assign reserved memory region to
  *					  given device
@@ -643,14 +665,11 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 	rmem = of_reserved_mem_lookup(target);
 	of_node_put(target);
 
-	if (!rmem || !rmem->ops || !rmem->ops->device_init)
-		return -EINVAL;
-
 	rd = kmalloc_obj(struct rmem_assigned_device);
 	if (!rd)
 		return -ENOMEM;
 
-	ret = rmem->ops->device_init(rmem, dev);
+	ret = of_reserved_mem_device_init_with_mem(dev, rmem);
 	if (ret == 0) {
 		rd->dev = dev;
 		rd->rmem = rmem;
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

